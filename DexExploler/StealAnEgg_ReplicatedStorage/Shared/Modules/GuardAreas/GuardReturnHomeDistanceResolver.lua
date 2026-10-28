-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardReturnHomeDistanceResolver
-- Decompile time: 0.44 ms

local GuardReturn = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardReturn
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return {
    Resolve = function(a1) -- Line: 21 -- upvalues: t (val), GuardReturn (val) -- types: a1: string
        t.strict(t.string)(a1)
        return GuardReturn.RETURN_HOME_DISTANCE_BY_AREA_ID[a1] or GuardReturn.DEFAULT_RETURN_HOME_DISTANCE
    end,
}