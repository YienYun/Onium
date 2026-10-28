-- Script path: ReplicatedStorage.UserGenerated.IO.HexToBuffer
-- Decompile time: 1.58 ms

local u0 = {
    [48] = 0,
    [49] = 1,
    [50] = 2,
    [51] = 3,
    [52] = 4,
    [53] = 5,
    [54] = 6,
    [55] = 7,
    [56] = 8,
    [57] = 9,
    [65] = 10,
    [66] = 11,
    [67] = 12,
    [68] = 13,
    [69] = 14,
    [70] = 15,
    [97] = 10,
    [98] = 11,
    [99] = 12,
    [100] = 13,
    [101] = 14,
    [102] = 15,
}
return function(a1) -- Line: 45 -- upvalues: u0 (val) -- types: a1: string
    local v1, v2, v3, v4, v5
    local v6 = #a1
    assert(v6 % 2 == 0, "hex length must be even")
    local v7 = buffer.create(v6 // 2)
    local v8 = 0
    for i = 1, v6, 2 do
        v1 = i + 1
        v3, v4 = string.byte(a1, i, v1)
        v5 = u0[v3]
        if not v5 then
            error((("invalid hex at %*"):format(i)))
        end
        v3 = u0[v4]
        if not v3 then
            error((("invalid hex at %*"):format(i + 1)))
        end
        v2 = v5 * 16 + v3
        buffer.writeu8(v7, v8, v2)
        v8 = v8 + 1
    end
    return v7
end