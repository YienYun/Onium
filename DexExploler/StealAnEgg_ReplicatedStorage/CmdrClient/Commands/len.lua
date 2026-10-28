-- Script path: ReplicatedStorage.CmdrClient.Commands.len
-- Decompile time: 0.22 ms

return {
    Name = "len",
    Description = "Returns the length of a comma-separated list",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {{Type = "string", Name = "CSV", Description = "The comma-separated list"}},
    Run = function(a1, a2) -- Line: 14
        return #a2:split(",")
    end,
}