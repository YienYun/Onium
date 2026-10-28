-- Script path: ReplicatedStorage.Data.Assets.Configs.Rattlesnake
-- Decompile time: 2.13 ms

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
    _id = "Rattlesnake",
    DisplayName = "Snake",
    Icon = "rbxassetid://119006769959865",
    EarningRate = 3600,
    IndexSpeedReward = 10800,
    DropWeight = 0.25,
    VisualOdds = 21547.05811,
    ModelWeight = 45,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Snake Egg", Icon = "rbxassetid://85648596444101", GrowthTime = 150, WeightKg = 3}),
}
local freeze_2 = table.freeze
local v2 = {TransitionFadeDuration = 0}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://130705101747406"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://130705101747406 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://130705101747406"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://130705101747406 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.new(0.6470588445663452, 0.4941176474094391, 0.2823529541492462)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.6470588445663452, 0.4941176474094391, 0.2823529541492462), 680}),
    table.freeze({Color3.new(0.7176470756530762, 0.5607843399047852, 0.3450980484485626), 170}),
    table.freeze({Color3.new(0.8039215803146362, 0.686274528503418, 0.45098039507865906), 115}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 120142944253002,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 90201240349836, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))