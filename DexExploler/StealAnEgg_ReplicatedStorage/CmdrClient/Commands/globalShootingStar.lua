-- Script path: ReplicatedStorage.CmdrClient.Commands.globalShootingStar
-- Decompile time: 0.16 ms

return {
    Name = "globalShootingStar",
    Description = "Drop a shooting star in every server now",
    Group = "Admin",
    Args = {
        {
            Type = "boolean",
            Name = "Everyone",
            Description = "true: everyone in each server can claim it (default). false: only players present since that server's day began",
            Optional = true,
        },
    },
}