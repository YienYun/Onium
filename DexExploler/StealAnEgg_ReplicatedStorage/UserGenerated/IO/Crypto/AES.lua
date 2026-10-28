-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.AES
-- Decompile time: 57.92 ms

local v1, v2, v3, v4, v5
local bxor = bit32.bxor
local rrotate = bit32.rrotate
local copy = buffer.copy
local create = buffer.create
local fromstring = buffer.fromstring
local len = buffer.len
local readu8 = buffer.readu8
local readu16 = buffer.readu16
local readu32 = buffer.readu32
local tostring = buffer.tostring
local writestring = buffer.writestring
local writeu8 = buffer.writeu8
local writeu16 = buffer.writeu16
local writeu32 = buffer.writeu32
local floor = math.floor
local sub = string.sub
local u358 = create(131072)
local u363 = create(65536)
local u368 = create(65536)
local u373 = create(65536)
local u378 = create(65536)
local u383 = create(65536)

local function keySchedule(a1, a2, a3, a4) -- Line: 159
    -- upvalues: copy (val), writestring (val), readu32 (val), rrotate (val), u358 (val), floor (val), readu16 (val)
    -- upvalues: bxor (val), writeu32 (val)
    if not a4 then
        writestring(a3, 0, a1, a2)
    else
        copy(a3, 0, a1, 0, a2)
    end
    local v1 = rrotate(readu32(a3, a2 - 4), 8)
    local v2 = 0.5
    if a2 == 32 then
        for k = 32, 192, 32 do
            v2 = v2 * 2 % 229
            v1 = bxor(readu32(a3, k - 32), readu16(u358, (floor(v1 / 65536)) * 2) * 65536 + readu16(u358, v1 % 65536 * 2), v2)
            writeu32(a3, k, v1)
            v1 = bxor(readu32(a3, k - 28), v1)
            writeu32(a3, k + 4, v1)
            v1 = bxor(readu32(a3, k - 24), v1)
            writeu32(a3, k + 8, v1)
            v1 = bxor(readu32(a3, k - 20), v1)
            writeu32(a3, k + 12, v1)
            v1 = bxor(readu32(a3, k - 16), readu16(u358, (floor(v1 / 65536)) * 2) * 65536 + (readu16(u358, v1 % 65536 * 2)))
            writeu32(a3, k + 16, v1)
            v1 = bxor(readu32(a3, k - 12), v1)
            writeu32(a3, k + 20, v1)
            v1 = bxor(readu32(a3, k - 8), v1)
            writeu32(a3, k + 24, v1)
            v1 = bxor(readu32(a3, k - 4), v1)
            writeu32(a3, k + 28, v1)
            v1 = rrotate(v1, 8)
        end
        v1 = bxor(readu32(a3, 192), readu16(u358, (floor(v1 / 65536)) * 2) * 65536 + readu16(u358, v1 % 65536 * 2), 64)
        writeu32(a3, 224, v1)
        v1 = bxor(readu32(a3, 196), v1)
        writeu32(a3, 228, v1)
        v1 = bxor(readu32(a3, 200), v1)
        writeu32(a3, 232, v1)
        writeu32(a3, 236, (bxor(readu32(a3, 204), v1)))
        return a3
    end
    if a2 ~= 24 then
        for i = 16, 144, 16 do
            v2 = v2 * 2 % 229
            v1 = bxor(readu32(a3, i - 16), readu16(u358, (floor(v1 / 65536)) * 2) * 65536 + readu16(u358, v1 % 65536 * 2), v2)
            writeu32(a3, i, v1)
            v1 = bxor(readu32(a3, i - 12), v1)
            writeu32(a3, i + 4, v1)
            v1 = bxor(readu32(a3, i - 8), v1)
            writeu32(a3, i + 8, v1)
            v1 = bxor(readu32(a3, i - 4), v1)
            writeu32(a3, i + 12, v1)
            v1 = rrotate(v1, 8)
        end
        v1 = bxor(readu32(a3, 144), readu16(u358, (floor(v1 / 65536)) * 2) * 65536 + readu16(u358, v1 % 65536 * 2), 54)
        writeu32(a3, 160, v1)
        v1 = bxor(readu32(a3, 148), v1)
        writeu32(a3, 164, v1)
        v1 = bxor(readu32(a3, 152), v1)
        writeu32(a3, 168, v1)
        writeu32(a3, 172, (bxor(readu32(a3, 156), v1)))
        return a3
    end
    for j = 24, 168, 24 do
        v2 = v2 * 2 % 229
        v1 = bxor(readu32(a3, j - 24), readu16(u358, (floor(v1 / 65536)) * 2) * 65536 + readu16(u358, v1 % 65536 * 2), v2)
        writeu32(a3, j, v1)
        v1 = bxor(readu32(a3, j - 20), v1)
        writeu32(a3, j + 4, v1)
        v1 = bxor(readu32(a3, j - 16), v1)
        writeu32(a3, j + 8, v1)
        v1 = bxor(readu32(a3, j - 12), v1)
        writeu32(a3, j + 12, v1)
        v1 = bxor(readu32(a3, j - 8), v1)
        writeu32(a3, j + 16, v1)
        v1 = bxor(readu32(a3, j - 4), v1)
        writeu32(a3, j + 20, v1)
        v1 = rrotate(v1, 8)
    end
    v1 = bxor(readu32(a3, 168), readu16(u358, (floor(v1 / 65536)) * 2) * 65536 + readu16(u358, v1 % 65536 * 2), 128)
    writeu32(a3, 192, v1)
    v1 = bxor(readu32(a3, 172), v1)
    writeu32(a3, 196, v1)
    v1 = bxor(readu32(a3, 176), v1)
    writeu32(a3, 200, v1)
    writeu32(a3, 204, (bxor(readu32(a3, 180), v1)))
    return a3
end

local function encryptBlock(a1, a2, a3, a4, a5, a6) -- Line: 284
    -- upvalues: readu8 (val), bxor (val), u363 (val), u368 (val), u358 (val), readu16 (val), readu32 (val)
    -- upvalues: writeu32 (val)
    local v1 = bxor(readu8(a3, a4), (readu8(a1, 0)))
    local v2 = bxor(readu8(a3, a4 + 1), (readu8(a1, 1)))
    local v3 = bxor(readu8(a3, a4 + 2), (readu8(a1, 2)))
    local v4 = bxor(readu8(a3, a4 + 3), (readu8(a1, 3)))
    local v5 = bxor(readu8(a3, a4 + 4), (readu8(a1, 4)))
    local v6 = bxor(readu8(a3, a4 + 5), (readu8(a1, 5)))
    local v7 = bxor(readu8(a3, a4 + 6), (readu8(a1, 6)))
    local v8 = bxor(readu8(a3, a4 + 7), (readu8(a1, 7)))
    local v9 = bxor(readu8(a3, a4 + 8), (readu8(a1, 8)))
    local v10 = bxor(readu8(a3, a4 + 9), (readu8(a1, 9)))
    local v11 = bxor(readu8(a3, a4 + 10), (readu8(a1, 10)))
    local v12 = bxor(readu8(a3, a4 + 11), (readu8(a1, 11)))
    local v13 = bxor(readu8(a3, a4 + 12), (readu8(a1, 12)))
    local v14 = bxor(readu8(a3, a4 + 13), (readu8(a1, 13)))
    local v15 = bxor(readu8(a3, a4 + 14), (readu8(a1, 14)))
    local v16 = bxor(readu8(a3, a4 + 15), (readu8(a1, 15)))
    local v17 = v1 * 256 + v6
    local v18 = v6 * 256 + v11
    local v19 = v11 * 256 + v16
    local v20 = v16 * 256 + v1
    local v21 = v5 * 256 + v10
    local v22 = v10 * 256 + v15
    local v23 = v15 * 256 + v4
    local v24 = v4 * 256 + v5
    local v25 = v9 * 256 + v14
    local v26 = v14 * 256 + v3
    local v27 = v3 * 256 + v8
    local v28 = v8 * 256 + v9
    local v29 = v13 * 256 + v2
    local v30 = v2 * 256 + v7
    local v31 = v7 * 256 + v12
    local v32 = v12 * 256 + v13
    for i = 16, a2, 16 do
        v1 = bxor(readu8(u363, v17), readu8(u368, v19), (readu8(a1, i)))
        v2 = bxor(readu8(u363, v18), readu8(u368, v20), (readu8(a1, i + 1)))
        v3 = bxor(readu8(u363, v19), readu8(u368, v17), (readu8(a1, i + 2)))
        v4 = bxor(readu8(u363, v20), readu8(u368, v18), (readu8(a1, i + 3)))
        v5 = bxor(readu8(u363, v21), readu8(u368, v23), (readu8(a1, i + 4)))
        v6 = bxor(readu8(u363, v22), readu8(u368, v24), (readu8(a1, i + 5)))
        v7 = bxor(readu8(u363, v23), readu8(u368, v21), (readu8(a1, i + 6)))
        v8 = bxor(readu8(u363, v24), readu8(u368, v22), (readu8(a1, i + 7)))
        v9 = bxor(readu8(u363, v25), readu8(u368, v27), (readu8(a1, i + 8)))
        v10 = bxor(readu8(u363, v26), readu8(u368, v28), (readu8(a1, i + 9)))
        v11 = bxor(readu8(u363, v27), readu8(u368, v25), (readu8(a1, i + 10)))
        v12 = bxor(readu8(u363, v28), readu8(u368, v26), (readu8(a1, i + 11)))
        v13 = bxor(readu8(u363, v29), readu8(u368, v31), (readu8(a1, i + 12)))
        v14 = bxor(readu8(u363, v30), readu8(u368, v32), (readu8(a1, i + 13)))
        v15 = bxor(readu8(u363, v31), readu8(u368, v29), (readu8(a1, i + 14)))
        v16 = bxor(readu8(u363, v32), readu8(u368, v30), (readu8(a1, i + 15)))
        v17 = v1 * 256 + v6
        v18 = v6 * 256 + v11
        v19 = v11 * 256 + v16
        v20 = v16 * 256 + v1
        v21 = v5 * 256 + v10
        v22 = v10 * 256 + v15
        v23 = v15 * 256 + v4
        v24 = v4 * 256 + v5
        v25 = v9 * 256 + v14
        v26 = v14 * 256 + v3
        v27 = v3 * 256 + v8
        v28 = v8 * 256 + v9
        v29 = v13 * 256 + v2
        v30 = v2 * 256 + v7
        v31 = v7 * 256 + v12
        v32 = v12 * 256 + v13
    end
    writeu32(a5, a6, (bxor(readu16(
        u358,
        bxor(readu8(u363, v32), readu8(u368, v30), (readu8(a1, a2 + 31))) * 512 + (bxor(readu8(u363, v27), readu8(u368, v25), (readu8(a1, a2 + 26)))) * 2
    ) * 65536 + readu16(
        u358,
        bxor(readu8(u363, v22), readu8(u368, v24), (readu8(a1, a2 + 21))) * 512 + (bxor(readu8(u363, v17), readu8(u368, v19), (readu8(a1, a2 + 16)))) * 2
    ), (readu32(a1, a2 + 32)))))
    writeu32(a5, a6 + 4, (bxor(readu16(
        u358,
        bxor(readu8(u363, v20), readu8(u368, v18), (readu8(a1, a2 + 19))) * 512 + (bxor(readu8(u363, v31), readu8(u368, v29), (readu8(a1, a2 + 30)))) * 2
    ) * 65536 + readu16(
        u358,
        bxor(readu8(u363, v26), readu8(u368, v28), (readu8(a1, a2 + 25))) * 512 + (bxor(readu8(u363, v21), readu8(u368, v23), (readu8(a1, a2 + 20)))) * 2
    ), (readu32(a1, a2 + 36)))))
    writeu32(a5, a6 + 8, (bxor(readu16(
        u358,
        bxor(readu8(u363, v24), readu8(u368, v22), (readu8(a1, a2 + 23))) * 512 + (bxor(readu8(u363, v19), readu8(u368, v17), (readu8(a1, a2 + 18)))) * 2
    ) * 65536 + readu16(
        u358,
        bxor(readu8(u363, v30), readu8(u368, v32), (readu8(a1, a2 + 29))) * 512 + (bxor(readu8(u363, v25), readu8(u368, v27), (readu8(a1, a2 + 24)))) * 2
    ), (readu32(a1, a2 + 40)))))
    writeu32(a5, a6 + 12, (bxor(readu16(
        u358,
        bxor(readu8(u363, v28), readu8(u368, v26), (readu8(a1, a2 + 27))) * 512 + (bxor(readu8(u363, v23), readu8(u368, v21), (readu8(a1, a2 + 22)))) * 2
    ) * 65536 + readu16(
        u358,
        bxor(readu8(u363, v18), readu8(u368, v20), (readu8(a1, a2 + 17))) * 512 + (bxor(readu8(u363, v29), readu8(u368, v31), (readu8(a1, a2 + 28)))) * 2
    ), (readu32(a1, a2 + 44)))))
end

local function decryptBlock(a1, a2, a3, a4, a5, a6) -- Line: 477
    -- upvalues: u373 (val), readu8 (val), bxor (val), u378 (val), u383 (val), writeu32 (val)
    local v1 = bxor(readu8(u373, readu8(a3, a4) * 256 + (readu8(a1, a2 + 32))), (readu8(a1, a2 + 16)))
    local v2 = bxor(readu8(u373, readu8(a3, a4 + 13) * 256 + (readu8(a1, a2 + 45))), (readu8(a1, a2 + 17)))
    local v3 = bxor(readu8(u373, readu8(a3, a4 + 10) * 256 + (readu8(a1, a2 + 42))), (readu8(a1, a2 + 18)))
    local v4 = bxor(readu8(u373, readu8(a3, a4 + 7) * 256 + (readu8(a1, a2 + 39))), (readu8(a1, a2 + 19)))
    local v5 = bxor(readu8(u373, readu8(a3, a4 + 4) * 256 + (readu8(a1, a2 + 36))), (readu8(a1, a2 + 20)))
    local v6 = bxor(readu8(u373, readu8(a3, a4 + 1) * 256 + (readu8(a1, a2 + 33))), (readu8(a1, a2 + 21)))
    local v7 = bxor(readu8(u373, readu8(a3, a4 + 14) * 256 + (readu8(a1, a2 + 46))), (readu8(a1, a2 + 22)))
    local v8 = bxor(readu8(u373, readu8(a3, a4 + 11) * 256 + (readu8(a1, a2 + 43))), (readu8(a1, a2 + 23)))
    local v9 = bxor(readu8(u373, readu8(a3, a4 + 8) * 256 + (readu8(a1, a2 + 40))), (readu8(a1, a2 + 24)))
    local v10 = bxor(readu8(u373, readu8(a3, a4 + 5) * 256 + (readu8(a1, a2 + 37))), (readu8(a1, a2 + 25)))
    local v11 = bxor(readu8(u373, readu8(a3, a4 + 2) * 256 + (readu8(a1, a2 + 34))), (readu8(a1, a2 + 26)))
    local v12 = bxor(readu8(u373, readu8(a3, a4 + 15) * 256 + (readu8(a1, a2 + 47))), (readu8(a1, a2 + 27)))
    local v13 = bxor(readu8(u373, readu8(a3, a4 + 12) * 256 + (readu8(a1, a2 + 44))), (readu8(a1, a2 + 28)))
    local v14 = bxor(readu8(u373, readu8(a3, a4 + 9) * 256 + (readu8(a1, a2 + 41))), (readu8(a1, a2 + 29)))
    local v15 = bxor(readu8(u373, readu8(a3, a4 + 6) * 256 + (readu8(a1, a2 + 38))), (readu8(a1, a2 + 30)))
    local v16 = bxor(readu8(u373, readu8(a3, a4 + 3) * 256 + (readu8(a1, a2 + 35))), (readu8(a1, a2 + 31)))
    local v17 = v1 * 256 + v2
    local v18 = v2 * 256 + v3
    local v19 = v3 * 256 + v4
    local v20 = v4 * 256 + v1
    local v21 = v5 * 256 + v6
    local v22 = v6 * 256 + v7
    local v23 = v7 * 256 + v8
    local v24 = v8 * 256 + v5
    local v25 = v9 * 256 + v10
    local v26 = v10 * 256 + v11
    local v27 = v11 * 256 + v12
    local v28 = v12 * 256 + v9
    local v29 = v13 * 256 + v14
    local v30 = v14 * 256 + v15
    local v31 = v15 * 256 + v16
    local v32 = v16 * 256 + v13
    for i = a2, 16, -16 do
        v1 = bxor(readu8(u373, readu8(u378, v17) * 256 + (readu8(u383, v19))), (readu8(a1, i)))
        v2 = bxor(readu8(u373, readu8(u378, v30) * 256 + (readu8(u383, v32))), (readu8(a1, i + 1)))
        v3 = bxor(readu8(u373, readu8(u378, v27) * 256 + (readu8(u383, v25))), (readu8(a1, i + 2)))
        v4 = bxor(readu8(u373, readu8(u378, v24) * 256 + (readu8(u383, v22))), (readu8(a1, i + 3)))
        v5 = bxor(readu8(u373, readu8(u378, v21) * 256 + (readu8(u383, v23))), (readu8(a1, i + 4)))
        v6 = bxor(readu8(u373, readu8(u378, v18) * 256 + (readu8(u383, v20))), (readu8(a1, i + 5)))
        v7 = bxor(readu8(u373, readu8(u378, v31) * 256 + (readu8(u383, v29))), (readu8(a1, i + 6)))
        v8 = bxor(readu8(u373, readu8(u378, v28) * 256 + (readu8(u383, v26))), (readu8(a1, i + 7)))
        v9 = bxor(readu8(u373, readu8(u378, v25) * 256 + (readu8(u383, v27))), (readu8(a1, i + 8)))
        v10 = bxor(readu8(u373, readu8(u378, v22) * 256 + (readu8(u383, v24))), (readu8(a1, i + 9)))
        v11 = bxor(readu8(u373, readu8(u378, v19) * 256 + (readu8(u383, v17))), (readu8(a1, i + 10)))
        v12 = bxor(readu8(u373, readu8(u378, v32) * 256 + (readu8(u383, v30))), (readu8(a1, i + 11)))
        v13 = bxor(readu8(u373, readu8(u378, v29) * 256 + (readu8(u383, v31))), (readu8(a1, i + 12)))
        v14 = bxor(readu8(u373, readu8(u378, v26) * 256 + (readu8(u383, v28))), (readu8(a1, i + 13)))
        v15 = bxor(readu8(u373, readu8(u378, v23) * 256 + (readu8(u383, v21))), (readu8(a1, i + 14)))
        v16 = bxor(readu8(u373, readu8(u378, v20) * 256 + (readu8(u383, v18))), (readu8(a1, i + 15)))
        v17 = v1 * 256 + v2
        v18 = v2 * 256 + v3
        v19 = v3 * 256 + v4
        v20 = v4 * 256 + v1
        v21 = v5 * 256 + v6
        v22 = v6 * 256 + v7
        v23 = v7 * 256 + v8
        v24 = v8 * 256 + v5
        v25 = v9 * 256 + v10
        v26 = v10 * 256 + v11
        v27 = v11 * 256 + v12
        v28 = v12 * 256 + v9
        v29 = v13 * 256 + v14
        v30 = v14 * 256 + v15
        v31 = v15 * 256 + v16
        v32 = v16 * 256 + v13
    end
    writeu32(
        a5,
        a6,
        bxor(readu8(u373, readu8(u378, v24) * 256 + (readu8(u383, v22))), (readu8(a1, 3))) * 16777216 + bxor(readu8(u373, readu8(u378, v27) * 256 + (readu8(u383, v25))), (readu8(a1, 2))) * 65536 + bxor(readu8(u373, readu8(u378, v30) * 256 + (readu8(u383, v32))), (readu8(a1, 1))) * 256 + (bxor(readu8(u373, readu8(u378, v17) * 256 + (readu8(u383, v19))), (readu8(a1, 0))))
    )
    writeu32(
        a5,
        a6 + 4,
        bxor(readu8(u373, readu8(u378, v28) * 256 + (readu8(u383, v26))), (readu8(a1, 7))) * 16777216 + bxor(readu8(u373, readu8(u378, v31) * 256 + (readu8(u383, v29))), (readu8(a1, 6))) * 65536 + bxor(readu8(u373, readu8(u378, v18) * 256 + (readu8(u383, v20))), (readu8(a1, 5))) * 256 + (bxor(readu8(u373, readu8(u378, v21) * 256 + (readu8(u383, v23))), (readu8(a1, 4))))
    )
    writeu32(
        a5,
        a6 + 8,
        bxor(readu8(u373, readu8(u378, v32) * 256 + (readu8(u383, v30))), (readu8(a1, 11))) * 16777216 + bxor(readu8(u373, readu8(u378, v19) * 256 + (readu8(u383, v17))), (readu8(a1, 10))) * 65536 + bxor(readu8(u373, readu8(u378, v22) * 256 + (readu8(u383, v24))), (readu8(a1, 9))) * 256 + (bxor(readu8(u373, readu8(u378, v25) * 256 + (readu8(u383, v27))), (readu8(a1, 8))))
    )
    writeu32(
        a5,
        a6 + 12,
        bxor(readu8(u373, readu8(u378, v20) * 256 + (readu8(u383, v18))), (readu8(a1, 15))) * 16777216 + bxor(readu8(u373, readu8(u378, v23) * 256 + (readu8(u383, v21))), (readu8(a1, 14))) * 65536 + bxor(readu8(u373, readu8(u378, v26) * 256 + (readu8(u383, v28))), (readu8(a1, 13))) * 256 + (bxor(readu8(u373, readu8(u378, v29) * 256 + (readu8(u383, v31))), (readu8(a1, 12))))
    )
end

local v6 = create(256)
local v7 = create(256)
local v8 = create(256)
local v9 = create(256)
local v10 = create(256)
local v11 = 1
local v12 = 1

local function gfmul(a1, a2) -- Line: 748 -- upvalues: bxor (val), floor (val) -- types: a1: number, a2: number
    local v1 = 0
    local v2, v3 = a2, a1
    for i = 0, 7 do
        if v2 % 2 == 1 then
            v1 = bxor(v1, v3)
        end
        v3 = if not (v3 >= 128) then v3 * 2 % 256 else bxor(v3 * 2 % 256, 27)
        floor(v2 / 2)
    end
    return v1
end

writeu8(v6, 0, 99)
for i = 1, 255 do
    v4 = v11 * 2
    v11 = bxor(v11, v4, if not (v11 < 128) then 27 else 0) % 256
    v12 = bxor(v12, v12 * 2)
    v12 = bxor(v12, v12 * 4)
    v12 = bxor(v12, v12 * 16) % 256
    if v12 >= 128 then
        v12 = bxor(v12, 9)
    end
    v1 = bxor(v12, v12 % 128 * 2 + v12 / 128, v12 % 64 * 4 + v12 / 64, v12 % 32 * 8 + v12 / 32, v12 % 16 * 16 + v12 / 16, 99)
    writeu8(v6, v11, v1)
    writeu8(v7, v1, v11)
    writeu8(v8, v11, (gfmul(3, v11)))
    writeu8(v9, v11, (gfmul(9, v11)))
    writeu8(v10, v11, (gfmul(11, v11)))
end
v1 = 0
for j = 0, 255 do
    v11 = readu8(v6, j)
    v2 = v11 * 256
    v3 = gfmul(2, v11)
    v4 = gfmul(13, j)
    v5 = gfmul(14, j)
    for k = 0, 255 do
        v12 = readu8(v6, k)
        writeu16(u358, v1 * 2, v2 + v12)
        writeu8(u373, v1, (readu8(v7, (bxor(j, k)))))
        writeu8(u363, v1, (bxor(v3, (readu8(v8, v12)))))
        writeu8(u368, v1, (bxor(v11, v12)))
        writeu8(u378, v1, (bxor(v5, (readu8(v10, k)))))
        writeu8(u383, v1, (bxor(v4, (readu8(v9, k)))))
        v1 = v1 + 1
    end
end

local function newidx(a1, a2) -- Line: 845
    return error((("%* cannot be assigned to"):format(a2)))
end

local function tostr() -- Line: 848
    return "AesCipher"
end

local Modes = require(script.Modes)
local Pads = require(script.Pads)

local function expandKey(a1, a2) -- Line: 854
    -- upvalues: len (val), keySchedule (val), create (val)
    local v1
    local v2 = if not (typeof(a1) == "buffer") then #a1 else len(a1)
    return (keySchedule(
        a1,
        v2,
        a2 or create(if v2 ~= 32 then if v2 ~= 24 then if v2 ~= 16 then error("Key must be either 16, 24 or 32 bytes long") else 176 else 208 else 240),
        v1
    ))
end

local function fromKey(a1, a2, a3) -- Line: 864
    -- upvalues: len (val), tostring (val), sub (val), Modes (val), Pads (val), encryptBlock (val), decryptBlock (val)
    -- upvalues: fromstring (val), create (val), newidx (val), tostr (val)
    local u5 = len(a1)
    local u6 = nil
    local u7 = nil
    local u10 = tostring(a1)
    if u5 == 240 then
        u6 = 192
        u7 = sub(u10, 1, 32)
    elseif u5 == 208 then
        u6 = 160
        u7 = sub(u10, 1, 24)
    elseif u5 ~= 176 then
        error("Round keys must be either 240, 208 or 128 bytes long")
    else
        u6 = 128
        u7 = sub(u10, 1, 16)
    end
    local u36 = a1
    local ECB = a2
    if not ECB then
        ECB = Modes.ECB
    end
    local FwdMode = ECB.FwdMode
    local InvMode = ECB.InvMode
    local u45 = ECB.SegmentSize or 16
    local Pkcs7 = a3
    if not Pkcs7 then
        Pkcs7 = Pads.Pkcs7
    end
    local Pad = Pkcs7.Pad
    local Unpad = Pkcs7.Unpad
    local u56 = newproxy(true)
    local v1 = getmetatable(u56)

    local function encp(a1, a2, a3, a4) -- Line: 894 -- upvalues: encryptBlock (upval), u36 (ref), u6 (ref)
        encryptBlock(u36, u6, a1, a2, a3, a4)
    end

    local function decp(a1, a2, a3, a4) -- Line: 897 -- upvalues: decryptBlock (upval), u36 (ref), u6 (ref)
        decryptBlock(u36, u6, a1, a2, a3, a4)
    end

    local function enc(a1, a2, a3, ...) -- Line: 900
        -- upvalues: fromstring (upval), u56 (val), u6 (ref), Pad (val), u45 (val), FwdMode (ref), encp (val)
        -- upvalues: decp (val), Pkcs7 (ref), ECB (ref), create (upval)
        local v1 = if typeof(a2) == "buffer" then a2 else if typeof(a2) ~= "string" then error((("Unable to cast %* to buffer"):format((typeof(a2))))) else fromstring(a2)
        local v2 = false
        if typeof(a3) == "buffer" then
            v2 = a3
        end
        local v3 = v2
        if a1 ~= u56 then
            return a1:Encrypt(v1, v3, ...)
        end
        if not u6 then
            error("AesCipher object's already destroyed")
            return create(0)
        end
        v2 = Pad(v1, v3, u45)
        FwdMode(encp, decp, if Pkcs7.Overwrite ~= false then v2 else v1, v2, ECB, ...)
        return v2
    end

    local function encb(a1, a2, a3, a4, a5) -- Line: 917
        -- upvalues: u56 (val), u6 (ref), encryptBlock (upval), u36 (ref)
        if a1 ~= u56 then
            a1:EncryptBlock(a2, a3, a4, a5)
            return
        end
        if u6 then
            encryptBlock(u36, u6, a2, a3, a4 or a2, a5 or a3)
            return
        end
        error("AesCipher object's already destroyed")
    end

    local function dec(a1, a2, a3, ...) -- Line: 926
        -- upvalues: fromstring (upval), u56 (val), u6 (ref), Pkcs7 (ref), create (upval), len (upval), InvMode (ref)
        -- upvalues: encp (val), decp (val), ECB (ref), Unpad (val), u45 (val)
        local v1 = if typeof(a2) == "buffer" then a2 else if typeof(a2) ~= "string" then error((("Unable to cast %* to buffer"):format((typeof(a2))))) else fromstring(a2)
        local v2 = false
        if typeof(a3) == "buffer" then
            v2 = a3
        end
        local v3 = v2
        if a1 ~= u56 then
            return a1:Decrypt(v1, v3, ...)
        end
        if not u6 then
            error("AesCipher object's already destroyed")
            return create(0)
        end
        local Overwrite = Pkcs7.Overwrite
        local v4 = if Overwrite ~= nil then if not Overwrite then v3 or create(len(v1)) else v1 else create(len(v1))
        InvMode(encp, decp, v1, v4, ECB, ...)
        return (Unpad(v4, v3, u45))
    end

    local function decb(a1, a2, a3, a4, a5) -- Line: 947
        -- upvalues: u56 (val), u6 (ref), decryptBlock (upval), u36 (ref)
        if a1 ~= u56 then
            a1:DecryptBlock(a2, a3, a4, a5)
            return
        end
        if u6 then
            decryptBlock(u36, u6, a2, a3, a4 or a2, a5 or a3)
            return
        end
        error("AesCipher object's already destroyed")
    end

    local function destroy(a1) -- Line: 956
        -- upvalues: u56 (val), u6 (ref), u10 (ref), u36 (ref), FwdMode (ref), InvMode (ref), ECB (ref), Pkcs7 (ref)
        -- upvalues: u7 (ref), u5 (ref)
        if a1 ~= u56 then
            a1:Destroy()
            return
        end
        if not u6 then
            error("AesCipher object's already destroyed")
            return
        end
        u10 = nil
        u36 = nil
        u6 = nil
        FwdMode = nil
        InvMode = nil
        ECB = nil
        Pkcs7 = nil
        u7 = nil
        u5 = nil
    end

    function v1.__index(a1, a2) -- Line: 967
        -- upvalues: enc (val), dec (val), encb (val), decb (val), destroy (val), u6 (ref), u7 (ref), u10 (ref)
        -- upvalues: ECB (ref), Pkcs7 (ref), u5 (ref)
        if a2 == "Encrypt" then
            return enc
        end
        if a2 == "Decrypt" then
            return dec
        end
        if a2 == "EncryptBlock" then
            return encb
        end
        if a2 == "DecryptBlock" then
            return decb
        end
        if a2 == "Destroy" then
            return destroy
        end
        if not u6 then
            return (error("AesCipher object's already destroyed"))
        end
        if a2 == "Key" then
            return u7
        end
        if a2 == "RoundKeys" then
            return u10
        end
        if a2 == "Mode" then
            return ECB
        end
        if a2 == "Padding" then
            return Pkcs7
        end
        if a2 == "Length" then
            return u5
        end
        return (error((("%* is not a valid member of AesCipher"):format(a2))))
    end

    v1.__newindex = newidx
    v1.__tostring = tostr

    function v1.__len() -- Line: 985 -- upvalues: u5 (ref)
        return u5 or error("AesCipher object's destroyed")
    end

    v1.__metatable = "AesCipher object: Metatable's locked"
    return u56
end

return table.freeze({
    new = function(a1, a2, a3) -- Line: 993 -- upvalues: fromKey (val), expandKey (val)
        return (fromKey(expandKey(a1), a2, a3))
    end,
    expandKey = expandKey,
    fromKey = fromKey,
    modes = Modes,
    pads = Pads,
})