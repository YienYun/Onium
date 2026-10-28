-- Script path: ReplicatedStorage.CmdrClient.Commands.scrambleRotate
-- Decompile time: 0.20 ms

return {
    Name = "scrambleRotate",
    Description = "Rotate this server's Dr. Scramble laboratory banner now and restart its one-hour timer.",
    Group = "Admin",
    Aliases = {"labRotate"},
    Args = {
        {
            Type = "string",
            Name = "Banner",
            Description = "next (weighted), Biohazard, Experimental, or UnstableDNA.",
            Optional = true,
            Default = "next",
        },
    },
}