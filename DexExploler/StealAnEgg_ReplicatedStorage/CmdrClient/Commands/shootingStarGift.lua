-- Script path: ReplicatedStorage.CmdrClient.Commands.shootingStarGift
-- Decompile time: 0.22 ms

return {
    Name = "shootingStarGift",
    Description = "Play the Star Guy gift celebration on a player (nothing is granted)",
    Group = "Moderator",
    Args = {
        {
            Type = "player",
            Name = "Player",
            Description = "Who receives the celebration. Use me for yourself.",
        },
        {
            Type = "integer",
            Name = "Count",
            Description = "How many stars to show (default 1)",
            Optional = true,
        },
    },
}