-- Script path: ReplicatedStorage.Shared.Util.MonsterParasiteEligibility
-- Decompile time: 0.52 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Guards = require(ReplicatedStorage.Data.Guards)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
return table.freeze({
    IsEligible = function(a1) -- Line: 14 -- upvalues: Guards (val), MonsterParasite (val), TreadmillUtil (val) -- types: a1: number
        local v1 = Guards.Directory[MonsterParasite.EligibilityGuardId]
        if v1 == nil then
            return false
        end
        return v1.WalkSpeed <= (TreadmillUtil.SpeedPowerToWalkSpeed(a1))
    end,
})