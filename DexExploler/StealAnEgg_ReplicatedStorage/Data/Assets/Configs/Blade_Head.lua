-- Script path: ReplicatedStorage.Data.Assets.Configs.Blade Head
-- Decompile time: 2.66 ms

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
    _id = "Blade Head",
    DisplayName = "Bladehide",
    Icon = "rbxassetid://72029341536310",
    EarningRate = 750000,
    IndexSpeedReward = 4809168,
    DropWeight = 0,
    VisualOdds = 1.142e+15,
    ModelWeight = 1700,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bladehide Egg",
        Icon = "rbxassetid://94504024229397",
        GrowthTime = 540,
        WeightKg = 3,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://92002483584190"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://92002483584190 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://117290263322327"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://117290263322327 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.95686274766922, 0.8627451062202454, 0.7098039388656616)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.95686274766922, 0.8627451062202454, 0.7098039388656616), 850}),
    table.freeze({Color3.new(0.7450980544090271, 0.5490196347236633, 0.3529411852359772), 90}),
    table.freeze({Color3.new(0.5490196347236633, 0.5098039507865906, 0.47058823704719543), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
return (freeze(v1))