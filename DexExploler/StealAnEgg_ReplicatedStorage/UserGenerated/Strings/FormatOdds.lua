-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatOdds
-- Decompile time: 0.54 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated)
return function(a1) -- Line: 24 -- upvalues: FormatAbbreviated (val) -- types: a1: number
    assert(type(a1) == "number")
    if a1 == 0 then
        return "0"
    end
    if a1 == (1 / 0) then
        return "Infinity"
    end
    if a1 == (-1 / 0) then
        return "-Infinity"
    end
    if a1 ~= a1 then
        return "NaN"
    end
    return "1/" .. FormatAbbreviated(1 / a1)
end