-- Script path: ReplicatedStorage.Data.Areas.Configs.Forest
-- Decompile time: 0.44 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Forest",
    Emoji = "🙂",
    GuardId = "Forest",
    Icon = "rbxassetid://110449023764288",
    IndexBatGearId = "Forest Bat",
    _id = "Forest",
    Color = Color3.fromRGB(110, 205, 105),
    DropTable = {
        {"Chicken", 34},
        {"Dog", 24},
        {"DesertLark", 17},
        {"Burrowing Owl", 10},
        {"Raccoon", 7},
        {"Mire Fox", 4.5},
        {"Bear", 2.5},
        {"Brr Brr Patapim", 1},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Common,
})