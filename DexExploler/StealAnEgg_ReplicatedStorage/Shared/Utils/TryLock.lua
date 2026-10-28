-- Script path: ReplicatedStorage.Shared.Utils.TryLock
-- Decompile time: 1.46 ms

local u3 = setmetatable({}, {__mode = "k"})

local function isEngaged(a1, a2) -- Line: 11 -- upvalues: u3 (val) -- types: a1: table, a2: number?
    local v1 = u3[a1]
    if v1 == nil then
        return false
    end
    local v2 = true
    if a2 ~= nil then
        v2 = os.clock() - v1.Since < a2
    end
    return v2
end

local function conclude(a1, a2, a3, ...) -- Line: 19 -- upvalues: u3 (val) -- types: a1: table, a2: table, a3: boolean
    if u3[a1] == a2 then
        u3[a1] = nil
    end
    if a3 then
        return true, ...
    end
    error(..., 0)
end

return function(a1) -- Line: 29 -- upvalues: u3 (val), conclude (val) -- types: a1: number?
    local u1 = {}
    return function(a1_2, ...) -- Line: 31 -- upvalues: u1 (val), a1 (val), u3 (upval), conclude (upval)
        local v1
        local v2 = a1
        local v3 = u3[u1]
        if v3 ~= nil then
            v1 = true
            if v2 ~= nil then
                v1 = os.clock() - v3.Since < v2
            end
        else
            v1 = false
        end
        if v1 then
            return false
        end
        v1 = {Since = os.clock()}
        u3[u1] = v1
        local v4 = conclude
        v2 = u1
        local success = pcall(a1_2, ...)
        return v4(v2, v1, success)
    end
end