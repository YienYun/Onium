-- Script path: ReplicatedStorage.Data.Assets.Configs.ArchAngel
-- Decompile time: 1.65 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Kitsune", {
    _id = "ArchAngel",
    DisplayName = "ArchAngel",
    Rarity = "Divine",
    EarningRate = 5000000000,
    IndexSpeedReward = 600000000,
    VisualOdds = 5000,
}))
v1.ModelWeight = 120000

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
local u19 = "rbxassetid://86353056746586"
local success = pcall(function() -- Line: 16 -- upvalues: Animation (val), u19 (val)
    Animation.AnimationId = u19
end)
if not success then
    warn("Animation rbxassetid://86353056746586 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u32 = "rbxassetid://70646957649460"
local success_2 = pcall(function() -- Line: 16 -- upvalues: Animation_2 (val), u32 (val)
    Animation_2.AnimationId = u32
end)
if not success_2 then
    warn("Animation rbxassetid://70646957649460 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
v1.Icon = "rbxassetid://113289118499426"
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://85963541672111"
v3.GrowthTime = 64800
v1.Egg = table.freeze(v3)
v1.WalkSound = table.freeze({
    SoundId = 92193537316584,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 132769740378123, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)