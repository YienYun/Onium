-- Script path: ReplicatedStorage.Data.Assets.Configs.Parrotfish
-- Decompile time: 3.22 ms

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
    _id = "Parrotfish",
    DisplayName = "Parrotfish",
    Icon = "rbxassetid://135424380374502",
    EarningRate = 220,
    IndexSpeedReward = 72000,
    DropWeight = 0.55,
    VisualOdds = 2773109151.841,
    ModelWeight = 5,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Parrotfish Egg",
        Icon = "rbxassetid://106162253439995",
        GrowthTime = 75,
        WeightKg = 6,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://72768315033468"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://72768315033468 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://78456388841958"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://78456388841958 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.8117647171020508, 0.4313725531101227, 0.5960784554481506)
v1.PossibleModelColors = table.freeze({})
v1.RandomIdleSound = table.freeze({SoundId = 85880720515106, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))