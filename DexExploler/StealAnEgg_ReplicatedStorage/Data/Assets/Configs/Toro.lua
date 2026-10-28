-- Script path: ReplicatedStorage.Data.Assets.Configs.Toro
-- Decompile time: 1.46 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Hellhound", {
    _id = "Toro",
    DisplayName = "Toro",
    Rarity = "Mythic",
    EarningRate = 1250000,
    IndexSpeedReward = 4000000,
    VisualOdds = 3.806623524933384,
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
local u18 = "rbxassetid://91059320033092"
local success = pcall(function() -- Line: 16 -- upvalues: Animation (val), u18 (val)
    Animation.AnimationId = u18
end)
if not success then
    warn("Animation rbxassetid://91059320033092 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u31 = "rbxassetid://134951177250078"
local success_2 = pcall(function() -- Line: 16 -- upvalues: Animation_2 (val), u31 (val)
    Animation_2.AnimationId = u31
end)
if not success_2 then
    warn("Animation rbxassetid://134951177250078 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.Icon = "rbxassetid://81140344970127"
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://79033215990120"
v3.GrowthTime = 480
v1.Egg = table.freeze(v3)
v1.WalkSound = table.freeze({
    SoundId = 131750573366000,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 82666189995615, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)