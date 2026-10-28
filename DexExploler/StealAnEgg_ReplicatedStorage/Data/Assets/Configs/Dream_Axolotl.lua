-- Script path: ReplicatedStorage.Data.Assets.Configs.Dream Axolotl
-- Decompile time: 2.63 ms

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
    _id = "Dream Axolotl",
    DisplayName = "Axolotl",
    Icon = "rbxassetid://129890708705568",
    EarningRate = 2800,
    IndexSpeedReward = 4000,
    DropWeight = 0.16666666666666666,
    VisualOdds = 954.119769692145,
    ModelWeight = 28,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Axolotl Egg", Icon = "rbxassetid://82740814910149", GrowthTime = 300, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://82684368997608"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://82684368997608 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://102359721577452"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://102359721577452 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.fromRGB(255, 135, 235)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(255, 135, 235), 430}),
    table.freeze({Color3.new(0.37254902720451355, 0.27450981736183167, 0.21568627655506134), 230}),
    table.freeze({Color3.new(0.9215686321258545, 0.8235294222831726, 0.47058823704719543), 150}),
    table.freeze({Color3.new(0.9607843160629272, 0.9607843160629272, 0.9019607901573181), 110}),
    table.freeze({Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886), 60}),
    (table.freeze({Color3.new(0.6274510025978088, 0.5098039507865906, 0.4117647111415863), 20})),
})
v1.WalkSound = table.freeze({
    SoundId = 106266887076783,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 87233046266422, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))