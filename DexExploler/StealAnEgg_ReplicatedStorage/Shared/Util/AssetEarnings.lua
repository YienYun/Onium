-- Script path: ReplicatedStorage.Shared.Util.AssetEarnings
-- Decompile time: 3.30 ms

local Earnings = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).Earnings
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
require(ReplicatedStorage.Shared.Types.Monetization)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local PlayerEarningsBoost = require(ReplicatedStorage.Shared.Util.PlayerEarningsBoost)
local t = require(ReplicatedStorage.Packages.t)
local u65 = t.strict((t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))))
local v1 = {}

local function scalePayoutFactor(a1) -- Line: 32 -- upvalues: u65 (val), Earnings (val) -- types: a1: number
    u65(a1)
    assert(a1 > 0, "Payout factor is undefined for a non-positive asset scale")
    if a1 <= Earnings.TAPER_KNEE_SCALE then
        return a1 ^ Earnings.STEEP_SCALE_POWER
    end
    return Earnings.TAPER_KNEE_SCALE ^ Earnings.STEEP_SCALE_POWER * (a1 / Earnings.TAPER_KNEE_SCALE) ^ Earnings.TAPERED_SCALE_POWER
end

local function catalogEarningRate(a1) -- Line: 45 -- upvalues: Assets (val)
    local v1 = Assets.Directory[a1.Category]
    return v1 and tonumber(v1.EarningRate) or 0
end

local function entitledRate(a1, a2, a3) -- Line: 51
    -- upvalues: AssetItem (val), Assets (val), u65 (val), Earnings (val), Mutations (val)
    -- upvalues: MonetizationEntitlements (val)
    assert((AssetItem.AssetItemData(a1)))
    local v1 = Assets.Directory[a1.Category]
    local v2 = v1 and tonumber(v1.EarningRate) or 0
    local Scale = a1.Scale
    u65(Scale)
    assert(Scale > 0, "Payout factor is undefined for a non-positive asset scale")
    return (math.max(
        math.round(v2 * (if not (Scale <= Earnings.TAPER_KNEE_SCALE) then Earnings.TAPER_KNEE_SCALE ^ Earnings.STEEP_SCALE_POWER * (Scale / Earnings.TAPER_KNEE_SCALE) ^ Earnings.TAPERED_SCALE_POWER else Scale ^ Earnings.STEEP_SCALE_POWER) * (Mutations.EarningsFor(a1.Mutations)) * (1 + (MonetizationEntitlements.AssetMoneyAdditiveBonus(a2, a3)))),
        Earnings.MINIMUM_RATE
    ))
end

function v1.RatePerSecond(a1, a2, a3) -- Line: 69 -- upvalues: AssetItem (val), entitledRate (val)
    assert((AssetItem.AssetItemData(a1)))
    return (entitledRate(a1, a2, a3))
end

function v1.LiveRatePerSecond(a1, a2, a3, a4) -- Line: 80
    -- upvalues: entitledRate (val), AdminBoosts (val), PlayerEarningsBoost (val)
    return (math.round(entitledRate(a1, a2, a3) * AdminBoosts.ReadMultiplier(AdminBoosts.EARNINGS) * (PlayerEarningsBoost.GetMultiplier(a4))))
end

function v1.MutationOnlyRatePerSecond(a1) -- Line: 95 -- upvalues: AssetItem (val), entitledRate (val)
    assert((AssetItem.AssetItemData(a1)))
    return (entitledRate(a1))
end

function v1.CatalogRatePerSecond(a1) -- Line: 101 -- upvalues: AssetItem (val), Assets (val), u65 (val), Earnings (val)
    assert((AssetItem.AssetItemData(a1)))
    local v1 = Assets.Directory[a1.Category]
    local v2 = v1 and tonumber(v1.EarningRate) or 0
    local Scale = a1.Scale
    u65(Scale)
    assert(Scale > 0, "Payout factor is undefined for a non-positive asset scale")
    v1 = if not (Scale <= Earnings.TAPER_KNEE_SCALE) then Earnings.TAPER_KNEE_SCALE ^ Earnings.STEEP_SCALE_POWER * (Scale / Earnings.TAPER_KNEE_SCALE) ^ Earnings.TAPERED_SCALE_POWER else Scale ^ Earnings.STEEP_SCALE_POWER
    return v2 * v1
end

return v1