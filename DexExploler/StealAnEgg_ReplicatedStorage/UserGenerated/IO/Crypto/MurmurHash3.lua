-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.MurmurHash3
-- Decompile time: 3.04 ms

local band = bit32.band
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local bxor = bit32.bxor
local bor = bit32.bor
local len = buffer.len
local readu32 = buffer.readu32
local readu8 = buffer.readu8
local readu16 = buffer.readu16
local fromstring = buffer.fromstring

function mul32(a1, a2) -- Line: 28 -- upvalues: band (val), rshift (val), lshift (val) -- types: a1: number, a2: number
    return band(a1, 65535) * a2 + lshift(band(rshift(a1, 16) * a2, 65535), 16)
end

function DigestBufferUnsafe(a1, a2, a3, a4) -- Line: 32
    -- upvalues: bor (val), readu32 (val), lrotate (val), bxor (val), lshift (val), band (val), readu8 (val)
    -- upvalues: readu16 (val), rshift (val)
    local v1, v2
    local v3 = 0
    if a4 ~= nil then
        assert(bor(a4, 0) == a4)
        v3 = a4
    end
    local v4 = a2
    local v5 = a2 + a3 - 3
    while v4 < v5 do
        v1 = readu32(a1, v4)
        v1 = lrotate(mul32(v1, 3432918353), 15)
        mul32(v1, 461845907)
        v2 = bxor
        v2(v3, v2)
        v2 = lrotate
        v2 = v2(v2, 13)
        v3 = lshift(v2 * 5, 0) + 3864292196
        v4 = v4 + 4
    end
    v5 = band(a3, 3)
    if v5 > 0 then
        v1 = if v5 ~= 3 then if v5 ~= 2 then readu8(a1, v4) else readu16(a1, v4) else (readu8(a1, v4)) + lshift(readu16(a1, v4 + 1), 8)
        v1 = lrotate(mul32(v1, 3432918353), 15)
        v3 = bxor(v3, (mul32(v1, 461845907)))
    end
    v3 = bxor(v3, a3)
    v3 = bxor(v3, (rshift(v3, 16)))
    v3 = mul32(v3, 2246822507)
    v3 = bxor(v3, (rshift(v3, 13)))
    v3 = mul32(v3, 3266489909)
    return (bxor(v3, (rshift(v3, 16))))
end

function DigestBufferCustom(a1, a2, a3, a4) -- Line: 80
    -- upvalues: len (val)
    assert(type(a1) == "buffer")
    local v1 = false
    if type(a2) == "number" then
        v1 = false
        if a2 >= 0 then
            v1 = a2 <= len(a1)
        end
    end
    assert(v1)
    v1 = false
    if type(a3) == "number" then
        v1 = false
        if a3 >= 0 then
            v1 = a3 <= len(a1) - a2
        end
    end
    assert(v1)
    return DigestBufferUnsafe(a1, a2, a3, a4)
end

function DigestBuffer(a1, a2) -- Line: 87 -- upvalues: len (val) -- types: a1: buffer, a2: number?
    return DigestBufferUnsafe(a1, 0, len(a1), a2)
end

function Digest(a1, a2) -- Line: 91 -- upvalues: fromstring (val), len (val) -- types: a1: string, a2: number?
    local v1 = fromstring(a1)
    return DigestBufferUnsafe(v1, 0, len(v1), a2)
end

local v1 = {DigestBufferCustom = DigestBufferCustom, DigestBuffer = DigestBuffer, Digest = Digest}
table.freeze(v1)
return v1