-- Script path: ReplicatedStorage.Data.Assets.Configs.Cerberus
-- Decompile time: 2.15 ms

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
    _id = "Cerberus",
    DisplayName = "Cerberus",
    Icon = "rbxassetid://71959618623573",
    EarningRate = 8000000,
    IndexSpeedReward = 42000,
    DropWeight = 0.12,
    VisualOdds = 718235270.327,
    ModelWeight = 9000,
    WalkAnimationReferenceSpeed = 7,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "Cerberus Egg",
        Icon = "rbxassetid://111446060864628",
        GrowthTime = 7200,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://128670391346328"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://128670391346328 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://134754326183729"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://134754326183729 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.23137255012989044, 0.21176470816135406, 0.21176470816135406)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.23137255012989044, 0.21176470816135406, 0.21176470816135406), 950}),
    table.freeze({Color3.new(0.7058823704719543, 0.13725490868091583, 0.09803921729326248), 50}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 89456206295750,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 136351744983693, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))