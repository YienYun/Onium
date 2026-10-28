-- Script path: ReplicatedStorage.Data.Assets.Configs.Flame Sprite
-- Decompile time: 1.50 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Demon Imp", {
    _id = "Flame Sprite",
    DisplayName = "Flame Sprite",
    Rarity = "Legendary",
    EarningRate = 225000,
    IndexSpeedReward = 3000000,
    VisualOdds = 2.6659557451346307,
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
local u18 = "rbxassetid://102483784314308"
local success = pcall(function() -- Line: 16 -- upvalues: Animation (val), u18 (val)
    Animation.AnimationId = u18
end)
if not success then
    warn("Animation rbxassetid://102483784314308 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u31 = "rbxassetid://98424320124914"
local success_2 = pcall(function() -- Line: 16 -- upvalues: Animation_2 (val), u31 (val)
    Animation_2.AnimationId = u31
end)
if not success_2 then
    warn("Animation rbxassetid://98424320124914 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.Icon = "rbxassetid://84084008364875"
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://120917483549782"
v3.GrowthTime = 300
v1.Egg = table.freeze(v3)
v1.WalkSound = table.freeze({
    SoundId = 95027260926731,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 77020164781939, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)