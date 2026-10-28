-- Script path: ReplicatedStorage.Shared.Utils.Diff
-- Decompile time: 1.71 ms

local deepEquals

function deepEquals(a1, a2) -- Line: 8 -- upvalues: deepEquals (val)
    if a1 == a2 then
        return true
    end
    if a1 ~= a1 and a2 ~= a2 then
        return true
    end
    if type(a1) == "table" and type(a2) == "table" then
        for k, v in pairs(a1) do
            if not deepEquals(v, a2[k]) then
                return false
            end
        end
        for k2 in pairs(a2) do
            if a1[k2] == nil then
                return false
            end
        end
        return true
    end
    return false
end

return function(a1, a2, a3) -- Line: 27 -- upvalues: deepEquals (val) -- types: a1: table, a2: table, a3: table?
    if type(a1) == "table" and type(a2) == "table" then
        local v1
        local SkipKeys = if not a3 then nil else a3.SkipKeys
        local v2 = {}
        local v3 = nil
        local v4 = nil
        local v5, v6 = a1, a2
        for i, j in a2, v3, v4 do
            if not SkipKeys or not SkipKeys[i] then
                v1 = v5[i]
                if v1 ~= j
                    and (if (typeof(j)) == typeof(v1) then if type(j) ~= "table" then true else not deepEquals(j, v1) else true) then
                    v2[i] = j
                end
            end
        end
        local v7 = {}
        v4 = nil
        local v8 = nil
        for k in v5, v4, v8 do
            if not SkipKeys then
                if v6[k] == nil then
                    v7[k] = true
                end
            elseif not SkipKeys[k] and v6[k] == nil then
                v7[k] = true
            end
        end
        return v2, v7
    end
    return {}, {}
end