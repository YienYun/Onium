-- Script path: ReplicatedStorage.Data.BossMastery
-- Decompile time: 12.92 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
require(ReplicatedStorage.Shared.Types.BossMastery)
local Currency = require(ReplicatedStorage.Data.Currency)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rift = require(ReplicatedStorage.Data.Rift)
local u32 = {
    RiftbornEgg = {
        Id = "RiftbornEgg",
        DisplayName = "Riftborn Egg",
        Reward = {Kind = "RiftEgg", BannerId = "Verdant", Mutated = false},
    },
    RiftbeastsEgg = {
        Id = "RiftbeastsEgg",
        DisplayName = "Riftbeasts Egg",
        Reward = {Kind = "RiftEgg", BannerId = "Umbral", Mutated = false},
    },
    MutatedRiftbornEgg = {
        Id = "MutatedRiftbornEgg",
        DisplayName = "Mutated Riftborn Egg",
        Reward = {Kind = "RiftEgg", BannerId = "Verdant", Mutated = true},
    },
    RotationMutatedEgg = {
        Id = "RotationMutatedEgg",
        DisplayName = "Mutated Egg",
        Reward = {Kind = "RiftRotationEgg", Mutated = true},
    },
    TokenBoost = {
        Id = "TokenBoost",
        DisplayName = "Permanent Boss Token Boost",
        Reward = {Kind = "TokenBoost", Percent = 50},
    },
}
local u43 = {
    {Id = "Mastery3", Kills = 3, RewardId = "RiftbornEgg"},
    {Id = "Mastery5", Kills = 5, RewardId = "TokenBoost"},
    {Id = "Mastery10", Kills = 10, RewardId = "RiftbeastsEgg"},
    {Id = "Mastery15", Kills = 15, RewardId = "MutatedRiftbornEgg"},
    {Id = "Mastery20", Kills = 20, RewardId = "RotationMutatedEgg"},
    {Id = "Mastery30", Kills = 30, RewardId = "RotationMutatedEgg"},
}
local u50 = {}
for i, j in u43 do
    u50[j.Id] = j
end
local v1 = {
    {
        Id = "CashBooster",
        DisplayName = "2x Cash Booster",
        Icon = "rbxassetid://119640363267627",
        Price = 175,
        Reward = {Kind = "CashBooster"},
    },
    {
        Id = "SpeedBoost",
        DisplayName = "1.25x Speed",
        Icon = "rbxassetid://78137530993637",
        Price = 225,
        Reward = {Kind = "SpeedBoost"},
    },
    {
        Id = "TreadmillBooster",
        DisplayName = "2x Treadmill Booster",
        Icon = "rbxassetid://107126944152347",
        Price = 200,
        Reward = {Kind = "TreadmillBoost"},
    },
    {
        Id = "MutationConsumable",
        DisplayName = "Mutation Consumable",
        Icon = "rbxassetid://74755693699202",
        Price = 400,
        Reward = {Kind = "MutationConsumable"},
    },
}
local u70 = {}
for k, n in v1 do
    u70[n.Id] = n
end
local u81 = {Verdant = 55, Umbral = 40, Radiant = 5}
local u82 = {MutationId = "Boss", InfiniteMilestoneId = "Infinite", Milestones = u43, ShopProducts = v1}

local function getRewardSpec(a1) -- Line: 173 -- upvalues: u32 (val) -- types: a1: string
    return u32[a1]
end

function u82.GetMilestone(a1) -- Line: 177 -- upvalues: u50 (val) -- types: a1: string
    return u50[a1]
end

function u82.FinalMilestone() -- Line: 181 -- upvalues: u43 (val)
    return u43[#u43]
end

function u82.GetMilestoneKills(a1) -- Line: 185 -- upvalues: BossMasteryFlags (val) -- types: a1: table
    local v1 = (BossMasteryFlags.MilestoneKillOverrides:Get())[a1.Id]
    if v1 ~= nil then
        return v1
    end
    return a1.Kills
end

function u82.GetMilestoneRewardId(a1) -- Line: 193 -- upvalues: BossMasteryFlags (val), u32 (val) -- types: a1: table
    local v1 = (BossMasteryFlags.MilestoneRewardIdOverrides:Get())[a1.Id]
    if v1 ~= nil and u32[v1] ~= nil then
        return v1
    end
    return a1.RewardId
end

function u82.GetMilestoneReward(a1) -- Line: 202 -- upvalues: u82 (val), u32 (val) -- types: a1: table
    local v1 = u32[(u82.GetMilestoneRewardId(a1))] or u32[a1.RewardId]
    local v2 = ("Unknown Boss Mastery reward for %*"):format(a1.Id)
    assert(v1 ~= nil, v2)
    return v1.Reward
end

function u82.GetInfiniteRewardId() -- Line: 209 -- upvalues: BossMasteryFlags (val), u32 (val)
    local v1 = BossMasteryFlags.InfiniteRewardId:Get()
    local v2 = u32[v1]
    if v2 == nil then
        return "RotationMutatedEgg"
    end
    if v2.Reward.Kind ~= "RiftEgg" and v2.Reward.Kind ~= "RiftRotationEgg" then
        return "RotationMutatedEgg"
    end
    return v1
end

function u82.GetInfiniteReward() -- Line: 224 -- upvalues: u82 (val), u32 (val)
    return assert(u32[(u82.GetInfiniteRewardId())], "Infinite Boss Mastery reward spec is missing").Reward
end

function u82.InfiniteRevealKey(a1) -- Line: 232 -- upvalues: u82 (val) -- types: a1: number
    return (("%*:%*"):format(u82.InfiniteMilestoneId, a1))
end

function u82.GetTokenBoostPercent(a1) -- Line: 236 -- upvalues: u82 (val), BossMasteryFlags (val) -- types: a1: table
    local v1 = u82.GetMilestoneReward(a1)
    if v1.Kind ~= "TokenBoost" then
        return 0
    end
    local v2 = (BossMasteryFlags.TokenBoostPercentOverrides:Get())[a1.Id]
    if v2 ~= nil then
        return v2
    end
    return v1.Percent
end

function u82.GetShopProduct(a1) -- Line: 249 -- upvalues: u70 (val) -- types: a1: string
    return u70[a1]
end

function u82.GetShopProducts() -- Line: 253 -- upvalues: BossMasteryFlags (val), u70 (val)
    local v1
    local v2 = {}
    local v3 = {}
    for i, j in BossMasteryFlags.ShopProductIds:Get() do
        v1 = u70[j]
        if v1 ~= nil and not v3[j] then
            v3[j] = true
            table.insert(v2, v1)
        end
    end
    return v2
end

function u82.IsShopProductListed(a1) -- Line: 266 -- upvalues: u82 (val) -- types: a1: string
    for i, j in u82.GetShopProducts() do
        if j.Id == a1 then
            return true
        end
    end
    return false
end

function u82.GetShopPrice(a1) -- Line: 275 -- upvalues: BossMasteryFlags (val) -- types: a1: table
    local v1 = (BossMasteryFlags.ShopPriceOverrides:Get())[a1.Id]
    if v1 ~= nil then
        return v1
    end
    return a1.Price
end

function u82.GetShopDisplayName(a1) -- Line: 283 -- upvalues: BossMasteryFlags (val) -- types: a1: table
    local Reward = a1.Reward
    if Reward.Kind == "CashBooster" then
        return (("%*x Cash Booster"):format((BossMasteryFlags.CashBoosterMultiplier:Get())))
    end
    if Reward.Kind == "SpeedBoost" then
        return (("%*x Speed"):format((BossMasteryFlags.SpeedBoostMultiplier:Get())))
    end
    if Reward.Kind == "TreadmillBoost" then
        return (("%*x Treadmill Booster"):format((BossMasteryFlags.TreadmillBoostMultiplier:Get())))
    end
    return a1.DisplayName
end

function u82.GetShopQuantity(a1) -- Line: 295 -- upvalues: BossMasteryFlags (val) -- types: a1: table
    if a1.Reward.Kind == "Traps" then
        return BossMasteryFlags.TrapsPerPurchase:Get()
    end
    return 1
end

function u82.GetShopQuantityText(a1) -- Line: 302 -- upvalues: BossMasteryFlags (val), u82 (val) -- types: a1: table
    local Reward = a1.Reward
    if Reward.Kind == "CashBooster" then
        return (("%*m"):format((math.max(math.floor((BossMasteryFlags.CashBoosterDurationSeconds:Get()) / 60), 0))))
    end
    if Reward.Kind == "SpeedBoost" then
        return (("%*m"):format((math.max(math.floor((BossMasteryFlags.SpeedBoostDurationSeconds:Get()) / 60), 0))))
    end
    if Reward.Kind == "TreadmillBoost" then
        return (("%*m"):format((math.max(math.floor((BossMasteryFlags.TreadmillBoostDurationSeconds:Get()) / 60), 0))))
    end
    if Reward.Kind == "MutationConsumable" then
        return (("%*%%"):format((BossMasteryFlags.MutationConsumableSuccessPercent:Get())))
    end
    return (("x%*"):format((u82.GetShopQuantity(a1))))
end

function u82.RewardNeedsReveal(a1) -- Line: 327 -- types: a1: table
    local v1 = true
    if a1.Kind ~= "RiftEgg" then
        v1 = a1.Kind == "RiftRotationEgg"
    end
    return v1
end

function u82.GetRotationBannerWeights() -- Line: 331 -- upvalues: BossMasteryFlags (val), u81 (val), Rift (val)
    local v1 = BossMasteryFlags.InfiniteBannerWeights:Get()
    local v2 = table.clone(u81)
    for i, j in v1 do
        if Rift.GetBanner(i) ~= nil then
            v2[i] = j
        end
    end
    return v2
end

function u82.RollBannerId(a1) -- Line: 342 -- upvalues: u82 (val) -- types: a1: userdata
    local v1 = u82.GetRotationBannerWeights()
    local v2 = 0
    for i, j in v1 do
        if j > 0 then
            v2 = v2 + j
        end
    end
    if v2 <= 0 then
        return nil
    end
    local v3 = a1:NextNumber() * v2
    v2 = 0
    local v4 = nil
    for k, n in v1 do
        if not (n <= 0) then
            v2 = v2 + n
            v4 = k
            if v3 <= v2 then
                return k
            end
        end
    end
    return v4
end

function u82.RollReveal(a1, a2) -- Line: 370 -- upvalues: u82 (val), Rift (val) -- types: a1: table, a2: userdata
    local BannerId, v1
    if a1.Kind == "RiftEgg" then
        v1 = Rift.RollPet(a1.BannerId, a2)
        if v1 == nil then
            return nil
        end
        return {BannerId = BannerId, AssetId = v1}
    end
    if a1.Kind ~= "RiftRotationEgg" then
        return nil
    end
    v1 = u82.RollBannerId(a2)
    if v1 == nil then
        return nil
    end
    v1 = Rift.RollPet(v1, a2)
    if v1 == nil then
        return nil
    end
    return {BannerId = BannerId, AssetId = v1}
end

function u82.FillMissingReveals(a1, a2) -- Line: 394
    -- upvalues: Assets (val), Rift (val), u82 (val), u43 (val)
    local u7 = table.clone(a1.RevealedRewards or {})
    local u8 = false

    local function ensure(a1, a2_2) -- Line: 401
        -- upvalues: u7 (val), Assets (upval), Rift (upval), u8 (ref), u82 (upval), a2 (val)
        local v1 = u7[a1]
        if v1 ~= nil then
            local v2 = true
            if a2_2.Kind == "RiftEgg" then
                v2 = v1.BannerId == a2_2.BannerId
            end
            if v2 and Assets.Directory[v1.AssetId] ~= nil and Rift.BannerContainsPet(v1.BannerId, v1.AssetId) then
                return
            end
            u7[a1] = nil
            u8 = true
        end
        v1 = u82.RollReveal(a2_2, a2)
        if v1 == nil then
            return
        end
        u7[a1] = v1
        u8 = true
    end

    local v1 = nil
    for i, j in u43, nil, v1 do
        if not a1.ClaimedMilestoneIds[j.Id] then
            ensure(j.Id, u82.GetMilestoneReward(j))
        end
    end
    local v2 = u82.ClaimableInfiniteCount(a1)
    local v3 = u82.GetInfiniteReward()
    if a1.ClaimedMilestoneIds[u82.FinalMilestone().Id] then
        v1 = math.max(v2, 1)
        local v4 = a1.InfiniteRewardsClaimed + 1
        local v5 = a1.InfiniteRewardsClaimed + v1
        for k = v4, v5 do
            ensure(u82.InfiniteRevealKey(k), v3)
        end
    end
    if not u8 then
        return a1
    end
    v3 = table.clone(a1)
    v3.RevealedRewards = u7
    return v3
end

function u82.TokenBoostMultiplierFor(a1) -- Line: 448 -- upvalues: BossMasteryFlags (val) -- types: a1: table
    local v1
    local v2 = 0
    local v3 = nil
    local v4 = nil
    for i, j in a1, v3, v4 do
        v1 = BossMasteryFlags.TokenBoostPercentOverrides:Get()[i]
        v2 = v2 + (if v1 == nil then j else v1)
    end
    return v2 / 100 + 1
end

function u82.NextMilestoneFor(a1) -- Line: 460 -- upvalues: u43 (val), u82 (val) -- types: a1: number
    for i, j in u43 do
        if a1 < u82.GetMilestoneKills(j) then
            return j
        end
    end
    return nil
end

function u82.ClaimableInfiniteCount(a1) -- Line: 469 -- upvalues: u82 (val), BossMasteryFlags (val)
    local v1 = u82.FinalMilestone()
    if not a1.ClaimedMilestoneIds[v1.Id] then
        return 0
    end
    return (math.max(
        math.max((a1.Mastery - (u82.GetMilestoneKills(v1))) // (BossMasteryFlags.InfiniteRewardEveryKills:Get()), 0) - a1.InfiniteRewardsClaimed,
        0
    ))
end

local function bossEggIcon() -- Line: 483 -- upvalues: Mutations (val)
    local Boss = Mutations.Get("Boss")
    if Boss ~= nil and Boss.EggIcon ~= nil then
        return Boss.EggIcon
    end
    return "rbxassetid://121553987798547"
end

local function tokenBoostPresentation(a1) -- Line: 491 -- upvalues: Currency (val) -- types: a1: number
    return {
        Title = "Permanent Token Boost",
        HoverTitle = "BOSS TOKEN BOOST",
        Icon = assert(Currency.Directory.BossTokens.Icon, "Boss Tokens icon is missing"),
        Amount = ("+%*%%"):format(a1),
        HoverDescription = ("Earn +%*%% Boss Tokens from boss kills"):format(a1),
    }
end

local function rotationEggIcons() -- Line: 504 -- upvalues: u82 (val), Rift (val)
    local v1
    local v2 = u82.GetRotationBannerWeights()
    local v3 = {}
    for i, j in Rift.Banners do
        v1 = v2[j.Id] or 0
        if not (v1 <= 0) then
            v1 = Rift.GetBannerEggIcon(j.Id)
            if v1 ~= nil then
                table.insert(v3, v1)
            end
        end
    end
    return v3
end

function u82.GetRewardPresentation(a1, a2, a3) -- Line: 519
    -- upvalues: Currency (val), Rift (val), Mutations (val), rotationEggIcons (val), u70 (val), u82 (val)
    local v1, v2
    if a1.Kind == "TokenBoost" then
        local Percent = a1.Percent
        return {
            Title = "Permanent Token Boost",
            HoverTitle = "BOSS TOKEN BOOST",
            Icon = assert(Currency.Directory.BossTokens.Icon, "Boss Tokens icon is missing"),
            Amount = ("+%*%%"):format(Percent),
            HoverDescription = ("Earn +%*%% Boss Tokens from boss kills"):format(Percent),
        }
    end
    local v3 = ("x%*"):format(a3 or 1)
    if a1.Kind == "RiftEgg" then
        v1 = Rift.GetBannerDisplayName(a1.BannerId)
        v2 = {}
        local v4 = if not a1.Mutated then ("%* Egg"):format(v1) else ("Mutated %* Egg"):format(v1)
        v2.Title = v4
        local EggIcon = Rift.GetBannerEggIcon(a1.BannerId)
        if not EggIcon then
            local Boss = Mutations.Get("Boss")
            EggIcon = if Boss == nil then "rbxassetid://121553987798547" else if Boss.EggIcon == nil then "rbxassetid://121553987798547" else Boss.EggIcon
        end
        v2.Icon = EggIcon
        v2.Amount = v3
        v2.HoverTitle = string.upper(if not a1.Mutated then ("%* EGG"):format(v1) else ("MUTATED %* EGG"):format(v1))
        v4 = if not a1.Mutated then ("Awards a %* Egg"):format(v1) else ("Awards a %* Egg with the Fractured mutation"):format(v1)
        v2.HoverDescription = v4
        return v2
    end
    if a1.Kind ~= "RiftRotationEgg" then
        local Icon_2
        v1 = u70[if a1.Kind ~= "CashBooster" then if a1.Kind ~= "SpeedBoost" then if a1.Kind ~= "TreadmillBoost" then "MutationConsumable" else "TreadmillBooster" else "SpeedBoost" else "CashBooster"]
        v2 = {Title = if not v1 then "Reward" else u82.GetShopDisplayName(v1)}
        if not v1 then
            local Boss_3 = Mutations.Get("Boss")
            Icon_2 = if Boss_3 == nil then "rbxassetid://121553987798547" else if Boss_3.EggIcon == nil then "rbxassetid://121553987798547" else Boss_3.EggIcon
        else
            Icon_2 = v1.Icon
        end
        v2.Icon = Icon_2
        v2.Amount = v3
        return v2
    end
    v1 = rotationEggIcons()
    v2 = {
        Title = "Random Mutated Egg",
        HoverTitle = "MUTATED EGG",
        HoverDescription = "Awards a random egg with the Fractured mutation",
    }
    local EggIcon_2 = v1[1]
    if not EggIcon_2 then
        local Boss_2 = Mutations.Get("Boss")
        EggIcon_2 = if Boss_2 == nil then "rbxassetid://121553987798547" else if Boss_2.EggIcon == nil then "rbxassetid://121553987798547" else Boss_2.EggIcon
    end
    v2.Icon = EggIcon_2
    v2.CycleIcons = v1
    v2.Amount = v3
    return v2
end

function u82.GetMilestonePresentation(a1, a2, a3) -- Line: 574
    -- upvalues: u82 (val), Currency (val)
    local v1 = u82.GetMilestoneReward(a1)
    if v1.Kind ~= "TokenBoost" then
        return u82.GetRewardPresentation(v1, a2, a3)
    end
    local v2 = u82.GetTokenBoostPercent(a1)
    return {
        Title = "Permanent Token Boost",
        HoverTitle = "BOSS TOKEN BOOST",
        Icon = assert(Currency.Directory.BossTokens.Icon, "Boss Tokens icon is missing"),
        Amount = ("+%*%%"):format(v2),
        HoverDescription = ("Earn +%*%% Boss Tokens from boss kills"):format(v2),
    }
end

return table.freeze(u82)