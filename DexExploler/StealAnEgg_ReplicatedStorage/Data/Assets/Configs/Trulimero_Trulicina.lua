-- Script path: ReplicatedStorage.Data.Assets.Configs.Trulimero Trulicina
-- Decompile time: 1.51 ms

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
    _id = "Trulimero Trulicina",
    DisplayName = "Trulimero Trulicina",
    Icon = "rbxassetid://76343978520262",
    EarningRate = 260,
    IndexSpeedReward = 3000,
    DropWeight = 0.25,
    VisualOdds = 475.4503389645072,
    ModelWeight = 140,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Trulimero Trulicina Egg",
        Icon = "rbxassetid://87452659682783",
        GrowthTime = 90,
        WeightKg = 2,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://138144344434611"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://138144344434611 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://106256675922211"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://106256675922211 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v1.PossibleModelColors = table.freeze({})
v1.RandomIdleSound = table.freeze({SoundId = 94224407092698, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))