-- Script path: ReplicatedStorage.CmdrClient.Commands.growWisp
-- Decompile time: 0.17 ms

return {
    Name = "growWisp",
    Description = "Grow a player's Wisp to a stage (1-4). Stage 5 finishes it and unlocks the Enchanted Tree. Leave the stage off to grow it one stage.",
    Group = "Admin",
    Args = {
        {Type = "players", Name = "Player", Description = "The players whose Wisp to grow."},
        {
            Type = "integer",
            Name = "Stage",
            Description = "1-4 grows the Wisp to that stage, 5 unlocks the Enchanted Tree.",
            Optional = true,
        },
    },
}