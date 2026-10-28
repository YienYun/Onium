-- Script path: ReplicatedStorage.Data.Assets.Configs.Kraken
-- Decompile time: 3.02 ms

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
    _id = "Kraken",
    DisplayName = "Kraken",
    Icon = "rbxassetid://136429320011912",
    EarningRate = 15000000,
    IndexSpeedReward = 144000,
    DropWeight = 0.14285714285714285,
    VisualOdds = 40284267734.10782,
    ModelWeight = 18000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Kraken Egg", Icon = "rbxassetid://114986552390612", GrowthTime = 8100, WeightKg = 6}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://77550298467205"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://77550298467205 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://125902579005259"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://125902579005259 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.7686274647712708, 0.1568627506494522, 0.10980392247438431)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.7686274647712708, 0.1568627506494522, 0.10980392247438431), 460}),
    table.freeze({Color3.new(0.47058823704719543, 0.21568627655506134, 0.3333333432674408), 190}),
    table.freeze({Color3.new(0.37254902720451355, 0.23529411852359772, 0.1764705926179886), 140}),
    table.freeze({Color3.new(0.7254902124404907, 0.4313725531101227, 0.27450981736183167), 110}),
    table.freeze({Color3.new(0.21568627655506134, 0.1764705926179886, 0.23529411852359772), 70}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 91640952661817,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99264926798032, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))