-- Script path: ReplicatedStorage.Shared.Util.AssetItems
-- Decompile time: 5.18 ms

local SellRewards = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).SellRewards
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetGender = require(ReplicatedStorage.Shared.Util.AssetGender)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local t = require(ReplicatedStorage.Packages.t)
local u58 = t.strict(t.string)
local u59 = {}

local function catalogEntry(a1) -- Line: 31 -- upvalues: Assets (val) -- types: a1: string
    return Assets.Directory[a1]
end

local function isNamedMutation(a1) -- Line: 35
    if typeof(a1) ~= "string" then
        return false
    end
    local v1 = false
    if a1 ~= "" then
        v1 = a1 ~= "None"
    end
    return v1
end

local function settled(a1) -- Line: 45 -- upvalues: AssetPalette (val), AssetGender (val)
    local v1, v2
    local v3 = {}
    local v4 = a1
    for i, v in ipairs(a1.Mutations) do
        if typeof(v) == "string" then
            v2 = false
            if v ~= "" then
                v2 = v ~= "None"
            end
        else
            v2 = false
        end
        if v2 then
            table.insert(v3, v)
        end
    end
    local v5 = AssetPalette.SettleFields(v4.Category, v4.EyeColor, v4.ColorSeed, v4.ColorIndex)
    local v6 = if AssetGender.Settle(v4.Category, v4.Gender) ~= "Male" then "Female" else "Male"
    local v7 = {Category = v4.Category, Mutations = v3}
    local BaseMutation = v4.BaseMutation
    if typeof(BaseMutation) == "string" then
        v1 = false
        if BaseMutation ~= "" then
            v1 = BaseMutation ~= "None"
        end
    else
        v1 = false
    end
    local BaseMutation_2 = if not v1 then v3[1] else v4.BaseMutation
    v7.BaseMutation = BaseMutation_2
    v7.Scale = v4.Scale
    v7.Gender = v6
    v7.EyeColor = v5.EyeColor
    v7.ColorSeed = v5.ColorSeed
    v7.ColorIndex = v5.ColorIndex
    v7.IsFavorite = v4.IsFavorite
    v7.GeneratedMoney = v4.GeneratedMoney
    v7.LastTick = v4.LastTick
    v7.PendingEggName = v4.PendingEggName
    v7.Claimed = v4.Claimed
    v7.LuckyBlockUnlockTimestamp = v4.LuckyBlockUnlockTimestamp
    v7.LuckyBlockUnlockDuration = v4.LuckyBlockUnlockDuration
    v7.LuckyBlockInstantUnlock = v4.LuckyBlockInstantUnlock
    v7.InFuse = v4.InFuse or false
    v7.Rideable = v4.Rideable
    v7.SpecialLuckyBlockColumn = v4.SpecialLuckyBlockColumn
    v7.SpecialLuckyBlockCapturedAt = v4.SpecialLuckyBlockCapturedAt
    v7.Personality = v4.Personality
    v7.HasBeenFirstPlaced = v4.HasBeenFirstPlaced
    v7.IsStolenDNA = v4.IsStolenDNA
    v7.CreatorTemporary = v4.CreatorTemporary
    return v7
end

function u59.Encode(a1) -- Line: 94 -- upvalues: settled (val)
    return (settled(a1))
end

function u59.Decode(a1) -- Line: 98 -- upvalues: settled (val)
    return (settled(a1))
end

function u59.WeightKg(a1) -- Line: 102 -- upvalues: AssetItem (val), Assets (val), SellRewards (val)
    assert((AssetItem.AssetItemData(a1)))
    return Assets.Directory[a1.Category].ModelWeight * (math.max(a1.Scale, 0)) ^ SellRewards.WEIGHT_SCALE_POWER
end

function u59.WeightLabel(a1) -- Line: 110 -- upvalues: u59 (val), AddCommas (val)
    return (("%*Kg"):format((AddCommas((math.max((math.round((u59.WeightKg(a1)) * 100)) / 100, 0))))))
end

function u59.SalePrice(a1) -- Line: 117 -- upvalues: AssetItem (val), AssetEarnings (val), SellRewards (val)
    assert((AssetItem.AssetItemData(a1)))
    return (AssetEarnings.RatePerSecond(a1)) * SellRewards.SALE_SECONDS_OF_INCOME
end

function u59.IndexMoneyReward(a1) -- Line: 123
    -- upvalues: Personalities (val), AssetEarnings (val), SellRewards (val)
    return (math.round((AssetEarnings.MutationOnlyRatePerSecond({
        Scale = 1,
        HasBeenFirstPlaced = true,
        Category = a1,
        Mutations = {},
        Personality = Personalities.Personalities.Normal,
    })) * SellRewards.INDEX_REWARD_SECONDS))
end

function u59.IndexSpeedReward(a1) -- Line: 137 -- upvalues: Assets (val) -- types: a1: string
    return Assets.Directory[a1].IndexSpeedReward
end

function u59.RarityRankForCategory(a1) -- Line: 142 -- upvalues: u58 (val), Assets (val) -- types: a1: string
    u58(a1)
    local v1 = Assets.Directory[a1]
    local v2 = ("Asset catalog has no entry named %*"):format(a1)
    assert(v1 ~= nil, v2)
    return v1.Rarity.Rank
end

function u59.ProfileIncomePerSecond(a1, a2, a3) -- Line: 154
    -- upvalues: settled (val), AssetEarnings (val)
    local Inventory = a2.Inventory
    local EquippedAssets = a2.EquippedAssets
    if typeof(Inventory) == "table" and typeof(EquippedAssets) == "table" then
        local v1, v2, v3
        local Gamepasses_2 = if typeof(a2.Gamepasses) ~= "table" then nil else a2.Gamepasses
        local Products_2 = if typeof(a2.Products) ~= "table" then nil else a2.Products
        local v4 = 0
        local v5, v6 = a3, a1
        for i, v in ipairs(EquippedAssets) do
            v1 = Inventory[v]
            if typeof(v1) == "table" then
                v2 = settled(v1)
                v3 = if not v5 then AssetEarnings.LiveRatePerSecond(v2, Gamepasses_2, Products_2, v6) else AssetEarnings.RatePerSecond(v2, Gamepasses_2, Products_2)
                v4 = v4 + math.max(v3, 0)
            end
        end
        return v4
    end
    return 0
end

return u59