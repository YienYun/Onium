-- Script path: ReplicatedStorage.CmdrClient.Commands.giveEssence
-- Decompile time: 0.23 ms

return {
    Name = "giveEssence",
    Description = "Give Enchanted Essence mutation consumables.",
    Group = "Admin",
    Args = {
        {Type = "players", Name = "Player", Description = "Players to give Enchanted Essence to."},
        {
            Type = "positiveInteger",
            Name = "Amount",
            Description = "How many to give, from 1 to 1000.",
            Default = 1,
        },
    },
}