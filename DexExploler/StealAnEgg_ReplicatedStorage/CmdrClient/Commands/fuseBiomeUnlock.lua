-- Script path: ReplicatedStorage.CmdrClient.Commands.fuseBiomeUnlock
-- Decompile time: 0.21 ms

return {
    Name = "fuseBiomeUnlock",
    Description = "Toggles the Fuse Biome waterfall portal on this server (normally unlocked when the Light vs Darkness event concludes).",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {
            Type = "string",
            Name = "Action",
            Description = "'on'/'off' to force, 'status' to look; omit to toggle.",
            Optional = true,
        },
    },
}