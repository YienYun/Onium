-- Script path: ReplicatedStorage.Data.Assets.Configs.Race Cheetah
-- Decompile time: 2.17 ms

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
    _id = "Race Cheetah",
    DisplayName = "Race Cheetah",
    Icon = "rbxassetid://125290288331645",
    EarningRate = 250000000,
    IndexSpeedReward = 30000,
    DropWeight = 0,
    VisualOdds = 1,
    ModelWeight = 400,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Race Cheetah Egg",
        Icon = "rbxassetid://140659206021481",
        GrowthTime = 240,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://75304334572494"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://75304334572494 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://74935455029922"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://74935455029922 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(255, 191, 43)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(255, 191, 43), 300}),
    table.freeze({Color3.fromRGB(148, 190, 129), 30}),
    table.freeze({Color3.fromRGB(215, 197, 154), 30}),
    (table.freeze({Color3.fromRGB(160, 95, 53), 30})),
})
v1.WalkSound = table.freeze({
    SoundId = 89052434554549,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 129805876689999, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))