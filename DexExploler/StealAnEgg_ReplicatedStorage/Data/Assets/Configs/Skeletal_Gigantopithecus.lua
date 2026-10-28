-- Script path: ReplicatedStorage.Data.Assets.Configs.Skeletal Gigantopithecus
-- Decompile time: 1.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = Color3.fromRGB(255, 255, 255)

local function makeAnimation(a1) -- Line: 12 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 14 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v2 = {
    _id = "Skeletal Gigantopithecus",
    DisplayName = "Skeletal Gigantus",
    Icon = "rbxassetid://72760641200300",
    EarningRate = 4000000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 1523.076923076923,
    ModelWeight = 35000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Skeletal Gigantus Egg",
        Icon = "rbxassetid://104417876555018",
        ModelName = "Skeletal Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://131115998811013"
local success = pcall(function() -- Line: 14 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://131115998811013 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://86961865889350"
local success_2 = pcall(function() -- Line: 14 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://86961865889350 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
v2.WalkSound = table.freeze({
    SoundId = 128349535510732,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v2.RandomIdleSound = table.freeze({SoundId = 122183260167104, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v2))