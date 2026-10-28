-- Script path: ReplicatedStorage.Data.Assets.Configs.Finned Thresher
-- Decompile time: 2.12 ms

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
    _id = "Finned Thresher",
    DisplayName = "Shark",
    Icon = "rbxassetid://125497863961128",
    EarningRate = 15000,
    IndexSpeedReward = 90000,
    DropWeight = 0,
    VisualOdds = 9500000000,
    ModelWeight = 450,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Shark Egg", Icon = "rbxassetid://71615245424079", GrowthTime = 240, WeightKg = 6}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://127775181505316"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://127775181505316 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://76392180822636"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://76392180822636 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.new(0, 0.27843138575553894, 0.4274509847164154)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0, 0.27843138575553894, 0.4274509847164154), 610}),
    table.freeze({Color3.new(0.1764705926179886, 0.29411765933036804, 0.3529411852359772), 190}),
    table.freeze({Color3.new(0.0784313753247261, 0.1764705926179886, 0.27450981736183167), 70}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.RandomIdleSound = table.freeze({SoundId = 71821986721113, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))