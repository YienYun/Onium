-- Script path: ReplicatedStorage.Data.Assets.Configs.Duckling
-- Decompile time: 2.91 ms

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
    _id = "Duckling",
    DisplayName = "Duckling",
    Icon = "rbxassetid://81116137079823",
    EarningRate = 4,
    IndexSpeedReward = 2250,
    DropWeight = 0,
    VisualOdds = 190,
    ModelWeight = 3,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Duckling Egg", Icon = "rbxassetid://120651022174989", GrowthTime = 20, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://118496144381000"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://118496144381000 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://121924503798489"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://121924503798489 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Common
v1.BaseModelColor = Color3.new(0.5098039507865906, 0.4941176474094391, 0.32156863808631897)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.5098039507865906, 0.4941176474094391, 0.32156863808631897), 360}),
    table.freeze({Color3.new(1, 0.7921568751335144, 0.47843137383461), 480}),
    table.freeze({Color3.new(0.37254902720451355, 0.29411765933036804, 0.1764705926179886), 80}),
    table.freeze({Color3.new(0.9607843160629272, 0.9215686321258545, 0.7058823704719543), 60}),
    table.freeze({Color3.new(0.23529411852359772, 0.21568627655506134, 0.1764705926179886), 20}),
    (table.freeze({Color3.new(1, 1, 1), 20})),
})
v1.WalkSound = table.freeze({
    SoundId = 108170229428604,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.9}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99745906196706, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))