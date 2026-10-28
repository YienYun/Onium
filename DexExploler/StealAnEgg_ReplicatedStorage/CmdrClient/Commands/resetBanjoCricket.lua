-- Script path: ReplicatedStorage.CmdrClient.Commands.resetBanjoCricket
-- Decompile time: 0.14 ms

return {
    Name = "resetBanjoCricket",
    Description = "Forget a player's Banjo Cricket mushroom solve and reward claim so the secret can be replayed.",
    Group = "Admin",
    Args = {{Type = "players", Name = "Player", Description = "The players to reset."}},
}