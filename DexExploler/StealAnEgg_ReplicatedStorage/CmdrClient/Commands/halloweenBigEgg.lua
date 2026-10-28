-- Script path: ReplicatedStorage.CmdrClient.Commands.halloweenBigEgg
-- Decompile time: 0.24 ms

return {
    Name = "halloweenBigEgg",
    Description = "Spawn big, collectible Halloween eggs at nearby nests in a zone on this server.",
    Group = "Admin",
    Aliases = {"halloweenBigEggs"},
    Args = {
        {
            Type = "integer",
            Name = "Zone",
            Description = "1: Graveyard, 2: Swamp, 3: Cursed Manor.",
            Default = 1,
        },
        {
            Type = "number",
            Name = "Scale",
            Description = "Saved egg scale, from 1 to 8; default 5.",
            Default = 5,
        },
        {
            Type = "integer",
            Name = "Count",
            Description = "Number of eggs, from 1 to 10; default 1.",
            Default = 1,
        },
    },
}