-- Script path: ReplicatedStorage.CmdrClient.Commands.abTestGroup
-- Decompile time: 0.21 ms

return {
    Name = "abTestGroup",
    Description = "Forces a sticky A/B test group for players. Applies on next join or server hop.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players whose group to set."},
        {
            Type = "string",
            Name = "Test",
            Description = "The test name, e.g. ExpandedLobbyTest or AfkTreadmillTest.",
        },
        {
            Type = "string",
            Name = "Group",
            Description = "The group name to pin, or Clear to return to normal enrollment.",
        },
    },
}