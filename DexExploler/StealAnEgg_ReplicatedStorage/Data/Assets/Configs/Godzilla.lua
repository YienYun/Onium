-- Script path: ReplicatedStorage.Data.Assets.Configs.Godzilla
-- Decompile time: 3.22 ms

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
    _id = "Godzilla",
    DisplayName = "Nightflame",
    Icon = "rbxassetid://102979882140882",
    EarningRate = 3000000000,
    IndexSpeedReward = 6870240,
    DropWeight = 0,
    VisualOdds = 168336000000000,
    ModelWeight = 160000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Nightflame Egg",
        Icon = "rbxassetid://134762388111337",
        GrowthTime = 57600,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://105030323854881"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://105030323854881 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://78608369871297"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://78608369871297 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Divine
v1.BaseModelColor = Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598), 850}),
    table.freeze({Color3.new(0.9215686321258545, 0.7843137383460999, 0.5490196347236633), 90}),
    table.freeze({Color3.new(0.7450980544090271, 0.7450980544090271, 0.7843137383460999), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
return (freeze(v1))