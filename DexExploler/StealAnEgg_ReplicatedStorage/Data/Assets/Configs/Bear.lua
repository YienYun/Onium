-- Script path: ReplicatedStorage.Data.Assets.Configs.Bear
-- Decompile time: 2.26 ms

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
    _id = "Bear",
    DisplayName = "Bear",
    Icon = "rbxassetid://99309954423391",
    EarningRate = 240,
    IndexSpeedReward = 820,
    DropWeight = 0.3333333333333333,
    VisualOdds = 56.702784,
    ModelWeight = 220,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Bear Egg", Icon = "rbxassetid://75135783493246", GrowthTime = 120, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://117105848139359"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://117105848139359 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://112971811958973"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://112971811958973 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(0.32549020648002625, 0.23529411852359772, 0.125490203499794)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.32549020648002625, 0.23529411852359772, 0.125490203499794), 640}),
    table.freeze({Color3.new(0.1764705926179886, 0.14901961386203766, 0.125490203499794), 180}),
    table.freeze({Color3.new(0.364705890417099, 0.26274511218070984, 0.1725490242242813), 120}),
    table.freeze({Color3.new(0.8235294222831726, 0.7450980544090271, 0.5882353186607361), 45}),
    (table.freeze({Color3.new(0.9215686321258545, 0.9019607901573181, 0.843137264251709), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 84881266793081,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 88584063816692, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))