-- Script path: ReplicatedStorage.Data.Assets.Configs.Mire Fox
-- Decompile time: 2.45 ms

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
    _id = "Mire Fox",
    DisplayName = "Fox",
    Icon = "rbxassetid://96639152572865",
    EarningRate = 180,
    IndexSpeedReward = 720,
    DropWeight = 0.14285714285714285,
    VisualOdds = 10.773529,
    ModelWeight = 28,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Fox Egg", Icon = "rbxassetid://122218902574805", GrowthTime = 90, WeightKg = 1}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://115440197758670"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://115440197758670 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://107607987905386"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://107607987905386 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(1, 0.2823529541492462, 0)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(1, 0.2823529541492462, 0), 760}),
    table.freeze({Color3.new(0.48627451062202454, 0.3137255012989044, 0.18431372940540314), 120}),
    table.freeze({Color3.new(0.9215686321258545, 0.8235294222831726, 0.6470588445663452), 70}),
    table.freeze({Color3.new(0.1764705926179886, 0.16470588743686676, 0.14901961386203766), 35}),
    (table.freeze({Color3.new(0.9607843160629272, 0.9607843160629272, 0.9215686321258545), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 124821449139609,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 140069693056979, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))