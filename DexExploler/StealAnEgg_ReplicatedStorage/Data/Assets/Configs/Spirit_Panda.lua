-- Script path: ReplicatedStorage.Data.Assets.Configs.Spirit Panda
-- Decompile time: 1.88 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = Color3.fromRGB(255, 255, 255)

local function makeAnimation(a1) -- Line: 6 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 8 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v2 = {
    _id = "Spirit Panda",
    DisplayName = "Spirit Panda",
    Icon = "rbxassetid://130775352945186",
    EarningRate = 90000000,
    IndexSpeedReward = 16000000,
    DropWeight = 0,
    VisualOdds = 22.93577981651376,
    ModelWeight = 2000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Spirit Panda Egg",
        Icon = "rbxassetid://131111647963702",
        ModelName = "Spirit Panda",
        GrowthTime = 10800,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://115211469719705"
local success = pcall(function() -- Line: 8 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://115211469719705 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://110027629838208"
local success_2 = pcall(function() -- Line: 8 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://110027629838208 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
return (freeze(v2))