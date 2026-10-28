-- Script path: ReplicatedStorage.Data.Assets.Configs.Ankylosaurus
-- Decompile time: 2.46 ms

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
    _id = "Ankylosaurus",
    DisplayName = "Ankylosaurus",
    Icon = "rbxassetid://71901208958017",
    EarningRate = 120000,
    IndexSpeedReward = 330000,
    DropWeight = 0.5,
    VisualOdds = 7778.721339,
    ModelWeight = 2500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Ankylosaurus Egg",
        Icon = "rbxassetid://103179713771844",
        GrowthTime = 300,
        WeightKg = 2,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://71910623791893"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://71910623791893 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://115768568703296"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://115768568703296 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.3843137323856354, 0.3450980484485626, 0.364705890417099)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.3843137323856354, 0.3450980484485626, 0.364705890417099), 450}),
    table.freeze({Color3.new(0.37254902720451355, 0.3137255012989044, 0.23529411852359772), 210}),
    table.freeze({Color3.new(0.3137255012989044, 0.37254902720451355, 0.2549019753932953), 150}),
    table.freeze({Color3.new(0.5098039507865906, 0.45098039507865906, 0.3529411852359772), 120}),
    table.freeze({Color3.new(0.21568627655506134, 0.21568627655506134, 0.21568627655506134), 70}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 129507085485558,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 73050793707525, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))