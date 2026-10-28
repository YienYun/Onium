-- Script path: ReplicatedStorage.Data.Assets.Configs.Peacock
-- Decompile time: 1.55 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Koi", {
    _id = "Peacock",
    DisplayName = "Holy Peacock",
    Rarity = "Cosmic",
    EarningRate = 25000000,
    IndexSpeedReward = 20000000,
    VisualOdds = 7.163323782234957,
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
local u19 = "rbxassetid://102772617893534"
local success = pcall(function() -- Line: 17 -- upvalues: Animation (val), u19 (val)
    Animation.AnimationId = u19
end)
if not success then
    warn("Animation rbxassetid://102772617893534 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u32 = "rbxassetid://97662813776740"
local success_2 = pcall(function() -- Line: 17 -- upvalues: Animation_2 (val), u32 (val)
    Animation_2.AnimationId = u32
end)
if not success_2 then
    warn("Animation rbxassetid://97662813776740 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.Icon = "rbxassetid://117035806469168"
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://129535163831580"
v3.GrowthTime = 1200
v1.Egg = table.freeze(v3)
v1.WalkSound = table.freeze({
    SoundId = 85587257116246,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 100420105295254, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)