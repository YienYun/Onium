-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe
-- Decompile time: 0.83 ms

function DeepEqualsPureUnsafe(a1, a2) -- Line: 33
    if rawequal(a1, a2) then
        return true
    end
    if type(a1) == "table" and type(a2) == "table" then
        local v1
        if (rawlen(a1)) ~= rawlen(a2) or (getmetatable(a1)) ~= getmetatable(a2) then
            return false
        end
        for k, v in next, a1 do
            v1 = rawget(a2, k)
            if v1 ~= nil and DeepEqualsPureUnsafe(v, v1) then
                continue
            end
            return false
        end
        for k2, i in next, a2 do
            if rawget(a1, k2) == nil then
                return false
            end
        end
        return true
    end
    if a1 ~= a1 and a2 ~= a2 then
        return true
    end
    return false
end

return DeepEqualsPureUnsafe