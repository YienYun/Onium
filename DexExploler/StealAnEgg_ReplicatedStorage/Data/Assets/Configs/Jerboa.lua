-- Script path: ReplicatedStorage.Data.Assets.Configs.Jerboa
-- Decompile time: 2.34 ms

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
    _id = "Jerboa",
    DisplayName = "Jerboa",
    Icon = "rbxassetid://139650837807677",
    EarningRate = 6,
    IndexSpeedReward = 7200,
    DropWeight = 0.1,
    VisualOdds = 4275.209942,
    ModelWeight = 2,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Jerboa Egg", Icon = "rbxassetid://116318646770786", GrowthTime = 20, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://120442698107384"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://120442698107384 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://98534506511088"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://98534506511088 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Common
v1.BaseModelColor = Color3.new(0.8274509906768799, 0.7450980544090271, 0.5882353186607361)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8392156958580017, 0.729411780834198, 0.5568627715110779), 760}),
    table.freeze({Color3.new(0.7254902124404907, 0.5882353186607361, 0.37254902720451355), 145}),
    table.freeze({Color3.new(0.9215686321258545, 0.843137264251709, 0.686274528503418), 70}),
    table.freeze({Color3.new(0.8588235378265381, 0.6352941393852234, 0.4117647111415863), 25}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 100593786623130,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 133440437999035, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))