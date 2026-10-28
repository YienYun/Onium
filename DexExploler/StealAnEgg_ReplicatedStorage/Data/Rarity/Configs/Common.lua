-- Script path: ReplicatedStorage.Data.Rarity.Configs.Common
-- Decompile time: 0.46 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Common",
    Rank = 1,
    _id = script.Name,
    Color = Color3.fromRGB(151, 151, 151),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})