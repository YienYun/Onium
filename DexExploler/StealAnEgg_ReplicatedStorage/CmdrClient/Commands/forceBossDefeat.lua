-- Script path: ReplicatedStorage.CmdrClient.Commands.forceBossDefeat
-- Decompile time: 0.30 ms

return {
    Name = "forceBossDefeat",
    Description = "Grants the players a Dr. Scramble boss kill.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {
            Type = "players",
            Name = "Player",
            Description = "The players to credit with the Dr. Scramble kill.",
        },
    },
}