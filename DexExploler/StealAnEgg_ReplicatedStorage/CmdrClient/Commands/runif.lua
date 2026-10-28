-- Script path: ReplicatedStorage.CmdrClient.Commands.runif
-- Decompile time: 1.63 ms

local u0 = {}

function u0.startsWith(a1, a2) -- Line: 2
    if a1:sub(1, #a2) == a2 then
        return a1:sub(#a2 + 1)
    end
end

return {
    Name = "runif",
    Description = "Runs a given command string if a certain condition is met.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "conditionFunction", Name = "Condition", Description = "The condition function"},
        {Type = "string", Name = "Argument", Description = "The argument to the condition function"},
        {Type = "string", Name = "Test against", Description = "The text to test against."},
        {
            Type = "string",
            Name = "Command",
            Description = "The command string to run if requirements are met. If omitted, return value from condition function is used.",
            Optional = true,
        },
    },
    Run = function(a1, a2, a3, a4, a5) -- Line: 38 -- upvalues: u0 (val)
        local v1 = u0[a2]
        if not v1 then
            return ("Condition %q is not valid."):format(a2)
        end
        local v2 = v1(a4, a3)
        if v2 then
            return a1.Dispatcher:EvaluateAndRun((a1.Cmdr.Util.RunEmbeddedCommands(a1.Dispatcher, a5 or v2)))
        end
        return ""
    end,
}