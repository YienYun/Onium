-- Script path: ReplicatedStorage.Data.Assets.Configs.Koi
-- Decompile time: 2.20 ms

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
    _id = "Koi",
    DisplayName = "Koi",
    Icon = "rbxassetid://107805660657502",
    EarningRate = 12000000,
    IndexSpeedReward = 4122144,
    DropWeight = 0,
    VisualOdds = 5266000000000,
    ModelWeight = 120,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Koi Egg", Icon = "rbxassetid://107397947617386", GrowthTime = 1500, WeightKg = 3}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://88607416819948"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://88607416819948 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://85297314199675"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://85297314199675 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.9490196108818054, 0.9529411792755127, 0.9529411792755127)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.9490196108818054, 0.9529411792755127, 0.9529411792755127), 850}),
    table.freeze({Color3.new(1, 0.8392156958580017, 0.47058823704719543), 90}),
    table.freeze({Color3.new(0.4313725531101227, 0.4313725531101227, 0.47058823704719543), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 91336069879459,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
return (freeze(v1))