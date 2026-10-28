-- Script path: ReplicatedStorage.Data.Assets.Configs.Mantis
-- Decompile time: 1.96 ms

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
    _id = "Mantis",
    DisplayName = "Mantaris",
    Icon = "rbxassetid://119413872068696",
    EarningRate = 11000000,
    IndexSpeedReward = 3435120,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 1500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Mantaris Egg",
        Icon = "rbxassetid://93443486739123",
        GrowthTime = 1020,
        WeightKg = 2,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://90034148491685"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://90034148491685 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://136861862282952"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://136861862282952 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.8392156958580017, 0.3843137323856354, 0.14901961386203766)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8392156958580017, 0.3843137323856354, 0.14901961386203766), 850}),
    table.freeze({Color3.new(0.6274510025978088, 0.27450981736183167, 0.11764705926179886), 90}),
    table.freeze({Color3.new(0.8823529481887817, 0.5882353186607361, 0.3137255012989044), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
return (freeze(v1))