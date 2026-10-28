-- Script path: ReplicatedStorage.CmdrClient.Commands.testAdLobby
-- Decompile time: 0.33 ms

return {
    Name = "testAdLobby",
    Description = "Temporarily test expanded lobby with ad variants in a reserved server. Clear returns to normal matchmaking.",
    Group = "Admin",
    Aliases = {"rvTestLobby"},
    Args = {
        {
            Type = "string",
            Name = "Variant",
            Description = "Both (default), Cash, Eggs, Control, 1-4, or Clear.",
            Optional = true,
        },
    },
}