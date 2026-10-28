-- Script path: ReplicatedStorage.CmdrClient.Commands.giveStars
-- Decompile time: 0.45 ms

return {
    Name = "giveStars",
    Description = "Give physical Star consumables (saved). Equip one and use it on a pet in your base.",
    Group = "Admin",
    Aliases = {"giveMountStars"},
    Args = {
        {Name = "Players", Type = "players", Description = "Recipients; use me for yourself."},
        {
            Name = "Amount",
            Type = "integer",
            Description = "Stars per player, from 1 to 100.",
            Optional = true,
            Default = 1,
        },
    },
}