-- Script path: ReplicatedStorage.CmdrClient.Commands.globalAdminTreadmill
-- Decompile time: 0.19 ms

return {
    Name = "globalAdminTreadmill",
    Description = "Spawns the Admin Treadmill in the base of all servers.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "number", Name = "Multiplier", Description = "The multiplier to apply (1 - 100)."},
        {Type = "integer", Name = "Duration", Description = "The duration in seconds."},
    },
}