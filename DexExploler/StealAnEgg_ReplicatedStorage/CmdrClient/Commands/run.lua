-- Script path: ReplicatedStorage.CmdrClient.Commands.run
-- Decompile time: 0.32 ms

return {
    Name = "run",
    Description = "Runs a given command string (replacing embedded commands).",
    Group = "DefaultUtil",
    Aliases = {">"},
    AutoExec = {"alias \"discard|Run a command and discard the output.\" replace ${run $1} .* \\\"\\\""},
    Args = {{Type = "string", Name = "Command", Description = "The command string to run"}},
    Run = function(a1, a2) -- Line: 17
        return a1.Cmdr.Util.RunCommandString(a1.Dispatcher, a2)
    end,
}