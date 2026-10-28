-- Script path: ReplicatedStorage.Shared.Utils.Time
-- Decompile time: 3.89 ms

local u0 = {
    {seconds = 86400, symbol = "d"},
    {seconds = 3600, symbol = "h"},
    {seconds = 60, symbol = "m"},
    {seconds = 1, symbol = "s"},
}
local u5 = #u0
local u8 = utf8.char(8734)
local v1 = {}

local function wholeSeconds(a1) -- Line: 18 -- types: a1: number
    if a1 == a1 and a1 ~= (1 / 0) then
        return (math.ceil((math.max(a1, 0))))
    end
    return nil
end

local function nonFiniteText(a1) -- Line: 25 -- upvalues: u8 (val) -- types: a1: number
    if a1 ~= a1 then
        return "NaN"
    end
    return u8
end

local function splitUnits(a1) -- Line: 30 -- upvalues: u0 (val) -- types: a1: number
    local v1 = table.create(#u0)
    local v2 = a1
    for i, j in u0 do
        v1[i] = v2 // j.seconds
        v2 = v2 % j.seconds
    end
    return v1
end

local function leadingUnit(a1) -- Line: 41 -- upvalues: u5 (val), u0 (val) -- types: a1: number
    local v1 = u5 - 1
    for i = 1, v1 do
        if u0[i].seconds <= a1 then
            return i
        end
    end
    return u5
end

function v1.Timecode(a1) -- Line: 54 -- upvalues: u8 (val), u5 (val), u0 (val) -- types: a1: number
    local v1, v2, v3
    assert(type(a1) == "number", "seconds must be a number")
    if (if a1 ~= a1 then nil else if a1 ~= (1 / 0) then math.ceil((math.max(a1, 0))) else nil) == nil then
        if a1 ~= a1 then
            return "NaN"
        end
        return u8
    end
    local v4 = u5 - 1
    for i = 1, v4 do
        if u0[i].seconds <= v1 then
            if i == u5 then
                return (("%*s"):format(v1))
            end
            v4 = table.create(#u0)
            v3 = v1
            for j, k in u0 do
                v4[j] = v3 // k.seconds
                v3 = v3 % k.seconds
            end
            v1 = {(tostring(v4[v2]))}
            for n = v2 + 1, u5 do
                table.insert(v1, (string.format("%02d", v4[n])))
            end
            return table.concat(v1, ":")
        end
    end
    if u5 == u5 then
        return (("%*s"):format(v1))
    end
    v4 = table.create(#u0)
    v3 = v1
    for m, i5 in u0 do
        v4[m] = v3 // i5.seconds
        v3 = v3 % i5.seconds
    end
    v1 = {(tostring(v4[v2]))}
    for i6 = v2 + 1, u5 do
        table.insert(v1, (string.format("%02d", v4[i6])))
    end
    return table.concat(v1, ":")
end

function v1.Elapsed(a1) -- Line: 78 -- upvalues: u8 (val), u0 (val), u5 (val) -- types: a1: number
    local v1
    assert(type(a1) == "number", "seconds must be a number")
    if (if a1 ~= a1 then nil else if a1 ~= (1 / 0) then math.ceil((math.max(a1, 0))) else nil) == nil then
        if a1 ~= a1 then
            return "NaN"
        end
        return u8
    end
    local v2 = table.create(#u0)
    local v3 = v1
    for i, j in u0 do
        v2[i] = v3 // j.seconds
        v3 = v3 % j.seconds
    end
    local v4 = u5 - 1
    for k = 1, v4 do
        if u0[k].seconds <= v1 then
            v3 = k
            v1 = ("%*%*"):format(v2[v3], u0[v3].symbol)
            v4 = v3 + 1
            if v4 <= u5 and 0 < v2[v4] then
                v1 = v1 .. (" %*%*"):format(v2[v4], u0[v4].symbol)
            end
            return v1
        end
    end
    v1 = ("%*%*"):format(v2[u5], u0[v3].symbol)
    v4 = v3 + 1
    if v4 <= u5 and 0 < v2[v4] then
        v1 = v1 .. (" %*%*"):format(v2[v4], u0[v4].symbol)
    end
    return v1
end

return table.freeze(v1)