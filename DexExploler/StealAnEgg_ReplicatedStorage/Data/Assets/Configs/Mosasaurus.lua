-- Script path: ReplicatedStorage.Data.Assets.Configs.Mosasaurus
-- Decompile time: 3.02 ms

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
    _id = "Mosasaurus",
    DisplayName = "Mosasaurus",
    Icon = "rbxassetid://124293259998827",
    EarningRate = 180000000,
    IndexSpeedReward = 600000,
    DropWeight = 0.55,
    VisualOdds = 2773109151.841,
    ModelWeight = 30000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Mosasaurus Egg",
        Icon = "rbxassetid://110731551346220",
        GrowthTime = 21600,
        WeightKg = 6,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://130987511514994"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://130987511514994 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://92570452388491"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://92570452388491 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(0.32156863808631897, 0.3686274588108063, 0.4941176474094391)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.32156863808631897, 0.3686274588108063, 0.4941176474094391), 540}),
    table.freeze({Color3.new(0.1764705926179886, 0.29411765933036804, 0.37254902720451355), 190}),
    table.freeze({Color3.new(0.23529411852359772, 0.3333333432674408, 0.29411765933036804), 120}),
    table.freeze({Color3.new(0.1568627506494522, 0.1764705926179886, 0.19607843458652496), 100}),
    table.freeze({Color3.new(0.4588235318660736, 0.4000000059604645, 0.21176470816135406), 120}),
    table.freeze({Color3.new(0.529411792755127, 0.5490196347236633, 0.529411792755127), 50}),
    table.freeze({Color3.new(1, 0, 0), 10}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.RandomIdleSound = table.freeze({SoundId = 110377151729054, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))