-- Script path: ReplicatedStorage.Data.Assets.Configs.Dreadclaw
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
    _id = "Dreadclaw",
    DisplayName = "Dreadclaw",
    Icon = "rbxassetid://77268107610374",
    EarningRate = 2200000,
    IndexSpeedReward = 30000,
    DropWeight = 0,
    VisualOdds = 1000000,
    ModelWeight = 9000,
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
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://83642136159586"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://83642136159586 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://103513095672988"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://103513095672988 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.fromRGB(39, 37, 56)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(39, 37, 56), 850}),
    table.freeze({Color3.fromRGB(110, 74, 126), 90}),
    table.freeze({Color3.fromRGB(69, 65, 99), 48}),
    (table.freeze({Color3.fromRGB(70, 48, 74), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 80704340749503,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 96954400843148, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))