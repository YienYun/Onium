-- Script path: ReplicatedStorage.Data.Assets.Configs.Orca
-- Decompile time: 1.98 ms

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
    _id = "Orca",
    DisplayName = "Orca",
    Icon = "rbxassetid://90382263788089",
    EarningRate = 80000,
    IndexSpeedReward = 99000,
    DropWeight = 0,
    VisualOdds = 19000000000,
    ModelWeight = 1800,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Orca Egg", Icon = "rbxassetid://117521368420399", GrowthTime = 360, WeightKg = 6}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://127927181298183"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://127927181298183 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://118415860190284"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://118415860190284 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.06666667014360428, 0.06666667014360428, 0.06666667014360428)
v1.PossibleModelColors = table.freeze({})
v1.RandomIdleSound = table.freeze({SoundId = 119846357883093, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))