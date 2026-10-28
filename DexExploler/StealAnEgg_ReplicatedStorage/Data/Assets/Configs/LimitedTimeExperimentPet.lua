-- Script path: ReplicatedStorage.Data.Assets.Configs.LimitedTimeExperimentPet
-- Decompile time: 1.70 ms

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
    _id = "LimitedTimeExperimentPet",
    DisplayName = "Experiment #001",
    Icon = "rbxassetid://92174010826963",
    EarningRate = 285000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 0,
    ModelWeight = 8,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Axolotl Egg",
        ModelName = "LimitedTimeExperimentPet",
        Icon = "rbxassetid://120361722086155",
        GrowthTime = 12600,
        WeightKg = 1,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://77978520019499"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://77978520019499 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://97188850562701"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://97188850562701 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.9725490212440491, 0.9725490212440491, 0.9725490212440491)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.9725490212440491, 0.9725490212440491, 0.9725490212440491), 760}),
    (table.freeze({Color3.new(0.9019607901573181, 0.8235294222831726, 0.6274510025978088), 120})),
})
return (freeze(v1))