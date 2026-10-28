-- Script path: ReplicatedStorage.Data.Assets.Configs.World Spirit
-- Decompile time: 2.39 ms

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
    _id = "World Spirit",
    DisplayName = "Spirit World Guardian",
    Icon = "rbxassetid://72974611437454",
    EarningRate = 15000000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 0,
    ModelWeight = 40000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Spirit World Guardian Egg",
        Icon = "rbxassetid://121251394844117",
        ModelName = "World Spirit",
        GrowthTime = 64800,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://93961573132593"
local success = pcall(function() -- Line: 8 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://93961573132593 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://120772797371025"
local success_2 = pcall(function() -- Line: 8 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://120772797371025 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Divine
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
return (freeze(v2))