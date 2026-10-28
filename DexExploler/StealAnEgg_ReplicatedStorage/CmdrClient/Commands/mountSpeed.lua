-- Script path: ReplicatedStorage.CmdrClient.Commands.mountSpeed
-- Decompile time: 0.20 ms

return {
    Name = "mountSpeed",
    Description = "Override mount speed; omit speed or use 0 to inherit player speed again.",
    Group = "Admin",
    Args = {
        {
            Name = "Speed",
            Type = "number",
            Description = "Override in studs/s; 0 resets it.",
            Optional = true,
        },
        {Name = "Player", Type = "player", Description = "Rider; defaults to you.", Optional = true},
    },
}