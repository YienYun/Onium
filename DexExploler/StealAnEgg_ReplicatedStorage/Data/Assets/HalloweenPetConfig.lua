-- Script path: ReplicatedStorage.Data.Assets.HalloweenPetConfig
-- Decompile time: 1.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local HalloweenPets = require(ReplicatedStorage.Data.HalloweenPets)
local u19 = require(script.Parent.Configs.Dog)

local function animation(a1) -- Line: 6
    if not a1 then
        return nil
    end
    local Animation = Instance.new("Animation")
    Animation.AnimationId = "rbxassetid://" .. a1
    return Animation
end

return function(a1) -- Line: 10 -- upvalues: HalloweenPets (val), u19 (val), Rarity (val)
    local v1
    local v2 = assert(HalloweenPets.Specs[a1], "Unknown Halloween pet " .. a1)
    local v3 = table.clone(u19)
    v3._id = a1
    v3.DisplayName = v2.DisplayName
    v3.Icon = v2.Icon
    v3.WhiteImage = nil
    v3.MutationIcons = nil
    v3.Rarity = assert(Rarity.Rarities[v2.Rarity], "Missing Halloween rarity")
    v3.EarningRate = v2.EarningRate
    v3.IndexSpeedReward = 0
    v3.DropWeight = 0
    v3.VisualOdds = v2.Weight
    v3.ModelWeight = v2.ModelWeight or 80
    v3.BaseModelScale = 1
    v3.LimitedEggViewportScale = 1
    v3.LimitedEggViewportVerticalOffset = 0
    v3.BaseModelColor = Color3.new(1, 1, 1)
    v3.PossibleModelColors = table.freeze({table.freeze({Color3.new(1, 1, 1), 1})})
    local freeze_3 = table.freeze
    local v4 = {}
    local Idle = v2.Idle
    if Idle then
        local Animation = Instance.new("Animation")
        Animation.AnimationId = "rbxassetid://" .. Idle
        v1 = Animation
    else
        v1 = nil
    end
    v4.Idle = v1
    local Walk = v2.Walk
    if Walk then
        local Animation_2 = Instance.new("Animation")
        Animation_2.AnimationId = "rbxassetid://" .. Walk
        v1 = Animation_2
    else
        v1 = nil
    end
    v4.Walk = v1
    v3.Animations = freeze_3(v4)
    v3.WalkSound = nil
    v3.RandomIdleSound = nil
    v3.PlaceSound = nil
    v3.DontRoll = true
    local freeze_4 = table.freeze
    v4 = {WeightKg = 80}
    local EggModel = if v2.Group ~= "World" then v2.EggModel else v2.DisplayName .. " Egg"
    v4.DisplayName = EggModel
    v4.ModelName = v2.EggModel
    v4.Icon = "rbxassetid://" .. v2.EggIcon
    v4.GrowthTime = v2.GrowthTime
    v4.IgnoreSizeGrowthMultiplier = v2.Group ~= "World"
    v3.Egg = freeze_4(v4)
    return table.freeze(v3)
end