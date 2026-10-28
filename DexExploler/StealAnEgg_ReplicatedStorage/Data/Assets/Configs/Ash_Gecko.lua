-- Script path: ReplicatedStorage.Data.Assets.Configs.Ash Gecko
-- Decompile time: 2.66 ms

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
    _id = "Ash Gecko",
    DisplayName = "Lava Gecko",
    Icon = "rbxassetid://72012424724645",
    EarningRate = 180,
    IndexSpeedReward = 24000,
    DropWeight = 0.5,
    VisualOdds = 89779408.791,
    ModelWeight = 14,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Lava Gecko Egg",
        Icon = "rbxassetid://133042706475767",
        GrowthTime = 60,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://74003246937640"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://74003246937640 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://105897036611424"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://105897036611424 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.2666666805744171, 0.23137255012989044, 0.23529411852359772)
v1.PossibleModelColors = table.freeze({})
v1.WalkSound = table.freeze({
    SoundId = 105238337386015,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 84932782868068, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))