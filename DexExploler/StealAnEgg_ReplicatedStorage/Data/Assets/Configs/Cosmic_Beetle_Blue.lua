-- Script path: ReplicatedStorage.Data.Assets.Configs.Cosmic Beetle Blue
-- Decompile time: 1.57 ms

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
    _id = "Cosmic Beetle Blue",
    DisplayName = "Petal Beetle",
    Icon = "rbxassetid://100456581757086",
    EarningRate = 1200000,
    IndexSpeedReward = 6000000,
    DropWeight = 0,
    VisualOdds = 3.806623524933384,
    ModelWeight = 900,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Petal Beetle Egg",
        Icon = "rbxassetid://74778395132095",
        ModelName = "Petal Beetle",
        GrowthTime = 480,
        WeightKg = 8,
    }),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u26 = "rbxassetid://128419183612223"
local success = pcall(function() -- Line: 8 -- upvalues: Animation (val), u26 (val)
    Animation.AnimationId = u26
end)
if not success then
    warn("Animation rbxassetid://128419183612223 is not shared with this experience")
end
v3.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u39 = "rbxassetid://96465486096704"
local success_2 = pcall(function() -- Line: 8 -- upvalues: Animation_2 (val), u39 (val)
    Animation_2.AnimationId = u39
end)
if not success_2 then
    warn("Animation rbxassetid://96465486096704 is not shared with this experience")
end
v3.Walk = Animation_2
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = v1
v2.PossibleModelColors = table.freeze({table.freeze({v1, 1})})
return (freeze(v2))