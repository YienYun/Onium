-- Script path: ReplicatedStorage.Data.Assets.Configs.Electric Eel
-- Decompile time: 2.01 ms

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
    _id = "Electric Eel",
    DisplayName = "Electric Eel",
    Icon = "rbxassetid://132365981269002",
    EarningRate = 200000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 9.090909091,
    ModelWeight = 45,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Electric Eel Egg",
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
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(27, 54, 103)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(27, 54, 103), 80}),
    table.freeze({Color3.fromRGB(36, 76, 96), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
v1.WalkSound = table.freeze({
    SoundId = 121002219719855,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 124596205464445, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))