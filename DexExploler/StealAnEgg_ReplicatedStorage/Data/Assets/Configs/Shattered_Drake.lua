-- Script path: ReplicatedStorage.Data.Assets.Configs.Shattered Drake
-- Decompile time: 2.08 ms

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
    _id = "Shattered Drake",
    DisplayName = "Shattered Drake",
    Icon = "rbxassetid://133460635177491",
    EarningRate = 800000000,
    IndexSpeedReward = 65000,
    DropWeight = 0,
    VisualOdds = 25000000,
    ModelWeight = 30000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Shattered Drake Egg",
        Icon = "rbxassetid://124927737636564",
        ModelName = "Crystal Egg",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://89629859180827"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://89629859180827 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://93157054599286"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://93157054599286 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.fromRGB(0, 0, 0)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(0, 0, 0), 850}),
    table.freeze({Color3.fromRGB(187, 107, 198), 90}),
    table.freeze({Color3.fromRGB(152, 86, 168), 48}),
    (table.freeze({Color3.fromRGB(57, 1, 68), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 127063996949067,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 88679077900730, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))