-- Script path: ReplicatedStorage.Data.Assets.Configs.Ember Dragon
-- Decompile time: 2.21 ms

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
    _id = "Ember Dragon",
    DisplayName = "Ember Dragon",
    Icon = "rbxassetid://135400297612664",
    EarningRate = 600000000,
    IndexSpeedReward = 80000,
    DropWeight = 0,
    VisualOdds = 50000,
    ModelWeight = 14000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({DisplayName = "Dragon Egg", Icon = "rbxassetid://124581147164560", GrowthTime = 60, WeightKg = 5}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://134684952794789"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://134684952794789 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://110166896149574"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://110166896149574 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.3803921639919281, 0.2823529541492462, 0.23529411852359772)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.3803921639919281, 0.2823529541492462, 0.23529411852359772), 700}),
    table.freeze({Color3.new(0.5607843399047852, 0.30980393290519714, 0.16470588743686676), 180}),
    table.freeze({Color3.new(0.27450981736183167, 0.1882352977991104, 0.14901961386203766), 108}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 95640392463828,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 0.9, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99984406249141, Data = table.freeze({MaxDistance = 30, Volume = 1.5})})
return (freeze(v1))