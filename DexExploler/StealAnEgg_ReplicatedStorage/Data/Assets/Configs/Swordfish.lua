-- Script path: ReplicatedStorage.Data.Assets.Configs.Swordfish
-- Decompile time: 2.18 ms

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
    _id = "Swordfish",
    DisplayName = "Swordfish",
    Icon = "rbxassetid://103426699196063",
    EarningRate = 1100,
    IndexSpeedReward = 81000,
    DropWeight = 0.5,
    VisualOdds = 4910446705.478001,
    ModelWeight = 250,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Swordfish Egg",
        Icon = "rbxassetid://108314641239947",
        GrowthTime = 120,
        WeightKg = 6,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://79570633151364"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://79570633151364 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://103930506176496"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://103930506176496 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(0.22745098173618317, 0.2980392277240753, 0.38823530077934265)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.22745098173618317, 0.2980392277240753, 0.38823530077934265), 650}),
    table.freeze({Color3.new(0.4313725531101227, 0.572549045085907, 0.7098039388656616), 170}),
    table.freeze({Color3.new(0.13725490868091583, 0.21568627655506134, 0.3333333432674408), 120}),
    table.freeze({Color3.new(0.09803921729326248, 0.13725490868091583, 0.21568627655506134), 15}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.RandomIdleSound = table.freeze({SoundId = 96287155757786, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))