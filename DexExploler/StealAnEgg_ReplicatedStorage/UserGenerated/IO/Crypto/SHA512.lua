-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.SHA512
-- Decompile time: 11.22 ms

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local u11 = table.create(80, 0)
local u15 = table.create(80, 0)
local u16 = {
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
    3391569614,
    3515267271,
    3940187606,
    4118630271,
    116418474,
    174292421,
    289380356,
    460393269,
    685471733,
    852142971,
    1017036298,
    1126000580,
    1288033470,
    1501505948,
    1607167915,
    1816402316,
}
local u97 = {
    3609767458,
    602891725,
    3964484399,
    2173295548,
    4081628472,
    3053834265,
    2937671579,
    3664609560,
    2734883394,
    1164996542,
    1323610764,
    3590304994,
    4068182383,
    991336113,
    633803317,
    3479774868,
    2666613458,
    944711139,
    2341262773,
    2007800933,
    1495990901,
    1856431235,
    3175218132,
    2198950837,
    3999719339,
    766784016,
    2566594879,
    3203337956,
    1034457026,
    2466948901,
    3758326383,
    168717936,
    1188179964,
    1546045734,
    1522805485,
    2643833823,
    2343527390,
    1014477480,
    1206759142,
    344077627,
    1290863460,
    3158454273,
    3505952657,
    106217008,
    3606008344,
    1432725776,
    1467031594,
    851169720,
    3100823752,
    1363258195,
    3750685593,
    3785050280,
    3318307427,
    3812723403,
    2003034995,
    3602036899,
    1575990012,
    1125592928,
    2716904306,
    442776044,
    593698344,
    3733110249,
    2999351573,
    3815920427,
    3928383900,
    566280711,
    3454069534,
    4000239992,
    1914138554,
    2731055270,
    3203993006,
    320620315,
    587496836,
    1086792851,
    365543100,
    2618297676,
    3409855158,
    4234509866,
    987167468,
    1246189591,
}

function lil_sig0(a1, a2) -- Line: 76 -- types: a1: number, a2: number
    return (bit32.bxor(bit32.rshift(a1, 1), bit32.lshift(a2, 31), bit32.rshift(a1, 8), bit32.lshift(a2, 24), (bit32.rshift(a1, 7)))), (bit32.bxor(
        bit32.rshift(a2, 1),
        bit32.lshift(a1, 31),
        bit32.rshift(a2, 8),
        bit32.lshift(a1, 24),
        bit32.rshift(a2, 7),
        (bit32.lshift(a1, 25))
    ))
end

function lil_sig1(a1, a2) -- Line: 98 -- types: a1: number, a2: number
    return (bit32.bxor(bit32.rshift(a1, 19), bit32.lshift(a2, 13), bit32.lshift(a1, 3), bit32.rshift(a2, 29), (bit32.rshift(a1, 6)))), (bit32.bxor(
        bit32.rshift(a2, 19),
        bit32.lshift(a1, 13),
        bit32.lshift(a2, 3),
        bit32.rshift(a1, 29),
        bit32.rshift(a2, 6),
        (bit32.lshift(a1, 26))
    ))
end

function big_sig0(a1, a2) -- Line: 119 -- types: a1: number, a2: number
    return (bit32.bxor(
        bit32.rshift(a1, 28),
        bit32.lshift(a2, 4),
        bit32.lshift(a1, 30),
        bit32.rshift(a2, 2),
        bit32.lshift(a1, 25),
        (bit32.rshift(a2, 7))
    )), (bit32.bxor(
        bit32.rshift(a2, 28),
        bit32.lshift(a1, 4),
        bit32.lshift(a2, 30),
        bit32.rshift(a1, 2),
        bit32.lshift(a2, 25),
        (bit32.rshift(a1, 7))
    ))
end

function big_sig1(a1, a2) -- Line: 137 -- types: a1: number, a2: number
    return (bit32.bxor(
        bit32.rshift(a1, 14),
        bit32.lshift(a2, 18),
        bit32.rshift(a1, 18),
        bit32.lshift(a2, 14),
        bit32.lshift(a1, 23),
        (bit32.rshift(a2, 9))
    )), (bit32.bxor(
        bit32.rshift(a2, 14),
        bit32.lshift(a1, 18),
        bit32.rshift(a2, 18),
        bit32.lshift(a1, 14),
        bit32.lshift(a2, 23),
        (bit32.rshift(a1, 9))
    ))
end

function processBlocks(a1, a2, a3, a4, a5) -- Line: 157
    -- upvalues: u11 (val), u15 (val), u97 (val), u16 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22
    local v23 = u11
    local v24 = u15
    local v25 = a1[1]
    local v26 = a1[2]
    local v27 = a1[3]
    local v28 = a1[4]
    local v29 = a1[5]
    local v30 = a1[6]
    local v31 = a1[7]
    local v32 = a1[8]
    local v33 = a2[1]
    local v34 = a2[2]
    local v35 = a2[3]
    local v36 = a2[4]
    local v37 = a2[5]
    local v38 = a2[6]
    local v39 = a2[7]
    local v40 = a2[8]
    for i = a4, a5, 128 do
        v1 = i
        for j = 1, 16 do
            v5, v6, v7, v8, v9, v10, v11, v12 = string.byte(a3, v1, v1 + 7)
            v14 = bit32.lshift(v5, 24)
            v15 = bit32.lshift(v6, 16)
            v16 = bit32.lshift(v7, 8)
            v23[j] = (bit32.bor(v14, v15, v16, v8))
            v14 = bit32.lshift(v9, 24)
            v15 = bit32.lshift(v10, 16)
            v16 = bit32.lshift(v11, 8)
            v24[j] = (bit32.bor(v14, v15, v16, v12))
            v1 = v1 + 8
        end
        for k = 17, 80 do
            v5, v6 = lil_sig0(v23[k - 15], v24[k - 15])
            v7, v8 = lil_sig1(v23[k - 2], v24[k - 2])
            v9 = v24[k - 16] + v6 + v24[k - 7] + v8
            v24[k] = (bit32.bor(v9, 0))
            v11 = v23[k - 16] + v5 + v23[k - 7] + v7
            v23[k] = v11 + v9 // 4294967296
        end
        v2 = v25
        v3 = v26
        v4 = v27
        v5 = v28
        v6 = v29
        v7 = v30
        v8 = v31
        v9 = v32
        v10 = v33
        v11 = v34
        v12 = v35
        v13 = v36
        v14 = v37
        v15 = v38
        v16 = v39
        v17 = v40
        for n = 1, 80 do
            v18, v19 = big_sig0(v2, v10)
            v20, v21 = big_sig1(v6, v14)
            v22 = v17 + v21 + bit32.bor(bit32.band(v14, v15), bit32.band(-1 - v14, v16), 0) + u97[n] + v24[n]
            v21 = v9 + v20 + bit32.bor(bit32.band(v6, v7), bit32.band(-1 - v6, v8), 0) + u16[n] + v23[n] + v22 // 4294967296
            v22 = bit32.bor(v22, 0)
            v20 = v19 + bit32.band(v12, v11) + bit32.band(v10, (bit32.bxor(v12, v11)))
            v19 = v18 + bit32.band(v4, v3) + bit32.band(v2, (bit32.bxor(v4, v3)))
            v9 = v8
            v17 = v16
            v8 = v7
            v16 = v15
            v7 = v6
            v15 = v14
            v14 = v22 + v13
            v6 = v21 + v5 + v14 // 4294967296
            v14 = bit32.bor(v14, 0)
            v5 = v4
            v13 = v12
            v4 = v3
            v12 = v11
            v3 = v2
            v11 = v10
            v10 = v22 + v20
            v2 = v21 + v19 + v10 // 4294967296
            v10 = bit32.bor(v10, 0)
        end
        v33 = v33 + v10
        v25 = bit32.bor(v25 + v2 + v33 // 4294967296, 0)
        v33 = bit32.bor(v33, 0)
        v34 = v34 + v11
        v26 = bit32.bor(v26 + v3 + v34 // 4294967296, 0)
        v34 = bit32.bor(v34, 0)
        v35 = v35 + v12
        v27 = bit32.bor(v27 + v4 + v35 // 4294967296, 0)
        v35 = bit32.bor(v35, 0)
        v36 = v36 + v13
        v28 = bit32.bor(v28 + v5 + v36 // 4294967296, 0)
        v36 = bit32.bor(v36, 0)
        v37 = v37 + v14
        v29 = bit32.bor(v29 + v6 + v37 // 4294967296, 0)
        v37 = bit32.bor(v37, 0)
        v38 = v38 + v15
        v30 = bit32.bor(v30 + v7 + v38 // 4294967296, 0)
        v38 = bit32.bor(v38, 0)
        v39 = v39 + v16
        v31 = bit32.bor(v31 + v8 + v39 // 4294967296, 0)
        v39 = bit32.bor(v39, 0)
        v40 = v40 + v17
        v32 = bit32.bor(v32 + v9 + v40 // 4294967296, 0)
        v40 = bit32.bor(v40, 0)
    end
    a1[1] = v25
    a2[1] = v33
    a1[2] = v26
    a2[2] = v34
    a1[3] = v27
    a2[3] = v35
    a1[4] = v28
    a2[4] = v36
    a1[5] = v29
    a2[5] = v37
    a1[6] = v30
    a2[6] = v38
    a1[7] = v31
    a2[7] = v39
    a1[8] = v32
    a2[8] = v40
end

function sha512(a1) -- Line: 291 -- types: a1: string
    local v1, v2
    local v3 = {1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225}
    local v4 = {4089235720, 2227873595, 4271175723, 1595750129, 2917565137, 725511199, 4215389547, 327033209}
    local v5 = #a1
    if v5 > 1125899906842624 then
        error("cannot calculate the SHA-512 hash of a string longer than 2^50 bytes", 2)
    end
    local v6 = v5 % 128
    if v5 >= 128 then
        processBlocks(v3, v4, a1, 1, v5 - v6)
    end
    local v7 = bit32.band(v6 + 64, 4294963200)
    v7 = table.concat({
        if v6 == 0 then "" else string.sub(a1, -v6),
        "€",
        string.rep("\000", (v7 - v6 - 17) % 128),
        string.pack(">L", v5 * 8 / 4294967296),
        (string.pack(">L", v5 * 8 % 4294967296)),
    })
    processBlocks(v3, v4, v7, 1, #v7)
    local v8 = buffer.create(64)
    for i = 1, 8 do
        v1 = (i - 1) * 8
        v2 = bit32.byteswap(v3[i])
        buffer.writeu32(v8, v1, v2)
        v1 = (i - 1) * 8 + 4
        v2 = bit32.byteswap(v4[i])
        buffer.writeu32(v8, v1, v2)
    end
    return v8
end

local v1 = {
    Name = "SHA-512",
    BlockSize = 128,
    OutputSize = 64,
    Digest = function(a1) -- Line: 341
        return buffer.tostring(sha512(a1))
    end,
    DigestBuffer = function(a1) -- Line: 344
        return sha512(buffer.tostring(a1))
    end,
    DigestToBuffer = sha512,
}
table.freeze(v1)
return v1