-- Script path: ReplicatedStorage.Data.Assets.Configs.Mecha Chompa
-- Decompile time: 1.75 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = Color3.fromRGB(255, 255, 255)

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
local v2 = {
    _id = "Mecha Chompa",
    DisplayName = "Mecha Chompa",
    Icon = "rbxassetid://125384591742959",
    EarningRate = 600000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 22000000000,
    ModelWeight = 50000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Mecha Chompa Egg",
        Icon = "rbxassetid://98532453004675",
        ModelName = "Toxic Crocodile",
        GrowthTime = 900,
        WeightKg = 6,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://115113910430628"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://115113910430628 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://140388531567918"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://140388531567918 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
v2.WalkSound = table.freeze({
    SoundId = 85221136478170,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v2.RandomIdleSound = table.freeze({SoundId = 91300610782424, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v2))