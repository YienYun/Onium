-- Script path: ReplicatedStorage.Data.Assets.Configs.Eye Bat
-- Decompile time: 1.82 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = Color3.fromRGB(255, 255, 255)

local function makeAnimation(a1) -- Line: 12 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 14 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v2 = {
    _id = "Eye Bat",
    DisplayName = "Eye Bat #021",
    Icon = "rbxassetid://130300416520896",
    EarningRate = 115000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 22000000000,
    ModelWeight = 1234,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({DisplayName = "Eye Bat Egg", Icon = "rbxassetid://126720584893394", GrowthTime = 900, WeightKg = 6}),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://86049546260358"
local success = pcall(function() -- Line: 14 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://86049546260358 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://108590769242586"
local success_2 = pcall(function() -- Line: 14 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://108590769242586 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Legendary
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
v2.WalkSound = table.freeze({
    SoundId = 100301199908418,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v2.RandomIdleSound = table.freeze({SoundId = 116682434430691, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v2))