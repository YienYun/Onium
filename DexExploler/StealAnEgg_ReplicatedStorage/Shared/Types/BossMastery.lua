-- Script path: ReplicatedStorage.Shared.Types.BossMastery
-- Decompile time: 2.50 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u14 = t.interface({BannerId = t.string, AssetId = t.string})
local u15 = {}
u15.Mastery = {
    check = t.number,
    blank = function() -- Line: 38
        return 0
    end,
}
u15.ClaimedMilestoneIds = {
    check = t.map(t.string, t.boolean),
    blank = function() -- Line: 44
        return {}
    end,
}
u15.ClaimedTokenBoostPercents = {
    check = t.map(t.string, t.number),
    blank = function() -- Line: 50
        return {}
    end,
}
u15.InfiniteRewardsClaimed = {
    check = t.number,
    blank = function() -- Line: 56
        return 0
    end,
}
u15.HasUsedMutationConsumable = {
    check = t.boolean,
    blank = function() -- Line: 62
        return false
    end,
}
u15.MutationConsumables = {
    check = t.number,
    blank = function() -- Line: 68
        return 0
    end,
}
u15.EggGrowthBoostExpiresAt = {
    check = t.number,
    blank = function() -- Line: 74
        return 0
    end,
}
u15.LuckBoostExpiresAt = {
    check = t.number,
    blank = function() -- Line: 80
        return 0
    end,
}
u15.SpeedBoostExpiresAt = {
    check = t.number,
    blank = function() -- Line: 86
        return 0
    end,
}
u15.RevealedRewards = {
    check = t.map(t.string, u14),
    blank = function() -- Line: 92
        return {}
    end,
}
local v1 = {}
for i, j in u15 do
    v1[i] = j.check
end
local u66 = {}
u66.State = t.interface(v1)

function u66.Blank() -- Line: 107 -- upvalues: u15 (val)
    local v1 = {}
    for i, j in u15 do
        v1[i] = (j.blank())
    end
    return v1
end

function u66.Reconcile(a1) -- Line: 115 -- upvalues: u66 (val), u15 (val), u14 (val)
    local v1
    if type(a1) ~= "table" then
        return u66.Blank()
    end
    local v2 = table.clone(a1)
    local v3 = nil
    local v4 = nil
    for i, j in u15, v3, v4 do
        if i ~= "RevealedRewards" then
            if not j.check(v2[i]) then
                v2[i] = (j.blank())
            end
        elseif type(v2[i]) == "table" then
            v1 = {}
            for k, n in v2[i] do
                if type(k) == "string" and u14(n) then
                    v1[k] = n
                end
            end
            v2[i] = v1
        elseif not j.check(v2[i]) then
            v2[i] = (j.blank())
        end
    end
    return v2
end

return u66