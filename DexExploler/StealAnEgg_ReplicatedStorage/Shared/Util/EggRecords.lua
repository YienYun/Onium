-- Script path: ReplicatedStorage.Shared.Util.EggRecords
-- Decompile time: 20.34 ms

local ServerClock = require(game:GetService("ReplicatedStorage").Shared.Util.ServerClock)
local Eggs = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).Eggs
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local Areas = require(ReplicatedStorage.Data.Areas)
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local Assets = require(ReplicatedStorage.Data.Assets)
local HalloweenPets = require(ReplicatedStorage.Data.HalloweenPets)
require(ReplicatedStorage.Shared.Util.AssetGender)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetLottery = require(ReplicatedStorage.Shared.Util.AssetLottery)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local Eggs_2 = require(ReplicatedStorage.Shared.Types.Eggs)
local EggSkins = require(ReplicatedStorage.Data.EggSkins)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local v2 = t.intersection(t.numberMin(0), t.numberMaxExclusive((1 / 0)))
local v3 = t.intersection(t.integer, t.numberMin(0))
local u131 = t.strict(t.boolean)
local u134 = t.strict(v1)
local u140 = t.strict(t.optional(v2))
local u145 = t.strict(t.optional(v3))
local u148 = t.strict(v2)
local u152 = t.strict(t.string)
local u155 = t.strict(v3)
local u161 = t.strict(t.optional(t.callback))
local u166 = t.strict(t.optional(t.number))
local u169 = t.strict(t.number)
local u172 = t.strict(t.table)
local u173 = {ScaleHardCap = Eggs.SCALE_HARD_CAP}
;(require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Changed:Connect(function() -- Line: 79 -- upvalues: u173 (val), Eggs (val)
    u173.ScaleHardCap = Eggs.SCALE_HARD_CAP
end)
local u186 = Random.new()
local u187 = {}

local function reloadGrowthBoosts() -- Line: 86 -- upvalues: u187 (ref), HttpService (val)
    local Attribute = workspace:GetAttribute("TemporaryGrowthBoosts")
    if type(Attribute) == "string" and Attribute ~= "" then
        xpcall(function() -- Line: 93 -- upvalues: u187 (upval), HttpService (upval), Attribute (val)
            HttpService:JSONDecode(Attribute)
        end, function() -- Line: 95 -- upvalues: u187 (upval)
            u187 = {}
        end)
        return
    end
end

;(workspace:GetAttributeChangedSignal("TemporaryGrowthBoosts")):Connect(reloadGrowthBoosts)
task.spawn(reloadGrowthBoosts)

local function bandBias(a1, a2) -- Line: 103 -- upvalues: u134 (val) -- types: a1: table
    local v1
    u134(if not a2 then 1 else a2(a1.min, a1.max))
    assert(v1 > 0, "A scale band bias has to be a positive multiplier")
    return v1
end

local function growthCurve(a1) -- Line: 112 -- upvalues: Eggs (val) -- types: a1: number
    if a1 <= Eggs.FLAT_GROWTH_MAX_SCALE then
        return 1
    end
    if a1 <= Eggs.STEEP_GROWTH_MAX_SCALE then
        return (a1 / Eggs.FLAT_GROWTH_MAX_SCALE) ^ Eggs.STEEP_GROWTH_POWER
    end
    return (math.min(Eggs.TAIL_GROWTH_COEFFICIENT * (a1 / Eggs.STEEP_GROWTH_MAX_SCALE) ^ Eggs.TAIL_GROWTH_POWER, Eggs.TAIL_GROWTH_CAP))
end

local function boostedSecondsFor(a1) -- Line: 128 -- upvalues: u187 (ref), ServerClock (val) -- types: a1: userdata?
    local Attribute, v1
    if type(if not a1 then nil else a1:GetAttribute("JoinTick")) ~= "number" then
        return 0
    end
    local v2 = 0
    for i, j in u187 do
        v1 = math.max(j.StartedAt, Attribute)
        v2 = v2 + math.floor(((math.min(ServerClock.Now(), j.EndsAt)) - v1) * j.Multiplier)
    end
    return v2
end

local function eggConfig(a1) -- Line: 147 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    local v2 = ("Asset catalog carries no entry named %*"):format(a1)
    assert(v1 ~= nil, v2)
    return v1
end

local function adminScaleBias() -- Line: 155 -- upvalues: AdminBoosts (val), Eggs (val)
    local u4 = AdminBoosts.ReadMultiplier(AdminBoosts.EGG_SIZE)
    if u4 <= 1 then
        return nil
    end
    return function(a1, a2) -- Line: 162 -- upvalues: Eggs (upval), u4 (val) -- types: a1: number, a2: number
        if Eggs.ADMIN_GROWS_BANDS_FROM <= a1 then
            return u4
        end
        if a2 <= Eggs.ADMIN_SHRINKS_BANDS_UNTIL then
            return 1 / u4
        end
        return 1
    end
end

local function requireSchema(a1) -- Line: 170 -- upvalues: Eggs_2 (val)
    assert(Eggs_2.SchemaValidation.SavedEgg(a1), "Saved egg failed its schema check")
end

local function copyTiming(a1) -- Line: 176
    return {
        PlacedAt = a1.PlacedAt,
        ReadyAt = a1.ReadyAt,
        GrowthDuration = a1.GrowthDuration,
        GrowthCreditSeconds = a1.GrowthCreditSeconds,
        NightGrowthPeriodIndex = a1.NightGrowthPeriodIndex,
        NightGrowthCreditSeconds = a1.NightGrowthCreditSeconds,
    }
end

local function copyIdentity(a1) -- Line: 188
    return {
        AssetCategory = a1.AssetCategory,
        AssetScale = a1.AssetScale,
        AssetEyeColor = a1.AssetEyeColor,
        AssetColorSeed = a1.AssetColorSeed,
        AssetColorIndex = a1.AssetColorIndex,
        AssetGender = a1.AssetGender,
        AssetPersonality = a1.AssetPersonality,
        BaseMutation = a1.BaseMutation,
        Mutations = if not a1.Mutations then nil else table.clone(a1.Mutations),
        IsStolenDNA = a1.IsStolenDNA,
        CreatorTemporary = a1.CreatorTemporary,
        HasParasite = a1.HasParasite,
        ParasiteRemovedForHatch = a1.ParasiteRemovedForHatch,
        MechaRerollDone = a1.MechaRerollDone,
        PurchaseId = a1.PurchaseId,
        EggSkin = a1.EggSkin,
    }
end

local function slotOf(a1) -- Line: 210
    return a1.Placement
end

local function cframeToComponents(a1) -- Line: 216 -- types: a1: userdata
    return {a1:GetComponents()}
end

local function componentsToCFrame(a1) -- Line: 220 -- types: a1: table
    return CFrame.new(table.unpack(a1, 1, 12))
end

function u173.DrawAssetScale(a1, a2) -- Line: 226
    -- upvalues: u172 (val), Eggs (val), u166 (val), u161 (val), u169 (val), u134 (val)
    local max, v1, v2, v3, weight, weight_2
    u172(Eggs.SCALE_BANDS)
    u166(Eggs.SCALE_HARD_CAP)
    u166(Eggs.SCALE_DOUBLING_ODDS)
    u161(a2)
    local v4 = a1 or Random.new()
    local v5 = 0
    for i, v in ipairs(Eggs.SCALE_BANDS) do
        u169(v.min)
        u169(v.max)
        u169(v.weight)
        max = v.max
        assert(v.min <= max, "A scale band cannot end below where it starts")
        assert(0 < v.weight, "A scale band needs a weight above zero to be reachable")
        weight_2 = v.weight
        u134(if not v1 then 1 else v1(v.min, v.max))
        assert(v2 > 0, "A scale band bias has to be a positive multiplier")
        v5 = v5 + weight_2 * v2
    end
    assert(v5 > 0, "No scale band is reachable: the weights total zero")
    local v6 = Eggs.SCALE_BANDS[1]
    local v7 = v4:NextNumber() * v5
    v5 = 0
    for i2, i3 in ipairs(Eggs.SCALE_BANDS) do
        weight = i3.weight
        u134(if not v1 then 1 else v1(i3.min, i3.max))
        assert(v3 > 0, "A scale band bias has to be a positive multiplier")
        v5 = v5 + weight * v3
        if v7 <= v5 then
            v6 = i3
            break
        end
    end
    v7 = v6.min + (v4:NextNumber()) * (v6.max - v6.min)
    while v7 * 2 <= Eggs.SCALE_HARD_CAP do
        if not ((v4:NextNumber()) <= Eggs.SCALE_DOUBLING_ODDS) then
            break
        end
        v7 = v7 * 2
    end
    return v7
end

function u173.EggModelName(a1, a2, a3, a4) -- Line: 276
    -- upvalues: u152 (val), EggSkins (val), Assets (val), Mutations (val)
    u152(a1)
    local v1 = EggSkins.Get(a4)
    if v1 ~= nil then
        return v1.ModelName
    end
    v1 = Assets.Directory[a1]
    local v2 = ("Asset catalog carries no entry named %*"):format(a1)
    assert(v1 ~= nil, v2)
    local ModelName = v1.Egg.ModelName
    if ModelName ~= nil then
        return ModelName
    end
    return Mutations.EggModelName(a2, a3) or a1
end

function u173.EggModelTemplate(a1, a2, a3, a4) -- Line: 301
    -- upvalues: u173 (val), ReplicatedStorage (val)
    local v1 = u173.EggModelName(a1, a2, a3, a4)
    local v2 = ReplicatedStorage.Assets.Models.Eggs:FindFirstChild(v1)
    local v3 = ("Egg model \"%*\" for asset %* is missing from ReplicatedStorage.Assets.Models.Eggs"):format(v1, a1)
    assert(v2 ~= nil, v3)
    assert(v2:IsA("Model"), (("Egg model \"%*\" must be a Model"):format(v1)))
    return v2
end

function u173.Normalize(a1) -- Line: 321 -- upvalues: AssetPalette (val)
    local v1 = AssetPalette.SettleFields(a1.AssetCategory, a1.AssetEyeColor, a1.AssetColorSeed, a1.AssetColorIndex)
    local v2 = table.clone(a1)
    v2.AssetEyeColor = v1.EyeColor
    v2.AssetColorSeed = v1.ColorSeed
    v2.AssetColorIndex = v1.ColorIndex
    return v2
end

function u173.EncodePlacement(a1) -- Line: 337
    return {
        PlacedAt = a1.PlacedAt,
        ReadyAt = a1.ReadyAt,
        GrowthDuration = a1.GrowthDuration,
        GrowthCreditSeconds = a1.GrowthCreditSeconds,
        NightGrowthPeriodIndex = a1.NightGrowthPeriodIndex,
        NightGrowthCreditSeconds = a1.NightGrowthCreditSeconds,
        LocalCFrame = {a1.LocalCFrame:GetComponents()},
    }
end

function u173.DecodePlacement(a1) -- Line: 345
    return {
        PlacedAt = a1.PlacedAt,
        ReadyAt = a1.ReadyAt,
        GrowthDuration = a1.GrowthDuration,
        GrowthCreditSeconds = a1.GrowthCreditSeconds,
        NightGrowthPeriodIndex = a1.NightGrowthPeriodIndex,
        NightGrowthCreditSeconds = a1.NightGrowthCreditSeconds,
        LocalCFrame = CFrame.new(table.unpack(a1.LocalCFrame, 1, 12)),
    }
end

function u173.Encode(a1) -- Line: 353 -- upvalues: u173 (val), copyIdentity (val)
    local v1 = u173.Normalize(a1)
    local v2 = copyIdentity(v1)
    local Placement = v1.Placement
    v2.Placement = if not Placement then nil else u173.EncodePlacement(Placement)
    return v2
end

function u173.Decode(a1) -- Line: 363 -- upvalues: copyIdentity (val), u173 (val)
    local v1 = copyIdentity(a1)
    local Placement = a1.Placement
    v1.Placement = if not Placement then nil else u173.DecodePlacement(Placement)
    return u173.Normalize(v1)
end

function u173.GrowthSpeedMultiplier(a1) -- Line: 372 -- upvalues: u131 (val), Eggs (val) -- types: a1: boolean
    u131(a1)
    if a1 then
        return 1 + Eggs.X2_GROWTH_BONUS
    end
    return 1
end

function u173.GrowthDuration(a1) -- Line: 378 -- upvalues: Eggs_2 (val), u134 (val), Assets (val), Eggs (val)
    assert(Eggs_2.SchemaValidation.SavedEgg(a1), "Saved egg failed its schema check")
    local v1 = assert(a1.Placement, "Growth duration is only defined for a placed egg")
    if v1.GrowthDuration ~= nil then
        return v1.GrowthDuration
    end
    u134(a1.AssetScale)
    assert(0 < a1.AssetScale, "Growth duration needs a positive asset scale")
    local AssetCategory = a1.AssetCategory
    v1 = Assets.Directory[AssetCategory]
    local v2 = ("Asset catalog carries no entry named %*"):format(AssetCategory)
    assert(v1 ~= nil, v2)
    local Egg = v1.Egg
    if Egg.IgnoreSizeGrowthMultiplier then
        return Egg.GrowthTime
    end
    local GrowthTime = Egg.GrowthTime
    local AssetScale = a1.AssetScale
    return GrowthTime * (if AssetScale <= Eggs.FLAT_GROWTH_MAX_SCALE then 1 else if not (AssetScale <= Eggs.STEEP_GROWTH_MAX_SCALE) then math.min(Eggs.TAIL_GROWTH_COEFFICIENT * (AssetScale / Eggs.STEEP_GROWTH_MAX_SCALE) ^ Eggs.TAIL_GROWTH_POWER, Eggs.TAIL_GROWTH_CAP) else (AssetScale / Eggs.FLAT_GROWTH_MAX_SCALE) ^ Eggs.STEEP_GROWTH_POWER)
end

function u173.GrowthCredit(a1) -- Line: 397 -- upvalues: u148 (val)
    local v1
    local Placement = a1.Placement
    u148(not (Placement == nil) and Placement.GrowthCreditSeconds or 0)
    return v1
end

function u173.GrowthAlpha(a1, a2, a3, a4, a5) -- Line: 406
    -- upvalues: u134 (val), u140 (val), u173 (val), boostedSecondsFor (val)
    u134(a2)
    u134(a3)
    u140(a4)
    assert(a3 > 0, "The growth speed multiplier has to be above zero")
    local Placement = a1.Placement
    if Placement == nil then
        return 0
    end
    if Placement.ReadyAt ~= nil then
        return 1
    end
    local v1 = u173.GrowthDuration(a1)
    if v1 <= 0 then
        return 1
    end
    return (math.clamp(((a2 - Placement.PlacedAt) * a3 + ((u173.GrowthCredit(a1)) + (a4 or 0) + boostedSecondsFor(a5))) / v1, 0, 1))
end

function u173.GrowthSecondsRemaining(a1, a2, a3, a4, a5) -- Line: 442
    -- upvalues: u134 (val), u140 (val), u173 (val), boostedSecondsFor (val)
    u134(a2)
    u134(a3)
    u140(a4)
    assert(a3 > 0, "The growth speed multiplier has to be above zero")
    local v1 = assert(a1.Placement, "Remaining growth is only defined for a placed egg")
    if v1.ReadyAt ~= nil then
        return 0
    end
    return (math.max(0, (u173.GrowthDuration(a1)) - (a2 - v1.PlacedAt) * a3 - ((u173.GrowthCredit(a1)) + (a4 or 0) + boostedSecondsFor(a5))))
end

function u173.WallSecondsRemaining(a1, a2, a3, a4) -- Line: 469
    -- upvalues: u173 (val)
    local v1 = u173.GrowthSecondsRemaining(a1, a2, a3, a4)
    if v1 <= 0 then
        return 0
    end
    return v1 / a3
end

function u173.IsGrown(a1, a2, a3, a4, a5) -- Line: 480
    -- upvalues: u173 (val)
    return 1 <= (u173.GrowthAlpha(a1, a2, a3, a4, a5))
end

function u173.CommittedNightCredit(a1, a2) -- Line: 490
    -- upvalues: u155 (val), u145 (val), u148 (val)
    local v1
    u155(a2)
    local Placement = a1.Placement
    if Placement == nil then
        return 0
    end
    u145(Placement.NightGrowthPeriodIndex)
    u148(not (Placement.NightGrowthPeriodIndex ~= a2) and Placement.NightGrowthCreditSeconds or 0)
    return v1
end

function u173.NightCreditAt(a1, a2, a3, a4, a5) -- Line: 510
    -- upvalues: u134 (val), u155 (val), u173 (val), AreaEggCycle (val)
    u134(a2)
    u134(a3)
    u134(a4)
    u155(a5)
    assert(a3 > 0, "The growth speed multiplier has to be above zero")
    local Placement = a1.Placement
    if Placement ~= nil and Placement.ReadyAt == nil and not (a4 < Placement.PlacedAt) then
        local v1 = u173.CommittedNightCredit(a1, a5)
        return (math.max(0, (math.min(AreaEggCycle.NightGrowthCreditAt(a2, a4), u173.GrowthSecondsRemaining(a1, a4, a3) + v1)) - v1))
    end
    return 0
end

function u173.CurrentNightCredit(a1, a2, a3) -- Line: 536
    -- upvalues: AreaEggCycle (val), u173 (val)
    if not AreaEggCycle.IsNightPhase(a2) then
        return 0
    end
    local v1 = AreaEggCycle.NightStartTime(a2)
    return u173.NightCreditAt(a1, a2, a3, v1, (AreaEggCycle.PeriodIndexAt(v1 + AreaEggCycle.NightLengthSeconds())))
end

function u173.ServerGrowthBoostMultiplier() -- Line: 548 -- upvalues: u187 (ref)
    local v1 = 0
    for i, j in u187 do
        v1 = v1 + j.Multiplier
    end
    return v1
end

function u173.ServerGrowthBoostEndsAt() -- Line: 562 -- upvalues: u187 (ref)
    local v1 = 0
    for i, j in u187 do
        v1 = math.max(v1, j.EndsAt)
    end
    return v1
end

function u173.NewEgg(a1, a2) -- Line: 573
    -- upvalues: u152 (val), u186 (val), AssetLottery (val), AdminBoosts (val), AssetPalette (val), u173 (val)
    -- upvalues: Eggs (val), Eggs_2 (val)
    u152(a1)
    local v1 = a2 or u186
    local v2 = AssetLottery.DrawMutations(
        nil,
        nil,
        v1,
        (AdminBoosts.ReadMultiplier(AdminBoosts.MUTATION_LUCK)) * AdminBoosts.ReadMultiplier(AdminBoosts.VIDEO_LUCK)
    )
    local v3 = AssetPalette.DrawFields(a1, v1)
    local DrawAssetScale = u173.DrawAssetScale
    local u38 = AdminBoosts.ReadMultiplier(AdminBoosts.EGG_SIZE)
    v1 = {
        AssetCategory = a1,
        AssetScale = DrawAssetScale(v1, if not (u38 <= 1) then function(a1, a2) -- Line: 162 -- upvalues: Eggs (upval), u38 (val) -- types: a1: number, a2: number
            if Eggs.ADMIN_GROWS_BANDS_FROM <= a1 then
                return u38
            end
            if a2 <= Eggs.ADMIN_SHRINKS_BANDS_UNTIL then
                return 1 / u38
            end
            return 1
        end else nil),
        AssetEyeColor = v3.EyeColor,
        AssetColorSeed = v3.ColorSeed,
        AssetColorIndex = v3.ColorIndex,
        Mutations = v2,
        BaseMutation = v2[1],
    }
    local v4, v5 = Eggs_2.SchemaValidation.SavedEgg(v1)
    assert(v4, v5)
    return v1
end

function u173.ToAssetItemData(a1) -- Line: 603 -- upvalues: Eggs_2 (val), Personalities (val)
    assert(Eggs_2.SchemaValidation.SavedEgg(a1), "Saved egg failed its schema check")
    local v1 = {
        Category = a1.AssetCategory,
        Scale = a1.AssetScale,
        EyeColor = a1.AssetEyeColor,
        ColorSeed = a1.AssetColorSeed,
        ColorIndex = a1.AssetColorIndex,
    }
    local Mutations = a1.Mutations or {}
    v1.Mutations = Mutations
    v1.BaseMutation = a1.BaseMutation
    v1.Gender = a1.AssetGender
    v1.Personality = a1.AssetPersonality
    v1.IsStolenDNA = a1.IsStolenDNA
    v1.CreatorTemporary = a1.CreatorTemporary
    return (Personalities.CreateNewItemData(v1))
end

function u173.SellPrice(a1) -- Line: 624 -- upvalues: Eggs_2 (val), u173 (val), AssetItems (val), Eggs (val)
    assert(Eggs_2.SchemaValidation.SavedEgg(a1), "Saved egg failed its schema check")
    local v1 = table.clone(u173.ToAssetItemData(a1))
    v1.Mutations = {}
    v1.BaseMutation = nil
    return (AssetItems.SalePrice(v1)) * Eggs.SELL_PRICE_SHARE
end

function u173.WeightKgForScale(a1, a2) -- Line: 635
    -- upvalues: u152 (val), u134 (val), AssetItems (val)
    u152(a1)
    u134(a2)
    return AssetItems.WeightKg({Category = a1, Scale = a2, Mutations = {}})
end

function u173.WeightKg(a1) -- Line: 644 -- upvalues: Eggs_2 (val), u173 (val)
    assert(Eggs_2.SchemaValidation.SavedEgg(a1), "Saved egg failed its schema check")
    return u173.WeightKgForScale(a1.AssetCategory, a1.AssetScale)
end

function u173.WeightLabel(a1) -- Line: 650 -- upvalues: AddCommas (val), u173 (val)
    return (("%*Kg"):format((AddCommas((u173.WeightKg(a1))))))
end

function u173.EggIcon(a1) -- Line: 655 -- upvalues: EggSkins (val), Mutations (val), Assets (val)
    local v1 = EggSkins.Get(a1.EggSkin)
    if v1 ~= nil then
        return v1.Icon
    end
    local Icon = Mutations.EggIcon(a1.Mutations, a1.BaseMutation)
    if not Icon then
        local AssetCategory = a1.AssetCategory
        local v2 = Assets.Directory[AssetCategory]
        local v3 = ("Asset catalog carries no entry named %*"):format(AssetCategory)
        assert(v2 ~= nil, v3)
        Icon = v2.Egg.Icon
    end
    return Icon
end

function u173.DisplayName(a1) -- Line: 668
    -- upvalues: Eggs_2 (val), EggSkins (val), Mutations (val), HalloweenPets (val), Assets (val), Areas (val)
    local v1
    assert(Eggs_2.SchemaValidation.SavedEgg(a1), "Saved egg failed its schema check")
    local v2 = EggSkins.Get(a1.EggSkin)
    if v2 ~= nil then
        return v2.DisplayName
    end
    v2 = Mutations.EggDisplayName(a1.Mutations, a1.BaseMutation)
    if v2 then
        return v2
    end
    if HalloweenPets.Specs[a1.AssetCategory] then
        return Assets.Directory[a1.AssetCategory].Egg.DisplayName
    end
    local AssetCategory = a1.AssetCategory
    v2 = Assets.Directory[AssetCategory]
    local v3 = ("Asset catalog carries no entry named %*"):format(AssetCategory)
    assert(v2 ~= nil, v3)
    local _id = v2.Rarity._id
    for k, v in pairs(Areas.Directory) do
        for i, i2 in ipairs(v.DropTable) do
            v1 = i2[1]
            if v1 ~= v4.AssetCategory and v1 ~= _id then
                continue
            end
            return (("%* Egg"):format(v.DisplayName))
        end
    end
    return "Egg"
end

function u173.DisplayNameWithWeight(a1) -- Line: 702 -- upvalues: u173 (val)
    return (("%* (%*)"):format(u173.DisplayName(a1), (u173.WeightLabel(a1))))
end

return u173