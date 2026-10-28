-- Script path: ReplicatedStorage.CmdrClient.Commands.pumpkinBossDoDamage
-- Decompile time: 0.23 ms

return {
    Name = "pumpkinBossDoDamage",
    Description = "Deals damage to the Pumpkin Brute / King, credited to you. Shield and cannon thresholds still block it.",
    Group = "Admin",
    Args = {{Type = "positiveInteger", Name = "Damage", Description = "How much damage to deal."}},
}