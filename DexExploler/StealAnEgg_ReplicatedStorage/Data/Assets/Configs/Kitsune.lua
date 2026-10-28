-- Script path: ReplicatedStorage.Data.Assets.Configs.Kitsune
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
    _id = "Kitsune",
    DisplayName = "Kitsune",
    Icon = "rbxassetid://107842067813602",
    EarningRate = 1800000000,
    IndexSpeedReward = 6870240,
    DropWeight = 0,
    VisualOdds = 168336000000000,
    ModelWeight = 260,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Kitsune Egg",
        Icon = "rbxassetid://136779412524244",
        GrowthTime = 50400,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://120302895222735"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://120302895222735 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://128388967340982"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://128388967340982 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Divine
v1.BaseModelColor = Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598), 850}),
    table.freeze({Color3.new(0.9215686321258545, 0.7843137383460999, 0.5490196347236633), 90}),
    table.freeze({Color3.new(0.7450980544090271, 0.7450980544090271, 0.7843137383460999), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 130410188254836,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))