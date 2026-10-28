-- Script path: ReplicatedStorage.UserGenerated.Lottie.PNG.zlib
-- Decompile time: 34.35 ms

local v1, v2
local u567 = {
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    15,
    17,
    19,
    23,
    27,
    31,
    35,
    43,
    51,
    59,
    67,
    83,
    99,
    115,
    131,
    163,
    195,
    227,
    258,
}
local u572 = {1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0}
local u519 = {
    1,
    2,
    3,
    4,
    5,
    7,
    9,
    13,
    17,
    25,
    33,
    49,
    65,
    97,
    129,
    193,
    257,
    385,
    513,
    769,
    1025,
    1537,
    2049,
    3073,
    4097,
    6145,
    8193,
    12289,
    16385,
    24577,
}
local u581 = {0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13}
local u562 = {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15}

local function createHuffmanTable(a1) -- Line: 56 -- types: a1: table
    local v1
    local v2 = table.create(15, 0)
    v2[0] = 0
    for i, j in a1 do
        if j > 0 then
            v2[j] = (v2[j] or 0) + 1
        end
    end
    local v3 = 1
    local v4 = table.create(15)
    for k = 1, 15 do
        v3 = bit32.lshift(v3 + v2[k - 1], 1)
        v4[k] = v3
    end
    v3 = {}
    v2 = {}
    local v5 = {}
    for n, m in a1 do
        if m > 0 then
            v3[v4[m]] = n - 1
            v1 = n - 1
            v2[v1] = (bit32.extract(v4[m], 0, m))
            v5[n - 1] = m
            v4[m] = v4[m] + 1
        end
    end
    return v3, v2, v5
end

local u587 = {}
local u592 = {}
local u597 = {}
for i = 3, 258 do
    v1 = nil
    for j = #u567, 1, -1 do
        if u567[j] <= i then
            v1 = j
            break
        end
    end
    u587[i] = 256 + v1
    u592[i] = i - u567[v1]
    u597[i] = u572[v1 - 8] or 0
end
local u479 = {}
for k = 1, 1024 do
    v2 = nil
    for n = #u519, 1, -1 do
        if u519[n] <= k then
            v2 = n
            break
        end
    end
    u479[k] = v2
end
local u539, u540, u541 = createHuffmanTable({
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
})
local u547, u548, u549 = createHuffmanTable(table.create(32, 5))

local function getStoreSize(a1) -- Line: 118 -- types: a1: number
    return math.ceil(a1 / 32768) * 5 + a1
end

local function getDistIdx(a1) -- Line: 122 -- upvalues: u479 (val) -- types: a1: number
    if a1 < 1025 then
        return u479[a1]
    end
    if a1 < 1537 then
        return 21
    end
    if a1 < 2049 then
        return 22
    end
    if a1 < 3073 then
        return 23
    end
    if a1 < 4097 then
        return 24
    end
    if a1 < 6145 then
        return 25
    end
    if a1 < 8193 then
        return 26
    end
    if a1 < 12289 then
        return 27
    end
    if a1 < 16385 then
        return 28
    end
    if a1 < 24577 then
        return 29
    end
    return 30
end

local function adler32(a1, a2, a3) -- Line: 139 -- types: a1: buffer, a2: number, a3: number
    local v1 = 1
    local v2 = 0
    local v3 = 0
    local v4 = a2 + a3 - 1
    for i = a2, v4 do
        v1 = v1 + buffer.readu8(a1, i)
        v2 = v2 + v1
        v3 = v3 + 1
        if v3 == 8400000 then
            v1 = v1 % 65521
            v2 = v2 % 65521
        end
    end
    return (bit32.bor(bit32.lshift(v2 % 65521, 16), v1 % 65521))
end

return {
    inflate = function(a1, a2) -- Line: 156
        -- upvalues: u539 (val), u547 (val), u562 (val), createHuffmanTable (val), u567 (val), u572 (val), u519 (val)
        -- upvalues: u581 (val), adler32 (val)
        local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16
        local v17 = buffer.readu8(a1, 0)
        local v18 = buffer.readu8(a1, 1)
        assert(bit32.extract(v17, 0, 4) == 8, "invalid zlib comp method")
        assert((bit32.extract(v17, 4, 4)) <= 7, "invalid zlib window size")
        assert(bit32.extract(v18, 5, 1) == 0, "preset dictionary is not allowed")
        assert(bit32.bor(bit32.lshift(v17, 8), v18) % 31 == 0, "zlib header sum mismatch")
        local u972 = 2
        local u118 = 0

        local function readBit() -- Line: 167 -- upvalues: a1 (val), u972 (ref), u118 (ref)
            local v1 = u972
            local v2 = bit32.extract(buffer.readu8(a1, v1), u118)
            u118 = u118 + 1
            if u118 == 8 then
                u118 = 0
                u972 = u972 + 1
            end
            return v2
        end

        local function readBits(a1_2) -- Line: 177 -- upvalues: a1 (val), u972 (ref), u118 (ref) -- types: a1_2: number
            local v1 = buffer.readbits(a1, u972 * 8 + u118, a1_2)
            u118 = u118 + a1_2
            u972 = u972 + bit32.rshift(u118, 3)
            bit32.band(u118, 7)
            return v1
        end

        local function readHuffmanTable(a1_2) -- Line: 185
            -- upvalues: a1 (val), u972 (ref), u118 (ref)
            local v1
            local v2 = u972
            local v3 = bit32.extract(buffer.readu8(a1, v2), u118)
            u118 = u118 + 1
            if u118 == 8 then
                u118 = 0
                u972 = u972 + 1
            end
            local v4 = 2 + v3
            local v5 = a1_2
            while not v5[v4] do
                v1 = 2 * v4
                v2 = u972
                v3 = bit32.extract(buffer.readu8(a1, v2), u118)
                u118 = u118 + 1
                if u118 == 8 then
                    u118 = 0
                    u972 = u972 + 1
                end
                v4 = v1 + v3
            end
            return v5[v4]
        end

        local v19 = 0
        repeat
            v2 = u118
            bit32.extract(buffer.readu8(a1, u972), v2)
            u118 = u118 + 1
            if u118 == 8 then
                u118 = 0
                u972 = u972 + 1
            end
            v16 = buffer.readbits(a1, u972 * 8 + u118, 2)
            u118 = u118 + 2
            v3 = u118
            u972 = u972 + bit32.rshift(v3, 3)
            u118 = bit32.band(u118, 7)
            assert(v16 ~= 3, "reserved btype")
            if v16 ~= 0 then
                v2 = u539
                v3 = u547
                if v16 == 2 then
                    v5 = buffer.readbits(a1, u972 * 8 + u118, 5)
                    u118 = u118 + 5
                    v7 = u118
                    u972 = u972 + bit32.rshift(v7, 3)
                    u118 = bit32.band(u118, 7)
                    v4 = v5 + 257
                    v6 = buffer.readbits(a1, u972 * 8 + u118, 5)
                    u118 = u118 + 5
                    v8 = u118
                    u972 = u972 + bit32.rshift(v8, 3)
                    u118 = bit32.band(u118, 7)
                    v5 = v6 + 1
                    v7 = buffer.readbits(a1, u972 * 8 + u118, 4)
                    u118 = u118 + 4
                    v9 = u118
                    u972 = u972 + bit32.rshift(v9, 3)
                    u118 = bit32.band(u118, 7)
                    v6 = v7 + 4
                    v7 = table.create(19, 0)
                    for i = 1, v6 do
                        v11 = u562[i] + 1
                        v12 = buffer.readbits(a1, u972 * 8 + u118, 3)
                        u118 = u118 + 3
                        v14 = u118
                        u972 = u972 + bit32.rshift(v14, 3)
                        u118 = bit32.band(u118, 7)
                        v7[v11] = v12
                    end
                    v6 = createHuffmanTable(v7)
                    v7 = table.create(v4)
                    v8 = nil
                    repeat
                        v14 = u118
                        v12 = bit32.extract(buffer.readu8(a1, u972), v14)
                        u118 = u118 + 1
                        if u118 == 8 then
                            u118 = 0
                            u972 = u972 + 1
                        end
                        v10 = 2 + v12
                        while not v6[v10] do
                            v11 = 2 * v10
                            v14 = u118
                            v12 = bit32.extract(buffer.readu8(a1, u972), v14)
                            u118 = u118 + 1
                            if u118 == 8 then
                                u118 = 0
                                u972 = u972 + 1
                            end
                            v10 = v11 + v12
                        end
                        v9 = v6[v10]
                        v10 = 1
                        if v9 <= 15 then
                            v8 = v9
                        elseif v9 == 16 then
                            v11 = buffer.readbits(a1, u972 * 8 + u118, 2)
                            u118 = u118 + 2
                            v13 = u118
                            u972 = u972 + bit32.rshift(v13, 3)
                            u118 = bit32.band(u118, 7)
                            v10 = v11 + 3
                        elseif v9 == 17 then
                            v8 = 0
                            v11 = buffer.readbits(a1, u972 * 8 + u118, 3)
                            u118 = u118 + 3
                            v13 = u118
                            u972 = u972 + bit32.rshift(v13, 3)
                            u118 = bit32.band(u118, 7)
                            v10 = v11 + 3
                        elseif v9 == 18 then
                            v8 = 0
                            v11 = buffer.readbits(a1, u972 * 8 + u118, 7)
                            u118 = u118 + 7
                            v13 = u118
                            u972 = u972 + bit32.rshift(v13, 3)
                            u118 = bit32.band(u118, 7)
                            v10 = v11 + 11
                        end
                        for j = 1, v10 do
                            table.insert(v7, v8)
                        end
                    until v4 <= #v7
                    v2 = createHuffmanTable(v7)
                    v8 = table.create(v5)
                    v9 = nil
                    repeat
                        v13 = u118
                        v11 = bit32.extract(buffer.readu8(a1, u972), v13)
                        u118 = u118 + 1
                        if u118 == 8 then
                            u118 = 0
                            u972 = u972 + 1
                        end
                        v4 = 2 + v11
                        while not v6[v4] do
                            v10 = 2 * v4
                            v13 = u118
                            v11 = bit32.extract(buffer.readu8(a1, u972), v13)
                            u118 = u118 + 1
                            if u118 == 8 then
                                u118 = 0
                                u972 = u972 + 1
                            end
                            v4 = v10 + v11
                        end
                        v7 = v6[v4]
                        v10 = 1
                        if v7 <= 15 then
                            v9 = v7
                        elseif v7 == 16 then
                            v11 = buffer.readbits(a1, u972 * 8 + u118, 2)
                            u118 = u118 + 2
                            v13 = u118
                            u972 = u972 + bit32.rshift(v13, 3)
                            u118 = bit32.band(u118, 7)
                            v10 = v11 + 3
                        elseif v7 == 17 then
                            v9 = 0
                            v11 = buffer.readbits(a1, u972 * 8 + u118, 3)
                            u118 = u118 + 3
                            v13 = u118
                            u972 = u972 + bit32.rshift(v13, 3)
                            u118 = bit32.band(u118, 7)
                            v10 = v11 + 3
                        elseif v7 == 18 then
                            v9 = 0
                            v11 = buffer.readbits(a1, u972 * 8 + u118, 7)
                            u118 = u118 + 7
                            v13 = u118
                            u972 = u972 + bit32.rshift(v13, 3)
                            u118 = bit32.band(u118, 7)
                            v10 = v11 + 11
                        end
                        for k = 1, v10 do
                            table.insert(v8, v9)
                        end
                    until v5 <= #v8
                    v3 = createHuffmanTable(v8)
                end
                repeat
                    v10 = u118
                    v8 = bit32.extract(buffer.readu8(a1, u972), v10)
                    u118 = u118 + 1
                    if u118 == 8 then
                        u118 = 0
                        u972 = u972 + 1
                    end
                    v6 = 2 + v8
                    while not v2[v6] do
                        v7 = 2 * v6
                        v10 = u118
                        v8 = bit32.extract(buffer.readu8(a1, u972), v10)
                        u118 = u118 + 1
                        if u118 == 8 then
                            u118 = 0
                            u972 = u972 + 1
                        end
                        v6 = v7 + v8
                    end
                    v4 = v2[v6]
                    if v4 < 256 then
                        buffer.writeu8(v1, v19, v4)
                        v19 = v19 + 1
                    elseif v4 > 256 then
                        v5 = u567[v4 - 256]
                        if v4 > 268 then
                            v7 = u572[v4 - 264]
                            v6 = buffer.readbits(a1, u972 * 8 + u118, v7)
                            u118 = u118 + v7
                            v9 = u118
                            u972 = u972 + bit32.rshift(v9, 3)
                            u118 = bit32.band(u118, 7)
                            v5 = v5 + v6
                        elseif v4 > 264 then
                            v8 = u118
                            v6 = bit32.extract(buffer.readu8(a1, u972), v8)
                            u118 = u118 + 1
                            if u118 == 8 then
                                u118 = 0
                                u972 = u972 + 1
                            end
                            v5 = v5 + v6
                        end
                        v12 = u118
                        v10 = bit32.extract(buffer.readu8(a1, u972), v12)
                        u118 = u118 + 1
                        if u118 == 8 then
                            u118 = 0
                            u972 = u972 + 1
                        end
                        v8 = 2 + v10
                        while not v3[v8] do
                            v9 = 2 * v8
                            v12 = u118
                            v10 = bit32.extract(buffer.readu8(a1, u972), v12)
                            u118 = u118 + 1
                            if u118 == 8 then
                                u118 = 0
                                u972 = u972 + 1
                            end
                            v8 = v9 + v10
                        end
                        v6 = v3[v8]
                        v7 = u519[v6 + 1]
                        if v6 > 5 then
                            v9 = u581[v6]
                            v8 = buffer.readbits(a1, u972 * 8 + u118, v9)
                            u118 = u118 + v9
                            v11 = u118
                            u972 = u972 + bit32.rshift(v11, 3)
                            u118 = bit32.band(u118, 7)
                            v7 = v7 + v8
                        elseif v6 > 3 then
                            v10 = u118
                            v8 = bit32.extract(buffer.readu8(a1, u972), v10)
                            u118 = u118 + 1
                            if u118 == 8 then
                                u118 = 0
                                u972 = u972 + 1
                            end
                            v7 = v7 + v8
                        end
                        if not (v5 <= v7) then
                            repeat
                                v6 = math.min(v5, v7)
                                buffer.copy(v1, v19, v1, v19 - v7, v6)
                                v19 = v19 + v6
                                v5 = v5 - v6
                                v7 = v7 + v6
                            until v5 == 0
                        else
                            buffer.copy(v1, v19, v1, v19 - v7, v5)
                            v19 = v19 + v5
                        end
                    end
                until v4 == 256
            else
                if u118 > 0 then
                    u972 = u972 + 1
                    u118 = 0
                end
                v4 = u972
                v2 = buffer.readu16(a1, v4)
                v9 = u972 + 2
                assert(bit32.bxor(v2, (buffer.readu16(a1, v9))) == 65535, "len ~= nlen")
                u972 = u972 + 4
                buffer.copy(v1, v19, a1, u972, v2)
                v19 = v19 + v2
                u972 = u972 + v2
            end
        until v15 == 1
        if u118 > 0 then
            u972 = u972 + 1
        end
        assert((adler32(v1, 0, buffer.len(v1))) == bit32.byteswap((buffer.readu32(a1, u972))), "adler-32 checksum mismatch")
        return v19
    end,
    deflate = function(a1) -- Line: 322
        -- upvalues: u540 (val), u541 (val), u587 (val), u592 (val), u597 (val), getDistIdx (val), u548 (val)
        -- upvalues: u549 (val), u519 (val), u581 (val), adler32 (val)
        local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, y
        local v17 = buffer.len(a1)
        local u608 = buffer.create(math.ceil(v17 / 32768) * 5 + v17 + 6)
        buffer.writeu16(u608, 0, 24184)
        local u629 = 2
        local u501 = 0

        local function writeBits(a1, a2) -- Line: 333
            -- upvalues: u608 (val), u629 (ref), u501 (ref)
            buffer.writebits(u608, u629 * 8 + u501, a2, a1)
            u501 = u501 + a2
            u629 = u629 + bit32.rshift(u501, 3)
            bit32.band(u501, 7)
        end

        local function writeHuffmanBits(a1, a2) -- Line: 341
            -- upvalues: u608 (val), u629 (ref), u501 (ref)
            local v1 = bit32.bor(bit32.band(bit32.rshift(a1, 1), 1431655765), (bit32.band(bit32.lshift(a1, 1), 2863311530)))
            v1 = bit32.bor(bit32.band(bit32.rshift(v1, 2), 858993459), (bit32.band(bit32.lshift(v1, 2), 3435973836)))
            v1 = bit32.bor(bit32.band(bit32.rshift(v1, 4), 252645135), (bit32.band(bit32.lshift(v1, 4), 4042322160)))
            v1 = bit32.bor(bit32.band(bit32.rshift(v1, 8), 16711935), (bit32.band(bit32.lshift(v1, 8), 4278255360)))
            local v2 = bit32.band(bit32.rshift(bit32.bor(bit32.rshift(v1, 16), (bit32.lshift(v1, 16))), 32 - a2), (bit32.lshift(1, a2)) - 1)
            buffer.writebits(u608, u629 * 8 + u501, a2, v2)
            u501 = u501 + a2
            u629 = u629 + bit32.rshift(u501, 3)
            bit32.band(u501, 7)
        end

        local function writeLitOrLen(a1) -- Line: 351
            -- upvalues: writeHuffmanBits (val), u540 (upval), u541 (upval)
            writeHuffmanBits(u540[a1], u541[a1])
        end

        local function writeBackRef(a1, a2) -- Line: 355
            -- upvalues: u587 (upval), writeHuffmanBits (val), u540 (upval), u541 (upval), u592 (upval), u597 (upval)
            -- upvalues: u608 (val), u629 (ref), u501 (ref), getDistIdx (upval), u548 (upval), u549 (upval)
            -- upvalues: u519 (upval), u581 (upval)
            local v1
            local v2 = u587[a2]
            writeHuffmanBits(u540[v2], u541[v2])
            if a2 > 10 then
                v2 = u592[a2]
                v1 = u597[a2]
                buffer.writebits(u608, u629 * 8 + u501, v1, v2)
                u501 = u501 + v1
                u629 = u629 + bit32.rshift(u501, 3)
                u501 = bit32.band(u501, 7)
            end
            v2 = getDistIdx(a1)
            writeHuffmanBits(u548[v2 - 1], u549[v2 - 1])
            if v2 > 3 then
                v1 = a1 - u519[v2]
                local v3 = u581[v2 - 1]
                buffer.writebits(u608, u629 * 8 + u501, v3, v1)
                u501 = u501 + v3
                u629 = u629 + bit32.rshift(u501, 3)
                bit32.band(u501, 7)
            end
        end

        local function getLitOrLenSize(a1) -- Line: 367 -- upvalues: u541 (upval) -- types: a1: number
            return u541[a1]
        end

        local function getBackRefSize(a1, a2) -- Line: 371
            -- upvalues: getDistIdx (upval), u587 (upval), u541 (upval), u597 (upval), u549 (upval), u581 (upval)
            local v1 = getDistIdx(a1)
            local v2 = u587[a2]
            return u541[v2] + u597[a2] + u549[v1 - 1] + (u581[v1 - 1] or 0)
        end

        local u262 = {}
        local u265 = {}
        local u268 = {}
        local u560 = 0

        local function insertNode(a1, a2) -- Line: 384
            -- upvalues: u560 (ref), u262 (val), u265 (val)
            u560 = u560 + 1
            u262[u560] = a1
            u265[u560] = a2
            return u560
        end

        local function clearTables() -- Line: 391 -- upvalues: u262 (val), u265 (val), u268 (val), u560 (ref)
            table.clear(u262)
            table.clear(u265)
            table.clear(u268)
            u560 = 0
        end

        local v18 = v17 - 1
        for i = 0, v18, 32768 do
            v1 = 0
            v2 = math.min(v17, i + 32768)
            v3 = i
            v4 = {}
            while v3 < v2 - 3 do
                v5 = bit32.band(buffer.readu32(a1, v3), 16777215)
                v9 = u268[v5]
                u560 = u560 + 1
                u262[u560] = v3
                u265[u560] = v9 or 0
                v6 = u560
                u268[v5] = v6
                v5 = 0
                v7 = -1
                v8 = 0
                v9 = u265[v6]
                while v9 do
                    v10 = u262[v9] or (-1 / 0)
                    if not (v3 - 32510 <= v10) or not (v8 < 12) or not (v5 < 96) then
                        break
                    end
                    v6 = 3
                    v10 = u262[v9]
                    v11 = false
                    v12 = math.min(v2, v3 + 258)
                    if v3 + v5 < v12 then
                        v15 = v10 + v5
                        v13 = buffer.readu8(a1, v15)
                        v16 = v3 + v5
                        if v13 ~= buffer.readu8(a1, v16) then
                            v11 = true
                        end
                    end
                    while not v11 do
                        if not (v6 < 258) or not (v3 + v6 < v2) then
                            break
                        end
                        v15 = v10 + v6
                        v13 = buffer.readu8(a1, v15)
                        v16 = v3 + v6
                        if v13 ~= buffer.readu8(a1, v16) then
                            break
                        end
                        v6 = v6 + 1
                    end
                    if v5 < v6 then
                        v7 = v10
                        if v6 >= 258 then
                            break
                        end
                    end
                    v9 = u265[v9]
                    v8 = v8 + 1
                end
                if v5 ~= 0 then
                    v11 = v3 - v7
                    v8 = getDistIdx(v11)
                    v16 = u587[v5]
                    v1 = v1 + (u541[v16] + u597[v5] + u549[v8 - 1] + (u581[v8 - 1] or 0))
                    v14 = v3 - v7
                    table.insert(v4, (vector.create(1, v14, v5)))
                    for j = v3 + 1, (math.min(v3 + v5 - 1, v2 - 4)) do
                        v13 = bit32.band(buffer.readu32(a1, j), 16777215)
                        v16 = u268[v13]
                        u560 = u560 + 1
                        u262[u560] = j
                        u265[u560] = v16 or 0
                        u268[v13] = u560
                    end
                    v3 = v3 + v5
                else
                    v9 = buffer.readu8(a1, v3)
                    v1 = v1 + u541[v9]
                    table.insert(v4, (vector.create(0, v9)))
                    v3 = v3 + 1
                end
            end
            while v3 < v2 do
                v5 = buffer.readu8(a1, v3)
                v1 = v1 + u541[v5]
                table.insert(v4, (vector.create(0, v5)))
                v3 = v3 + 1
            end
            v1 = v1 + u541[256]
            table.insert(v4, (Vector3.new(0, 256, 0)))
            if v2 ~= v17 then
                buffer.writebits(u608, u629 * 8 + u501, 1, 0)
            else
                buffer.writebits(u608, u629 * 8 + u501, 1, 1)
            end
            u501 = u501 + 1
            v6 = u501
            u629 = u629 + bit32.rshift(v6, 3)
            u501 = bit32.band(u501, 7)
            v3 = v2 - i
            v2 = math.ceil(v1 / 8) + 1
            v8 = v3 / 32768
            if not (v2 < math.ceil(v8) * 5 + v3) then
                buffer.writebits(u608, u629 * 8 + u501, 2, 0)
                u501 = u501 + 2
                v6 = u501
                u629 = u629 + bit32.rshift(v6, 3)
                u501 = bit32.band(u501, 7)
                if u501 > 0 then
                    u629 = u629 + 1
                    u501 = 0
                end
                v7 = u629
                buffer.writeu16(u608, v7, v3)
                v7 = u629 + 2
                v8 = bit32.bxor(65535, v3)
                buffer.writeu16(u608, v7, v8)
                buffer.copy(u608, u629 + 4, a1, i, v3)
                u629 = u629 + (v3 + 4)
            else
                buffer.writebits(u608, u629 * 8 + u501, 2, 1)
                u501 = u501 + 2
                v6 = u501
                u629 = u629 + bit32.rshift(v6, 3)
                u501 = bit32.band(u501, 7)
                for k, n in v4 do
                    if n.x ~= 0 then
                        writeBackRef(n.y, n.z)
                    else
                        y = n.y
                        writeHuffmanBits(u540[y], u541[y])
                    end
                end
            end
            if u560 > 50000 then
                table.clear(u262)
                table.clear(u265)
                table.clear(u268)
                u560 = 0
            end
        end
        if u501 > 0 then
            u629 = u629 + 1
        end
        v1 = bit32.byteswap((adler32(a1, 0, (buffer.len(a1)))))
        local v19 = u629
        buffer.writeu32(u608, v19, v1)
        return u608, u629 + 4
    end,
}