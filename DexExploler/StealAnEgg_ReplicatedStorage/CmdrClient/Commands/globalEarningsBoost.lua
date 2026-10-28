-- Script path: ReplicatedStorage.CmdrClient.Commands.globalEarningsBoost
-- Decompile time: 0.21 ms

return {
    Name = "globalEarningsBoost",
    Description = "Boosts brainrot earnings in all servers.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "number", Name = "Multiplier", Description = "The multiplier to apply (1 - 16)."},
        {Type = "integer", Name = "Duration", Description = "The duration in seconds."},
    },
}