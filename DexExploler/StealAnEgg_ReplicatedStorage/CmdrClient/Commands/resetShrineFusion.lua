-- Script path: ReplicatedStorage.CmdrClient.Commands.resetShrineFusion
-- Decompile time: 0.25 ms

return {
    Name = "resetShrineFusion",
    Description = "Clear a player's once-per-account shrine fusion so it can be run again.",
    Group = "Admin",
    Args = {
        {Type = "players", Name = "Player", Description = "The players to reset."},
        {
            Type = "shrineFusionTier",
            Name = "Tier",
            Description = "One fusion tier, or All.",
            Default = "All",
            Optional = true,
        },
    },
}