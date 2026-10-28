-- Script path: ReplicatedStorage.Data.Assets.Configs.Dove
-- Decompile time: 1.48 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Swan", {
    _id = "Dove",
    DisplayName = "Light Dove",
    Rarity = "Legendary",
    EarningRate = 225000,
    IndexSpeedReward = 3000000,
    VisualOdds = 2.6659557451346307,
}))
v1.ModelWeight = 45000

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
local u19 = "rbxassetid://87026407917685"
local success = pcall(function() -- Line: 17 -- upvalues: Animation (val), u19 (val)
    Animation.AnimationId = u19
end)
if not success then
    warn("Animation rbxassetid://87026407917685 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u32 = "rbxassetid://88155121013841"
local success_2 = pcall(function() -- Line: 17 -- upvalues: Animation_2 (val), u32 (val)
    Animation_2.AnimationId = u32
end)
if not success_2 then
    warn("Animation rbxassetid://88155121013841 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.Icon = "rbxassetid://71242072766450"
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://104459545767438"
v3.GrowthTime = 300
v1.Egg = table.freeze(v3)
v1.WalkSound = table.freeze({
    SoundId = 128632172954714,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 118323451396721, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)