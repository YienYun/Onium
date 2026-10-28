-- Script path: ReplicatedStorage.Data.Assets.Configs.Shardling
-- Decompile time: 1.72 ms

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
    _id = "Shardling",
    DisplayName = "Shardling",
    Icon = "rbxassetid://110489441957396",
    EarningRate = 450000,
    IndexSpeedReward = 42000,
    DropWeight = 0,
    VisualOdds = 6000000,
    ModelWeight = 13000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Shattered Rift Egg",
        Icon = "rbxassetid://85929412992561",
        ModelName = "Shattered Rift Egg",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://129116620156149"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://129116620156149 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://129116620156149"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://129116620156149 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.fromRGB(143, 112, 204)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.fromRGB(143, 112, 204), 1})})
v1.WalkSound = table.freeze({
    SoundId = 113982093954612,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 133591606094699, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))