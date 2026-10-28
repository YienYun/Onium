-- Script path: ReplicatedStorage.Data.Assets.Configs.Strawberry Elephant
-- Decompile time: 1.84 ms

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
    _id = "Strawberry Elephant",
    DisplayName = "Strawberry Elephant",
    Icon = "rbxassetid://104893772657012",
    EarningRate = 110000000,
    IndexSpeedReward = 143000,
    DropWeight = 0.01,
    VisualOdds = 100,
    ModelWeight = 35000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1.4,
    LimitedEggViewportVerticalOffset = 0.15,
    Egg = table.freeze({
        DisplayName = "Strawberry Elephant Egg",
        Icon = "rbxassetid://81000367959664",
        GrowthTime = 14400,
        WeightKg = 6,
        HideRarity = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://108521102806050"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://108521102806050 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://140073552251730"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://140073552251730 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(1, 0, 0)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(1, 0, 0), 990}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 71981709552622,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 2}),
})
v1.RandomIdleSound = table.freeze({SoundId = 110133807626521, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))