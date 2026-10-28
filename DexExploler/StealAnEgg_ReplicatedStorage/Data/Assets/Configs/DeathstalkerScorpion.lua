-- Script path: ReplicatedStorage.Data.Assets.Configs.DeathstalkerScorpion
-- Decompile time: 2.30 ms

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
    _id = "DeathstalkerScorpion",
    DisplayName = "Scorpion",
    Icon = "rbxassetid://95410883489917",
    EarningRate = 18500,
    IndexSpeedReward = 14400,
    DropWeight = 0.2,
    VisualOdds = 35911.763516,
    ModelWeight = 75,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Scorpion Egg", Icon = "rbxassetid://94810083404486", GrowthTime = 300, WeightKg = 3}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://85777917853482"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://85777917853482 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://73290619201848"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://73290619201848 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.8352941274642944, 0.6313725709915161, 0.364705890417099)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.9176470637321472, 0.6941176652908325, 0.4000000059604645), 520}),
    table.freeze({Color3.new(0.686274528503418, 0.47058823704719543, 0.2549019753932953), 220}),
    table.freeze({Color3.new(0.7490196228027344, 0.5137255191802979, 0.35686275362968445), 150}),
    table.freeze({Color3.new(0.8627451062202454, 0.8039215803146362, 0.5882353186607361), 30}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 98032095284026,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 82428421778817, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))