-- Script path: ReplicatedStorage.CmdrClient.Commands.nightDuration
-- Decompile time: 0.17 ms

return {
    Name = "nightDuration",
    Description = "Override how long the area egg night lasts, or omit to restore the default",
    Group = "Moderator",
    Args = {{Type = "number", Name = "Seconds", Optional = true}},
}