-- Script path: ReplicatedStorage.Data.Assets.Configs.Bananita Dolphinita
-- Decompile time: 1.97 ms

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
    _id = "Bananita Dolphinita",
    DisplayName = "Bananita Dolphinita",
    Icon = "rbxassetid://113957121441284",
    EarningRate = 400,
    IndexSpeedReward = 710,
    DropWeight = 0.26,
    VisualOdds = 3.8461538461538463,
    ModelWeight = 300,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bananita Dolphinita Egg",
        Icon = "rbxassetid://81000367959664",
        GrowthTime = 35,
        WeightKg = 6,
        HideRarity = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://123772280708936"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://123772280708936 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://88210160286814"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://88210160286814 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Epic
v1.BaseModelColor = Color3.new(0.35686275362968445, 0.43529412150382996, 0.5058823823928833)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.35686275362968445, 0.43529412150382996, 0.5058823823928833), 990}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 78702370861356,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 126732060046163, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))