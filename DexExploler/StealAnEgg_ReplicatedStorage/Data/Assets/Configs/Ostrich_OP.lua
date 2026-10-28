-- Script path: ReplicatedStorage.Data.Assets.Configs.Ostrich OP
-- Decompile time: 2.85 ms

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
    _id = "Ostrich OP",
    DisplayName = "Ostrich",
    Icon = "rbxassetid://110438227069985",
    EarningRate = 148500000,
    IndexSpeedReward = 640,
    DropWeight = 0,
    VisualOdds = 2.5,
    ModelWeight = 8500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Ostrich Egg",
        Icon = "rbxassetid://105363290726741",
        GrowthTime = 900,
        WeightKg = 6,
        HideRarity = true,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://119115088508006"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://119115088508006 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://101084762282057"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://101084762282057 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.768627, 0.298039, 0.254902)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(196, 76, 65), 124}),
    table.freeze({Color3.fromRGB(51, 88, 130), 124}),
    table.freeze({Color3.fromRGB(213, 91, 34), 124}),
    table.freeze({Color3.fromRGB(123, 0, 123), 124}),
    table.freeze({Color3.fromRGB(52, 142, 64), 124}),
    table.freeze({Color3.fromRGB(255, 176, 0), 124}),
    table.freeze({Color3.fromRGB(255, 102, 204), 124}),
    table.freeze({Color3.fromRGB(99, 226, 255), 124}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 115015002616480,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 121742630798975, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))