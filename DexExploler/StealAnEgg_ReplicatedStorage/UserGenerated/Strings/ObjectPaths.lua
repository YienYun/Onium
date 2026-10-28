-- Script path: ReplicatedStorage.UserGenerated.Strings.ObjectPaths
-- Decompile time: 0.92 ms

return table.freeze({
    QueryObject = function(a1, a2, a3) -- Line: 29 -- types: a2: string
        local v1 = a1
        for i, v in ipairs(string.split(a2, ".")) do
            if v1 == nil then
                return false
            end
            if v1 == a3 then
                return true
            end
            if type(v1) ~= "table" then
                return false
            end
            v1 = v1[v]
        end
        if v1 == nil then
            return false
        end
        if v1 == a3 then
            return true
        end
        return true, v1
    end,
    HasHierarchicalOverlap = function(a1, a2) -- Line: 57 -- types: a1: string, a2: string
        if a1 == a2 then
            return true
        end
        local v1 = string.split(a1, ".")
        local v2 = string.split(a2, ".")
        for i = 1, (math.min(#v1, #v2)) do
            if v1[i] ~= v2[i] then
                return false
            end
        end
        return true
    end,
})