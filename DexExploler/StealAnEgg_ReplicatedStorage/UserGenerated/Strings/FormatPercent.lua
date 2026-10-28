-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatPercent
-- Decompile time: 0.30 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatFigures = require(ReplicatedStorage.UserGenerated.Strings.FormatFigures)
return function(a1) -- Line: 24 -- upvalues: FormatFigures (val) -- types: a1: number
    return (FormatFigures(a1 * 100, 4, 5)) .. "%"
end