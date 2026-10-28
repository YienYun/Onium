-- Script path: ReplicatedStorage.Data.Areas.Configs.Cherry Blossom
-- Decompile time: 0.55 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Cherry Blossom",
    Emoji = "🌸",
    GuardId = "Cherry Blossom",
    Icon = "rbxassetid://128921736835133",
    IndexBatGearId = "Katana",
    Lighting = "CherryBlossom",
    _id = "Cherry Blossom",
    Color = Color3.fromRGB(255, 138, 190),
    DropTable = {
        {"Crane", 37.51},
        {"Salamander", 26.27},
        {"Red Panda", 16.83},
        {"Snowy Owl", 13.96},
        {"Koi", 4.36},
        {"Stag", 0.74},
        {"Oni Tiger", 0.31},
        {"Kitsune", 0.02},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Divine,
})