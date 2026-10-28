-- Script path: ReplicatedStorage.Data.Assets.Configs.Basilisk
-- Decompile time: 2.45 ms

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
    _id = "Basilisk",
    DisplayName = "Leviathan",
    Icon = "rbxassetid://127583688266170",
    EarningRate = 220000,
    IndexSpeedReward = 5000,
    DropWeight = 0.14285714285714285,
    VisualOdds = 1372.3499248948783,
    ModelWeight = 5000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Leviathan Egg",
        Icon = "rbxassetid://90075842297994",
        GrowthTime = 1500,
        WeightKg = 2,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://99945162566289"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://99945162566289 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://134348178448156"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://134348178448156 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468), 520}),
    table.freeze({Color3.new(0.07450980693101883, 0.0941176488995552, 0.05098039284348488), 210}),
    table.freeze({Color3.new(0.20392157137393951, 0.16078431904315948, 0.10196078568696976), 140}),
    table.freeze({Color3.new(0.12156862765550613, 0.11764705926179886, 0.08235294371843338), 90}),
    table.freeze({Color3.new(0.12941177189350128, 0.12941177189350128, 0.12156862765550613), 40}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.RandomIdleSound = table.freeze({SoundId = 71506363557317, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))