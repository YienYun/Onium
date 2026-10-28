-- Script path: ReplicatedStorage.CmdrClient.Commands.giveBossTokens
-- Decompile time: 0.21 ms

return {
    Name = "giveBossTokens",
    Description = "Gives the player Boss Tokens.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to give tokens to."},
        {Type = "integer", Name = "Amount", Description = "The amount of tokens to give."},
    },
}