-- Script path: ReplicatedStorage.Data.Assets.Configs.FennecFox
-- Decompile time: 2.23 ms

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
    _id = "FennecFox",
    DisplayName = "Fennec",
    Icon = "rbxassetid://130204625520606",
    EarningRate = 18,
    IndexSpeedReward = 8100,
    DropWeight = 0.5,
    VisualOdds = 7778.721339,
    ModelWeight = 8,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Fennec Egg", Icon = "rbxassetid://104249034532190", GrowthTime = 30, WeightKg = 2}),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
local u20 = "rbxassetid://97698541539837"
local success = pcall(function() -- Line: 9 -- upvalues: Animation (val), u20 (val)
    Animation.AnimationId = u20
end)
if not success then
    warn("Animation rbxassetid://97698541539837 is not shared with this experience")
end
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
local u33 = "rbxassetid://87942495505255"
local success_2 = pcall(function() -- Line: 9 -- upvalues: Animation_2 (val), u33 (val)
    Animation_2.AnimationId = u33
end)
if not success_2 then
    warn("Animation rbxassetid://87942495505255 is not shared with this experience")
end
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Uncommon
v1.BaseModelColor = Color3.new(0.8392156958580017, 0.729411780834198, 0.5568627715110779)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.new(0.8392156958580017, 0.729411780834198, 0.5568627715110779), 780}),
    table.freeze({Color3.new(0.9215686321258545, 0.843137264251709, 0.686274528503418), 130}),
    table.freeze({Color3.new(0.7058823704719543, 0.529411792755127, 0.3137255012989044), 70}),
    table.freeze({Color3.new(1, 0.7333333492279053, 0.501960813999176), 20}),
    (table.freeze({Color3.new(1, 1, 1), 15})),
})
v1.WalkSound = table.freeze({
    SoundId = 100755799211418,
    Data = table.freeze({Looped = true, MaxDistance = 20, Speed = 1, Volume = 1.5}),
})
v1.RandomIdleSound = table.freeze({SoundId = 139113514652602, Data = table.freeze({MaxDistance = 20, Volume = 1.5})})
return (freeze(v1))