-- Script path: ReplicatedStorage.Data.Assets.Configs.Depths Manta Ray
-- Decompile time: 1.94 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 10 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 12 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Depths Manta Ray",
    DisplayName = "Luminous Spirit Manta",
    Icon = "rbxassetid://98909828891785",
    EarningRate = 500000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 412.5,
    ModelWeight = 450,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Luminous Spirit Manta Egg",
        Icon = "rbxassetid://103020287697704",
        ModelName = "Depths Reroll Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://105989677028261"
local success = pcall(function() -- Line: 12 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://105989677028261 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://101971494384327"
local success_2 = pcall(function() -- Line: 12 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://101971494384327 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(75, 40, 135)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(75, 40, 135), 80}),
    table.freeze({Color3.fromRGB(86, 54, 120), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
v1.WalkSound = table.freeze({
    SoundId = 129118606287387,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 112060333280301, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))