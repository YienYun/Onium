-- Script path: ReplicatedStorage.Shared.Types.Eggs
-- Decompile time: 3.57 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.AssetItem)
require(ReplicatedStorage.Data.Assets)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {MAX_INVENTORY = 115, HATCH_RESULT_MECHA_UPGRADED = "MechaUpgraded"}
local v2 = t.interface({
    LocalCFrame = t.CFrame,
    PlacedAt = t.number,
    GrowthDuration = t.optional(t.number),
    GrowthCreditSeconds = t.optional(t.number),
    NightGrowthPeriodIndex = t.optional(t.number),
    NightGrowthCreditSeconds = t.optional(t.number),
    ReadyAt = t.optional(t.number),
})
local v3 = t.interface({
    LocalCFrame = t.array(t.number),
    PlacedAt = t.number,
    GrowthDuration = t.optional(t.number),
    GrowthCreditSeconds = t.optional(t.number),
    NightGrowthPeriodIndex = t.optional(t.number),
    NightGrowthCreditSeconds = t.optional(t.number),
    ReadyAt = t.optional(t.number),
})
local v4 = t.interface({
    AssetCategory = t.string,
    AssetScale = t.number,
    AssetEyeColor = t.string,
    AssetColorSeed = t.number,
    AssetColorIndex = t.number,
    Mutations = t.optional(t.array(t.string)),
    BaseMutation = t.optional(t.string),
    AssetGender = t.optional(t.union(t.literal("Male"), t.literal("Female"))),
    AssetPersonality = t.optional(t.string),
    IsStolenDNA = t.optional(t.boolean),
    CreatorTemporary = t.optional(t.boolean),
    HasParasite = t.optional(t.boolean),
    ParasiteRemovedForHatch = t.optional(t.boolean),
    MechaRerollDone = t.optional(t.boolean),
    PurchaseId = t.optional(t.string),
    EggSkin = t.optional(t.string),
    Placement = t.optional(v2),
})
local v5 = t.interface({
    AssetCategory = t.string,
    AssetScale = t.number,
    AssetEyeColor = t.string,
    AssetColorSeed = t.number,
    AssetColorIndex = t.number,
    Mutations = t.optional(t.array(t.string)),
    BaseMutation = t.optional(t.string),
    AssetGender = t.optional(t.union(t.literal("Male"), t.literal("Female"))),
    AssetPersonality = t.optional(t.string),
    IsStolenDNA = t.optional(t.boolean),
    CreatorTemporary = t.optional(t.boolean),
    HasParasite = t.optional(t.boolean),
    ParasiteRemovedForHatch = t.optional(t.boolean),
    MechaRerollDone = t.optional(t.boolean),
    PurchaseId = t.optional(t.string),
    EggSkin = t.optional(t.string),
    Placement = t.optional(v3),
})
local v6 = t.interface({
    AssetCategory = t.string,
    AssetScale = t.number,
    AssetEyeColor = t.string,
    AssetColorSeed = t.number,
    AssetColorIndex = t.number,
    Mutations = t.optional(t.array(t.string)),
    BaseMutation = t.optional(t.string),
    AssetGender = t.optional(t.union(t.literal("Male"), t.literal("Female"))),
    AssetPersonality = t.optional(t.string),
    IsStolenDNA = t.optional(t.boolean),
    CreatorTemporary = t.optional(t.boolean),
    HasParasite = t.optional(t.boolean),
    ParasiteRemovedForHatch = t.optional(t.boolean),
    MechaRerollDone = t.optional(t.boolean),
    PurchaseId = t.optional(t.string),
    EggSkin = t.optional(t.string),
    Placement = t.optional(v2),
    GrowthSpeedMultiplier = t.number,
})
v1.SchemaValidation = {
    EggPlacement = v2,
    EggInventory = t.map(t.string, v5),
    PlaceEggRequest = t.interface({Uid = t.string, LocalCFrame = t.CFrame}),
    RuntimeEggOwnerClear = t.interface({OwnerUserId = t.number}),
    RuntimeEggOwnerUpdate = t.interface({OwnerUserId = t.number, Records = t.map(t.string, v6)}),
    RuntimeEggSnapshot = t.array(t.interface({OwnerUserId = t.number, Records = t.map(t.string, v6)})),
    RuntimeEggRecord = v6,
    SavedEgg = v4,
    SerializedEggPlacement = v3,
    SerializedSavedEgg = v5,
}
return v1