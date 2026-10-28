-- Script path: ReplicatedStorage.Data.Assets.Configs.Hazardhog
-- Decompile time: 1.77 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 5 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 7 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Hazardhog",
    DisplayName = "Hazardhog",
    Icon = "rbxassetid://79555871489806",
    EarningRate = 500000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 0,
    ModelWeight = 25000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Biohazard Egg",
        Icon = "rbxassetid://103838374075457",
        ModelName = "Biohazard Egg",
        GrowthTime = 60,
        WeightKg = 1,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://75849941243877"
local success = pcall(function() -- Line: 7 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://75849941243877 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://105404788634249"
local success_2 = pcall(function() -- Line: 7 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://105404788634249 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.fromRGB(255, 255, 255)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.fromRGB(255, 255, 255), 1})})
v1.WalkSound = table.freeze({
    SoundId = 108336560174689,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 93666017204097, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))