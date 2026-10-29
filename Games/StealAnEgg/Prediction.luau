local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")

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
local SaveModule = RequireGameModule("Shared", "Save")
local FuseKernelModule = RequireGameModule("Shared", "Util", "FuseKernel")
local BalanceModule = RequireGameModule("Shared", "Flags", "GameplayBalance")
local EggStateModule = RequireGameModule("Client", "EggState")
local AreasModule = RequireGameModule("Data", "Areas")

local Prediction = {
	SortOptions = { "Value", "Rarity", "Time Left" },
	FilterOptions = { "All", "Ready", "Growing", "In Bag" },
	SortMode = "Value",
	FilterMode = "All",
	Entries = {},
	SelectedId = nil,
	Signature = "",
	Cards = {},
	Filters = {},
	Counts = {},
	Groupbox = nil,
	Preview = nil,
	ListFrame = nil,
	Grid = nil,
	CardWidth = 0,
	PreviewWidth = 0,
	PreviewVisible = true,
	Hero = nil,
	ListColumn = nil,
	Hooks = nil,
	NextRefreshAt = 0,
	RaysAngle = 0,
	LastFrameAt = 0,
}

local COLORS = {
	Text = Color3.fromRGB(255, 255, 255),
	Card = Color3.fromRGB(18, 18, 26),
	Border = Color3.fromRGB(62, 64, 84),
	Subtext = Color3.fromRGB(214, 218, 236),
	Track = Color3.fromRGB(8, 8, 12),
	Select = Color3.fromRGB(255, 214, 90),
	IncomeTop = Color3.fromRGB(170, 255, 140),
	IncomeBottom = Color3.fromRGB(40, 230, 90),
	ScaleTop = Color3.fromRGB(255, 244, 190),
	ScaleBottom = Color3.fromRGB(255, 196, 60),
	WeightTop = Color3.fromRGB(235, 250, 255),
	WeightBottom = Color3.fromRGB(110, 200, 255),
	Ready = { Color3.fromRGB(170, 255, 150), Color3.fromRGB(30, 205, 85) },
	Growing = { Color3.fromRGB(255, 225, 120), Color3.fromRGB(255, 130, 40) },
	InBag = { Color3.fromRGB(160, 225, 255), Color3.fromRGB(60, 140, 255) },
	TileTint = Color3.fromRGB(40, 40, 60),
	ShadowTint = Color3.fromRGB(20, 18, 34),
	Hint = Color3.fromRGB(159, 184, 255),
	Separator = Color3.fromRGB(122, 140, 192),
	Clock = Color3.fromRGB(255, 194, 77),
}

local FILTERS = {
	{ Key = "All", Title = "ALL", Colors = { Color3.fromRGB(255, 255, 255), Color3.fromRGB(176, 188, 220) } },
	{ Key = "Ready", Title = "READY", Colors = { Color3.fromRGB(170, 255, 150), Color3.fromRGB(40, 220, 90) } },
	{ Key = "Growing", Title = "GROWING", Colors = { Color3.fromRGB(255, 232, 150), Color3.fromRGB(255, 150, 40) } },
	{ Key = "In Bag", Title = "IN BAG", Colors = { Color3.fromRGB(180, 232, 255), Color3.fromRGB(70, 160, 255) } },
}

local CARD_TILE_ASSET = "rbxassetid://90325592797235"
local PREVIEW_RAYS_ASSET = "rbxassetid://109516122757226"
local PREVIEW_SHADOW_ASSET = "rbxassetid://10822615828"
local HERO_HEIGHT = 338
local HERO_GAP = 8
local HERO_FILTER_HEIGHT = 20
local HERO_MIN_WIDTH = 208
local HERO_MAX_WIDTH = 252
local PREVIEW_ART_HEIGHT = 148
local MUTATION_STACK_LIMIT = 3
local GRID_GAP = 8
local FALLBACK_RARITY_COLOR = Color3.fromRGB(255, 255, 255)

local ETERNAL_SEQUENCE = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(196, 222, 255)),
	ColorSequenceKeypoint.new(0.45, Color3.fromRGB(246, 242, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 180, 255)),
})

local SECRET_SEQUENCE = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 243, 250)),
	ColorSequenceKeypoint.new(0.3, Color3.fromRGB(120, 128, 146)),
	ColorSequenceKeypoint.new(0.52, Color3.fromRGB(30, 32, 42)),
	ColorSequenceKeypoint.new(0.74, Color3.fromRGB(110, 118, 136)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(248, 250, 255)),
})

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

local function LoadFontFace(assetPath, weight)
	local callOk, fontFace = pcall(Font.new, assetPath, weight, Enum.FontStyle.Normal)
	return callOk and fontFace or nil
end

local DISPLAY_FONT = LoadFontFace("rbxassetid://12187365977", Enum.FontWeight.Bold)
	or LoadFontFace("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular)

local function UseDisplayFont(label)
	if DISPLAY_FONT then
		label.FontFace = DISPLAY_FONT
	else
		label.Font = Enum.Font.GothamBold
	end
end

local function CreateLabel(parent, properties)
	local label = New("TextLabel", {
		BackgroundTransparency = 1,
		Text = "",
		TextColor3 = COLORS.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = parent,
	})
	for key, value in pairs(properties or {}) do
		label[key] = value
	end
	UseDisplayFont(label)
	return label
end

local function FormatRate(value)
	local amount = tonumber(value) or 0
	if amount >= 1000000000000 then
		return string.format("%.2fT/s", amount / 1000000000000)
	elseif amount >= 1000000000 then
		return string.format("%.2fB/s", amount / 1000000000)
	elseif amount >= 1000000 then
		return string.format("%.2fM/s", amount / 1000000)
	elseif amount >= 1000 then
		return string.format("%.1fK/s", amount / 1000)
	end
	return string.format("%d/s", math.floor(amount))
end

local function FormatWeight(value)
	local amount = tonumber(value) or 0
	local formatted = amount >= 1000 and string.format("%.0f", amount) or string.format("%.2f", amount)
	local integerPart, decimalPart = string.match(formatted, "^(%-?%d+)(%.%d+)$")
	integerPart = integerPart or formatted
	while true do
		local replaced, count = string.gsub(integerPart, "^(%-?%d+)(%d%d%d)", "%1,%2")
		if count == 0 then
			break
		end
		integerPart = replaced
	end
	return integerPart .. (decimalPart or "") .. " Kg"
end

local function FormatRemaining(totalSeconds)
	local seconds = math.max(0, math.floor(tonumber(totalSeconds) or 0))
	if seconds >= 3600 then
		return string.format("%dh %02dm", seconds // 3600, (seconds % 3600) // 60)
	end
	return string.format("%dm %02ds", seconds // 60, seconds % 60)
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
		PetIcon = tostring(assetInfo.Icon or ""),
		EggIcon = tostring(eggInfo.Icon or ""),
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

local DEFAULT_MUTATION_TINT = Color3.fromRGB(143, 227, 255)
local RAINBOW_TINTS = {
	Color3.fromRGB(255, 107, 107),
	Color3.fromRGB(255, 179, 107),
	Color3.fromRGB(255, 240, 107),
	Color3.fromRGB(107, 255, 138),
	Color3.fromRGB(107, 200, 255),
	Color3.fromRGB(185, 107, 255),
}

local function ReadMutation(rawMutation)
	local mutationId = tostring(rawMutation)
	local label, tint = mutationId, nil
	if type(MutationsModule) == "table" then
		if type(MutationsModule.LabelOf) == "function" then
			local callOk, labelValue = pcall(MutationsModule.LabelOf, mutationId)
			if callOk and type(labelValue) == "string" and labelValue ~= "" then
				label = labelValue
			end
		end
		if type(MutationsModule.Get) == "function" then
			local callOk, mutationSpec = pcall(MutationsModule.Get, mutationId)
			if callOk and type(mutationSpec) == "table" and typeof(mutationSpec.Tint) == "Color3" then
				tint = mutationSpec.Tint
			end
		end
	end
	return { Id = mutationId, Label = string.upper(label), Tint = tint or DEFAULT_MUTATION_TINT }
end

local function ReadMutations(rawMutations)
	local mutations = {}
	if type(rawMutations) ~= "table" then
		return mutations
	end
	for _, rawMutation in ipairs(rawMutations) do
		local mutation = ReadMutation(rawMutation)
		if mutation.Label ~= "NONE" and mutation.Label ~= "" then
			table.insert(mutations, mutation)
		end
	end
	return mutations
end

local function BuildMutationText(mutations)
	local parts = {}
	for _, mutation in ipairs(mutations) do
		if mutation.Label == "RAINBOW" or mutation.Label == "PRISMATIC" then
			local letters = {}
			for index = 1, #mutation.Label do
				local tint = RAINBOW_TINTS[(index - 1) % #RAINBOW_TINTS + 1]
				table.insert(
					letters,
					string.format('<font color="#%s">%s</font>', tint:ToHex(), string.sub(mutation.Label, index, index))
				)
			end
			table.insert(parts, "<b>" .. table.concat(letters) .. "</b>")
		else
			table.insert(
				parts,
				string.format('<b><font color="#%s">%s</font></b>', mutation.Tint:ToHex(), mutation.Label)
			)
		end
	end
	return table.concat(parts, " ")
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
			local petIcon = assetInfo and assetInfo.PetIcon or ""
			local eggIcon = ReadEggIcon(eggData, assetInfo and assetInfo.EggIcon or "")
			if petIcon == "" then
				petIcon = eggIcon
			end
			local mutations = ReadMutations(eggData.Mutations)
			local earningRate = assetInfo and assetInfo.EarningRate or 0
			local income = 0
			if earningRate > 0 and scaleValue > 0 then
				income = math.max(math.floor(earningRate * ScaleFactor(scaleValue) * ReadMutationMultiplier(eggData.Mutations) + 0.5), 1)
			end
			table.insert(entries, {
				Id = tostring(eggKey),
				Category = tostring(eggData.AssetCategory or ""),
				Name = assetInfo and assetInfo.Name or tostring(eggData.AssetCategory or "Egg"),
				Rarity = assetInfo and assetInfo.Rarity or "Common",
				RarityRank = assetInfo and assetInfo.RarityRank or 0,
				RarityColor = assetInfo and assetInfo.RarityColor or FALLBACK_RARITY_COLOR,
				Gradient = assetInfo and assetInfo.Gradient or nil,
				PetIcon = petIcon,
				EggIcon = eggIcon,
				Mutations = mutations,
				MutationText = BuildMutationText(mutations),
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

local function CountStatuses(entries)
	local counts = { All = #entries, Ready = 0, Growing = 0, ["In Bag"] = 0 }
	for _, entry in ipairs(entries) do
		counts[entry.Status] = (counts[entry.Status] or 0) + 1
	end
	return counts
end

local function SampleSequence(sequence, position)
	local keypoints = sequence.Keypoints
	if position <= keypoints[1].Time then
		return keypoints[1].Value
	end
	for index = 2, #keypoints do
		local previous, current = keypoints[index - 1], keypoints[index]
		if position <= current.Time then
			local span = current.Time - previous.Time
			local alpha = span > 0 and (position - previous.Time) / span or 0
			return previous.Value:Lerp(current.Value, alpha)
		end
	end
	return keypoints[#keypoints].Value
end

local function CropSequence(sequence, from, to)
	local keypoints = { ColorSequenceKeypoint.new(0, SampleSequence(sequence, from)) }
	for _, keypoint in ipairs(sequence.Keypoints) do
		if keypoint.Time > from + 0.001 and keypoint.Time < to - 0.001 then
			table.insert(keypoints, ColorSequenceKeypoint.new((keypoint.Time - from) / (to - from), keypoint.Value))
		end
	end
	table.insert(keypoints, ColorSequenceKeypoint.new(1, SampleSequence(sequence, to)))
	return ColorSequence.new(keypoints)
end

local function ReadRaritySequence(entry)
	local rarity = string.upper(tostring(entry.Rarity))
	if rarity == "SECRET" then
		return SECRET_SEQUENCE, 90
	end
	local gradient = entry.Gradient
	if typeof(gradient) == "Instance" and gradient:IsA("UIGradient") then
		return gradient.Color, gradient.Rotation
	end
	return ColorSequence.new(entry.RarityColor:Lerp(COLORS.Text, 0.35), entry.RarityColor), 90
end

local function BuildArtSequence(entry)
	local rarity = string.upper(tostring(entry.Rarity))
	if rarity == "SECRET" then
		return SECRET_SEQUENCE
	elseif rarity == "ETERNAL" then
		return ETERNAL_SEQUENCE
	end
	local sequence = ReadRaritySequence(entry)
	local brightColors = {}
	for _, keypoint in ipairs(sequence.Keypoints) do
		local color = keypoint.Value
		if color.R * 0.299 + color.G * 0.587 + color.B * 0.114 >= 0.45 then
			table.insert(brightColors, color)
		end
	end
	if #brightColors == 0 then
		table.insert(brightColors, entry.RarityColor)
	end
	local sampleCount = math.min(#brightColors, 8)
	local samples = {}
	for index = 1, sampleCount do
		local position = math.clamp(
			math.floor((index - 1) * (#brightColors - 1) / math.max(sampleCount - 1, 1) + 1.5),
			1,
			#brightColors
		)
		table.insert(samples, brightColors[position]:Lerp(COLORS.Text, 0.36))
	end
	if #samples == 1 then
		table.insert(samples, samples[1])
	end
	local keypoints = {}
	for index, color in ipairs(samples) do
		table.insert(keypoints, ColorSequenceKeypoint.new((index - 1) / (#samples - 1), color))
	end
	return ColorSequence.new(keypoints)
end

local DARK_INK = Color3.fromRGB(46, 32, 14)
local LIGHT_INK = Color3.fromRGB(255, 255, 255)
local PILL_LIGHT = Color3.fromRGB(250, 246, 232)
local PILL_DARK = Color3.fromRGB(18, 16, 24)

local function ReadSurfaceInk(entry)
	local color = SampleSequence(BuildArtSequence(entry), 0.5)
	local luminance = color.R * 0.299 + color.G * 0.587 + color.B * 0.114
	return luminance > 0.56 and DARK_INK or LIGHT_INK
end

local function ReadIncomeSequence(ink)
	if ink == DARK_INK then
		return ColorSequence.new(Color3.fromRGB(22, 150, 60), Color3.fromRGB(10, 92, 34))
	end
	return ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom)
end

local function PaintGradient(target, name, sequence, rotation)
	local gradient = target:FindFirstChild(name)
	if not gradient then
		gradient = New("UIGradient", { Name = name, Parent = target })
	end
	gradient.Color = sequence
	gradient.Rotation = rotation
	return gradient
end

local function PaintRarityText(label, entry, isHeading)
	local sequence, rotation = ReadRaritySequence(entry)
	local reversed = math.cos(math.rad(rotation)) < -0.3 or math.sin(math.rad(rotation)) < -0.3
	local from, to
	if isHeading then
		from, to = reversed and 0.5 or 0, reversed and 1 or 0.5
	else
		from, to = reversed and 0 or 0.5, reversed and 0.5 or 1
	end
	PaintGradient(label, "TextPaint", CropSequence(sequence, from, to), rotation)
	label.TextColor3 = COLORS.Text
end
local SHIMMER_SEQUENCE = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 128, 146)),
	ColorSequenceKeypoint.new(0.34, Color3.fromRGB(206, 212, 224)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.66, Color3.fromRGB(206, 212, 224)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 128, 146)),
})

local CONTAINER_PADDING = 7
local SCROLLBAR_WIDTH = 4
local GRID_GAP = 6
local MIN_CARD_WIDTH = 72
local CARD_MARGIN = 2
local LIST_COLUMNS = 4
local SHIMMER_SPEED = 0.9
local SHIMMER_ROTATION = 45

Prediction.Shimmers = {}
Prediction.Theme = nil

local function ReadTheme(groupbox)
	local surface, border = COLORS.Card, COLORS.Border
	local holder = groupbox and groupbox.Holder
	if holder then
		surface = holder.BackgroundColor3
		local outline = holder:FindFirstChildWhichIsA("UIStroke")
		if outline then
			border = outline.Color
		end
	end
	return {
		Surface = surface:Lerp(Color3.new(1, 1, 1), 0.06),
		Border = border,
		Hover = border:Lerp(Color3.new(1, 1, 1), 0.45),
	}
end

local function AddShimmer(stroke, phase, rotation)
	local gradient = PaintGradient(stroke, "Shimmer", SHIMMER_SEQUENCE, rotation or SHIMMER_ROTATION)
	table.insert(Prediction.Shimmers, { Gradient = gradient, Phase = phase or 0 })
	return gradient
end

local function AnimateShimmers(now)
	for _, shimmer in ipairs(Prediction.Shimmers) do
		local gradient = shimmer.Gradient
		if gradient and gradient.Parent then
			gradient.Offset = Vector2.new(math.sin(now * SHIMMER_SPEED + shimmer.Phase) * 0.7, 0)
		end
	end
end

local function PruneShimmers()
	for index = #Prediction.Shimmers, 1, -1 do
		local gradient = Prediction.Shimmers[index].Gradient
		if not gradient or not gradient.Parent then
			table.remove(Prediction.Shimmers, index)
		end
	end
end

local function StatusText(entry)
	if not entry then
		return ""
	elseif entry.Status == "Ready" then
		return "READY"
	elseif entry.Status == "Growing" then
		return FormatRemaining(entry.Remaining) .. "  " .. entry.Percent .. "%"
	end
	return "IN BAG"
end

local function ApplyStatusFill(bar, entry)
	if not entry then
		bar.Chip.Visible = false
		bar.Fill.Size = UDim2.fromScale(0, 1)
		return
	end

	local colors = COLORS.InBag
	if entry.Status == "Ready" then
		colors = COLORS.Ready
	elseif entry.Status == "Growing" then
		colors = COLORS.Growing
	end

	bar.Gradient.Color = ColorSequence.new(colors[1], colors[2])
	bar.Fill.Size = UDim2.fromScale(entry.Status == "Growing" and math.clamp(entry.Percent / 100, 0.04, 1) or 1, 1)
	bar.Text.Text = StatusText(entry)
	bar.Chip.Visible = true
end

local function CreateProgressBar(parent, height, textSize, theme)
	local track = New("Frame", {
		BackgroundColor3 = COLORS.Track,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Size = UDim2.new(1, 0, 0, height),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		New("UIStroke", {
			Color = theme.Border,
			Thickness = 1,
			Transparency = 0.6,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}),
	})

	local fill = New("Frame", {
		BackgroundColor3 = COLORS.Text,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Parent = track,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
	})

	local gradient = New("UIGradient", {
		Color = ColorSequence.new(COLORS.InBag[1], COLORS.InBag[2]),
		Parent = fill,
	})

	New("Frame", {
		BackgroundColor3 = COLORS.Text,
		BackgroundTransparency = 0.8,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0, 0.1),
		Size = UDim2.fromScale(1, 0.32),
		Parent = fill,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
	})

	local chip = New("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.42,
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.X,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 0, 1, -3),
		ZIndex = 4,
		Parent = track,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		New("UIPadding", {
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
		}),
	})

	local label = New("TextLabel", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromScale(0, 1),
		Text = "",
		TextColor3 = COLORS.Text,
		TextSize = textSize,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		ZIndex = 5,
		Parent = chip,
	})
	UseDisplayFont(label)

	return {
		Track = track,
		Fill = fill,
		Gradient = gradient,
		Text = label,
		Chip = chip,
	}
end

local function CreateArtBox(parent, entry, position, size, badgeSize, theme, showShadow)
	local petImage = New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.47),
		Size = UDim2.fromScale(0.86, 0.86),
		Image = entry.PetIcon,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 2,
	})

	local badgeStroke = New("UIStroke", {
		Color = entry.RarityColor,
		Thickness = 1.2,
		Transparency = 0.3,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})

	local eggImage = New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.52),
		Size = UDim2.fromScale(0.76, 0.76),
		Image = entry.EggIcon,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 5,
	})

	local badge = New("Frame", {
		AnchorPoint = Vector2.new(1, 1),
		BackgroundColor3 = theme.Surface,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -3, 1, -3),
		Size = UDim2.fromOffset(badgeSize, badgeSize),
		ZIndex = 4,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		badgeStroke,
		eggImage,
	})

	local art = New("Frame", {
		BackgroundColor3 = COLORS.Text,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = position,
		Size = size,
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 7) }),
		New("ImageLabel", {
			BackgroundTransparency = 1,
			Image = CARD_TILE_ASSET,
			ImageColor3 = COLORS.TileTint,
			ImageTransparency = 0.86,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromScale(0.34, 0.42),
			Size = UDim2.fromScale(1, 1),
		}),
		petImage,
		New("Frame", {
			BackgroundColor3 = COLORS.Text,
			BackgroundTransparency = 0.9,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 1,
		}, {
			New("UIGradient", {
				Rotation = 90,
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0.86),
					NumberSequenceKeypoint.new(0.45, 0.94),
					NumberSequenceKeypoint.new(1, 1),
				}),
			}),
		}),
		badge,
	})

	if showShadow then
		New("ImageLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.88),
			Size = UDim2.fromScale(0.52, 0.12),
			Image = PREVIEW_SHADOW_ASSET,
			ImageColor3 = COLORS.ShadowTint,
			ImageTransparency = 0.55,
			ScaleType = Enum.ScaleType.Stretch,
			ZIndex = 1,
			Parent = art,
		})
	end

	PaintGradient(art, "RarityPaint", BuildArtSequence(entry), 90)

	return {
		Frame = art,
		Pet = petImage,
		Egg = eggImage,
		Badge = badge,
		BadgeStroke = badgeStroke,
	}
end

local function CardMetrics(cardWidth)
	local inset = 4
	local contentWidth = cardWidth - inset * 2
	local artHeight = math.floor(contentWidth * 0.78)

	local nameSize = math.clamp(math.floor(cardWidth * 0.128 + 0.5), 9, 13)
	local metaSize = math.clamp(math.floor(cardWidth * 0.095 + 0.5), 7, 10)
	local valueSize = math.clamp(math.floor(cardWidth * 0.132 + 0.5), 9, 13)
	local rankSize = math.clamp(math.floor(cardWidth * 0.098 + 0.5), 7, 9)

	local metaHeight = metaSize + 4
	local nameHeight = nameSize + 4
	local rarityHeight = metaSize + 3
	local valueHeight = valueSize + 4

	local artY = inset
	local metaY = artY + artHeight + 2
	local nameY = metaY + metaHeight
	local rarityY = nameY + nameHeight - 1
	local valueY = rarityY + rarityHeight - 1

	return {
		Width = cardWidth,
		Height = valueY + valueHeight + inset,
		Inset = inset,
		ContentWidth = contentWidth,
		ArtWidth = contentWidth,
		ArtHeight = artHeight,
		ArtY = artY,
		Badge = math.max(16, math.floor(contentWidth * 0.24)),
		RankSize = rankSize,
		MetaSize = metaSize,
		MetaY = metaY,
		MetaHeight = metaHeight,
		NameSize = nameSize,
		NameY = nameY,
		NameHeight = nameHeight,
		RaritySize = metaSize,
		RarityY = rarityY,
		RarityHeight = rarityHeight,
		ValueSize = valueSize,
		ValueY = valueY,
		ValueHeight = valueHeight,
	}
end

local function CreateMutationStack(parent, rightInset, topInset, width, textSize, lineHeight)
	local labels = {}
	for index = 1, MUTATION_STACK_LIMIT do
		local label = CreateLabel(parent, {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -rightInset, 0, topInset + (index - 1) * lineHeight),
			Size = UDim2.new(0, width, 0, lineHeight),
			Text = "",
			TextSize = textSize,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Visible = false,
			ZIndex = 8,
		})
		New("UIStroke", {
			Color = COLORS.Track,
			Thickness = 1.6,
			Transparency = 0.15,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			Parent = label,
		})
		labels[index] = label
	end

	local stack = {}

	function stack.Update(mutations)
		for index, label in ipairs(labels) do
			local mutation = mutations and mutations[index]
			label.Visible = mutation ~= nil
			if mutation then
				label.Text = mutation.Label
				label.TextColor3 = mutation.Tint
			end
		end
	end

	stack.Update(nil)
	return stack
end

local function CreateCard(parent, entry, metrics, index, theme)
	local cell = New("Frame", {
		Name = "PredictorCardCell",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = index,
		Size = UDim2.fromOffset(metrics.Width + CARD_MARGIN * 2, metrics.Height + CARD_MARGIN * 2),
		Parent = parent,
	})

	local ink = ReadSurfaceInk(entry)
	local card = New("Frame", {
		Name = "PredictorCard",
		BackgroundColor3 = COLORS.Text,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(CARD_MARGIN, CARD_MARGIN),
		Size = UDim2.fromOffset(metrics.Width, metrics.Height),
		Parent = cell,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 8) }),
	})
	PaintGradient(card, "RarityPaint", BuildArtSequence(entry), 90)

	local baseStroke = New("UIStroke", {
		Color = ink,
		Thickness = 1,
		Transparency = 0.55,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = card,
	})

	local shimmerStroke = New("UIStroke", {
		Color = COLORS.Text,
		Thickness = 1.1,
		Transparency = 0.4,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = card,
	})
	AddShimmer(shimmerStroke, index * 0.6)

	local artBox = CreateArtBox(
		card,
		entry,
		UDim2.fromOffset(metrics.Inset, metrics.ArtY),
		UDim2.fromOffset(metrics.ArtWidth, metrics.ArtHeight),
		metrics.Badge,
		theme,
		false
	)
	PaintGradient(artBox.Frame, "RarityPaint", BuildArtSequence(entry), 90).Transparency = NumberSequence.new(0.35, 0.7)

	local rankChip = New("Frame", {
		BackgroundColor3 = PILL_DARK,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(metrics.Inset + 2, metrics.ArtY + 2),
		Size = UDim2.fromOffset(math.max(18, metrics.RankSize * 2), metrics.RankSize + 5),
		ZIndex = 8,
		Parent = card,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
	})

	local rankLabel = CreateLabel(rankChip, {
		Size = UDim2.fromScale(1, 1),
		Text = string.format("#%d", index),
		TextSize = metrics.RankSize,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextColor3 = COLORS.Text,
		ZIndex = 9,
	})

	local mutationStack = CreateMutationStack(
		artBox.Frame,
		4,
		2,
		math.max(28, math.floor(metrics.ContentWidth * 0.66)),
		metrics.RankSize,
		metrics.RankSize + 2
	)
	mutationStack.Update(entry.Mutations)

	local timeLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.MetaY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.MetaHeight),
		Text = entry.Status == "Growing" and FormatRemaining(entry.Remaining) or entry.Status,
		TextSize = metrics.MetaSize,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = ink,
	})

	local scaleLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.MetaY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.MetaHeight),
		Text = string.format("x%.2f", entry.Scale),
		TextSize = metrics.MetaSize,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextColor3 = ink,
	})

	local nameLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.NameY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.NameHeight),
		Text = entry.Name,
		TextSize = metrics.NameSize,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextColor3 = ink,
	})
	UseDisplayFont(nameLabel)

	local rarityLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.RarityY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.RarityHeight),
		Text = string.upper(entry.Rarity),
		TextSize = metrics.RaritySize,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextColor3 = ink,
		TextTransparency = 0.25,
	})

	local valueLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.ValueY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.ValueHeight),
		Text = FormatRate(entry.Income),
		TextSize = metrics.ValueSize,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextColor3 = COLORS.Text,
	})
	PaintGradient(valueLabel, "TextPaint", ReadIncomeSequence(ink), 90)

	local selection = New("UIStroke", {
		Color = COLORS.Text,
		Thickness = 2,
		Transparency = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = card,
	})
	AddShimmer(selection, index * 0.6)

	local button = New("TextButton", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		ZIndex = 9,
		Parent = card,
	})

	button.MouseEnter:Connect(function()
		baseStroke.Transparency = 0.1
		baseStroke.Thickness = 1.6
	end)

	button.MouseLeave:Connect(function()
		baseStroke.Transparency = 0.55
		baseStroke.Thickness = 1
	end)

	button.MouseButton1Click:Connect(function()
		Prediction.SelectedId = entry.Id
		Prediction.SelectCard()
		if Prediction.Preview then
			local rank = 0
			for currentIndex, current in ipairs(Prediction.Entries or {}) do
				if current.Id == entry.Id then
					rank = currentIndex
					break
				end
			end
			Prediction.Preview.Update(entry, rank)
		end
	end)

	return {
		Frame = cell,
		Selection = selection,
		Update = function(current)
			valueLabel.Text = FormatRate(current.Income)
			scaleLabel.Text = string.format("x%.2f", current.Scale)
			timeLabel.Text = current.Status == "Growing" and FormatRemaining(current.Remaining) or current.Status
			mutationStack.Update(current.Mutations)
		end,
	}
end
local function CreateChip(parent, position, anchorX, textSize)
	local chip = New("Frame", {
		BackgroundColor3 = PILL_LIGHT,
		BackgroundTransparency = 0.05,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(anchorX, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		Position = position,
		Size = UDim2.new(0, 0, 0, 16),
		ZIndex = 7,
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		New("UIPadding", {
			PaddingLeft = UDim.new(0, 7),
			PaddingRight = UDim.new(0, 7),
		}),
	})

	local label = New("TextLabel", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Text = "",
		TextColor3 = DARK_INK,
		TextSize = textSize or 9,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 8,
		Parent = chip,
	})
	UseDisplayFont(label)

	return { Frame = chip, Label = label }
end

local function CreateStatPill(parent, position, size, captionText)
	local pill = New("Frame", {
		BackgroundColor3 = PILL_LIGHT,
		BackgroundTransparency = 0.08,
		BorderSizePixel = 0,
		Position = position,
		Size = size,
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 7) }),
	})

	local valueLabel = CreateLabel(pill, {
		Position = UDim2.fromOffset(0, 5),
		Size = UDim2.new(1, 0, 0, 12),
		Text = "",
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextColor3 = DARK_INK,
	})

	local caption = CreateLabel(pill, {
		Position = UDim2.fromOffset(0, 16),
		Size = UDim2.new(1, 0, 0, 9),
		Text = captionText,
		TextSize = 7,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextColor3 = DARK_INK,
		TextTransparency = 0.45,
	})

	return { Frame = pill, Value = valueLabel, Caption = caption }
end

local function CreatePreview(parent, theme)
	local frame = New("Frame", {
		Name = "PredictorPreview",
		BackgroundColor3 = COLORS.Text,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(HERO_MIN_WIDTH, HERO_HEIGHT),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 14) }),
	})
	PaintGradient(frame, "CardPaint", ColorSequence.new(theme.Surface, COLORS.ShadowTint), 90)

	local glowStroke = New("UIStroke", {
		Color = COLORS.Text,
		Thickness = 1.6,
		Transparency = 0.24,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = frame,
	})
	AddShimmer(glowStroke, 0, 35)

	local artWidth = HERO_MIN_WIDTH - 16
	local artBox = CreateArtBox(
		frame,
		{ PetIcon = "", EggIcon = "", Rarity = "Common", RarityColor = COLORS.Text, Gradient = nil, MutationText = "" },
		UDim2.fromOffset(8, 6),
		UDim2.fromOffset(artWidth, PREVIEW_ART_HEIGHT),
		math.floor(artWidth * 0.2),
		theme,
		true
	)
	PaintGradient(artBox.Frame, "RarityPaint", ColorSequence.new(theme.Surface, theme.Surface), 90)
	artBox.Pet.Image = ""
	artBox.Egg.Image = ""

	local rays = New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.46),
		Size = UDim2.fromScale(1.7, 1.7),
		Image = PREVIEW_RAYS_ASSET,
		ImageColor3 = COLORS.Text,
		ImageTransparency = 0.3,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 1,
		Parent = artBox.Frame,
	})

	local rankChip = New("Frame", {
		BackgroundColor3 = PILL_DARK,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.X,
		Position = UDim2.fromOffset(6, 6),
		Size = UDim2.new(0, 0, 0, 17),
		ZIndex = 8,
		Parent = artBox.Frame,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		New("UIPadding", {
			PaddingLeft = UDim.new(0, 8),
			PaddingRight = UDim.new(0, 8),
		}),
	})

	local rankLabel = New("TextLabel", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Text = "RANK -",
		TextColor3 = COLORS.Text,
		TextSize = 9,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 9,
		Parent = rankChip,
	})
	UseDisplayFont(rankLabel)

	local mutationStack = CreateMutationStack(artBox.Frame, 6, 7, math.floor(artWidth * 0.58), 11, 13)

	local nameLabel = CreateLabel(frame, {
		Position = UDim2.fromOffset(8, 160),
		Size = UDim2.new(1, -16, 0, 32),
		Text = "No egg",
		TextSize = 16,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.None,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextColor3 = COLORS.Subtext,
	})

	local rarityChip = CreateChip(frame, UDim2.new(0.5, 0, 0, 196), 0.5, 9)
	rarityChip.Frame.AnchorPoint = Vector2.new(0.5, 0)
	rarityChip.Frame.Visible = false

	local valueLabel = CreateLabel(frame, {
		Position = UDim2.fromOffset(8, 216),
		Size = UDim2.new(1, -16, 0, 30),
		TextSize = 25,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	PaintGradient(valueLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

	local pillWidth = math.floor((HERO_MIN_WIDTH - 16 - 6) / 2)
	local scalePill = CreateStatPill(frame, UDim2.fromOffset(8, 250), UDim2.fromOffset(pillWidth, 30), "SIZE")
	local weightPill = CreateStatPill(
		frame,
		UDim2.fromOffset(8 + pillWidth + 6, 250),
		UDim2.fromOffset(pillWidth, 30),
		"WEIGHT"
	)

	local bar = CreateProgressBar(frame, 18, 9, theme)
	bar.Track.Position = UDim2.fromOffset(8, 286)
	bar.Track.Size = UDim2.new(1, -16, 0, 18)

	local goButton = nil
	if Prediction.Hooks and type(Prediction.Hooks.OnGoToEgg) == "function" then
		goButton = New("TextButton", {
			BackgroundColor3 = PILL_LIGHT,
			BackgroundTransparency = 0.02,
			AutoButtonColor = true,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(8, 308),
			Size = UDim2.new(1, -16, 0, 24),
			Text = "Go to egg",
			TextColor3 = DARK_INK,
			TextSize = 11,
			ZIndex = 8,
			Parent = frame,
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})
		UseDisplayFont(goButton)
	end

	local preview = {
		Frame = frame,
		Art = artBox.Frame,
		Rays = rays,
		Key = nil,
		Entry = nil,
	}

	function preview.Resize(width)
		frame.Size = UDim2.fromOffset(width, HERO_HEIGHT)
		artBox.Frame.Size = UDim2.fromOffset(width - 16, PREVIEW_ART_HEIGHT)
		local nextPillWidth = math.floor((width - 16 - 6) / 2)
		scalePill.Frame.Size = UDim2.fromOffset(nextPillWidth, 30)
		weightPill.Frame.Position = UDim2.fromOffset(8 + nextPillWidth + 6, 250)
		weightPill.Frame.Size = UDim2.fromOffset(nextPillWidth, 30)
	end

	function preview.Update(entry, rank)
		if not entry then
			preview.Key = nil
			preview.Entry = nil
			rankLabel.Text = "RANK -"
			nameLabel.Text = "No egg"
			nameLabel.TextColor3 = COLORS.Subtext
			mutationStack.Update(nil)
			rarityChip.Frame.Visible = false
			valueLabel.Text = ""
			scalePill.Value.Text = ""
			weightPill.Value.Text = ""
			artBox.Pet.Image = ""
			artBox.Egg.Image = ""
			PaintGradient(frame, "CardPaint", ColorSequence.new(theme.Surface, COLORS.ShadowTint), 90)
			PaintGradient(artBox.Frame, "RarityPaint", ColorSequence.new(theme.Surface, theme.Surface), 90)
			ApplyStatusFill(bar, nil)
			return
		end

		preview.Entry = entry
		rankLabel.Text = string.format("RANK %d", rank or 0)

		local key = entry.Id .. "|" .. entry.Rarity .. "|" .. entry.Name
		if preview.Key ~= key then
			preview.Key = key
			local ink = ReadSurfaceInk(entry)
			artBox.Pet.Image = entry.PetIcon
			artBox.Egg.Image = entry.EggIcon
			artBox.BadgeStroke.Color = ink
			PaintGradient(artBox.Frame, "RarityPaint", BuildArtSequence(entry), 90).Transparency = NumberSequence.new(0.4, 0.75)
			PaintGradient(frame, "CardPaint", BuildArtSequence(entry), 90)
			nameLabel.Text = entry.Name
			nameLabel.TextColor3 = ink
			rarityChip.Frame.Visible = true
			rarityChip.Label.Text = string.upper(entry.Rarity)
			rarityChip.Label.TextColor3 = ink
			rarityChip.Frame.BackgroundColor3 = ink == DARK_INK and PILL_LIGHT or PILL_DARK
			PaintGradient(valueLabel, "TextPaint", ReadIncomeSequence(ink), 90)
		end

		mutationStack.Update(entry.Mutations)
		valueLabel.Text = FormatRate(entry.Income)
		scalePill.Value.Text = string.format("x%.2f", entry.Scale)
		weightPill.Value.Text = FormatWeight(entry.Weight)
		ApplyStatusFill(bar, entry)
	end

	if goButton then
		goButton.MouseButton1Click:Connect(function()
			if not preview.Entry then
				return
			end
			task.spawn(Prediction.Hooks.OnGoToEgg, preview.Entry)
		end)
	end

	return preview
end

local function CreateFilterBar(parent, theme)
	local bar = New("Frame", {
		Name = "PredictorFilters",
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Size = UDim2.new(1, -CONTAINER_PADDING * 2, 0, 21),
		Parent = parent,
	}, {
		New("UIGridLayout", {
			CellSize = UDim2.new(0.25, -3, 0, 21),
			CellPadding = UDim2.fromOffset(4, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	Prediction.Filters = {}
	for index, filter in ipairs(FILTERS) do
		local button = New("TextButton", {
			BackgroundColor3 = theme.Surface,
			BackgroundTransparency = 0.15,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			LayoutOrder = index,
			Text = "",
			Parent = bar,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		})

		local stroke = New("UIStroke", {
			Color = theme.Border,
			Thickness = 1,
			Transparency = 0.25,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Parent = button,
		})

		local gradient = New("UIGradient", {
			Color = ColorSequence.new(filter.Colors[1], filter.Colors[2]),
			Rotation = 90,
			Enabled = false,
			Parent = button,
		})

		local label = New("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(2, 0),
			Size = UDim2.new(1, -4, 1, 0),
			Text = filter.Title,
			TextColor3 = COLORS.Subtext,
			TextScaled = true,
			Parent = button,
		}, {
			New("UITextSizeConstraint", { MaxTextSize = 9, MinTextSize = 6 }),
		})
		UseDisplayFont(label)

		button.MouseButton1Click:Connect(function()
			Prediction.SetFilterMode(filter.Key)
		end)

		Prediction.Filters[filter.Key] = {
			Button = button,
			Stroke = stroke,
			Gradient = gradient,
			Label = label,
			Title = filter.Title,
		}
	end

	return bar
end

function Prediction.SetFilterActive()
	local theme = Prediction.Theme or ReadTheme(nil)
	for key, filter in pairs(Prediction.Filters) do
		local isActive = key == Prediction.FilterMode
		local count = Prediction.Counts[key] or 0
		filter.Label.Text = filter.Title .. "  " .. tostring(count)
		filter.Gradient.Enabled = isActive
		filter.Button.BackgroundColor3 = isActive and COLORS.Text or theme.Surface
		filter.Button.BackgroundTransparency = isActive and 0 or 0.15
		filter.Label.TextColor3 = isActive and Color3.new(0, 0, 0) or COLORS.Subtext
		filter.Stroke.Color = isActive and Color3.new(0, 0, 0) or theme.Border
		filter.Stroke.Transparency = isActive and 0.35 or 0.25
	end
end

function Prediction.SelectCard()
	for id, card in pairs(Prediction.Cards) do
		local isSelected = id == Prediction.SelectedId
		card.Selection.Transparency = isSelected and 0 or 1
		card.Selection.Thickness = isSelected and 2.2 or 0
	end
end

local function ClearCards()
	for _, card in pairs(Prediction.Cards) do
		card.Frame:Destroy()
	end
	Prediction.Cards = {}
end

local function RenderList(entries)
	local scroll = Prediction.ListFrame
	local width = math.floor(scroll.AbsoluteSize.X)
	if width <= 0 then
		width = 300
	end

	local usable = width - SCROLLBAR_WIDTH - CARD_MARGIN * 2
	local columns = math.clamp(math.floor((usable + GRID_GAP) / (MIN_CARD_WIDTH + GRID_GAP)), 1, LIST_COLUMNS)
	local cellWidth = math.floor((usable - GRID_GAP * (columns - 1)) / columns)
	local metrics = CardMetrics(cellWidth - CARD_MARGIN * 2)
	local cellHeight = metrics.Height + CARD_MARGIN * 2

	ClearCards()
	PruneShimmers()
	Prediction.Grid.CellSize = UDim2.fromOffset(cellWidth, cellHeight)
	Prediction.Grid.CellPadding = UDim2.fromOffset(GRID_GAP, GRID_GAP)

	Prediction.CardWidth = width

	for index, entry in ipairs(entries) do
		Prediction.Cards[entry.Id] = CreateCard(scroll, entry, metrics, index, Prediction.Theme)
	end

	Prediction.SelectCard()
	Prediction.Groupbox:Resize()
end

local function BuildSignature(entries)
	local ids = {}
	for _, entry in ipairs(entries) do
		table.insert(ids, entry.Id)
	end
	return table.concat({ Prediction.SortMode, Prediction.FilterMode, table.concat(ids, ",") }, "|")
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
		Prediction.SetFilterActive()
	end
end

function Prediction.LayoutHero()
	local hero = Prediction.Hero
	local preview = Prediction.Preview
	local column = Prediction.ListColumn
	if not hero or not preview or not column then
		return
	end

	local heroWidth = math.floor(hero.AbsoluteSize.X)
	if heroWidth <= 0 then
		return
	end

	local previewWidth = math.clamp(math.floor(heroWidth * 0.32), HERO_MIN_WIDTH, HERO_MAX_WIDTH)
	if previewWidth ~= Prediction.PreviewWidth then
		Prediction.PreviewWidth = previewWidth
		preview.Resize(previewWidth)
	end

	local showPreview = Prediction.PreviewVisible
	preview.Frame.Visible = showPreview
	local offset = showPreview and (previewWidth + HERO_GAP) or 0
	column.Position = UDim2.fromOffset(offset, 0)
	column.Size = UDim2.new(1, -offset, 0, HERO_HEIGHT)
end

function Prediction.SetCardVisible(visible)
	Prediction.PreviewVisible = visible == true
	Prediction.LayoutHero()
	Prediction.Signature = ""
	if Prediction.Groupbox then
		Prediction.Groupbox:Resize()
	end
end

function Prediction.Build(groupbox, hooks)
	Prediction.Groupbox = groupbox
	Prediction.Hooks = hooks
	Prediction.Theme = ReadTheme(groupbox)
	local container = groupbox.Container

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

	local hero = New("Frame", {
		Name = "PredictorHero",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -CONTAINER_PADDING * 2, 0, HERO_HEIGHT),
		Parent = container,
	})

	Prediction.Hero = hero
	Prediction.Preview = CreatePreview(hero, Prediction.Theme)

	Prediction.ListColumn = New("Frame", {
		Name = "PredictorListColumn",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(HERO_MIN_WIDTH + HERO_GAP, 0),
		Size = UDim2.new(1, -(HERO_MIN_WIDTH + HERO_GAP), 0, HERO_HEIGHT),
		Parent = hero,
	})

	local filterBar = CreateFilterBar(Prediction.ListColumn, Prediction.Theme)
	filterBar.Size = UDim2.new(1, -SCROLLBAR_WIDTH, 0, HERO_FILTER_HEIGHT)

	Prediction.ListFrame = New("ScrollingFrame", {
		Name = "PredictorList",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(0, HERO_FILTER_HEIGHT + 6),
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Prediction.Theme.Border,
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, 0, 0, HERO_HEIGHT - HERO_FILTER_HEIGHT - 6),
		Parent = Prediction.ListColumn,
	})

	Prediction.LayoutHero()

	Prediction.Grid = New("UIGridLayout", {
		CellSize = UDim2.fromOffset(MIN_CARD_WIDTH + CARD_MARGIN * 2, 120),
		CellPadding = UDim2.fromOffset(GRID_GAP, GRID_GAP),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = Prediction.ListFrame,
	})

	groupbox:Resize()

	Prediction.Signature = ""
	Prediction.NextRefreshAt = 0
	Prediction.LastFrameAt = os.clock()

	Prediction.Connection = RunService.Heartbeat:Connect(function()
		local now = os.clock()
		local delta = math.min(now - Prediction.LastFrameAt, 0.1)
		Prediction.LastFrameAt = now

		AnimateShimmers(now)

		local preview = Prediction.Preview
		if preview and preview.Frame.Visible then
			Prediction.RaysAngle = (Prediction.RaysAngle + delta * 14) % 360
			preview.Rays.Rotation = Prediction.RaysAngle
		end

		if now < Prediction.NextRefreshAt then
			return
		end
		Prediction.NextRefreshAt = now + 1

		local allEntries = ReadEntries()
		Prediction.Counts = CountStatuses(allEntries)

		local visible = {}
		for _, entry in ipairs(SortEntries(allEntries)) do
			if IsVisible(entry) then
				table.insert(visible, entry)
			end
		end
		Prediction.Entries = visible

		if not Prediction.SelectedId or not Prediction.Cards[Prediction.SelectedId] then
			Prediction.SelectedId = visible[1] and visible[1].Id or nil
		end

		Prediction.LayoutHero()

		local signature = BuildSignature(visible)
		local width = math.floor(Prediction.ListFrame.AbsoluteSize.X)
		if signature ~= Prediction.Signature or math.abs(width - Prediction.CardWidth) > 1 then
			Prediction.Signature = signature
			RenderList(visible)
		else
			for _, entry in ipairs(visible) do
				local card = Prediction.Cards[entry.Id]
				if card then
					card.Update(entry)
				end
			end
		end

		Prediction.SetFilterActive()

		local selectedEntry = nil
		for _, entry in ipairs(visible) do
			if entry.Id == Prediction.SelectedId then
				selectedEntry = entry
				break
			end
		end
		local previewEntry = selectedEntry or visible[1]
		local previewRank = 0
		if previewEntry then
			for index, entry in ipairs(visible) do
				if entry.Id == previewEntry.Id then
					previewRank = index
					break
				end
			end
		end
		Prediction.Preview.Update(previewEntry, previewRank)
	end)
end

local FUSE_SLOTS = 3
local FUSE_CARD_HEIGHT = 132
local FUSE_ART_SIZE = 100
local FUSE_SLOT_HEIGHT = 44
local FUSE_SLOT_ART = 34
local FUSE_SLOT_GAP = 4
local FUSE_BAND_ROWS = 3
local BASE_EGG_ICON = "rbxassetid://116524274262912"

local SCALE_BAND_COLORS = {
	{ Min = 0, Color = Color3.fromRGB(143, 152, 168) },
	{ Min = 0.3, Color = Color3.fromRGB(198, 205, 218) },
	{ Min = 0.85, Color = Color3.fromRGB(255, 255, 255) },
	{ Min = 1.45, Color = Color3.fromRGB(124, 255, 158) },
	{ Min = 1.9, Color = Color3.fromRGB(79, 224, 255) },
	{ Min = 2.85, Color = Color3.fromRGB(111, 160, 255) },
	{ Min = 3.8, Color = Color3.fromRGB(192, 139, 255) },
	{ Min = 5.8, Color = Color3.fromRGB(255, 154, 61) },
	{ Min = 9.5, Color = Color3.fromRGB(255, 92, 92) },
	{ Min = 12, Color = Color3.fromRGB(255, 211, 77) },
	{ Min = 20, Color = Color3.fromRGB(255, 77, 232) },
}

local function ScaleBandColor(bandMin)
	local bestMin, color = -math.huge, COLORS.Text
	for _, band in ipairs(SCALE_BAND_COLORS) do
		if bandMin + 0.001 >= band.Min and band.Min > bestMin then
			bestMin, color = band.Min, band.Color
		end
	end
	return color
end

local function FormatMoney(value)
	local suffixes = { "", "K", "M", "B", "T", "Qa", "Qi" }
	local amount = tonumber(value) or 0
	local index = 1
	while math.abs(amount) >= 1000 and index < #suffixes do
		amount = amount / 1000
		index = index + 1
	end
	if index == 1 then
		return string.format("$%d", math.floor(amount))
	end
	return string.format("$%.2f%s", amount, suffixes[index])
end

local function ReadScaleBands()
	if type(BalanceModule) == "table" and type(BalanceModule.Eggs) == "table" then
		local bands = BalanceModule.Eggs.SCALE_BANDS
		if type(bands) == "table" and #bands > 0 then
			return bands
		end
	end
	if type(EggRecordsModule) == "table" and type(EggRecordsModule.DrawAssetScale) == "function" then
		local hasDebug = type(debug) == "table" and type(debug.getupvalues) == "function"
		if hasDebug then
			local callOk, upvalues = pcall(debug.getupvalues, EggRecordsModule.DrawAssetScale)
			if callOk and type(upvalues) == "table" then
				for _, value in pairs(upvalues) do
					local first = type(value) == "table" and value[1] or nil
					if type(first) == "table" and type(first.min) == "number" and type(first.weight) == "number" then
						return value
					end
				end
			end
		end
	end
	return nil
end

local function BandWeightBias(scales, bandMin, bandMax)
	if type(FuseKernelModule) == "table" and type(FuseKernelModule.BandWeightBias) == "function" then
		local callOk, bias = pcall(FuseKernelModule.BandWeightBias, scales, bandMin, bandMax)
		if callOk and type(bias) == "number" then
			return bias
		end
	end
	local average = (scales[1] + scales[2] + scales[3]) / 3
	local biasStrength = 0.6
	if type(BalanceModule) == "table" and type(BalanceModule.Fusion) == "table" then
		biasStrength = tonumber(BalanceModule.Fusion.BIAS_STRENGTH) or biasStrength
	end
	return math.exp(
		math.log(math.max(average, 1e-6)) / math.log(2) * (math.log((bandMin + bandMax) / 2) / math.log(2)) * biasStrength
	)
end

local function PredictWeight(category, scale)
	if type(EggRecordsModule) == "table" and type(EggRecordsModule.WeightKgForScale) == "function" then
		local callOk, weight = pcall(EggRecordsModule.WeightKgForScale, category, scale)
		if callOk and type(weight) == "number" then
			return weight
		end
	end
	return nil
end

local function ReadFuseState()
	local profile = nil
	if type(SaveModule) == "table" and type(SaveModule.Peek) == "function" then
		local callOk, peeked = pcall(SaveModule.Peek, LocalPlayer)
		if callOk and type(peeked) == "table" then
			profile = peeked
		end
	end
	if type(profile) ~= "table" then
		return { Items = {}, Locked = false, Duration = 0, Reward = false }
	end

	local inventory = type(profile.Inventory) == "table" and profile.Inventory or {}
	local slots = type(profile.FusionSlots) == "table" and profile.FusionSlots or {}
	local items = {}
	for index = 1, FUSE_SLOTS do
		local uid = slots[index]
		local record = uid ~= nil and inventory[uid] or nil
		if type(record) == "table" then
			table.insert(items, {
				Category = tostring(record.Category),
				Scale = tonumber(record.Scale) or 1,
				Mutations = type(record.Mutations) == "table" and record.Mutations or {},
			})
		end
	end

	return {
		Items = items,
		Locked = profile.FusionLocked == true,
		Duration = tonumber(profile.FusionDuration) or 0,
		Reward = profile.FusionEggReward ~= nil and profile.FusionEggReward ~= false,
	}
end

local function ReadFusePrice(items)
	if #items ~= FUSE_SLOTS then
		return nil
	end
	if type(FuseKernelModule) == "table" and type(FuseKernelModule.PriceFor) == "function" then
		local callOk, price = pcall(FuseKernelModule.PriceFor, items)
		if callOk and type(price) == "number" then
			return price
		end
	end
	return nil
end

local function PredictFuse(state)
	local items = state.Items
	if #items == 0 then
		return nil
	end

	local assetInfo = ReadAssetInfo(items[1].Category)
	local scales, totalScale = {}, 0
	local mutation, mutationId = nil, nil
	local bestMultiplier = 1
	local earningRate = assetInfo and assetInfo.EarningRate or 0
	for _, item in ipairs(items) do
		table.insert(scales, item.Scale)
		totalScale = totalScale + item.Scale
		item.Income = earningRate > 0 and item.Scale > 0
				and math.max(math.floor(earningRate * ScaleFactor(item.Scale) * ReadMutationMultiplier(item.Mutations) + 0.5), 1)
			or 0
		item.MutationText = BuildMutationText(ReadMutations(item.Mutations))
		for _, rawMutation in ipairs(item.Mutations) do
			local multiplier = ReadMutationMultiplier({ rawMutation })
			if multiplier > bestMultiplier then
				bestMultiplier = multiplier
				mutation = ReadMutation(rawMutation)
				mutationId = tostring(rawMutation)
			end
		end
	end

	local prediction = {
		Items = items,
		Asset = assetInfo,
		Category = items[1].Category,
		AverageScale = totalScale / #items,
		Mutation = mutation,
		MutationId = mutationId,
		Price = ReadFusePrice(items),
		Bands = {},
		BestBand = nil,
	}

	local bands = ReadScaleBands()
	if bands and #scales == FUSE_SLOTS then
		local weighted = {}
		local totalWeight = 0
		for _, band in ipairs(bands) do
			local weight = band.weight * BandWeightBias(scales, band.min, band.max)
			totalWeight = totalWeight + weight
			table.insert(weighted, { Min = band.min, Max = band.max, Weight = weight })
		end
		for _, band in ipairs(weighted) do
			local share = totalWeight > 0 and band.Weight / totalWeight * 100 or 0
			local mutationList = mutationId and { mutationId } or {}
			local incomeMin = assetInfo and math.max(math.floor(assetInfo.EarningRate * ScaleFactor(band.Min) * ReadMutationMultiplier(mutationList) + 0.5), 1) or 0
			local incomeMax = assetInfo and math.max(math.floor(assetInfo.EarningRate * ScaleFactor(band.Max) * ReadMutationMultiplier(mutationList) + 0.5), 1) or 0
			table.insert(prediction.Bands, {
				Min = band.Min,
				Max = band.Max,
				Share = share,
				Color = ScaleBandColor(band.Min),
				WeightMin = PredictWeight(items[1].Category, band.Min),
				WeightMax = PredictWeight(items[1].Category, band.Max),
				IncomeMin = incomeMin,
				IncomeMax = incomeMax,
			})
		end
		table.sort(prediction.Bands, function(left, right)
			return left.Share > right.Share
		end)
		prediction.BestBand = prediction.Bands[1]
	end

	return prediction
end

local function FuseStatus(state, prediction)
	if state.Reward then
		return "READY TO CLAIM", 1, COLORS.Ready, true
	elseif state.Locked then
		local remaining = 0
		if state.Duration > 1000000000 then
			remaining = math.max(state.Duration - Workspace:GetServerTimeNow(), 0)
		end
		return string.format("FUSING  %s", FormatRemaining(remaining)), 1, COLORS.Growing, true
	end
	local count = prediction and #prediction.Items or 0
	if count == 0 then
		return "MACHINE EMPTY", 0, COLORS.InBag, false
	end
	return string.format("%d/%d LOADED", count, FUSE_SLOTS), count / FUSE_SLOTS, COLORS.InBag, true
end

local function CreateFusePreview(parent, theme)
	local frame = New("Frame", {
		Name = "FusePreview",
		BackgroundColor3 = theme.Surface,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Size = UDim2.new(1, -CONTAINER_PADDING * 2 - CARD_MARGIN * 2, 0, FUSE_CARD_HEIGHT),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 11) }),
	})

	local glowStroke = New("UIStroke", {
		Color = COLORS.Text,
		Thickness = 1.5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = frame,
	})
	AddShimmer(glowStroke, 0, 35)

	local art = New("Frame", {
		BackgroundColor3 = COLORS.Text,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(8, 8),
		Size = UDim2.fromOffset(FUSE_ART_SIZE, FUSE_ART_SIZE),
		Parent = frame,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 8) }),
		New("ImageLabel", {
			BackgroundTransparency = 1,
			Image = CARD_TILE_ASSET,
			ImageColor3 = COLORS.TileTint,
			ImageTransparency = 0.86,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromScale(0.34, 0.42),
			Size = UDim2.fromScale(1, 1),
		}),
	})

	local eggShadow = New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.88),
		Size = UDim2.fromScale(0.56, 0.13),
		Image = PREVIEW_SHADOW_ASSET,
		ImageColor3 = COLORS.ShadowTint,
		ImageTransparency = 0.55,
		ScaleType = Enum.ScaleType.Stretch,
		Parent = art,
	})
	eggShadow.ZIndex = 1

	local eggImage = New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.47),
		Size = UDim2.fromScale(0.78, 0.78),
		Image = BASE_EGG_ICON,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 2,
		Parent = art,
	})

	local predictionChip = New("Frame", {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(4, 4),
		Size = UDim2.fromOffset(0, 13),
		AutomaticSize = Enum.AutomaticSize.X,
		ZIndex = 4,
		Parent = art,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		New("UIPadding", {
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
		}),
		New("TextLabel", {
			Name = "Caption",
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.fromScale(0, 1),
			Text = "PREDICTED",
			TextColor3 = COLORS.Text,
			TextSize = 8,
			ZIndex = 5,
		}),
	})
	UseDisplayFont(predictionChip.Caption)

	local bodyX = 8 + FUSE_ART_SIZE + 12
	local body = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(bodyX, 8),
		Size = UDim2.new(1, -(bodyX + 8), 0, FUSE_ART_SIZE),
		Parent = frame,
	})

	local nameLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 4),
		Size = UDim2.new(1, 0, 0, 20),
		Text = "No fusion",
		TextSize = 16,
		TextColor3 = COLORS.Subtext,
	})

	local rarityLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 24),
		Size = UDim2.new(1, 0, 0, 12),
		TextSize = 9,
	})

	local mutationLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 36),
		Size = UDim2.new(1, 0, 0, 12),
		TextSize = 9,
		RichText = true,
	})

	local valueLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 49),
		Size = UDim2.new(1, 0, 0, 19),
		TextSize = 16,
	})
	PaintGradient(valueLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

	local statsRow = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 68),
		Size = UDim2.new(1, 0, 0, 13),
		Parent = body,
	}, {
		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 7),
		}),
	})

	local scaleLabel = CreateLabel(statsRow, {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 1,
		Size = UDim2.fromScale(0, 1),
		TextSize = 9,
	})
	PaintGradient(scaleLabel, "TextPaint", ColorSequence.new(COLORS.ScaleTop, COLORS.ScaleBottom), 90)

	local weightLabel = CreateLabel(statsRow, {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 2,
		Size = UDim2.fromScale(0, 1),
		TextSize = 9,
	})
	PaintGradient(weightLabel, "TextPaint", ColorSequence.new(COLORS.WeightTop, COLORS.WeightBottom), 90)

	local bar = CreateProgressBar(body, 14, 9, theme)
	bar.Track.Position = UDim2.fromOffset(0, 83)
	bar.Track.Size = UDim2.new(1, 0, 0, 14)

	return {
		Frame = frame,
		Art = art,
		Egg = eggImage,
		Chip = predictionChip,
		Update = function(state, prediction)
			local statusText, progress, colors, showChip = FuseStatus(state, prediction)
			local assetInfo = prediction and prediction.Asset or nil
			local isFusing = showChip

			bar.Gradient.Color = ColorSequence.new(colors[1], colors[2])
			bar.Fill.Size = UDim2.fromScale(progress, 1)
			bar.Text.Text = statusText
			bar.Chip.Visible = true

			predictionChip.Visible = isFusing
			eggImage.Image = assetInfo and assetInfo.EggIcon ~= "" and assetInfo.EggIcon or BASE_EGG_ICON
			eggImage.Size = assetInfo and UDim2.fromScale(0.82, 0.82) or UDim2.fromScale(0.62, 0.62)
			eggImage.ImageTransparency = assetInfo and 0 or 0.5
			eggShadow.Visible = assetInfo ~= nil

			if assetInfo then
				PaintGradient(art, "RarityPaint", BuildArtSequence(assetInfo), 90)
				nameLabel.Text = assetInfo.Name
				PaintRarityText(nameLabel, assetInfo, true)
				rarityLabel.Text = string.upper(assetInfo.Rarity)
				PaintRarityText(rarityLabel, assetInfo, false)
			else
				PaintGradient(art, "RarityPaint", ColorSequence.new(theme.Surface, theme.Surface), 90)
				nameLabel.Text = "No fusion"
				nameLabel.TextColor3 = COLORS.Subtext
				rarityLabel.Text = ""
			end

			local mutationText = prediction and prediction.Mutation and BuildMutationText({ prediction.Mutation }) or ""
			mutationLabel.Text = mutationText
			mutationLabel.Visible = mutationText ~= ""

			local bestBand = prediction and prediction.BestBand or nil
			if bestBand then
				valueLabel.Text = FormatRate(bestBand.IncomeMin) .. " ~ " .. FormatRate(bestBand.IncomeMax)
				scaleLabel.Text = string.format("%.2fx - %.2fx", bestBand.Min, bestBand.Max)
				if bestBand.WeightMin and bestBand.WeightMax then
					weightLabel.Text = string.format(
						"%s - %s",
						FormatWeight(bestBand.WeightMin),
						FormatWeight(bestBand.WeightMax)
					)
				else
					weightLabel.Text = ""
				end
			else
				valueLabel.Text = ""
				scaleLabel.Text = prediction and string.format("x%.2f", prediction.AverageScale) or ""
				local weight = prediction and PredictWeight(prediction.Category, prediction.AverageScale) or nil
				weightLabel.Text = weight and FormatWeight(weight) or ""
			end
		end,
	}
end

local function CreateFuseSlots(parent, theme)
	local holder = New("Frame", {
		Name = "FuseSlots",
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.new(1, -CONTAINER_PADDING * 2 - CARD_MARGIN * 2, 0, 0),
		Parent = parent,
	}, {
		New("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, FUSE_SLOT_GAP),
		}),
	})

	local cards = {}
	for index = 1, FUSE_SLOTS do
		local card = New("Frame", {
			Name = string.format("FuseSlot%d", index),
			BackgroundColor3 = theme.Surface,
			BackgroundTransparency = 0.1,
			BorderSizePixel = 0,
			LayoutOrder = index,
			Size = UDim2.new(1, 0, 0, FUSE_SLOT_HEIGHT),
			Parent = holder,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 9) }),
		})

		local stroke = New("UIStroke", {
			Color = theme.Border,
			Thickness = 1,
			Transparency = 0.35,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Parent = card,
		})

		AddShimmer(
			New("UIStroke", {
				Color = COLORS.Text,
				Thickness = 1,
				Transparency = 0.55,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Parent = card,
			}),
			index * 0.6
		)

		local art = New("Frame", {
			BackgroundColor3 = COLORS.Track,
			BackgroundTransparency = 0.25,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Position = UDim2.fromOffset(5, 5),
			Size = UDim2.fromOffset(FUSE_SLOT_ART, FUSE_SLOT_ART),
			Parent = card,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 6) }),
			New("ImageLabel", {
				BackgroundTransparency = 1,
				Image = CARD_TILE_ASSET,
				ImageColor3 = COLORS.TileTint,
				ImageTransparency = 0.88,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromScale(0.36, 0.44),
				Size = UDim2.fromScale(1, 1),
			}),
		})

		local petIcon = New("ImageLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.86, 0.86),
			Image = "",
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 2,
			Parent = art,
		})

		local emptyMark = CreateLabel(art, {
			Size = UDim2.fromScale(1, 1),
			Text = "+",
			TextSize = 14,
			TextColor3 = COLORS.Border,
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 2,
		})

		local slotTag = CreateLabel(card, {
			Position = UDim2.new(1, -38, 0, 5),
			Size = UDim2.fromOffset(33, 10),
			Text = string.format("SLOT %d", index),
			TextSize = 7,
			TextColor3 = COLORS.Hint,
			TextXAlignment = Enum.TextXAlignment.Right,
		})

		local nameLabel = CreateLabel(card, {
			Position = UDim2.fromOffset(FUSE_SLOT_ART + 12, 4),
			Size = UDim2.new(1, -(FUSE_SLOT_ART + 12 + 42), 0, 13),
			Text = "Empty",
			TextSize = 10,
			TextColor3 = COLORS.Subtext,
		})

		local statsRow = New("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(FUSE_SLOT_ART + 12, 17),
			Size = UDim2.new(1, -(FUSE_SLOT_ART + 12 + 8), 0, 12),
			Parent = card,
		}, {
			New("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			}),
		})

		local scaleLabel = CreateLabel(statsRow, {
			AutomaticSize = Enum.AutomaticSize.X,
			LayoutOrder = 1,
			Size = UDim2.fromScale(0, 1),
			TextSize = 8,
		})
		PaintGradient(scaleLabel, "TextPaint", ColorSequence.new(COLORS.ScaleTop, COLORS.ScaleBottom), 90)

		local incomeLabel = CreateLabel(statsRow, {
			AutomaticSize = Enum.AutomaticSize.X,
			LayoutOrder = 2,
			Size = UDim2.fromScale(0, 1),
			TextSize = 8,
		})
		PaintGradient(incomeLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

		local mutationLabel = CreateLabel(statsRow, {
			AutomaticSize = Enum.AutomaticSize.X,
			LayoutOrder = 3,
			Size = UDim2.fromScale(0, 1),
			TextSize = 8,
			RichText = true,
		})

		local hintLabel = CreateLabel(card, {
			Position = UDim2.fromOffset(FUSE_SLOT_ART + 12, 17),
			Size = UDim2.new(1, -(FUSE_SLOT_ART + 12 + 8), 0, 12),
			Text = "Add a pet to this slot",
			TextSize = 8,
			TextColor3 = COLORS.Hint,
			TextTransparency = 0.2,
		})

		local accent = New("Frame", {
			BackgroundColor3 = COLORS.Text,
			BackgroundTransparency = 0.75,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 5, 1, -3),
			Size = UDim2.new(1, -10, 0, 2),
			Parent = card,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		})

		table.insert(cards, {
			Card = card,
			Stroke = stroke,
			Art = art,
			Icon = petIcon,
			EmptyMark = emptyMark,
			SlotTag = slotTag,
			Name = nameLabel,
			Stats = statsRow,
			Scale = scaleLabel,
			Income = incomeLabel,
			Mutation = mutationLabel,
			Hint = hintLabel,
			Accent = accent,
			AccentGradient = New("UIGradient", {
				Color = ColorSequence.new(theme.Border, theme.Border),
				Parent = accent,
			}),
			Key = nil,
		})
	end

	holder.Size = UDim2.new(1, 0, 0, FUSE_SLOTS * FUSE_SLOT_HEIGHT + (FUSE_SLOTS - 1) * FUSE_SLOT_GAP)

	return {
		Frame = holder,
		Update = function(prediction)
			for index, card in ipairs(cards) do
				local item = prediction and prediction.Items[index] or nil
				local assetInfo = prediction and prediction.Asset or nil
				local key = item and (item.Category .. "|" .. tostring(item.Scale) .. "|" .. tostring(#item.Mutations)) or "empty"
				if card.Key ~= key then
					card.Key = key
					if item then
						card.Icon.Image = assetInfo and assetInfo.PetIcon or ""
						card.Icon.Visible = true
						card.EmptyMark.Visible = false
						card.Art.BackgroundTransparency = 1
						card.Name.Text = assetInfo and assetInfo.Name or item.Category
						card.Name.TextColor3 = COLORS.Text
						card.Stats.Visible = true
						card.Hint.Visible = false
						card.Scale.Text = string.format("x%.2f", item.Scale)
						card.Income.Text = FormatRate(item.Income or 0)
						local mutationText = item.MutationText or ""
						card.Mutation.Text = mutationText
						card.Mutation.Visible = mutationText ~= ""
						card.AccentGradient.Color = assetInfo and BuildArtSequence(assetInfo)
							or ColorSequence.new(theme.Border, theme.Border)
						card.Accent.BackgroundTransparency = 0.2
						card.Stroke.Color = assetInfo and assetInfo.RarityColor or theme.Border
						card.Stroke.Transparency = 0.2
					else
						card.Icon.Image = ""
						card.Icon.Visible = false
						card.EmptyMark.Visible = true
						card.Art.BackgroundTransparency = 0.25
						card.Name.Text = "Empty"
						card.Name.TextColor3 = COLORS.Subtext
						card.Stats.Visible = false
						card.Hint.Visible = true
						card.AccentGradient.Color = ColorSequence.new(theme.Border, theme.Border)
						card.Accent.BackgroundTransparency = 0.75
						card.Stroke.Color = theme.Border
						card.Stroke.Transparency = 0.35
					end
				elseif item then
					card.Income.Text = FormatRate(item.Income or 0)
				end
			end
		end,
	}
end

local function CreateFuseBands(parent, theme)
	local holder = New("Frame", {
		Name = "FuseBands",
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Size = UDim2.new(1, -CONTAINER_PADDING * 2 - CARD_MARGIN * 2, 0, 0),
		Parent = parent,
	}, {
		New("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 2),
		}),
	})

	local title = CreateLabel(holder, {
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 12),
		Text = "PREDICTED SIZE",
		TextSize = 8,
		TextColor3 = COLORS.Hint,
	})

	local rows = {}
	for index = 1, FUSE_BAND_ROWS do
		table.insert(
			rows,
			CreateLabel(holder, {
				LayoutOrder = 1 + index,
				Size = UDim2.new(1, 0, 0, 12),
				TextSize = 8,
				RichText = true,
			})
		)
	end

	local costLabel = CreateLabel(holder, {
		LayoutOrder = FUSE_BAND_ROWS + 2,
		Size = UDim2.new(1, 0, 0, 12),
		TextSize = 8,
		RichText = true,
	})

	local separator = New("Frame", {
		LayoutOrder = FUSE_BAND_ROWS + 3,
		BackgroundColor3 = COLORS.Border,
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 1),
		Parent = holder,
	})
	separator.Name = "Separator"

	holder.Size = UDim2.new(holder.Size.X.Scale, holder.Size.X.Offset, 0, 12 + FUSE_BAND_ROWS * 14 + 14 + 4)

	return {
		Frame = holder,
		Title = title,
		Update = function(prediction)
			for index, row in ipairs(rows) do
				local band = prediction and prediction.Bands[index] or nil
				if band then
					row.Visible = true
					row.Text = string.format(
						'<b><font color="#%s">%.2fx - %.2fx</font></b>  <font color="#%s">•</font>  <font color="#%s">%.1f%%</font>%s',
						band.Color:ToHex(),
						band.Min,
						band.Max,
						COLORS.Separator:ToHex(),
						COLORS.IncomeTop:ToHex(),
						band.Share,
						band.WeightMin and band.WeightMax and string.format(
							'  <font color="#%s">•</font>  <font color="#%s">%s - %s</font>',
							COLORS.Separator:ToHex(),
							COLORS.WeightTop:ToHex(),
							FormatWeight(band.WeightMin),
							FormatWeight(band.WeightMax)
						) or ""
					)
				else
					row.Visible = index == 1
					if index == 1 then
						row.Text = string.format(
							'<font color="#%s">Load %d of %d pets to see the odds</font>',
							COLORS.Hint:ToHex(),
							math.max(FUSE_SLOTS - (prediction and #prediction.Items or 0), 0),
							FUSE_SLOTS
						)
					end
				end
			end

			local price = prediction and prediction.Price or nil
			costLabel.Text = string.format(
				'<font color="#%s">Fuse Cost</font>  <b><font color="#%s">%s</font></b>',
				COLORS.Hint:ToHex(),
				COLORS.Clock:ToHex(),
				price and FormatMoney(price) or "-"
			)
		end,
	}
end

function Prediction.BuildFuse(groupbox)
	Prediction.FuseGroupbox = groupbox
	local theme = ReadTheme(groupbox)
	local container = groupbox.Container

	local preview = CreateFusePreview(container, theme)
	local slots = CreateFuseSlots(container, theme)
	local bands = CreateFuseBands(container, theme)

	groupbox:Resize()

	Prediction.FuseNextRefreshAt = 0

	Prediction.FuseConnection = RunService.Heartbeat:Connect(function()
		local now = os.clock()
		if now < Prediction.FuseNextRefreshAt then
			return
		end
		Prediction.FuseNextRefreshAt = now + 1

		local state = ReadFuseState()
		local prediction = PredictFuse(state)
		preview.Update(state, prediction)
		slots.Update(prediction)
		bands.Update(prediction)
	end)
end

local WEBHOOK_EVENTS = { "Egg Stolen", "Egg Fused", "Egg Ready" }
local WEBHOOK_STORAGE = "Onium/StealAnEgg_Webhook.json"
local WEBHOOK_POLL = 1.5
local WEBHOOK_SPACING = 1.6
local WEBHOOK_CARRY_WINDOW = 90
local WEBHOOK_SEEN_LIMIT = 4000
local WEBHOOK_THUMBNAIL_API = "https://thumbnails.roblox.com/v1/assets?assetIds=%s&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false"
local WEBHOOK_AVATAR_API = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%d&size=150x150&format=Png&isCircular=false"
local WEBHOOK_AVATAR_FALLBACK_API = "https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png"
local WEBHOOK_THUMBNAIL_AUTO_API = "https://thumbnails.roblox.com/v1/assets?assetIds=%s&size=420x420&format=Png&isCircular=false"
local WEBHOOK_ASSET_IMAGE_API = "https://www.roblox.com/asset-thumbnail/image?assetId=%s&width=420&height=420&format=png"
local WEBHOOK_ASSET_DELIVERY_API = "https://assetdelivery.roblox.com/v1/asset/?id=%s"
local WEBHOOK_ASSET_DELIVERY_V2_API = "https://assetdelivery.roblox.com/v2/assetId/%s"
local WEBHOOK_PNG_SIGNATURE = "\137PNG\r\n\26\n"
local WEBHOOK_RENDER_SIZE = 256
local WEBHOOK_JPEG_SIGNATURE = "\255\216\255"
local WEBHOOK_THUMBNAIL_TRIES = 4
local WEBHOOK_THUMBNAIL_DELAY = 1
local WEBHOOK_REPAIR_BUDGET = 120
local WEBHOOK_REPAIR_STEP = 2
local WEBHOOK_REPAIR_STEP_MAX = 10
local WEBHOOK_LOG = "[Onium Webhook]"

local Webhook = {
	Url = "",
	PingEveryone = false,
	Events = { ["Egg Stolen"] = true, ["Egg Fused"] = true, ["Egg Ready"] = true },
	MinRarity = 0,
	MinValue = 0,
	EggFilter = {},
	Queue = {},
	Sending = false,
	EggSeen = nil,
	EggSeenCount = 0,
	PenStatus = {},
	FuseRewardUid = nil,
	Carry = nil,
	ThumbnailCache = {},
	AttachmentCache = {},
	LastThumbnailError = nil,
	Repairs = {},
	Repairing = false,
	Inputs = {},
	Connection = nil,
	CarryConnection = nil,
	WarnedRequest = false,
	WarnedUrl = false,
	WarnedSave = false,
	WarnedInventory = false,
	LastTestedUrl = nil,
	PersistToken = nil,
	NextPollAt = 0,
}

Prediction.Webhook = Webhook

local function RequestFallback(options)
	local response = HttpService:RequestAsync({
		Url = options.Url,
		Method = options.Method,
		Headers = options.Headers,
		Body = options.Body,
	})
	return {
		Success = response.Success,
		StatusCode = response.StatusCode,
		Status = response.StatusCode,
		Body = response.Body,
	}
end

local function ResolveHttpRequest()
	local candidates = {}
	local function push(candidate)
		if type(candidate) == "function" then
			table.insert(candidates, candidate)
		end
	end

	if type(syn) == "table" then
		push(syn.request)
	end
	if type(fluxus) == "table" then
		push(fluxus.request)
	end
	if type(http) == "table" then
		push(http.request)
	end
	if type(krnl) == "table" then
		push(krnl.request)
	end
	push(type(http_request) == "function" and http_request or nil)
	push(type(https_request) == "function" and https_request or nil)

	local envReaders = {}
	if type(getgenv) == "function" then
		table.insert(envReaders, getgenv)
	end
	if type(getfenv) == "function" then
		table.insert(envReaders, getfenv)
	end
	for _, envReader in ipairs(envReaders) do
		local envOk, env = pcall(envReader)
		if envOk and type(env) == "table" then
			push(rawget(env, "request"))
		end
	end

	if type(HttpService.RequestAsync) == "function" then
		push(RequestFallback)
	end

	return candidates[1]
end

local function LogWebhook(message)
	print(string.format("%s %s", WEBHOOK_LOG, message))
end

local function ReadExecutorName()
	if type(identifyexecutor) == "function" then
		local callOk, name = pcall(identifyexecutor)
		if callOk and type(name) == "string" and name ~= "" then
			return name
		end
	end
	return "unknown"
end

local function NormalizeUrl(rawUrl)
	local url = tostring(rawUrl or ""):gsub("[%s`\"']", "")
	if url == "" then
		return ""
	end
	if not string.match(url, "^https?://") then
		if not string.match(url, "^[%w%-%.]+%.com/") then
			return ""
		end
		url = "https://" .. url
	end
	return url
end

local function ReadStoredWebhook()
	if type(readfile) ~= "function" or type(isfile) ~= "function" then
		return nil
	end
	local exists = pcall(isfile, WEBHOOK_STORAGE)
	if not exists then
		return nil
	end
	local callOk, raw = pcall(readfile, WEBHOOK_STORAGE)
	if not callOk or type(raw) ~= "string" or raw == "" then
		return nil
	end
	local decodeOk, data = pcall(function()
		return HttpService:JSONDecode(raw)
	end)
	if decodeOk and type(data) == "table" then
		return data
	end
	return nil
end

local function SaveWebhook()
	if type(writefile) ~= "function" then
		return
	end
	local payload = {
		Url = Webhook.Url,
		PingEveryone = Webhook.PingEveryone,
		Events = Webhook.Events,
		MinRarity = Webhook.MinRarity,
		MinValue = Webhook.MinValue,
		EggFilter = Webhook.EggFilter,
	}
	pcall(function()
		if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder("Onium") then
			makefolder("Onium")
		end
		writefile(WEBHOOK_STORAGE, HttpService:JSONEncode(payload))
	end)
end

local function ParseAmount(rawText)
	local text = tostring(rawText or ""):lower():gsub("[%s,$]", "")
	local numberText, suffix = string.match(text, "^(%-?%d+%.?%d*)([kmbtq]?)$")
	if not numberText then
		return 0
	end
	local amount = tonumber(numberText) or 0
	local multipliers = { k = 1e3, m = 1e6, b = 1e9, t = 1e12, q = 1e15 }
	return math.max(amount * (multipliers[suffix] or 1), 0)
end

local function FormatColorInt(color)
	return math.floor(color.R * 255 + 0.5) * 65536 + math.floor(color.G * 255 + 0.5) * 256 + math.floor(color.B * 255 + 0.5)
end

local function ReadInputValue(key, fallback)
	local input = Webhook.Inputs[key]
	if type(input) == "table" then
		local value = input.Value
		if type(value) == "string" then
			return value
		end
	end
	return fallback
end

local function CurrentUrl()
	local url = NormalizeUrl(ReadInputValue("Url", Webhook.Url))
	if url ~= "" then
		Webhook.Url = url
	end
	return url
end

local function CurrentMinValue()
	local raw = ReadInputValue("MinValue", nil)
	if type(raw) == "string" then
		Webhook.MinValue = ParseAmount(raw)
	end
	return Webhook.MinValue
end

local function FormatMutationDiscord(mutations)
	if type(mutations) ~= "table" or #mutations == 0 then
		return "Normal"
	end
	local parts = {}
	for _, mutation in ipairs(mutations) do
		table.insert(parts, string.format("**%s**", tostring(mutation.Label)))
	end
	return table.concat(parts, "  ·  ")
end

local function HttpCall(options)
	local requestFn = ResolveHttpRequest()
	if not requestFn then
		return nil
	end
	local callOk, response = pcall(requestFn, options)
	if not callOk or type(response) ~= "table" then
		return nil
	end
	return response
end

local function ReadStatus(response)
	return tonumber(response.StatusCode or response.Status or response.status)
end

local function DecodeJson(payload)
	local decodeOk, decoded = pcall(function()
		return HttpService:JSONDecode(tostring(payload))
	end)
	return decodeOk and type(decoded) == "table" and decoded or nil
end

local function IsPng(payload)
	return string.sub(payload, 1, 8) == WEBHOOK_PNG_SIGNATURE
end

local function IsJpeg(payload)
	return string.sub(payload, 1, 3) == WEBHOOK_JPEG_SIGNATURE
end

local function ReadThumbnailUrl(apiUrl, requireImagePath)
	local response = HttpCall({ Url = apiUrl, Method = "GET" })
	if not response then
		return nil, "request failed"
	end
	if ReadStatus(response) ~= 200 then
		return nil, "HTTP " .. tostring(ReadStatus(response))
	end
	local data = DecodeJson(response.Body)
	local entry = data and type(data.data) == "table" and data.data[1] or nil
	if type(entry) ~= "table" then
		return nil, "empty data"
	end
	if entry.state ~= "Completed" then
		return nil, "state " .. tostring(entry.state)
	end
	local imageUrl = entry.imageUrl
	if type(imageUrl) ~= "string" or imageUrl == "" then
		return nil, "empty imageUrl"
	end
	if requireImagePath and not string.find(imageUrl, "/Image/", 1, true) then
		return nil, "placeholder"
	end
	return imageUrl
end

local function ReadImageBytes(requestUrl, depth)
	if type(requestUrl) ~= "string" or requestUrl == "" or (depth or 0) > 2 then
		return nil
	end
	local response = HttpCall({ Url = requestUrl, Method = "GET" })
	if not response then
		return nil
	end
	local body = response.Body
	if type(body) ~= "string" or body == "" then
		return nil
	end
	if IsPng(body) or IsJpeg(body) then
		return body
	end
	local data = DecodeJson(body)
	local location = data and type(data.location) == "string" and data.location or nil
	if location then
		return ReadImageBytes(location, (depth or 0) + 1)
	end
	return nil
end

local function BuildAssetThumbnailSource(iconUrl)
	local assetId = string.match(tostring(iconUrl or ""), "%d+")
	if not assetId then
		return nil
	end
	return {
		Key = "asset_" .. assetId,
		AssetId = assetId,
		Apis = {
			string.format(WEBHOOK_THUMBNAIL_API, assetId),
			string.format(WEBHOOK_THUMBNAIL_AUTO_API, assetId),
		},
		Images = {
			string.format(WEBHOOK_ASSET_IMAGE_API, assetId),
			string.format(WEBHOOK_ASSET_DELIVERY_V2_API, assetId),
			string.format(WEBHOOK_ASSET_DELIVERY_API, assetId),
		},
		RequireImage = true,
	}
end

local function BuildAvatarThumbnailSource()
	local userId = tostring(LocalPlayer.UserId)
	return {
		Key = "avatar_" .. userId,
		Apis = { string.format(WEBHOOK_AVATAR_API, LocalPlayer.UserId) },
		Images = { string.format(WEBHOOK_AVATAR_FALLBACK_API, LocalPlayer.UserId) },
		RequireImage = false,
	}
end

local function ResolveThumbnailUrl(source, tries)
	if type(source) ~= "table" then
		return nil
	end
	local cached = Webhook.ThumbnailCache[source.Key]
	if cached ~= nil then
		return cached
	end

	for attempt = 1, tries or 1 do
		local lastError
		for _, apiUrl in ipairs(source.Apis) do
			local imageUrl, errorText = ReadThumbnailUrl(apiUrl, source.RequireImage)
			if imageUrl then
				Webhook.ThumbnailCache[source.Key] = imageUrl
				return imageUrl
			end
			lastError = errorText
		end
		Webhook.LastThumbnailError = lastError
		if string.find(tostring(lastError), "Blocked", 1, true) then
			return nil
		end
		if attempt < (tries or 1) then
			task.wait(WEBHOOK_THUMBNAIL_DELAY)
		end
	end
	return nil
end

local CRC_TABLE = {}
for index = 0, 255 do
	local value = index
	for _ = 1, 8 do
		if value % 2 == 1 then
			value = bit32.bxor(0xEDB88320, math.floor(value / 2))
		else
			value = math.floor(value / 2)
		end
	end
	CRC_TABLE[index] = value
end

local function Crc32(payload)
	local crc = 0xFFFFFFFF
	local length = #payload
	local index = 1
	while index <= length do
		local chunkEnd = math.min(index + 2047, length)
		for position = index, chunkEnd do
			local byte = string.byte(payload, position)
			crc = bit32.bxor(CRC_TABLE[bit32.band(bit32.bxor(crc, byte), 0xFF)], math.floor(crc / 256))
		end
		index = chunkEnd + 1
	end
	return bit32.bxor(crc, 0xFFFFFFFF)
end

local function Adler32(payload)
	local first, second = 1, 0
	local length = #payload
	local index = 1
	while index <= length do
		local chunkEnd = math.min(index + 4095, length)
		for position = index, chunkEnd do
			first = (first + string.byte(payload, position)) % 65521
			second = (second + first) % 65521
		end
		index = chunkEnd + 1
	end
	return second * 65536 + first
end

local function PackUInt32(value)
	return string.char(
		math.floor(value / 16777216) % 256,
		math.floor(value / 65536) % 256,
		math.floor(value / 256) % 256,
		value % 256
	)
end

local function PngChunk(tag, payload)
	return PackUInt32(#payload) .. tag .. payload .. PackUInt32(Crc32(tag .. payload))
end

local function DeflateStored(raw)
	local parts = { string.char(0x78, 0x01) }
	local index = 1
	local length = #raw
	while index <= length do
		local blockLength = math.min(65535, length - index + 1)
		local isFinal = (index + blockLength - 1) >= length and 1 or 0
		local low = blockLength % 256
		local high = math.floor(blockLength / 256)
		parts[#parts + 1] = string.char(isFinal, low, high, 255 - low, 255 - high)
		parts[#parts + 1] = string.sub(raw, index, index + blockLength - 1)
		index += blockLength
	end
	parts[#parts + 1] = PackUInt32(Adler32(raw))
	return table.concat(parts)
end

local function EncodePng(width, height, rows)
	local header = PackUInt32(width) .. PackUInt32(height) .. string.char(8, 6, 0, 0, 0)
	return WEBHOOK_PNG_SIGNATURE
		.. PngChunk("IHDR", header)
		.. PngChunk("IDAT", DeflateStored(table.concat(rows)))
		.. PngChunk("IEND", "")
end

local function DownscaleRows(pixels, width, height, target)
	local scaleX, scaleY = width / target, height / target
	local rows = table.create(target)
	for y = 0, target - 1 do
		local sourceY = math.min(height - 1, math.floor(y * scaleY))
		local rowOffset = sourceY * width
		local parts = table.create(target * 4 + 1)
		parts[1] = string.char(0)
		for x = 0, target - 1 do
			local sourceX = math.min(width - 1, math.floor(x * scaleX))
			local value = buffer.readu32(pixels, (rowOffset + sourceX) * 4)
			local slot = x * 4 + 2
			parts[slot] = string.char(value % 256)
			parts[slot + 1] = string.char(math.floor(value / 256) % 256)
			parts[slot + 2] = string.char(math.floor(value / 65536) % 256)
			parts[slot + 3] = string.char(math.floor(value / 16777216) % 256)
		end
		rows[y + 1] = table.concat(parts)
	end
	return rows
end

local function RenderAssetPng(assetId)
	if type(AssetService.CreateEditableImageAsync) ~= "function" then
		return nil, "executor tanpa CreateEditableImageAsync"
	end

	local created, image = pcall(function()
		return AssetService:CreateEditableImageAsync("rbxassetid://" .. assetId)
	end)
	if not created or not image then
		return nil, "render rejected: " .. tostring(image)
	end

	local size = image.Size
	local width, height = math.floor(size.X), math.floor(size.Y)
	if width <= 0 or height <= 0 then
		pcall(function()
			image:Destroy()
		end)
		return nil, "empty image size"
	end

	local readOk, pixels = pcall(function()
		return image:ReadPixelsBuffer(Vector2.zero, size)
	end)
	pcall(function()
		image:Destroy()
	end)
	if not readOk or type(pixels) ~= "buffer" then
		return nil, "ReadPixelsBuffer failed: " .. tostring(pixels)
	end
	if buffer.len(pixels) ~= width * height * 4 then
		return nil, "unsupported pixel format"
	end

	local target = math.min(WEBHOOK_RENDER_SIZE, math.max(width, height))
	return EncodePng(target, target, DownscaleRows(pixels, width, height, target))
end

local function ResolveAttachment(source)
	if type(source) ~= "table" then
		return nil
	end
	local cached = Webhook.AttachmentCache[source.Key]
	if cached ~= nil then
		return cached or nil
	end
	if source.AssetId then
		local rendered, renderError = RenderAssetPng(source.AssetId)
		if rendered then
			Webhook.AttachmentCache[source.Key] = rendered
			return rendered
		end
		Webhook.LastThumbnailError = renderError
	end

	for _, imageUrl in ipairs(source.Images) do
		local payload = ReadImageBytes(imageUrl, 0)
		if payload then
			Webhook.AttachmentCache[source.Key] = payload
			return payload
		end
	end
	Webhook.AttachmentCache[source.Key] = false
	return nil
end

local function BuildAttachment(payload)
	local name, mime = "onium_pet.png", "image/png"
	if IsJpeg(payload) then
		name, mime = "onium_pet.jpg", "image/jpeg"
	end
	return { Bytes = payload, Name = name, Mime = mime }
end

local function BuildWebhookEmbed(title, payload, source)
	local assetInfo = payload.Asset
	local avatar = ResolveThumbnailUrl(BuildAvatarThumbnailSource(), 1)
	local rarityName = string.upper(assetInfo and assetInfo.Rarity or "Common")

	local description = string.format(
		"### %s\n`%s`  ·  `%s`  ·  `%s`",
		assetInfo and assetInfo.Name or payload.Category,
		FormatRate(payload.Income),
		rarityName,
		string.format("%.2fx", payload.Scale)
	)

	local embed = {
		author = { name = string.format("%s  ·  Onium Hub", LocalPlayer.DisplayName or LocalPlayer.Name or "Player") },
		title = title,
		description = description,
		color = assetInfo and FormatColorInt(assetInfo.RarityColor) or FormatColorInt(COLORS.Text),
		fields = {
			{ name = "Income", value = string.format("`%s`", FormatRate(payload.Income)), inline = true },
			{ name = "Size", value = string.format("`%.2fx`", payload.Scale), inline = true },
			{
				name = "Weight",
				value = payload.Weight and string.format("`%s`", FormatWeight(payload.Weight)) or "`-`",
				inline = true,
			},
			{ name = "Rarity", value = string.format("`%s`", rarityName), inline = true },
			{ name = "Mutation", value = FormatMutationDiscord(payload.Mutations), inline = true },
			{ name = "Source", value = string.format("`%s`", source), inline = true },
		},
		footer = { text = "Onium Hub  ·  Steal An Egg", icon_url = avatar },
		timestamp = DateTime.now():ToIsoDate(),
	}
	if avatar then
		embed.author.icon_url = avatar
	end
	return embed
end

local function BuildAssetSourceForCategory(category)
	local assetInfo = ReadAssetInfo(category)
	if not assetInfo then
		return nil
	end
	return BuildAssetThumbnailSource(assetInfo.PetIcon) or BuildAssetThumbnailSource(assetInfo.EggIcon)
end

local function EncodePayload(payload)
	local encodeOk, encoded = pcall(function()
		return HttpService:JSONEncode(payload)
	end)
	return encodeOk and type(encoded) == "string" and encoded or nil
end

local function BuildWebhookPayload(embed, attachment)
	local payload = {
		embeds = { embed },
		allowed_mentions = { parse = { "everyone" } },
	}
	if Webhook.PingEveryone then
		payload.content = "@everyone"
	end
	local encoded = EncodePayload(payload)
	if not encoded then
		return nil
	end
	if not attachment then
		return { Headers = { ["Content-Type"] = "application/json" }, Body = encoded }
	end

	local boundary = "----OniumBoundary" .. tostring(math.random(100000, 999999))
	return {
		Headers = { ["Content-Type"] = "multipart/form-data; boundary=" .. boundary },
		Body = table.concat({
			"--" .. boundary .. "\r\n",
			'Content-Disposition: form-data; name="payload_json"\r\n',
			"Content-Type: application/json\r\n\r\n",
			encoded .. "\r\n",
			"--" .. boundary .. "\r\n",
			string.format('Content-Disposition: form-data; name="files[0]"; filename="%s"\r\n', attachment.Name),
			"Content-Type: " .. attachment.Mime .. "\r\n\r\n",
			attachment.Bytes .. "\r\n",
			"--" .. boundary .. "--\r\n",
		}, ""),
	}
end

local function SendWebhookBody(url, embed, attachment)
	local built = BuildWebhookPayload(embed, attachment)
	if not built then
		LogWebhook("failed to encode embed payload")
		return false, nil
	end

	local separator = string.find(url, "?", 1, true) and "&" or "?"
	local response = HttpCall({
		Url = url .. separator .. "wait=true",
		Method = "POST",
		Headers = built.Headers,
		Body = built.Body,
	})
	if not response then
		if not Webhook.WarnedRequest then
			Webhook.WarnedRequest = true
			LogWebhook("no http transport available, webhook cannot send")
		end
		return false, nil
	end

	local status = ReadStatus(response)
	if status ~= nil and status >= 300 then
		LogWebhook(string.format("discord rejected the message (HTTP %d): %s", status, tostring(response.Body)))
		return false, nil
	end
	return true, DecodeJson(response.Body)
end

local function PatchWebhookMessage(url, messageId, embed)
	local encoded = EncodePayload({ embeds = { embed } })
	if not encoded then
		return false
	end
	local response = HttpCall({
		Url = string.format("%s/messages/%s", url, messageId),
		Method = "PATCH",
		Headers = { ["Content-Type"] = "application/json" },
		Body = encoded,
	})
	if not response then
		return false
	end
	local status = ReadStatus(response)
	return status == nil or status < 300
end

local function AttachThumbnail(job)
	local source = job.Thumbnail
	if not job.Embed.thumbnail and type(source) == "table" then
		local imageUrl = ResolveThumbnailUrl(source, 1)
		if imageUrl then
			job.Embed.thumbnail = { url = imageUrl }
			return nil
		end
		local payload = ResolveAttachment(source)
		if payload then
			local attachment = BuildAttachment(payload)
			job.Embed.thumbnail = { url = "attachment://" .. attachment.Name }
			return attachment
		end
	end
	return nil
end

local function RepairSending()
	if Webhook.Repairing or #Webhook.Repairs == 0 then
		return
	end
	Webhook.Repairing = true
	task.spawn(function()
		while true do
			local now = os.clock()
			for index = #Webhook.Repairs, 1, -1 do
				local job = Webhook.Repairs[index]
				if now > job.Until then
					table.remove(Webhook.Repairs, index)
				elseif now >= job.NextAt then
					local imageUrl = ResolveThumbnailUrl(job.Thumbnail, 1)
					if imageUrl then
						job.Embed.thumbnail = { url = imageUrl }
						if PatchWebhookMessage(job.Base, job.MessageId, job.Embed) then
						else
							LogWebhook("failed to patch the thumbnail into the previous message")
						end
						table.remove(Webhook.Repairs, index)
					elseif string.find(tostring(Webhook.LastThumbnailError), "Blocked", 1, true) then
						LogWebhook("thumbnail blocked by roblox: " .. job.Thumbnail.Key)
						table.remove(Webhook.Repairs, index)
					else
						job.Step = math.min(job.Step * 1.6, WEBHOOK_REPAIR_STEP_MAX)
						job.NextAt = now + job.Step
					end
				end
			end
			if #Webhook.Repairs == 0 then
				break
			end
			task.wait(WEBHOOK_REPAIR_STEP)
		end
		Webhook.Repairing = false
		if #Webhook.Repairs > 0 then
			RepairSending()
		end
	end)
end

local function WebhookSending()
	if Webhook.Sending then
		return
	end
	Webhook.Sending = true
	task.spawn(function()
		while #Webhook.Queue > 0 do
			local job = table.remove(Webhook.Queue, 1)
			local url = CurrentUrl()
			if url == "" then
				if not Webhook.WarnedUrl then
					Webhook.WarnedUrl = true
					LogWebhook("webhook url is empty, fill it in the Discord Webhook group")
				end
			else
				local attachment = AttachThumbnail(job)
				local sent, message = SendWebhookBody(url, job.Embed, attachment)
				if not sent and attachment then
					job.Embed.thumbnail = nil
					attachment = nil
					sent, message = SendWebhookBody(url, job.Embed)
				end
				if not sent then
					task.wait(3)
					sent, message = SendWebhookBody(url, job.Embed, attachment)
				end
				local messageId = sent and type(message) == "table" and message.id or nil
				if job.Thumbnail and not job.Embed.thumbnail then
					if type(messageId) == "string" then
						table.insert(Webhook.Repairs, {
							Base = url,
							MessageId = messageId,
							Embed = job.Embed,
							Thumbnail = job.Thumbnail,
							Until = os.clock() + WEBHOOK_REPAIR_BUDGET,
							NextAt = os.clock() + WEBHOOK_REPAIR_STEP,
							Step = WEBHOOK_REPAIR_STEP,
						})
						RepairSending()
					end
					LogWebhook(string.format(
						"thumbnail not ready (%s) for %s",
						tostring(Webhook.LastThumbnailError),
						job.Thumbnail.Key
					))
				end
			end
			task.wait(WEBHOOK_SPACING)
		end
		Webhook.Sending = false
	end)
end

local function QueueTestEmbed()
	local url = CurrentUrl()
	if url == "" or Webhook.LastTestedUrl == url then
		return
	end
	if not string.find(url, "/api/webhooks/%d+/") then
		return
	end
	Webhook.LastTestedUrl = url

	local executor = ReadExecutorName()

	table.insert(Webhook.Queue, {
		Embed = {
			title = "Webhook Connected",
			description = string.format(
				"**Onium Hub** is connected and ready to post egg notifications.\n`%s`  ·  `%s`",
				executor,
				LocalPlayer.DisplayName or LocalPlayer.Name or "Player"
			),
			color = FormatColorInt(COLORS.IncomeTop),
			footer = { text = "Onium Hub  ·  Steal An Egg" },
			timestamp = DateTime.now():ToIsoDate(),
		},
	})
	WebhookSending()
end

local function SchedulePersist(withTest)
	if Webhook.PersistToken then
		task.cancel(Webhook.PersistToken)
	end
	Webhook.PersistToken = task.delay(1, function()
		Webhook.PersistToken = nil
		SaveWebhook()
		if withTest then
			QueueTestEmbed()
		end
	end)
end

local function EnqueueEggWebhook(eventName, category, scale, mutations, source)
	if not Webhook.Events[eventName] then
		return
	end
	if CurrentUrl() == "" then
		if not Webhook.WarnedUrl then
			Webhook.WarnedUrl = true
			LogWebhook("event captured but the url is empty, embed skipped")
		end
		return
	end
	local assetInfo = ReadAssetInfo(category)
	if next(Webhook.EggFilter) ~= nil then
		local name = assetInfo and assetInfo.Name or tostring(category)
		if Webhook.EggFilter[name] ~= true then
			return
		end
	end

	if Webhook.MinRarity > 0 and (not assetInfo or assetInfo.RarityRank < Webhook.MinRarity) then
		return
	end

	local income = 0
	if assetInfo and assetInfo.EarningRate > 0 and scale > 0 then
		income = math.max(
			math.floor(assetInfo.EarningRate * ScaleFactor(scale) * ReadMutationMultiplier(mutations) + 0.5),
			1
		)
	end
	if income < CurrentMinValue() then
		return
	end

	local payload = {
		Category = tostring(category),
		Asset = assetInfo,
		Scale = scale,
		Income = income,
		Weight = PredictWeight(category, scale),
		Mutations = ReadMutations(mutations),
	}

	task.spawn(function()
		table.insert(Webhook.Queue, {
			Embed = BuildWebhookEmbed(eventName, payload, source),
			Thumbnail = BuildAssetSourceForCategory(payload.Category),
		})
		WebhookSending()
	end)
end

local function ReadSaveProfile()
	if type(SaveModule) ~= "table" or type(SaveModule.Peek) ~= "function" then
		if not Webhook.WarnedSave then
			Webhook.WarnedSave = true
			LogWebhook("Shared.Save is unavailable, fuse and inventory events disabled")
		end
		return nil
	end
	local callOk, profile = pcall(SaveModule.Peek, LocalPlayer)
	if not callOk or type(profile) ~= "table" then
		return nil
	end
	if type(profile.Inventory) ~= "table" and type(profile.Data) == "table" then
		return profile.Data
	end
	return profile
end

local function RememberEgg(uid)
	if type(Webhook.EggSeen) ~= "table" or Webhook.EggSeen[uid] then
		return
	end
	Webhook.EggSeen[uid] = true
	Webhook.EggSeenCount += 1
end

local function PollFuseWebhook(profile)
	local reward = type(profile) == "table" and profile.FusionEggReward or nil
	if type(reward) ~= "table" then
		return
	end

	local rewardUid = reward.Uid ~= nil and tostring(reward.Uid) or nil
	if rewardUid == nil or rewardUid == Webhook.FuseRewardUid then
		return
	end
	Webhook.FuseRewardUid = rewardUid
	RememberEgg(rewardUid)

	local egg = type(reward.Egg) == "table" and reward.Egg or nil
	if egg then
		EnqueueEggWebhook(
			"Egg Fused",
			egg.AssetCategory,
			tonumber(egg.AssetScale) or 1,
			type(egg.Mutations) == "table" and egg.Mutations or {},
			"Fuse Machine"
		)
	end
end

local function AreaDisplayName(areaId)
	local directory = type(AreasModule) == "table" and type(AreasModule.Directory) == "table" and AreasModule.Directory or nil
	local entry = directory and areaId ~= nil and directory[tostring(areaId)] or nil
	return type(entry) == "table" and type(entry.DisplayName) == "string" and entry.DisplayName or nil
end

local function NoteCarry(carryState)
	if type(carryState) ~= "table" or carryState.IsCarrying ~= true then
		return
	end
	Webhook.Carry = {
		Uid = carryState.Uid ~= nil and tostring(carryState.Uid) or nil,
		Category = carryState.AssetCategory ~= nil and tostring(carryState.AssetCategory) or nil,
		Area = AreaDisplayName(carryState.AreaId),
		At = os.clock(),
	}
end

local function EggSource(uid, category)
	local carry = Webhook.Carry
	if type(carry) ~= "table" then
		return "Egg Inventory"
	end
	if os.clock() - carry.At > WEBHOOK_CARRY_WINDOW then
		Webhook.Carry = nil
		return "Egg Inventory"
	end
	if carry.Uid ~= uid and (carry.Category == nil or carry.Category ~= category) then
		return "Egg Inventory"
	end
	Webhook.Carry = nil
	return carry.Area or "Field"
end

local function PollEggInventoryWebhook(profile)
	local eggInventory = type(profile) == "table" and type(profile.EggInventory) == "table" and profile.EggInventory or nil
	if not eggInventory then
		if type(profile) == "table" and not Webhook.WarnedInventory then
			Webhook.WarnedInventory = true
			LogWebhook("EggInventory is missing from the profile, egg events disabled")
		end
		return
	end

	if Webhook.EggSeen == nil then
		Webhook.EggSeen = {}
		for uid in pairs(eggInventory) do
			RememberEgg(tostring(uid))
		end
		LogWebhook(string.format("tracking %d existing eggs, only new eggs will be posted", Webhook.EggSeenCount))
		return
	end

	for uid, record in pairs(eggInventory) do
		local uidText = tostring(uid)
		if type(record) == "table" and not Webhook.EggSeen[uidText] then
			RememberEgg(uidText)
			if uidText ~= Webhook.FuseRewardUid then
				local category = tostring(record.AssetCategory)
				EnqueueEggWebhook(
					"Egg Stolen",
					category,
					tonumber(record.AssetScale) or 1,
					type(record.Mutations) == "table" and record.Mutations or {},
					EggSource(uidText, category)
				)
			end
		end
	end

	if Webhook.EggSeenCount > WEBHOOK_SEEN_LIMIT then
		Webhook.EggSeen = {}
		Webhook.EggSeenCount = 0
		for uid in pairs(eggInventory) do
			RememberEgg(tostring(uid))
		end
	end
end

local function PollPenWebhook()
	if not Webhook.Events["Egg Ready"] then
		return
	end
	for _, entry in ipairs(ReadEntries()) do
		local previous = Webhook.PenStatus[entry.Id]
		Webhook.PenStatus[entry.Id] = entry.Status
		if previous == "Growing" and entry.Status == "Ready" then
			EnqueueEggWebhook("Egg Ready", entry.Category, entry.Scale, {}, "Pen")
		end
	end
end

local function PollWebhook()
	local profile = ReadSaveProfile()
	PollFuseWebhook(profile)
	PollEggInventoryWebhook(profile)
	PollPenWebhook()
end

local function ReadRarityOptions()
	local byRank = {}
	if type(AssetsModule) == "table" and type(AssetsModule.Directory) == "table" then
		for _, assetInfo in pairs(AssetsModule.Directory) do
			local rarity = type(assetInfo) == "table" and type(assetInfo.Rarity) == "table" and assetInfo.Rarity or nil
			if rarity then
				local rank = tonumber(rarity.RarityNumber or rarity.Rank)
				local name = tostring(rarity.DisplayName or rarity._id or "")
				if rank and name ~= "" and byRank[rank] == nil then
					byRank[rank] = name
				end
			end
		end
	end

	local ranks = {}
	for rank in pairs(byRank) do
		table.insert(ranks, rank)
	end
	table.sort(ranks)

	local values, rankByName = { "All" }, { All = 0 }
	for _, rank in ipairs(ranks) do
		local name = byRank[rank]
		table.insert(values, name)
		rankByName[name] = rank
	end
	return values, rankByName
end

local function ReadEggOptions()
	local options = {}
	if type(AssetsModule) == "table" and type(AssetsModule.Directory) == "table" then
		for category, assetInfo in pairs(AssetsModule.Directory) do
			if type(assetInfo) == "table" then
				local rarity = type(assetInfo.Rarity) == "table" and assetInfo.Rarity or {}
				table.insert(options, {
					Name = tostring(assetInfo.DisplayName or category),
					Rank = tonumber(rarity.RarityNumber or rarity.Rank) or 0,
				})
			end
		end
	end
	table.sort(options, function(left, right)
		if left.Rank ~= right.Rank then
			return left.Rank > right.Rank
		end
		return left.Name < right.Name
	end)

	local names, seen = {}, {}
	for _, option in ipairs(options) do
		if not seen[option.Name] then
			seen[option.Name] = true
			table.insert(names, option.Name)
		end
	end
	return names
end

function Prediction.BuildWebhook(groupbox)
	local stored = ReadStoredWebhook()
	if type(stored) == "table" then
		Webhook.Url = NormalizeUrl(stored.Url)
		Webhook.PingEveryone = stored.PingEveryone == true
		Webhook.MinRarity = tonumber(stored.MinRarity) or 0
		Webhook.MinValue = tonumber(stored.MinValue) or 0
		if type(stored.Events) == "table" then
			for _, eventName in ipairs(WEBHOOK_EVENTS) do
				Webhook.Events[eventName] = stored.Events[eventName] == true
			end
		end
		if type(stored.EggFilter) == "table" then
			Webhook.EggFilter = stored.EggFilter
		end
	end

	local rarityValues, rarityRanks = ReadRarityOptions()
	local rarityDefault = "All"
	for _, rarityName in ipairs(rarityValues) do
		if Webhook.MinRarity > 0 and rarityRanks[rarityName] == Webhook.MinRarity then
			rarityDefault = rarityName
		end
	end

	local selectedEvents = {}
	for _, eventName in ipairs(WEBHOOK_EVENTS) do
		if Webhook.Events[eventName] then
			table.insert(selectedEvents, eventName)
		end
	end

	Webhook.Inputs.Url = groupbox:AddInput("Input_Webhook_Url", {
		Text = "Webhook URL",
		Placeholder = "https://discord.com/api/webhooks/...",
		Default = Webhook.Url,
		ClearTextOnFocus = false,
		Tooltip = "Discord webhook that receives the egg embed",
		Callback = function(value)
			Webhook.Url = NormalizeUrl(value)
			Webhook.WarnedUrl = false
			SchedulePersist(true)
		end,
	})

	groupbox:AddToggle("Toggle_Webhook_Ping", {
		Text = "Ping @Everyone",
		Default = Webhook.PingEveryone,
		Tooltip = "Adds @everyone in front of the embed",
		Callback = function(isEnabled)
			Webhook.PingEveryone = isEnabled == true
			SaveWebhook()
		end,
	})

	groupbox:AddDropdown("Dropdown_Webhook_NotifyOn", {
		Text = "Notify On",
		Values = WEBHOOK_EVENTS,
		Multi = true,
		Default = selectedEvents,
		Tooltip = "Which events post to the webhook",
		Callback = function(selected)
			for _, eventName in ipairs(WEBHOOK_EVENTS) do
				Webhook.Events[eventName] = false
			end
			for _, eventName in ipairs(selected or {}) do
				Webhook.Events[eventName] = true
			end
			SaveWebhook()
		end,
	})

	groupbox:AddDropdown("Dropdown_Webhook_MinRarity", {
		Text = "Webhook Min Rarity",
		Values = rarityValues,
		Default = rarityDefault,
		Tooltip = "Only post eggs of this rarity and above",
		Callback = function(selected)
			Webhook.MinRarity = rarityRanks[selected] or 0
			SaveWebhook()
		end,
	})

	Webhook.Inputs.MinValue = groupbox:AddInput("Input_Webhook_MinValue", {
		Text = "Webhook Min Value",
		Placeholder = "0",
		Default = Webhook.MinValue > 0 and tostring(math.floor(Webhook.MinValue)) or "",
		ClearTextOnFocus = false,
		Tooltip = "Minimum income per second, accepts 250k, 50m, 1.5b",
		Callback = function(value)
			Webhook.MinValue = ParseAmount(value)
			SchedulePersist(false)
		end,
	})

	local eggValues = ReadEggOptions()
	local selectedEggs = {}
	for _, eggName in ipairs(eggValues) do
		if Webhook.EggFilter[eggName] then
			table.insert(selectedEggs, eggName)
		end
	end

	groupbox:AddDropdown("Dropdown_Webhook_Eggs", {
		Text = "Webhook Eggs",
		Values = eggValues,
		Multi = true,
		Default = selectedEggs,
		Tooltip = "Only post these eggs, empty means all eggs",
		Callback = function(selected)
			Webhook.EggFilter = {}
			for _, eggName in ipairs(selected or {}) do
				Webhook.EggFilter[eggName] = true
			end
			SaveWebhook()
		end,
	})

	if type(EggStateModule) == "table" and type(EggStateModule.CarryChanged) == "table" then
		local connectOk, carryConnection = pcall(function()
			return EggStateModule.CarryChanged:Connect(NoteCarry)
		end)
		if connectOk then
			Webhook.CarryConnection = carryConnection
		end
	end

	LogWebhook(string.format(
		"ready · executor=%s · transport=%s · url=%s",
		ReadExecutorName(),
		ResolveHttpRequest() and "ok" or "missing",
		CurrentUrl() ~= "" and "saved" or "empty"
	))

	Webhook.NextPollAt = os.clock() + WEBHOOK_POLL
	Webhook.Connection = RunService.Heartbeat:Connect(function()
		local now = os.clock()
		if now < Webhook.NextPollAt then
			return
		end
		Webhook.NextPollAt = now + WEBHOOK_POLL
		local pollOk, pollError = pcall(PollWebhook)
		if not pollOk then
			LogWebhook("poll error: " .. tostring(pollError))
		end
	end)
end

function Prediction.Stop()
	if Prediction.Connection then
		Prediction.Connection:Disconnect()
		Prediction.Connection = nil
	end
	if Prediction.FuseConnection then
		Prediction.FuseConnection:Disconnect()
		Prediction.FuseConnection = nil
	end
	if Prediction.Webhook and Prediction.Webhook.Connection then
		Prediction.Webhook.Connection:Disconnect()
		Prediction.Webhook.Connection = nil
	end
	if Prediction.Webhook and Prediction.Webhook.CarryConnection then
		Prediction.Webhook.CarryConnection:Disconnect()
		Prediction.Webhook.CarryConnection = nil
	end
	if Prediction.Webhook then
		table.clear(Prediction.Webhook.Queue)
		table.clear(Prediction.Webhook.Repairs)
	end
end

return Prediction
