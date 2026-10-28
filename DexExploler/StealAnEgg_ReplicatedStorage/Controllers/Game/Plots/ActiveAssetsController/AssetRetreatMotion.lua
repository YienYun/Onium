-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetRetreatMotion
-- Decompile time: 4.23 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetWanderArea = require(script.Parent.AssetWanderArea)
require(ReplicatedStorage.Data.Assets)
local u26 = table.freeze({
    0,
    0.6108652381980153,
    -0.6108652381980153,
    1.2217304763960306,
    -1.2217304763960306,
    1.8325957145940461,
    -1.8325957145940461,
    2.443460952792061,
    -2.443460952792061,
    3.141592653589793,
})
local v1 = {}

local function rotateLocalFlatDirection(a1, a2) -- Line: 35 -- types: a1: vector, a2: number
    local v1 = math.cos(a2)
    local v2 = math.sin(a2)
    return (Vector3.new(a1.X * v1 - a1.Z * v2, 0, a1.X * v2 + a1.Z * v1))
end

local function distanceToAreaEdge(a1, a2, a3) -- Line: 45
    -- upvalues: AssetWanderArea (val)
    local v1, v2 = AssetWanderArea.HalfExtents(a1)
    local v3 = (1 / 0)
    local v4 = (1 / 0)
    if 0 < a3.X then
        v3 = (v1 - a2.X) / a3.X
    elseif a3.X < 0 then
        v3 = (-v1 - a2.X) / a3.X
    end
    if 0 < a3.Z then
        v4 = (v2 - a2.Z) / a3.Z
    elseif a3.Z < 0 then
        v4 = (-v2 - a2.Z) / a3.Z
    end
    return (math.max(math.min(v3, v4) - 2, 0))
end

local function ownerAwayDirection(a1, a2, a3) -- Line: 68 -- types: a1: userdata, a2: vector, a3: vector
    local v1 = Vector3.new(a3.X - a2.X, 0, a3.Z - a2.Z)
    if 0 < v1.Magnitude then
        return v1.Unit
    end
    v1 = Vector3.new(a3.X - a1.Position.X, 0, a3.Z - a1.Position.Z)
    if 0 < v1.Magnitude then
        return v1.Unit
    end
    local LookVector = a1.CFrame.LookVector
    local v2 = Vector3.new(LookVector.X, 0, LookVector.Z)
    assert(0 < v2.Magnitude, "Asset area must provide a horizontal retreat direction")
    return v2.Unit
end

function v1.Destination(a1, a2, a3, a4, a5) -- Line: 98
    -- upvalues: ownerAwayDirection (val), u26 (val), distanceToAreaEdge (val), AssetWanderArea (val)
    local Unit_2, v1, v2, v3
    local v4 = a1.CFrame:PointToObjectSpace(a5)
    local v5 = a1.CFrame:VectorToObjectSpace((ownerAwayDirection(a1, a4, a5)))
    local v6 = Vector3.new(v5.X, 0, v5.Z)
    assert(0 < v6.Magnitude, "Retreat direction must be horizontal")
    local Unit = v6.Unit
    v6 = Unit
    local v7 = 0
    local v8 = (-1 / 0)
    for i, v in ipairs(u26) do
        v1 = math.cos(v)
        v2 = math.sin(v)
        Unit_2 = Vector3.new(Unit.X * v1 - Unit.Z * v2, 0, Unit.X * v2 + Unit.Z * v1).Unit
        v1 = distanceToAreaEdge(a1, v4, Unit_2)
        v3 = v1 * (math.max(Unit_2:Dot(Unit), 0) + 0.6)
        if v8 < v3 then
            v7 = v1
            v6 = Unit_2
        end
    end
    if v7 <= 0 then
        return AssetWanderArea.RandomPoint(a1, a2)
    end
    v7 = v4 + v6 * (if a3.MaxTravelDistance == nil then v7 else math.min(a3.MaxTravelDistance, v7))
    return (a1.CFrame * CFrame.new(v7.X, 0, v7.Z)).Position
end

return v1