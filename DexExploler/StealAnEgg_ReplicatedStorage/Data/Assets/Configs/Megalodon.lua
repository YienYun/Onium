-- Script path: ReplicatedStorage.Data.Assets.Configs.Megalodon
-- Decompile time: 1.88 ms

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
    _id = "Megalodon",
    DisplayName = "Abyss Shark",
    Icon = "rbxassetid://73721822576503",
    EarningRate = 2500000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 5.555555556,
    ModelWeight = 60000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Abyss Shark Egg",
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
local u20 = "rbxassetid://80029181974482"
local success = pcall(function() -- Line: 10 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://80029181974482 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://87231380690296"
local success_2 = pcall(function() -- Line: 10 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://87231380690296 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(39, 65, 93)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(39, 65, 93), 80}),
    table.freeze({Color3.fromRGB(60, 89, 102), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
v1.WalkSound = table.freeze({
    SoundId = 134086453189212,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 97895397656046, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))