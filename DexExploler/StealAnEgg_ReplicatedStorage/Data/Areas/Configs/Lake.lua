-- Script path: ReplicatedStorage.Data.Areas.Configs.Lake
-- Decompile time: 0.51 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Lake",
    Emoji = "😐",
    GuardId = "Lake",
    Icon = "rbxassetid://121852407064086",
    IndexBatGearId = "Lake Bat",
    _id = "Lake",
    Color = Color3.fromRGB(60, 150, 255),
    DropTable = {
        {"Frog", 29.274167},
        {"Duckling", 23.217443},
        {"Catfish", 17.160719},
        {"Turtle", 12.113448},
        {"Trulimero Trulicina", 8.075632},
        {"Swan", 5.551997},
        {"Dream Axolotl", 4.037816},
        {"Basilisk", 0.568777},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Uncommon,
})