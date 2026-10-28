-- Script path: ReplicatedStorage.CmdrClient.Commands.shootingStar
-- Decompile time: 0.14 ms

return {
    Name = "shootingStar",
    Description = "Drop a shooting star in this server now",
    Group = "Moderator",
    Args = {
        {
            Type = "boolean",
            Name = "Everyone",
            Description = "true: everyone here can claim it (default). false: only players present since this day began",
            Optional = true,
        },
    },
}