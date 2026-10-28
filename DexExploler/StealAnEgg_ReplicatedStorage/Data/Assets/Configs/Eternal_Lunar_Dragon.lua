-- Script path: ReplicatedStorage.Data.Assets.Configs.Eternal Lunar Dragon
-- Decompile time: 2.22 ms

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
    _id = "Eternal Lunar Dragon",
    DisplayName = "Eternal Lunar Dragon",
    Icon = "rbxassetid://93762296316916",
    EarningRate = 250000000,
    IndexSpeedReward = 1920000,
    DropWeight = 20,
    VisualOdds = 28729410813070.773,
    ModelWeight = 60000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Eternal Lunar Dragon Egg",
        Icon = "rbxassetid://76095389378180",
        GrowthTime = 25200,
        WeightKg = 9,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://118874129580676"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://118874129580676 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://139537878984191"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://139537878984191 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468), 700}),
    table.freeze({Color3.new(0.1921568661928177, 0.2078431397676468, 0.27843138575553894), 200}),
    table.freeze({Color3.new(0.20000000298023224, 0.23137255012989044, 0.23529411852359772), 100}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 95249764844448,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 126402073411522, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))