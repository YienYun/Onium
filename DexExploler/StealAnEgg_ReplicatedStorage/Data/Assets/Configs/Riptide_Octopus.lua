-- Script path: ReplicatedStorage.Data.Assets.Configs.Riptide Octopus
-- Decompile time: 1.75 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 9 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 11 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Riptide Octopus",
    DisplayName = "Riptide Octopus",
    Icon = "rbxassetid://136429320011912",
    EarningRate = 1500000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 5.555555556,
    ModelWeight = 18000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Riptide Octopus Egg",
        Icon = "rbxassetid://113826857989447",
        ModelName = "Depths Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://77550298467205"
local success = pcall(function() -- Line: 11 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://77550298467205 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://125902579005259"
local success_2 = pcall(function() -- Line: 11 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://125902579005259 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(196, 40, 28)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.fromRGB(196, 40, 28), 1})})
v1.WalkSound = table.freeze({
    SoundId = 86108522326041,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 106524640987093, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))