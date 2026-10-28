-- Script path: ReplicatedStorage.Data.Areas.Configs.Prehistoric
-- Decompile time: 0.63 ms

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Prehistoric",
    Emoji = "😨",
    GuardId = "Prehistoric",
    Icon = "rbxassetid://128413001319264",
    IndexBatGearId = "Prehistoric Bat",
    _id = "Prehistoric",
    Color = Color3.fromRGB(200, 130, 70),
    DropTable = {
        {"Dodo", 39.066058},
        {"Pterodactyl", 26.044039},
        {"Ankylosaurus", 20.835231},
        {"Triceratops", 4.929402},
        {"Bronto", 6.995959},
        {"TyrannosaurusRex", 0.991743},
        {"Tralaledon", 0.826453},
        {"Mosasaurus", 0.311113},
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Secret,
})