-- Script path: ReplicatedStorage.Data.Assets.Configs.Gorilla
-- Decompile time: 2.27 ms

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
    _id = "Gorilla",
    DisplayName = "Gorilla",
    Icon = "rbxassetid://117411686345819",
    EarningRate = 4800,
    IndexSpeedReward = 9900,
    DropWeight = 0.3333333333333333,
    VisualOdds = 294259.18734308693,
    ModelWeight = 190,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Gorilla Egg", Icon = "rbxassetid://83787014176548", GrowthTime = 120, WeightKg = 3}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://74956622750880"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://74956622750880 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://97501167000723"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://97501167000723 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.new(0.15294118225574493, 0.15294118225574493, 0.15294118225574493)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.15294118225574493, 0.15294118225574493, 0.15294118225574493), 720}),
    table.freeze({Color3.new(0.2549019753932953, 0.2549019753932953, 0.2549019753932953), 180}),
    table.freeze({Color3.new(0.4117647111415863, 0.4117647111415863, 0.3921568691730499), 80}),
    table.freeze({Color3.new(0.09803921729326248, 0.09803921729326248, 0.09803921729326248), 20}),
    (table.freeze({Color3.new(0.929411768913269, 0.9176470637321472, 0.9176470637321472), 2})),
})
v1.WalkSound = table.freeze({
    SoundId = 138687597486095,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 131453269610048, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))