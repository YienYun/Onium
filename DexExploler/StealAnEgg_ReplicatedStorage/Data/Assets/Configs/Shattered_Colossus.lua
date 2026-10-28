-- Script path: ReplicatedStorage.Data.Assets.Configs.Shattered Colossus
-- Decompile time: 2.62 ms

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
    _id = "Shattered Colossus",
    DisplayName = "Shattered Colossus",
    Icon = "rbxassetid://113063464048237",
    EarningRate = 3500000000,
    IndexSpeedReward = 48000,
    DropWeight = 0,
    VisualOdds = 8000000,
    ModelWeight = 16000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Shattered Colossus Egg",
        Icon = "rbxassetid://124927737636564",
        ModelName = "Crystal Egg",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://91298110425808"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://91298110425808 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://126685367627443"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://126685367627443 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Divine
v1.BaseModelColor = Color3.fromRGB(96, 52, 239)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(96, 52, 239), 850}),
    table.freeze({Color3.fromRGB(249, 164, 255), 90}),
    table.freeze({Color3.fromRGB(139, 90, 245), 48}),
    (table.freeze({Color3.fromRGB(83, 35, 177), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 108764740433037,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 113389912536422, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))