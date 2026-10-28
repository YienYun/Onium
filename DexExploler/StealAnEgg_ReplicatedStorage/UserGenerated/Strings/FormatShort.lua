-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatShort
-- Decompile time: 2.19 ms

local u0 = {"k", "m", "b", "t", "q", "Qt", "Sx", "Sp", "o", "n", "d", "u", "Du", "Tr"}
return function(a1, a2, a3) -- Line: 38 -- upvalues: u0 (val) -- types: a1: number, a2: number?, a3: number?
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
    if a1 ~= a1 then
        return "NaN"
    end
    if a1 == (1 / 0) then
        return "Infinity"
    end
    if a1 == (-1 / 0) then
        return "-Infinity"
    end
    local v2 = a2 or 3
    local v3 = math.max(math.abs(a1), (math.pow(10, -#u0 * 3)))
    v1 = 10 ^ (math.min(math.ceil((math.log10(v3))), #u0 * 3 + v2) - (a3 or 0) - v2)
    local v4 = math.round(v3 / v1) * v1
    v3 = math.min(math.floor((math.log10((math.max(v4, 1)))) / 3), #u0)
    v4 = v4 * math.sign(a1) / 10 ^ (v3 * 3)
    v1 = string.format("%f", v4):gsub("%.?0+$", "")
    if v3 >= 1 then
        return v1 .. u0[v3]
    end
    return v1
end