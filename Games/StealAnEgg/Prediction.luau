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
	SelectedId = nil,
	Signature = "",
	Cards = {},
	Groupbox = nil,
	Card = nil,
	NextRefreshAt = 0,
}

local COLORS = {
	Text = Color3.fromRGB(255, 255, 255),
	Income = Color3.fromRGB(77, 255, 122),
	Clock = Color3.fromRGB(255, 194, 77),
	Ready = Color3.fromRGB(77, 255, 122),
	Growing = Color3.fromRGB(255, 194, 77),
	Inventory = Color3.fromRGB(127, 216, 255),
	Weight = Color3.fromRGB(205, 231, 255),
	CardBackground = Color3.fromRGB(18, 19, 27),
	ProgressTrack = Color3.fromRGB(12, 13, 19),
}

local CARD_HEIGHT = 96
local CARD_PADDING = 6
local ART_SIZE = 84
local CARD_TILE_ASSET = "rbxassetid://90325592797235"
local FALLBACK_RARITY_COLOR = Color3.fromRGB(255, 255, 255)

local function New(className, properties, children)
	local instance = Instance.new(className)
	for key, value in pairs(properties or {}) do
		instance[key] = value
	end
	for _, child in ipairs(children or {}) do
		child.Parent = instance
	end
	return instance
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
	local integerText = string.format("%d", math.floor(tonumber(value) or 0))
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

local rarityGradientsFolder = nil
local function ReadRarityGradient(rarityId)
	if rarityGradientsFolder == nil then
		local assetsFolder = ReplicatedStorage:FindFirstChild("Assets")
		local uiFolder = assetsFolder and assetsFolder:FindFirstChild("UI")
		rarityGradientsFolder = (uiFolder and uiFolder:FindFirstChild("RarityGradients")) or false
	end
	if not rarityGradientsFolder then
		return nil
	end
	local rarityModel = rarityGradientsFolder:FindFirstChild(tostring(rarityId))
	local gradient = rarityModel and rarityModel:FindFirstChild("RarityGradient")
	if gradient and gradient:IsA("UIGradient") then
		return gradient
	end
	return nil
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
	local rarityId = tostring(rarityInfo._id or rarityInfo.DisplayName or "Common")
	return {
		Name = tostring(assetInfo.DisplayName or assetCategory),
		RarityId = rarityId,
		Rarity = tostring(rarityInfo.DisplayName or rarityId),
		RarityRank = tonumber(rarityInfo.RarityNumber or rarityInfo.Rank) or 0,
		RarityColor = typeof(rarityInfo.Color) == "Color3" and rarityInfo.Color or FALLBACK_RARITY_COLOR,
		Gradient = ReadRarityGradient(rarityId),
		EarningRate = tonumber(assetInfo.EarningRate) or 0,
		Icon = tostring(eggInfo.Icon or assetInfo.Icon or ""),
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
				RarityColor = assetInfo and assetInfo.RarityColor or FALLBACK_RARITY_COLOR,
				Gradient = assetInfo and assetInfo.Gradient or nil,
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
	elseif filter == "In Bag" then
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

local function StatusColor(entry)
	if entry.Status == "Ready" then
		return COLORS.Ready
	elseif entry.Status == "Growing" then
		return COLORS.Growing
	end
	return COLORS.Inventory
end

local function StatusText(entry)
	if entry.Status == "Ready" then
		return "Ready to hatch", 100
	elseif entry.Status == "Growing" then
		return FormatClock(entry.Remaining), entry.Percent
	end
	return "In bag", 0
end

local function ApplyGradient(label, entry)
	local gradient = entry.Gradient
	if gradient then
		New("UIGradient", {
			Color = gradient.Color,
			Rotation = gradient.Rotation,
			Transparency = gradient.Transparency,
			Parent = label,
		})
		label.TextColor3 = COLORS.Text
	else
		label.TextColor3 = entry.RarityColor
	end
end

local function UpdatePreviewCard(entry)
	local card = Prediction.Card
	if not card or card.Destroyed then
		return
	end
	if not entry then
		card:SetFields({ Name = "No egg", Rarity = "", Mutation = "", Rate = "", Meta = "Waiting for your eggs..." })
		return
	end
	local statusText, percent = StatusText(entry)
	card:SetData(entry.Name, string.format("%s  %d%%", statusText, percent), entry.Icon, nil)
	card:SetFields({
		Name = entry.Name,
		Rarity = entry.Rarity,
		RarityColor = entry.RarityColor,
		Mutation = "",
		Rate = FormatRate(entry.Income),
		Meta = string.format("%s   %s   %s", FormatRate(entry.Income), FormatWeight(entry.Weight), statusText),
	})
end

local function CreateCard(parent, entry, layoutOrder)
	local card = New("Frame", {
		BackgroundColor3 = COLORS.CardBackground,
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		LayoutOrder = 100 + layoutOrder,
		Size = UDim2.new(1, 0, 0, CARD_HEIGHT),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 8) }),
	})

	local stroke = New("UIStroke", {
		Color = entry.RarityColor,
		Thickness = 1,
		Transparency = 0.35,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = card,
	})

	local art = New("Frame", {
		BackgroundColor3 = entry.RarityColor,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(CARD_PADDING, CARD_PADDING),
		Size = UDim2.fromOffset(ART_SIZE, ART_SIZE),
		ClipsDescendants = true,
		Parent = card,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 6) }),
		New("ImageLabel", {
			BackgroundTransparency = 1,
			Image = CARD_TILE_ASSET,
			ImageColor3 = entry.RarityColor,
			ImageTransparency = 0.82,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
		}),
		New("ImageLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.52),
			Size = UDim2.fromScale(0.92, 0.92),
			Image = entry.Icon,
			ScaleType = Enum.ScaleType.Fit,
		}),
	})

	if entry.Gradient then
		New("UIGradient", {
			Color = entry.Gradient.Color,
			Rotation = entry.Gradient.Rotation,
			Parent = art,
		})
	end

	local textLeft = CARD_PADDING + ART_SIZE + 10
	local textWidth = UDim.new(1, -(textLeft + 8))

	local nameLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(textLeft, 8),
		Size = UDim2.new(textWidth.Scale, textWidth.Offset, 0, 16),
		Font = Enum.Font.GothamBold,
		Text = entry.Name,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = card,
	})
	ApplyGradient(nameLabel, entry)

	New("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -8, 0, 8),
		Size = UDim2.fromOffset(84, 16),
		Font = Enum.Font.GothamBold,
		Text = entry.Rarity,
		TextColor3 = entry.RarityColor,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = card,
	})

	New("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(textLeft, 28),
		Size = UDim2.new(textWidth.Scale, textWidth.Offset, 0, 15),
		Font = Enum.Font.GothamBold,
		Text = FormatRate(entry.Income),
		TextColor3 = COLORS.Income,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = card,
	})

	local statusText, percent = StatusText(entry)
	New("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(textLeft, 45),
		Size = UDim2.new(textWidth.Scale, textWidth.Offset, 0, 14),
		Font = Enum.Font.Gotham,
		Text = string.format("%s  ·  %s", FormatWeight(entry.Weight), statusText),
		TextColor3 = entry.Status == "In Bag" and COLORS.Inventory or COLORS.Weight,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = card,
	})

	local track = New("Frame", {
		BackgroundColor3 = COLORS.ProgressTrack,
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(textLeft, 66),
		Size = UDim2.new(textWidth.Scale, textWidth.Offset, 0, 14),
		Parent = card,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 4) }),
	})

	local fill = New("Frame", {
		BackgroundColor3 = StatusColor(entry),
		BorderSizePixel = 0,
		Size = UDim2.fromScale(math.clamp(percent / 100, 0, 1), 1),
		Parent = track,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 4) }),
	})

	if entry.Gradient then
		New("UIGradient", {
			Color = entry.Gradient.Color,
			Rotation = entry.Gradient.Rotation,
			Parent = fill,
		})
	end

	if entry.Status == "In Bag" then
		fill.Visible = false
	end

	New("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Font = Enum.Font.GothamBold,
		Text = entry.Status == "In Bag" and "IN BAG" or string.format("%d%%", percent),
		TextColor3 = COLORS.Text,
		TextSize = 10,
		TextTransparency = 0.15,
		Parent = track,
	})

	local button = New("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		Parent = card,
	})

	button.MouseButton1Click:Connect(function()
		Prediction.SelectedId = entry.Id
		UpdatePreviewCard(entry)
		for cardId, cardStroke in pairs(Prediction.Cards) do
			cardStroke.Transparency = cardId == entry.Id and 0 or 0.35
		end
	end)

	return card, stroke
end

local function ClearCards()
	for _, child in ipairs(Prediction.Groupbox.Container:GetChildren()) do
		if child:GetAttribute("PredictorCard") then
			child:Destroy()
		end
	end
	Prediction.Cards = {}
end

local function RenderCards(entries)
	ClearCards()
	local container = Prediction.Groupbox.Container
	for index, entry in ipairs(entries) do
		local card, stroke = CreateCard(container, entry, index)
		card:SetAttribute("PredictorCard", true)
		Prediction.Cards[entry.Id] = stroke
		if Prediction.SelectedId == entry.Id then
			stroke.Transparency = 0
		end
	end
	Prediction.Groupbox:Resize()
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

	groupbox:AddDropdown("Dropdown_Predictor_Sort", {
		Text = "Sort By",
		Values = Prediction.SortOptions,
		Default = Prediction.SortMode,
		Tooltip = "Order of the egg cards",
		Callback = function(selectedMode)
			Prediction.SetSortMode(selectedMode)
		end,
	})

	groupbox:AddToggle("Toggle_Predictor_PreviewCard", {
		Text = "Show Preview Card",
		Default = true,
		Tooltip = "Shows the big card of the selected egg",
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

	Prediction.Signature = ""
	Prediction.NextRefreshAt = 0

	Prediction.Connection = RunService.Heartbeat:Connect(function()
		local now = os.clock()
		if now < Prediction.NextRefreshAt then
			return
		end
		Prediction.NextRefreshAt = now + 1

		local visible = {}
		for _, entry in ipairs(SortEntries(ReadEntries())) do
			if IsVisible(entry) then
				table.insert(visible, entry)
			end
		end
		Prediction.Entries = visible

		local signature = BuildSignature(visible)
		if signature ~= Prediction.Signature then
			Prediction.Signature = signature
			if not Prediction.SelectedId or not Prediction.Cards[Prediction.SelectedId] then
				Prediction.SelectedId = visible[1] and visible[1].Id or nil
			end
			RenderCards(visible)
		end

		local selectedId = Prediction.SelectedId
		if selectedId and Prediction.Cards[selectedId] then
			for _, entry in ipairs(visible) do
				if entry.Id == selectedId then
					UpdatePreviewCard(entry)
					break
				end
			end
		else
			UpdatePreviewCard(visible[1])
		end
	end)
end

function Prediction.Stop()
	if Prediction.Connection then
		Prediction.Connection:Disconnect()
		Prediction.Connection = nil
	end
end

return Prediction
