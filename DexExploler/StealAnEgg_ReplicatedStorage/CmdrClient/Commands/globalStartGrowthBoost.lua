-- Script path: ReplicatedStorage.CmdrClient.Commands.globalStartGrowthBoost
-- Decompile time: 0.47 ms

return {
    Name = "globalStartGrowthBoost",
    Description = "Adds an growth boost in all servers",
    Group = "Moderator",
    Args = {
        {
            Type = "integer",
            Name = "Multiplier",
            Description = "NOTE +1 Multiplier = x2 multiplier, multiplier added.",
        },
        {Type = "integer", Name = "Duration"},
    },
}