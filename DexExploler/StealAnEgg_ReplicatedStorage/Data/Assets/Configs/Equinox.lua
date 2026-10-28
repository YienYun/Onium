-- Script path: ReplicatedStorage.Data.Assets.Configs.Equinox
-- Decompile time: 2.09 ms

local v1 = table.clone(require(script.Parent.Pegasus))
v1._id = "Equinox"
v1.DisplayName = "Equinox"
v1.Icon = "rbxassetid://92079543818607"
v1.EarningRate = 1800000000
v1.ModelWeight = 65000

local function makeAnimation(a1) -- Line: 10 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 12 -- upvalues: Animation (val), a1 (val)
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
local u18 = "rbxassetid://84399470387824"
local success = pcall(function() -- Line: 12 -- upvalues: Animation (val), u18 (val)
    Animation.AnimationId = u18
end)
if not success then
    warn("Animation rbxassetid://84399470387824 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u31 = "rbxassetid://102707946124614"
local success_2 = pcall(function() -- Line: 12 -- upvalues: Animation_2 (val), u31 (val)
    Animation_2.AnimationId = u31
end)
if not success_2 then
    warn("Animation rbxassetid://102707946124614 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.BaseModelColor = Color3.fromRGB(240, 194, 77)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(240, 194, 77), 850}),
    table.freeze({Color3.fromRGB(255, 223, 142), 90}),
    table.freeze({Color3.fromRGB(196, 140, 56), 48}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 12})),
})
local v3 = table.clone(v1.Egg)
v3.DisplayName = "Equinox Egg"
v3.ModelName = "Equinox"
v3.Icon = "rbxassetid://73572093043918"
v1.Egg = table.freeze(v3)
v1.DropWeight = 0
v1.DontRoll = true
v1.WalkSound = table.freeze({
    SoundId = 127024805236306,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 105229098897232, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)