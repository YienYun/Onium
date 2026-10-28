-- Script path: ReplicatedStorage.Shared.Utils.DeepCopy
-- Decompile time: 1.68 ms

local function replicate(a1) -- Line: 7 -- types: a1: table
    local v1, v2, v3, v4, v5, v6, v7, v8
    local u78 = {}
    local u80 = {}

    local function shadow(a1) -- Line: 11 -- upvalues: u78 (val), u80 (val)
        if type(a1) ~= "table" then
            return a1
        end
        local v1 = u78[a1]
        if v1 == nil then
            u78[a1] = {}
            table.insert(u80, a1)
        end
        return v1
    end

    if type(a1) == "table" then
        v5 = u78[a1]
        if v5 == nil then
            u78[a1] = {}
            table.insert(u80, a1)
        end
        v4 = v5
    else
        v4 = a1
    end
    while #u80 > 0 do
        v5 = table.remove(u80)
        v6 = u78[v5]
        v7 = nil
        v8 = nil
        for i, j in v5, v7, v8 do
            if type(i) == "table" then
                v2 = u78[i]
                if v2 == nil then
                    u78[i] = {}
                    table.insert(u80, i)
                end
                v1 = v2
            else
                v1 = i
            end
            if type(j) == "table" then
                v3 = u78[j]
                if v3 == nil then
                    u78[j] = {}
                    table.insert(u80, j)
                end
                v2 = v3
            else
                v2 = j
            end
            v6[v1] = v2
        end
    end
    return v4
end

return function(a1) -- Line: 35 -- upvalues: replicate (val)
    if type(a1) ~= "table" then
        return a1
    end
    return (replicate(a1))
end