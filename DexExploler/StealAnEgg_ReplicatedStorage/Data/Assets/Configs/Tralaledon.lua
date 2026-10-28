-- Script path: ReplicatedStorage.Data.Assets.Configs.Tralaledon
-- Decompile time: 2.34 ms

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
    _id = "Tralaledon",
    DisplayName = "Tralaledon",
    Icon = "rbxassetid://130012248199145",
    EarningRate = 32000000,
    IndexSpeedReward = 480000,
    DropWeight = 0.5,
    VisualOdds = 4788235.136,
    ModelWeight = 1000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Tralaledon Egg",
        Icon = "rbxassetid://73956313512014",
        GrowthTime = 10800,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://76232355786894"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://76232355786894 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://106459098297164"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://106459098297164 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305), 1}),
    table.freeze({Color3.new(0.3764705955982208, 0.46666666865348816, 0.32156863808631897), 1}),
    table.freeze({Color3.new(0.3529411852359772, 0.3921568691730499, 0.4117647111415863), 1}),
    table.freeze({Color3.new(0.364705890417099, 0.3294117748737335, 0.26274511218070984), 1}),
    table.freeze({Color3.new(0.5686274766921997, 0.47843137383461, 0.33725491166114807), 1}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 102782721780407,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 111240888016649, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))