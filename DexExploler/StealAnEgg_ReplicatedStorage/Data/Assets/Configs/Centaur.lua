-- Script path: ReplicatedStorage.Data.Assets.Configs.Centaur
-- Decompile time: 1.62 ms

local v1 = table.clone((require(script.Parent.Parent.LightDarkPlaceholder)).FromTemplate("Stag", {
    _id = "Centaur",
    DisplayName = "Centaur",
    Rarity = "Secret",
    EarningRate = 350000000,
    IndexSpeedReward = 90000000,
    VisualOdds = 135.13513513513513,
}))
v1.ModelWeight = 12000

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
local u19 = "rbxassetid://103579027390419"
local success = pcall(function() -- Line: 17 -- upvalues: Animation (val), u19 (val)
    Animation.AnimationId = u19
end)
if not success then
    warn("Animation rbxassetid://103579027390419 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u32 = "rbxassetid://87256504987743"
local success_2 = pcall(function() -- Line: 17 -- upvalues: Animation_2 (val), u32 (val)
    Animation_2.AnimationId = u32
end)
if not success_2 then
    warn("Animation rbxassetid://87256504987743 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze(v2)
local v3 = table.clone(v1.Egg)
v3.Icon = "rbxassetid://94996357404675"
v3.GrowthTime = 12600
v1.Egg = table.freeze(v3)
v1.Icon = "rbxassetid://136114731886336"
v1.WalkSound = table.freeze({
    SoundId = 90865226033557,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 138591041806731, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return table.freeze(v1)