-- Script path: ReplicatedStorage.Data.Assets.Configs.Cyclops Gorilla
-- Decompile time: 1.95 ms

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
    _id = "Cyclops Gorilla",
    DisplayName = "Cosmic Gorilla",
    Icon = "rbxassetid://85663322244323",
    EarningRate = 180000,
    IndexSpeedReward = 1200000,
    DropWeight = 0.2,
    VisualOdds = 1723764648784.246,
    ModelWeight = 450,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Cosmic Gorilla Egg",
        Icon = "rbxassetid://116039419189340",
        GrowthTime = 420,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://75984141998333"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://75984141998333 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://92130515907598"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://92130515907598 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.3921568691730499, 0.4000000059604645, 0.5803921818733215)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.3921568691730499, 0.4000000059604645, 0.5803921818733215), 990}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 99927549101907,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 70967128852883, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))