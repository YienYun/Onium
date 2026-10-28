-- Script path: ReplicatedStorage.Data.Assets.Configs.Jellyfish
-- Decompile time: 1.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 6 -- types: a1: string
    local Animation = Instance.new("Animation")
    Animation.AnimationId = a1
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Jellyfish",
    DisplayName = "Pure Jellyfish",
    Icon = "rbxassetid://125711705647799",
    EarningRate = 225000000,
    IndexSpeedReward = 30000000,
    DropWeight = 0,
    VisualOdds = 22.935779816513758,
    ModelWeight = 10000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    WalkSound = table.freeze({
        SoundId = 119456513629592,
        Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
    }),
    RandomIdleSound = table.freeze({SoundId = 120392356663478, Data = table.freeze({MaxDistance = 20, Volume = 1.5})}),
    Egg = table.freeze({
        DisplayName = "Pure Jellyfish Egg",
        Icon = "rbxassetid://128249019051623",
        ModelName = "Jellyfish",
        GrowthTime = 10800,
        WeightKg = 10,
    }),
}
local freeze_4 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://138191306409960"
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
Animation_2.AnimationId = "rbxassetid://86698796056796"
v2.Walk = Animation_2
v1.Animations = freeze_4(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(243, 243, 210)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(243, 243, 210), 80}),
    table.freeze({Color3.fromRGB(232, 228, 197), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
return freeze(v1)