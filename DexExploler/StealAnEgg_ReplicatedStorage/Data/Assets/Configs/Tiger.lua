-- Script path: ReplicatedStorage.Data.Assets.Configs.Tiger
-- Decompile time: 2.00 ms

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
    _id = "Tiger",
    DisplayName = "Tiger",
    Icon = "rbxassetid://126259364621453",
    EarningRate = 28000,
    IndexSpeedReward = 14400,
    DropWeight = 0.14285714285714285,
    VisualOdds = 1150976.057531318,
    ModelWeight = 260,
    WalkAnimationReferenceSpeed = 10,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Tiger Egg", Icon = "rbxassetid://134641680880560", GrowthTime = 360, WeightKg = 4}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://114561164594465"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://114561164594465 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://71271079410070"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://71271079410070 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(1, 0.5333333611488342, 0.20000000298023224)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(1, 0.5333333611488342, 0.20000000298023224), 820}),
    table.freeze({Color3.new(0.9333333373069763, 0.8980392217636108, 0.8039215803146362), 120}),
    (table.freeze({Color3.new(0.8313725590705872, 0.6627451181411743, 0.27843138575553894), 40})),
})
v1.WalkSound = table.freeze({
    SoundId = 80252515692802,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 88142592932537, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))