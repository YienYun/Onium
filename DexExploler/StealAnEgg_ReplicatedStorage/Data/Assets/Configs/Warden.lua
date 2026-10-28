-- Script path: ReplicatedStorage.Data.Assets.Configs.Warden
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
    _id = "Warden",
    DisplayName = "King Snake",
    Icon = "rbxassetid://82294183801565",
    EarningRate = 3500000,
    IndexSpeedReward = 18000,
    DropWeight = 0.125,
    VisualOdds = 1652583.9179961935,
    ModelWeight = 10000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "King Snake Egg",
        Icon = "rbxassetid://102674774717128",
        GrowthTime = 5400,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://82447191024805"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://82447191024805 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://127172203925868"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://127172203925868 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.2705882489681244, 0.40784314274787903, 0.11764705926179886)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.2705882489681244, 0.40784314274787903, 0.11764705926179886), 990}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 112166870345373,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 79072253253403, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))