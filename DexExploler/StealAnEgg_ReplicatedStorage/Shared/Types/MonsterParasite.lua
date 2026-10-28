-- Script path: ReplicatedStorage.Shared.Types.MonsterParasite
-- Decompile time: 4.20 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local t = require(ReplicatedStorage.Packages.t)
local u19 = {}
u19.RewardIds = table.freeze({
    EggGrowthBoost = "EggGrowthBoost",
    SpeedBoost = "SpeedBoost",
    TreadmillBoost = "TreadmillBoost",
    ExclusiveWeapon = "ExclusiveWeapon",
    MonsterEgg = "MonsterEgg",
})
u19.RetiredRewardIds = table.freeze({Cash = "Cash", SpeedSmall = "SpeedSmall", SpeedLarge = "SpeedLarge"})
local v1 = t.interface({
    Id = t.union(
        t.literal(u19.RewardIds.EggGrowthBoost),
        t.literal(u19.RewardIds.SpeedBoost),
        t.literal(u19.RewardIds.TreadmillBoost),
        t.literal(u19.RewardIds.ExclusiveWeapon),
        t.literal(u19.RewardIds.MonsterEgg),
        t.literal(u19.RetiredRewardIds.Cash),
        t.literal(u19.RetiredRewardIds.SpeedSmall),
        t.literal(u19.RetiredRewardIds.SpeedLarge)
    ),
    DisplayName = t.string,
    Amount = t.optional(t.number),
    ItemId = t.optional(t.string),
    Egg = t.optional(t.interface({Uid = t.string, AssetCategory = t.string, Mutation = t.string})),
})
u19.PendingRewardSchema = t.interface({
    OpeningId = t.string,
    Reward = v1,
    SerializedEgg = t.optional(Eggs.SchemaValidation.SerializedSavedEgg),
})
u19.StateSchema = t.interface({
    Charge = t.number,
    PendingChests = t.number,
    TotalFeeds = t.number,
    PendingReward = t.optional(u19.PendingRewardSchema),
    EggGrowthBoostExpiresAt = t.optional(t.number),
    SpeedBoostExpiresAt = t.optional(t.number),
})
u19.EventStateSchema = t.interface({Active = t.boolean, EndsAt = t.number, ServerTime = t.number})
u19.SnapshotSchema = t.interface({Event = u19.EventStateSchema, State = u19.StateSchema})
u19.FeedResultSchema = t.interface({
    Success = t.boolean,
    Message = t.string,
    EggUid = t.optional(t.string),
    PreviousCharge = t.optional(t.number),
    Charge = t.optional(t.number),
    PendingChests = t.optional(t.number),
})
u19.ChestResultSchema = t.interface({
    Success = t.boolean,
    Message = t.string,
    OpeningId = t.optional(t.string),
    Reward = t.optional(v1),
    PendingChests = t.optional(t.number),
})
u19.RevealResultSchema = t.interface({Success = t.boolean, Message = t.string})
u19.TakeResultSchema = t.interface({Success = t.boolean, Message = t.string})
u19.ViewRewardsPromptName = "ViewRewardsPrompt"
u19.ViewRewardsPromptText = "View Rewards"
u19.ChargeDrainAttributeName = "MonsterChargeDrain"
u19.ChargeDrainDuration = 0.5
u19.ChargeGainAttributeName = "MonsterChargeGain"
u19.ChargeGainCueTimeout = 4
u19.BoostKinds = table.freeze({EggGrowth = "EggGrowth", Speed = "Speed"})
u19.BoostRewardIds = table.freeze({EggGrowth = u19.RewardIds.EggGrowthBoost, Speed = u19.RewardIds.SpeedBoost})

function u19.BoostExpiresAt(a1, a2) -- Line: 295 -- upvalues: u19 (val) -- types: a1: table?, a2: string
    if a1 == nil then
        return 0
    end
    local EggGrowthBoostExpiresAt = if a2 ~= u19.BoostKinds.EggGrowth then a1.SpeedBoostExpiresAt else a1.EggGrowthBoostExpiresAt
    if type(EggGrowthBoostExpiresAt) == "number" then
        return EggGrowthBoostExpiresAt
    end
    return 0
end

function u19.BoostRemainingSeconds(a1, a2, a3) -- Line: 306
    -- upvalues: Workspace (val), u19 (val)
    return (math.max(u19.BoostExpiresAt(a1, a2) - (if a3 ~= nil then a3 else Workspace:GetServerTimeNow()), 0))
end

function u19.IsBoostActive(a1, a2, a3) -- Line: 315 -- upvalues: u19 (val) -- types: a1: table?, a2: string, a3: number?
    return 0 < (u19.BoostRemainingSeconds(a1, a2, a3))
end

function u19.RefreshBoost(a1, a2, a3, a4) -- Line: 330
    -- upvalues: u19 (val)
    local v1 = table.clone(a1)
    local v2 = math.max(a4 + a3, (u19.BoostExpiresAt(a1, a2)))
    if a2 == u19.BoostKinds.EggGrowth then
        v1.EggGrowthBoostExpiresAt = v2
        return v1
    end
    v1.SpeedBoostExpiresAt = v2
    return v1
end

function u19.DefaultState() -- Line: 349
    return {Charge = 0, PendingChests = 0, TotalFeeds = 0}
end

return table.freeze(u19)