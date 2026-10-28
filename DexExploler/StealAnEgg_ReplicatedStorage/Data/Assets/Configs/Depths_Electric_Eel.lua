-- Script path: ReplicatedStorage.Data.Assets.Configs.Depths Electric Eel
-- Decompile time: 1.97 ms

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
    _id = "Depths Electric Eel",
    DisplayName = "Luminous Electric Eel",
    Icon = "rbxassetid://122607475268508",
    EarningRate = 1750000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 900,
    ModelWeight = 45,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Luminous Electric Eel Egg",
        Icon = "rbxassetid://103020287697704",
        ModelName = "Depths Reroll Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://77626896467685"
local success = pcall(function() -- Line: 11 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://77626896467685 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://110663969055239"
local success_2 = pcall(function() -- Line: 11 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://110663969055239 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.fromRGB(47, 36, 145)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(47, 36, 145), 80}),
    table.freeze({Color3.fromRGB(65, 43, 125), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
v1.WalkSound = table.freeze({
    SoundId = 75208096856329,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 76342189119305, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))