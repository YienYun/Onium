-- Script path: ReplicatedStorage.Data.Assets.Configs.El Maja
-- Decompile time: 1.81 ms

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
    _id = "El Maja",
    DisplayName = "El Maja",
    Icon = "rbxassetid://77518688092604",
    EarningRate = 130000000,
    IndexSpeedReward = 180000,
    DropWeight = 0.125,
    VisualOdds = 66391535236.3381,
    ModelWeight = 90000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "El Maja Egg",
        Icon = "rbxassetid://123897639279253",
        GrowthTime = 19800,
        WeightKg = 6,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://132181117287223"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://132181117287223 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://75800532076044"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://75800532076044 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(0, 0.6000000238418579, 1)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0, 0.6000000238418579, 1), 900}),
    table.freeze({Color3.new(0, 0.1764705926179886, 0.37254902720451355), 100}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.RandomIdleSound = table.freeze({SoundId = 115062059439564, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))