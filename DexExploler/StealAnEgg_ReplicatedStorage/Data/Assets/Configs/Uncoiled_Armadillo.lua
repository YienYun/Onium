-- Script path: ReplicatedStorage.Data.Assets.Configs.Uncoiled Armadillo
-- Decompile time: 1.83 ms

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
    _id = "Uncoiled Armadillo",
    DisplayName = "Uncoiled Armadillo",
    Icon = "rbxassetid://118238377930162",
    EarningRate = 625000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 22000000000,
    ModelWeight = 1234,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Uncoiled Armadillo Egg",
        Icon = "rbxassetid://98361525003865",
        GrowthTime = 900,
        WeightKg = 6,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://125898874530988"
local success = pcall(function() -- Line: 14 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://125898874530988 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://115772030888542"
local success_2 = pcall(function() -- Line: 14 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://115772030888542 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
v2.WalkSound = table.freeze({
    SoundId = 124924924476422,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v2.RandomIdleSound = table.freeze({SoundId = 126373309661299, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v2))