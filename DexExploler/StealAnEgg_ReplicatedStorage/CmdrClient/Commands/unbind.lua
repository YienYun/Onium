-- Script path: ReplicatedStorage.CmdrClient.Commands.unbind
-- Decompile time: 0.43 ms

return {
    Name = "unbind",
    Description = "Unbinds an input previously bound with Bind",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "userInput ! bindableResource @ player",
            Name = "Input/Key",
            Description = "The key or input type you'd like to unbind.",
        },
    },
    ClientRun = function(a1, a2) -- Line: 14
        local Store = a1:GetStore("CMDR_Binds")
        if not Store[a2] then
            return "That input wasn't bound."
        end
        Store[a2]:Disconnect()
        Store[a2] = nil
        return "Unbound command from input."
    end,
}