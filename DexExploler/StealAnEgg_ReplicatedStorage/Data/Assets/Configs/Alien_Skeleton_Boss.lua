-- Script path: ReplicatedStorage.Data.Assets.Configs.Alien Skeleton Boss
-- Decompile time: 1.82 ms

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
    _id = "Alien Skeleton Boss",
    DisplayName = "Cosmic Skeleton Boss",
    Icon = "rbxassetid://132367218748284",
    EarningRate = 45000000,
    IndexSpeedReward = 1680000,
    DropWeight = 0.1,
    VisualOdds = 5266356515000.135,
    ModelWeight = 1000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "Cosmic Skeleton Boss Egg",
        Icon = "rbxassetid://110149104359970",
        GrowthTime = 9000,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://117753870137871"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://117753870137871 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://71017244285761"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://71017244285761 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468), 990}),
    (table.freeze({Color3.new(1, 1, 1), 10})),
})
v1.WalkSound = table.freeze({
    SoundId = 116819340330349,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 105167789823714, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))