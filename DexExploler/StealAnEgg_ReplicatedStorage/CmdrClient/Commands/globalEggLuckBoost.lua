-- Script path: ReplicatedStorage.CmdrClient.Commands.globalEggLuckBoost
-- Decompile time: 0.20 ms

return {
    Name = "globalEggLuckBoost",
    Description = "Boosts egg spawn luck on the map in all servers.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "number", Name = "Multiplier", Description = "The multiplier to apply (1 - 100)."},
        {Type = "integer", Name = "Duration", Description = "The duration in seconds."},
    },
}