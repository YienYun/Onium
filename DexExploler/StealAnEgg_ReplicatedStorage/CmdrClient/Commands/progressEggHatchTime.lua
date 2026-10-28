-- Script path: ReplicatedStorage.CmdrClient.Commands.progressEggHatchTime
-- Decompile time: 0.45 ms

return {
    Name = "progressEggHatchTime",
    Description = "Increments the hatch time on all the placed eggs",
    Group = "Moderator",
    Args = {
        {Type = "players", Name = "Players"},
        {Type = "integer", Name = "Amount", Description = "The amount of hatch time to progress"},
    },
}