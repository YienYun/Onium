-- Script path: ReplicatedStorage.Data.Assets.Configs.Crane
-- Decompile time: 2.09 ms

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
    _id = "Crane",
    DisplayName = "Crane",
    Icon = "rbxassetid://89113690580626",
    EarningRate = 4000,
    IndexSpeedReward = 2748096,
    DropWeight = 0,
    VisualOdds = 135000000000,
    ModelWeight = 22,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Crane Egg", Icon = "rbxassetid://73259961188044", GrowthTime = 180, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://129341238383901"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://129341238383901 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://127557613470703"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://127557613470703 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(1, 0.8980392217636108, 0.8980392217636108)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(1, 0.8980392217636108, 0.8980392217636108), 850}),
    table.freeze({Color3.new(1, 0.7843137383460999, 0.8627451062202454), 90}),
    table.freeze({Color3.new(0.8823529481887817, 0.8823529481887817, 0.9215686321258545), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 89415448274930,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))