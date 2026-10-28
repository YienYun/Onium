-- Script path: ReplicatedStorage.Data.Assets.Configs.Skeletal Terrorbird
-- Decompile time: 1.76 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = Color3.fromRGB(255, 255, 255)

local function makeAnimation(a1) -- Line: 12 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 14 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v2 = {
    _id = "Skeletal Terrorbird",
    DisplayName = "Skeletal Terrorbird",
    Icon = "rbxassetid://87232744434342",
    EarningRate = 750000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 412.5,
    ModelWeight = 6000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Skeletal Terrorbird Egg",
        Icon = "rbxassetid://104417876555018",
        ModelName = "Skeletal Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://110653346687219"
local success = pcall(function() -- Line: 14 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://110653346687219 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://130270537699371"
local success_2 = pcall(function() -- Line: 14 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://130270537699371 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
v2.WalkSound = table.freeze({
    SoundId = 110189560155344,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v2.RandomIdleSound = table.freeze({SoundId = 113335388739857, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v2))