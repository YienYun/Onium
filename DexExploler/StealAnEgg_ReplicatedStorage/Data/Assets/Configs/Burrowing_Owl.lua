-- Script path: ReplicatedStorage.Data.Assets.Configs.Burrowing Owl
-- Decompile time: 2.73 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 7 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "Burrowing Owl",
    DisplayName = "Burrowing Owl",
    Icon = "rbxassetid://123516361239872",
    EarningRate = 35,
    IndexSpeedReward = 560,
    DropWeight = 0.2,
    VisualOdds = 6.484806179286864,
    ModelWeight = 8,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Burrowing Owl Egg",
        Icon = "rbxassetid://122807946218302",
        GrowthTime = 40,
        WeightKg = 1,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://89419902709935"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://89419902709935 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://137489865198011"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://137489865198011 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Rare
v1.BaseModelColor = Color3.new(0.3450980484485626, 0.2980392277240753, 0.2078431397676468)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.3450980484485626, 0.2980392277240753, 0.2078431397676468), 720}),
    table.freeze({Color3.new(0.4901960790157318, 0.4117647111415863, 0.27450981736183167), 170}),
    table.freeze({Color3.new(0.2549019753932953, 0.22745098173618317, 0.1764705926179886), 75}),
    table.freeze({Color3.new(0.47058823704719543, 0.4117647111415863, 0.29019609093666077), 35}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 99892403203037,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 87403836085353, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))