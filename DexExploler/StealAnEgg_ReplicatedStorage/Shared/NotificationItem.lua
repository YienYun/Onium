-- Script path: ReplicatedStorage.Shared.NotificationItem
-- Decompile time: 4.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local Directory = require(ReplicatedStorage.Data.Currency).Directory
local Directory_2 = require(ReplicatedStorage.Data.Gears).Directory
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.string, function(a1) -- Line: 68
    return #a1 > 0
end)
local v2 = t.intersection(t.integer, t.numberPositive)
local u50 = {}
u50.Schema = t.union(
    t.strictInterface({Kind = t.literal("Currency"), Id = v1, Amount = v2}),
    t.strictInterface({Kind = t.literal("Gear"), Id = v1, Amount = v2}),
    t.strictInterface({Kind = t.literal("SpeedPower"), Amount = v2}),
    t.strictInterface({Kind = t.literal("TemporarySpeedBoost"), Amount = v2}),
    t.strictInterface({Kind = t.literal("MonsterChestReward"), Id = v1, Amount = v2}),
    t.strictInterface({Kind = t.literal("Egg"), Id = v1, Amount = v2, Mutation = t.optional(v1)})
)
local u92 = {[MonsterParasite_2.RewardIds.MonsterEgg] = "Prismatic"}
local u96 = {
    [250000] = "rbxassetid://119640363267627",
    [1000000] = "rbxassetid://119640363267627",
    [5000000] = "rbxassetid://119640363267627",
}

local function currencyIcon(a1, a2) -- Line: 123 -- upvalues: u96 (val) -- types: a2: number
    local v1 = a1.Icon or ""
    local v2 = 0
    for k, v in pairs(u96) do
        if k <= a2 and v2 < k then
            v1 = v
        end
    end
    return v1
end

function u50.Describe(a1) -- Line: 135
    -- upvalues: u50 (val), Directory (val), currencyIcon (val), Rarity (val), Directory_2 (val), Assets (val)
    -- upvalues: TreadmillUtil (val), MonsterParasite (val), u92 (val)
    local v1, v2, v3
    assert(u50.Schema(a1), "invalid notification item")
    if a1.Kind == "Currency" then
        v1 = assert(Directory[a1.Id], (("unknown currency notification id: %*"):format(a1.Id)))
        v2 = {
            Name = v1.DisplayName or "",
            Description = v1.Desc or "",
            Icon = currencyIcon(v1, a1.Amount),
        }
        local Rarity_2 = v1.Rarity or Rarity.Rarities.Rare
        v2.Rarity = Rarity_2
        return v2
    end
    if a1.Kind == "Gear" then
        v1 = assert(Directory_2[a1.Id], (("unknown gear notification id: %*"):format(a1.Id)))
        v2 = {
            Name = v1.DisplayName or "",
            Description = v1.Description or "",
            Icon = v1.Icon or "",
        }
        local Common = Rarity.Rarities[v1.Rarity] or Rarity.Rarities.Common
        v2.Rarity = Common
        return v2
    end
    if a1.Kind == "Egg" then
        v1 = assert(Assets.Directory[a1.Id], (("unknown egg notification id: %*"):format(a1.Id)))
        v2 = v1.Egg.DisplayName or ""
        v3 = {
            Description = "",
            Name = if a1.Mutation == nil then v2 else ("%* %*"):format(a1.Mutation, v2),
        }
        local Icon = if v1.Egg.Icon == "" then Assets.BaseConfig.Egg.Icon else v1.Egg.Icon
        v3.Icon = Icon
        v3.Rarity = v1.Rarity
        return v3
    end
    if a1.Kind == "TemporarySpeedBoost" then
        v1 = math.max(math.floor(a1.Amount / 60 + 0.5), 1)
        return {
            Icon = "rbxassetid://78137530993637",
            Name = ("x%* Speed Boost"):format((TreadmillUtil.GetTemporarySpeedBoostMultiplier())),
            Description = ("%* MINUTES"):format(v1),
            Rarity = Rarity.Rarities.Rare,
        }
    end
    if a1.Kind ~= "MonsterChestReward" then
        return {
            Name = "Speed Power",
            Description = "SPEED",
            Icon = "rbxassetid://78137530993637",
            Rarity = Rarity.Rarities.Rare,
        }
    end
    v1 = MonsterParasite.GetReward(a1.Id)
    local Rarity_3 = u92[a1.Id] or v1.Rarity
    v3 = {
        Name = v1.DisplayName,
        Description = v1.DisplayNote or "",
        Icon = v1.Icon or "rbxassetid://78137530993637",
    }
    local Common_2 = Rarity.Rarities[Rarity_3] or Rarity.Rarities.Common
    v3.Rarity = Common_2
    return v3
end

return u50