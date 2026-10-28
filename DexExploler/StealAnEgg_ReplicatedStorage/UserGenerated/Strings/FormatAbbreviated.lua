-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated
-- Decompile time: 2.66 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures)
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10)
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString)
local u20 = {"", "k", "m", "b", "t", "q", "Qt", "Sx", "Sp", "o", "n", "d", "u", "Du", "Tr"}
return function(a1) -- Line: 66
    -- upvalues: u20 (val), StableExp10 (val), RoundFigures (val), TrimmedNumberString (val)
    local v1
    assert(type(a1) == "number")
    if a1 ~= a1 then
        return "NaN"
    end
    if a1 == (1 / 0) then
        return "Infinity"
    end
    if a1 == (-1 / 0) then
        return "-Infinity"
    end
    local v2 = {}
    if not (a1 < 0) then
        v1 = a1
    else
        table.insert(v2, "-")
        v1 = -a1
    end
    v1 = math.floor(v1)
    if not (v1 >= 1000) then
        table.insert(v2, (TrimmedNumberString(v1)))
    else
        local v3 = math.clamp((math.floor((math.log10(v1)) / 3)) + 1, 1, #u20)
        v1 = StableExp10(v1, (v3 - 1) * -3)
        table.insert(v2, (TrimmedNumberString((RoundFigures(v1, 3, nil, math.floor)))))
        table.insert(v2, u20[v3])
    end
    return table.concat(v2)
end