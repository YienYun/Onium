-- Script path: ReplicatedStorage.Shared.Util.RaceRallyEligibility
-- Decompile time: 0.45 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceRallyFlags = require(ReplicatedStorage.Shared.Flags.RaceRallyFlags)
return table.freeze({
    Changed = RaceRallyFlags.SpeedPowerRequirement.Changed,
    IsEligible = function(a1) -- Line: 13 -- upvalues: RaceRallyFlags (val) -- types: a1: number
        return RaceRallyFlags.SpeedPowerRequirement:Get() <= a1
    end,
})