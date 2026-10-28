-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction
-- Decompile time: 5.37 ms

local GuardPrediction = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardPrediction
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local u32 = {}

local function resolveHorizontalDirection(a1) -- Line: 27 -- types: a1: vector
    local v1 = Vector3.new(a1.X, 0, a1.Z)
    assert(1e-06 < v1.Magnitude)
    return v1.Unit
end

local function resolveAtSpeed(a1, a2) -- Line: 35 -- upvalues: GuardChasePolicy (val) -- types: a2: number
    if a2 == 0 then
        return {ExitTime = (1 / 0), Outcome = "Caught", CatchTime = GuardChasePolicy.GetWakingDuration()}
    end
    local v1 = a1.ExitDistance / a2
    local v2 = GuardChasePolicy.GetWakingDuration()
    if v1 <= v2 then
        return {Outcome = "EscapedSafely", ExitTime = v1}
    end
    local ExitDirection = a1.ExitDirection
    local v3 = Vector3.new(ExitDirection.X, 0, ExitDirection.Z)
    assert(1e-06 < v3.Magnitude)
    local Unit = v3.Unit
    local v4 = ((a1.PlayerStartPosition - a1.GuardStartPosition):Dot(Unit)) + a2 * v2
    if v4 <= a1.HitDistance then
        return {Outcome = "Caught", CatchTime = v2, ExitTime = v1}
    end
    v3 = GuardChasePolicy.ResolveCatchDuration(a1.BaseGuardWalkSpeed, a1.FlatRadius, a1.HitDistance, v4, a2)
    v4 = if v3 == nil then nil else v2 + v3
    v3 = false
    if v4 ~= nil then
        v3 = v4 < v1
    end
    return {CatchTime = v4, ExitTime = v1, Outcome = if not v3 then "EscapedSafely" else "Caught"}
end

function u32.ResolveExitDistance(a1, a2, a3, a4) -- Line: 92
    -- upvalues: t (val)
    t.strict(t.CFrame)(a1)
    t.strict(t.Vector3)(a2)
    t.strict(t.Vector3)(a3)
    t.strict(t.Vector3)(a4)
    local v1 = Vector3.new(a4.X, 0, a4.Z)
    assert(1e-06 < v1.Magnitude)
    local Unit = v1.Unit
    v1 = a1:PointToObjectSpace(a3)
    local v2 = a1:VectorToObjectSpace(Unit)
    local v3 = a2 * 0.5
    assert((math.abs(v1.X)) <= v3.X + 1e-06)
    assert((math.abs(v1.Z)) <= v3.Z + 1e-06)
    local v4 = (1 / 0)
    if 1e-06 < (math.abs(v2.X)) then
        local X_4 = if not (0 < v2.X) then -v3.X else v3.X
        v4 = (X_4 - v1.X) / v2.X
    end
    local v5 = (1 / 0)
    if 1e-06 < (math.abs(v2.Z)) then
        local Z_4 = if not (0 < v2.Z) then -v3.Z else v3.Z
        v5 = (Z_4 - v1.Z) / v2.Z
    end
    v2 = math.min(v4, v5)
    local v6 = false
    if v2 >= 0 then
        v6 = v2 < (1 / 0)
    end
    assert(v6)
    return v2
end

function u32.ResolvePlayerWalkSpeedRequirement(a1, a2) -- Line: 134
    -- upvalues: t (val), GuardChasePolicy (val), resolveAtSpeed (val)
    local v1
    t.strict(t.table)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a1.BaseGuardWalkSpeed)
    t.strict(t.Vector3)(a1.ExitDirection)
    t.strict(t.number)(a1.ExitDistance)
    t.strict(t.number)(a1.FlatRadius)
    t.strict(t.Vector3)(a1.GuardStartPosition)
    t.strict(t.number)(a1.HitDistance)
    t.strict(t.Vector3)(a1.PlayerStartPosition)
    assert(0 < a1.BaseGuardWalkSpeed)
    assert(0 <= a1.ExitDistance)
    assert(0 < a1.FlatRadius)
    assert(0 < a1.HitDistance)
    local v2 = false
    if a2 > 0 then
        v2 = a2 <= 1
    end
    assert(v2)
    if a1.ExitDistance == 0 then
        return 0
    end
    v2 = 0
    local v3 = a1.ExitDistance / (GuardChasePolicy.GetWakingDuration()) / a2
    local v4, v5 = a2, a1
    for i = 1, 48 do
        v1 = (v2 + v3) * 0.5
        if resolveAtSpeed(v5, v1 * v4).Outcome ~= "Caught" then
            v3 = v1
        end
    end
    return v3
end

function u32.ResolveGreenPlayerWalkSpeedRequirement(a1) -- Line: 175 -- upvalues: u32 (val), GuardPrediction (val)
    return u32.ResolvePlayerWalkSpeedRequirement(a1, GuardPrediction.FULL_GREEN_EGG_CARRY_SPEED_RATIO)
end

function u32.ResolveSlowdownTolerance(a1, a2) -- Line: 184 -- upvalues: t (val) -- types: a1: number, a2: number
    t.strict(t.number)(a1)
    t.strict(t.number)(a2)
    assert(a1 >= 0)
    assert(a2 >= 0)
    if a1 == 0 then
        return 1
    end
    if a2 == 0 then
        return -1
    end
    return 1 - a1 / a2
end

function u32.Resolve(a1) -- Line: 204 -- upvalues: t (val), resolveAtSpeed (val), GuardPrediction (val)
    t.strict(t.table)(a1)
    t.strict(t.number)(a1.BaseGuardWalkSpeed)
    t.strict(t.Vector3)(a1.ExitDirection)
    t.strict(t.number)(a1.ExitDistance)
    t.strict(t.number)(a1.FlatRadius)
    t.strict(t.Vector3)(a1.GuardStartPosition)
    t.strict(t.number)(a1.HitDistance)
    t.strict(t.number)(a1.PlayerWalkSpeed)
    t.strict(t.Vector3)(a1.PlayerStartPosition)
    assert(0 < a1.BaseGuardWalkSpeed)
    assert(0 <= a1.ExitDistance)
    assert(0 < a1.FlatRadius)
    assert(0 < a1.HitDistance)
    assert(0 <= a1.PlayerWalkSpeed)
    local v1 = resolveAtSpeed(a1, a1.PlayerWalkSpeed)
    if v1.Outcome == "Caught" then
        return v1
    end
    return {
        CatchTime = v1.CatchTime,
        ExitTime = v1.ExitTime,
        Outcome = if (resolveAtSpeed(a1, a1.PlayerWalkSpeed * GuardPrediction.FULL_GREEN_EGG_CARRY_SPEED_RATIO)).Outcome ~= "Caught" then "EscapedSafely" else "EscapedAtRisk",
    }
end

return u32