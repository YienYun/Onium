-- Script path: ReplicatedStorage.Data.Assets.Configs.Snowy Owl
-- Decompile time: 2.06 ms

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
    _id = "Snowy Owl",
    DisplayName = "Snowy Owl",
    Icon = "rbxassetid://123321230182882",
    EarningRate = 7500000,
    IndexSpeedReward = 3778632,
    DropWeight = 0,
    VisualOdds = 1724000000000,
    ModelWeight = 20,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Snowy Owl Egg",
        Icon = "rbxassetid://110224614368360",
        GrowthTime = 900,
        WeightKg = 2,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://89629292005887"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://89629292005887 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://131028384806119"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://131028384806119 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.8156862854957581, 0.7921568751335144, 0.7215686440467834)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8156862854957581, 0.7921568751335144, 0.7215686440467834), 850}),
    table.freeze({Color3.new(0.6666666865348816, 0.529411792755127, 0.37254902720451355), 90}),
    table.freeze({Color3.new(0.47058823704719543, 0.47058823704719543, 0.4901960790157318), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 96920277869957,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))