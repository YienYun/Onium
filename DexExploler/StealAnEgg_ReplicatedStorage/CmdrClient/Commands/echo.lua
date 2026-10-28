-- Script path: ReplicatedStorage.CmdrClient.Commands.echo
-- Decompile time: 0.20 ms

return {
    Name = "echo",
    Description = "Echoes your text back to you.",
    Group = "DefaultUtil",
    Aliases = {"="},
    Args = {{Type = "string", Name = "Text", Description = "The text."}},
    Run = function(a1, a2) -- Line: 14
        return a2
    end,
}