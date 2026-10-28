-- Script path: ReplicatedStorage.Data.MonsterParasite
-- Decompile time: 7.09 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Flyswatter = require(ReplicatedStorage.Data.Gears.Configs.Flyswatter)
local MonsterParasiteFlags = require(ReplicatedStorage.Shared.Flags.MonsterParasiteFlags)
local MonsterParasite = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local RewardIds = MonsterParasite.RewardIds
local u22 = {
    Snow = 29,
    Volcano = 26,
    ["Abyss Ocean"] = 18,
    Prehistoric = 15,
    Cosmic = 13,
    ["Cherry Blossom"] = 11,
    ["Titan Temple"] = 9,
}
local u30 = {
    {Charge = 0, Scale = 1},
    {Charge = 20, Scale = 1.12},
    {Charge = 40, Scale = 1.25},
    {Charge = 60, Scale = 1.45},
    {Charge = 80, Scale = 1.75},
    {Charge = 100, Scale = 2},
}

local function buildMonstrousEggIdsList() -- Line: 225 -- upvalues: ReplicatedStorage (val)
    local v1 = require(ReplicatedStorage.Data.Areas).Directory["Titan Temple"]
    local v2 = {}
    for i, j in v1.DropTable do
        table.insert(v2, {Id = j[1], Weight = j[2]})
    end
    assert(#v2 > 0, "Titan Temple has no drop table for the Monstrous Egg")
    return v2
end

local u53 = {}
local v1 = {
    Weight = 43.5,
    DisplayName = "1.25x Egg Growth",
    DisplayNote = "5 Minutes",
    Rarity = "Common",
    Icon = "rbxassetid://84954605144740",
    Id = RewardIds.EggGrowthBoost,
    Metadata = {DurationSeconds = 300, Multiplier = 1.25},
}
local v2 = {
    Weight = 30,
    DisplayName = "1.25x Speed",
    DisplayNote = "5 Minutes",
    Rarity = "Uncommon",
    Icon = "rbxassetid://78137530993637",
    Id = RewardIds.SpeedBoost,
    Metadata = {DurationSeconds = 300, Multiplier = 1.25},
}
local v3 = {
    Weight = 20,
    DisplayName = "2x Treadmill Speed",
    DisplayNote = "5 Minutes",
    Rarity = "Rare",
    Id = RewardIds.TreadmillBoost,
    Metadata = {DurationSeconds = 300},
}
local v4 = {
    Weight = 5,
    DisplayName = "Flyswatter",
    Rarity = "Epic",
    Id = RewardIds.ExclusiveWeapon,
    DuplicateRewardId = RewardIds.TreadmillBoost,
    Icon = Flyswatter.Icon,
    Metadata = {GearId = Flyswatter._id},
}
local v5 = {
    Weight = 1.5,
    DisplayName = "PARASITE EGG",
    DisplayNote = "Guaranteed Monstrous Mutation",
    NoteIsPanelOnly = true,
    Rarity = "BEST REWARD",
    Icon = "rbxassetid://121553987798547",
    Id = RewardIds.MonsterEgg,
    Metadata = {MutationId = "Monstrous", EggIdsList = buildMonstrousEggIdsList()},
}
u53[1] = v1
u53[2] = v2
u53[3] = v3
u53[4] = v4
u53[5] = v5
v2 = {
    EventName = "MonsterParasite",
    EndsAt = 1788620400,
    MinimumRarityNumber = 5,
    EligibilityGuardId = "Jungle",
    SpawnChanceByArea = u22,
    ChargePerFeed = 20,
    MaxCharge = 100,
    BellyStages = u30,
    Rewards = u53,
    FeedDistance = 14,
    HudDistance = 24,
    RequestCooldown = 0.75,
    PromptHoldDuration = 0.25,
    MonsterOffset = CFrame.new(0, 0, -8),
    MarkerFolderName = "MonsterParasiteMarkers",
    MonsterSpawnMarkerName = "MonsterSpawn",
    ChestSpawnMarkerName = "MonsterChestSpawn",
    ChestSpawnCFrameAttributeName = "MonsterChestSpawnCFrame",
    AssetsFolderName = "MonsterParasite",
    ParasiteModelName = "Parasite",
    ParasiteVisualName = "MonsterParasiteVisual",
    ParasiteIdleAnimationId = 113082199990805,
    ParasiteCrownOffset = Vector2.zero,
    ParasiteScaleMultiplier = 0.45,
    MonsterModelName = "Monster",
    MonsterModelNames = {"Monster1", "Monster2", "Monster3", "Monster4"},
    MonsterModelIndexAttributeName = "MonsterModelIndex",
    MonsterRetiringAttributeName = "MonsterRetiring",
    MonsterRetireSeconds = 0.45,
    MonsterAnimationIdsByIndex = {
        {Idle = 128217356432291, Yank = 86644195835902},
        {Idle = 99744254158313, Yank = 131549849408123},
        {Idle = 122218896916983, Yank = 140178521003505},
        {Idle = 124151642143348, Yank = 110901356129499, Burp = 94789436133823},
    },
    ChestModelName = "MonsterChest",
    ChestToolName = "Monster Chest",
    ChestToolItemType = "MonsterChest",
    ChestToolScale = 0.42,
    ChestToolGrip = (CFrame.new(0, -0.15, -0.35)) * CFrame.Angles(0, 1.5707963267948966, 0),
    ChestToolIcon = "rbxassetid://139693832314356",
    ChestPickupDuration = 0.6,
    ParasiteBillboardName = "MonsterParasite",
    ParasiteBillboardScale = 0.5,
    ParasiteHighlightName = "MonsterParasiteHighlight",
    ParasiteHighlightColor = Color3.fromRGB(198, 158, 255),
    ParasiteHighlightTransparency = 0.25,
    ParasiteHighlightFillTransparency = 0.7,
    HudName = "MonsterChargeUI",
    WorldFolderName = "MonsterParasiteMonsters",
    PadName = "Monster",
    MonsterDisplayName = "The Hungry Monster",
    TalkPromptName = "TalkPrompt",
    TalkPromptText = "Who are you?",
    FeedPromptName = "FeedPrompt",
    FeedPromptText = "Feed Parasite",
    ChestPromptName = "ChestPrompt",
    ChestPromptText = "Claim Monster Chest",
    DialogueText = "Parasites make me stronger. Bring me an infested egg, and I will eat the parasite without harming what is inside.",
    RewardTitle = "MONSTER CHEST REWARD",
    BellyPartName = "Belly",
    ParasiteEatTargetPartName = "ParasiteEatTarget",
    TongueTipName = "Tongue3",
    ChestOriginPartName = "ChestOrigin",
    ChestOriginNames = {"ChestOrigin", "MouthCenter1", "Tongue3"},
    GrabMarkerName = "Grab",
    BurpMarkerName = "burp_start",
    ChestOffset = CFrame.new(0, 2, -4),
    YankDuration = 0.35,
    BellyTweenDuration = 0.45,
    FullChargeHoldDuration = 0.8,
    FullChargeModelHoldDuration = 15,
    BurpBeatDuration = 0.18,
    RoarDuration = 0.55,
    ChestLaunchDelay = 0.06,
    ChestLaunchDuration = 0.78,
    ChestBounceDuration = 0.4,
    ChestLaunchHeight = 5,
    ChestBounceHeight = 1.4,
    ChestLaunchStartScale = 0.65,
    ChestLaunchSpins = 2,
    ChestLaunchBeatFallback = 2.4,
    ChestThrowDistanceMin = 12,
    ChestThrowDistanceMax = 19,
    ChestThrowSpreadDegrees = 26,
    ChestThrowStraightJitterDegrees = 5,
    ChestThrowAttempts = 5,
    ChestGroundRestDuration = 0.3,
    ChestPickupRise = 2.5,
    ChestGroundProbeHeight = 6,
    ChestGroundProbeDepth = 90,
    ChestImpactShakeMagnitude = 1.4,
    ChestImpactShakeRoughness = 9,
    ChestImpactShakeFadeIn = 0.04,
    ChestImpactShakeFadeOut = 0.5,
    ChestImpactShakeRange = 110,
    SoundFolderName = "MonsterParasite",
    YankSoundName = "Yank",
    ChompSoundName = "Chomp",
    BurpSoundName = "Burp",
    RoarSoundName = "Roar",
    EnergyBurstSoundName = "EnergyBurst",
    ChestLandingSoundName = "ChestLanding",
    ChestSoundName = "ChestOpen",
    VfxFolderName = "MonsterParasite",
    EnergyBurstVfxName = "EnergyBurst",
    SwapPoofVfxName = "SwapPoof",
    GroundHitParticlesName = "BigHitGroundAttach",
    HudRootName = "Root",
    HudBarName = "Bar",
    HudFillName = "Fill",
    HudPercentName = "Percent",
    HudStatusName = "Status",
    HudTimerName = "Timer",
    HudChargingText = "MONSTER CHARGE",
    HudReadyText = "MONSTER CHEST READY!",
    GetSpawnChance = function(a1) -- Line: 468 -- upvalues: MonsterParasiteFlags (val), u22 (val) -- types: a1: string
        local v1 = MonsterParasiteFlags.SpawnChanceByArea:Get()[a1]
        if v1 ~= nil then
            return v1
        end
        return u22[a1] or 0
    end,
    GetBellyScale = function(a1) -- Line: 477 -- upvalues: u30 (val) -- types: a1: number
        local Scale = u30[1].Scale
        for i, j in u30 do
            if a1 < j.Charge then
                break
            end
            Scale = j.Scale
        end
        return Scale
    end,
    GetMonsterModelIndex = function(a1) -- Line: 208 -- types: a1: number
        if a1 >= 80 then
            return 4
        end
        if a1 >= 60 then
            return 3
        end
        if a1 >= 40 then
            return 2
        end
        return 1
    end,
    GetReward = function(a1) -- Line: 322 -- upvalues: u53 (val)
        for i, j in u53 do
            if j.Id == a1 then
                return j
            end
        end
        error(("Unknown Monster Chest reward %*"):format(a1), 2)
    end,
    RewardLabel = function(a1) -- Line: 314
        if a1.DisplayNote ~= nil and not a1.NoteIsPanelOnly then
            return (("%* (%*)"):format(a1.DisplayName, a1.DisplayNote))
        end
        return a1.DisplayName
    end,
    BoostMultiplier = function(a1) -- Line: 493 -- upvalues: MonsterParasite (val), u53 (val)
        local v1 = MonsterParasite.BoostRewardIds[a1]
        for i, j in u53 do
            if j.Id == v1 then
                return j.Metadata.Multiplier or 1
            end
        end
        error(("Unknown Monster Chest reward %*"):format(v1), 2)
        return (nil).Metadata.Multiplier or 1
    end,
    BoostDurationSeconds = function(a1) -- Line: 496 -- upvalues: MonsterParasite (val), u53 (val)
        local v1 = MonsterParasite.BoostRewardIds[a1]
        for i, j in u53 do
            if j.Id == v1 then
                return j.Metadata.DurationSeconds or 0
            end
        end
        error(("Unknown Monster Chest reward %*"):format(v1), 2)
        return (nil).Metadata.DurationSeconds or 0
    end,
    GetRewardWeight = function(a1) -- Line: 499 -- upvalues: MonsterParasiteFlags (val), u53 (val)
        local v1 = MonsterParasiteFlags.RewardWeights:Get()[a1]
        if v1 ~= nil then
            return v1
        end
        for i, j in u53 do
            if j.Id == a1 then
                return j.Weight
            end
        end
        error(("Unknown Monster Chest reward %*"):format(a1), 2)
        return (nil).Weight
    end,
}
v2 = require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.MonsterParasite", v2, {
    MinimumRarityNumber = true,
    ChargePerFeed = true,
    MaxCharge = true,
    FeedDistance = true,
    RequestCooldown = true,
    PromptHoldDuration = true,
}, false, function(a1) -- Line: 522
    local v1 = false
    if 0 < a1.ChargePerFeed then
        v1 = false
        if 0 < a1.MaxCharge then
            v1 = 0 < a1.FeedDistance
        end
    end
    assert(v1)
end)
v3 = {}
for i, j in u53 do
    v3[j.Id] = {
        DurationSeconds = j.Metadata.DurationSeconds,
        Multiplier = j.Metadata.Multiplier,
    }
end
local u255 = ((require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.MonsterChestRewards", v3, true, false))

local function refreshRewards() -- Line: 542
    -- upvalues: u53 (val), u255 (ref), RewardIds (val), buildMonstrousEggIdsList (val)
    local v1, v2
    local v3 = nil
    local v4 = nil
    for i, j in u53, v3, v4 do
        v1 = u255[j.Id]
        j.Metadata.DurationSeconds = v1.DurationSeconds
        j.Metadata.Multiplier = v1.Multiplier
        if v1.DurationSeconds then
            v2 = v1.DurationSeconds / 60
            j.DisplayNote = ("%* Minutes"):format(v2)
            if j.Id == RewardIds.EggGrowthBoost then
                j.DisplayName = ("%*x Egg Growth"):format(v1.Multiplier)
            end
            if j.Id == RewardIds.SpeedBoost then
                j.DisplayName = ("%*x Speed"):format(v1.Multiplier)
            end
        end
        if j.Id == RewardIds.MonsterEgg then
            j.Metadata.EggIdsList = buildMonstrousEggIdsList()
        end
    end
end

refreshRewards()
require(ReplicatedStorage.Shared.Flags.BalanceConfig).Changed:Connect(refreshRewards)
return v2