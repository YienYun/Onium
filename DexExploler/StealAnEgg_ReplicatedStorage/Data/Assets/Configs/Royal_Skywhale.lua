-- Script path: ReplicatedStorage.Data.Assets.Configs.Royal Skywhale
-- Decompile time: 1.59 ms

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
    _id = "Royal Skywhale",
    DisplayName = "Royal Skywhale",
    Icon = "rbxassetid://140420688307546",
    EarningRate = 8000000000,
    IndexSpeedReward = 6000000,
    DropWeight = 0,
    VisualOdds = 5000,
    ModelWeight = 190000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Royal Skywhale Egg",
        Icon = "rbxassetid://121358694277567",
        ModelName = "Royal Skywhale",
        GrowthTime = 64800,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://72475549070227"
local success = pcall(function() -- Line: 8 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://72475549070227 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://83615732104417"
local success_2 = pcall(function() -- Line: 8 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://83615732104417 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Divine
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
return (freeze(v2))