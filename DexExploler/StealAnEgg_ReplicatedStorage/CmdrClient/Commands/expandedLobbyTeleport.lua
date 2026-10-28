-- Script path: ReplicatedStorage.CmdrClient.Commands.expandedLobbyTeleport
-- Decompile time: 0.21 ms

return {
    Name = "expandedLobbyTeleport",
    Description = "Teleports players into a reserved server locked to an ExpandedLobby group.",
    Group = "Admin",
    Aliases = {},
    Args = {
        {Type = "string", Name = "Group", Description = "Control or Variant."},
        {
            Type = "players",
            Name = "Players",
            Description = "The players to teleport. Defaults to you.",
            Optional = true,
        },
    },
}