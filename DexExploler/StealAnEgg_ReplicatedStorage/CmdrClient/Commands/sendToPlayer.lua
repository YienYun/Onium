-- Script path: ReplicatedStorage.CmdrClient.Commands.sendToPlayer
-- Decompile time: 0.16 ms

return {
    Name = "sendToPlayer",
    Description = "Teleports one account into whichever server another account is in.",
    Group = "Admin",
    Args = {
        {Type = "string", Name = "Player", Description = "The account to move. Username or UserId."},
        {
            Type = "string",
            Name = "Destination",
            Description = "The account whose server they land in. Username or UserId.",
        },
    },
}