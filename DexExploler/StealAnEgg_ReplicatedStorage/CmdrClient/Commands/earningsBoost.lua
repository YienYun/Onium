-- Script path: ReplicatedStorage.CmdrClient.Commands.earningsBoost
-- Decompile time: 0.24 ms

return {
    Name = "earningsBoost",
    Description = "Gives the player the x2 earnings boost. Duration 0 clears it.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to boost."},
        {
            Type = "integer",
            Name = "DurationSeconds",
            Description = "Seconds to add (default 900). 0 clears the boost.",
            Optional = true,
        },
    },
}