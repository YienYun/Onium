-- Script path: ReplicatedStorage.UserGenerated.IO.BufferToHex
-- Decompile time: 1.13 ms

function BufferToHex(a1) -- Line: 20 -- types: a1: buffer
    local v1, v2, v3, v4, v5
    local v6 = buffer.len(a1)
    local v7 = buffer.create(v6 * 2)
    local v8 = v6 - 1
    for i = 0, v8 do
        v3 = buffer.readu8(a1, i)
        v4 = bit32.rshift(v3, 4)
        v5 = bit32.band(v3, 15)
        v1 = i * 2 + 0
        v2 = if not (v4 < 10) then v4 + 87 else v4 + 48
        buffer.writeu8(v7, v1, v2)
        v1 = i * 2 + 1
        v2 = if not (v5 < 10) then v5 + 87 else v5 + 48
        buffer.writeu8(v7, v1, v2)
    end
    return buffer.tostring(v7)
end

return BufferToHex