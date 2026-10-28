-- Script path: ReplicatedStorage.Shared.Util.FuseKernel
-- Decompile time: 4.08 ms

local Fusion = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).Fusion
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local u50 = t.strict(t.boolean)
local u53 = t.strict(v1)
local u59 = t.strict(t.optional(t.string))
local u62 = t.strict(t.string)
local u65 = t.strict(t.table)
local u66 = {}

local function averageOf(a1) -- Line: 32 -- upvalues: u65 (val), Fusion (val), u53 (val) -- types: a1: table
    u65(a1)
    assert(#a1 == Fusion.INPUT_COUNT, (("A fuse consumes exactly %* pets"):format(Fusion.INPUT_COUNT)))
    local v1 = 0
    for i, v in ipairs(a1) do
        u53(v)
        assert(v > 0, "Every fuse input needs a positive scale")
        v1 = v1 + v
    end
    return v1 / Fusion.INPUT_COUNT
end

local function refusalFor(a1, a2, a3, a4) -- Line: 51
    -- upvalues: Assets (val)
    if a4 ~= nil and a1.CreatorTemporary == true ~= a4 then
        if a4 then
            return "This fuse only takes temporary creator pets"
        end
        return "Temporary creator pets cannot be fused with permanent ones"
    end
    local v1 = Assets.Directory[a1.Category]
    if v1 ~= nil and v1.CannotFuse ~= true then
        if a1.IsFavorite == true then
            return "Favorite pets cannot be fused"
        end
        if a3 ~= (a1.InFuse == true) then
            if a3 then
                return "That pet is not in this fuse machine"
            end
            return "That pet is already in a fuse machine"
        end
        if a2 ~= nil and a1.Category ~= a2 then
            return "All pets must be the same category"
        end
        return nil
    end
    return "That pet cannot be fused"
end

function u66.MayEnterFuse(a1, a2, a3, a4, a5) -- Line: 92
    -- upvalues: u62 (val), AssetItem (val), u59 (val), u50 (val), refusalFor (val)
    u62(a1)
    assert((AssetItem.SerializedAssetItemData(a2)))
    u59(a3)
    u50(a4)
    local v1 = refusalFor(a2, a3, a4, a5)
    return v1 == nil, v1
end

function u66.MayEnterRift(a1, a2) -- Line: 109
    -- upvalues: u62 (val), AssetItem (val), Assets (val)
    u62(a1)
    assert((AssetItem.SerializedAssetItemData(a2)))
    if Assets.Directory[a2.Category] == nil then
        return false, "That pet cannot be offered"
    end
    if a2.IsFavorite == true then
        return false, "Favorite pets cannot be offered"
    end
    if a2.InFuse == true then
        return false, "That pet is in a fuse machine"
    end
    return true, nil
end

function u66.BandWeightBias(a1, a2, a3) -- Line: 133
    -- upvalues: u53 (val), averageOf (val), Fusion (val)
    u53(a2)
    u53(a3)
    assert(a2 > 0, "A scale band cannot start at or below zero")
    assert(a2 <= a3, "A scale band cannot end below where it starts")
    return (math.exp(math.log((averageOf(a1))) / 0.6931471805599453 * ((math.log((a2 + a3) / 2)) / 0.6931471805599453) * Fusion.BIAS_STRENGTH))
end

function u66.DrawFusedScale(a1, a2) -- Line: 145
    -- upvalues: averageOf (val), EggRecords (val), u66 (val)
    averageOf(a1)
    return EggRecords.DrawAssetScale(a2, function(a1_2, a2) -- Line: 148 -- upvalues: u66 (upval), a1 (val) -- types: a1_2: number, a2: number
        return u66.BandWeightBias(a1, a1_2, a2)
    end)
end

function u66.PriceFor(a1) -- Line: 153
    -- upvalues: AssetItem (val), Fusion (val), AssetEarnings (val)
    assert((AssetItem.AssetItemDataArray(a1)))
    assert(#a1 == Fusion.INPUT_COUNT, (("Pricing a fuse needs exactly %* pets"):format(Fusion.INPUT_COUNT)))
    local v1 = Fusion.PRICED_MINUTES_OF_INCOME * 60
    local v2 = 0
    local v3 = 0
    for i, v in ipairs(a1) do
        v2 = v2 + AssetEarnings.RatePerSecond(v) * v1
        v3 = math.max(v3, #v.Mutations)
    end
    local ONE_MUTATION_SURCHARGE = 1
    if v3 == 1 then
        ONE_MUTATION_SURCHARGE = Fusion.ONE_MUTATION_SURCHARGE
    elseif v3 >= 2 then
        ONE_MUTATION_SURCHARGE = Fusion.MANY_MUTATION_SURCHARGE
    end
    return (math.floor((math.floor(v2)) * ONE_MUTATION_SURCHARGE))
end

return u66