-- Script path: ReplicatedStorage.Data.Areas.Configs.Cosmic
-- Decompile time: 0.53 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Cosmic",
    Emoji = "🌌",
    GuardId = "Cosmic",
    Icon = "rbxassetid://132367218748284",
    IndexBackgroundImage = "rbxassetid://130113964572741",
    IndexBatGearId = "Cosmic Bat",
    _id = "Cosmic",
    Color = Color3.fromRGB(195, 140, 255),
    DropTable = {
        {"Centapede", 39.869773},
        {"Galaxy Gecko", 34.387407},
        {"Cyclops Gorilla", 19.618806},
        {"La Vacca Saturno Saturnita", 4.550072},
        {"Alien Skeleton Boss", 0.495856},
        {"Cave Dragon", 0.743784},
        {"Eternal Lunar Dragon", 0.311104},
        {"Unicorn", 0.0231993},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Eternal,
})