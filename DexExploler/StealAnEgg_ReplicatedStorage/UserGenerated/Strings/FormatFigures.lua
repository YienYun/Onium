-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatFigures
-- Decompile time: 0.35 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures)
local Commas = require(ReplicatedStorage.UserGenerated.Strings.Commas)
return function(a1, a2, a3, a4) -- Line: 44
    -- upvalues: Commas (val), RoundFigures (val)
    return Commas(RoundFigures(a1, a2, a3, a4))
end