-- Script path: ReplicatedStorage.Data.Assets.Configs.Shardwing
-- Decompile time: 2.24 ms

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
    _id = "Shardwing",
    DisplayName = "Shardwing",
    Icon = "rbxassetid://127569270595542",
    EarningRate = 145000000,
    IndexSpeedReward = 32000,
    DropWeight = 0,
    VisualOdds = 1200000,
    ModelWeight = 9500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Shardwing Egg",
        Icon = "rbxassetid://124927737636564",
        ModelName = "Crystal Egg",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://116924541763188"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://116924541763188 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://117987331989460"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://117987331989460 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(255, 255, 255)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(255, 255, 255), 850}),
    table.freeze({Color3.fromRGB(69, 33, 250), 90}),
    table.freeze({Color3.fromRGB(187, 107, 198), 48}),
    (table.freeze({Color3.fromRGB(137, 86, 198), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 104361388663112,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 133591606094699, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))