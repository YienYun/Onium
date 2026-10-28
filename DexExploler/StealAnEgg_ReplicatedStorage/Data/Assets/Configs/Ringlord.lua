-- Script path: ReplicatedStorage.Data.Assets.Configs.Ringlord
-- Decompile time: 1.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 5 -- types: a1: string
    local Animation = Instance.new("Animation")
    Animation.AnimationId = a1
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Ringlord",
    DisplayName = "Ringlord",
    Icon = "rbxassetid://91756381949392",
    EarningRate = 825000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 1,
    ModelWeight = 80,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    DontRoll = true,
    WalkSound = table.freeze({
        SoundId = 118578341930967,
        Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
    }),
    RandomIdleSound = table.freeze({SoundId = 82083136808152, Data = table.freeze({MaxDistance = 20, Volume = 1.5})}),
    Egg = table.freeze({
        DisplayName = "Ringlord Egg",
        Icon = "rbxassetid://126807681611943",
        ModelName = "Ringlord",
        GrowthTime = 21600,
        WeightKg = 80,
    }),
}
local freeze_4 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://116695407509351"
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
Animation_2.AnimationId = "rbxassetid://116861024650521"
v2.Walk = Animation_2
v1.Animations = freeze_4(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(90, 87, 83)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(90, 87, 83), 80}),
    table.freeze({Color3.fromRGB(110, 98, 78), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
return freeze(v1)