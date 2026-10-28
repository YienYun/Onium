-- Script path: ReplicatedStorage.Data.Assets.Configs.Bronto
-- Decompile time: 2.53 ms

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
    _id = "Bronto",
    DisplayName = "Bronto",
    Icon = "rbxassetid://97379364436568",
    EarningRate = 1500000,
    IndexSpeedReward = 300000,
    DropWeight = 0.25,
    VisualOdds = 10773529.055,
    ModelWeight = 35000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Bronto Egg", Icon = "rbxassetid://102498197407436", GrowthTime = 660, WeightKg = 4}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://99676847051723"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://99676847051723 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://93614636566946"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://93614636566946 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.4117647111415863, 0.41960784792900085, 0.4745098054409027)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.4117647111415863, 0.41960784792900085, 0.4745098054409027), 440}),
    table.freeze({Color3.new(0.4313725531101227, 0.37254902720451355, 0.27450981736183167), 210}),
    table.freeze({Color3.new(0.37254902720451355, 0.45098039507865906, 0.29411765933036804), 150}),
    table.freeze({Color3.new(0.5686274766921997, 0.5098039507865906, 0.37254902720451355), 120}),
    table.freeze({Color3.new(0.2549019753932953, 0.2549019753932953, 0.27450981736183167), 80}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 104739285394756,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 90507633553833, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))