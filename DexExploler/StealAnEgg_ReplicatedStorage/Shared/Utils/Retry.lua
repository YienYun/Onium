-- Script path: ReplicatedStorage.Shared.Utils.Retry
-- Decompile time: 1.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Packages.Promise)
return function(a1, a2, a3, a4) -- Line: 8
    -- upvalues: Promise (val)
    local u4 = a2 or 5
    local v1 = false
    if u4 >= 1 then
        v1 = u4 % 1 == 0
    end
    assert(v1, "retry attempts must be a positive integer")
    assert(a3 == nil == (a4 == nil), "retry delay range needs both minimum and maximum")
    if a3 and a4 then
        v1 = false
        if a3 >= 0 then
            v1 = a3 <= a4
        end
        assert(v1, "invalid retry delay range")
    end
    return Promise.new(function(a1_2, a2) -- Line: 24 -- upvalues: u4 (val), a3 (val), a4 (val), a1 (val)
        local pack, success, v1
        local v2 = Random.new()
        local v3 = nil
        for i = 1, u4 do
            if i > 1 then
                v1 = 2 ^ (i - 2)
                task.wait(if not a3 or not a4 then v1 else v2:NextNumber(a3 * v1, a4 * v1))
            end
            pack = table.pack
            success = pcall(a1)
            v1 = pack(success)
            if v1[1] then
                a1_2(table.unpack(v1, 2, v1.n))
                return
            end
            v3 = v1[2]
        end
        a2((("gave up after %* attempts; last failure: %*"):format(u4, v3)))
    end)
end