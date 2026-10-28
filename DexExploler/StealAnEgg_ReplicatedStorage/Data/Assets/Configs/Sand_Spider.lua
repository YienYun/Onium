-- Script path: ReplicatedStorage.Data.Assets.Configs.Sand Spider
-- Decompile time: 2.17 ms

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
    _id = "Sand Spider",
    DisplayName = "Sand Spider",
    Icon = "rbxassetid://70412724408814",
    EarningRate = 16000,
    IndexSpeedReward = 12600,
    DropWeight = 0.16666666666666666,
    VisualOdds = 53867.64527500001,
    ModelWeight = 120,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Sand Spider Egg",
        Icon = "rbxassetid://86024313887428",
        GrowthTime = 240,
        WeightKg = 3,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://105987892350746"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://105987892350746 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://97154176315300"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://97154176315300 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.5176470875740051, 0.4274509847164154, 0.2549019753932953)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.5176470875740051, 0.4274509847164154, 0.2549019753932953), 670}),
    table.freeze({Color3.new(0.5686274766921997, 0.4117647111415863, 0.2549019753932953), 180}),
    table.freeze({Color3.new(0.8627451062202454, 0.7647058963775635, 0.5490196347236633), 100}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 110506317720110,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 126330135983232, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))