-- Script path: ReplicatedStorage.CmdrClient.Commands.varSet
-- Decompile time: 0.35 ms

return {
    Name = "var=",
    Description = "Sets a stored value.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "storedKey",
            Name = "Key",
            Description = "The key to set, saved in your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved.",
        },
        {Type = "string", Name = "Value", Description = "Value or values to set.", Default = ""},
    },
    ClientRun = function(a1, a2) -- Line: 20
        local Store = a1:GetStore("vars_used")
        Store[a2] = true
    end,
}