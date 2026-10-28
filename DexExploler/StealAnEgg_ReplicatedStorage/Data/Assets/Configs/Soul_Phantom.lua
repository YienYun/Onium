-- Script path: ReplicatedStorage.Data.Assets.Configs.Soul Phantom
-- Decompile time: 1.62 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 8 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 10 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Soul Phantom",
    DisplayName = "Soul Phantom",
    Icon = "rbxassetid://139447998862041",
    EarningRate = 2500000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 200,
    ModelWeight = 1750,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Halloween Dimension Egg",
        Icon = "rbxassetid://108942186680593",
        ModelName = "Halloween Dimension Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://103896950320831"
local success = pcall(function() -- Line: 10 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://103896950320831 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://76782045756515"
local success_2 = pcall(function() -- Line: 10 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://76782045756515 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.fromRGB(135, 95, 168)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(135, 95, 168), 990}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 10})),
})
return (freeze(v1))