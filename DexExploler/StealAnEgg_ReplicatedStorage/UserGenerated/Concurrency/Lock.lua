-- Script path: ReplicatedStorage.UserGenerated.Concurrency.Lock
-- Decompile time: 1.07 ms

local Finally = require(game.ReplicatedStorage.UserGenerated.Lang.Finally)
local v1 = {
    Call = function(a1, a2, ...) -- Line: 40 -- upvalues: Finally (val)
        assert(type(a2) == "function")
        while 0 < a1.Count do
            task.wait()
        end
        a1.Count = a1.Count + 1
        return Finally(a2, function() -- Line: 47 -- upvalues: a1 (val)
            local v1 = a1
            v1.Count = v1.Count - 1
        end, ...)
    end,
    Try = function(a1, a2, ...) -- Line: 52 -- upvalues: Finally (val)
        assert(type(a2) == "function")
        if 0 < a1.Count then
            return false
        end
        a1.Count = a1.Count + 1
        return true, Finally(a2, function() -- Line: 59 -- upvalues: a1 (val)
            local v1 = a1
            v1.Count = v1.Count - 1
        end, ...)
    end,
    IsLocked = function(a1) -- Line: 64
        return 0 < a1.Count
    end,
}
local v2 = {}
local u17 = table.freeze({__index = table.freeze(v1)})

function v2.new() -- Line: 73 -- upvalues: u17 (val)
    return (setmetatable({Count = 0}, u17))
end

return table.freeze(v2)