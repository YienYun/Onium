-- Script path: ReplicatedStorage.Data.Assets.Configs.Red Panda
-- Decompile time: 2.05 ms

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
    _id = "Red Panda",
    DisplayName = "Red Panda",
    Icon = "rbxassetid://87532519318091",
    EarningRate = 450000,
    IndexSpeedReward = 3435120,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 25,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Red Panda Egg",
        Icon = "rbxassetid://119131393871771",
        GrowthTime = 480,
        WeightKg = 2,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://98137834403940"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://98137834403940 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://102540312255963"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://102540312255963 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.8392156958580017, 0.3843137323856354, 0.14901961386203766)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8392156958580017, 0.3843137323856354, 0.14901961386203766), 850}),
    table.freeze({Color3.new(0.6274510025978088, 0.27450981736183167, 0.11764705926179886), 90}),
    table.freeze({Color3.new(0.8823529481887817, 0.5882353186607361, 0.3137255012989044), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 80776140827842,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))