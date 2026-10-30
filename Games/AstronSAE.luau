local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local Astron = {
	Version = "1.0.0",
	Settings = {
		AutoSteal = false,
		MoveToEgg = "Walk",
		Delivery = "Fast Tween",
		FastTweenSpeed = 3300,
		DeliverySpeed = 100,
		StepCount = 3,
		MinRarity = "Any",
		DropAtSafeZone = false,
	},
	State = {
		Running = false,
		Status = "Idle",
		TargetUid = nil,
		TargetName = nil,
		Session = 0,
		Skipped = {},
	},
	Catalog = {
		Rarities = {},
		RarityRankByKey = {},
		EggRarity = {},
		AreaNames = {},
	},
}

local SAFE_CORRIDOR_Z = -365.3
local DROP_GAP_X = 13.8
local DROP_HEIGHT = 3.35
local CARRY_STOP_DISTANCE = 36
local CARRY_SNAP_DISTANCE = 6
local CARRY_FRAME_CAP = 250
local CARRY_Z_EASE = 0.03
local CARRY_ROTATION = CFrame.Angles(0, math.pi / 2, 0)
local QUICK_STEP_AREAS = {
	["Enchanted Forest"] = true,
	["Light Dark"] = true,
	["Titan Temple"] = true,
}

local function RequireModule(...)
	local segments = { ... }
	local ok, loaded = pcall(function()
		local current = ReplicatedStorage
		for _, segment in ipairs(segments) do
			current = current and (current:FindFirstChild(segment) or current:WaitForChild(segment, 3))
		end
		return current and require(current) or nil
	end)
	return (ok and type(loaded) == "table") and loaded or nil
end

local EggState = RequireModule("Client", "EggState")
local AreasData = RequireModule("Data", "Areas")
local AssetsData = RequireModule("Data", "Assets")
local Earnings = RequireModule("Shared", "Util", "AssetEarnings")
local Save = RequireModule("Shared", "Save") or RequireModule("Client", "Save")

local function NormalizeKey(value)
	return string.lower((tostring(value or ""):gsub("%s+", " ")))
end

local function ToNumber(value, fallback)
	local numeric = tonumber(value)
	if numeric == nil then
		return fallback or 0
	end
	return numeric
end

local function GetCharacter()
	local character = LocalPlayer.Character
	if not character or not character.Parent then
		character = LocalPlayer.CharacterAdded:Wait()
	end
	return character
end

local function GetRoot()
	local character = LocalPlayer.Character
	return character and character:FindFirstChild("HumanoidRootPart") or nil
end

local function GetHumanoid()
	local character = LocalPlayer.Character
	return character and character:FindFirstChildOfClass("Humanoid") or nil
end

local function IsAlive()
	local humanoid = GetHumanoid()
	return humanoid ~= nil and humanoid.Health > 0 and GetRoot() ~= nil
end

local function StopMotion()
	local root = GetRoot()
	if not root then
		return
	end
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
end

local function SetStatus(text)
	Astron.State.Status = text
	if Astron.UI and Astron.UI.StatusLabel then
		Astron.UI.StatusLabel.Text = text
	end
end

local function BuildCatalog()
	local assetsDirectory = AssetsData and AssetsData.Directory or nil
	local rankToName, rarityRanks = {}, {}
	if type(assetsDirectory) == "table" then
		for categoryName, assetEntry in pairs(assetsDirectory) do
			if type(assetEntry) == "table" then
				local rarityTable = type(assetEntry.Rarity) == "table" and assetEntry.Rarity or nil
				local rankNumber = rarityTable and ToNumber(rarityTable.RarityNumber or rarityTable.Rank, 0) or 0
				local rarityName = rarityTable
					and tostring(rarityTable.DisplayName or rarityTable._id or rarityTable.Name or "")
					or ""
				if rankNumber > 0 and rarityName ~= "" then
					rankToName[rankNumber] = rankToName[rankNumber] or rarityName
					rarityRanks[rarityName] = rankNumber
				end
				Astron.Catalog.EggRarity[NormalizeKey(categoryName)] = {
					Name = rarityName ~= "" and rarityName or "Common",
					Rank = rankNumber > 0 and rankNumber or 1,
					Rate = ToNumber(assetEntry.Rate or assetEntry.BaseRate or 0, 0),
				}
			end
		end
	end

	local sortedRanks = {}
	for rankNumber in pairs(rankToName) do
		table.insert(sortedRanks, rankNumber)
	end
	table.sort(sortedRanks, function(leftRank, rightRank)
		return leftRank < rightRank
	end)
	for _, rankNumber in ipairs(sortedRanks) do
		local rarityName = rankToName[rankNumber]
		table.insert(Astron.Catalog.Rarities, rankNumber .. " - " .. rarityName)
		Astron.Catalog.RarityRankByKey[rankNumber] = rankNumber
		Astron.Catalog.RarityRankByKey[NormalizeKey(rarityName)] = rankNumber
	end

	local areasDirectory = AreasData and AreasData.Directory or nil
	if type(areasDirectory) == "table" then
		for areaName in pairs(areasDirectory) do
			table.insert(Astron.Catalog.AreaNames, tostring(areaName))
		end
		table.sort(Astron.Catalog.AreaNames)
	end
end

local function RarityInfo(categoryName)
	local cached = Astron.Catalog.EggRarity[NormalizeKey(categoryName)]
	if cached then
		return cached.Name, cached.Rank
	end
	return "Common", 1
end

local function EggValue(categoryName, assetScale, mutations)
	local category = tostring(categoryName or "")
	if Earnings and type(Earnings.LiveRatePerSecond) == "function" then
		local ok, rate = pcall(Earnings.LiveRatePerSecond, {
			Category = category,
			Scale = math.max(ToNumber(assetScale, 1), 0.5),
			Mutations = type(mutations) == "table" and mutations or {},
		}, nil, nil, LocalPlayer)
		if ok and type(rate) == "number" and rate > 0 then
			return rate
		end
	end
	local cached = Astron.Catalog.EggRarity[NormalizeKey(category)]
	local baseRate = cached and cached.Rate or 0
	return baseRate * math.max(ToNumber(assetScale, 1), 0.5)
end

local function MinRarityRank()
	local label = tostring(Astron.Settings.MinRarity or "Any")
	local rank = ToNumber(label:match("^(%d+)"), nil)
	return rank or 0
end

local function ReadFieldEggs()
	if not EggState or type(EggState.ReadFieldEggs) ~= "function" then
		return {}
	end
	local ok, snapshot = pcall(EggState.ReadFieldEggs)
	if not ok or type(snapshot) ~= "table" then
		return {}
	end
	return type(snapshot.Records) == "table" and snapshot.Records or {}
end

local function ReadFieldEgg(uid)
	if not EggState or type(EggState.ReadFieldEgg) ~= "function" then
		return nil
	end
	local ok, record = pcall(EggState.ReadFieldEgg, uid)
	return (ok and type(record) == "table") and record or nil
end

local function IsCarriedByMe(uid)
	local record = ReadFieldEgg(uid)
	return record ~= nil
		and record.State == "Carried"
		and ToNumber(record.CarrierUserId, 0) == LocalPlayer.UserId
end

local function EggPosition(record)
	local pivot = record.BottomCFrame or record.BoundsCFrame
	if typeof(pivot) == "CFrame" then
		return pivot.Position
	end
	local slots = Workspace:FindFirstChild("AreaEggSlotsClient")
	local model = slots and slots:FindFirstChild(tostring(record.Uid))
	if model and model:IsA("Model") then
		local ok, cachedPivot = pcall(function()
			return model:GetPivot()
		end)
		if ok and cachedPivot then
			return cachedPivot.Position
		end
	end
	return nil
end

function Astron.CollectCandidates()
	local candidates = {}
	local minRank = MinRarityRank()
	for _, record in pairs(ReadFieldEggs()) do
		if type(record) == "table" and record.State ~= "Carried" and record.State ~= "Claimed" then
			local position = EggPosition(record)
			local categoryName = tostring(record.AssetCategory or "Egg")
			local rarityName, rarityRank = RarityInfo(categoryName)
			if position and rarityRank >= minRank then
				local mutations = type(record.Mutations) == "table" and #record.Mutations or 0
				table.insert(candidates, {
					Uid = tostring(record.Uid),
					Category = categoryName,
					Rarity = rarityName,
					RarityRank = rarityRank,
					MutationCount = mutations,
					Value = EggValue(categoryName, record.AssetScale, record.Mutations),
					Weight = ToNumber(record.AssetScale, 1),
					Position = position,
					AreaId = record.AreaId,
					Record = record,
				})
			end
		end
	end
	table.sort(candidates, function(left, right)
		if left.RarityRank ~= right.RarityRank then
			return left.RarityRank > right.RarityRank
		end
		if left.MutationCount ~= right.MutationCount then
			return left.MutationCount > right.MutationCount
		end
		if left.Value ~= right.Value then
			return left.Value > right.Value
		end
		return left.Uid < right.Uid
	end)
	return candidates
end

local function SeparationPosition()
	local world = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
	local areas = world and world:FindFirstChild("Areas")
	local line = areas and areas:FindFirstChild("SeparationLine")
	if line and line:IsA("BasePart") then
		return line.Position
	end
	return Vector3.new(552, 71, SAFE_CORRIDOR_Z)
end

local function SafeZoneParts()
	local parts = {}
	for _, part in ipairs(CollectionService:GetTagged("SafeZone")) do
		if part:IsA("BasePart") and part:IsDescendantOf(Workspace) then
			table.insert(parts, part)
		end
	end
	return parts
end

local function OwnSafeZone()
	local separation = SeparationPosition()
	local bestPart, bestX = nil, -math.huge
	for _, part in ipairs(SafeZoneParts()) do
		if part.Position.X < separation.X and part.Position.X > bestX then
			bestPart, bestX = part, part.Position.X
		end
	end
	return bestPart
end

local function DropPoint()
	local separation = SeparationPosition()
	return Vector3.new(separation.X + DROP_GAP_X, separation.Y + DROP_HEIGHT, SAFE_CORRIDOR_Z)
end

local function DepositPoint()
	local zone = OwnSafeZone()
	if zone then
		return zone.Position + Vector3.new(0, zone.Size.Y * 0.5, 0)
	end
	local separation = SeparationPosition()
	return Vector3.new(separation.X - 25, separation.Y + 3, SAFE_CORRIDOR_Z)
end

local function GroundY(x, z)
	local root = GetRoot()
	if not root then
		return nil
	end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { LocalPlayer.Character }
	params.IgnoreWater = true
	local hit = Workspace:Raycast(Vector3.new(x, root.Position.Y + 80, z), Vector3.new(0, -400, 0), params)
	return hit and hit.Position.Y or nil
end

local function SetCarryCFrame(position)
	local root = GetRoot()
	if not root then
		return
	end
	root.CFrame = CFrame.new(position) * CARRY_ROTATION
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
end

local function LegCount(areaId)
	if areaId and QUICK_STEP_AREAS[areaId] then
		return 4
	end
	local world = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
	local areas = world and world:FindFirstChild("Areas")
	local guardAreas = areas and areas:FindFirstChild("GuardAreas")
	local guardArea = areaId and guardAreas and guardAreas:FindFirstChild(areaId)
	local escapeSpeeds = guardArea and guardArea:GetAttribute("GuardEscapeSpeeds")
	if typeof(escapeSpeeds) == "Vector2" then
		local walkSpeed = ToNumber(GetHumanoid() and GetHumanoid().WalkSpeed, 16)
		if walkSpeed * 0.9 < escapeSpeeds.Y * 1.05 then
			return 2
		end
	end
	return 1
end

local function CarrySpeed()
	local base = math.clamp(ToNumber(Astron.Settings.FastTweenSpeed, 3300), 800, 8000)
	local scale = math.clamp(ToNumber(Astron.Settings.DeliverySpeed, 100), 50, 200) / 100
	return base * scale
end

local function RequestCarry(uid, slotKey)
	if not EggState or type(EggState.CarryFieldEgg) ~= "function" then
		return
	end
	task.spawn(function()
		pcall(EggState.CarryFieldEgg, uid, slotKey)
	end)
	local slots = Workspace:FindFirstChild("AreaEggSlotsClient")
	local model = slots and slots:FindFirstChild(tostring(uid))
	local prompt = model and model:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt and prompt.Enabled and typeof(fireproximityprompt) == "function" then
		pcall(fireproximityprompt, prompt)
	end
end

local function RequestDrop()
	if not EggState or type(EggState.DropFieldEgg) ~= "function" then
		return
	end
	pcall(EggState.DropFieldEgg, "PlayerRequest")
end

local function SnapToEgg(uid)
	local record = ReadFieldEgg(uid)
	local position = record and EggPosition(record)
	local root = GetRoot()
	if not position or not root then
		return
	end
	if (position - root.Position).Magnitude > CARRY_SNAP_DISTANCE then
		SetCarryCFrame(position + Vector3.new(0, 3, 0))
	end
end

local function DropAndRegrab(uid)
	if not IsCarriedByMe(uid) then
		return false
	end
	RequestDrop()
	local snapped, tries = false, 0
	local deadline = os.clock() + 2
	while os.clock() < deadline and Astron.State.Running do
		if IsCarriedByMe(uid) then
			return true
		end
		local record = ReadFieldEgg(uid)
		if not snapped and record and record.State == "Dropped" then
			snapped = true
			SnapToEgg(uid)
		end
		if tries < 3 then
			tries = tries + 1
			RequestCarry(uid)
		end
		task.wait(0.03)
	end
	return IsCarriedByMe(uid)
end

function Astron.TweenTo(targetPosition, tolerance, deadlineSeconds)
	local root = GetRoot()
	if not root then
		return false
	end
	local deadline = os.clock() + (deadlineSeconds or 20)
	local toleranceDistance = tolerance or 2
	local speed = 5000
	while os.clock() < deadline and Astron.State.Running and IsAlive() do
		root = GetRoot()
		if not root then
			return false
		end
		local current = root.Position
		local delta = targetPosition - current
		if delta.Magnitude <= toleranceDistance then
			return true
		end
		local dt = RunService.Heartbeat:Wait()
		dt = math.clamp(tonumber(dt) or (1 / 60), 1 / 240, 0.15)
		local nextPosition = current + delta.Unit * math.min(speed * dt, delta.Magnitude)
		root.CFrame = CFrame.lookAt(nextPosition, nextPosition + delta.Unit)
		StopMotion()
	end
	return false
end

function Astron.WalkTo(targetPosition, tolerance, deadlineSeconds)
	local humanoid = GetHumanoid()
	if not humanoid then
		return false
	end
	local deadline = os.clock() + (deadlineSeconds or 25)
	local toleranceDistance = tolerance or 6
	humanoid:MoveTo(targetPosition)
	while os.clock() < deadline and Astron.State.Running and IsAlive() do
		local root = GetRoot()
		if not root then
			return false
		end
		local flatDistance = Vector2.new(
			targetPosition.X - root.Position.X,
			targetPosition.Z - root.Position.Z
		).Magnitude
		if flatDistance <= toleranceDistance then
			humanoid:MoveTo(root.Position)
			StopMotion()
			return true
		end
		task.wait(0.1)
		humanoid:MoveTo(targetPosition)
	end
	humanoid:MoveTo(Vector3.zero)
	return false
end

local function MoveToPosition(position)
	if Astron.Settings.MoveToEgg == "Teleport" then
		return Astron.TweenTo(position, 3, 20)
	end
	return Astron.WalkTo(position, 6, 25)
end

function Astron.ApproachEgg(candidate)
	SetStatus("Heading to " .. candidate.Category)
	local destination = candidate.Position
	local root = GetRoot()
	if not root then
		return false
	end
	local groundY = GroundY(destination.X, destination.Z)
	if groundY then
		destination = Vector3.new(destination.X, groundY + 3, destination.Z)
	end
	if not MoveToPosition(destination) then
		return false
	end
	local liveRecord = ReadFieldEgg(candidate.Uid)
	local livePosition = liveRecord and EggPosition(liveRecord)
	if livePosition and (livePosition - (GetRoot() and GetRoot().Position or livePosition)).Magnitude > 8 then
		return false
	end
	return true
end

function Astron.RequestTargetCarry(candidate)
	local deadline = os.clock() + 12
	local tries = 0
	while os.clock() < deadline and Astron.State.Running do
		if IsCarriedByMe(candidate.Uid) then
			return true
		end
		local record = ReadFieldEgg(candidate.Uid)
		if not record then
			return false
		end
		if tries < 6 then
			tries = tries + 1
			RequestCarry(candidate.Uid)
		end
		task.wait(0.2)
	end
	return IsCarriedByMe(candidate.Uid)
end

local function CarryLegs(uid, areaId)
	local target = DropPoint()
	local root = GetRoot()
	if not root then
		return false
	end
	local start = root.Position
	local legCount = LegCount(areaId)
	local legX = {}
	for index = 1, legCount - 1 do
		legX[index] = start.X - ((start.X - target.X) * index / legCount)
	end
	local carryY = math.max(start.Y, target.Y)
	local speed = CarrySpeed()
	local legIndex = 1
	local deadline = os.clock() + 60

	while os.clock() < deadline and Astron.State.Running and IsAlive() do
		root = GetRoot()
		if not root then
			return false
		end
		if not IsCarriedByMe(uid) then
			return false
		end
		local position = root.Position
		if legX[legIndex] and position.X <= legX[legIndex] then
			legIndex = legIndex + 1
			SetCarryCFrame(Vector3.new(position.X, carryY, position.Z))
			task.wait(0.1)
			if not DropAndRegrab(uid) then
				return false
			end
			continue
		end
		if position.X - target.X <= CARRY_STOP_DISTANCE then
			SetCarryCFrame(Vector3.new(target.X, target.Y, target.Z))
			return true
		end
		local dt = RunService.Heartbeat:Wait()
		dt = math.clamp(tonumber(dt) or (1 / 60), 1 / 240, 0.15)
		local stepX = math.min(speed * dt, CARRY_FRAME_CAP, position.X - target.X)
		local nextZ = position.Z + ((target.Z - position.Z) * CARRY_Z_EASE)
		SetCarryCFrame(Vector3.new(position.X - stepX, carryY, nextZ))
	end
	return false
end

local function CarrySteps(uid)
	local target = DropPoint()
	local root = GetRoot()
	if not root then
		return false
	end
	local start = root.Position
	local steps = math.clamp(ToNumber(Astron.Settings.StepCount, 3), 1, 6)
	local carryY = math.max(start.Y, target.Y)
	for index = 1, steps do
		if not Astron.State.Running or not IsCarriedByMe(uid) then
			return false
		end
		local share = index / steps
		SetCarryCFrame(Vector3.new(
			start.X + ((target.X - start.X) * share),
			carryY,
			start.Z + ((target.Z - start.Z) * share)
		))
		task.wait(0.1)
		if not DropAndRegrab(uid) then
			return false
		end
		task.wait(0.05)
	end
	return true
end

local function CarryWalk(uid)
	local target = DropPoint()
	local root = GetRoot()
	if not root then
		return false
	end
	local humanoid = GetHumanoid()
	if not humanoid then
		return false
	end
	humanoid:MoveTo(target)
	local deadline = os.clock() + 60
	while os.clock() < deadline and Astron.State.Running and IsAlive() do
		root = GetRoot()
		if not root or not IsCarriedByMe(uid) then
			return false
		end
		local flatDistance = Vector2.new(target.X - root.Position.X, target.Z - root.Position.Z).Magnitude
		if flatDistance <= CARRY_STOP_DISTANCE then
			humanoid:MoveTo(root.Position)
			return true
		end
		task.wait(0.1)
	end
	return false
end

local function DepositEgg(uid)
	local deposit = DepositPoint()
	local humanoid = GetHumanoid()
	if not humanoid then
		return false
	end
	SetStatus("Taking the egg inside")
	humanoid:MoveTo(deposit)
	local deadline = os.clock() + 15
	while os.clock() < deadline and Astron.State.Running and IsAlive() do
		local record = ReadFieldEgg(uid)
		if not record then
			return true
		end
		local root = GetRoot()
		if root then
			local flatDistance = Vector2.new(deposit.X - root.Position.X, deposit.Z - root.Position.Z).Magnitude
			if flatDistance <= 5 then
				humanoid:MoveTo(root.Position)
				StopMotion()
			else
				humanoid:MoveTo(deposit)
			end
		end
		task.wait(0.1)
	end
	return ReadFieldEgg(uid) == nil
end

local function DropAtPoint(uid)
	if not IsCarriedByMe(uid) then
		return false
	end
	RequestDrop()
	local deadline = os.clock() + 1.5
	while os.clock() < deadline and Astron.State.Running and IsCarriedByMe(uid) do
		task.wait(0.05)
	end
	return not IsCarriedByMe(uid)
end

local function TakeEggBack(uid)
	local deadline = os.clock() + 2.5
	while os.clock() < deadline and Astron.State.Running do
		if IsCarriedByMe(uid) then
			return true
		end
		SnapToEgg(uid)
		RequestCarry(uid)
		task.wait(0.1)
	end
	return IsCarriedByMe(uid)
end

function Astron.Deliver(uid, areaId)
	SetStatus("Bringing the egg home")
	local delivery = Astron.Settings.Delivery
	local arrived = false
	if delivery == "Fast Tween" then
		arrived = CarryLegs(uid, areaId)
	elseif delivery == "Instant Steps" then
		arrived = CarrySteps(uid)
	else
		arrived = CarryWalk(uid)
	end
	if not arrived or not Astron.State.Running then
		return false
	end
	if not DropAtPoint(uid) then
		return false
	end
	if Astron.Settings.DropAtSafeZone then
		SetStatus("Egg left in front of the safe zone")
		return true
	end
	if not TakeEggBack(uid) then
		return false
	end
	return DepositEgg(uid)
end

local function PruneSkipped()
	local now = os.clock()
	for uid, expireAt in pairs(Astron.State.Skipped) do
		if expireAt <= now then
			Astron.State.Skipped[uid] = nil
		end
	end
end

function Astron.StealOnce()
	PruneSkipped()
	local candidates = Astron.CollectCandidates()
	local candidate = nil
	for _, entry in ipairs(candidates) do
		if not Astron.State.Skipped[entry.Uid] then
			candidate = entry
			break
		end
	end
	if not candidate then
		SetStatus("No matching egg")
		return false
	end
	Astron.State.TargetUid = candidate.Uid
	Astron.State.TargetName = candidate.Category

	if not Astron.ApproachEgg(candidate) then
		Astron.State.Skipped[candidate.Uid] = os.clock() + 20
		SetStatus("Could not reach the egg")
		return false
	end
	if not Astron.RequestTargetCarry(candidate) then
		Astron.State.Skipped[candidate.Uid] = os.clock() + 20
		SetStatus("Carry refused")
		return false
	end

	local delivered = Astron.Deliver(candidate.Uid, candidate.AreaId)
	Astron.State.TargetUid = nil
	if delivered then
		SetStatus("Delivered " .. candidate.Category)
	end
	return delivered
end

function Astron.Start()
	if Astron.State.Running then
		return
	end
	Astron.State.Running = true
	Astron.State.Session = Astron.State.Session + 1
	local session = Astron.State.Session
	task.spawn(function()
		while Astron.State.Running and Astron.State.Session == session do
			if not IsAlive() then
				SetStatus("Waiting for character")
				task.wait(1)
				continue
			end
			local ok, errorText = pcall(Astron.StealOnce)
			if not ok then
				SetStatus("Error: " .. tostring(errorText))
			end
			task.wait(0.6)
		end
	end)
end

function Astron.Stop()
	Astron.State.Running = false
	Astron.State.Session = Astron.State.Session + 1
	local humanoid = GetHumanoid()
	if humanoid then
		humanoid:MoveTo(Vector3.zero)
	end
	StopMotion()
	SetStatus("Idle")
end

function Astron.Toggle()
	if Astron.Settings.AutoSteal then
		Astron.Settings.AutoSteal = false
		Astron.Stop()
	else
		Astron.Settings.AutoSteal = true
		Astron.Start()
	end
	Astron.SyncUI()
end

local function CreateButton(parent, text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 26)
	button.BackgroundColor3 = Color3.fromRGB(38, 33, 52)
	button.BorderSizePixel = 0
	button.TextColor3 = Color3.fromRGB(235, 225, 255)
	button.Font = Enum.Font.GothamMedium
	button.TextSize = 13
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.Text = "  " .. text
	button.AutoButtonColor = true
	button.Parent = parent
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button
	button.MouseButton1Click:Connect(callback)
	return button
end

local function CycleValue(list, current)
	for index, value in ipairs(list) do
		if value == current then
			return list[(index % #list) + 1]
		end
	end
	return list[1]
end

function Astron.BuildUI()
	if Astron.UI and Astron.UI.Gui and Astron.UI.Gui.Parent then
		return
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "AstronSAE"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 300, 0, 268)
	frame.Position = UDim2.new(0, 24, 0, 120)
	frame.BackgroundColor3 = Color3.fromRGB(24, 20, 34)
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Parent = gui

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 10)
	frameCorner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(217, 70, 239)
	stroke.Thickness = 1
	stroke.Transparency = 0.35
	stroke.Parent = frame

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -16, 0, 34)
	title.Position = UDim2.new(0, 12, 0, 6)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.GothamBold
	title.TextSize = 15
	title.TextColor3 = Color3.fromRGB(217, 70, 239)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = "Astron SAE  v" .. Astron.Version
	title.Parent = frame

	local statusLabel = Instance.new("TextLabel")
	statusLabel.Size = UDim2.new(1, -24, 0, 20)
	statusLabel.Position = UDim2.new(0, 12, 0, 40)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextSize = 12
	statusLabel.TextColor3 = Color3.fromRGB(200, 195, 215)
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.Text = "Status: Idle"
	statusLabel.Parent = frame

	local list = Instance.new("Frame")
	list.Size = UDim2.new(1, -24, 0, 214)
	list.Position = UDim2.new(0, 12, 0, 64)
	list.BackgroundTransparency = 1
	list.Parent = frame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 4)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = list

	Astron.UI = { Gui = gui, Frame = frame, StatusLabel = statusLabel, Buttons = {} }

	Astron.UI.Buttons.AutoSteal = CreateButton(list, "Auto Steal", function()
		Astron.Toggle()
	end)

	Astron.UI.Buttons.MoveToEgg = CreateButton(list, "Move To Egg", function()
		Astron.Settings.MoveToEgg = CycleValue({ "Walk", "Teleport" }, Astron.Settings.MoveToEgg)
		Astron.SyncUI()
	end)

	Astron.UI.Buttons.Delivery = CreateButton(list, "Delivery", function()
		Astron.Settings.Delivery = CycleValue({ "Fast Tween", "Instant Steps", "Walk" }, Astron.Settings.Delivery)
		Astron.SyncUI()
	end)

	Astron.UI.Buttons.Speed = CreateButton(list, "Fast Tween Speed", function()
		local nextSpeed = ToNumber(Astron.Settings.FastTweenSpeed, 3300) + 300
		if nextSpeed > 4500 then
			nextSpeed = 3000
		end
		Astron.Settings.FastTweenSpeed = nextSpeed
		Astron.SyncUI()
	end)

	Astron.UI.Buttons.MinRarity = CreateButton(list, "Min Rarity", function()
		local options = { "Any" }
		for _, rarityLabel in ipairs(Astron.Catalog.Rarities) do
			table.insert(options, rarityLabel)
		end
		Astron.Settings.MinRarity = CycleValue(options, Astron.Settings.MinRarity)
		Astron.SyncUI()
	end)

	Astron.UI.Buttons.DropAtSafeZone = CreateButton(list, "Drop At Safe Zone", function()
		Astron.Settings.DropAtSafeZone = not Astron.Settings.DropAtSafeZone
		Astron.SyncUI()
	end)

	local dragStart, dragOrigin
	title.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			dragStart = input.Position
			dragOrigin = frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch)
		then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				dragOrigin.X.Scale,
				dragOrigin.X.Offset + delta.X,
				dragOrigin.Y.Scale,
				dragOrigin.Y.Offset + delta.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			dragStart = nil
		end
	end)

	Astron.SyncUI()
end

function Astron.SyncUI()
	local buttons = Astron.UI and Astron.UI.Buttons
	if not buttons then
		return
	end
	buttons.AutoSteal.Text = "  Auto Steal: " .. (Astron.Settings.AutoSteal and "ON" or "OFF")
	buttons.MoveToEgg.Text = "  Move To Egg: " .. tostring(Astron.Settings.MoveToEgg)
	buttons.Delivery.Text = "  Delivery: " .. tostring(Astron.Settings.Delivery)
	buttons.Speed.Text = "  Fast Tween Speed: " .. tostring(Astron.Settings.FastTweenSpeed)
	buttons.MinRarity.Text = "  Min Rarity: " .. tostring(Astron.Settings.MinRarity)
	buttons.DropAtSafeZone.Text = "  Drop At Safe Zone: " .. (Astron.Settings.DropAtSafeZone and "ON" or "OFF")
	Astron.UI.StatusLabel.Text = "Status: " .. tostring(Astron.State.Status)
end

BuildCatalog()
Astron.BuildUI()
SetStatus("Idle")

return Astron
