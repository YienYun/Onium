-- Script path: ReplicatedStorage.CmdrClient.Commands.convertTimestamp
-- Decompile time: 0.35 ms

return {
    Name = "convertTimestamp",
    Description = "Convert a timestamp to a human-readable format.",
    Group = "DefaultUtil",
    Aliases = {"date"},
    Args = {
        {
            Type = "number",
            Name = "timestamp",
            Description = "A numerical representation of a specific moment in time.",
            Optional = true,
        },
    },
    ClientRun = function(a1, a2) -- Line: 14
        local v1 = a2 or os.time()
        return (("%* %*"):format(os.date("%x", v1), (os.date("%X", v1))))
    end,
}