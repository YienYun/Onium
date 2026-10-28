-- Script path: ReplicatedStorage.Data.Rarity.Configs.BrainrotGod
-- Decompile time: 0.44 ms

local v1 = (game:GetService("ReplicatedStorage")).Assets.UI.RarityGradients:FindFirstChild(script.Name)
assert(v1, (("RarityGradients has no \"%*\" folder"):format(script.Name)))
return table.freeze({
    DisplayName = "Squishy God",
    Rank = 6,
    _id = script.Name,
    Color = Color3.fromRGB(172, 0, 198),
    RarityGradient = v1.RarityGradient,
    ItemTemplate = v1.ItemTemplate,
})