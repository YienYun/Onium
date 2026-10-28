-- Script path: ReplicatedStorage.Data.Assets.Configs.RazorFang
-- Decompile time: 1.45 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(a1) -- Line: 6 -- types: a1: string
    local Animation = Instance.new("Animation")
    Animation.AnimationId = a1
    return Animation
end

local freeze = table.freeze
local v1 = {
    _id = "RazorFang",
    DisplayName = "RazorFang",
    Icon = "rbxassetid://102849850756685",
    EarningRate = 350000000,
    IndexSpeedReward = 90000000,
    DropWeight = 0,
    VisualOdds = 135.13513513513513,
    ModelWeight = 12000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "RazorFang Egg",
        Icon = "rbxassetid://78651457785123",
        ModelName = "RazorFang",
        GrowthTime = 12600,
        WeightKg = 5,
    }),
}
local freeze_2 = table.freeze
local v2 = {}
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://136791371854597"
v2.Idle = Animation
local Animation_2 = Instance.new("Animation")
Animation_2.AnimationId = "rbxassetid://103039030085527"
v2.Walk = Animation_2
v1.Animations = freeze_2(v2)
v1.Rarity = Rarity.Rarities.Secret
v1.BaseModelColor = Color3.fromRGB(85, 78, 76)
v1.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(85, 78, 76), 80}),
    table.freeze({Color3.fromRGB(104, 87, 75), 19}),
    (table.freeze({Color3.fromRGB(255, 255, 255), 1})),
})
return freeze(v1)