-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe
-- Decompile time: 0.34 ms

function DeepFreezeUnsafe(a1) -- Line: 31
    if type(a1) ~= "table" then
        return a1
    end
    if not table.isfrozen(a1) then
        table.freeze(a1)
    end
    for k, v in next, a1 do
        DeepFreezeUnsafe(k)
        DeepFreezeUnsafe(v)
    end
    return a1
end

return DeepFreezeUnsafe