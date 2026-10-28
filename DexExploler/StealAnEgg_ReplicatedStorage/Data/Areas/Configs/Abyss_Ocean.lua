-- Script path: ReplicatedStorage.Data.Areas.Configs.Abyss Ocean
-- Decompile time: 0.47 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Abyss Ocean",
    Emoji = "😱",
    GuardId = "Abyss Ocean",
    Icon = "rbxassetid://114973940272302",
    IndexBatGearId = "Abyss Ocean Bat",
    _id = "Abyss Ocean",
    Color = Color3.fromRGB(40, 185, 245),
    DropTable = {
        {"Parrotfish", 34.755713},
        {"Swordfish", 24.665345},
        {"Finned Thresher", 19.059585},
        {"Orca", 14.574977},
        {"Whale Shark", 3.412663},
        {"Alabaster Whale", 2.616375},
        {"Kraken", 0.826453},
        {"El Maja", 0.08889},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Cosmic,
})