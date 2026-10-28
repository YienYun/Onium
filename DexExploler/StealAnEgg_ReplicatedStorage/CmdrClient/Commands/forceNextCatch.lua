-- Script path: ReplicatedStorage.CmdrClient.Commands.forceNextCatch
-- Decompile time: 0.18 ms

return {
    Name = "forceNextCatch",
    Description = "Force the next Haunted Rod catch (one shot, consumed by the next cast).",
    Group = "Admin",
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "Players to arm. Defaults to you.",
            Optional = true,
        },
        {
            Type = "string",
            Name = "Reward",
            Description = "ghostfish, tokens, egg, mutation, pet (also the Ghost Fish), manorkey (sewer cave, key not claimed yet) or clear",
            Default = "ghostfish",
        },
    },
}