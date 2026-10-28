-- Script path: ReplicatedStorage.Data.Assets.Configs.Void Serpent
-- Decompile time: 2.02 ms

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
    _id = "Void Serpent",
    DisplayName = "Void Serpent",
    Icon = "rbxassetid://76489166561287",
    EarningRate = 900000000,
    IndexSpeedReward = 45000,
    DropWeight = 0,
    VisualOdds = 7000000,
    ModelWeight = 14000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Riftbeasts Egg",
        Icon = "rbxassetid://97679329738336",
        ModelName = "Riftbeasts Egg",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {TransitionFadeDuration = 0}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://126055619089698"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://126055619089698 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://116304487121082"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://116304487121082 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.fromRGB(144, 120, 239)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(144, 120, 239), 850}),
    table.freeze({Color3.fromRGB(97, 61, 126), 90}),
    table.freeze({Color3.fromRGB(67, 62, 94), 48}),
    (table.freeze({Color3.fromRGB(111, 83, 252), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 119874987778528,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 90119740314250, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))