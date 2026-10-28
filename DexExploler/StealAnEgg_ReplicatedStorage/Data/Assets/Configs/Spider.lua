-- Script path: ReplicatedStorage.Data.Assets.Configs.Spider
-- Decompile time: 2.58 ms

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
    _id = "Spider",
    DisplayName = "Spider",
    Icon = "rbxassetid://132010793204072",
    EarningRate = 22000,
    IndexSpeedReward = 12600,
    DropWeight = 0.16666666666666666,
    VisualOdds = 861882.324392,
    ModelWeight = 120,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Spider Egg", Icon = "rbxassetid://85241307147394", GrowthTime = 270, WeightKg = 4}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://117459506499807"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://117459506499807 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://71117255441251"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://71117255441251 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Mythic
v1.BaseModelColor = Color3.new(0.21568627655506134, 0.21960784494876862, 0.24313725531101227)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.21568627655506134, 0.21960784494876862, 0.24313725531101227), 520}),
    table.freeze({Color3.new(0.1764705926179886, 0.13725490868091583, 0.11764705926179886), 180}),
    table.freeze({Color3.new(0.3333333432674408, 0.27450981736183167, 0.1764705926179886), 130}),
    table.freeze({Color3.new(0.13725490868091583, 0.1764705926179886, 0.13725490868091583), 100}),
    table.freeze({Color3.new(0.5098039507865906, 0.37254902720451355, 0.1764705926179886), 50}),
    table.freeze({Color3.new(0.09803921729326248, 0.09803921729326248, 0.09803921729326248), 20}),
    (table.freeze({Color3.new(1, 1, 1), 12})),
})
v1.WalkSound = table.freeze({
    SoundId = 131115341364194,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 134280584978628, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))