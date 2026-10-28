-- Script path: ReplicatedStorage.CmdrClient.Commands.riftReroll
-- Decompile time: 0.25 ms

return {
    Name = "riftReroll",
    Description = "Rerolls the Rift's 3-pet ask for the players against the live banner. No free refresh is consumed.",
    Group = "Admin",
    Aliases = {""},
    Args = {{Type = "players", Name = "Players", Description = "The players whose ask to reroll."}},
}