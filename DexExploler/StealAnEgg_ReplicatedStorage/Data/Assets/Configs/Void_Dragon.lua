-- Script path: ReplicatedStorage.Data.Assets.Configs.Void Dragon
-- Decompile time: 3.36 ms

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
    _id = "Void Dragon",
    DisplayName = "Void Dragon",
    Icon = "rbxassetid://140262099495529",
    EarningRate = 120000000,
    IndexSpeedReward = 40000,
    DropWeight = 0,
    VisualOdds = 5000,
    ModelWeight = 12000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({DisplayName = "Dragon Egg", Icon = "rbxassetid://124581147164560", GrowthTime = 60, WeightKg = 5}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://137162488295849"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://137162488295849 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://115568355078468"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://115568355078468 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(0.19607843458652496, 0.1568627506494522, 0.27450981736183167)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.19607843458652496, 0.1568627506494522, 0.27450981736183167), 700}),
    table.freeze({Color3.new(0.35686275362968445, 0.239215686917305, 0.4588235318660736), 180}),
    table.freeze({Color3.new(0.5490196347236633, 0.35686275362968445, 0.6235294342041016), 108}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 95640392463828,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 0.97, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99984406249141, Data = table.freeze({MaxDistance = 30, Volume = 1.5})})
return (freeze(v1))