-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe
-- Decompile time: 0.38 ms

function DeepCopyPureUnsafe(a1) -- Line: 31
    local v1
    if type(a1) ~= "table" then
        return a1
    end
    local v2 = {}
    for k, v in next, a1 do
        v1 = DeepCopyPureUnsafe(k)
        v2[v1] = (DeepCopyPureUnsafe(v))
    end
    return v2
end

return DeepCopyPureUnsafe