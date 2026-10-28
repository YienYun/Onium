-- Script path: ReplicatedStorage.Data.Assets.Configs.Turtle
-- Decompile time: 3.06 ms

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
    _id = "Turtle",
    DisplayName = "Turtle",
    Icon = "rbxassetid://90736612624734",
    EarningRate = 60,
    IndexSpeedReward = 2750,
    DropWeight = 0.3333333333333333,
    VisualOdds = 349.30572063219404,
    ModelWeight = 100,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Turtle Egg", Icon = "rbxassetid://132237234794333", GrowthTime = 50, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://79398133579699"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://79398133579699 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://116555747328509"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://116555747328509 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.364705890417099, 0.5254902243614197, 0.239215686917305)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.364705890417099, 0.5254902243614197, 0.239215686917305), 560}),
    table.freeze({Color3.new(0.3529411852359772, 0.3137255012989044, 0.1764705926179886), 220}),
    table.freeze({Color3.new(0.23529411852359772, 0.37254902720451355, 0.21568627655506134), 120}),
    table.freeze({Color3.new(0.5490196347236633, 0.45098039507865906, 0.2549019753932953), 75}),
    table.freeze({Color3.new(0.1764705926179886, 0.19607843458652496, 0.13725490868091583), 25}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 129596767024447,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))