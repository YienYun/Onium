-- Script path: ReplicatedStorage.Data.Assets.Configs.Colossal Mammoth
-- Decompile time: 1.65 ms

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
    _id = "Colossal Mammoth",
    DisplayName = "King Mammoth",
    Icon = "rbxassetid://95135851583684",
    EarningRate = 400000,
    IndexSpeedReward = 22400,
    DropWeight = 0.2,
    VisualOdds = 17955881.758,
    ModelWeight = 25000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "King Mammoth Egg",
        Icon = "rbxassetid://81868336511715",
        GrowthTime = 900,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://71312716272835"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://71312716272835 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://138490570661413"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://138490570661413 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v1.PossibleModelColors = table.freeze({})
v1.WalkSound = table.freeze({
    SoundId = 76916547885841,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 2}),
})
v1.RandomIdleSound = table.freeze({SoundId = 92104421508143, Data = table.freeze({MaxDistance = 20, Volume = 1.8})})
return (freeze(v1))