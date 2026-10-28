-- Script path: ReplicatedStorage.Data.Assets.Configs.Ascended Vermilion Phoenix
-- Decompile time: 2.31 ms

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
    _id = "Ascended Vermilion Phoenix",
    DisplayName = "Phoenix",
    Icon = "rbxassetid://118067990008425",
    EarningRate = 85000000,
    IndexSpeedReward = 48000,
    DropWeight = 0.1111111111111111,
    VisualOdds = 1077352905.49,
    ModelWeight = 2500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Phoenix Egg",
        Icon = "rbxassetid://108172622989366",
        GrowthTime = 16200,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://85057156715276"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://85057156715276 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://104273848115084"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://104273848115084 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(0.6392157077789307, 0.33725491166114807, 0.16470588743686676)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.6392157077789307, 0.33725491166114807, 0.16470588743686676), 440}),
    table.freeze({Color3.new(1, 0.48235294222831726, 0.18431372940540314), 210}),
    table.freeze({Color3.new(0.5098039507865906, 0.2549019753932953, 0.10588235408067703), 150}),
    table.freeze({Color3.new(0.7176470756530762, 0.30588236451148987, 0.07058823853731155), 120}),
    table.freeze({Color3.new(1, 0, 0), 80}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 74222673189312,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 78009543684733, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))