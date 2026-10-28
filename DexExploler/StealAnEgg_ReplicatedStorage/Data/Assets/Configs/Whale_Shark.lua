-- Script path: ReplicatedStorage.Data.Assets.Configs.Whale Shark
-- Decompile time: 2.33 ms

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
    _id = "Whale Shark",
    DisplayName = "Whale Shark",
    Icon = "rbxassetid://133745688279874",
    EarningRate = 700000,
    IndexSpeedReward = 108000,
    DropWeight = 0.25,
    VisualOdds = 14504941186.087273,
    ModelWeight = 2000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Whale Shark Egg",
        Icon = "rbxassetid://93013491848495",
        GrowthTime = 600,
        WeightKg = 6,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://96079428169602"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://96079428169602 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://94460509562960"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://94460509562960 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0, 0.125490203499794, 0.3764705955982208)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0, 0.125490203499794, 0.3764705955982208), 680}),
    table.freeze({Color3.new(0.09803921729326248, 0.16862745583057404, 0.21176470816135406), 160}),
    table.freeze({Color3.new(0.14509804546833038, 0.16862745583057404, 0.1764705926179886), 110}),
    table.freeze({Color3.new(0.14901961386203766, 0.16078431904315948, 0.16078431904315948), 35}),
    table.freeze({Color3.new(0.09803921729326248, 0.13725490868091583, 0.1764705926179886), 15}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.RandomIdleSound = table.freeze({SoundId = 76545999037742, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))