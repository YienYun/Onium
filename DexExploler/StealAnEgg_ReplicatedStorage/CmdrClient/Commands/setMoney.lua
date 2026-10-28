-- Script path: ReplicatedStorage.CmdrClient.Commands.setMoney
-- Decompile time: 0.17 ms

return {
    Name = "setMoney",
    Description = "Sets the player money.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to give money to."},
        {Type = "integer", Name = "Amount", Description = "The amount of money to give."},
    },
}