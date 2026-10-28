-- Script path: ReplicatedStorage.CmdrClient.Commands.kick
-- Decompile time: 0.17 ms

return {
    Name = "kick",
    Description = "Kicks a player or set of players.",
    Group = "DefaultAdmin",
    Aliases = {"boot"},
    Args = {{Type = "players", Name = "players", Description = "The players to kick."}},
}