-- Script path: ReplicatedStorage.Data.Assets.Configs.Chicken
-- Decompile time: 1.77 ms

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
    _id = "Chicken",
    DisplayName = "Chicken",
    Icon = "rbxassetid://87733160598688",
    EarningRate = 1,
    IndexSpeedReward = 420,
    DropWeight = 0.5,
    VisualOdds = 2.154706,
    ModelWeight = 8,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Chicken Egg", Icon = "rbxassetid://118146808162748", GrowthTime = 10, WeightKg = 1}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://139122582247217"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://139122582247217 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://139560613766322"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://139560613766322 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Common
v1.BaseModelColor = Color3.new(0.9725490212440491, 0.9725490212440491, 0.9725490212440491)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.9725490212440491, 0.9725490212440491, 0.9725490212440491), 760}),
    (table.freeze({Color3.new(0.9019607901573181, 0.8235294222831726, 0.6274510025978088), 120})),
})
v1.WalkSound = table.freeze({
    SoundId = 122169025762843,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 2}),
})
return (freeze(v1))