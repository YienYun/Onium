-- Script path: ReplicatedStorage.Shared.Types.OnboardingQuestline
-- Decompile time: 1.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u9 = {}
u9.Variant = {
    check = t.string,
    blank = function() -- Line: 22
        return ""
    end,
}
u9.StartedAt = {
    check = t.number,
    blank = function() -- Line: 28
        return 0
    end,
}
u9.SetIndex = {
    check = t.number,
    blank = function() -- Line: 34
        return 1
    end,
}
u9.Progress = {
    check = t.map(t.string, t.number),
    blank = function() -- Line: 40
        return {}
    end,
}
u9.Claimed = {
    check = t.map(t.string, t.boolean),
    blank = function() -- Line: 46
        return {}
    end,
}
u9.UnlockedPadlocks = {
    check = t.number,
    blank = function() -- Line: 52
        return 0
    end,
}
u9.PadlocksAcknowledged = {
    check = t.number,
    blank = function() -- Line: 58
        return 0
    end,
}
u9.RewardGranted = {
    check = t.boolean,
    blank = function() -- Line: 64
        return false
    end,
}
u9.RewardAcknowledged = {
    check = t.boolean,
    blank = function() -- Line: 70
        return false
    end,
}
local v1 = {}
for i, j in u9 do
    v1[i] = j.check
end
local u54 = {}
u54.State = t.interface(v1)

function u54.Blank() -- Line: 85 -- upvalues: u9 (val)
    local v1 = {}
    for i, j in u9 do
        v1[i] = (j.blank())
    end
    return v1
end

function u54.Reconcile(a1) -- Line: 95 -- upvalues: u54 (val), u9 (val)
    if type(a1) ~= "table" then
        return u54.Blank()
    end
    local v1 = table.clone(a1)
    for i, j in u9 do
        if not j.check(v1[i]) then
            v1[i] = (j.blank())
        end
    end
    return v1
end

return u54