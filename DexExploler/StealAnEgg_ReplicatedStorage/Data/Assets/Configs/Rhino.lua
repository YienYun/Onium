-- Script path: ReplicatedStorage.Data.Assets.Configs.Rhino
-- Decompile time: 2.00 ms

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
    _id = "Rhino",
    DisplayName = "Rhinotaur",
    Icon = "rbxassetid://137684641039927",
    EarningRate = 17500000,
    IndexSpeedReward = 3091608,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 35000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Rhinotaur Egg",
        Icon = "rbxassetid://117685498595422",
        GrowthTime = 1740,
        WeightKg = 2,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://100647587597239"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://100647587597239 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://98517843584316"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://98517843584316 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.23137255012989044, 0.21960784494876862, 0.23137255012989044)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.23137255012989044, 0.21960784494876862, 0.23137255012989044), 850}),
    table.freeze({Color3.new(0.27450981736183167, 0.21568627655506134, 0.1764705926179886), 90}),
    table.freeze({Color3.new(0.19607843458652496, 0.2549019753932953, 0.21568627655506134), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
return (freeze(v1))