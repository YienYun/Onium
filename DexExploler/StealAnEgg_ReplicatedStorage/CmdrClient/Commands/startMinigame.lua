-- Script path: ReplicatedStorage.CmdrClient.Commands.startMinigame
-- Decompile time: 0.33 ms

return {
    Name = "startMinigame",
    Description = "Start an admin abuse minigame in this server, or queue it behind the same minigame. Choose the egg it awards and its mutation.",
    Group = "Moderator",
    Args = {
        {Type = "minigameName", Name = "Minigame", Description = "Which minigame to start."},
        {
            Type = "assetName",
            Name = "Egg",
            Description = "The animal the minigame egg hatches into. Defaults to the minigame's own egg.",
            Optional = true,
        },
        {
            Type = "mutation",
            Name = "Mutation",
            Description = "Mutation forced onto the minigame egg. None when omitted.",
            Optional = true,
        },
    },
}