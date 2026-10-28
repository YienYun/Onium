-- Script path: ReplicatedStorage.Data.Sakura
-- Decompile time: 6.76 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local u14 = {
    EventName = "GreatBloom",
    CurrencyId = "SakuraCrystals",
    MutationName = "Sakura",
    SpecialMutationName = "GreatBloom",
    TreeTag = "SakuraBloomTree",
    CrystalTag = "SakuraCrystal",
    BatToolAttribute = "IsBat",
    Bloom = {
        IntervalSeconds = 1800,
        OffsetSeconds = 900,
        DurationSeconds = 285,
        NightPollSeconds = 0.5,
        EndsAtAttribute = "GreatBloomEndsAt",
        MaxActiveTrees = 50,
        SpawnDelayMin = 0.25,
        SpawnDelayMax = 0.75,
        SpawnClearance = 6,
        SpawnAttempts = 40,
        HitCooldownSeconds = 0.6,
        HitHoldSeconds = 0.2,
        EndingWarningSeconds = 30,
        HitRange = 10,
        SpawnShakeRadius = 10,
        CrystalScale = 0.22,
        CrystalPickupRange = 10,
        CrystalLifetimeSeconds = 60,
        CrystalSpreadRadius = 14,
        Sizes = {
            {
                Id = "Small",
                Weight = 50,
                Hits = 1,
                CrystalsPerHit = 0,
                ScatterCrystals = 1,
                ScatterCrystalValue = 5,
            },
            {
                Id = "Medium",
                Weight = 30,
                Hits = 2,
                CrystalsPerHit = 0,
                ScatterCrystals = 2,
                ScatterCrystalValue = 5,
            },
            {
                Id = "Large",
                Weight = 15,
                Hits = 3,
                CrystalsPerHit = 0,
                ScatterCrystals = 4,
                ScatterCrystalValue = 5,
            },
            {
                Id = "Gigantic",
                Weight = 5,
                Hits = 3,
                CrystalsPerHit = 0,
                ScatterCrystals = 6,
                ScatterCrystalValue = 5,
            },
        },
    },
    Incubator = {
        Cost = 1000,
        MaxChargePercent = 150,
        SpecialChanceAt100 = 2.5,
        SpecialChanceAtMax = 5,
        LuckBoostMultiplier = 2,
        MaxLuckBoosts = 3,
        LuckBoostProductNames = {"SakuraLuckBoost1", "SakuraLuckBoost2", "SakuraLuckBoost3"},
    },
    Sounds = {
        TreeSpawn = 116457372922007,
        TreeHit = 84529703733081,
        TreeBreak = 83426144942407,
        CrystalPickup = 98181315786739,
        CrystalsGained = 72831064837421,
        Deposit = 133204478644023,
        Mutate = 139860804876890,
        CraneFlap = 9120779671,
        Bloom = 9116418035,
        Unlocked = 102177008084626,
        TutorialOpen = 89550685069550,
    },
}
local v1 = {
    AreaId = "CherryBlossom",
    DisplayName = "Cherry Blossom",
    Emoji = "🌸",
    Lighting = "CherryBlossom",
    Rarity = Rarity.Rarities.Divine,
}
u14.AreaDisplay = v1
u14.Quest = {CraneAssetId = "Crane"}

function u14.GetRequiredCrystals() -- Line: 123 -- upvalues: u14 (ref)
    return u14.Incubator.Cost
end

function u14.GetChargePercent(a1, a2) -- Line: 127 -- upvalues: u14 (ref) -- types: a1: number, a2: number
    if a2 <= 0 then
        return 0
    end
    return (math.clamp(a1 / a2 * 100, 0, u14.Incubator.MaxChargePercent))
end

function u14.GetLuckMultiplier(a1) -- Line: 135 -- upvalues: u14 (ref) -- types: a1: number
    return u14.Incubator.LuckBoostMultiplier ^ a1
end

function u14.CanBuyLuckBoost(a1, a2) -- Line: 139 -- upvalues: u14 (ref) -- types: a1: table, a2: number
    if not a1.Unlocked then
        return false, "The Sakura Incubator is still sealed"
    end
    if a1.Egg == false then
        return false, "Place an egg inside first"
    end
    local LuckBoost = a1.LuckBoost
    if u14.Incubator.MaxLuckBoosts <= LuckBoost then
        return false, "This egg already has max luck"
    end
    if a2 ~= a1.LuckBoost + 1 then
        return false, "Wrong luck boost tier for this egg"
    end
    return true, nil
end

function u14.GetFreeChargeCap(a1) -- Line: 162 -- upvalues: u14 (ref) -- types: a1: number
    return (math.ceil(a1 * u14.Incubator.MaxChargePercent / 100))
end

function u14.GetMutationChance(a1) -- Line: 166 -- types: a1: number
    return (math.clamp(a1, 0, 100))
end

function u14.GetEffectiveMutationChance(a1, a2) -- Line: 171 -- upvalues: u14 (ref) -- types: a1: number, a2: number
    return 100 - u14.GetSpecialChance(a1, a2)
end

function u14.GetSpecialChance(a1, a2) -- Line: 175
    -- upvalues: u14 (ref), AdminBoosts (val)
    local Incubator = u14.Incubator
    return (math.clamp(
        (Incubator.SpecialChanceAt100 + (Incubator.SpecialChanceAtMax - Incubator.SpecialChanceAt100) * ((math.max(a1 - 100, 0)) / math.max(Incubator.MaxChargePercent - 100, 1))) * u14.GetLuckMultiplier(a2) * (AdminBoosts.ReadMultiplier(AdminBoosts.VIDEO_LUCK)),
        0,
        100
    ))
end

function u14.PickTreeSize(a1) -- Line: 184 -- upvalues: u14 (ref) -- types: a1: userdata
    local Sizes = u14.Bloom.Sizes
    local v1 = 0
    for i, j in Sizes do
        v1 = v1 + j.Weight
    end
    local v2 = a1:NextNumber() * v1
    v1 = 0
    for k, n in Sizes do
        v1 = v1 + n.Weight
        if v2 <= v1 then
            return n
        end
    end
    return Sizes[#Sizes]
end

function u14.GetTreeSize(a1) -- Line: 206 -- upvalues: u14 (ref) -- types: a1: string
    for i, j in u14.Bloom.Sizes do
        if j.Id == a1 then
            return j
        end
    end
    error((("Unknown Sakura tree size %*"):format(a1)))
end

function u14.HasSakuraMutation(a1) -- Line: 216 -- upvalues: u14 (ref) -- types: a1: table?
    if a1 == nil then
        return false
    end
    local v1 = true
    if table.find(a1, u14.MutationName) == nil then
        v1 = table.find(a1, u14.SpecialMutationName) ~= nil
    end
    return v1
end

function u14.IsBatTool(a1) -- Line: 225 -- upvalues: u14 (ref) -- types: a1: userdata
    return a1:GetAttribute(u14.BatToolAttribute) == true
end

u14 = ((require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.Sakura", u14, {
    Bloom = {
        IntervalSeconds = true,
        OffsetSeconds = true,
        DurationSeconds = true,
        MaxActiveTrees = true,
        SpawnDelayMin = true,
        SpawnDelayMax = true,
        HitCooldownSeconds = true,
        HitRange = true,
        CrystalPickupRange = true,
        CrystalLifetimeSeconds = true,
        Sizes = true,
    },
    Incubator = {
        Cost = true,
        MaxChargePercent = true,
        SpecialChanceAt100 = true,
        SpecialChanceAtMax = true,
        LuckBoostMultiplier = true,
        MaxLuckBoosts = true,
    },
}, false, function(a1) -- Line: 256
    local v1 = false
    if 0 < a1.Bloom.IntervalSeconds then
        v1 = 0 < a1.Bloom.DurationSeconds
    end
    assert(v1)
    v1 = false
    if a1.Bloom.SpawnDelayMin <= a1.Bloom.SpawnDelayMax then
        v1 = 0 < a1.Bloom.SpawnDelayMin
    end
    assert(v1)
    assert(a1.Bloom.MaxActiveTrees % 1 == 0)
    v1 = false
    if 0 < a1.Incubator.Cost then
        v1 = 100 < a1.Incubator.MaxChargePercent
    end
    assert(v1)
    v1 = false
    if a1.Incubator.SpecialChanceAt100 <= 100 then
        v1 = a1.Incubator.SpecialChanceAtMax <= 100
    end
    assert(v1)
    v1 = false
    if a1.Incubator.MaxLuckBoosts % 1 == 0 then
        v1 = a1.Incubator.MaxLuckBoosts <= 3
    end
    assert(v1)
end))
return u14