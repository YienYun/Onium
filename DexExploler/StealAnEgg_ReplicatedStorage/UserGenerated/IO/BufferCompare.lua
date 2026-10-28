-- Script path: ReplicatedStorage.UserGenerated.IO.BufferCompare
-- Decompile time: 0.42 ms

return function(a1, a2) -- Line: 20 -- types: a1: buffer, a2: buffer
    local v1, v2
    local v3 = buffer.len(a1)
    local v4 = buffer.len(a2)
    local v5 = math.min(v3, v4) - 1
    for i = 0, v5 do
        v1 = buffer.readu8(a1, i)
        v2 = buffer.readu8(a2, i)
        if v1 ~= v2 then
            return v1 - v2
        end
    end
    return v3 - v4
end