-- Script path: ReplicatedStorage.CmdrClient.Commands.setSpeedPower
-- Decompile time: 0.22 ms

return {
    Name = "setSpeedPower",
    Description = "Sets the player's Speed.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Player", Description = "The players to give speed to."},
        {Type = "integer", Name = "Amount", Description = "The amount of speed to give."},
    },
}