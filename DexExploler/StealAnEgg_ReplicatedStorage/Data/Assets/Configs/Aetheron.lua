-- Script path: ReplicatedStorage.Data.Assets.Configs.Aetheron
-- Decompile time: 1.99 ms

local v1 = table.clone(require(script.Parent.ArchAngel))
v1._id = "Aetheron"
v1.DisplayName = "Aetheron"
v1.Icon = "rbxassetid://116718586319869"
v1.EarningRate = 6900000000
v1.ModelWeight = 120000

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
local u18 = "rbxassetid://97205108103704"
local success = pcall(function() -- Line: 12 -- upvalues: Animation (val), u18 (val)
    Animation.AnimationId = u18
end)
if not success then
    warn("Animation rbxassetid://97205108103704 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u31 = "rbxassetid://81153625252167"
local success_2 = pcall(function() -- Line: 12 -- upvalues: Animation_2 (val), u31 (val)
    Animation_2.AnimationId = u31
end)
if not success_2 then
    warn("Animation rbxassetid://81153625252167 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.BaseModelColor = Color3.fromRGB(255, 48, 12)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(255, 48, 12), 850}),
    table.freeze({Color3.fromRGB(255, 120, 30), 90}),
    table.freeze({Color3.fromRGB(158, 28, 28), 48}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 12})),
})
local v3 = table.clone(v1.Egg)
v3.DisplayName = "Aetheron Egg"
v3.ModelName = "Aetheron"
v3.Icon = "rbxassetid://98329267204643"
v1.Egg = table.freeze(v3)
v1.DropWeight = 0
v1.DontRoll = true
v1.WalkSound = table.freeze({
    SoundId = 89464015548692,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 120804583549199, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)