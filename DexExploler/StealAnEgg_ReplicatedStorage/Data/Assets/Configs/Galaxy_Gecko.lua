-- Script path: ReplicatedStorage.Data.Assets.Configs.Galaxy Gecko
-- Decompile time: 2.16 ms

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
    _id = "Galaxy Gecko",
    DisplayName = "Cosmic Gecko",
    Icon = "rbxassetid://115834854015858",
    EarningRate = 30000,
    IndexSpeedReward = 1080000,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 18,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Cosmic Gecko Egg",
        Icon = "rbxassetid://107132653319667",
        GrowthTime = 240,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://138853141977630"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://138853141977630 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://99128282956160"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://99128282956160 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.new(0.24313725531101227, 0.3294117748737335, 0.40392157435417175)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.24313725531101227, 0.3294117748737335, 0.40392157435417175), 900}),
    table.freeze({Color3.new(0.0784313753247261, 0.11764705926179886, 0.21568627655506134), 100}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 85688845524024,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 130520753193462, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))