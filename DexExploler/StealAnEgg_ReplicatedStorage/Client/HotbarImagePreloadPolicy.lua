-- Script path: ReplicatedStorage.Client.HotbarImagePreloadPolicy
-- Decompile time: 1.31 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local t = require(ReplicatedStorage.Packages.t)
local u19 = t.strict(t.instanceIsA("BasePart"))
local u22 = t.strict(t.Vector3)
local u25 = t.strict(t.number)
local u30 = t.strict(t.optional(t.number))
local u31 = {CLAIM_PRELOAD_DISTANCE_STUDS = 50}

function u31.GetShortestDistanceToClaimLine(a1, a2) -- Line: 23
    -- upvalues: u19 (val), u22 (val), GuardAreaGeometry (val)
    u19(a1)
    u22(a2)
    return (math.abs((GuardAreaGeometry.SignedDistanceToLine(a1, a2))))
end

function u31.IsSpeedEligible(a1, a2) -- Line: 33 -- upvalues: u25 (val), u30 (val) -- types: a1: number, a2: number?
    u25(a1)
    u30(a2)
    local v1 = false
    if a2 ~= nil then
        v1 = a2 <= a1
    end
    return v1
end

function u31.IsWithinClaimPreloadDistance(a1) -- Line: 43 -- upvalues: u25 (val), u31 (val) -- types: a1: number
    u25(a1)
    return a1 < u31.CLAIM_PRELOAD_DISTANCE_STUDS
end

function u31.ShouldPreloadCarriedEgg(a1, a2, a3) -- Line: 49
    -- upvalues: u30 (val), u31 (val)
    u30(a3)
    local v1 = u31.IsSpeedEligible(a1, a2)
    if not v1 then
        v1 = false
        if a3 ~= nil then
            v1 = u31.IsWithinClaimPreloadDistance(a3)
        end
    end
    return v1
end

return table.freeze(u31)