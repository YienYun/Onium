-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardChasePolicy
-- Decompile time: 2.66 ms

local GuardChase = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardChase
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u20 = {}

function u20.GetWakingDuration() -- Line: 23 -- upvalues: GuardChase (val)
    return GuardChase.WAKING_DURATION
end

function u20.ResolveHitDistance(a1) -- Line: 27 -- upvalues: t (val), GuardChase (val) -- types: a1: number?
    t.strict(t.optional(t.number))(a1)
    local DEFAULT_HIT_DISTANCE = a1 or GuardChase.DEFAULT_HIT_DISTANCE
    assert(DEFAULT_HIT_DISTANCE > 0)
    return DEFAULT_HIT_DISTANCE
end

function u20.ResolveWalkSpeed(a1, a2, a3) -- Line: 37
    -- upvalues: t (val), GuardChase (val)
    t.strict(t.number)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    assert(a1 > 0)
    assert(a2 > 0)
    assert(a3 >= 0)
    local v1 = math.max(a2, 0.001)
    if a3 <= v1 then
        return a1
    end
    return (math.min(a1 * (1 + (a3 / v1 - 1) * GuardChase.DISTANCE_MULTIPLIER_STRENGTH), a1 * GuardChase.MAX_DISTANCE_MULTIPLIER))
end

function u20.ResolveCatchDuration(a1, a2, a3, a4, a5) -- Line: 64
    -- upvalues: t (val), u20 (val), GuardChase (val)
    t.strict(t.number)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    t.strict(t.number)(a4)
    t.strict(t.number)(a5)
    assert(a1 > 0)
    assert(a2 > 0)
    assert(a3 > 0)
    assert(a4 >= 0)
    assert(a5 >= 0)
    if a4 <= a3 then
        return 0
    end
    if u20.ResolveWalkSpeed(a1, a2, a3) <= a5 then
        return nil
    end
    local v1 = math.max(a2, 0.001)
    local v2 = v1 * (1 + (GuardChase.MAX_DISTANCE_MULTIPLIER - 1) / GuardChase.DISTANCE_MULTIPLIER_STRENGTH)
    local v3 = 0
    local v4 = math.max(a3, v2)
    if v4 < a4 then
        v3 = v3 + (a4 - v4) / (a1 * GuardChase.MAX_DISTANCE_MULTIPLIER - a5)
    end
    v4 = math.max(a3, v1)
    local v5 = math.min(a4, v2)
    if v4 < v5 then
        v2 = a1 * GuardChase.DISTANCE_MULTIPLIER_STRENGTH / v1
        local v6 = a1 * (1 - GuardChase.DISTANCE_MULTIPLIER_STRENGTH)
        v3 = v3 + math.log((v6 + v2 * v5 - a5) / (v6 + v2 * v4 - a5)) / v2
    end
    v5 = math.min(a4, v1)
    if a3 < v5 then
        v3 = v3 + (v5 - a3) / (a1 - a5)
    end
    return v3
end

return u20