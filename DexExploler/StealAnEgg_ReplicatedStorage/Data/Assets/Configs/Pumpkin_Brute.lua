-- Script path: ReplicatedStorage.Data.Assets.Configs.Pumpkin Brute
-- Decompile time: 1.81 ms

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
    _id = "Pumpkin Brute",
    DisplayName = "Pumpkin Brute",
    Icon = "rbxassetid://118229903531977",
    EarningRate = 3500000000,
    IndexSpeedReward = 640,
    DropWeight = 0.4,
    VisualOdds = 2.5,
    ModelWeight = 58500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Pumpkin Brute Egg",
        Icon = "rbxassetid://84594069243792",
        ModelName = "Pumpkin Brute Egg",
        GrowthTime = 25200,
        WeightKg = 6,
        HideRarity = false,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://103840666930791"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://103840666930791 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://87399511158640"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://87399511158640 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(1, 1, 1)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.new(1, 1, 1), 10})})
return (freeze(v1))