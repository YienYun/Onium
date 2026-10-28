-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.MD5
-- Decompile time: 5.55 ms

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local u8 = {
    3614090360,
    3905402710,
    606105819,
    3250441966,
    4118548399,
    1200080426,
    2821735955,
    4249261313,
    1770035416,
    2336552879,
    4294925233,
    2304563134,
    1804603682,
    4254626195,
    2792965006,
    1236535329,
    4129170786,
    3225465664,
    643717713,
    3921069994,
    3593408605,
    38016083,
    3634488961,
    3889429448,
    568446438,
    3275163606,
    4107603335,
    1163531501,
    2850285829,
    4243563512,
    1735328473,
    2368359562,
    4294588738,
    2272392833,
    1839030562,
    4259657740,
    2763975236,
    1272893353,
    4139469664,
    3200236656,
    681279174,
    3936430074,
    3572445317,
    76029189,
    3654602809,
    3873151461,
    530742520,
    3299628645,
    4096336452,
    1126891415,
    2878612391,
    4237533241,
    1700485571,
    2399980690,
    4293915773,
    2240044497,
    1873313359,
    4264355552,
    2734768916,
    1309151649,
    4149444226,
    3174756917,
    718787259,
    3951481745,
}
local u73 = {
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
}
local u141 = table.create(64, 0)

function processBlocks(a1, a2, a3, a4) -- Line: 66
    -- upvalues: u141 (val), u8 (val), u73 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    local v14 = u141
    local v15 = a1[1]
    local v16 = a1[2]
    local v17 = a1[3]
    local v18 = a1[4]
    for i = a3, a4, 64 do
        v1 = i
        for j = 1, 16 do
            v5, v6, v7, v8 = string.byte(a2, v1, v1 + 3)
            v9 = bit32.lshift(v8, 24)
            v10 = bit32.lshift(v7, 16)
            v11 = bit32.lshift(v6, 8)
            v14[j] = (bit32.bor(v9, v10, v11, v5))
            v1 = v1 + 4
        end
        v2 = v15
        v3 = v16
        v4 = v17
        v5 = v18
        for k = 0, 15 do
            v13 = bit32.bxor(v4, v5)
            v6 = v5
            v5 = v4
            v4 = v3
            v3 = v3 + bit32.lrotate(v2 + bit32.bxor(v5, (bit32.band(v3, v13))) + u8[k + 1] + v14[k + 1], u73[k + 1])
            v2 = v6
        end
        for n = 16, 31 do
            v12 = bit32.band(v5, (bit32.bxor(v3, v4)))
            v6 = v5
            v5 = v4
            v12 = v2 + bit32.bxor(v3, v12) + u8[n + 1]
            v3 = v3 + bit32.lrotate(v12 + v14[(n * 5 + 1) % 16 + 1], u73[n + 1])
            v2 = v6
        end
        for m = 32, 47 do
            v3 = v3 + bit32.lrotate(v2 + bit32.bxor(v3, v3, v4) + u8[m + 1] + v14[(m * 3 + 5) % 16 + 1], u73[m + 1])
            v2 = v5
        end
        for i5 = 48, 63 do
            v13 = bit32.bnot(v5)
            v6 = v5
            v5 = v4
            v3 = v3 + bit32.lrotate(v2 + bit32.bxor(v3, (bit32.bor(v3, v13))) + u8[i5 + 1] + v14[i5 * 7 % 16 + 1], u73[i5 + 1])
            v2 = v6
        end
        v15 = bit32.bor(v2 + v15)
        v16 = bit32.bor(v3 + v16)
        v17 = bit32.bor(v4 + v17)
        v18 = bit32.bor(v5 + v18)
    end
    a1[1] = v15
    a1[2] = v16
    a1[3] = v17
    a1[4] = v18
end

function md5(a1) -- Line: 141 -- types: a1: string
    local v1 = {1732584193, 4023233417, 2562383102, 271733878}
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
        (string.pack("<L", v2 * 8)),
    })
    processBlocks(v1, v4, 1, #v4)
    local v5 = buffer.create(16)
    local v6 = v1[1]
    buffer.writeu32(v5, 0, v6)
    v6 = v1[2]
    buffer.writeu32(v5, 4, v6)
    v6 = v1[3]
    buffer.writeu32(v5, 8, v6)
    v6 = v1[4]
    buffer.writeu32(v5, 12, v6)
    return v5
end

local v1 = {
    Name = "MD5",
    BlockSize = 64,
    OutputSize = 16,
    Digest = function(a1) -- Line: 180
        return buffer.tostring(md5(a1))
    end,
    DigestBuffer = function(a1) -- Line: 183
        return md5(buffer.tostring(a1))
    end,
    DigestToBuffer = md5,
}
table.freeze(v1)
return v1