-- Script path: ReplicatedStorage.Data.Assets.Configs.Dragon
-- Decompile time: 2.12 ms

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
    _id = "Dragon",
    DisplayName = "Lava Dragon",
    Icon = "rbxassetid://78935088838538",
    EarningRate = 100000000,
    IndexSpeedReward = 60000,
    DropWeight = 0.1,
    VisualOdds = 1723764648.784,
    ModelWeight = 14000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Lava Dragon Egg",
        Icon = "rbxassetid://83763836069510",
        GrowthTime = 18000,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://89972004562188"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://89972004562188 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://76810501908674"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://76810501908674 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(0.18431372940540314, 0.13333334028720856, 0.13333334028720856)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.18431372940540314, 0.13333334028720856, 0.13333334028720856), 950}),
    table.freeze({Color3.new(0.7450980544090271, 0.13725490868091583, 0.09803921729326248), 50}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 75100575755567,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99984406249141, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))