-- Script path: ReplicatedStorage.Data.Assets.Configs.Irihorus
-- Decompile time: 2.16 ms

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
    _id = "Irihorus",
    DisplayName = "Royal Sphinx",
    Icon = "rbxassetid://127700885487813",
    EarningRate = 280000,
    IndexSpeedReward = 18000,
    DropWeight = 0.14285714285714285,
    VisualOdds = 86188.232439,
    ModelWeight = 4000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Royal Sphinx Egg",
        Icon = "rbxassetid://131634678618769",
        GrowthTime = 1800,
        WeightKg = 3,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://91972383372833"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://91972383372833 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://136125998199222"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://136125998199222 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Cosmic
v1.BaseModelColor = Color3.new(0.5098039507865906, 0.3921568691730499, 0.25882354378700256)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.5098039507865906, 0.3921568691730499, 0.25882354378700256), 850}),
    table.freeze({Color3.new(0.6470588445663452, 0.5098039507865906, 0.3137255012989044), 100}),
    table.freeze({Color3.new(0.37254902720451355, 0.27450981736183167, 0.1764705926179886), 50}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 96694253920514,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 114810982171335, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))