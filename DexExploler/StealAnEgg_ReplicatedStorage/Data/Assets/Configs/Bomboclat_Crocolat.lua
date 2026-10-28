-- Script path: ReplicatedStorage.Data.Assets.Configs.Bomboclat Crocolat
-- Decompile time: 1.82 ms

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
    _id = "Bomboclat Crocolat",
    DisplayName = "Bombo Croco",
    Icon = "rbxassetid://127751254795569",
    EarningRate = 20000000,
    IndexSpeedReward = 860000,
    DropWeight = 0.05,
    VisualOdds = 20,
    ModelWeight = 7000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1.5,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bombo Croco Egg",
        Icon = "rbxassetid://81000367959664",
        GrowthTime = 5400,
        WeightKg = 6,
        HideRarity = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://132827855432447"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://132827855432447 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://86256248170015"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://86256248170015 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.23529411852359772, 0.3450980484485626, 0.1882352977991104)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.23529411852359772, 0.3450980484485626, 0.1882352977991104), 990}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 82231882756292,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 71113129310717, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))