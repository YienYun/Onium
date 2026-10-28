-- Script path: ReplicatedStorage.CmdrClient.Commands.announcement
-- Decompile time: 0.15 ms

return {
    Name = "announcement",
    Description = "Shows an announcement to your server.",
    Group = "Admin",
    Aliases = {""},
    Args = {{Type = "string", Name = "Text", Description = "The announcement to show."}},
}