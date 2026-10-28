-- Script path: ReplicatedStorage.Shared.Util.Fishing
-- Decompile time: 7.35 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local FishingFlags = require(ReplicatedStorage.Shared.Flags.FishingFlags)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local u29 = {WaterTag = "FishingWater", FlightSeconds = 0.75, RodAttribute = GhostDogQuest.RodAttribute}
u29.Messages = table.freeze({
    Miss = "Cast into the water!",
    Nothing = "Nothing's biting...",
    Escaped = "It got away...",
    Hint = "Cast at the glowing ripples off the end of the pier!",
    Busy = "Hold on...",
    Closed = "Fishing is closed right now.",
    Dimension = "Fish inside the Halloween dimension!",
})

function u29.ChargeAt(a1) -- Line: 65 -- upvalues: FishingFlags (val) -- types: a1: number
    local v1 = FishingFlags.ChargeSeconds:Get()
    local v2 = math.max(a1, 0) / v1 % 2
    return math.clamp(if not (v2 <= 1) then 2 - v2 else v2, 0, 1) ^ 1.4
end

function u29.IsPerfect(a1) -- Line: 72 -- upvalues: FishingFlags (val) -- types: a1: number
    local v1 = false
    if FishingFlags.PerfectMin:Get() <= a1 then
        v1 = a1 <= FishingFlags.PerfectMax:Get()
    end
    return v1
end

function u29.LuckFor(a1) -- Line: 76 -- upvalues: u29 (val), FishingFlags (val) -- types: a1: number
    if u29.IsPerfect(a1) then
        return FishingFlags.PerfectLuck:Get()
    end
    return 1 + (FishingFlags.ChargeLuck:Get() - 1) * math.clamp(a1, 0, 1)
end

function u29.LuckText(a1) -- Line: 83 -- types: a1: number
    local v1 = math.floor(a1 * 10 + 0.5) / 10
    if v1 % 1 == 0 then
        return (("x%*"):format((string.format("%d", v1))))
    end
    return (("x%*"):format((string.format("%.1f", v1))))
end

function u29.DistanceFor(a1) -- Line: 91 -- upvalues: FishingFlags (val) -- types: a1: number
    local v1 = FishingFlags.MinCastDistance:Get()
    return v1 + (math.max(FishingFlags.MaxCastDistance:Get(), v1) - v1) * math.clamp(a1, 0, 1)
end

function u29.IsRod(a1) -- Line: 97 -- upvalues: GhostDogQuest (val) -- types: a1: userdata?
    local v1 = false
    if a1 ~= nil then
        v1 = a1:IsA("Tool") and a1:GetAttribute(GhostDogQuest.RodAttribute) == true
    end
    return v1
end

function u29.EquippedRod(a1) -- Line: 103 -- upvalues: u29 (val) -- types: a1: userdata?
    if a1 == nil then
        return nil
    end
    for i, j in a1:GetChildren() do
        if u29.IsRod(j) then
            return j
        end
    end
    return nil
end

function u29.QuestMarkers() -- Line: 115 -- upvalues: Workspace (val), HalloweenDimension (val), GhostDogQuest (val)
    local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
    local v2 = v1 and v1:FindFirstChild(GhostDogQuest.FolderName)
    v1 = v2 and v2:FindFirstChild(GhostDogQuest.MarkersName)
    if v1 ~= nil and v1:IsA("Folder") then
        return v1
    end
    return nil
end

function u29.QuestPoint(a1) -- Line: 122 -- upvalues: u29 (val) -- types: a1: string
    local v1 = u29.QuestMarkers()
    local v2 = v1 and v1:FindFirstChild(a1)
    if v2 ~= nil and v2:IsA("BasePart") then
        return v2.Position
    end
    return nil
end

function u29.FlatDistance(a1, a2) -- Line: 128 -- types: a1: vector, a2: vector
    return Vector3.new(a1.X - a2.X, 0, a1.Z - a2.Z).Magnitude
end

function u29.NearQuestTarget(a1) -- Line: 132 -- upvalues: u29 (val), FishingFlags (val) -- types: a1: vector
    local CastTarget = u29.QuestPoint("CastTarget")
    local v1 = false
    if CastTarget ~= nil then
        v1 = false
        if (u29.FlatDistance(a1, CastTarget)) <= FishingFlags.QuestRadius:Get() then
            v1 = (math.abs(a1.Y - CastTarget.Y)) <= 24
        end
    end
    return v1
end

function u29.IsWaterHit(a1) -- Line: 139 -- upvalues: CollectionService (val) -- types: a1: userdata
    if a1.Material == Enum.Material.Water then
        return true
    end
    local Instance = a1.Instance
    local v1 = true
    if Instance:GetAttribute("TerrainRole") ~= "Basin" then
        v1 = true
        if Instance:GetAttribute("FishingWater") ~= true then
            v1 = CollectionService:HasTag(Instance, "FishingWater")
        end
    end
    return v1
end

function u29.Probe(a1, a2) -- Line: 149 -- upvalues: u29 (val), Workspace (val) -- types: a1: vector, a2: table
    local Instance, Y, v1
    local v2 = table.clone(a2)
    local v3 = RaycastParams.new()
    v3.FilterType = Enum.RaycastFilterType.Exclude
    v3.IgnoreWater = false
    v3.FilterDescendantsInstances = v2
    local CastTarget = u29.QuestPoint("CastTarget")
    local v4 = false
    if CastTarget ~= nil then
        v4 = u29.NearQuestTarget(a1)
    end
    local v5 = a1 + Vector3.new(0, 40, 0)
    local v6 = false
    local v7 = a1
    for i = 1, 16 do
        v1 = Workspace:Raycast(v5, Vector3.new(0, -180, 0), v3)
        if v1 == nil then
            break
        end
        if u29.IsWaterHit(v1) then
            return {Water = true, Point = v1.Position}
        end
        Instance = v1.Instance
        if Instance:IsA("BasePart") and 0.95 <= Instance.Transparency then
            table.insert(v2, Instance)
            v3.FilterDescendantsInstances = v2
            continue
        end
        if Instance:IsA("BasePart") and not Instance:IsA("Terrain") then
            Y = v1.Position.Y
            if v7.Y + 3 < Y then
                v6 = true
                table.insert(v2, Instance)
                v3.FilterDescendantsInstances = v2
                continue
            end
        end
        if v4 and CastTarget then
            return {
                Water = true,
                Point = Vector3.new(v7.X, math.max(v1.Position.Y, CastTarget.Y), v7.Z),
            }
        end
        return {Water = false, Point = v1.Position}
    end
    if v4 and CastTarget then
        return {Water = true, Point = Vector3.new(v7.X, CastTarget.Y, v7.Z)}
    end
    if v6 then
        return {Water = false, Point = v7}
    end
    return {Water = false, Point = v7 - Vector3.new(0, 40, 0)}
end

function u29.Aim(a1, a2, a3) -- Line: 199 -- upvalues: u29 (val) -- types: a1: vector, a2: vector, a3: number
    local v1 = Vector3.new(a2.X, 0, a2.Z)
    return a1 + (if not (0.01 < v1.Magnitude) then Vector3.new(0, 0, -1) else v1.Unit) * u29.DistanceFor(a3)
end

return table.freeze(u29)