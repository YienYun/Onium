-- Script path: ReplicatedStorage.CmdrClient.Commands.globalProgressEggHatchTime
-- Decompile time: 0.14 ms

return {
    Name = "globalProgressEggHatchTime",
    Description = "Increments the hatch time on all the placed eggs",
    Group = "Moderator",
    Args = {{Type = "integer", Name = "Amount", Description = "The amount of hatch time to progress"}},
}