-- Script path: ReplicatedStorage.CmdrClient.Commands.giveSpeedPower
-- Decompile time: 0.18 ms

return {
    Name = "giveSpeedPower",
    Description = "Gives Speed to players.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to give speed to."},
        {Type = "integer", Name = "Amount", Description = "The amount of speed to give."},
    },
}