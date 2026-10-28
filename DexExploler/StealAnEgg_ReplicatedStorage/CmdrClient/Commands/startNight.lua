-- Script path: ReplicatedStorage.CmdrClient.Commands.startNight
-- Decompile time: 0.17 ms

return {
    Name = "startNight",
    Description = "Start the area egg night now, ending this reset period early",
    Group = "Moderator",
    Args = {{Type = "number", Name = "Night Duration", Optional = true}},
}