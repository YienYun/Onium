-- Script path: ReplicatedStorage.UserGenerated.Collections.DeepEquals
-- Decompile time: 1.28 ms

local DeepEquals

function DeepEquals(a1, a2, a3) -- Line: 31 -- upvalues: DeepEquals (val) -- types: a3: table?
    if rawequal(a1, a2) then
        return true
    end
    if type(a1) == "table" and type(a2) == "table" then
        if (rawlen(a1)) ~= rawlen(a2) then
            return false
        end
        local v1 = getmetatable(a1)
        if v1 ~= getmetatable(a2) then
            return false
        end
        if v1 ~= nil and v1.__eq then
            return a1 == a2
        end
        local v2 = a3 or {}
        local v3 = v2[a1] or {}
        v2[a1] = v3
        v3 = v2[a2] or {}
        v2[a2] = v3
        if v2[a1][a2] then
            return true
        end
        v2[a1][a2] = true
        v2[a2][a1] = true
        for k, v in next, a1 do
            v1 = rawget(a2, k)
            if v1 ~= nil and DeepEquals(v, v1, v2) then
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

return DeepEquals