-- Script path: ReplicatedStorage.Data.Assets.Configs.Coffin Skeleton
-- Decompile time: 1.96 ms

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
    _id = "Coffin Skeleton",
    DisplayName = "Coffin Crawler",
    Icon = "rbxassetid://83437053151492",
    EarningRate = 175000,
    IndexSpeedReward = 640,
    DropWeight = 0.4,
    VisualOdds = 2.5,
    ModelWeight = 8500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Coffin Crawler Egg",
        Icon = "rbxassetid://127118549491652",
        ModelName = "Coffin Skeleton Egg",
        GrowthTime = 240,
        WeightKg = 6,
        HideRarity = false,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://112765144416177"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://112765144416177 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://99288337020783"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://99288337020783 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.new(1, 1, 1)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.new(1, 1, 1), 10})})
v1.WalkSound = table.freeze({
    SoundId = 84480650511667,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 79610497781552, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))