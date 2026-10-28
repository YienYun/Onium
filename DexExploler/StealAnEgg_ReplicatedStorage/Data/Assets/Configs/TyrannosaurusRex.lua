-- Script path: ReplicatedStorage.Data.Assets.Configs.TyrannosaurusRex
-- Decompile time: 2.75 ms

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
    _id = "TyrannosaurusRex",
    DisplayName = "TRex",
    Icon = "rbxassetid://123124934383954",
    EarningRate = 25000000,
    IndexSpeedReward = 420000,
    DropWeight = 0.3333333333333333,
    VisualOdds = 134669113.186,
    ModelWeight = 7500,
    WalkAnimationReferenceSpeed = 16,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "TRex Egg", Icon = "rbxassetid://124390268104324", GrowthTime = 9000, WeightKg = 5}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://85804925095766"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://85804925095766 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://117274313338090"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://117274313338090 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(227, 155, 111)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(227, 155, 111), 470}),
    table.freeze({Color3.new(0.37254902720451355, 0.29411765933036804, 0.1764705926179886), 210}),
    table.freeze({Color3.new(0.27450981736183167, 0.37254902720451355, 0.21568627655506134), 140}),
    table.freeze({Color3.new(0.5686274766921997, 0.47058823704719543, 0.27450981736183167), 100}),
    table.freeze({Color3.new(0.4431372582912445, 0.40392157435417175, 0.33725491166114807), 60}),
    table.freeze({Color3.new(0.16862745583057404, 0.25882354378700256, 0.35686275362968445), 60}),
    table.freeze({Color3.new(0.6274510025978088, 0.27450981736183167, 0.1764705926179886), 20}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 114165406336338,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 81004933444699, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))