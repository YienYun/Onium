-- Script path: ReplicatedStorage.Data.Assets.Configs.Ring Guard
-- Decompile time: 1.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 5 -- types: a1: string
    local Animation = Instance.new("Animation")
    Animation.AnimationId = a1
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Ring Guard",
    DisplayName = "Ring Guard",
    Icon = "rbxassetid://97967732679537",
    EarningRate = 15000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 1,
    ModelWeight = 80,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    DontRoll = true,
    WalkSound = table.freeze({
        SoundId = 107135546418104,
        Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
    }),
    RandomIdleSound = table.freeze({SoundId = 108615491098304, Data = table.freeze({MaxDistance = 20, Volume = 1.5})}),
    Egg = table.freeze({
        DisplayName = "Ring Guard Egg",
        Icon = "rbxassetid://105780316822746",
        ModelName = "Ring Guard",
        GrowthTime = 1140,
        WeightKg = 80,
    }),
}
local freeze_4 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://105537650706847"
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
Animation_2.AnimationId = "rbxassetid://127903082838058"
v2.Walk = Animation_2
v1.Animations = freeze_4(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(107, 97, 78)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(107, 97, 78), 80}),
    table.freeze({Color3.fromRGB(91, 84, 70), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
return freeze(v1)