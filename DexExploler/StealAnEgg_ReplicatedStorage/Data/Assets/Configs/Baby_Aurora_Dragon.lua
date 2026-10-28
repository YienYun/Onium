-- Script path: ReplicatedStorage.Data.Assets.Configs.Baby Aurora Dragon
-- Decompile time: 3.90 ms

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
    _id = "Baby Aurora Dragon",
    DisplayName = "Baby Aurora Dragon",
    Icon = "rbxassetid://93373306453881",
    EarningRate = 5000000,
    IndexSpeedReward = 10000,
    DropWeight = 0,
    VisualOdds = 100,
    ModelWeight = 8000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({DisplayName = "Dragon Egg", Icon = "rbxassetid://124581147164560", GrowthTime = 60, WeightKg = 5}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://94341479254631"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://94341479254631 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://133547081058201"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://133547081058201 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.new(0.9137254953384399, 0.8549019694328308, 0.8549019694328308)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.9137254953384399, 0.8549019694328308, 0.8549019694328308), 700}),
    table.freeze({Color3.new(0.5882353186607361, 0.615686297416687, 0.8588235378265381), 180}),
    table.freeze({Color3.new(1, 0.48235294222831726, 0.4901960790157318), 108}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 95640392463828,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1.12, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99984406249141, Data = table.freeze({MaxDistance = 30, Volume = 1.5})})
return (freeze(v1))