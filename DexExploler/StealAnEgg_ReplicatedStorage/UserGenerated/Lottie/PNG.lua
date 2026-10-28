-- Script path: ReplicatedStorage.UserGenerated.Lottie.PNG
-- Decompile time: 41.83 ms

require(script.Types)
local chunks = require(script.chunks)
local crc32 = require(script.crc32)
local zlib = require(script.zlib)
local u16 = {
    [0] = 1,
    [2] = 3,
    [3] = 1,
    [4] = 2,
    [6] = 4,
}
local u23 = {0, 0, 4, 0, 2, 0, 1}
local u31 = {0, 4, 0, 2, 0, 1, 0}
local u39 = {8, 8, 8, 4, 4, 2, 2}
local u47 = {8, 8, 4, 4, 2, 2, 1}
return {
    decode = function(a1, a2) -- Line: 38
        -- upvalues: crc32 (val), chunks (val), u16 (val), u31 (val), u47 (val), u23 (val), u39 (val), zlib (val)
        local type, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
        local v12 = buffer.len(a1)
        assert(v12 >= 8, "not a PNG")
        assert(buffer.readstring(a1, 0, 8) == "‰PNG\r\n\026\n", "not a PNG")
        local v13 = table.create(3)
        local v14 = 8
        local v15 = false
        if a2 ~= nil then
            v15 = a2.allowIncorrectCRC == true
        end
        local v16 = a1
        repeat
            v8 = bit32.byteswap((buffer.readu32(v16, v14)))
            v9 = buffer.readstring(v16, v14 + 4, 4)
            assert(string.match(v9, "%a%a%a%a"), (("invalid chunk type %*"):format(v9)))
            v10 = v14 + 8
            v11 = v10 + v8 + 4
            v3 = ("EOF while reading %* chunk"):format(v9)
            assert(v11 <= v12, v3)
            v4 = v11 - 4
            v1 = bit32.byteswap((buffer.readu32(v16, v4)))
            v2 = crc32(v16, v14 + 4, v11 - 5)
            v5 = ("incorrect checksum in %*"):format(v9)
            assert(v15 or v1 == v2, v5)
            table.insert(v13, {type = v9, offset = v10, length = v8})
        until v12 <= v11
        assert(v14 == v12, "trailing data in file")
        for i, j in v13 do
            type = j.type
            if bit32.extract(string.byte(type, 1, 1), 5) == 0
                and type ~= "IHDR"
                and type ~= "IDAT"
                and type ~= "PLTE"
                and type ~= "IEND" then
                error((("unhandled critical chunk %*"):format(type)))
            end
        end
        v14 = v13[1]
        assert(v14.type == "IHDR", "first chunk must be IHDR")
        v9 = #v13
        for k = 2, v9 do
            assert(v13[k].type ~= "IHDR", "multiple IHDR chunks are not allowed")
        end
        v8 = chunks.IHDR(v16, v14)
        v14 = -1
        v12 = -1
        v9 = 0
        v11 = nil
        v1 = nil
        for n, m in v13, v11, v1 do
            if m.type == "IDAT" then
                if not (v14 < 0) then
                    assert(n == v12 + 1, "multiple IDAT chunks must be consecutive")
                else
                    v14 = n
                end
                v12 = n
                v9 = v9 + m.length
            end
        end
        assert(v14 > 0, "no IDAT chunks")
        assert(v9 > 0, "no image data in IDAT chunks")
        v10 = nil
        v12 = -1
        v1 = nil
        v2 = nil
        for i5, i6 in v13, v1, v2 do
            if i6.type == "PLTE" then
                assert(not v10, "multiple PLTE chunks are not allowed")
                assert(i5 < v14, "PLTE not allowed after IDAT chunks")
                v6 = false
                if v8.colorType ~= 0 then
                    v6 = v8.colorType ~= 4
                end
                assert(v6, "PLTE not allowed for color type")
                v10 = chunks.PLTE(v16, i6, v8)
                v12 = i5
            end
        end
        if v8.colorType == 3 then
            assert(v10 ~= nil, "color type requires a PLTE chunk")
        end
        v11 = nil
        v2 = nil
        v3 = nil
        for i7, i8 in v13, v2, v3 do
            if i8.type == "tRNS" then
                assert(v11 == nil, "multiple tRNS chunks are not allowed")
                assert(i7 < v14, "tRNS not allowed after IDAT chunks")
                assert(not v10 or v12 < i7, "tRNS must be after PLTE")
                v7 = false
                if v8.colorType ~= 4 then
                    v7 = v8.colorType ~= 6
                end
                assert(v7, "tRNS not allowed for color type")
                v11 = chunks.tRNS(v16, i8, v8, v10)
            end
        end
        v14 = v13[#v13]
        assert(v14.type == "IEND", "final chunk must be IEND")
        assert(v14.length == 0, "IEND chunk must be empty")
        v1 = #v13 - 1
        for i9 = 2, v1 do
            assert(v13[i9].type ~= "IEND", "multiple IEND chunks are not allowed")
        end
        v14 = buffer.create(v9)
        v9 = 0
        for i10, i11 in v13 do
            if i11.type == "IDAT" then
                buffer.copy(v14, v9, v16, i11.offset, i11.length)
                v9 = v9 + i11.length
            end
        end
        local width = v8.width
        local height = v8.height
        local bitDepth = v8.bitDepth
        local colorType = v8.colorType
        local u385 = u16[colorType]
        v3 = 0
        if v8.interlaced then
            local v17
            for i12 = 1, 7 do
                v7 = math.ceil((width - u31[i12]) / u47[i12])
                v17 = math.ceil((height - u23[i12]) / u39[i12])
                if v7 > 0 and v17 > 0 then
                    v3 = v3 + v17 * (math.ceil(v7 * u385 * bitDepth / 8) + 1)
                end
            end
        else
            v3 = height * (math.ceil(width * u385 * bitDepth / 8) + 1)
        end
        local colors = nil
        if v10 then
            colors = v10.colors
        end
        local u404 = nil
        if colorType ~= 3 and bitDepth < 8 then
            u404 = 255 / (2 ^ bitDepth - 1)
        end
        local u413 = math.ceil(u385 * bitDepth / 8)
        local u416 = 2 ^ bitDepth - 1
        local u417 = 0
        local u423 = buffer.create(v3)
        assert(zlib.inflate(v14, u423) == v3, "decompressed data size mismatch")
        local u452 = buffer.create(width * height * 4)
        local gray = if not v11 then -1 else v11.gray
        local red = if not v11 then -1 else v11.red
        local green = if not v11 then -1 else v11.green
        local blue = if not v11 then -1 else v11.blue

        local function pass(a1, a2, a3, a4) -- Line: 190
            -- upvalues: width (val), height (val), u385 (val), bitDepth (val), u417 (ref), u423 (val), u413 (val)
            -- upvalues: colorType (val), gray (val), u416 (val), red (val), green (val), blue (val), colors (ref)
            -- upvalues: u404 (ref), u452 (val)
            local v1 = math.ceil((width - a1) / a3)
            local v2 = math.ceil((height - a2) / a4)
            if not (v1 < 1) and not (v2 < 1) then
                local a, b, g, r, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17
                local v18 = math.ceil(v1 * u385 * bitDepth / 8)
                local u573 = u417
                for i = 1, v2 do
                    v4 = u417
                    v3 = buffer.readu8(u423, v4)
                    u417 = u417 + 1
                    if v3 == 0 then
                        u417 = u417 + v18
                    elseif v3 ~= 2 then
                        if v3 == 1 then
                            for m = 1, v18 do
                                if not (m <= u413) then
                                    v6 = u423
                                    v7 = u417 - u413
                                    v5 = buffer.readu8(v6, v7)
                                else
                                    v5 = 0
                                end
                                v10 = u417
                                v6 = bit32.band(buffer.readu8(u423, v10) + v5, 255)
                                v9 = u417
                                buffer.writeu8(u423, v9, v6)
                                u417 = u417 + 1
                            end
                        elseif v3 == 2 then
                            for n = 1, v18 do
                                v6 = u423
                                v7 = u417 - v18 - 1
                                v5 = buffer.readu8(v6, v7)
                                v10 = u417
                                v6 = bit32.band(buffer.readu8(u423, v10) + v5, 255)
                                v9 = u417
                                buffer.writeu8(u423, v9, v6)
                                u417 = u417 + 1
                            end
                        elseif v3 == 3 then
                            for k = 1, v18 do
                                if not (k <= u413) then
                                    v6 = u423
                                    v7 = u417 - u413
                                    v5 = buffer.readu8(v6, v7)
                                else
                                    v5 = 0
                                end
                                if i ~= 1 then
                                    v7 = u423
                                    v8 = u417 - v18 - 1
                                    v6 = buffer.readu8(v7, v8)
                                else
                                    v6 = 0
                                end
                                v11 = u417
                                v7 = bit32.band((buffer.readu8(u423, v11)) + bit32.rshift(v5 + v6, 1), 255)
                                v10 = u417
                                buffer.writeu8(u423, v10, v7)
                                u417 = u417 + 1
                            end
                        elseif v3 ~= 4 then
                            error("invalid row filter")
                        else
                            for j = 1, v18 do
                                if not (j <= u413) then
                                    v6 = u423
                                    v7 = u417 - u413
                                    v5 = buffer.readu8(v6, v7)
                                else
                                    v5 = 0
                                end
                                if i ~= 1 then
                                    v7 = u423
                                    v8 = u417 - v18 - 1
                                    v6 = buffer.readu8(v7, v8)
                                else
                                    v6 = 0
                                end
                                if j <= u413 then
                                    v7 = 0
                                elseif i ~= 1 then
                                    v8 = u423
                                    v9 = u417 - v18 - u413 - 1
                                    v7 = buffer.readu8(v8, v9)
                                else
                                    v7 = 0
                                end
                                v8 = math.abs(v6 - v7)
                                v9 = math.abs(v5 - v7)
                                v10 = math.abs(v5 + v6 - v7 * 2)
                                v11 = if not (v8 <= v9) then if not (v9 <= v10) then v7 else v6 else if not (v8 <= v10) then if not (v9 <= v10) then v7 else v6 else v5
                                v16 = u417
                                v12 = bit32.band(buffer.readu8(u423, v16) + v11, 255)
                                v14 = u417
                                buffer.writeu8(u423, v14, v12)
                                u417 = u417 + 1
                            end
                        end
                    elseif i == 1 then
                        u417 = u417 + v18
                    elseif v3 == 1 then
                        for i8 = 1, v18 do
                            if not (i8 <= u413) then
                                v6 = u423
                                v7 = u417 - u413
                                v5 = buffer.readu8(v6, v7)
                            else
                                v5 = 0
                            end
                            v10 = u417
                            v6 = bit32.band(buffer.readu8(u423, v10) + v5, 255)
                            v9 = u417
                            buffer.writeu8(u423, v9, v6)
                            u417 = u417 + 1
                        end
                    elseif v3 == 2 then
                        for i7 = 1, v18 do
                            v6 = u423
                            v7 = u417 - v18 - 1
                            v5 = buffer.readu8(v6, v7)
                            v10 = u417
                            v6 = bit32.band(buffer.readu8(u423, v10) + v5, 255)
                            v9 = u417
                            buffer.writeu8(u423, v9, v6)
                            u417 = u417 + 1
                        end
                    elseif v3 == 3 then
                        for i6 = 1, v18 do
                            if not (i6 <= u413) then
                                v6 = u423
                                v7 = u417 - u413
                                v5 = buffer.readu8(v6, v7)
                            else
                                v5 = 0
                            end
                            if i ~= 1 then
                                v7 = u423
                                v8 = u417 - v18 - 1
                                v6 = buffer.readu8(v7, v8)
                            else
                                v6 = 0
                            end
                            v11 = u417
                            v7 = bit32.band((buffer.readu8(u423, v11)) + bit32.rshift(v5 + v6, 1), 255)
                            v10 = u417
                            buffer.writeu8(u423, v10, v7)
                            u417 = u417 + 1
                        end
                    elseif v3 ~= 4 then
                        error("invalid row filter")
                    else
                        for i5 = 1, v18 do
                            if not (i5 <= u413) then
                                v6 = u423
                                v7 = u417 - u413
                                v5 = buffer.readu8(v6, v7)
                            else
                                v5 = 0
                            end
                            if i ~= 1 then
                                v7 = u423
                                v8 = u417 - v18 - 1
                                v6 = buffer.readu8(v7, v8)
                            else
                                v6 = 0
                            end
                            if i5 <= u413 then
                                v7 = 0
                            elseif i ~= 1 then
                                v8 = u423
                                v9 = u417 - v18 - u413 - 1
                                v7 = buffer.readu8(v8, v9)
                            else
                                v7 = 0
                            end
                            v8 = math.abs(v6 - v7)
                            v9 = math.abs(v5 - v7)
                            v10 = math.abs(v5 + v6 - v7 * 2)
                            v11 = if not (v8 <= v9) then if not (v9 <= v10) then v7 else v6 else if not (v8 <= v10) then if not (v9 <= v10) then v7 else v6 else v5
                            v16 = u417
                            v12 = bit32.band(buffer.readu8(u423, v16) + v11, 255)
                            v14 = u417
                            buffer.writeu8(u423, v14, v12)
                            u417 = u417 + 1
                        end
                    end
                end
                local u558 = 8

                local function readValue() -- Line: 249
                    -- upvalues: u423 (upval), u573 (ref), bitDepth (upval), u558 (ref)
                    local v1 = u573
                    local v2 = buffer.readu8(u423, v1)
                    if bitDepth < 8 then
                        v2 = bit32.extract(v2, u558 - bitDepth, bitDepth)
                        u558 = u558 - bitDepth
                        if u558 ~= 0 then
                            return v2
                        end
                        u558 = 8
                        u573 = u573 + 1
                        return v2
                    end
                    if bitDepth == 8 then
                        u573 = u573 + 1
                        return v2
                    end
                    v1 = bit32.lshift(v2, 8)
                    local v3 = u423
                    local v4 = u573 + 1
                    v2 = bit32.bor(v1, (buffer.readu8(v3, v4)))
                    u573 = u573 + 2
                    return v2
                end

                for i9 = 1, v2 do
                    u573 = u573 + 1
                    if u558 < 8 then
                        u558 = 8
                        u573 = u573 + 1
                    end
                    for i10 = 1, v1 do
                        r = nil
                        g = nil
                        b = nil
                        a = nil
                        if colorType == 0 then
                            v11 = u573
                            v9 = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                v9 = bit32.extract(v9, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v11 = bit32.lshift(v9, 8)
                                v13 = u423
                                v14 = u573 + 1
                                v9 = bit32.bor(v11, (buffer.readu8(v13, v14)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            r = v9
                            g = v9
                            b = v9
                            a = if v9 ~= gray then u416 else 0
                        elseif colorType == 2 then
                            v11 = u573
                            r = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                r = bit32.extract(r, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v10 = bit32.lshift(r, 8)
                                v12 = u423
                                v13 = u573 + 1
                                r = bit32.bor(v10, (buffer.readu8(v12, v13)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            v11 = u573
                            g = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                g = bit32.extract(g, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v10 = bit32.lshift(g, 8)
                                v12 = u423
                                v13 = u573 + 1
                                g = bit32.bor(v10, (buffer.readu8(v12, v13)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            v11 = u573
                            b = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                b = bit32.extract(b, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v10 = bit32.lshift(b, 8)
                                v12 = u423
                                v13 = u573 + 1
                                b = bit32.bor(v10, (buffer.readu8(v12, v13)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            a = if r ~= red then u416 else if g ~= green then u416 else if b ~= blue then u416 else 0
                        elseif colorType == 3 then
                            v10 = colors
                            v14 = u573
                            v12 = buffer.readu8(u423, v14)
                            if bitDepth < 8 then
                                v12 = bit32.extract(v12, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v14 = bit32.lshift(v12, 8)
                                v16 = u423
                                v17 = u573 + 1
                                v12 = bit32.bor(v14, (buffer.readu8(v16, v17)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            v9 = v10[v12 + 1]
                            r = v9.r
                            g = v9.g
                            b = v9.b
                            a = v9.a
                        elseif colorType == 4 then
                            v11 = u573
                            v9 = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                v9 = bit32.extract(v9, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v11 = bit32.lshift(v9, 8)
                                v13 = u423
                                v14 = u573 + 1
                                v9 = bit32.bor(v11, (buffer.readu8(v13, v14)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            r = v9
                            g = v9
                            b = v9
                            v12 = u573
                            a = buffer.readu8(u423, v12)
                            if bitDepth < 8 then
                                a = bit32.extract(a, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v11 = bit32.lshift(a, 8)
                                v13 = u423
                                v14 = u573 + 1
                                a = bit32.bor(v11, (buffer.readu8(v13, v14)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                        elseif colorType == 6 then
                            v11 = u573
                            r = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                r = bit32.extract(r, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v10 = bit32.lshift(r, 8)
                                v12 = u423
                                v13 = u573 + 1
                                r = bit32.bor(v10, (buffer.readu8(v12, v13)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            v11 = u573
                            g = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                g = bit32.extract(g, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v10 = bit32.lshift(g, 8)
                                v12 = u423
                                v13 = u573 + 1
                                g = bit32.bor(v10, (buffer.readu8(v12, v13)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            v11 = u573
                            b = buffer.readu8(u423, v11)
                            if bitDepth < 8 then
                                b = bit32.extract(b, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v10 = bit32.lshift(b, 8)
                                v12 = u423
                                v13 = u573 + 1
                                b = bit32.bor(v10, (buffer.readu8(v12, v13)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                            v10 = u573
                            a = buffer.readu8(u423, v10)
                            if bitDepth < 8 then
                                a = bit32.extract(a, u558 - bitDepth, bitDepth)
                                u558 = u558 - bitDepth
                                if u558 == 0 then
                                    u558 = 8
                                    u573 = u573 + 1
                                end
                            elseif bitDepth ~= 8 then
                                v10 = bit32.lshift(a, 8)
                                v12 = u423
                                v13 = u573 + 1
                                a = bit32.bor(v10, (buffer.readu8(v12, v13)))
                                u573 = u573 + 2
                            else
                                u573 = u573 + 1
                            end
                        end
                        v9 = a2 + (i9 - 1) * a4
                        v10 = a1 + (i10 - 1) * a3
                        v11 = (v9 * width + v10) * 4
                        if u404 then
                            r = math.round(r * u404)
                            g = math.round(g * u404)
                            b = math.round(b * u404)
                            a = math.round(a * u404)
                        elseif bitDepth == 16 then
                            r = bit32.rshift(r, 8)
                            g = bit32.rshift(g, 8)
                            b = bit32.rshift(b, 8)
                            a = bit32.rshift(a, 8)
                        end
                        v13 = u452
                        v15 = bit32.bor(bit32.lshift(a, 24), bit32.lshift(b, 16), bit32.lshift(g, 8), r)
                        buffer.writeu32(v13, v11, v15)
                    end
                end
                return
            end
        end

        if v8.interlaced then
            for i13 = 1, 7 do
                pass(u31[i13], u23[i13], u47[i13], u39[i13])
            end
        else
            pass(0, 0, 1, 1)
        end
        return {
            width = width,
            height = height,
            pixels = u452,
            readPixel = function(a1, a2) -- Line: 336 -- upvalues: width (val), height (val), u452 (val) -- types: a1: number, a2: number
                local v1 = false
                if a1 >= 1 then
                    v1 = false
                    if a1 <= width then
                        v1 = false
                        if a2 >= 1 then
                            v1 = a2 <= height
                        end
                    end
                end
                assert(v1, "pixel out of range")
                local v2 = ((a2 - 1) * width + a1 - 1) * 4
                v1 = buffer.readu8(u452, v2)
                local v3 = u452
                local v4 = v2 + 1
                local v5 = buffer.readu8(v3, v4)
                v4 = u452
                local v6 = v2 + 2
                v3 = buffer.readu8(v4, v6)
                v6 = u452
                local v7 = v2 + 3
                return v1, v5, v3, (buffer.readu8(v6, v7))
            end,
        }
    end,
    encode = function(a1, a2) -- Line: 354 -- upvalues: zlib (val), crc32 (val) -- types: a1: buffer, a2: table
        local v1, v2, v3
        local width = a2.width
        local height = a2.height
        local v4 = buffer.len(a1)
        local v5 = width * height * 4
        local v6 = ("expected %* bytes, got %* bytes"):format(v5, v4)
        assert(v4 == v5, v6)
        v5 = width * 4 + 1
        v4 = buffer.create(height * v5)
        local v7 = height - 1
        for i = 0, v7 do
            v3 = i * width * 4
            v1 = i * v5
            buffer.writeu8(v4, v1, 0)
            buffer.copy(v4, v1 + 1, a1, v3, width * 4)
        end
        v7, v2 = zlib.deflate(v4)
        v5 = 33 + (8 + v2 + 4) + 12
        v4 = buffer.create(v5)
        buffer.writestring(v4, 0, "‰PNG\r\n\026\n")
        local v8 = bit32.byteswap(13)
        buffer.writeu32(v4, 8, v8)
        buffer.writestring(v4, 12, "IHDR")
        v8 = bit32.byteswap(width)
        buffer.writeu32(v4, 16, v8)
        v8 = bit32.byteswap(height)
        buffer.writeu32(v4, 20, v8)
        buffer.writeu8(v4, 24, 8)
        buffer.writeu8(v4, 25, 6)
        buffer.writeu8(v4, 26, 0)
        buffer.writeu8(v4, 27, 0)
        buffer.writeu8(v4, 28, 0)
        v8 = bit32.byteswap((crc32(v4, 12, 28)))
        buffer.writeu32(v4, 29, v8)
        v8 = bit32.byteswap(v2)
        buffer.writeu32(v4, 33, v8)
        buffer.writestring(v4, 37, "IDAT")
        buffer.copy(v4, 41, v7, 0, v2)
        v7 = 41 + v2
        v8 = bit32.byteswap((crc32(v4, 37, v7 - 1)))
        buffer.writeu32(v4, v7, v8)
        v1 = v7 + 4
        buffer.writeu32(v4, v1, 0)
        buffer.writestring(v4, v7 + 8, "IEND")
        v1 = v7 + 12
        buffer.writeu32(v4, v1, 2187346606)
        return v4
    end,
}