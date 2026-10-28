-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetPersonalityMotion
-- Decompile time: 3.01 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetWanderArea = require(script.Parent.AssetWanderArea)
require(ReplicatedStorage.Data.Assets)
local Player = require(ReplicatedStorage.Shared.Player)
local u18 = {}

local function isolatedPointFromOwner(a1, a2, a3) -- Line: 25
    -- upvalues: AssetWanderArea (val)
    local v1, v2 = AssetWanderArea.HalfExtents(a1)
    local v3 = a1.CFrame:PointToObjectSpace(a3)
    local v4 = if not (0 <= v3.X) then a2:NextNumber(0, v1) else a2:NextNumber(-v1, 0)
    return (a1.CFrame * CFrame.new(v4, 0, if not (0 <= v3.Z) then a2:NextNumber(0, v2) else a2:NextNumber(-v2, 0))).Position
end

function u18.StepIdle(a1, a2, a3, a4, a5) -- Line: 46 -- types: a1: number, a2: number, a3: number, a4: userdata
    local v1 = math.max(a2 - a1, 0)
    local v2 = a3 + a1
    local v3 = a4
    if a5 ~= nil and v1 > 0 then
        local v4 = a5.Amplitude * math.min(math.clamp(v2 / 0.2, 0, 1), (math.clamp(v1 / 0.2, 0, 1)))
        local v5 = v2 * a5.CyclesPerSecond * 3.141592653589793 * 2
        v3 = a4 * CFrame.new(math.sin(v5) * v4, 0, math.sin(v5 * 1.37 + 1.0471975511965976) * v4)
    end
    return v3, v1, v2, v1 <= 0
end

function u18.ChooseDestination(a1, a2, a3, a4) -- Line: 69
    -- upvalues: isolatedPointFromOwner (val), AssetWanderArea (val)
    if a4 ~= nil and (a2:NextNumber()) < a3.IsolationPreference then
        return (isolatedPointFromOwner(a1, a2, a4))
    end
    if a4 ~= nil and (a2:NextNumber()) < a3.NearOwnerPreference then
        return AssetWanderArea.ClampedPointToward(a1, a4)
    end
    return AssetWanderArea.RandomPoint(a1, a2)
end

function u18.RandomOwnerOffset(a1, a2, a3) -- Line: 85 -- types: a1: userdata, a2: userdata, a3: number
    local v1 = a2:NextNumber(0, 6.283185307179586)
    return a1.CFrame:VectorToWorldSpace((Vector3.new(math.cos(v1) * a3, 0, (math.sin(v1)) * a3)))
end

function u18.RollChance(a1, a2) -- Line: 96 -- types: a1: userdata, a2: number
    if a2 <= 0 then
        return false
    end
    if a2 >= 1 then
        return true
    end
    return a1:NextNumber() <= a2
end

function u18.RandomConfiguredText(a1, a2, a3, a4) -- Line: 107 -- types: a1: userdata, a2: table, a4: string
    assert(#a2 > 0, (("Personality %* requires at least one %* text"):format(a3, a4)))
    return a2[a1:NextInteger(1, #a2)]
end

function u18.OwnerRootPosition(a1) -- Line: 117 -- upvalues: Player (val) -- types: a1: userdata
    local v1 = Player.FindPrimaryPart(a1)
    if v1 ~= nil then
        return v1.Position
    end
    return nil
end

function u18.DistanceFromPlayerToAreaCenter(a1, a2) -- Line: 122
    -- upvalues: u18 (val)
    local v1 = u18.OwnerRootPosition(a1)
    if v1 ~= nil then
        return (v1 - a2.Position).Magnitude
    end
    return nil
end

function u18.ShouldStartAmbientJump(a1, a2, a3, a4) -- Line: 130
    -- upvalues: 
    if not (a2 <= 0) and not a4 then
        local v1 = 1 - (math.exp(-a2 * a3))
        return a1:NextNumber() <= v1
    end
    return false
end

return u18