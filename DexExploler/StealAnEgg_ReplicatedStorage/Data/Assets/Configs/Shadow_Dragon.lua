-- Script path: ReplicatedStorage.Data.Assets.Configs.Shadow Dragon
-- Decompile time: 2.19 ms

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
    _id = "Shadow Dragon",
    DisplayName = "Shadow Dragon",
    Icon = "rbxassetid://95217633876957",
    EarningRate = 25000000,
    IndexSpeedReward = 20000,
    DropWeight = 0,
    VisualOdds = 500,
    ModelWeight = 10000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({DisplayName = "Dragon Egg", Icon = "rbxassetid://124581147164560", GrowthTime = 60, WeightKg = 5}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://131290563384917"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://131290563384917 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://125181480859908"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://125181480859908 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.33725491166114807, 0.32549020648002625, 0.3333333432674408)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.33725491166114807, 0.32549020648002625, 0.3333333432674408), 650}),
    table.freeze({Color3.new(0.21568627655506134, 0.20392157137393951, 0.23529411852359772), 230}),
    table.freeze({Color3.new(0.07058823853731155, 0.07058823853731155, 0.08627451211214066), 108}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 95640392463828,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1.05, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99984406249141, Data = table.freeze({MaxDistance = 30, Volume = 1.5})})
return (freeze(v1))