-- Script path: ReplicatedStorage.Data.Rarity.Configs.Cosmic
-- Decompile time: 0.43 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Cosmic",
    Rank = 7,
    _id = script.Name,
    Color = Color3.fromRGB(65, 0, 170),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})