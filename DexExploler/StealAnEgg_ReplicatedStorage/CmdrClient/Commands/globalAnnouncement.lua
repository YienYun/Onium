-- Script path: ReplicatedStorage.CmdrClient.Commands.globalAnnouncement
-- Decompile time: 0.15 ms

return {
    Name = "globalAnnouncement",
    Description = "Shows a global announcement.",
    Group = "Admin",
    Aliases = {""},
    Args = {{Type = "string", Name = "Text", Description = "The announcement to show."}},
}