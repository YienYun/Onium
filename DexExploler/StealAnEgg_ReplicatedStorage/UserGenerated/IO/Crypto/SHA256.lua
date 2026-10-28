-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.SHA256
-- Decompile time: 6.25 ms

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local u8 = {
    1116352408,
    1899447441,
    3049323471,
    3921009573,
    961987163,
    1508970993,
    2453635748,
    2870763221,
    3624381080,
    310598401,
    607225278,
    1426881987,
    1925078388,
    2162078206,
    2614888103,
    3248222580,
    3835390401,
    4022224774,
    264347078,
    604807628,
    770255983,
    1249150122,
    1555081692,
    1996064986,
    2554220882,
    2821834349,
    2952996808,
    3210313671,
    3336571891,
    3584528711,
    113926993,
    338241895,
    666307205,
    773529912,
    1294757372,
    1396182291,
    1695183700,
    1986661051,
    2177026350,
    2456956037,
    2730485921,
    2820302411,
    3259730800,
    3345764771,
    3516065817,
    3600352804,
    4094571909,
    275423344,
    430227734,
    506948616,
    659060556,
    883997877,
    958139571,
    1322822218,
    1537002063,
    1747873779,
    1955562222,
    2024104815,
    2227730452,
    2361852424,
    2428436474,
    2756734187,
    3204031479,
    3329325298,
}
local u76 = table.create(64, 0)

function processBlocks(a1, a2, a3, a4) -- Line: 49
    -- upvalues: u76 (val), u8 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local v13 = u76
    local v14 = a1[1]
    local v15 = a1[2]
    local v16 = a1[3]
    local v17 = a1[4]
    local v18 = a1[5]
    local v19 = a1[6]
    local v20 = a1[7]
    local v21 = a1[8]
    for i = a3, a4, 64 do
        v1 = i
        for j = 1, 16 do
            v5, v6, v7, v8 = string.byte(a2, v1, v1 + 3)
            v10 = bit32.lshift(v5, 24)
            v11 = bit32.lshift(v6, 16)
            v12 = bit32.lshift(v7, 8)
            v13[j] = (bit32.bor(v10, v11, v12, v8))
            v1 = v1 + 4
        end
        for k = 17, 64 do
            v5 = v13[k - 2]
            v6 = v13[k - 15]
            v8 = (bit32.bxor(bit32.rrotate(v5, 17), bit32.rrotate(v5, 19), (bit32.rshift(v5, 10)))) + v13[k - 7] + bit32.bxor(bit32.rrotate(v6, 7), bit32.rrotate(v6, 18), (bit32.rshift(v6, 3)))
            v13[k] = v8 + v13[k - 16]
        end
        v2 = v14
        v3 = v15
        v4 = v16
        v5 = v17
        v6 = v18
        v7 = v19
        v8 = v20
        v9 = v21
        for n = 1, 64 do
            v10 = v9 + bit32.bxor(bit32.rrotate(v6, 6), bit32.rrotate(v6, 11), (bit32.rrotate(v6, 25))) + bit32.band(v6, v7) + bit32.band(bit32.bnot(v6), v8) + u8[n] + v13[n]
            v11 = (bit32.band(v4, v3)) + bit32.band(v2, (bit32.bxor(v4, v3))) + (bit32.bxor(bit32.rrotate(v2, 2), bit32.rrotate(v2, 13), (bit32.rrotate(v2, 22))))
            v9 = v8
            v8 = v7
            v7 = v6
            v6 = v5 + v10
            v5 = v4
            v4 = v3
            v3 = v2
            v2 = v10 + v11
        end
        v14 = bit32.bor(v2 + v14, 0)
        v15 = bit32.bor(v3 + v15, 0)
        v16 = bit32.bor(v4 + v16, 0)
        v17 = bit32.bor(v5 + v17, 0)
        v18 = bit32.bor(v6 + v18, 0)
        v19 = bit32.bor(v7 + v19, 0)
        v20 = bit32.bor(v8 + v20, 0)
        v21 = bit32.bor(v9 + v21, 0)
    end
    a1[1] = v14
    a1[2] = v15
    a1[3] = v16
    a1[4] = v17
    a1[5] = v18
    a1[6] = v19
    a1[7] = v20
    a1[8] = v21
end

function sha256(a1) -- Line: 128 -- types: a1: string
    local v1 = {1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225}
    local v2 = #a1
    local v3 = v2 % 64
    if v2 >= 64 then
        processBlocks(v1, a1, 1, v2 - v3)
    end
    local v4 = bit32.band(v3 + 32, 4294967232)
    v4 = table.concat({
        if v3 == 0 then "" else string.sub(a1, -v3),
        "€",
        string.rep("\000", (v4 - v3 - 9) % 64),
        (string.pack(">L", v2 * 8)),
    })
    processBlocks(v1, v4, 1, #v4)
    local v5 = buffer.create(32)
    local v6 = bit32.byteswap(v1[1])
    buffer.writeu32(v5, 0, v6)
    v6 = bit32.byteswap(v1[2])
    buffer.writeu32(v5, 4, v6)
    v6 = bit32.byteswap(v1[3])
    buffer.writeu32(v5, 8, v6)
    v6 = bit32.byteswap(v1[4])
    buffer.writeu32(v5, 12, v6)
    v6 = bit32.byteswap(v1[5])
    buffer.writeu32(v5, 16, v6)
    v6 = bit32.byteswap(v1[6])
    buffer.writeu32(v5, 20, v6)
    v6 = bit32.byteswap(v1[7])
    buffer.writeu32(v5, 24, v6)
    v6 = bit32.byteswap(v1[8])
    buffer.writeu32(v5, 28, v6)
    return v5
end

local v1 = {
    Name = "SHA-256",
    BlockSize = 64,
    OutputSize = 32,
    Digest = function(a1) -- Line: 171
        return buffer.tostring(sha256(a1))
    end,
    DigestBuffer = function(a1) -- Line: 174
        return sha256(buffer.tostring(a1))
    end,
    DigestToBuffer = sha256,
}
table.freeze(v1)
return v1