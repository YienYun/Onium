-- Script path: ReplicatedStorage.Data.Assets.Configs.Mangolini Parrochini
-- Decompile time: 1.73 ms

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
    _id = "Mangolini Parrochini",
    DisplayName = "Mangolini Parrochini",
    Icon = "rbxassetid://130382563562193",
    EarningRate = 800000,
    IndexSpeedReward = 267000,
    DropWeight = 0.1,
    VisualOdds = 10,
    ModelWeight = 1500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0.05,
    Egg = table.freeze({
        DisplayName = "Mangolini Parrochini Egg",
        Icon = "rbxassetid://81000367959664",
        GrowthTime = 600,
        WeightKg = 6,
        HideRarity = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://115841704171803"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://115841704171803 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://86277719813751"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://86277719813751 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.6039215922355652, 0.13333334028720856, 0.0941176488995552)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.6039215922355652, 0.13333334028720856, 0.0941176488995552), 990}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 126354350064440,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))