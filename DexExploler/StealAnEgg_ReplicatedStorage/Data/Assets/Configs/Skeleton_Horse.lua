-- Script path: ReplicatedStorage.Data.Assets.Configs.Skeleton Horse
-- Decompile time: 1.46 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Balrog", {
    _id = "Skeleton Horse",
    DisplayName = "Skeleton Horse",
    Rarity = "Eternal",
    EarningRate = 1300000000,
    IndexSpeedReward = 200000000,
    VisualOdds = 322.5806451612903,
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
local u18 = "rbxassetid://131965507609560"
local success = pcall(function() -- Line: 15 -- upvalues: Animation (val), u18 (val)
    Animation.AnimationId = u18
end)
if not success then
    warn("Animation rbxassetid://131965507609560 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u31 = "rbxassetid://135445394374807"
local success_2 = pcall(function() -- Line: 15 -- upvalues: Animation_2 (val), u31 (val)
    Animation_2.AnimationId = u31
end)
if not success_2 then
    warn("Animation rbxassetid://135445394374807 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://136184113799222"
v3.GrowthTime = 36000
v1.Egg = table.freeze(v3)
v1.Icon = "rbxassetid://78230812200224"
v1.WalkSound = table.freeze({
    SoundId = 98213672349073,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 101150307443849, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)