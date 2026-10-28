-- Script path: ReplicatedStorage.Data.Assets.Configs.Camel
-- Decompile time: 2.68 ms

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
    _id = "Camel",
    DisplayName = "Camel",
    Icon = "rbxassetid://108762713931799",
    EarningRate = 75,
    IndexSpeedReward = 9000,
    DropWeight = 0.5,
    VisualOdds = 7778.721339,
    ModelWeight = 700,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Camel Egg", Icon = "rbxassetid://115488818954741", GrowthTime = 45, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://132038053239618"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://132038053239618 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://88361956334028"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://88361956334028 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.6901960968971252, 0.5333333611488342, 0.3529411852359772)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.7372549176216125, 0.6078431606292725, 0.364705890417099), 680}),
    table.freeze({Color3.new(0.5882353186607361, 0.4117647111415863, 0.23529411852359772), 180}),
    table.freeze({Color3.new(0.8627451062202454, 0.7647058963775635, 0.5490196347236633), 105}),
    table.freeze({Color3.new(0.37254902720451355, 0.2549019753932953, 0.1568627506494522), 35}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 107100680371623,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))