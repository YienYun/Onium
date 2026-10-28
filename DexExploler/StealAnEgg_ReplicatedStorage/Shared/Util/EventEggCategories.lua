-- Script path: ReplicatedStorage.Shared.Util.EventEggCategories
-- Decompile time: 0.70 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u13 = {
    require(ReplicatedStorage.Data.AdminAbuseEgg),
    (require(ReplicatedStorage.Data.DragonEgg)),
}
return table.freeze({
    IsEventEgg = function(a1) -- Line: 20 -- upvalues: u13 (val) -- types: a1: string?
        local v1
        local v2 = false
        local v3 = nil
        local v4 = nil
        local v5 = a1
        for i, j in u13, v3, v4 do
            v1 = v2
            if not v1 then
                v1 = false
                if v5 ~= nil then
                    v1 = j.IsEventCategory(v5)
                end
            end
            v2 = v1
        end
        return v2
    end,
})