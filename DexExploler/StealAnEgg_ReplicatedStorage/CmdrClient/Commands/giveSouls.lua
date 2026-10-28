-- Script path: ReplicatedStorage.CmdrClient.Commands.giveSouls
-- Decompile time: 0.17 ms

return {
    Name = "giveSouls",
    Description = "Give saved Souls for the Train Event Soul Keeper.",
    Group = "Admin",
    Args = {
        {Type = "players", Name = "Player", Description = "Players receiving Souls."},
        {
            Type = "positiveInteger",
            Name = "Amount",
            Description = "Souls to grant (Game.TrainEvent.AdminSoulGrantMax).",
            Default = 1000,
        },
    },
}