-- Script path: ReplicatedStorage.Data.Assets.Configs.Race Bird
-- Decompile time: 2.01 ms

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
    _id = "Race Bird",
    DisplayName = "Race Bird",
    Icon = "rbxassetid://95688797601022",
    EarningRate = 16000000,
    IndexSpeedReward = 30000,
    DropWeight = 0,
    VisualOdds = 1,
    ModelWeight = 400,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Race Bird Egg",
        Icon = "rbxassetid://112599398060234",
        GrowthTime = 240,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://137451404613452"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://137451404613452 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://78667646662090"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://78667646662090 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(87, 141, 206)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(87, 141, 206), 180}),
    table.freeze({Color3.fromRGB(75, 151, 75), 100}),
    (table.freeze({Color3.fromRGB(98, 37, 209), 40})),
})
v1.WalkSound = table.freeze({
    SoundId = 131919476389435,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 108741426399048, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))