-- Script path: ReplicatedStorage.Data.Rarity.Configs.Rare
-- Decompile time: 0.48 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Rare",
    Rank = 3,
    _id = script.Name,
    Color = Color3.fromRGB(25, 144, 255),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})