-- Script path: ReplicatedStorage.Data.Assets.Configs.Moth
-- Decompile time: 1.48 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Snowy Owl", {
    _id = "Moth",
    DisplayName = "Sacred Moth",
    Rarity = "Cosmic",
    EarningRate = 16000000,
    IndexSpeedReward = 8000000,
    VisualOdds = 5.9417706476530014,
}))
v1.ModelWeight = 9000

local function makeAnimation(a1) -- Line: 15 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 17 -- upvalues: Animation (val), a1 (val)
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
local u19 = "rbxassetid://113695479057312"
local success = pcall(function() -- Line: 17 -- upvalues: Animation (val), u19 (val)
    Animation.AnimationId = u19
end)
if not success then
    warn("Animation rbxassetid://113695479057312 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u32 = "rbxassetid://95246247805951"
local success_2 = pcall(function() -- Line: 17 -- upvalues: Animation_2 (val), u32 (val)
    Animation_2.AnimationId = u32
end)
if not success_2 then
    warn("Animation rbxassetid://95246247805951 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
local v3 = table.clone(v1.Egg)
v3.GrowthTime = 900
v3.Icon = "rbxassetid://104832997526909"
v1.Egg = table.freeze(v3)
v1.Icon = "rbxassetid://114029210145538"
v1.WalkSound = table.freeze({
    SoundId = 88538312814962,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 113504042242020, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)