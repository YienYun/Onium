-- Script path: ReplicatedStorage.CmdrClient.Commands.var
-- Decompile time: 0.34 ms

return {
    Name = "var",
    Description = "Gets a stored variable.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = {
        "alias \"init-edit|Edit your initialization script\" edit ${var init} \\\\\n && var= init ||",
        "alias \"init-run|Re-runs the initialization script manually.\" run-lines ${var init}",
        "init-run",
    },
    Args = {
        {
            Type = "storedKey",
            Name = "Key",
            Description = "The key to get, retrieved from your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved.",
        },
    },
    ClientRun = function(a1, a2) -- Line: 19
        local Store = a1:GetStore("vars_used")
        Store[a2] = true
    end,
}