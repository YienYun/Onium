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
				income = math.max(math.floor(earningRate * ScaleFactor(scaleValue) * ReadMutationMultiplier(eggData.Mutations) + 0.5), 1)
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

local function StatusText(entry)
	if entry.Status == "Ready" then
		return "READY"
	elseif entry.Status == "Growing" then
		return FormatRemaining(entry.Remaining) .. "  " .. entry.Percent .. "%"
	end
	return "IN BAG"
end

local function ApplyStatusFill(bar, entry)
	local colors = COLORS.InBag
	if entry.Status == "Ready" then
		colors = COLORS.Ready
	elseif entry.Status == "Growing" then
		colors = COLORS.Growing
	end
	bar.Gradient.Color = ColorSequence.new(colors[1], colors[2])
	local alpha = 1
	if entry.Status == "Growing" then
		alpha = math.clamp(entry.Percent / 100, 0.04, 1)
	end
	bar.Fill.Size = UDim2.fromScale(alpha, 1)
	bar.Text.Text = StatusText(entry)
end

local function CreateProgressBar(parent, height, textSize)
	local track = New("Frame", {
		BackgroundColor3 = COLORS.Track,
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Size = UDim2.new(1, 0, 0, height),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		New("UIStroke", {
			Color = Color3.new(0, 0, 0),
			Thickness = 1.4,
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
		BackgroundTransparency = 0.78,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0, 0.08),
		Size = UDim2.fromScale(1, 0.34),
		Parent = fill,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
	})

	local label = CreateLabel(track, {
		Size = UDim2.fromScale(1, 1),
		TextSize = textSize,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 3,
	})
	New("UIStroke", {
		Color = Color3.new(0, 0, 0),
		Thickness = math.max(1, textSize * 0.12),
		LineJoinMode = Enum.LineJoinMode.Round,
		Parent = label,
	})

	return {
		Track = track,
		Fill = fill,
		Gradient = gradient,
		Text = label,
	}
end

local function CardMetrics(cardWidth)
	local inset = 6
	local nameSize = math.clamp(math.floor(cardWidth * 0.105 + 0.5), 12, 18)
	local raritySize = math.clamp(math.floor(cardWidth * 0.072 + 0.5), 9, 12)
	local valueSize = math.clamp(math.floor(cardWidth * 0.113 + 0.5), 13, 20)
	local statsSize = math.clamp(math.floor(cardWidth * 0.078 + 0.5), 9, 13)
	local barSize = math.clamp(math.floor(cardWidth * 0.074 + 0.5), 9, 12)

	local art = cardWidth - inset * 2
	local nameHeight = nameSize + 3
	local rarityHeight = raritySize + 2
	local valueHeight = valueSize + 3
	local statsHeight = statsSize + 2
	local barHeight = math.max(14, barSize + 5)

	local nameY = inset + art + 5
	local rarityY = nameY + nameHeight
	local valueY = rarityY + rarityHeight + 1
	local statsY = valueY + valueHeight + 1
	local barY = statsY + statsHeight + 3

	return {
		Width = cardWidth,
		Height = barY + barHeight + inset,
		Inset = inset,
		Art = art,
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
	}
end

local function CreateCardArt(parent, entry, metrics)
	local art = New("Frame", {
		BackgroundColor3 = COLORS.Text,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(metrics.Inset, metrics.Inset),
		Size = UDim2.fromOffset(metrics.Art, metrics.Art),
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
		New("ImageLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.52),
			Size = UDim2.fromScale(0.88, 0.88),
			Image = entry.Icon,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 2,
		}),
		New("Frame", {
			BackgroundColor3 = COLORS.Text,
			BackgroundTransparency = 0.9,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
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
	})
	PaintGradient(art, "RarityPaint", BuildArtSequence(entry), 90)
	return art
end

local function CreateCard(parent, entry, metrics, index)
	local card = New("Frame", {
		Name = "PredictorCard",
		BackgroundColor3 = COLORS.Card,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		LayoutOrder = index,
		Size = UDim2.fromOffset(metrics.Width, metrics.Height),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 9) }),
		New("UIStroke", {
			Color = COLORS.Border,
			Thickness = 1.2,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}),
	})

	CreateCardArt(card, entry, metrics)

	local textWidth = UDim.new(1, -metrics.Inset * 2)
	local nameLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.NameY),
		Size = UDim2.new(textWidth.Scale, textWidth.Offset, 0, metrics.NameHeight),
		Text = entry.Name,
		TextSize = metrics.NameSize,
	})
	PaintRarityText(nameLabel, entry, true)

	local rarityLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.RarityY),
		Size = UDim2.new(textWidth.Scale, textWidth.Offset, 0, metrics.RarityHeight),
		Text = string.upper(entry.Rarity),
		TextSize = metrics.RaritySize,
	})
	PaintRarityText(rarityLabel, entry, false)

	local valueLabel = CreateLabel(card, {
		Position = UDim2.fromOffset(metrics.Inset, metrics.ValueY),
		Size = UDim2.new(textWidth.Scale, textWidth.Offset, 0, metrics.ValueHeight),
		Text = FormatRate(entry.Income),
		TextSize = metrics.ValueSize,
	})
	PaintGradient(valueLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

	local statsRow = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(metrics.Inset, metrics.StatsY),
		Size = UDim2.new(1, -metrics.Inset * 2, 0, metrics.StatsHeight),
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

	local bar = CreateProgressBar(card, metrics.BarHeight, metrics.BarSize)
	bar.Track.Position = UDim2.fromOffset(metrics.Inset, metrics.BarY)
	bar.Track.Size = UDim2.new(1, -metrics.Inset * 2, 0, metrics.BarHeight)
	ApplyStatusFill(bar, entry)

	local selection = New("UIStroke", {
		Color = COLORS.Select,
		Thickness = 2.2,
		Transparency = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = card,
	})

	local button = New("TextButton", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		ZIndex = 5,
		Parent = card,
	})

	button.MouseButton1Click:Connect(function()
		Prediction.SelectedId = entry.Id
		Prediction.SelectCard()
		if Prediction.Preview then
			Prediction.Preview.Update(entry)
		end
	end)

	return {
		Frame = card,
		Selection = selection,
		Update = function(current)
			valueLabel.Text = FormatRate(current.Income)
			scaleLabel.Text = string.format("x%.2f", current.Scale)
			weightLabel.Text = FormatWeight(current.Weight)
			ApplyStatusFill(bar, current)
		end,
	}
end

local function CreatePreview(parent)
	local frame = New("Frame", {
		Name = "PredictorPreview",
		BackgroundColor3 = COLORS.Card,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, PREVIEW_HEIGHT),
		Parent = parent,
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 10) }),
		New("UIStroke", {
			Color = COLORS.Border,
			Thickness = 1.4,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}),
	})

	local art = New("Frame", {
		BackgroundColor3 = COLORS.Text,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(8, 8),
		Size = UDim2.fromOffset(PREVIEW_ART_SIZE, PREVIEW_ART_SIZE),
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

	local rays = New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.46),
		Size = UDim2.fromScale(1.9, 1.9),
		Image = PREVIEW_RAYS_ASSET,
		ImageColor3 = FALLBACK_RARITY_COLOR,
		ImageTransparency = 0.2,
		ScaleType = Enum.ScaleType.Fit,
		Parent = art,
	})

	New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.9),
		Size = UDim2.fromScale(0.62, 0.14),
		Image = PREVIEW_SHADOW_ASSET,
		ImageColor3 = COLORS.ShadowTint,
		ImageTransparency = 0.55,
		ScaleType = Enum.ScaleType.Stretch,
		ZIndex = 2,
		Parent = art,
	})

	local eggImage = New("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.47),
		Size = UDim2.fromScale(0.9, 0.9),
		Image = "",
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 3,
		Parent = art,
	})

	local bodyX = 8 + PREVIEW_ART_SIZE + 12
	local body = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(bodyX, 8),
		Size = UDim2.new(1, -(bodyX + 8), 0, PREVIEW_ART_SIZE),
		Parent = frame,
	})

	local nameLabel = CreateLabel(body, {
		Size = UDim2.new(1, 0, 0, 22),
		Text = "No egg",
		TextSize = 18,
		TextColor3 = COLORS.Subtext,
	})

	local rarityLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 23),
		Size = UDim2.new(1, 0, 0, 13),
		TextSize = 11,
	})

	local valueLabel = CreateLabel(body, {
		Position = UDim2.fromOffset(0, 38),
		Size = UDim2.new(1, 0, 0, 26),
		TextSize = 21,
	})
	PaintGradient(valueLabel, "TextPaint", ColorSequence.new(COLORS.IncomeTop, COLORS.IncomeBottom), 90)

	local statsRow = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 65),
		Size = UDim2.new(1, 0, 0, 16),
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
		TextSize = 12,
	})
	PaintGradient(scaleLabel, "TextPaint", ColorSequence.new(COLORS.ScaleTop, COLORS.ScaleBottom), 90)

	local weightLabel = CreateLabel(statsRow, {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 2,
		Size = UDim2.fromScale(0, 1),
		TextSize = 12,
	})
	PaintGradient(weightLabel, "TextPaint", ColorSequence.new(COLORS.WeightTop, COLORS.WeightBottom), 90)

	local bar = CreateProgressBar(body, 16, 11)
	bar.Track.Position = UDim2.fromOffset(0, 86)
	bar.Track.Size = UDim2.new(1, 0, 0, 16)

	local preview = {
		Frame = frame,
		Art = art,
		Rays = rays,
		Image = eggImage,
		Key = nil,
	}

	function preview.Update(entry)
		if not entry then
			preview.Key = nil
			nameLabel.Text = "No egg"
			nameLabel.TextColor3 = COLORS.Subtext
			rarityLabel.Text = ""
			valueLabel.Text = ""
			scaleLabel.Text = ""
			weightLabel.Text = ""
			bar.Text.Text = ""
			bar.Fill.Size = UDim2.fromScale(0, 1)
			eggImage.Image = ""
			return
		end

		local key = entry.Id .. "|" .. entry.Rarity .. "|" .. entry.Name
		if preview.Key ~= key then
			preview.Key = key
			PaintGradient(art, "RarityPaint", BuildArtSequence(entry), 90)
			PaintRarityText(nameLabel, entry, true)
			rarityLabel.Text = string.upper(entry.Rarity)
			PaintRarityText(rarityLabel, entry, false)
			eggImage.Image = entry.Icon
		end

		valueLabel.Text = FormatRate(entry.Income)
		scaleLabel.Text = string.format("x%.2f", entry.Scale)
		weightLabel.Text = FormatWeight(entry.Weight)
		ApplyStatusFill(bar, entry)
	end

	return preview
end

local function CreateFilterBar(parent)
	local bar = New("Frame", {
		Name = "PredictorFilters",
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Size = UDim2.new(1, 0, 0, 26),
		Parent = parent,
	}, {
		New("UIGridLayout", {
			CellSize = UDim2.new(0.25, -3, 0, 26),
			CellPadding = UDim2.fromOffset(4, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	Prediction.Filters = {}
	for index, filter in ipairs(FILTERS) do
		local button = New("TextButton", {
			BackgroundColor3 = COLORS.Card,
			BackgroundTransparency = 0.15,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			LayoutOrder = index,
			Text = "",
			Parent = bar,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0.3, 0) }),
		})

		local stroke = New("UIStroke", {
			Color = COLORS.Border,
			Thickness = 1.2,
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
			New("UITextSizeConstraint", { MaxTextSize = 10, MinTextSize = 6 }),
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
	for key, filter in pairs(Prediction.Filters) do
		local isActive = key == Prediction.FilterMode
		local count = Prediction.Counts[key] or 0
		filter.Label.Text = filter.Title .. "  " .. tostring(count)
		filter.Gradient.Enabled = isActive
		filter.Button.BackgroundColor3 = isActive and COLORS.Text or COLORS.Card
		filter.Button.BackgroundTransparency = isActive and 0 or 0.15
		filter.Label.TextColor3 = isActive and Color3.new(0, 0, 0) or COLORS.Subtext
		filter.Stroke.Color = isActive and Color3.new(0, 0, 0) or COLORS.Border
	end
end

function Prediction.SelectCard()
	for id, card in pairs(Prediction.Cards) do
		card.Selection.Transparency = id == Prediction.SelectedId and 0 or 1
	end
end

local function ClearCards()
	for _, card in pairs(Prediction.Cards) do
		card.Frame:Destroy()
	end
	Prediction.Cards = {}
end

local function RenderList(entries)
	local listFrame = Prediction.ListFrame
	local width = math.floor(listFrame.AbsoluteSize.X)
	if width <= 0 then
		width = 320
	end
	local columns = width >= 300 and 2 or 1
	local cardWidth = math.max(120, math.floor((width - GRID_GAP * (columns - 1)) / columns))
	local metrics = CardMetrics(cardWidth)

	ClearCards()
	Prediction.Grid.CellSize = UDim2.fromOffset(metrics.Width, metrics.Height)
	Prediction.Grid.CellPadding = UDim2.fromOffset(GRID_GAP, GRID_GAP)

	local rows = math.ceil(#entries / columns)
	listFrame.Size = UDim2.new(1, 0, 0, rows * metrics.Height + math.max(0, rows - 1) * GRID_GAP)
	Prediction.CardWidth = width

	for index, entry in ipairs(entries) do
		Prediction.Cards[entry.Id] = CreateCard(listFrame, entry, metrics, index)
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

	Prediction.Preview = CreatePreview(container)
	CreateFilterBar(container)

	Prediction.ListFrame = New("Frame", {
		Name = "PredictorList",
		BackgroundTransparency = 1,
		LayoutOrder = 4,
		Size = UDim2.new(1, 0, 0, 0),
		Parent = container,
	})

	Prediction.Grid = New("UIGridLayout", {
		CellSize = UDim2.fromOffset(160, 250),
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

function Prediction.Stop()
	if Prediction.Connection then
		Prediction.Connection:Disconnect()
		Prediction.Connection = nil
	end
end

return Prediction
