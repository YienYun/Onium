-- Script path: ReplicatedStorage.CmdrClient.Commands.JumpPower
-- Decompile time: 0.19 ms

return {
    Name = "jumppower",
    Description = "Sets the jump power of a player.",
    Group = "Tester",
    Aliases = {"jp"},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to change the jump power of"},
        {Type = "number", Name = "power", Description = "The jumppower value to set"},
    },
}