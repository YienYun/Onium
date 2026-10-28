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
local SaveModule = RequireGameModule("Shared", "Save")
local FuseKernelModule = RequireGameModule("Shared", "Util", "FuseKernel")
local BalanceModule = RequireGameModule("Shared", "Flags", "GameplayBalance")

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
local PREVIEW_HEIGHT = 132
local PREVIEW_ART_SIZE = 116
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
local GRID_GAP = 7
local MIN_CARD_WIDTH = 126
local CARD_MARGIN = 3
local VISIBLE_ROWS = 2
local PREVIEW_HEIGHT = 122
local PREVIEW_ART_SIZE = 106
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
	local inset = 5
	local contentWidth = cardWidth - inset * 2
	local artHeight = math.floor(contentWidth * 0.62)

	local nameSize = math.clamp(math.floor(cardWidth * 0.096 + 0.5), 10, 14)
	local raritySize = math.clamp(math.floor(cardWidth * 0.062 + 0.5), 8, 9)
	local valueSize = math.clamp(math.floor(cardWidth * 0.100 + 0.5), 11, 15)
	local statsSize = math.clamp(math.floor(cardWidth * 0.062 + 0.5), 8, 9)
	local barSize = math.clamp(math.floor(cardWidth * 0.060 + 0.5), 8, 9)
	local mutationSize = math.clamp(raritySize, 8, 9)

	local nameHeight = nameSize + 4
	local rarityHeight = raritySize + 3
	local valueHeight = valueSize + 4
	local statsHeight = statsSize + 4
	local barHeight = math.max(12, barSize + 4)

	local artY = inset
	local nameY = artY + artHeight + 3
	local rarityY = nameY + nameHeight - 1
	local valueY = rarityY + rarityHeight
	local statsY = valueY + valueHeight - 1
	local barY = statsY + statsHeight + 1

	return {
		Width = cardWidth,
		Height = barY + barHeight + inset,
		Inset = inset,
		ContentWidth = contentWidth,
		ArtWidth = contentWidth,
		ArtHeight = artHeight,
		ArtY = artY,
		Badge = math.max(20, math.floor(contentWidth * 0.19)),
		NameSize = nameSize,
		NameY = nameY,
		NameHeight = nameHeight,
		RaritySize = raritySize,
		RarityY = rarityY,
		RarityHeight = rarityHeight,
		ValueSize = valueSize,
		ValueY = valueY,
		ValueHeight = valueHeight,
		StatsSize = statsSize,
		StatsY = statsY,
		StatsHeight = statsHeight,
		BarSize = barSize,
		BarY = barY,
		BarHeight = barHeight,
		MutationSize = mutationSize,
	}
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

	local card = New("Frame", {
		Name = "PredictorCard",
		BackgroundColor3 = theme.Surface,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(CARD_MARGIN, CARD_MARGIN),
		Size = UDim2.fromOffset(metrics.Width, metrics.Height),
		Parent = cell,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 9) }),
	})

	local baseStroke = New("UIStroke", {
		Color = theme.Border,
		Thickness = 1,
		Transparency = 0.25,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = card,
	})

	local shimmerStroke = New("UIStroke", {
		Color = COLORS.Text,
		Thickness = 1.3,
		Transparency = 0.2,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = card,
	})
	AddShimmer(shimmerStroke, index * 0.6)

	CreateArtBox(
		card,
		entry,
		UDim2.fromOffset(metrics.Inset, metrics.ArtY),
		UDim2.fromOffset(metrics.ArtWidth, metrics.ArtHeight),
		metrics.Badge,
		theme,
		false
	)

	local mutationLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset + math.floor(metrics.ContentWidth * 0.34), metrics.ArtY + 3),
		Size = UDim2.new(0, math.floor(metrics.ContentWidth * 0.64), 0, 12),
		Text = entry.MutationText,
		TextSize = metrics.MutationSize,
		TextXAlignment = Enum.TextXAlignment.Right,
		RichText = true,
		Visible = entry.MutationText ~= "",
		ZIndex = 6,
	})

	local nameLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.NameY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.NameHeight),
		Text = entry.Name,
		TextSize = metrics.NameSize,
	})
	PaintRarityText(nameLabel, entry, true)

	local rarityLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.RarityY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.RarityHeight),
		Text = string.upper(entry.Rarity),
		TextSize = metrics.RaritySize,
	})
	PaintRarityText(rarityLabel, entry, false)

	local valueLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.ValueY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.ValueHeight),
		Text = FormatRate(entry.Income),
		TextSize = metrics.ValueSize,
	})
	PaintGradient(valueLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

	local statsRow = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(metrics.Inset, metrics.StatsY),
		Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.StatsHeight),
		Parent = card,
	}, {
		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 5),
		}),
	})

	local scaleLabel = CreateLabel(statsRow, {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 1,
		Size = UDim2.fromScale(0, 1),
		Text = string.format("x%.2f", entry.Scale),
		TextSize = metrics.StatsSize,
	})
	PaintGradient(scaleLabel, "TextPaint", ColorSequence.new(COLORS.ScaleTop, COLORS.ScaleBottom), 90)

	local weightLabel = CreateLabel(statsRow, {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 2,
		Size = UDim2.fromScale(0, 1),
		Text = FormatWeight(entry.Weight),
		TextSize = metrics.StatsSize,
	})
	PaintGradient(weightLabel, "TextPaint", ColorSequence.new(COLORS.WeightTop, COLORS.WeightBottom), 90)

	local bar = CreateProgressBar(card, metrics.BarHeight, metrics.BarSize, theme)
	bar.Track.Position = UDim2.fromOffset(metrics.Inset, metrics.BarY)
	bar.Track.Size = UDim2.new(0, metrics.ContentWidth, 0, metrics.BarHeight)
	ApplyStatusFill(bar, entry)

	local selection = New("UIStroke", {
		Color = COLORS.Text,
		Thickness = 2.2,
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
		ZIndex = 7,
		Parent = card,
	})

	button.MouseEnter:Connect(function()
		baseStroke.Color = theme.Hover
		baseStroke.Transparency = 0
	end)

	button.MouseLeave:Connect(function()
		baseStroke.Color = theme.Border
		baseStroke.Transparency = 0.25
	end)

	button.MouseButton1Click:Connect(function()
		Prediction.SelectedId = entry.Id
		Prediction.SelectCard()
		if Prediction.Preview then
			Prediction.Preview.Update(entry)
		end
	end)

	return {
		Frame = cell,
		Selection = selection,
		Update = function(current)
			valueLabel.Text = FormatRate(current.Income)
			scaleLabel.Text = string.format("x%.2f", current.Scale)
			weightLabel.Text = FormatWeight(current.Weight)
			if mutationLabel.Text ~= current.MutationText then
				mutationLabel.Text = current.MutationText
				mutationLabel.Visible = current.MutationText ~= ""
			end
			ApplyStatusFill(bar, current)
		end,
	}
end

local function CreatePreview(parent, theme)
	local frame = New("Frame", {
		Name = "PredictorPreview",
		BackgroundColor3 = theme.Surface,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Size = UDim2.new(1, -CONTAINER_PADDING * 2, 0, PREVIEW_HEIGHT),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 11) }),
	})

	local glowStroke = New("UIStroke", {
		Color = COLORS.Text,
		Thickness = 1.5,
		Transparency = 0.15,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = frame,
	})
	AddShimmer(glowStroke, 0, 35)

	local artBox = CreateArtBox(
		frame,
		{ PetIcon = "", EggIcon = "", Rarity = "Common", RarityColor = COLORS.Text, Gradient = nil, MutationText = "" },
		UDim2.fromOffset(8, 8),
		UDim2.fromOffset(PREVIEW_ART_SIZE, PREVIEW_ART_SIZE),
		26,
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
		Size = UDim2.fromScale(1.9, 1.9),
		Image = PREVIEW_RAYS_ASSET,
		ImageColor3 = COLORS.Text,
		ImageTransparency = 0.24,
		ScaleType = Enum.ScaleType.Fit,
		Parent = artBox.Frame,
	})
	rays.ZIndex = 1

	local bodyX = 8 + PREVIEW_ART_SIZE + 12
	local body = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(bodyX, 8),
		Size = UDim2.new(1, -(bodyX + 8), 0, PREVIEW_ART_SIZE),
		Parent = frame,
	})

	local nameLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 6),
		Size = UDim2.new(1, 0, 0, 20),
		Text = "No egg",
		TextSize = 16,
		TextColor3 = COLORS.Subtext,
	})

	local mutationLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 26),
		Size = UDim2.new(1, 0, 0, 12),
		TextSize = 9,
		RichText = true,
	})

	local rarityLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 38),
		Size = UDim2.new(1, 0, 0, 12),
		TextSize = 9,
	})

	local valueLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 51),
		Size = UDim2.new(1, 0, 0, 20),
		TextSize = 17,
	})
	PaintGradient(valueLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

	local statsRow = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 71),
		Size = UDim2.new(1, 0, 0, 14),
		Parent = body,
	}, {
		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		}),
	})

	local scaleLabel = CreateLabel(statsRow, {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 1,
		Size = UDim2.fromScale(0, 1),
		TextSize = 10,
	})
	PaintGradient(scaleLabel, "TextPaint", ColorSequence.new(COLORS.ScaleTop, COLORS.ScaleBottom), 90)

	local weightLabel = CreateLabel(statsRow, {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 2,
		Size = UDim2.fromScale(0, 1),
		TextSize = 10,
	})
	PaintGradient(weightLabel, "TextPaint", ColorSequence.new(COLORS.WeightTop, COLORS.WeightBottom), 90)

	local bar = CreateProgressBar(body, 14, 9, theme)
	bar.Track.Position = UDim2.fromOffset(0, 87)
	bar.Track.Size = UDim2.new(1, 0, 0, 14)

	local preview = {
		Frame = frame,
		Art = artBox.Frame,
		Rays = rays,
		Key = nil,
	}

	function preview.Update(entry)
		if not entry then
			preview.Key = nil
			nameLabel.Text = "No egg"
			nameLabel.TextColor3 = COLORS.Subtext
			mutationLabel.Text = ""
			rarityLabel.Text = ""
			valueLabel.Text = ""
			scaleLabel.Text = ""
			weightLabel.Text = ""
			artBox.Pet.Image = ""
			artBox.Egg.Image = ""
			PaintGradient(artBox.Frame, "RarityPaint", ColorSequence.new(theme.Surface, theme.Surface), 90)
			ApplyStatusFill(bar, nil)
			return
		end

		local key = entry.Id .. "|" .. entry.Rarity .. "|" .. entry.Name .. "|" .. entry.MutationText
		if preview.Key ~= key then
			preview.Key = key
			artBox.Pet.Image = entry.PetIcon
			artBox.Egg.Image = entry.EggIcon
			artBox.BadgeStroke.Color = entry.RarityColor
			PaintGradient(artBox.Frame, "RarityPaint", BuildArtSequence(entry), 90)
			nameLabel.Text = entry.Name
			PaintRarityText(nameLabel, entry, true)
			mutationLabel.Text = entry.MutationText
			rarityLabel.Text = string.upper(entry.Rarity)
			PaintRarityText(rarityLabel, entry, false)
		end

		valueLabel.Text = FormatRate(entry.Income)
		scaleLabel.Text = string.format("x%.2f", entry.Scale)
		weightLabel.Text = FormatWeight(entry.Weight)
		ApplyStatusFill(bar, entry)
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
	local columns = math.clamp(math.floor((usable + GRID_GAP) / (MIN_CARD_WIDTH + GRID_GAP)), 1, 4)
	local cellWidth = math.floor((usable - GRID_GAP * (columns - 1)) / columns)
	local metrics = CardMetrics(cellWidth - CARD_MARGIN * 2)
	local cellHeight = metrics.Height + CARD_MARGIN * 2

	ClearCards()
	PruneShimmers()
	Prediction.Grid.CellSize = UDim2.fromOffset(cellWidth, cellHeight)
	Prediction.Grid.CellPadding = UDim2.fromOffset(GRID_GAP, GRID_GAP)

	local rows = math.ceil(#entries / columns)
	local visibleRows = math.max(1, math.min(rows, VISIBLE_ROWS))
	scroll.Size = UDim2.new(
		1,
		-CONTAINER_PADDING * 2 - CARD_MARGIN * 2,
		0,
		visibleRows * cellHeight + math.max(0, visibleRows - 1) * GRID_GAP
	)
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

function Prediction.SetCardVisible(visible)
	if Prediction.Preview then
		Prediction.Preview.Frame.Visible = visible == true
		if Prediction.Groupbox then
			Prediction.Groupbox:Resize()
		end
	end
end

function Prediction.Build(groupbox)
	Prediction.Groupbox = groupbox
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

	Prediction.Preview = CreatePreview(container, Prediction.Theme)
	CreateFilterBar(container, Prediction.Theme)

	Prediction.ListFrame = New("ScrollingFrame", {
		Name = "PredictorList",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = 4,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Prediction.Theme.Border,
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, -CONTAINER_PADDING * 2 - CARD_MARGIN * 2, 0, 0),
		Parent = container,
	})

	Prediction.Grid = New("UIGridLayout", {
		CellSize = UDim2.fromOffset(MIN_CARD_WIDTH + CARD_MARGIN * 2, 171),
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
		Prediction.Preview.Update(selectedEntry or visible[1])
	end)
end

local FUSE_SLOTS = 3
local FUSE_CARD_HEIGHT = 132
local FUSE_ART_SIZE = 100
local FUSE_SLOT_HEIGHT = 62
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
	for _, item in ipairs(items) do
		table.insert(scales, item.Scale)
		totalScale = totalScale + item.Scale
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
			eggImage.Size = isFusing and UDim2.fromScale(0.82, 0.82) or UDim2.fromScale(0.66, 0.66)

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
		Size = UDim2.new(1, -CONTAINER_PADDING * 2 - CARD_MARGIN * 2, 0, FUSE_SLOT_HEIGHT),
		Parent = parent,
	}, {
		New("UIGridLayout", {
			CellSize = UDim2.new(1 / 3, -4, 0, FUSE_SLOT_HEIGHT - CARD_MARGIN * 2),
			CellPadding = UDim2.fromOffset(4, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local cards = {}
	for index = 1, FUSE_SLOTS do
		local card = New("Frame", {
			BackgroundColor3 = theme.Surface,
			BackgroundTransparency = 0.1,
			BorderSizePixel = 0,
			LayoutOrder = index,
			Size = UDim2.fromOffset(90, FUSE_SLOT_HEIGHT - CARD_MARGIN * 2),
			Parent = holder,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 8) }),
			New("UIStroke", {
				Color = theme.Border,
				Thickness = 1,
				Transparency = 0.3,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			}),
		})

		New("Frame", {
			BackgroundColor3 = COLORS.Track,
			BackgroundTransparency = 0.3,
			BorderSizePixel = 0,
			Position = UDim2.fromOffset(4, 4),
			Size = UDim2.fromOffset(26, 26),
			Parent = card,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 6) }),
			New("ImageLabel", {
				Name = "Icon",
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(0.86, 0.86),
				Image = "",
				ScaleType = Enum.ScaleType.Fit,
			}),
		})

		local slotLabel = CreateLabel(card, {
			Position = UDim2.fromOffset(4, 3),
			Size = UDim2.new(1, -8, 0, 10),
			Text = string.format("SLOT %d", index),
			TextSize = 8,
			TextColor3 = COLORS.Subtext,
			TextXAlignment = Enum.TextXAlignment.Right,
		})

		local nameLabel = CreateLabel(card, {
			Position = UDim2.fromOffset(33, 6),
			Size = UDim2.new(1, -37, 0, 12),
			TextSize = 9,
		})

		local detailLabel = CreateLabel(card, {
			Position = UDim2.fromOffset(4, 33),
			Size = UDim2.new(1, -8, 0, 11),
			TextSize = 8,
			RichText = true,
		})

		local incomeLabel = CreateLabel(card, {
			Position = UDim2.fromOffset(4, 44),
			Size = UDim2.new(1, -8, 0, 11),
			TextSize = 8,
		})
		PaintGradient(incomeLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

		table.insert(cards, {
			Frame = card,
			Icon = card:FindFirstChild("Icon", true),
			Slot = slotLabel,
			Name = nameLabel,
			Detail = detailLabel,
			Income = incomeLabel,
		})
	end

	return {
		Frame = holder,
		Update = function(prediction)
			for index, card in ipairs(cards) do
				local item = prediction and prediction.Items[index] or nil
				if item then
					local assetInfo = prediction.Asset
					card.Icon.Image = assetInfo and assetInfo.PetIcon or ""
					card.Name.Text = assetInfo and assetInfo.Name or item.Category
					card.Name.TextColor3 = COLORS.Text
					local mutationText = BuildMutationText(ReadMutations(item.Mutations))
					card.Detail.Text = string.format(
						'<font color="#%s">%.2fx</font>%s',
						COLORS.ScaleTop:ToHex(),
						item.Scale,
						mutationText ~= "" and ("  " .. mutationText) or ""
					)
					local income = 0
					if assetInfo then
						income = math.max(
							math.floor(
								assetInfo.EarningRate * ScaleFactor(item.Scale) * ReadMutationMultiplier(item.Mutations) + 0.5
							),
							1
						)
					end
					card.Income.Text = FormatRate(income)
				else
					card.Icon.Image = ""
					card.Name.Text = "Empty"
					card.Name.TextColor3 = COLORS.Subtext
					card.Detail.Text = ""
					card.Income.Text = ""
				end
				card.Slot.Text = string.format("SLOT %d", index)
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

function Prediction.Stop()
	if Prediction.Connection then
		Prediction.Connection:Disconnect()
		Prediction.Connection = nil
	end
	if Prediction.FuseConnection then
		Prediction.FuseConnection:Disconnect()
		Prediction.FuseConnection = nil
	end
end

return Prediction
