-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepCopy
-- Decompile time: 0.62 ms

function DeepCopyWithMetatables(a1, a2) -- Line: 33 -- types: a2: table?
    local v1
    if type(a1) ~= "table" then
        return a1
    end
    local v2 = a2 or {}
    local v3 = v2[a1]
    if v3 then
        return v3
    end
    v3 = {}
    v2[a1] = v3
    for k, v in next, a1 do
        v1 = DeepCopyWithMetatables(k, v2)
        v3[v1] = (DeepCopyWithMetatables(v, v2))
    end
    v2 = getmetatable(a1)
    if v2 then
        setmetatable(v3, v2)
    end
    return v3
end

return DeepCopyWithMetatables