-- Script path: ReplicatedStorage.Data.Rarity.Configs.Mythic
-- Decompile time: 0.42 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Mythic",
    Rank = 6,
    _id = script.Name,
    Color = Color3.fromRGB(254, 44, 102),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})