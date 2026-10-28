-- Script path: ReplicatedStorage.CmdrClient.Commands.resetButterflies
-- Decompile time: 0.20 ms

return {
    Name = "resetButterflies",
    Description = "Forget a player's butterfly net, butterflies and essence so the Butterfly Bloom can be replayed from scratch.",
    Group = "Admin",
    Args = {{Type = "players", Name = "Player", Description = "The players to reset."}},
}