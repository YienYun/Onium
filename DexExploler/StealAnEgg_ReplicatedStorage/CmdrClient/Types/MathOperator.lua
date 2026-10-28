-- Script path: ReplicatedStorage.CmdrClient.Types.MathOperator
-- Decompile time: 0.71 ms

return function(a1) -- Line: 1
    a1:RegisterType("mathOperator", (a1.Cmdr.Util.MakeEnumType("Math Operator", {
        {
            Name = "+",
            Perform = function(a1, a2) -- Line: 5
                return a1 + a2
            end,
        },
        {
            Name = "-",
            Perform = function(a1, a2) -- Line: 11
                return a1 - a2
            end,
        },
        {
            Name = "*",
            Perform = function(a1, a2) -- Line: 17
                return a1 * a2
            end,
        },
        {
            Name = "/",
            Perform = function(a1, a2) -- Line: 23
                return a1 / a2
            end,
        },
        {
            Name = "**",
            Perform = function(a1, a2) -- Line: 29
                return a1 ^ a2
            end,
        },
        {
            Name = "%",
            Perform = function(a1, a2) -- Line: 35
                return a1 % a2
            end,
        },
    })))
end