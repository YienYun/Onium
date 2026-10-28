-- Script path: ReplicatedStorage.Data.Rarity.Configs.Eternal
-- Decompile time: 0.45 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Eternal",
    Rank = 9,
    _id = script.Name,
    Color = Color3.fromRGB(255, 30, 240),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})