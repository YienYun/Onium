-- Script path: ReplicatedStorage.Data.Assets.Configs.Chillin Chilli
-- Decompile time: 1.60 ms

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
    _id = "Chillin Chilli",
    DisplayName = "Chillin Chilli",
    Icon = "rbxassetid://107384783072333",
    EarningRate = 55000,
    IndexSpeedReward = 33000,
    DropWeight = 0.16666666666666666,
    VisualOdds = 478823513.551,
    ModelWeight = 30,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "Chillin Chilli Egg",
        Icon = "rbxassetid://139767472094255",
        GrowthTime = 420,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://113963889057275"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://113963889057275 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://129853773834110"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://129853773834110 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v1.PossibleModelColors = table.freeze({})
v1.WalkSound = table.freeze({
    SoundId = 108490077595826,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 115971008260367, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))