-- Script path: ReplicatedStorage.Data.Rarity.Configs.Legendary
-- Decompile time: 0.41 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Legendary",
    Rank = 5,
    _id = script.Name,
    Color = Color3.fromRGB(254, 132, 36),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})