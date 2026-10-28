-- Script path: ReplicatedStorage.Data.Assets.Configs.Sharkodile
-- Decompile time: 1.75 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 6 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 8 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Sharkodile",
    DisplayName = "Sharkodile",
    Icon = "rbxassetid://120991125290188",
    EarningRate = 350000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 0,
    ModelWeight = 30000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Sharkodile Egg",
        Icon = "rbxassetid://121178065227483",
        ModelName = "Unstable",
        GrowthTime = 60,
        WeightKg = 1,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://120948009576895"
local success = pcall(function() -- Line: 8 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://120948009576895 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u32 = "rbxassetid://85146906074482"
local success_2 = pcall(function() -- Line: 8 -- upvalues: Animation_2 (val), u32 (val)
    Animation_2.AnimationId = u32
end)
if not success_2 then
    warn("Animation rbxassetid://85146906074482 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(84, 84, 71)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.fromRGB(84, 84, 71), 1})})
v1.WalkSound = table.freeze({
    SoundId = 114354670547200,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 99491822374029, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))