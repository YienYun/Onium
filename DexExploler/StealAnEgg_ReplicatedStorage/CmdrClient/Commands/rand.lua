-- Script path: ReplicatedStorage.CmdrClient.Commands.rand
-- Decompile time: 0.35 ms

return {
    Name = "rand",
    Description = "Returns a random number between min and max",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "integer",
            Name = "First number",
            Description = "If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number.",
        },
        {Type = "integer", Name = "Second number", Description = "The upper bound.", Optional = true},
    },
    Run = function(a1, a2, a3) -- Line: 20
        return (tostring(a3 and math.random(a2, a3) or math.random(a2)))
    end,
}