-- Script path: ReplicatedStorage.UserGenerated.Lottie.PNG.chunks.PLTE
-- Decompile time: 0.89 ms

require(script.Parent.Parent.Types)
return function(a1, a2, a3) -- Line: 3 -- types: a1: buffer
    local v1, v2
    assert(a2.length % 3 == 0, "malformed PLTE chunk")
    local v3 = a2.length / 3
    assert(v3 > 0, "no entries in PLTE")
    assert(v3 <= 256, "too many entries in PLTE")
    assert(v3 <= 2 ^ a3.bitDepth, "too many entries in PLTE for bit depth")
    local v4 = table.create(v3)
    local offset = a2.offset
    for i = 1, v3 do
        v2 = {a = 255, r = buffer.readu8(a1, offset)}
        v1 = offset + 1
        v2.g = buffer.readu8(a1, v1)
        v1 = offset + 2
        v2.b = buffer.readu8(a1, v1)
        v4[i] = v2
        offset = offset + 3
    end
    return {colors = v4}
end