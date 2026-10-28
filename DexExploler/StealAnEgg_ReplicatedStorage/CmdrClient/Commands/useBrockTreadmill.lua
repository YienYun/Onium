-- Script path: ReplicatedStorage.CmdrClient.Commands.useBrockTreadmill
-- Decompile time: 0.18 ms

return {
    Name = "useBrockTreadmill",
    Description = "Swaps the player's treadmill for the Brock Treadmill until they leave. Pass false to give theirs back.",
    Group = "Admin",
    Aliases = {},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to give the Brock Treadmill to."},
        {
            Type = "boolean",
            Name = "Enabled",
            Description = "true to use the Brock Treadmill, false to go back to their own.",
            Optional = true,
            Default = true,
        },
    },
}