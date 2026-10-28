-- Script path: ReplicatedStorage.CmdrClient.Commands.globalMutationBoost
-- Decompile time: 0.19 ms

return {
    Name = "globalMutationBoost",
    Description = "Boosts egg mutation chances in all servers.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "number", Name = "Multiplier", Description = "The multiplier to apply (1 - 16)."},
        {Type = "integer", Name = "Duration", Description = "The duration in seconds."},
    },
}