-- Script path: ReplicatedStorage.Data.Areas.Configs.Snow
-- Decompile time: 0.50 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Snow",
    Emoji = "😟",
    GuardId = "Snow",
    Icon = "rbxassetid://94742267172174",
    IndexBatGearId = "Snow Bat",
    _id = "Snow",
    Color = Color3.fromRGB(170, 225, 255),
    DropTable = {
        {"Penguin", 29.444067},
        {"Walrus", 21.570745},
        {"Polar Bear", 18.335133},
        {"Sabertooth Tiger", 14.020984},
        {"Mammoth", 11.86391},
        {"Colossal Mammoth", 4.171033},
        {"Yeti", 0.371904},
        {"Ice Dragon", 0.222224},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Legendary,
})