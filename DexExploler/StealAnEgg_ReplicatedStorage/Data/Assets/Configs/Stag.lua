-- Script path: ReplicatedStorage.Data.Assets.Configs.Stag
-- Decompile time: 2.08 ms

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
    _id = "Stag",
    DisplayName = "Stag",
    Icon = "rbxassetid://103920312992960",
    EarningRate = 145000000,
    IndexSpeedReward = 4809168,
    DropWeight = 0,
    VisualOdds = 1.142e+15,
    ModelWeight = 180,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Stag Egg", Icon = "rbxassetid://97036591304998", GrowthTime = 10800, WeightKg = 3}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://97594016374994"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://97594016374994 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://127164749954687"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://127164749954687 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.95686274766922, 0.8627451062202454, 0.7098039388656616)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.95686274766922, 0.8627451062202454, 0.7098039388656616), 850}),
    table.freeze({Color3.new(0.7450980544090271, 0.5490196347236633, 0.3529411852359772), 90}),
    table.freeze({Color3.new(0.5490196347236633, 0.5098039507865906, 0.47058823704719543), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 86323278444941,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))