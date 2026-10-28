-- Script path: ReplicatedStorage.Shared.Util.MonetizationEntitlements
-- Decompile time: 9.90 ms

local GamepassBenefits = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GamepassBenefits
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
require(ReplicatedStorage.Shared.Types.Monetization)
local Marketplace = require(ReplicatedStorage.Shared.Utils.Marketplace)
local Products = require(ReplicatedStorage.Data.Products)
local Price = Marketplace.Price
local t = require(ReplicatedStorage.Packages.t)
local X2Money = Gamepasses.Directory.X2Money
local X2Growth = Gamepasses.Directory.X2Growth
local Lucky = Gamepasses.Directory.Lucky
local u49 = table.freeze({[X2Money.Name] = true})
local u54 = table.freeze({[Lucky.Name] = true})
local u61 = table.freeze({[X2Money.Name] = true, [Lucky.Name] = true})
local u64 = t.strict(t.number)
local u69 = t.strict(t.instanceIsA("Player"))
local u72 = t.strict(t.string)
local u73 = {}
u73.PROFILES = table.freeze({NON_SPENDER = "NonSpender", AVATAR_VALUE_ONLY = "AvatarValueOnly", SPENT_ROBUX = "SpentRobux"})

local function wholeRobux(a1) -- Line: 52 -- types: a1: number?
    if typeof(a1) == "number" then
        return (math.max(math.floor(a1), 0))
    end
    return 0
end

local function countedAttribute(a1, a2) -- Line: 56 -- upvalues: u69 (val) -- types: a1: userdata, a2: string
    u69(a1)
    local Attribute = a1:GetAttribute(a2)
    local v1 = if typeof(Attribute) ~= "number" then nil else Attribute
    if typeof(v1) == "number" then
        return (math.max(math.floor(v1), 0))
    end
    return 0
end

local function switchedAttribute(a1, a2) -- Line: 64
    -- upvalues: u69 (val), u72 (val)
    u69(a1)
    u72(a2)
    return a1:GetAttribute(a2) == true
end

local function passHeld(a1, a2) -- Line: 71 -- types: a2: string
    local v1 = false
    if typeof(a1) == "table" then
        v1 = a1[a2] == true
    end
    return v1
end

local function productHeld(a1, a2) -- Line: 75 -- types: a2: number
    local v1 = false
    if typeof(a1) == "table" then
        v1 = a1[tostring(a2)] == true
    end
    return v1
end

function u73.NormalizeRobuxSpend(a1) -- Line: 79 -- types: a1: number?
    if typeof(a1) == "number" then
        return (math.max(math.floor(a1), 0))
    end
    return 0
end

function u73.ProductPrice(a1) -- Line: 83 -- upvalues: u64 (val), Price (val) -- types: a1: number
    u64(a1)
    local v1 = Price(a1, Enum.InfoType.Product)
    if v1 == nil then
        return 0
    end
    if typeof(v1) == "number" then
        return (math.max(math.floor(v1), 0))
    end
    return 0
end

function u73.GamepassPrice(a1) -- Line: 91 -- upvalues: u64 (val), Price (val) -- types: a1: number
    u64(a1)
    local v1 = Price(a1, Enum.InfoType.GamePass)
    if v1 == nil then
        return 0
    end
    if typeof(v1) == "number" then
        return (math.max(math.floor(v1), 0))
    end
    return 0
end

function u73.MarketplacePrice(a1, a2) -- Line: 99 -- upvalues: u64 (val), Marketplace (val) -- types: a1: number
    u64(a1)
    local v1 = Marketplace.Current(a1, a2)
    if typeof(v1) ~= "table" then
        return 0
    end
    local PriceInRobux = v1.PriceInRobux
    if typeof(PriceInRobux) == "number" then
        return (math.max(math.floor(PriceInRobux), 0))
    end
    return 0
end

function u73.AvatarAssetPrice(a1) -- Line: 107 -- upvalues: u73 (val) -- types: a1: number
    return u73.MarketplacePrice(a1, Enum.InfoType.Asset)
end

function u73.AvatarBundlePrice(a1) -- Line: 111 -- upvalues: u73 (val) -- types: a1: number
    return u73.MarketplacePrice(a1, Enum.InfoType.Bundle)
end

function u73.HasX2Money(a1) -- Line: 115 -- upvalues: X2Money (val)
    local v1 = false
    if typeof(a1) == "table" then
        v1 = a1[X2Money.Name] == true
    end
    return v1
end

function u73.HasX2Growth(a1) -- Line: 119 -- upvalues: X2Growth (val)
    local v1 = false
    if typeof(a1) == "table" then
        v1 = a1[X2Growth.Name] == true
    end
    return v1
end

function u73.HasLucky(a1) -- Line: 123 -- upvalues: Lucky (val)
    local v1 = false
    if typeof(a1) == "table" then
        v1 = a1[Lucky.Name] == true
    end
    return v1
end

function u73.HasVipProduct(a1) -- Line: 129
    return false
end

function u73.PlayerHasX2Money(a1) -- Line: 133 -- upvalues: u69 (val), u72 (val) -- types: a1: userdata
    u69(a1)
    u72("MonetizationX2MoneyGamepassOwned")
    return a1:GetAttribute("MonetizationX2MoneyGamepassOwned") == true
end

function u73.PlayerHasLucky(a1) -- Line: 137 -- upvalues: u69 (val), u72 (val) -- types: a1: userdata
    u69(a1)
    u72("MonetizationLuckyGamepassOwned")
    return a1:GetAttribute("MonetizationLuckyGamepassOwned") == true
end

function u73.PlayerHasVipProduct(a1) -- Line: 141 -- types: a1: userdata
    return false
end

function u73.SumOwnedRobuxSpend(a1, a2, a3) -- Line: 145
    -- upvalues: Gamepasses (val), u73 (val), Products (val)
    local v1
    local v2 = 0
    if typeof(a1) == "table" then
        local v3 = a1
        for k, v in pairs(Gamepasses.Directory) do
            if not a3 or not a3[("Pass:%*"):format(v.Name)] then
                v1 = false
                if typeof(v3) == "table" then
                    v1 = v3[v.Name] == true
                end
                v2 = v2 + (if not v1 then 0 else u73.GamepassPrice(v.ProductId))
            end
        end
    end
    if typeof(a2) == "table" then
        for k2, i in pairs(Products.Directory) do
            if not a3 or not a3[("Product:%*"):format(i.ProductId)] then
                v1 = false
                if typeof(a2) == "table" then
                    v1 = a2[tostring(i.ProductId)] == true
                end
                v2 = v2 + (if not v1 then 0 else u73.ProductPrice(i.ProductId))
            end
        end
    end
    return v2
end

function u73.EffectiveRobuxSpend(a1, a2, a3, a4) -- Line: 179 -- upvalues: u73 (val) -- types: a3: number?, a4: table?
    local v1 = if typeof(a3) ~= "number" then 0 else math.max(math.floor(a3), 0)
    if v1 > 0 then
        return v1
    end
    return (u73.SumOwnedRobuxSpend(a1, a2, a4))
end

function u73.IsSpender(a1) -- Line: 192 -- types: a1: number?
    return (if typeof(a1) ~= "number" then 0 else math.max(math.floor(a1), 0)) > 0
end

function u73.PlayerRobuxSpend(a1) -- Line: 196 -- upvalues: u69 (val) -- types: a1: userdata
    u69(a1)
    local Attribute = a1:GetAttribute("MonetizationRobuxSpentTotal")
    local v1 = if typeof(Attribute) ~= "number" then nil else Attribute
    if typeof(v1) == "number" then
        return (math.max(math.floor(v1), 0))
    end
    return 0
end

function u73.IsPlayerSpender(a1) -- Line: 200 -- upvalues: u73 (val) -- types: a1: userdata
    return 0 < (u73.PlayerRobuxSpend(a1))
end

function u73.PlayerAvatarValue(a1) -- Line: 204 -- upvalues: u69 (val) -- types: a1: userdata
    u69(a1)
    local Attribute = a1:GetAttribute("MonetizationAvatarMarketplaceValue")
    local v1 = if typeof(Attribute) ~= "number" then nil else Attribute
    if typeof(v1) == "number" then
        return (math.max(math.floor(v1), 0))
    end
    return 0
end

function u73.PlayerHasAvatarValue(a1) -- Line: 208 -- upvalues: u73 (val) -- types: a1: userdata
    return 0 < (u73.PlayerAvatarValue(a1))
end

function u73.SyncPlayerFlags(a1, a2, a3, a4, a5) -- Line: 212
    -- upvalues: u69 (val), X2Money (val), Lucky (val), u73 (val)
    u69(a1)
    local v1 = false
    if typeof(a2) == "table" then
        v1 = a2[X2Money.Name] == true
    end
    a1:SetAttribute("MonetizationX2MoneyGamepassOwned", v1)
    v1 = false
    if typeof(a2) == "table" then
        v1 = a2[Lucky.Name] == true
    end
    a1:SetAttribute("MonetizationLuckyGamepassOwned", v1)
    a1:SetAttribute("MonetizationRobuxSpentTotal", (u73.EffectiveRobuxSpend(a2, a3, a4, a5)))
end

function u73.SyncPlayerAvatarValue(a1, a2) -- Line: 229 -- upvalues: u69 (val) -- types: a1: userdata, a2: number?
    u69(a1)
    a1:SetAttribute("MonetizationAvatarMarketplaceValue", if typeof(a2) ~= "number" then 0 else math.max(math.floor(a2), 0))
end

function u73.ProfileFor(a1, a2) -- Line: 235 -- upvalues: u73 (val) -- types: a1: number?, a2: number?
    local PROFILES = u73.PROFILES
    if (if typeof(a2) ~= "number" then 0 else math.max(math.floor(a2), 0)) > 0 then
        return PROFILES.SPENT_ROBUX
    end
    if (if typeof(a1) ~= "number" then 0 else math.max(math.floor(a1), 0)) > 0 then
        return PROFILES.AVATAR_VALUE_ONLY
    end
    return PROFILES.NON_SPENDER
end

function u73.PlayerProfile(a1) -- Line: 244 -- upvalues: u69 (val), u73 (val) -- types: a1: userdata
    u69(a1)
    return u73.ProfileFor(u73.PlayerAvatarValue(a1), u73.PlayerRobuxSpend(a1))
end

function u73.PlayerMayTakeBackSteal(a1) -- Line: 252 -- upvalues: u73 (val) -- types: a1: userdata
    return (u73.PlayerProfile(a1)) ~= u73.PROFILES.NON_SPENDER
end

function u73.AssetMoneyAdditiveBonus(a1, a2) -- Line: 256 -- upvalues: u73 (val), GamepassBenefits (val)
    if u73.HasX2Money(a1) then
        return GamepassBenefits.X2_MONEY_BONUS
    end
    return 0
end

function u73.PlayerAssetMoneyAdditiveBonus(a1) -- Line: 260
    -- upvalues: u73 (val), GamepassBenefits (val)
    if u73.PlayerHasX2Money(a1) then
        return GamepassBenefits.X2_MONEY_BONUS
    end
    return 0
end

function u73.GameplayBlockLuckPercent(a1) -- Line: 264 -- upvalues: u73 (val), GamepassBenefits (val)
    if u73.HasLucky(a1) then
        return GamepassBenefits.LUCKY_BLOCK_LUCK_PERCENT
    end
    return 0
end

function u73.PlayerGameplayBlockLuckPercent(a1) -- Line: 268
    -- upvalues: u73 (val), GamepassBenefits (val)
    if u73.PlayerHasLucky(a1) then
        return GamepassBenefits.LUCKY_BLOCK_LUCK_PERCENT
    end
    return 0
end

function u73.FuseRarestWeightMultiplier(a1) -- Line: 272 -- upvalues: u73 (val), GamepassBenefits (val)
    if u73.HasLucky(a1) then
        return GamepassBenefits.LUCKY_FUSE_WEIGHT_BOOST
    end
    return 1
end

function u73.PlayerFuseRarestWeightMultiplier(a1) -- Line: 276
    -- upvalues: u73 (val), GamepassBenefits (val)
    if u73.PlayerHasLucky(a1) then
        return GamepassBenefits.LUCKY_FUSE_WEIGHT_BOOST
    end
    return 1
end

function u73.OwnedGamepassesForPlayer(a1) -- Line: 280
    -- upvalues: u69 (val), u73 (val), u61 (val), u49 (val), u54 (val)
    u69(a1)
    local v1 = u73.PlayerHasX2Money(a1)
    local v2 = u73.PlayerHasLucky(a1)
    if v1 and v2 then
        return u61
    end
    if v1 then
        return u49
    end
    if v2 then
        return u54
    end
    return nil
end

function u73.OwnedProductsForPlayer(a1) -- Line: 293 -- upvalues: u69 (val) -- types: a1: userdata
    u69(a1)
    return nil
end

return u73