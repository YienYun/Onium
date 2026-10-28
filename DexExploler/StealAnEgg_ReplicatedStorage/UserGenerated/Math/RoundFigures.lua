-- Script path: ReplicatedStorage.UserGenerated.Math.RoundFigures
-- Decompile time: 1.36 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10)
return function(a1, a2, a3, a4) -- Line: 40
    -- upvalues: StableExp10 (val)
    assert(type(a1) == "number")
    local v1 = true
    if a2 ~= nil then
        v1 = type(a2) == "number"
    end
    assert(v1)
    v1 = true
    if a3 ~= nil then
        v1 = type(a3) == "number"
    end
    assert(v1)
    v1 = true
    if a4 ~= nil then
        v1 = type(a4) == "function"
    end
    assert(v1)
    if a1 == a1 and a1 ~= (1 / 0) and a1 ~= (-1 / 0) then
        v1 = a3 or 1
        local round = a4 or math.round
        local v2 = math.sign(a1)
        if v2 == 0 then
            return 0
        end
        local v3 = a1 * v2
        local v4 = math.floor((math.log10(v3))) - (a2 or 3) + 1
        local v5 = v3
        if v1 ~= 1 then
            v5 = v5 / v1
        end
        v5 = StableExp10(v5, -v4)
        v5 = round(v5)
        return StableExp10(v5 * v1, v4) * v2
    end
    return a1
end