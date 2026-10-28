-- Script path: ReplicatedStorage.Data.Assets.Configs.Spike
-- Decompile time: 1.90 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 8 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 10 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Spike",
    DisplayName = "Spike",
    Icon = "rbxassetid://80985497889360",
    EarningRate = 15000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 2.564102564,
    ModelWeight = 250,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Spike Egg",
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
local u20 = "rbxassetid://110718459245771"
local success = pcall(function() -- Line: 10 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://110718459245771 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://73218249712397"
local success_2 = pcall(function() -- Line: 10 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://73218249712397 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.fromRGB(252, 129, 45)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(252, 129, 45), 80}),
    table.freeze({Color3.fromRGB(204, 150, 76), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
v1.WalkSound = table.freeze({
    SoundId = 80203665065178,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 90564893555864, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))