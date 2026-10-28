-- Script path: ReplicatedStorage.Data.Assets.Configs.Swan
-- Decompile time: 2.17 ms

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
    _id = "Swan",
    DisplayName = "Swan",
    Icon = "rbxassetid://125076114591417",
    EarningRate = 320,
    IndexSpeedReward = 3500,
    DropWeight = 0.2,
    VisualOdds = 670.5118643718583,
    ModelWeight = 22,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Swan Egg", Icon = "rbxassetid://125884067432601", GrowthTime = 120, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://113947385873952"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://113947385873952 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://136832792656489"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://136832792656489 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(0.7921568751335144, 0.7960784435272217, 0.8196078538894653)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.7921568751335144, 0.7960784435272217, 0.8196078538894653), 200}),
    table.freeze({Color3.new(0.9607843160629272, 0.9607843160629272, 0.9333333373069763), 710}),
    table.freeze({Color3.new(0.21568627655506134, 0.21568627655506134, 0.21568627655506134), 70}),
    (table.freeze({Color3.new(0.7450980544090271, 0.686274528503418, 0.6078431606292725), 20})),
})
v1.WalkSound = table.freeze({
    SoundId = 99672949453572,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 109415901740965, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))