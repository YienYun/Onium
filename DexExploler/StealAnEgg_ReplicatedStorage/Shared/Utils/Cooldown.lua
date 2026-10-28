-- Script path: ReplicatedStorage.Shared.Utils.Cooldown
-- Decompile time: 0.54 ms

return function(a1) -- Line: 5 -- types: a1: number
    local v1 = false
    if a1 >= 0 then
        v1 = a1 == a1
    end
    assert(v1, "cooldown duration must be a non-negative number")
    local u9 = true
    return function(a1_2) -- Line: 9 -- upvalues: u9 (ref), a1 (val) -- types: a1_2: function?
        if not u9 then
            return false
        end
        u9 = false
        task.delay(a1, function() -- Line: 14 -- upvalues: u9 (upval)
            u9 = true
        end)
        if a1_2 then
            a1_2()
        end
        return true
    end
end