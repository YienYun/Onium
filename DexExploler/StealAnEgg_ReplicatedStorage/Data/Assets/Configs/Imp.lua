-- Script path: ReplicatedStorage.Data.Assets.Configs.Imp
-- Decompile time: 1.52 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 6 -- types: a1: string
    local Animation = Instance.new("Animation")
    Animation.AnimationId = a1
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Imp",
    DisplayName = "Imp",
    Icon = "rbxassetid://80756597804671",
    EarningRate = 16000000,
    IndexSpeedReward = 8000000,
    DropWeight = 0,
    VisualOdds = 5.9417706476530014,
    ModelWeight = 9000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    WalkSound = table.freeze({
        SoundId = 122896507255411,
        Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
    }),
    RandomIdleSound = table.freeze({SoundId = 87783014657179, Data = table.freeze({MaxDistance = 20, Volume = 1.5})}),
    Egg = table.freeze({
        DisplayName = "Imp Egg",
        Icon = "rbxassetid://86008838296332",
        ModelName = "Imp",
        GrowthTime = 900,
        WeightKg = 5,
    }),
}
local freeze_4 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://99392172664963"
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
Animation_2.AnimationId = "rbxassetid://72516808870539"
v2.Walk = Animation_2
v1.Animations = freeze_4(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(165, 38, 40)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(165, 38, 40), 80}),
    table.freeze({Color3.fromRGB(125, 45, 38), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
return freeze(v1)