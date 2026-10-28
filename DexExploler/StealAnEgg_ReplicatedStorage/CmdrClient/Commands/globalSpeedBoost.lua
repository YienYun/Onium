-- Script path: ReplicatedStorage.CmdrClient.Commands.globalSpeedBoost
-- Decompile time: 0.18 ms

return {
    Name = "globalSpeedBoost",
    Description = "Boosts every player's speed in all servers (1.25 = +25%).",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "number", Name = "Multiplier", Description = "The multiplier to apply (1 - 100)."},
        {Type = "integer", Name = "Duration", Description = "The duration in seconds."},
    },
}