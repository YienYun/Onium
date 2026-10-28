-- Script path: ReplicatedStorage.CmdrClient.Commands.history
-- Decompile time: 0.58 ms

return {
    Name = "history",
    Description = "Displays previous commands from history.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = {
        "alias \"!|Displays previous command from history.\" run ${history $1{number|Line Number}}",
        "alias \"^|Runs the previous command, replacing all occurrences of A with B.\" run ${run replace ${history -1} $1{string|A} $2{string|B}}",
        "alias \"!!|Reruns the last command.\" ! -1",
    },
    Args = {
        {
            Type = "integer",
            Name = "Line Number",
            Description = "Command line number (can be negative to go from end)",
        },
    },
    ClientRun = function(a1, a2) -- Line: 19
        local History = a1.Dispatcher:GetHistory()
        if a2 <= 0 then
            a2 = #History + a2
        end
        return History[a2] or ""
    end,
}