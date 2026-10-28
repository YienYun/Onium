-- Script path: ReplicatedStorage.CmdrClient.Commands.math
-- Decompile time: 0.35 ms

return {
    Name = "math",
    Description = "Perform a math operation on 2 values.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = {
        "alias \"+|Perform an addition.\" math + $1{number|Number} $2{number|Number}",
        "alias \"-|Perform a subtraction.\" math - $1{number|Number} $2{number|Number}",
        "alias \"*|Perform a multiplication.\" math * $1{number|Number} $2{number|Number}",
        "alias \"/|Perform a division.\" math / $1{number|Number} $2{number|Number}",
        "alias \"**|Perform an exponentiation.\" math ** $1{number|Number} $2{number|Number}",
        "alias \"%|Perform a modulus.\" math % $1{number|Number} $2{number|Number}",
    },
    Args = {
        {Type = "mathOperator", Name = "Operation", Description = "A math operation."},
        {Type = "number", Name = "Value", Description = "A number value."},
        {Type = "number", Name = "Value", Description = "A number value."},
    },
    ClientRun = function(a1, a2, a3, a4) -- Line: 32
        return a2.Perform(a3, a4)
    end,
}