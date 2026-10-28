-- Script path: ReplicatedStorage.Shared.Types.HalloweenDimension
-- Decompile time: 0.90 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u9 = {}
u9.Manor = t.strictInterface({Met = t.boolean, KeyClaimed = t.boolean, GateUnlocked = t.boolean})
u9.BossMastery = t.strictInterface({
    Mastery = t.integer,
    ClaimedMilestoneIds = t.map(t.string, t.boolean),
    InfiniteRewardsClaimed = t.integer,
})
u9.State = t.strictInterface({Manor = u9.Manor, TutorialSeen = t.boolean, BossMastery = u9.BossMastery})

function u9.BlankManor() -- Line: 52
    return {Met = false, KeyClaimed = false, GateUnlocked = false}
end

function u9.BlankBossMastery() -- Line: 56
    return {Mastery = 0, InfiniteRewardsClaimed = 0, ClaimedMilestoneIds = {}}
end

function u9.Blank() -- Line: 60 -- upvalues: u9 (val)
    return {
        TutorialSeen = false,
        Manor = u9.BlankManor(),
        BossMastery = u9.BlankBossMastery(),
    }
end

return table.freeze(u9)