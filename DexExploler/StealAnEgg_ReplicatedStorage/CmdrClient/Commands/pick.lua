-- Script path: ReplicatedStorage.CmdrClient.Commands.pick
-- Decompile time: 0.29 ms

return {
    Name = "pick",
    Description = "Picks a value out of a comma-separated list.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "integer",
            Name = "Index to pick",
            Description = "The index of the item you want to pick",
        },
        {Type = "string", Name = "CSV", Description = "The comma-separated list"},
    },
    Run = function(a1, a2, a3) -- Line: 19
        return a3:split(",")[a2] or ""
    end,
}