-- Script path: ReplicatedStorage.Data.Assets.Configs.Mammoth
-- Decompile time: 2.49 ms

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
    _id = "Mammoth",
    DisplayName = "Mammoth",
    Icon = "rbxassetid://127045436214447",
    EarningRate = 42000,
    IndexSpeedReward = 19200,
    DropWeight = 0,
    VisualOdds = 12000000,
    ModelWeight = 2000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Mammoth Egg", Icon = "rbxassetid://99020285854980", GrowthTime = 300, WeightKg = 4}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://96559517682950"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://96559517682950 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://71037817684116"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://71037817684116 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.20392157137393951, 0.13333334028720856, 0.09019608050584793)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.20392157137393951, 0.13333334028720856, 0.09019608050584793), 620}),
    table.freeze({Color3.new(0.3529411852359772, 0.23529411852359772, 0.13725490868091583), 210}),
    table.freeze({Color3.new(0.529411792755127, 0.37254902720451355, 0.21568627655506134), 120}),
    table.freeze({Color3.new(0.7450980544090271, 0.6470588445663452, 0.4901960790157318), 40}),
    table.freeze({Color3.new(0.10980392247438431, 0.09803921729326248, 0.08627451211214066), 10}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 87980387017956,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 98423116392516, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))