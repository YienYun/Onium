-- Script path: ReplicatedStorage.CmdrClient.Commands.giveSakuraCrystals
-- Decompile time: 0.18 ms

return {
    Name = "giveSakuraCrystals",
    Description = "Gives the player Sakura Crystals.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to give crystals to."},
        {Type = "integer", Name = "Amount", Description = "The amount of crystals to give."},
    },
}