-- Script path: ReplicatedStorage.Data.Assets.Configs.King Kong
-- Decompile time: 2.59 ms

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
    _id = "King Kong",
    DisplayName = "Gorilla King",
    Icon = "rbxassetid://135650224014044",
    EarningRate = 880000000,
    IndexSpeedReward = 5496192,
    DropWeight = 0,
    VisualOdds = 28729000000000,
    ModelWeight = 100000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Gorilla King Egg",
        Icon = "rbxassetid://140733363307193",
        GrowthTime = 32400,
        WeightKg = 4,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://123822629912237"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://123822629912237 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://131533059911792"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://131533059911792 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Eternal
v1.BaseModelColor = Color3.new(0.8705882430076599, 0.8274509906768799, 0.7568627595901489)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8705882430076599, 0.8274509906768799, 0.7568627595901489), 850}),
    table.freeze({Color3.new(0.9215686321258545, 0.7450980544090271, 0.47058823704719543), 90}),
    table.freeze({Color3.new(0.47058823704719543, 0.47058823704719543, 0.5098039507865906), 48}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
return (freeze(v1))