-- Script path: ReplicatedStorage.Data.Areas.Configs.Titan Temple
-- Decompile time: 0.46 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Titan Temple",
    Emoji = "🦖",
    GuardId = "Titan Temple",
    Icon = "rbxassetid://112788249655110",
    IndexBatGearId = "Titan Axe",
    _id = "Titan Temple",
    Color = Color3.fromRGB(90, 255, 210),
    DropTable = {
        {"Kaiju Spider", 37.51},
        {"Crab", 26.27},
        {"Blade Head", 16.83},
        {"Mantis", 13.96},
        {"Rhino", 4.36},
        {"Shark", 0.74},
        {"King Kong", 0.31},
        {"Godzilla", 0.02},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Titan,
})