-- Script path: ReplicatedStorage.Shared.Utils.GuardEscape
-- Decompile time: 0.81 ms

local GuardRequirements = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardRequirements
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardEscapePrediction = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction)
require(ReplicatedStorage.Shared.Modules.GuardAreas.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local u41 = t.strict(t.table)

function v1.RequiredSpeedPower(a1) -- Line: 27
    -- upvalues: u41 (val), GuardEscapePrediction (val), GuardRequirements (val), TreadmillUtil (val)
    u41(a1)
    return TreadmillUtil.RoundSpeedPowerRequirement((TreadmillUtil.WalkSpeedToSpeedPower((GuardEscapePrediction.ResolvePlayerWalkSpeedRequirement(a1, GuardRequirements.CARRY_SPEED_RATIO)))) * GuardRequirements.REQUIREMENT_MARGIN)
end

return v1