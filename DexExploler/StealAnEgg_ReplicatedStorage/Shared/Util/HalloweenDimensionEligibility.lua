-- Script path: ReplicatedStorage.Shared.Util.HalloweenDimensionEligibility
-- Decompile time: 0.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HalloweenDimensionFlags = require(ReplicatedStorage.Shared.Flags.HalloweenDimensionFlags)
local FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated)
local u15 = {GateArea = "Abyss Ocean"}

function u15.RequiredSpeedPower() -- Line: 23 -- upvalues: HalloweenDimensionFlags (val)
    return HalloweenDimensionFlags.SpeedPowerRequirement:Get()
end

function u15.RequirementText() -- Line: 27 -- upvalues: FormatAbbreviated (val), u15 (val)
    return string.upper(FormatAbbreviated(u15.RequiredSpeedPower()))
end

function u15.IsEligible(a1) -- Line: 31 -- upvalues: u15 (val) -- types: a1: number
    return u15.RequiredSpeedPower() <= a1
end

return table.freeze(u15)