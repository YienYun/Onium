-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepCopyPure
-- Decompile time: 0.54 ms

function DeepCopyPure(a1, a2) -- Line: 31 -- types: a2: table?
    local v1
    if type(a1) ~= "table" then
        return a1
    end
    assert(not (getmetatable(a1)))
    local v2 = a2 or {}
    assert(not v2[a1])
    v2[a1] = true
    local v3 = {}
    for k, v in next, a1 do
        v1 = DeepCopyPure(k, v2)
        v3[v1] = (DeepCopyPure(v, v2))
    end
    v2[a1] = nil
    return v3
end

return DeepCopyPure