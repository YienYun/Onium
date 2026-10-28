-- Script path: ReplicatedStorage.Data.Assets.Configs.Abyssal Overlord OP
-- Decompile time: 1.89 ms

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
    _id = "Abyss Overlord OP",
    DisplayName = "Abyss Overlord",
    Icon = "rbxassetid://109336297710127",
    EarningRate = 100000000,
    IndexSpeedReward = 42000,
    DropWeight = 0,
    VisualOdds = 6000000,
    ModelWeight = 13000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Abyss Overlord Egg",
        Icon = "rbxassetid://92114389149544",
        ModelName = "Abyss Overlord",
        GrowthTime = 60,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://136140636644582"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://136140636644582 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://136140636644582"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://136140636644582 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(110, 74, 126)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.fromRGB(110, 74, 126), 1})})
return (freeze(v1))