-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepEqualsPure
-- Decompile time: 1.01 ms

function DeepEqualsPure(a1, a2, a3) -- Line: 33 -- types: a3: table?
    if type(a1) == "table" and type(a2) == "table" then
        local v1 = a3 or {}
        if not v1[a1] and not v1[a2] then
            local v2
            if rawequal(a1, a2) then
                return true
            end
            if (rawlen(a1)) ~= rawlen(a2) or (getmetatable(a1)) ~= getmetatable(a2) then
                return false
            end
            v1[a1] = true
            v1[a2] = true
            for k, v in next, a1 do
                v2 = rawget(a2, k)
                if v2 ~= nil and DeepEqualsPure(v, v2, v1) then
                    continue
                end
                return false
            end
            for k2, i in next, a2 do
                if rawget(a1, k2) == nil then
                    return false
                end
            end
            v1[a1] = nil
            v1[a2] = nil
            return true
        end
        return false
    end
    if rawequal(a1, a2) then
        return true
    end
    if a1 ~= a1 and a2 ~= a2 then
        return true
    end
    return false
end

return DeepEqualsPure