-- Script path: ReplicatedStorage.CmdrClient.Commands.sakuraUnlock
-- Decompile time: 0.17 ms

return {
    Name = "sakuraUnlock",
    Description = "Unlocks or re-seals the Sakura Incubator for the players.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to change."},
        {Type = "boolean", Name = "Unlocked", Description = "true to unlock, false to seal."},
    },
}