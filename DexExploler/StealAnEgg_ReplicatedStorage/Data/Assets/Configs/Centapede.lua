-- Script path: ReplicatedStorage.Data.Assets.Configs.Centapede
-- Decompile time: 1.89 ms

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
    _id = "Centapede",
    DisplayName = "Centapede",
    Icon = "rbxassetid://137964650556285",
    EarningRate = 1500,
    IndexSpeedReward = 960000,
    DropWeight = 0,
    VisualOdds = 135000000000,
    ModelWeight = 6,
    WalkAnimationReferenceSpeed = 2,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Centapede Egg",
        Icon = "rbxassetid://131685653579153",
        GrowthTime = 120,
        WeightKg = 7,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://112002125092401"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://112002125092401 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://117870055907973"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://117870055907973 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(0.9058823585510254, 0.9058823585510254, 0.9254902005195618)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.9058823585510254, 0.9058823585510254, 0.9254902005195618), 900}),
    table.freeze({Color3.new(0.20000000298023224, 1, 0.1882352977991104), 100}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 90676527927085,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))