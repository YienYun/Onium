-- Script path: ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.tRNS
-- Decompile time: 2.88 ms

require(script.Parent.Parent.Types)

local function readU16(a1, a2, a3) -- Line: 3 -- types: a1: buffer, a2: number, a3: number
    return (bit32.extract(bit32.bor(bit32.lshift(buffer.readu8(a1, a2), 8), (buffer.readu8(a1, a2 + 1))), 0, a3))
end

return function(a1, a2, a3, a4) -- Line: 11 -- types: a1: buffer
    local v1, v2
    local v3 = -1
    local v4 = -1
    local v5 = -1
    local v6 = -1
    if a3.colorType == 0 then
        assert(a2.length == 2, "invalid tRNS length for color type")
        local offset_2 = a2.offset
        local bitDepth = a3.bitDepth
        v1 = bit32.lshift(buffer.readu8(a1, offset_2), 8)
        v2 = offset_2 + 1
        v3 = bit32.extract(bit32.bor(v1, (buffer.readu8(a1, v2))), 0, bitDepth)
    elseif a3.colorType ~= 2 then
        local length = a2.length
        assert(a4, "tRNS requires PLTE for color type")
        assert(length <= #a4.colors, "tRNS specified too many PLTE alphas")
        for i = 1, length do
            v1 = a4.colors[i]
            v2 = a2.offset + i - 1
            v1.a = buffer.readu8(a1, v2)
        end
    else
        assert(a2.length == 6, "invalid tRNS length for color type")
        local offset_3 = a2.offset
        local bitDepth_2 = a3.bitDepth
        v1 = bit32.lshift(buffer.readu8(a1, offset_3), 8)
        v2 = offset_3 + 1
        v4 = bit32.extract(bit32.bor(v1, (buffer.readu8(a1, v2))), 0, bitDepth_2)
        local v7 = a2.offset + 2
        local bitDepth_3 = a3.bitDepth
        v1 = bit32.lshift(buffer.readu8(a1, v7), 8)
        v2 = v7 + 1
        v5 = bit32.extract(bit32.bor(v1, (buffer.readu8(a1, v2))), 0, bitDepth_3)
        v7 = a2.offset + 4
        local bitDepth_4 = a3.bitDepth
        v1 = bit32.lshift(buffer.readu8(a1, v7), 8)
        v2 = v7 + 1
        v6 = bit32.extract(bit32.bor(v1, (buffer.readu8(a1, v2))), 0, bitDepth_4)
    end
    return {gray = v3, red = v4, green = v5, blue = v6}
end