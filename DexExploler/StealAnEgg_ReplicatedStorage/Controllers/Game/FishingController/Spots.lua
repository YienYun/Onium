-- Script path: ReplicatedStorage.Controllers.Game.FishingController.Spots
-- Decompile time: 17.88 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Fishing = require(ReplicatedStorage.Shared.Util.Fishing)
local FishingFlags = require(ReplicatedStorage.Shared.Flags.FishingFlags)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u45 = Color3.fromRGB(120, 255, 175)
local v1 = {}

local function isWater(a1) -- Line: 70 -- upvalues: Fishing (val), CollectionService (val) -- types: a1: userdata
    if not a1:IsA("BasePart") then
        return false
    end
    local v1 = true
    if a1.Material ~= Enum.Material.Water then
        v1 = true
        if a1:GetAttribute("TerrainRole") ~= "Basin" then
            v1 = true
            if a1:GetAttribute(Fishing.WaterTag) ~= true then
                v1 = CollectionService:HasTag(a1, Fishing.WaterTag)
            end
        end
    end
    return v1
end

local function bounds(a1) -- Line: 80 -- types: a1: userdata
    local CFrame = a1.CFrame
    local Size = a1.Size
    local RightVector = CFrame.RightVector
    local UpVector = CFrame.UpVector
    local LookVector = CFrame.LookVector
    local v1 = Vector3.new(
        (math.abs(RightVector.X)) * Size.X + (math.abs(UpVector.X)) * Size.Y + (math.abs(LookVector.X)) * Size.Z,
        (math.abs(RightVector.Y)) * Size.X + (math.abs(UpVector.Y)) * Size.Y + (math.abs(LookVector.Y)) * Size.Z,
        (math.abs(RightVector.Z)) * Size.X + (math.abs(UpVector.Z)) * Size.Y + (math.abs(LookVector.Z)) * Size.Z
    ) / 2
    return CFrame.Position, v1
end

local function footprint(a1) -- Line: 94 -- types: a1: userdata
    if a1:IsA("BasePart") and not a1:IsA("Terrain") then
        local Size = a1.Size
        local v1 = {Size.X, Size.Y, Size.Z}
        table.sort(v1)
        return v1[2] * v1[3]
    end
    return (1 / 0)
end

local function surfaceAt(a1, a2, a3, a4) -- Line: 104
    -- upvalues: bounds (val), Workspace (val), isWater (val), footprint (val)
    local Instance, v1, v2
    local v3, v4 = bounds(a1)
    local v5 = v3.Y + v4.Y
    v3 = table.clone(a4)
    local v6 = RaycastParams.new()
    v6.FilterType = Enum.RaycastFilterType.Exclude
    v6.IgnoreWater = false
    v6.FilterDescendantsInstances = v3
    local v7 = Vector3.new(a2, v5 + 30, a3)
    v5 = Vector3.new(0, -(30 + v4.Y * 2 + 6), 0)
    for i = 1, 4 do
        v4 = Workspace:Raycast(v7, v5, v6)
        if v4 == nil then
            return nil
        end
        Instance = v4.Instance
        if Instance ~= a1 then
            if Instance:IsA("BasePart") and 0.95 <= Instance.Transparency and not isWater(Instance) then
                table.insert(v3, Instance)
                v6.FilterDescendantsInstances = v3
                continue
            end
            return nil
        end
        v1 = table.clone(v3)
        table.insert(v1, a1)
        v6.FilterDescendantsInstances = v1
        v1 = Workspace:Raycast(v4.Position, Vector3.new(0, -3, 0), v6)
        if v1 ~= nil and isWater(v1.Instance) then
            v2 = footprint(v1.Instance)
            if footprint(a1) * 1.5 <= v2 then
                return nil
            end
        end
        return v4.Position
    end
    return nil
end

local function rippleAt(a1, a2, a3, a4) -- Line: 144
    -- upvalues: surfaceAt (val)
    local v1
    local v2 = surfaceAt(a1, a2, a3, a4)
    if v2 == nil then
        return nil
    end
    for i, j in {
        Vector3.new(2.5, 0, 0),
        Vector3.new(-2.5, 0, 0),
        Vector3.new(0, 0, 2.5),
        (Vector3.new(0, 0, -2.5)),
    } do
        v1 = surfaceAt(a1, a2 + j.X, a3 + j.Z, a4)
        if v1 ~= nil and not (1.5 < (math.abs(v1.Y - v2.Y))) then
            continue
        end
        return nil
    end
    return v2 + Vector3.new(0, 0.25, 0)
end

local function cellRipple(a1, a2, a3, a4) -- Line: 164
    -- upvalues: rippleAt (val)
    local v1
    for i, j in {
        Vector2.zero,
        Vector2.new(10, 10),
        Vector2.new(-10, 10),
        Vector2.new(10, -10),
        (Vector2.new(-10, -10)),
    } do
        v1 = rippleAt(a1, a2 + j.X, a3 + j.Y, a4)
        if v1 then
            return v1
        end
    end
    return nil
end

local function spread(a1, a2) -- Line: 182 -- types: a1: table, a2: number
    local v1, v2
    if #a1 == 0 then
        return {}
    end
    local v3 = Vector3.new(0, 0, 0)
    for i, j in a1 do
        v3 = v3 + j
    end
    local v4 = v3 / #a1
    v3 = a1[1]
    local v5 = a1
    local v6 = nil
    for k, n in v5, nil, v6 do
        if (n - v4).Magnitude < (v3 - v4).Magnitude then
            v3 = n
        end
    end
    v4 = {v3}
    local v7, v8 = a2, a1
    while #v4 < v7 do
        v3 = nil
        v5 = 8
        v6 = nil
        v2 = nil
        for m, i5 in v8, v6, v2 do
            v1 = (1 / 0)
            for i6, i7 in v4 do
                v1 = math.min(v1, (i5 - i7).Magnitude)
            end
            if v5 <= v1 then
                v3 = i5
            end
        end
        if v3 == nil then
            break
        end
        table.insert(v4, v3)
    end
    return v4
end

local function smallPoints(a1, a2) -- Line: 219
    -- upvalues: bounds (val), rippleAt (val), footprint (val), spread (val)
    local v1
    local v2, v3 = bounds(a1)
    local v4 = math.clamp(math.ceil(v3.X * 2 / 4), 3, 12)
    local v5 = math.clamp(math.ceil(v3.Z * 2 / 4), 3, 12)
    local v6 = {}
    for i = 1, v4 do
        for j = 1, v5 do
            v1 = rippleAt(a1, v2.X - v3.X + (i - 0.5) * (v3.X * 2 / v4), v2.Z - v3.Z + (j - 0.5) * (v3.Z * 2 / v5), a2)
            if v1 then
                table.insert(v6, v1)
            end
        end
    end
    return (spread(v6, (math.clamp(math.floor((footprint(a1)) / 800 + 0.5), 1, 3))))
end

local function ownsRod(a1) -- Line: 238 -- upvalues: Fishing (val), LocalPlayer (val) -- types: a1: userdata
    if Fishing.EquippedRod(a1) ~= nil then
        return true
    end
    local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if Backpack == nil then
        return false
    end
    for i, j in Backpack:GetChildren() do
        if Fishing.IsRod(j) then
            return true
        end
    end
    return false
end

local function rootPart() -- Line: 254 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if Character ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        return Character, HumanoidRootPart
    end
    return nil, nil
end

local function characters() -- Line: 263 -- upvalues: Players (val)
    local v1 = {}
    for i, j in Players:GetPlayers() do
        if j.Character then
            table.insert(v1, j.Character)
        end
    end
    return v1
end

local function makeSlot(a1) -- Line: 273 -- upvalues: u45 (val) -- types: a1: userdata
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "Spot"
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = "rbxassetid://90951481407921"
    ParticleEmitter.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.Color = ColorSequence.new(u45)
    ParticleEmitter.LightEmission = 0.6
    ParticleEmitter.Size = NumberSequence.new(0.8999999999999999, 6.6)
    ParticleEmitter.Transparency = NumberSequence.new(0.55, 1)
    ParticleEmitter.Lifetime = NumberRange.new(1.3, 1.6)
    ParticleEmitter.Speed = NumberRange.new(0.01, 0.01)
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.LockedToPart = false
    ParticleEmitter.Rate = 0
    ParticleEmitter.Parent = Attachment
    Attachment.Parent = a1
    return {Attachment = Attachment, Emitter = ParticleEmitter}
end

function v1.Start(a1, a2) -- Line: 294
    -- upvalues: makeSlot (val), Workspace (val), isWater (val), bounds (val), cellRipple (val), smallPoints (val)
    -- upvalues: FishingFlags (val), LocalPlayer (val), ownsRod (val), characters (val), Fishing (val)
    -- upvalues: CollectionService (val), RunService (val)
    local v1 = a1:Extend()
    local u5 = {}
    local u6 = {}
    local u7 = 0
    local u13 = v1:Add((Instance.new("Part")))
    u13.Name = "FishingSpotRipples"
    u13.Anchored = true
    u13.CanCollide = false
    u13.CanQuery = false
    u13.CanTouch = false
    u13.CastShadow = false
    u13.Transparency = 1
    u13.Size = Vector3.new(1, 1, 1)
    u13.CFrame = CFrame.identity
    for i = 1, 6 do
        table.insert(u6, (makeSlot(u13)))
    end
    u13.Parent = Workspace

    local function track(a1) -- Line: 315
        -- upvalues: u5 (val), Workspace (upval), isWater (upval), bounds (upval)
        if a1:IsA("BasePart") and u5[a1] == nil then
            if a1:IsDescendantOf(Workspace) and isWater(a1) then
                local v1
                _, v1 = bounds(a1)
                u5[a1] = {
                    Tries = 0,
                    RetryAt = 0,
                    Part = a1,
                    Large = 160 < math.max(v1.X, v1.Z) * 2,
                    Points = {},
                    Cells = {},
                }
                return
            end
            return
        end
    end

    local function untrack(a1) -- Line: 333 -- upvalues: u5 (val) -- types: a1: userdata
        if a1:IsA("BasePart") then
            u5[a1] = nil
        end
    end

    local function within(a1, a2) -- Line: 339 -- upvalues: bounds (upval) -- types: a1: table, a2: vector
        local v1, v2 = bounds(a1.Part)
        local v3 = math.max((math.abs(a2.X - v1.X)) - v2.X, 0)
        local v4 = math.max((math.abs(a2.Z - v1.Z)) - v2.Z, 0)
        local v5 = false
        if (math.sqrt(v3 * v3 + v4 * v4)) <= 75 then
            v5 = (math.abs(a2.Y - v1.Y)) <= v2.Y + 80
        end
        return v5
    end

    local function scanCells(a1, a2, a3, a4) -- Line: 347
        -- upvalues: bounds (upval), cellRipple (upval)
        local v1, v2, v3, v4, v5
        local v6, v7 = bounds(a1.Part)
        local v8 = math.floor((a2.X - 75) / 40)
        local v9 = math.floor((a2.X + 75) / 40)
        local v10 = math.floor((a2.Z - 75) / 40)
        local v11 = math.floor((a2.Z + 75) / 40)
        local v12, v13, v14 = a1, a2, a3
        for i = v8, v9 do
            for j = v10, v11 do
                if a4 <= 0 then
                    return a4
                end
                v1 = ("%*:%*"):format(i, j)
                if v12.Cells[v1] == nil then
                    v2 = (i + 0.5) * 40
                    v3 = (j + 0.5) * 40
                    v4 = false
                    if (math.abs(v2 - v6.X)) <= v7.X then
                        v4 = (math.abs(v3 - v6.Z)) <= v7.Z
                    end
                    v5 = Vector2.new(v2 - v13.X, v3 - v13.Z).Magnitude <= 75
                    if v4 and v5 then
                        a4 = a4 - 1
                        v12.Cells[v1] = cellRipple(v12.Part, v2, v3, v14) or false
                    end
                end
            end
        end
        return a4
    end

    local function refresh(a1, a2, a3, a4) -- Line: 380
        -- upvalues: scanCells (val), smallPoints (upval)
        if a1.Large then
            return (scanCells(a1, a2, a3, a4))
        end
        if not (#a1.Points > 0) and not (2 <= a1.Tries) and not (os.clock() < a1.RetryAt) then
            a1.Tries = a1.Tries + 1
            a1.RetryAt = os.clock() + 8
            a1.Points = smallPoints(a1.Part, a3)
            return a4 - 1
        end
        return a4
    end

    local function allowed() -- Line: 393
        -- upvalues: a2 (val), FishingFlags (upval), LocalPlayer (upval), ownsRod (upval)
        if not a2() and FishingFlags.Enabled:Get() then
            local v1, v2
            if FishingFlags.DimensionOnly:Get() and LocalPlayer:GetAttribute("InHalloweenDimension") ~= true then
                return nil
            end
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if Character == nil or HumanoidRootPart == nil then
                v1 = nil
                v2 = nil
            elseif HumanoidRootPart:IsA("BasePart") then
                v1 = Character
                v2 = HumanoidRootPart
            else
                v1 = nil
                v2 = nil
            end
            if v1 ~= nil and v2 ~= nil and ownsRod(v1) then
                return v2
            end
            return nil
        end
        return nil
    end

    local function wantedPoints(a1) -- Line: 407
        -- upvalues: Workspace (upval), FishingFlags (upval), characters (upval), u13 (val), u5 (val), within (val)
        -- upvalues: refresh (val), Fishing (upval)
        local Points, v1, v2
        local GhostDogCastRipples = Workspace:FindFirstChild("GhostDogCastRipples")
        local Position = if GhostDogCastRipples == nil then nil else if not GhostDogCastRipples:IsA("BasePart") then nil else GhostDogCastRipples.Position
        local v3 = FishingFlags.QuestRadius:Get() + 4
        local v4 = characters()
        table.insert(v4, u13)
        local v5 = 8
        local v6 = {}
        local v7 = nil
        local v8 = nil
        for i, j in u5, v7, v8 do
            if j.Part.Parent ~= nil and within(j, a1) then
                v5 = refresh(j, a1, v4, v5)
                Points = j.Points
                if j.Large then
                    for k, n in j.Cells do
                        if n then
                            table.insert({}, n)
                        end
                    end
                end
                v1 = nil
                v2 = nil
                for m, i5 in Points, v1, v2 do
                    if not (60 < (i5 - a1).Magnitude) then
                        if not Position or not (Fishing.FlatDistance(i5, Position) <= v3) then
                            table.insert(v6, i5)
                        end
                    end
                end
            end
        end
        table.sort(v6, function(a1_2, a2) -- Line: 439 -- upvalues: a1 (val) -- types: a1_2: vector, a2: vector
            return (a1_2 - a1).Magnitude < (a2 - a1).Magnitude
        end)
        v5 = {}
        for i6 = 1, (math.min(#v6, 6)) do
            v5[i6] = v6[i6]
        end
        return v5
    end

    local function apply(a1) -- Line: 449 -- upvalues: u6 (val) -- types: a1: table
        local Point, v1
        local v2 = {}
        for i, j in a1 do
            v2[j] = true
        end
        local v3 = nil
        local v4 = nil
        for k, n in u6, v3, v4 do
            Point = n.Point
            if not Point then
                if Point then
                    n.Point = nil
                    n.Emitter.Rate = 0
                end
            elseif v2[Point] then
                v2[Point] = nil
            elseif Point then
                n.Point = nil
                n.Emitter.Rate = 0
            end
        end
        for m, i5 in u6 do
            if i5.Point == nil then
                v1 = next(v2)
                if v1 == nil then
                    break
                end
                v2[v1] = nil
                i5.Point = v1
                i5.Attachment.Position = v1
                i5.Emitter.Rate = 0.5
            end
        end
    end

    v1:Connect(CollectionService:GetInstanceAddedSignal(Fishing.WaterTag), track)
    v1:Connect(CollectionService:GetInstanceRemovedSignal(Fishing.WaterTag), untrack)
    v1:Connect(Workspace.DescendantAdded, track)
    v1:Connect(Workspace.DescendantRemoving, untrack)
    for j, k in CollectionService:GetTagged(Fishing.WaterTag) do
        track(k)
    end
    v1:Add((task.defer(function() -- Line: 484 -- upvalues: Workspace (upval), track (val)
        for i, j in Workspace:GetDescendants() do
            track(j)
            if i % 4000 == 0 then
                task.wait()
            end
        end
    end)))
    v1:Connect(RunService.Heartbeat, function() -- Line: 493 -- upvalues: u7 (ref), allowed (val), apply (val), wantedPoints (val)
        if os.clock() < u7 then
            return
        end
        u7 = os.clock() + 0.25
        local v1 = allowed()
        apply(if not v1 then {} else wantedPoints(v1.Position))
    end)
    return v1
end

return v1