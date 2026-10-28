-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.PositionalRandom
-- Decompile time: 3.42 ms

local function Mix(a1, a2, a3) -- Line: 20 -- types: a1: number, a2: number, a3: number
    local v1 = bit32.bor(a1, 0)
    local v2 = bit32.bor(a2, 0)
    local v3 = bit32.bor(a3, 0)
    v1 = v1 - v2
    v1 = v1 - v3
    v1 = bit32.bxor(v1, (bit32.rshift(v3, 13)))
    v2 = v2 - v3
    v2 = v2 - v1
    v2 = bit32.bxor(v2, (bit32.lshift(v1, 8)))
    v3 = v3 - v1
    v3 = v3 - v2
    v3 = bit32.bxor(v3, (bit32.rshift(v2, 13)))
    v1 = v1 - v2
    v1 = v1 - v3
    v1 = bit32.bxor(v1, (bit32.rshift(v3, 12)))
    v2 = v2 - v3
    v2 = v2 - v1
    v2 = bit32.bxor(v2, (bit32.lshift(v1, 16)))
    v3 = v3 - v1
    v3 = v3 - v2
    v3 = bit32.bxor(v3, (bit32.rshift(v2, 5)))
    v1 = v1 - v2
    v1 = v1 - v3
    v1 = bit32.bxor(v1, (bit32.rshift(v3, 3)))
    v2 = v2 - v3
    v2 = v2 - v1
    v2 = bit32.bxor(v2, (bit32.lshift(v1, 10)))
    v3 = v3 - v1
    v3 = v3 - v2
    return (bit32.bxor(v3, (bit32.rshift(v2, 15))))
end

local function Unpack64(a1) -- Line: 52 -- types: a1: number
    if not (a1 < 0) then
        return (bit32.bor(a1 // 4294967296, 0)), (bit32.bor(a1, 0))
    end
    local v1 = -1 - a1
    return (bit32.bnot(v1 // 4294967296)), (bit32.bnot(v1))
end

local function ParseUUID(a1) -- Line: 65 -- types: a1: string
    return (tonumber(string.sub(a1, 1, 8), 16)), (tonumber((string.sub(a1, 10, 13)) .. string.sub(a1, 15, 18), 16)), (tonumber((string.sub(a1, 20, 23)) .. string.sub(a1, 25, 28), 16)), (tonumber(string.sub(a1, 29, 36), 16))
end

return table.freeze({
    Mix = Mix,
    DoubleFromInt64 = function(a1, a2) -- Line: 60 -- upvalues: Mix (val) -- types: a1: number, a2: number
        local v1, v2
        if not (a1 < 0) then
            v1 = bit32.bor(a1 // 4294967296, 0)
            v2 = bit32.bor(a1, 0)
        else
            local v3 = -1 - a1
            v1 = bit32.bnot(v3 // 4294967296)
            v2 = bit32.bnot(v3)
        end
        return Mix(v2, v1, a2) / 4294967296
    end,
    DoubleFromUUID = function(a1, a2) -- Line: 71 -- upvalues: Mix (val) -- types: a1: string, a2: number
        local v1 = tonumber(string.sub(a1, 1, 8), 16)
        local v2 = tonumber((string.sub(a1, 10, 13)) .. string.sub(a1, 15, 18), 16)
        local v3 = tonumber((string.sub(a1, 20, 23)) .. string.sub(a1, 25, 28), 16)
        local v4 = tonumber(string.sub(a1, 29, 36), 16)
        return Mix(Mix(v1, v2, 2197175160), Mix(v3, v4, 2821953579), a2) / 4294967296
    end,
    IntegerFromUUID = function(a1, a2, a3, a4) -- Line: 76 -- upvalues: Mix (val) -- types: a1: string, a2: number, a3: number, a4: number
        return (math.floor(a3 + (a4 - a3 + 1) * ((Mix(
            Mix(tonumber(string.sub(a1, 1, 8), 16), tonumber((string.sub(a1, 10, 13)) .. string.sub(a1, 15, 18), 16), 2197175160),
            Mix(tonumber((string.sub(a1, 20, 23)) .. string.sub(a1, 25, 28), 16), tonumber(string.sub(a1, 29, 36), 16), 2821953579),
            a2
        )) / 4294967296)))
    end,
})