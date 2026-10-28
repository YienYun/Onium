-- Script path: ReplicatedStorage.Data.Assets.Configs.Bell Ghost
-- Decompile time: 1.90 ms

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
    _id = "Bell Ghost",
    DisplayName = "Bell Scream",
    Icon = "rbxassetid://86468060543012",
    EarningRate = 1000000,
    IndexSpeedReward = 640,
    DropWeight = 0.4,
    VisualOdds = 2.5,
    ModelWeight = 12000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bell Scream Egg",
        Icon = "rbxassetid://98567615969358",
        ModelName = "Bell Ghost Egg",
        GrowthTime = 360,
        WeightKg = 6,
        HideRarity = false,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://114842519728388"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://114842519728388 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://120885598795995"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://120885598795995 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(1, 1, 1)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.new(1, 1, 1), 10})})
v1.WalkSound = table.freeze({
    SoundId = 115764722116712,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 132743467440874, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))