-- Script path: ReplicatedStorage.Data.Areas.Configs.Enchanted Forest
-- Decompile time: 0.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
return table.freeze({
    _id = "Enchanted Forest",
    DisplayName = "Enchanted Forest",
    Emoji = "🦋",
    Icon = "rbxassetid://134995639155984",
    GuardId = "Enchanted Forest",
    GuardImpulseProgress = 1,
    ProgressionOrder = 13,
    IndexBatGearId = "EnchantedHammer",
    IndexBackgroundImage = "rbxassetid://97131835055653",
    IndexIncludeDontRoll = true,
    Color = Color3.fromRGB(174, 125, 255),
    AnnouncementColor = Color3.fromRGB(174, 125, 255),
    Rarity = require(ReplicatedStorage.Data.Rarity).Rarities.Secret,
    ZoneGradient = ReplicatedStorage.Assets.UI.Gradients.EnchantedForestGradient,
    DropTable = {
        {"Prism Gecko", 37.51},
        {"Cosmic Beetle Blue", 26.27},
        {"Enchanted Bluejay", 16.83},
        {"Cosmic Fox", 0.74},
        {"Spirit Panda", 4.36},
        {"Spirit Hare", 13.96},
        {"Royal Skywhale", 0.02},
        {"Cosmic Lion", 0.31},
    },
})