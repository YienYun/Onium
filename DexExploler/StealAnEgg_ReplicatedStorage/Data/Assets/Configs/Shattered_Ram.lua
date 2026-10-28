-- Script path: ReplicatedStorage.Data.Assets.Configs.Shattered Ram
-- Decompile time: 1.94 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 7 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Shattered Ram",
    DisplayName = "Shattered Ram",
    Icon = "rbxassetid://125891227427227",
    EarningRate = 8000000,
    IndexSpeedReward = 42000,
    DropWeight = 0,
    VisualOdds = 6000000,
    ModelWeight = 13000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Shattered Rift Egg",
        Icon = "rbxassetid://85929412992561",
        ModelName = "Shattered Rift Egg",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://87119522622192"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://87119522622192 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://110081678424085"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://110081678424085 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(84, 73, 103)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.fromRGB(84, 73, 103), 1})})
v1.WalkSound = table.freeze({
    SoundId = 121314153594495,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 109452009272137, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))