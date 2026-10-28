-- Script path: ReplicatedStorage.Shared.Utils.Checksum
-- Decompile time: 1.08 ms

local u0 = {}

local function foldByte(a1, a2) -- Line: 9 -- types: a1: number, a2: number
    local v1
    local v2 = bit32.bxor(a1, a2)
    for i = 1, 8 do
        v1 = bit32.band(v2, 1)
        v2 = bit32.rshift(v2, 1)
        if v1 == 1 then
            v2 = bit32.bxor(v2, 3988292384)
        end
    end
    return v2
end

function u0.CRC32(a1) -- Line: 21 -- upvalues: foldByte (val) -- types: a1: string
    local v1 = buffer.fromstring(a1)
    local v2 = 4294967295
    local v3 = buffer.len(v1) - 1
    for i = 0, v3 do
        v2 = foldByte(v2, (buffer.readu8(v1, i)))
    end
    return (bit32.bnot(v2))
end

function u0.PathSeed(...) -- Line: 30 -- upvalues: u0 (val)
    local v1
    local v2 = table.pack(...)
    local n = v2.n
    for i = 1, n do
        v1 = v2[i]
        v2[i] = (tostring(v1))
    end
    return u0.CRC32(table.concat(v2, "/", 1, v2.n))
end

return table.freeze(u0)