-- Script path: ReplicatedStorage.Shared.Types.Rift
-- Decompile time: 1.76 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.interface({Uid = t.string, Egg = Eggs.SchemaValidation.SerializedSavedEgg})
local v2 = t.map(t.string, t.number)
local u26 = {}
u26.Requirements = {
    check = t.array(t.string),
    blank = function() -- Line: 40
        return {}
    end,
}
u26.RequirementsBannerId = {
    check = t.string,
    blank = function() -- Line: 46
        return ""
    end,
}
u26.Pity = {
    check = v2,
    blank = function() -- Line: 52
        return {}
    end,
}
u26.FreeRefreshDayKey = {
    check = t.string,
    blank = function() -- Line: 58
        return ""
    end,
}
u26.FreeRefreshesUsed = {
    check = t.number,
    blank = function() -- Line: 64
        return 0
    end,
}
u26.TradeInsByBanner = {
    check = v2,
    blank = function() -- Line: 70
        return {}
    end,
}
u26.PendingReward = {
    check = t.union(t.literal(false), v1),
    blank = function() -- Line: 76
        return false
    end,
}
u26.PaidRefreshDayKey = {
    check = t.optional(t.string),
    blank = function() -- Line: 83
        return ""
    end,
}
u26.PaidRefreshesUsed = {
    check = t.optional(t.number),
    blank = function() -- Line: 89
        return 0
    end,
}
v2 = {}
for i, j in u26 do
    v2[i] = j.check
end
return {
    PendingReward = v1,
    State = t.interface(v2),
    Blank = function() -- Line: 107 -- upvalues: u26 (val)
        local v1 = {}
        for i, j in u26 do
            v1[i] = (j.blank())
        end
        return v1
    end,
}