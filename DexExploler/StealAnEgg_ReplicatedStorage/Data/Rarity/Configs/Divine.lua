-- Script path: ReplicatedStorage.Data.Rarity.Configs.Divine
-- Decompile time: 0.44 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Divine",
    Rank = 10,
    _id = script.Name,
    Color = Color3.fromRGB(251, 255, 0),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})