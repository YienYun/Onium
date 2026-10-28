-- Script path: ReplicatedStorage.CmdrClient.Commands.pullPlayer
-- Decompile time: 0.14 ms

return {
    Name = "pullPlayer",
    Description = "Teleports a player from another server in this game into your server.",
    Group = "Admin",
    Args = {{Type = "string", Name = "Username", Description = "The player's full username."}},
}