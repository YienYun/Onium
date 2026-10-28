-- Script path: ReplicatedStorage.CmdrClient.Commands.pullProdData
-- Decompile time: 0.24 ms

return {
    Name = "pullProdData",
    Description = "[TESTING AND DEV ONLY] Pulls production data and sets your data to it.",
    Group = "Admin",
    Args = {{Type = "integer", Name = "UserId", Description = "The UserId of the player to pull their data"}},
}