-- Script path: ReplicatedStorage.Data.Assets.Configs.Catfish
-- Decompile time: 2.23 ms

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
    _id = "Catfish",
    DisplayName = "Catfish",
    Icon = "rbxassetid://137813424891388",
    EarningRate = 12,
    IndexSpeedReward = 2500,
    DropWeight = 0.5,
    VisualOdds = 262.769001,
    ModelWeight = 35,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Catfish Egg", Icon = "rbxassetid://120156933101223", GrowthTime = 30, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://77531242643307"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://77531242643307 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://97654952506163"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://97654952506163 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Uncommon
v1.BaseModelColor = Color3.new(0.01568627543747425, 0.686274528503418, 0.9254902005195618)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.01568627543747425, 0.686274528503418, 0.9254902005195618), 470}),
    table.freeze({Color3.new(0.25882354378700256, 0.2705882489681244, 0.250980406999588), 230}),
    table.freeze({Color3.new(0.2549019753932953, 0.23529411852359772, 0.19607843458652496), 150}),
    table.freeze({Color3.new(0.45490196347236633, 1, 0.5921568870544434), 100}),
    table.freeze({Color3.new(0.13725490868091583, 0.13725490868091583, 0.13725490868091583), 50}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.RandomIdleSound = table.freeze({SoundId = 131342808703780, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))