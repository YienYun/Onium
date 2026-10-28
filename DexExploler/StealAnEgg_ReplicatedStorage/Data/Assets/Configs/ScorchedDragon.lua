-- Script path: ReplicatedStorage.Data.Assets.Configs.ScorchedDragon
-- Decompile time: 2.20 ms

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
    _id = "ScorchedDragon",
    DisplayName = "Scorched Dragon",
    Icon = "rbxassetid://71785777924134",
    EarningRate = 35000000,
    IndexSpeedReward = 150000,
    DropWeight = 0,
    VisualOdds = 1000,
    ModelWeight = 120000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Dragon's Egg",
        Icon = "rbxassetid://114970669202722",
        GrowthTime = 10800,
        WeightKg = 40,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://85591916692734"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://85591916692734 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://95766204290612"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://95766204290612 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.3529411852359772, 0.2980392277240753, 0.25882354378700256)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.3529411852359772, 0.2980392277240753, 0.25882354378700256), 700}),
    table.freeze({Color3.new(0.20000000298023224, 0.18039216101169586, 0.16862745583057404), 180}),
    table.freeze({Color3.new(0.6666666865348816, 0.3333333432674408, 0.13725490868091583), 108}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 140401695659406,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99984406249141, Data = table.freeze({MaxDistance = 30, Volume = 1.5})})
return (freeze(v1))