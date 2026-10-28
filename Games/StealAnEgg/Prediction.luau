local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local function RequireGameModule(...)
	local pathSegments = { ... }
	local callOk, loadedModule = pcall(function()
		local currentInstance = ReplicatedStorage
		for _, segmentName in ipairs(pathSegments) do
			currentInstance = currentInstance
				and (currentInstance:FindFirstChild(segmentName) or currentInstance:WaitForChild(segmentName, 3))
		end
		return currentInstance and require(currentInstance) or nil
	end)
	if callOk and type(loadedModule) == "table" then
		return loadedModule
	end
	return nil
end

local EggStateModule = RequireGameModule("Client", "EggState")
local EggRecordsModule = RequireGameModule("Shared", "Util", "EggRecords")
local AssetsModule = RequireGameModule("Data", "Assets")
local MutationsModule = RequireGameModule("Shared", "Modules", "Mutations")

local Prediction = {
	SortOptions = { "Value", "Rarity", "Time Left" },
	FilterOptions = { "All", "Ready", "Growing", "In Bag" },
	SortMode = "Value",
	FilterMode = "All",
	Entries = {},
	VisibleLabels = {},
	Signature = "",
	SelectedLabel = nil,
	Groupbox = nil,
	Card = nil,
	List = nil,
	NextRefreshAt = 0,
}

local GRADIENT_STOPS = { "#FF6B6B", "#FFB36B", "#FFF06B", "#6BFF8A", "#6BC8FF", "#B96BFF" }
local MONEY_FROM, MONEY_TO = "#6BFF8A", "#3ED2FF"
local WEIGHT_FROM, WEIGHT_TO = "#FFE07A", "#FF9D4D"
local TIME_FROM, TIME_TO = "#8FE3FF", "#B96BFF"
local LABEL_SEPARATOR = "  •  "

local function EscapeRichText(text)
	return ((tostring(text):gsub("&", "&amp;")):gsub("<", "&lt;")):gsub(">", "&gt;")
end

local function Paint(hexColor, text)
	return string.format('<font color="%s">%s</font>', hexColor, text)
end

local function Bold(text)
	return "<b>" .. text .. "</b>"
end

local function LerpHex(fromHex, toHex, alpha)
	local fromR, fromG, fromB = string.match(fromHex, "^#?(%x%x)(%x%x)(%x%x)$")
	local toR, toG, toB = string.match(toHex, "^#?(%x%x)(%x%x)(%x%x)$")
	if not (fromR and toR) then
		return fromHex
	end
	local function mix(fromValue, toValue)
		local fromChannel, toChannel = tonumber(fromValue, 16), tonumber(toValue, 16)
		return math.floor(fromChannel + (toChannel - fromChannel) * alpha + 0.5)
	end
	return string.format("#%02X%02X%02X", mix(fromR, toR), mix(fromG, toG), mix(fromB, toB))
end

local function Gradient(text, fromHex, toHex)
	text = tostring(text)
	local length = #text
	if length == 0 then
		return ""
	end
	local parts = table.create(length)
	for index = 1, length do
		local character = string.sub(text, index, index)
		if character == " " then
			parts[index] = character
		else
			local alpha = length > 1 and (index - 1) / (length - 1) or 0
			parts[index] = Paint(LerpHex(fromHex, toHex, alpha), EscapeRichText(character))
		end
	end
	return Bold(table.concat(parts))
end

local function RainbowWord(text)
	text = EscapeRichText(text)
	local parts = table.create(#text)
	for index = 1, #text do
		parts[index] = Paint(GRADIENT_STOPS[(index - 1) % #GRADIENT_STOPS + 1], string.sub(text, index, index))
	end
	return Bold(table.concat(parts))
end

local function FormatRate(value)
	local amount = math.max(0, math.floor(tonumber(value) or 0))
	if amount >= 1000000000 then
		return string.format("%.2fB/s", amount / 1000000000)
	elseif amount >= 1000000 then
		return string.format("%.2fM/s", amount / 1000000)
	elseif amount >= 1000 then
		return string.format("%.1fK/s", amount / 1000)
	end
	return string.format("%d/s", amount)
end

local function FormatWeight(value)
	local numberValue = tonumber(value) or 0
	local integerText = string.format("%d", math.floor(numberValue))
	local grouped = integerText:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	return grouped .. " Kg"
end

local function FormatClock(totalSeconds)
	local seconds = math.max(0, math.floor(tonumber(totalSeconds) or 0))
	return string.format("%02dh %02dm %02ds", seconds // 3600, (seconds % 3600) // 60, seconds % 60)
end

local function ScaleFactor(scaleValue)
	if scaleValue > 5 then
		return (scaleValue / 5) ^ 1.2 * 19.637875755794113
	end
	return scaleValue ^ 1.85
end

local function ReadMutationMultiplier(mutations)
	if type(MutationsModule) == "table" and type(MutationsModule.EarningsFor) == "function" then
		local callOk, multiplier = pcall(MutationsModule.EarningsFor, type(mutations) == "table" and mutations or {})
		if callOk and type(multiplier) == "number" then
			return multiplier
		end
	end
	return 1
end

local function ReadAssetInfo(assetCategory)
	if type(AssetsModule) ~= "table" or type(AssetsModule.Directory) ~= "table" then
		return nil
	end
	local assetInfo = AssetsModule.Directory[tostring(assetCategory)]
	if type(assetInfo) ~= "table" then
		return nil
	end
	local rarityInfo = type(assetInfo.Rarity) == "table" and assetInfo.Rarity or {}
	local eggInfo = type(assetInfo.Egg) == "table" and assetInfo.Egg or {}
	return {
		Name = tostring(assetInfo.DisplayName or assetCategory),
		Rarity = tostring(rarityInfo.DisplayName or rarityInfo._id or "Common"),
		RarityRank = tonumber(rarityInfo.RarityNumber or rarityInfo.Rank) or 0,
		RarityColor = typeof(rarityInfo.Color) == "Color3" and rarityInfo.Color or nil,
		EarningRate = tonumber(assetInfo.EarningRate) or 0,
		Icon = tostring(rarityInfo.Icon or eggInfo.Icon or assetInfo.Icon or ""),
	}
end

local function ReadEggIcon(eggData, fallbackIcon)
	if type(EggRecordsModule) == "table" and type(EggRecordsModule.EggIcon) == "function" then
		local callOk, icon = pcall(EggRecordsModule.EggIcon, eggData)
		if callOk and type(icon) == "string" and icon ~= "" then
			return icon
		end
	end
	return fallbackIcon
end

local function ReadGrowthState(eggKey, eggData, serverNow)
	if eggData.Placement == nil then
		return "In Bag", math.huge, 0
	end
	if type(EggStateModule) == "table" and type(EggStateModule.IsReadyToHatch) == "function" then
		local callOk, readyToHatch = pcall(EggStateModule.IsReadyToHatch, eggKey)
		if callOk and readyToHatch then
			return "Ready", 0, 100
		end
	end
	local growthSpeed = 1
	if type(EggRecordsModule) == "table" and type(EggRecordsModule.GrowthSpeedMultiplier) == "function" then
		local callOk, multiplier = pcall(EggRecordsModule.GrowthSpeedMultiplier, eggData)
		if callOk and type(multiplier) == "number" then
			growthSpeed = multiplier
		end
	end
	local remainingSeconds, durationSeconds = 0, 0
	if type(EggRecordsModule) == "table" and type(EggRecordsModule.GrowthSecondsRemaining) == "function" then
		local callOk, remaining = pcall(EggRecordsModule.GrowthSecondsRemaining, eggData, serverNow, growthSpeed)
		if callOk and type(remaining) == "number" then
			remainingSeconds = remaining
		end
	end
	if type(EggRecordsModule) == "table" and type(EggRecordsModule.GrowthDuration) == "function" then
		local callOk, duration = pcall(EggRecordsModule.GrowthDuration, eggData)
		if callOk and type(duration) == "number" then
			durationSeconds = duration
		end
	end
	local percent = 0
	if durationSeconds > 0 then
		percent = math.clamp(math.floor((1 - remainingSeconds / durationSeconds) * 100 + 0.5), 0, 100)
	end
	return "Growing", remainingSeconds, percent
end

local function ReadEntries()
	if type(EggStateModule) ~= "table" or type(EggStateModule.ReadOwnerEggs) ~= "function" then
		return {}
	end
	local callOk, ownerEggs = pcall(EggStateModule.ReadOwnerEggs, LocalPlayer.UserId)
	if not callOk or type(ownerEggs) ~= "table" then
		return {}
	end
	local serverNow = Workspace:GetServerTimeNow()
	local entries = {}
	for eggKey, eggData in pairs(ownerEggs) do
		if type(eggData) == "table" then
			local assetInfo = ReadAssetInfo(eggData.AssetCategory)
			local scaleValue = tonumber(eggData.AssetScale) or 0
			local weightKg = 0
			if type(EggRecordsModule) == "table" and type(EggRecordsModule.WeightKg) == "function" then
				local weightOk, weightValue = pcall(EggRecordsModule.WeightKg, eggData)
				if weightOk and type(weightValue) == "number" then
					weightKg = weightValue
				end
			end
			local status, remainingSeconds, percent = ReadGrowthState(eggKey, eggData, serverNow)
			local earningRate = assetInfo and assetInfo.EarningRate or 0
			local income = 0
			if earningRate > 0 and scaleValue > 0 then
				income = math.max(1, math.floor(earningRate * ScaleFactor(scaleValue) * ReadMutationMultiplier(eggData.Mutations) + 0.5))
			end
			table.insert(entries, {
				Id = tostring(eggKey),
				Name = assetInfo and assetInfo.Name or tostring(eggData.AssetCategory or "Egg"),
				Rarity = assetInfo and assetInfo.Rarity or "Common",
				RarityRank = assetInfo and assetInfo.RarityRank or 0,
				RarityColor = assetInfo and assetInfo.RarityColor or nil,
				Icon = ReadEggIcon(eggData, assetInfo and assetInfo.Icon or ""),
				Status = status,
				Remaining = remainingSeconds,
				Percent = percent,
				Scale = scaleValue,
				Weight = weightKg,
				Income = income,
			})
		end
	end
	return entries
end

local function IsVisible(entry)
	local filter = Prediction.FilterMode
	if filter == "All" then
		return true
	end
	if filter == "In Bag" then
		return entry.Status == "In Bag"
	end
	return entry.Status == filter
end

local function SortEntries(entries)
	local sortMode = Prediction.SortMode
	table.sort(entries, function(left, right)
		if sortMode == "Rarity" then
			if left.RarityRank ~= right.RarityRank then
				return left.RarityRank > right.RarityRank
			end
			return left.Income > right.Income
		elseif sortMode == "Time Left" then
			if left.Remaining ~= right.Remaining then
				return left.Remaining < right.Remaining
			end
			return left.Income > right.Income
		end
		if left.Income ~= right.Income then
			return left.Income > right.Income
		end
		return left.RarityRank > right.RarityRank
	end)
	return entries
end

local function StatusText(entry)
	if entry.Status == "Ready" then
		return "Ready"
	elseif entry.Status == "Growing" then
		return "Growing " .. FormatClock(entry.Remaining)
	end
	return "In Bag"
end

local function BuildLabel(entry, index)
	return string.format("%02d  %s  ·  %s", index, entry.Name, StatusText(entry))
end

local function BuildCardMeta(entry)
	local pieces = {
		Gradient(FormatRate(entry.Income), MONEY_FROM, MONEY_TO),
		Paint("#C9A6FF", EscapeRichText(entry.Rarity)),
		Gradient(FormatWeight(entry.Weight), WEIGHT_FROM, WEIGHT_TO),
	}
	if entry.Status == "Growing" then
		table.insert(pieces, Gradient(FormatClock(entry.Remaining) .. "  " .. entry.Percent .. "%", TIME_FROM, TIME_TO))
	elseif entry.Status == "Ready" then
		table.insert(pieces, RainbowWord("READY"))
	else
		table.insert(pieces, Paint("#9FB4C7", "In Bag"))
	end
	return table.concat(pieces, LABEL_SEPARATOR)
end

local function UpdateCard(entry)
	local card = Prediction.Card
	if not card or card.Destroyed then
		return
	end
	if not entry then
		card:SetFields({ Name = "No egg", Rarity = "", Mutation = "", Rate = "", Meta = "Waiting for your eggs..." })
		return
	end
	card:SetData(entry.Name, BuildCardMeta(entry), entry.Icon, nil)
	card:SetFields({
		Name = entry.Name,
		Rarity = entry.Rarity,
		RarityColor = entry.RarityColor,
		Mutation = "",
		Rate = FormatRate(entry.Income),
		Meta = BuildCardMeta(entry),
	})
end

local function FindEntryByLabel(label)
	for _, entry in ipairs(Prediction.Entries) do
		if Prediction.VisibleLabels[entry.Id] == label then
			return entry
		end
	end
	return nil
end

local function ReadVisibleEntries(entries)
	local visible = {}
	for _, entry in ipairs(entries) do
		if IsVisible(entry) then
			table.insert(visible, entry)
		end
	end
	return visible
end

local function RenderList(entries)
	local labels, images = {}, {}
	Prediction.VisibleLabels = {}
	for index, entry in ipairs(entries) do
		local label = BuildLabel(entry, index)
		Prediction.VisibleLabels[entry.Id] = label
		table.insert(labels, label)
		if entry.Icon ~= "" then
			images[label] = entry.Icon
		end
	end

	local list = Prediction.List
	if not list then
		return
	end
	list:SetValues(labels)
	list:SetValueImages(images)
	if Prediction.SelectedLabel then
		list:SetValue(Prediction.SelectedLabel)
	end
end

local function RefreshCard(entries)
	local selected = Prediction.SelectedLabel and FindEntryByLabel(Prediction.SelectedLabel) or nil
	if not selected then
		selected = entries[1]
	end
	if selected then
		Prediction.SelectedLabel = Prediction.VisibleLabels[selected.Id] or Prediction.SelectedLabel
	end
	UpdateCard(selected)
end

local function BuildSignature(entries)
	local statusCount = { Ready = 0, Growing = 0, ["In Bag"] = 0 }
	for _, entry in ipairs(entries) do
		statusCount[entry.Status] = (statusCount[entry.Status] or 0) + 1
	end
	return string.format(
		"%s|%s|%d|%d|%d|%d",
		Prediction.SortMode,
		Prediction.FilterMode,
		#entries,
		statusCount.Ready,
		statusCount.Growing,
		statusCount["In Bag"]
	)
end

function Prediction.SetSortMode(mode)
	if table.find(Prediction.SortOptions, mode) then
		Prediction.SortMode = mode
		Prediction.Signature = ""
	end
end

function Prediction.SetFilterMode(mode)
	if table.find(Prediction.FilterOptions, mode) then
		Prediction.FilterMode = mode
		Prediction.Signature = ""
	end
end

function Prediction.SetCardVisible(visible)
	if Prediction.Card and Prediction.Card.Frame then
		Prediction.Card.Frame.Visible = visible == true
		if Prediction.Groupbox then
			Prediction.Groupbox:Resize()
		end
	end
end

function Prediction.Build(groupbox)
	Prediction.Groupbox = groupbox

	local sortDropdown = groupbox:AddDropdown("Dropdown_Predictor_Sort", {
		Text = "Sort By",
		Values = Prediction.SortOptions,
		Default = Prediction.SortMode,
		Tooltip = "Order of the egg list",
		Callback = function(selectedMode)
			Prediction.SetSortMode(selectedMode)
		end,
	})

	groupbox:AddToggle("Toggle_Predictor_PreviewCard", {
		Text = "Show Preview Card",
		Default = true,
		Tooltip = "Shows the spotlight card of the selected egg",
		Callback = function(isEnabled)
			Prediction.SetCardVisible(isEnabled)
		end,
	})

	Prediction.Card = groupbox:AddSpotlightCard("Card_Predictor_Egg", {
		Height = 110,
		Title = "Egg Predictor",
		Description = "Waiting for your eggs...",
		Image = "",
	})

	groupbox:AddDropdown("Dropdown_Predictor_Filter", {
		Text = "Egg Status",
		Values = Prediction.FilterOptions,
		Default = Prediction.FilterMode,
		Tooltip = "Only show eggs in this state",
		Callback = function(selectedFilter)
			Prediction.SetFilterMode(selectedFilter)
		end,
	})

	Prediction.List = groupbox:AddDropdown("Dropdown_Predictor_Eggs", {
		Text = "Egg List",
		Values = {},
		ValueImages = {},
		Tooltip = "Pick an egg to preview it",
		Callback = function(selectedLabel)
			Prediction.SelectedLabel = selectedLabel
			UpdateCard(FindEntryByLabel(selectedLabel))
		end,
	})

	sortDropdown:SetValue(Prediction.SortMode)
	Prediction.Signature = ""
	Prediction.NextRefreshAt = 0

	Prediction.Connection = RunService.Heartbeat:Connect(function()
		local now = os.clock()
		if now < Prediction.NextRefreshAt then
			return
		end
		Prediction.NextRefreshAt = now + 1

		local entries = ReadVisibleEntries(SortEntries(ReadEntries()))
		Prediction.Entries = entries

		local signature = BuildSignature(entries)
		if signature ~= Prediction.Signature then
			Prediction.Signature = signature
			RenderList(entries)
		end
		RefreshCard(entries)
	end)
end

function Prediction.Stop()
	if Prediction.Connection then
		Prediction.Connection:Disconnect()
		Prediction.Connection = nil
	end
end

return Prediction
