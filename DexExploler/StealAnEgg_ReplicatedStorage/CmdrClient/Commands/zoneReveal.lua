-- Script path: ReplicatedStorage.CmdrClient.Commands.zoneReveal
-- Decompile time: 0.28 ms

return {
    Name = "zoneReveal",
    Description = "Reveals or hides the Cherry Blossom zone on this server (open by default, the dragon event hides it).",
    Group = "Admin",
    Aliases = {""},
    Args = {{Type = "boolean", Name = "Revealed", Description = "true to reveal, false to hide."}},
}