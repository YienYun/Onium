-- Script path: ReplicatedStorage.CmdrClient.Commands.gotoPlayer
-- Decompile time: 0.15 ms

return {
    Name = "goto-player",
    Description = "Join a player's server by Roblox username.",
    Group = "Admin",
    Aliases = {"join-player"},
    Args = {{Type = "string", Name = "Username", Description = "The player's Roblox username"}},
}