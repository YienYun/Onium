-- Script path: ReplicatedStorage.Data.Assets.Configs.Raccoon
-- Decompile time: 2.28 ms

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
    _id = "Raccoon",
    DisplayName = "Raccoon",
    Icon = "rbxassetid://108876887480947",
    EarningRate = 45,
    IndexSpeedReward = 620,
    DropWeight = 0.16666666666666666,
    VisualOdds = 8.44701453885662,
    ModelWeight = 19,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Raccoon Egg", Icon = "rbxassetid://125284294936901", GrowthTime = 50, WeightKg = 1}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://110452042491667"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://110452042491667 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://134919972715929"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://134919972715929 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.35686275362968445, 0.364705890417099, 0.4117647111415863)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.35686275362968445, 0.364705890417099, 0.4117647111415863), 760}),
    table.freeze({Color3.new(0.2549019753932953, 0.2549019753932953, 0.27450981736183167), 140}),
    table.freeze({Color3.new(0.5098039507865906, 0.4901960790157318, 0.45098039507865906), 70}),
    table.freeze({Color3.new(0.25882354378700256, 0.250980406999588, 0.250980406999588), 30}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 83241021513756,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 125958086678055, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))