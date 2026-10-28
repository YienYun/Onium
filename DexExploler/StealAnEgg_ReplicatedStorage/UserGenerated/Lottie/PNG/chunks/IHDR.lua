-- Script path: ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.IHDR
-- Decompile time: 1.80 ms

require(script.Parent.Parent.Types)
local u6 = {
    [0] = {1, 2, 4, 8, 16},
    [2] = {8, 16},
    [3] = {1, 2, 4, 8},
    [4] = {8, 16},
    [6] = {8, 16},
}
return function(a1, a2) -- Line: 11 -- upvalues: u6 (val) -- types: a1: buffer
    assert(a2.length == 13, "IHDR data must be 13 bytes")
    local offset = a2.offset
    local v1 = bit32.byteswap((buffer.readu32(a1, offset)))
    local v2 = offset + 4
    local v3 = bit32.byteswap((buffer.readu32(a1, v2)))
    v2 = offset + 8
    local v4 = buffer.readu8(a1, v2)
    local v5 = offset + 9
    local v6 = buffer.readu8(a1, v5)
    local v7 = offset + 10
    v2 = buffer.readu8(a1, v7)
    local v8 = offset + 11
    v5 = buffer.readu8(a1, v8)
    local v9 = offset + 12
    v7 = buffer.readu8(a1, v9)
    v9 = false
    if v1 > 0 then
        v9 = false
        if v1 <= 2147483648 then
            v9 = false
            if v3 > 0 then
                v9 = v3 <= 2147483648
            end
        end
    end
    assert(v9, "invalid dimensions")
    assert(v2 == 0, "invalid compression method")
    assert(v5 == 0, "invalid filter method")
    v9 = true
    if v7 ~= 0 then
        v9 = v7 == 1
    end
    assert(v9, "invalid interlace method")
    v5 = u6[v6]
    assert(v5 ~= nil, "invalid color type")
    assert(table.find(v5, v4) ~= nil, "invalid bit depth")
    return {
        width = v1,
        height = v3,
        bitDepth = v4,
        colorType = v6,
        interlaced = v7 == 1,
    }
end