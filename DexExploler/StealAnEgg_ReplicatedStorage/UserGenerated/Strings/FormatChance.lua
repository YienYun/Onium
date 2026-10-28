-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatChance
-- Decompile time: 1.29 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatOdds = require(ReplicatedStorage.UserGenerated.Strings.FormatOdds)
local FormatPercent = require(ReplicatedStorage.UserGenerated.Strings.FormatPercent)
return function(a1, a2) -- Line: 31 -- upvalues: FormatOdds (val), FormatPercent (val) -- types: a1: number, a2: number?
    assert(type(a1) == "number")
    local v1 = true
    if a2 ~= nil then
        v1 = type(a2) == "number"
    end
    assert(v1)
    local v2 = math.clamp(a1, 0, 1)
    local v3 = math.clamp(a2 or v2, 0, 1)
    if v2 > 0 and v3 <= 0.0002 and v2 <= 0.001 then
        return FormatOdds(v2)
    end
    return FormatPercent(v2)
end