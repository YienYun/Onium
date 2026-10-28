-- Script path: ReplicatedStorage.Shared.Utils.TryCall
-- Decompile time: 0.62 ms

local function onError(a1) -- Line: 3
    return debug.traceback(tostring(a1), 2)
end

return function(a1, ...) -- Line: 7 -- upvalues: onError (val) -- types: a1: function
    local pack = table.pack
    local success = xpcall(a1, onError, ...)
    local v1 = pack(success)
    if v1[1] then
        return true, table.unpack(v1, 2, v1.n)
    end
    warn("protected call failed: " .. tostring(v1[2]))
    return false, v1[2]
end