-- Script path: ReplicatedStorage.Data.Assets.Configs.Cave Dragon
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
    _id = "Cave Dragon",
    DisplayName = "Cosmic Dragon",
    Icon = "rbxassetid://107923370723949",
    EarningRate = 60000000,
    IndexSpeedReward = 1440000,
    DropWeight = 70,
    VisualOdds = 1141825743428080.2,
    ModelWeight = 15000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Cosmic Dragon Egg",
        Icon = "rbxassetid://108447968078067",
        GrowthTime = 10800,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://102500062625694"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://102500062625694 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://137187648227824"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://137187648227824 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468), 1000}),
    table.freeze({Color3.new(0.20392157137393951, 0.30980393290519714, 0.3333333432674408), 200}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 75668180706771,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 107572758231211, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))