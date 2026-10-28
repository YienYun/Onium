-- Script path: ReplicatedStorage.Data.Assets.Configs.DesertLark
-- Decompile time: 2.34 ms

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
    _id = "DesertLark",
    DisplayName = "Bird",
    Icon = "rbxassetid://107145283169125",
    EarningRate = 8,
    IndexSpeedReward = 500,
    DropWeight = 0.3333333333333333,
    VisualOdds = 3.265923580159354,
    ModelWeight = 5,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Bird Egg", Icon = "rbxassetid://131243362633620", GrowthTime = 25, WeightKg = 1}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://83189168987431"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://83189168987431 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://71642453365136"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://71642453365136 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Uncommon
v1.BaseModelColor = Color3.new(0.6470588445663452, 0.6078431606292725, 0.5058823823928833)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.6470588445663452, 0.6078431606292725, 0.5058823823928833), 700}),
    table.freeze({Color3.new(0.7450980544090271, 0.686274528503418, 0.529411792755127), 180}),
    table.freeze({Color3.new(0.4901960790157318, 0.4117647111415863, 0.29411765933036804), 85}),
    table.freeze({Color3.new(0.843137264251709, 0.7843137383460999, 0.6470588445663452), 35}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 102991056587805,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 98182435581719, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))