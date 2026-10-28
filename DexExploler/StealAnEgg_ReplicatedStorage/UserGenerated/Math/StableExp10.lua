-- Script path: ReplicatedStorage.UserGenerated.Math.StableExp10
-- Decompile time: 0.43 ms

return function(a1, a2) -- Line: 25 -- types: a1: number, a2: number
    assert(type(a1) == "number")
    assert(type(a2) == "number")
    if a2 == 0 then
        return a1
    end
    local v1 = tonumber((("%*e%*"):format(string.format("%f", a1), a2)))
    if not v1 then
        return a1 * 10 ^ a2
    end
    return v1
end