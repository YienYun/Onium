-- Script path: ReplicatedStorage.Data.Assets.Configs.Demon Imp
-- Decompile time: 1.58 ms

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
    _id = "Demon Imp",
    DisplayName = "Demon Imp",
    Icon = "rbxassetid://137458446707590",
    EarningRate = 700000,
    IndexSpeedReward = 900000,
    DropWeight = 0,
    VisualOdds = 2.38,
    ModelWeight = 45000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Demonic Egg",
        Icon = "rbxassetid://109846660752456",
        GrowthTime = 50400,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://72081259853723"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://72081259853723 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://116257151425403"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://116257151425403 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.3607843220233917, 0.0941176488995552, 0.11764705926179886)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.3607843220233917, 0.0941176488995552, 0.11764705926179886), 1000}),
})
return (freeze(v1))