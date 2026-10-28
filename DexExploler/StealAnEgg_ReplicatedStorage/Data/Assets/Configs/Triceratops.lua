-- Script path: ReplicatedStorage.Data.Assets.Configs.Triceratops
-- Decompile time: 2.45 ms

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
    _id = "Triceratops",
    DisplayName = "Triceratops",
    Icon = "rbxassetid://127014885618024",
    EarningRate = 1200000,
    IndexSpeedReward = 360000,
    DropWeight = 0.3333333333333333,
    VisualOdds = 13901.327813000002,
    ModelWeight = 3500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Triceratops Egg",
        Icon = "rbxassetid://73329615832715",
        GrowthTime = 480,
        WeightKg = 3,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://87496654880154"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://87496654880154 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://122861021000342"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://122861021000342 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.35686275362968445, 0.30588236451148987, 0.2823529541492462)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.35686275362968445, 0.30588236451148987, 0.2823529541492462), 520}),
    table.freeze({Color3.new(0.4313725531101227, 0.37254902720451355, 0.2549019753932953), 180}),
    table.freeze({Color3.new(0.3333333432674408, 0.4117647111415863, 0.2549019753932953), 130}),
    table.freeze({Color3.new(0.5098039507865906, 0.47058823704719543, 0.37254902720451355), 110}),
    table.freeze({Color3.new(0.23529411852359772, 0.21568627655506134, 0.19607843458652496), 60}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 117490508431150,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 103866172195808, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))