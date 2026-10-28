-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.SHA1
-- Decompile time: 5.15 ms

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local u11 = table.create(80, 0)

function processBlocks(a1, a2, a3, a4) -- Line: 37
    -- upvalues: u11 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local v12 = u11
    local v13 = a1[1]
    local v14 = a1[2]
    local v15 = a1[3]
    local v16 = a1[4]
    local v17 = a1[5]
    for i = a3, a4, 64 do
        v1 = i
        for j = 1, 16 do
            v5, v6, v7, v8 = string.byte(a2, v1, v1 + 3)
            v9 = bit32.lshift(v5, 24)
            v10 = bit32.lshift(v6, 16)
            v11 = bit32.lshift(v7, 8)
            v12[j] = (bit32.bor(v9, v10, v11, v8))
            v1 = v1 + 4
        end
        for k = 17, 80 do
            v6 = bit32.bxor(v12[k - 3], v12[k - 8], v12[k - 14], v12[k - 16])
            v12[k] = (bit32.lrotate(v6, 1))
        end
        v2 = v13
        v3 = v14
        v4 = v15
        v5 = v16
        v6 = v17
        for n = 1, 20 do
            v7 = (bit32.lrotate(v2, 5)) + bit32.band(v3, v4) + bit32.band(bit32.bnot(v3), v5) + v6 + 1518500249 + v12[n]
            v6 = v5
            v5 = v4
            v4 = bit32.lrotate(v3, 30)
            v3 = v2
            v2 = v7
        end
        for m = 21, 40 do
            v7 = (bit32.lrotate(v2, 5)) + bit32.bxor(v3, v4, v5) + v6 + 1859775393 + v12[m]
            v6 = v5
            v5 = v4
            v4 = bit32.lrotate(v3, 30)
            v3 = v2
            v2 = v7
        end
        for i5 = 41, 60 do
            v7 = (bit32.lrotate(v2, 5)) + bit32.band(v5, v4) + bit32.band(v3, (bit32.bxor(v5, v4))) + v6 + 2400959708 + v12[i5]
            v6 = v5
            v5 = v4
            v4 = bit32.lrotate(v3, 30)
            v3 = v2
            v2 = v7
        end
        for i6 = 61, 80 do
            v7 = (bit32.lrotate(v2, 5)) + bit32.bxor(v3, v4, v5) + v6 + 3395469782 + v12[i6]
            v6 = v5
            v5 = v4
            v4 = bit32.lrotate(v3, 30)
            v3 = v2
            v2 = v7
        end
        v13 = bit32.bor(v2 + v13, 0)
        v14 = bit32.bor(v3 + v14, 0)
        v15 = bit32.bor(v4 + v15, 0)
        v16 = bit32.bor(v5 + v16, 0)
        v17 = bit32.bor(v6 + v17, 0)
    end
    a1[1] = v13
    a1[2] = v14
    a1[3] = v15
    a1[4] = v16
    a1[5] = v17
end

function sha1(a1) -- Line: 112 -- types: a1: string
    local v1 = {1732584193, 4023233417, 2562383102, 271733878, 3285377520}
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
    local v5 = buffer.create(20)
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
    return v5
end

local v1 = {
    Name = "SHA-1",
    BlockSize = 64,
    OutputSize = 20,
    Digest = function(a1) -- Line: 152
        return buffer.tostring(sha1(a1))
    end,
    DigestBuffer = function(a1) -- Line: 155
        return sha1(buffer.tostring(a1))
    end,
    DigestToBuffer = sha1,
}
table.freeze(v1)
return v1