-- Script path: ReplicatedStorage.UserGenerated.IO.Base64
-- Decompile time: 9.97 ms

local v1, v2
local u2 = buffer.create(64)
local u5 = buffer.create(256)
for i = 1, 64 do
    v1 = i - 1
    v2 = string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", i)
    buffer.writeu8(u2, v1, v2)
    buffer.writeu8(u5, v2, v1)
end

function encode(a1, a2) -- Line: 42 -- upvalues: u2 (val) -- types: a1: buffer, a2: number?
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = a2 or buffer.len(a1)
    local v12 = math.ceil(v11 / 3)
    local v13 = v12 * 4
    local v14 = buffer.create(v13)
    local v15 = v12 - 1
    for i = 1, v15 do
        v10 = (i - 1) * 3
        v1 = (i - 1) * 4
        v2 = bit32.byteswap((buffer.readu32(a1, v10)))
        v10 = bit32.rshift(v2, 26)
        v3 = bit32.band(bit32.rshift(v2, 20), 63)
        v4 = bit32.band(bit32.rshift(v2, 14), 63)
        v5 = bit32.band(bit32.rshift(v2, 8), 63)
        v7 = buffer.readu8(u2, v10)
        buffer.writeu8(v14, v1, v7)
        v6 = v1 + 1
        v7 = buffer.readu8(u2, v3)
        buffer.writeu8(v14, v6, v7)
        v6 = v1 + 2
        v7 = buffer.readu8(u2, v4)
        buffer.writeu8(v14, v6, v7)
        v6 = v1 + 3
        v7 = buffer.readu8(u2, v5)
        buffer.writeu8(v14, v6, v7)
    end
    v12 = v11 % 3
    if v12 == 1 then
        v9 = v11 - 1
        v15 = buffer.readu8(a1, v9)
        v8 = bit32.rshift(v15, 2)
        v9 = bit32.band(bit32.lshift(v15, 4), 63)
        v2 = v13 - 4
        v3 = buffer.readu8(u2, v8)
        buffer.writeu8(v14, v2, v3)
        v2 = v13 - 3
        v3 = buffer.readu8(u2, v9)
        buffer.writeu8(v14, v2, v3)
        v2 = v13 - 2
        buffer.writeu8(v14, v2, 61)
        v2 = v13 - 1
        buffer.writeu8(v14, v2, 61)
        return v14
    end
    if v12 == 2 then
        v1 = v11 - 2
        v8 = bit32.lshift(buffer.readu8(a1, v1), 8)
        v1 = v11 - 1
        v15 = bit32.bor(v8, (buffer.readu8(a1, v1)))
        v8 = bit32.rshift(v15, 10)
        v9 = bit32.band(bit32.rshift(v15, 4), 63)
        v10 = bit32.band(bit32.lshift(v15, 2), 63)
        v3 = v13 - 4
        v4 = buffer.readu8(u2, v8)
        buffer.writeu8(v14, v3, v4)
        v3 = v13 - 3
        v4 = buffer.readu8(u2, v9)
        buffer.writeu8(v14, v3, v4)
        v3 = v13 - 2
        v4 = buffer.readu8(u2, v10)
        buffer.writeu8(v14, v3, v4)
        v3 = v13 - 1
        buffer.writeu8(v14, v3, 61)
        return v14
    end
    if v12 == 0 and v11 ~= 0 then
        v1 = v11 - 3
        v8 = bit32.lshift(buffer.readu8(a1, v1), 16)
        v2 = v11 - 2
        v9 = bit32.lshift(buffer.readu8(a1, v2), 8)
        v2 = v11 - 1
        v15 = bit32.bor(v8, v9, (buffer.readu8(a1, v2)))
        v8 = bit32.rshift(v15, 18)
        v9 = bit32.band(bit32.rshift(v15, 12), 63)
        v10 = bit32.band(bit32.rshift(v15, 6), 63)
        v1 = bit32.band(v15, 63)
        v4 = v13 - 4
        v5 = buffer.readu8(u2, v8)
        buffer.writeu8(v14, v4, v5)
        v4 = v13 - 3
        v5 = buffer.readu8(u2, v9)
        buffer.writeu8(v14, v4, v5)
        v4 = v13 - 2
        v5 = buffer.readu8(u2, v10)
        buffer.writeu8(v14, v4, v5)
        v4 = v13 - 1
        v5 = buffer.readu8(u2, v1)
        buffer.writeu8(v14, v4, v5)
    end
    return v14
end

function decode(a1) -- Line: 113 -- upvalues: u5 (val) -- types: a1: buffer
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = buffer.len(a1)
    local v12 = math.ceil(v11 / 4)
    local v13 = 0
    if v11 ~= 0 then
        v9 = v11 - 1
        if buffer.readu8(a1, v9) == 61 then
            v13 = v13 + 1
        end
        v9 = v11 - 2
        if buffer.readu8(a1, v9) == 61 then
            v13 = v13 + 1
        end
    end
    local v14 = v12 * 3 - v13
    local v15 = buffer.create(v14)
    v9 = v12 - 1
    for i = 1, v9 do
        v14 = (i - 1) * 4
        v10 = (i - 1) * 3
        v2 = u5
        v3 = buffer.readu8(a1, v14)
        v1 = buffer.readu8(v2, v3)
        v3 = u5
        v6 = v14 + 1
        v4 = buffer.readu8(a1, v6)
        v2 = buffer.readu8(v3, v4)
        v4 = u5
        v7 = v14 + 2
        v5 = buffer.readu8(a1, v7)
        v3 = buffer.readu8(v4, v5)
        v5 = u5
        v8 = v14 + 3
        v6 = buffer.readu8(a1, v8)
        v4 = buffer.readu8(v5, v6)
        v14 = bit32.bor(bit32.lshift(v1, 18), bit32.lshift(v2, 12), bit32.lshift(v3, 6), v4)
        v4 = bit32.rshift(v14, 16)
        v3 = bit32.band(bit32.rshift(v14, 8), 255)
        v2 = bit32.band(v14, 255)
        buffer.writeu8(v15, v10, v4)
        v7 = v10 + 1
        buffer.writeu8(v15, v7, v3)
        v7 = v10 + 2
        buffer.writeu8(v15, v7, v2)
    end
    if v11 ~= 0 then
        v9 = (v12 - 1) * 4
        local v16 = (v12 - 1) * 3
        v10 = u5
        v1 = buffer.readu8(a1, v9)
        local v17 = buffer.readu8(v10, v1)
        v1 = u5
        v4 = v9 + 1
        v2 = buffer.readu8(a1, v4)
        v10 = buffer.readu8(v1, v2)
        v2 = u5
        v5 = v9 + 2
        v3 = buffer.readu8(a1, v5)
        v1 = buffer.readu8(v2, v3)
        v3 = u5
        v6 = v9 + 3
        v4 = buffer.readu8(a1, v6)
        v2 = buffer.readu8(v3, v4)
        v9 = bit32.bor(bit32.lshift(v17, 18), bit32.lshift(v10, 12), bit32.lshift(v1, 6), v2)
        if v13 <= 2 then
            v2 = bit32.rshift(v9, 16)
            buffer.writeu8(v15, v16, v2)
            if v13 <= 1 then
                v2 = bit32.band(bit32.rshift(v9, 8), 255)
                v5 = v16 + 1
                buffer.writeu8(v15, v5, v2)
                if v13 == 0 then
                    v2 = bit32.band(v9, 255)
                    v5 = v16 + 2
                    buffer.writeu8(v15, v5, v2)
                end
            end
        end
    end
    return v15
end

function Encode(a1) -- Line: 186 -- types: a1: string
    return buffer.tostring(encode(buffer.fromstring(a1)))
end

function Decode(a1) -- Line: 190 -- types: a1: string
    return buffer.tostring(decode(buffer.fromstring(a1)))
end

return table.freeze({Encode = Encode, Decode = Decode, EncodeBuffer = encode, DecodeBuffer = decode})