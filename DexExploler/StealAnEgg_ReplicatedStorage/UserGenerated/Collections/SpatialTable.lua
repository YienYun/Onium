-- Script path: ReplicatedStorage.UserGenerated.Collections.SpatialTable
-- Decompile time: 5.75 ms

local function hash(a1, a2, a3) -- Line: 45 -- types: a1: number, a2: number, a3: number
    return (bit32.band(a1, 262143) * 262144 + bit32.band(a3, 262143)) * 131072 + bit32.band(a2, 131071)
end

local function quantize(a1, a2) -- Line: 49 -- types: a1: vector, a2: number
    return a1.X // a2, a1.Y // a2, a1.Z // a2
end

local function key(a1, a2) -- Line: 53 -- types: a1: vector, a2: number
    local v1 = a1.X // a2
    local v2 = a1.Y // a2
    local v3 = a1.Z // a2
    return (bit32.band(v1, 262143) * 262144 + bit32.band(v3, 262143)) * 131072 + bit32.band(v2, 131071)
end

local v1 = {}
local u6 = table.freeze({__index = v1})

function v1.Insert(a1, a2, a3) -- Line: 63
    assert(typeof(a2) == "Vector3")
    local Epsilon = a1.Epsilon
    local v1 = a2.X // Epsilon
    local v2 = a2.Y // Epsilon
    local v3 = a2.Z // Epsilon
    local v4 = (bit32.band(v1, 262143) * 262144 + bit32.band(v3, 262143)) * 131072 + bit32.band(v2, 131071)
    local Table = a1.Table
    if not Table[v4] then
        Table[v4] = {}
    end
    table.insert(Table[v4], {Pos = a2, Value = a3})
end

function v1.Remove(a1, a2, a3) -- Line: 75
    assert(typeof(a2) == "Vector3")
    local Epsilon = a1.Epsilon
    local v1 = a2.X // Epsilon
    local v2 = a2.Y // Epsilon
    local v3 = a2.Z // Epsilon
    local v4 = (bit32.band(v1, 262143) * 262144 + bit32.band(v3, 262143)) * 131072 + bit32.band(v2, 131071)
    local v5 = a1.Table[v4]
    if not v5 then
        return
    end
    for i = #v5, 1, -1 do
        if v5[i].Value == a3 then
            table.remove(v5, i)
        end
    end
    if #v5 == 0 then
        local v6
        v6.Table[v4] = nil
    end
end

function v1.Collect(a1, a2, a3) -- Line: 94
    local v1, v2, v3
    assert(typeof(a2) == "Vector3")
    local v4 = true
    if a3 ~= nil then
        v4 = false
        if type(a3) == "number" then
            v4 = false
            if a3 > 0 then
                v4 = math.floor(a3) == a3
            end
        end
    end
    assert(v4)
    local Epsilon = a1.Epsilon
    local v5 = a2.X // Epsilon
    v4 = a2.Y // Epsilon
    local v6 = a2.Z // Epsilon
    local v7 = a3 or 1
    local v8 = {}
    local v9 = 0
    for i = -v7, v7 do
        for j = -v7, v7 do
            for k = -v7, v7 do
                v1 = v5 + i
                v2 = v4 + j
                v3 = v6 + k
                v1 = a1.Table[(bit32.band(v1, 262143) * 262144 + bit32.band(v3, 262143)) * 131072 + bit32.band(v2, 131071)]
                if v1 then
                    for i2, v in ipairs(v1) do
                        v9 = v9 + 1
                        v8[v9] = v.Value
                    end
                end
            end
        end
    end
    v8.n = v9
    return v8
end

function v1.Query(a1, a2, a3) -- Line: 122
    local Magnitude, v1, v2, v3
    assert(typeof(a2) == "Vector3")
    local v4 = true
    if a3 ~= nil then
        v4 = false
        if type(a3) == "number" then
            v4 = false
            if a3 > 0 then
                v4 = math.floor(a3) == a3
            end
        end
    end
    assert(v4)
    local Epsilon = a1.Epsilon
    local v5 = a2.X // Epsilon
    v4 = a2.Y // Epsilon
    local v6 = a2.Z // Epsilon
    local v7 = a3 or 1
    local Value = nil
    local v8 = nil
    for i = -v7, v7 do
        for j = -v7, v7 do
            for k = -v7, v7 do
                v1 = v5 + i
                v2 = v4 + j
                v3 = v6 + k
                v1 = a1.Table[(bit32.band(v1, 262143) * 262144 + bit32.band(v3, 262143)) * 131072 + bit32.band(v2, 131071)]
                if v1 then
                    for i2, v in ipairs(v1) do
                        Magnitude = (v.Pos - a2).Magnitude
                        if not v8 or Magnitude < v8 then
                            Value = v.Value
                        end
                    end
                end
            end
        end
    end
    return Value
end

table.freeze(v1)
return table.freeze({
    new = function(a1, a2) -- Line: 156 -- upvalues: u6 (val) -- types: a1: number?
        local v1 = true
        if a1 ~= nil then
            v1 = false
            if type(a1) == "number" then
                v1 = a1 > 0
            end
        end
        assert(v1)
        return (setmetatable({Table = {}, Epsilon = a1 or 10}, u6))
    end,
})