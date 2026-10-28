-- Script path: ReplicatedStorage.Data.Assets.Configs.Frog
-- Decompile time: 2.76 ms

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
    _id = "Frog",
    DisplayName = "Frog",
    Icon = "rbxassetid://114669220150056",
    EarningRate = 3,
    IndexSpeedReward = 2000,
    DropWeight = 0.2,
    VisualOdds = 159.607838,
    ModelWeight = 3,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Frog Egg", Icon = "rbxassetid://103297453814736", GrowthTime = 15, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://117840973653687"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://117840973653687 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://90603625106827"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://90603625106827 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Common
v1.BaseModelColor = Color3.new(0.29411765933036804, 0.5921568870544434, 0.29411765933036804)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.29411765933036804, 0.5921568870544434, 0.29411765933036804), 620}),
    table.freeze({Color3.new(0.4117647111415863, 0.5098039507865906, 0.21568627655506134), 170}),
    table.freeze({Color3.new(0.37254902720451355, 0.3137255012989044, 0.1764705926179886), 95}),
    table.freeze({Color3.new(0.886274516582489, 0.13725490868091583, 1), 65}),
    table.freeze({Color3.new(0.21568627655506134, 0.47058823704719543, 0.47058823704719543), 35}),
    table.freeze({Color3.new(0.1568627506494522, 0.1764705926179886, 0.13725490868091583), 15}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 137308803652619,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 2.1}),
})
v1.RandomIdleSound = table.freeze({SoundId = 105312001208106, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))