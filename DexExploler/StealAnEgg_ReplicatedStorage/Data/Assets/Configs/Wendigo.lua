-- Script path: ReplicatedStorage.Data.Assets.Configs.Wendigo
-- Decompile time: 2.52 ms

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
    _id = "Wendigo",
    DisplayName = "Wendigo",
    Icon = "rbxassetid://134637186116583",
    EarningRate = 15000000,
    IndexSpeedReward = 40000,
    DropWeight = 0,
    VisualOdds = 5000000,
    ModelWeight = 12000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Riftborn Egg",
        Icon = "rbxassetid://136340085637939",
        ModelName = "Riftborn Egg",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://72535019019919"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://72535019019919 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://105460764927533"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://105460764927533 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(83, 60, 255)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(83, 60, 255), 850}),
    table.freeze({Color3.fromRGB(105, 77, 220), 90}),
    table.freeze({Color3.fromRGB(42, 40, 61), 48}),
    (table.freeze({Color3.fromRGB(72, 52, 102), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 122192452632506,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 82387086630378, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))