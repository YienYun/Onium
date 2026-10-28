-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.CRC32
-- Decompile time: 2.86 ms

local v1
local u48 = {}
for i = 0, 255 do
    v1 = i
    for j = 1, 8 do
        v1 = if bit32.band(v1, 1) == 0 then bit32.rshift(v1, 1) else bit32.bxor(bit32.rshift(v1, 1), 3988292384)
    end
    u48[i + 1] = v1
end
local u59 = {}

function u59.Init() -- Line: 44
    return 4294967295
end

function u59.Update(a1, a2, a3, a4) -- Line: 48
    -- upvalues: u48 (val)
    local v1
    local v2 = a3 or 1
    local v3 = v2 + (a4 or string.len(a2)) - 1
    local v4 = a1
    for i = v2, v3 do
        v1 = string.byte(a2, i)
        v4 = bit32.bxor(bit32.rshift(v4, 8), u48[(bit32.band(bit32.bxor(v4, v1), 255)) + 1])
    end
    return v4
end

function u59.UpdateBuffer(a1, a2, a3, a4) -- Line: 59
    -- upvalues: u48 (val)
    local v1
    local v2 = a3 or 0
    local v3 = v2 + (a4 or buffer.len(a2)) - 1
    local v4 = a1
    for i = v2, v3 do
        v1 = buffer.readu8(a2, i)
        v4 = bit32.bxor(bit32.rshift(v4, 8), u48[(bit32.band(bit32.bxor(v4, v1), 255)) + 1])
    end
    return v4
end

function u59.Finish(a1) -- Line: 70 -- types: a1: number
    return (bit32.bnot(a1))
end

function u59.Digest(a1, a2, a3) -- Line: 74 -- upvalues: u59 (val) -- types: a1: string, a2: number?, a3: number?
    return u59.Finish((u59.Update(u59.Init(), a1, a2, a3)))
end

function u59.DigestBuffer(a1, a2, a3) -- Line: 80 -- upvalues: u59 (val) -- types: a1: buffer, a2: number?, a3: number?
    return u59.Finish((u59.UpdateBuffer(u59.Init(), a1, a2, a3)))
end

return table.freeze(u59)