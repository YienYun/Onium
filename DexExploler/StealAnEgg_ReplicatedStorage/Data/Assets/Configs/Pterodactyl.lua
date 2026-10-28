-- Script path: ReplicatedStorage.Data.Assets.Configs.Pterodactyl
-- Decompile time: 2.54 ms

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
    _id = "Pterodactyl",
    DisplayName = "Pterodactyl",
    Icon = "rbxassetid://92643140066500",
    EarningRate = 22000,
    IndexSpeedReward = 270000,
    DropWeight = 0.5,
    VisualOdds = 215470.581098,
    ModelWeight = 180,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Pterodactyl Egg",
        Icon = "rbxassetid://88209726148785",
        GrowthTime = 180,
        WeightKg = 3,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://139638551129821"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://139638551129821 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://92715712978388"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://92715712978388 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Legendary
v1.BaseModelColor = Color3.new(0.33725491166114807, 0.3137255012989044, 0.30588236451148987)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.33725491166114807, 0.3137255012989044, 0.30588236451148987), 520}),
    table.freeze({Color3.new(0.47058823704719543, 0.37254902720451355, 0.2549019753932953), 180}),
    table.freeze({Color3.new(0.5882353186607361, 0.5098039507865906, 0.37254902720451355), 130}),
    table.freeze({Color3.new(0.21568627655506134, 0.21568627655506134, 0.23529411852359772), 100}),
    table.freeze({Color3.new(0.37254902720451355, 0.4117647111415863, 0.45098039507865906), 70}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 137006206175690,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 106521441079177, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))