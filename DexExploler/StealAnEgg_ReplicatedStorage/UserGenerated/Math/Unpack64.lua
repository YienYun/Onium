-- Script path: ReplicatedStorage.UserGenerated.Math.Unpack64
-- Decompile time: 0.27 ms

return function(a1) -- Line: 20 -- types: a1: number
    if not (a1 < 0) then
        return (bit32.bor(a1 // 4294967296, 0)), (bit32.bor(a1, 0))
    end
    local v1 = -1 - a1
    return (bit32.bnot(v1 // 4294967296)), (bit32.bnot(v1))
end