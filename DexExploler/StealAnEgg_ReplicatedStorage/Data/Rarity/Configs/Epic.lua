-- Script path: ReplicatedStorage.Data.Rarity.Configs.Epic
-- Decompile time: 0.50 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Epic",
    Rank = 4,
    _id = script.Name,
    Color = Color3.fromRGB(196, 2, 255),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})