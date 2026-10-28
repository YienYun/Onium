-- Script path: ReplicatedStorage.CmdrClient.Commands.version
-- Decompile time: 0.17 ms

return {
    Name = "version",
    Description = "Shows the current version of Cmdr",
    Group = "DefaultDebug",
    Args = {},
    Run = function() -- Line: 9
        return ("Cmdr Version %s"):format("v1.12.0")
    end,
}