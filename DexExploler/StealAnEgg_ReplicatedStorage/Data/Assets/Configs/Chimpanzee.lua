-- Script path: ReplicatedStorage.Data.Assets.Configs.Chimpanzee
-- Decompile time: 2.61 ms

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
    _id = "Chimpanzee",
    DisplayName = "Chimpanzee",
    Icon = "rbxassetid://74635759656969",
    EarningRate = 90,
    IndexSpeedReward = 7200,
    DropWeight = 0,
    VisualOdds = 190000,
    ModelWeight = 65,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Chimpanzee Egg",
        Icon = "rbxassetid://112484055753399",
        GrowthTime = 30,
        WeightKg = 3,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://79828503574644"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://79828503574644 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://118780292967097"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://118780292967097 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.33725491166114807, 0.2235294133424759, 0.14509804546833038)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.33725491166114807, 0.2235294133424759, 0.14509804546833038), 650}),
    table.freeze({Color3.new(0.21568627655506134, 0.16470588743686676, 0.125490203499794), 180}),
    table.freeze({Color3.new(0.47058823704719543, 0.3333333432674408, 0.21568627655506134), 125}),
    table.freeze({Color3.new(0.6078431606292725, 0.4901960790157318, 0.37254902720451355), 45}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 123431841520512,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 102428875173675, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))