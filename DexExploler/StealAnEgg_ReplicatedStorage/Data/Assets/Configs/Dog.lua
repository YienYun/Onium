-- Script path: ReplicatedStorage.Data.Assets.Configs.Dog
-- Decompile time: 2.90 ms

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
    _id = "Dog",
    DisplayName = "Dog",
    Icon = "rbxassetid://128470938015055",
    EarningRate = 2,
    IndexSpeedReward = 460,
    DropWeight = 0,
    VisualOdds = 2,
    ModelWeight = 25,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Dog Egg", Icon = "rbxassetid://123926130544109", GrowthTime = 15, WeightKg = 1}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://117866633124975"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://117866633124975 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://85471228397160"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://85471228397160 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Common
v1.BaseModelColor = Color3.new(0.6470588445663452, 0.3333333432674408, 0.3333333432674408)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.6470588445663452, 0.3333333432674408, 0.3333333432674408), 170}),
    table.freeze({Color3.new(0.8549019694328308, 0.6196078658103943, 0.2823529541492462), 160}),
    table.freeze({Color3.new(0.8039215803146362, 0.6666666865348816, 0.4117647111415863), 145}),
    table.freeze({Color3.new(0.9333333373069763, 0.8627451062202454, 0.686274528503418), 115}),
    table.freeze({Color3.new(0.9607843160629272, 0.9411764740943909, 0.8823529481887817), 85}),
    table.freeze({Color3.new(0.4117647111415863, 0.2549019753932953, 0.1568627506494522), 115}),
    table.freeze({Color3.new(0.21568627655506134, 0.1764705926179886, 0.14901961386203766), 90}),
    table.freeze({Color3.new(0.5882353186607361, 0.529411792755127, 0.45098039507865906), 55}),
    table.freeze({Color3.new(0.37254902720451355, 0.3921568691730499, 0.4117647111415863), 40}),
    (table.freeze({Color3.new(0.7254902124404907, 0.7254902124404907, 0.6980392336845398), 25})),
})
v1.WalkSound = table.freeze({
    SoundId = 134795569551185,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))