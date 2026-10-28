-- Script path: ReplicatedStorage.Data.Assets.Configs.Banjo Firefly
-- Decompile time: 1.13 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
local Rarity = require(ReplicatedStorage.Data.Rarity)
require(script.Parent.Parent.Types)
return table.freeze({
    _id = "Banjo Firefly",
    DisplayName = "Jitterbug",
    Icon = "rbxassetid://116314691958416",
    EarningRate = 155000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 416.6666667,
    ModelWeight = 35,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = {
        DisplayName = "Jitterbug Egg",
        Icon = "rbxassetid://112602319982998",
        ModelName = "Banjo Firefly",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    },
    Animations = {
        Idle = AnimationAssets.Get("rbxassetid://81755619145930"),
        Walk = AnimationAssets.Get("rbxassetid://74876274996643"),
    },
    Rarity = Rarity.Rarities.Secret,
    BaseModelColor = Color3.new(1, 1, 1),
    PossibleModelColors = {{Color3.new(1, 1, 1), 1}},
})