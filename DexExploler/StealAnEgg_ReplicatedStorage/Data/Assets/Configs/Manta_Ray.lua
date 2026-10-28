-- Script path: ReplicatedStorage.Data.Assets.Configs.Manta Ray
-- Decompile time: 2.00 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 9 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 11 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Manta Ray",
    DisplayName = "Spirit Manta",
    Icon = "rbxassetid://76920182177298",
    EarningRate = 75000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 4.166666667,
    ModelWeight = 450,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Spirit Manta Egg",
        Icon = "rbxassetid://113826857989447",
        ModelName = "Depths Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://72007957253168"
local success = pcall(function() -- Line: 11 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://72007957253168 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://118098972084969"
local success_2 = pcall(function() -- Line: 11 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://118098972084969 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.fromRGB(47, 79, 113)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(47, 79, 113), 80}),
    table.freeze({Color3.fromRGB(63, 104, 110), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
v1.WalkSound = table.freeze({
    SoundId = 114002227385562,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 80432037767379, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))