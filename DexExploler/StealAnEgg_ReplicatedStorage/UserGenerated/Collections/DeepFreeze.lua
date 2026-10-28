-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepFreeze
-- Decompile time: 0.49 ms

function DeepFreeze(a1, a2) -- Line: 32 -- types: a2: table?
    if type(a1) ~= "table" then
        return a1
    end
    if not table.isfrozen(a1) then
        table.freeze(a1)
    end
    local v1 = a2 or {}
    if not v1[a1] then
        v1[a1] = true
        for k, v in next, a1 do
            DeepFreeze(k, v1)
            DeepFreeze(v, v1)
        end
        v1[a1] = nil
    end
    return a1
end

return DeepFreeze