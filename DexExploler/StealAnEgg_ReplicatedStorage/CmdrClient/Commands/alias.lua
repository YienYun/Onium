-- Script path: ReplicatedStorage.CmdrClient.Commands.alias
-- Decompile time: 0.37 ms

return {
    Name = "alias",
    Description = "Creates a new, single command out of a command and given arguments.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "string",
            Name = "Alias name",
            Description = "The key or input type you'd like to bind the command to.",
        },
        {
            Type = "string",
            Name = "Command string",
            Description = "The command text you want to run. Separate multiple commands with \"&&\". Accept arguments with $1, $2, $3, etc.",
        },
    },
    ClientRun = function(a1, a2, a3) -- Line: 19
        a1.Cmdr.Registry:RegisterCommandObject(a1.Cmdr.Util.MakeAliasCommand(a2, a3), true)
        return ("Created alias %q"):format(a2)
    end,
}