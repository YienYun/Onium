-- Script path: ReplicatedStorage.CmdrClient.Commands.kill
-- Decompile time: 0.15 ms

return {
    Name = "kill",
    Description = "Kills a player or set of players.",
    Group = "DefaultAdmin",
    Aliases = {"slay"},
    Args = {{Type = "players", Name = "victims", Description = "The players to kill."}},
}