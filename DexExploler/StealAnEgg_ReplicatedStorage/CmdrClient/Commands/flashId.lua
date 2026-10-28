-- Script path: ReplicatedStorage.CmdrClient.Commands.flashId
-- Decompile time: 0.16 ms

return {
    Name = "flash-id",
    Description = "Flashes every player's own user id on their screen, in every server. Defaults to above the hotbar.",
    Group = "Admin",
    Args = {
        {
            Type = "flashPosition",
            Name = "Position",
            Description = "Where it shows: bottom (above the hotbar), top, center, left or right",
            Optional = true,
        },
    },
}