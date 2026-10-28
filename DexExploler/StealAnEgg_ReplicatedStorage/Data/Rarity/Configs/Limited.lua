-- Script path: ReplicatedStorage.Data.Rarity.Configs.Limited
-- Decompile time: 0.43 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Limited",
    Rank = 9,
    _id = script.Name,
    Color = Color3.fromRGB(174, 80, 254),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})