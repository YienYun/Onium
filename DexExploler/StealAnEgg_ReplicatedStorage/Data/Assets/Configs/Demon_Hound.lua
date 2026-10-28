-- Script path: ReplicatedStorage.Data.Assets.Configs.Demon Hound
-- Decompile time: 2.11 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 6 -- types: a1: string
    local Animation = Instance.new("Animation")
    Animation.AnimationId = a1
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Demon Hound",
    DisplayName = "Demon Hound",
    Icon = "rbxassetid://97830965844787",
    EarningRate = 25000000,
    IndexSpeedReward = 20000000,
    DropWeight = 0,
    VisualOdds = 7.163323782234957,
    ModelWeight = 9000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    WalkSound = table.freeze({
        SoundId = 91021680910561,
        Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
    }),
    RandomIdleSound = table.freeze({SoundId = 109891701674473, Data = table.freeze({MaxDistance = 20, Volume = 1.5})}),
    Egg = table.freeze({
        DisplayName = "Demon Hound Egg",
        Icon = "rbxassetid://81200150769664",
        ModelName = "Demon Hound",
        GrowthTime = 1200,
        WeightKg = 5,
    }),
}
local freeze_4 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://71097341870152"
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
Animation_2.AnimationId = "rbxassetid://88651036276589"
v2.Walk = Animation_2
v1.Animations = freeze_4(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(149, 68, 60)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(149, 68, 60), 80}),
    table.freeze({Color3.fromRGB(108, 46, 40), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
return freeze(v1)