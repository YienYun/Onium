-- Script path: ReplicatedStorage.Data.Assets.LightDarkPlaceholder
-- Decompile time: 2.45 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Configs = script.Parent.Configs

local function makeAnimation(a1) -- Line: 21 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 23 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local function borrowAnimations(a1) -- Line: 31 -- upvalues: makeAnimation (val)
    local Animations = a1.Animations
    if Animations == nil then
        return nil
    end
    return table.freeze({
        Idle = if not Animations.Idle then nil else makeAnimation(Animations.Idle.AnimationId),
        Walk = if not Animations.Walk then nil else makeAnimation(Animations.Walk.AnimationId),
        TransitionFadeDuration = Animations.TransitionFadeDuration,
    })
end

return table.freeze({
    FromTemplate = function(a1, a2) -- Line: 45
        -- upvalues: Configs (val), Rarity (val), borrowAnimations (val)
        local v1 = Configs:FindFirstChild(a1)
        local v2 = ("No asset config named \"%*\" to borrow placeholder art from"):format(a1)
        assert(v1 ~= nil, v2)
        local v3 = require(v1)
        v1 = Rarity.Rarities[a2.Rarity]
        local v4 = ("Unknown rarity \"%*\" on %*"):format(a2.Rarity, a2._id)
        assert(v1 ~= nil, v4)
        return table.freeze({
            DropWeight = 0,
            _id = a2._id,
            DisplayName = a2.DisplayName,
            Icon = v3.Icon,
            Egg = table.freeze({
                DisplayName = ("%* Egg"):format(a2.DisplayName),
                Icon = v3.Egg.Icon,
                GrowthTime = v3.Egg.GrowthTime,
                WeightKg = v3.Egg.WeightKg,
                HideRarity = v3.Egg.HideRarity,
                IgnoreSizeGrowthMultiplier = v3.Egg.IgnoreSizeGrowthMultiplier,
            }),
            EarningRate = a2.EarningRate,
            IndexSpeedReward = a2.IndexSpeedReward,
            VisualOdds = a2.VisualOdds,
            ModelWeight = v3.ModelWeight,
            Animations = borrowAnimations(v3),
            WalkAnimationReferenceSpeed = v3.WalkAnimationReferenceSpeed,
            Rarity = v1,
            BaseModelScale = v3.BaseModelScale,
            LimitedEggViewportScale = v3.LimitedEggViewportScale,
            LimitedEggViewportVerticalOffset = v3.LimitedEggViewportVerticalOffset,
            BaseModelColor = v3.BaseModelColor,
            PossibleModelColors = v3.PossibleModelColors,
            PlaceSound = v3.PlaceSound,
            WalkSound = v3.WalkSound,
            RandomIdleSound = v3.RandomIdleSound,
        })
    end,
})