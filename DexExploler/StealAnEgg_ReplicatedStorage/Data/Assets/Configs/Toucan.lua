-- Script path: ReplicatedStorage.Data.Assets.Configs.Toucan
-- Decompile time: 2.20 ms

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
    _id = "Toucan",
    DisplayName = "Toucan",
    Icon = "rbxassetid://125683101618417",
    EarningRate = 110,
    IndexSpeedReward = 8100,
    DropWeight = 0.5,
    VisualOdds = 215470.581098,
    ModelWeight = 5,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Toucan Egg", Icon = "rbxassetid://133240723882442", GrowthTime = 40, WeightKg = 3}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://103568539384204"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://103568539384204 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://93317338815787"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://93317338815787 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.0313725508749485, 0.0313725508749485, 0.03529411926865578)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.0313725508749485, 0.0313725508749485, 0.03529411926865578), 760}),
    table.freeze({Color3.new(0.1764705926179886, 0.1764705926179886, 0.16470588743686676), 120}),
    table.freeze({Color3.new(0.9607843160629272, 0.9215686321258545, 0.8039215803146362), 80}),
    table.freeze({Color3.new(0.29411765933036804, 0.21568627655506134, 0.13725490868091583), 40}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 115370318218911,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))