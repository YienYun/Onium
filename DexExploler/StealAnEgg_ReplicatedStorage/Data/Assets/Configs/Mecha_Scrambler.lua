-- Script path: ReplicatedStorage.Data.Assets.Configs.Mecha Scrambler
-- Decompile time: 1.51 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 4 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 6 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Mecha Scrambler",
    DisplayName = "Mecha Scrambler",
    Icon = "rbxassetid://92101779058721",
    EarningRate = 7500000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 0,
    ModelWeight = 30000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Mecha Scrambler Egg",
        Icon = "rbxassetid://121178065227483",
        GrowthTime = 60,
        WeightKg = 1,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://120484795823977"
local success = pcall(function() -- Line: 6 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://120484795823977 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u32 = "rbxassetid://107270328959157"
local success_2 = pcall(function() -- Line: 6 -- upvalues: Animation_2 (val), u32 (val)
    Animation_2.AnimationId = u32
end)
if not success_2 then
    warn("Animation rbxassetid://107270328959157 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Divine
v1.BaseModelColor = Color3.fromRGB(81, 226, 36)
v1.PossibleModelColors = table.freeze({table.freeze({Color3.fromRGB(81, 226, 36), 1})})
return (freeze(v1))