-- Script path: ReplicatedStorage.Data.Assets.Configs.Terra Snapper
-- Decompile time: 1.79 ms

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
    _id = "Terra Snapper",
    DisplayName = "Terra Snapper",
    Icon = "rbxassetid://82250986590981",
    EarningRate = 750000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 15.38461538,
    ModelWeight = 60000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Terra Snapper Egg",
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
local u20 = "rbxassetid://90942455913842"
local success = pcall(function() -- Line: 11 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://90942455913842 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://119118916125408"
local success_2 = pcall(function() -- Line: 11 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://119118916125408 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.fromRGB(68, 100, 51)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(68, 100, 51), 80}),
    table.freeze({Color3.fromRGB(105, 99, 70), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
return (freeze(v1))