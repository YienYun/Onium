-- Script path: ReplicatedStorage.Data.Assets.Configs.Walrus
-- Decompile time: 2.77 ms

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
    _id = "Walrus",
    DisplayName = "Walrus",
    Icon = "rbxassetid://129141571024477",
    EarningRate = 600,
    IndexSpeedReward = 14400,
    DropWeight = 0.5,
    VisualOdds = 4788235.136,
    ModelWeight = 200,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Walrus Egg", Icon = "rbxassetid://91972491841412", GrowthTime = 60, WeightKg = 4}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://98973083016392"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://98973083016392 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://106288976924750"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://106288976924750 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.WalkSound = table.freeze({
    SoundId = 81119519724182,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(0.46666666865348816, 0.4431372582912445, 0.41960784792900085)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.46666666865348816, 0.4431372582912445, 0.41960784792900085), 620}),
    table.freeze({Color3.new(0.4117647111415863, 0.3333333432674408, 0.27450981736183167), 180}),
    table.freeze({Color3.new(0.6470588445663452, 0.5490196347236633, 0.47058823704719543), 140}),
    table.freeze({Color3.new(0.7450980544090271, 0.6470588445663452, 0.5686274766921997), 45}),
    table.freeze({Color3.new(0.27450981736183167, 0.23529411852359772, 0.21568627655506134), 15}),
    table.freeze({Color3.new(0.27843138575553894, 0.3686274588108063, 0.615686297416687), 7}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 110863031812081,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))