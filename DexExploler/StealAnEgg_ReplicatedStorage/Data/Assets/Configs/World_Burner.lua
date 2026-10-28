-- Script path: ReplicatedStorage.Data.Assets.Configs.World Burner
-- Decompile time: 1.49 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Archdemon Dragon", {
    _id = "World Burner",
    DisplayName = "World Burner",
    Rarity = "Divine",
    EarningRate = 5000000000,
    IndexSpeedReward = 600000000,
    VisualOdds = 5000,
}))

local function makeAnimation(a1) -- Line: 13 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 15 -- upvalues: Animation (val), a1 (val)
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
local u18 = "rbxassetid://105908120568207"
local success = pcall(function() -- Line: 15 -- upvalues: Animation (val), u18 (val)
    Animation.AnimationId = u18
end)
if not success then
    warn("Animation rbxassetid://105908120568207 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u31 = "rbxassetid://134098549938118"
local success_2 = pcall(function() -- Line: 15 -- upvalues: Animation_2 (val), u31 (val)
    Animation_2.AnimationId = u31
end)
if not success_2 then
    warn("Animation rbxassetid://134098549938118 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.Icon = "rbxassetid://74345431327000"
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://117970605290776"
v3.GrowthTime = 64800
v1.Egg = table.freeze(v3)
v1.WalkSound = table.freeze({
    SoundId = 107316499206585,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 112126857388298, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)