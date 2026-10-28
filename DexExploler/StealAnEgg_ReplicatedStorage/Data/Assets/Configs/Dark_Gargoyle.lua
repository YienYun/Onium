-- Script path: ReplicatedStorage.Data.Assets.Configs.Dark Gargoyle
-- Decompile time: 1.44 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Shadow Dragon", {
    _id = "Dark Gargoyle",
    DisplayName = "Gargoyle",
    Rarity = "Secret",
    EarningRate = 225000000,
    IndexSpeedReward = 30000000,
    VisualOdds = 22.935779816513758,
}))

local function makeAnimation(a1) -- Line: 14 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 16 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u18 = "rbxassetid://116878464800621"
local success = pcall(function() -- Line: 16 -- upvalues: Animation (val), u18 (val)
    Animation.AnimationId = u18
end)
if not success then
    warn("Animation rbxassetid://116878464800621 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u31 = "rbxassetid://72168860461322"
local success_2 = pcall(function() -- Line: 16 -- upvalues: Animation_2 (val), u31 (val)
    Animation_2.AnimationId = u31
end)
if not success_2 then
    warn("Animation rbxassetid://72168860461322 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://119732629571247"
v3.GrowthTime = 10800
v1.Egg = table.freeze(v3)
v1.Icon = "rbxassetid://99077940722686"
v1.WalkSound = table.freeze({
    SoundId = 140567909859107,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 89807033480950, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)