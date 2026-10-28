-- Script path: ReplicatedStorage.CmdrClient.Commands.mountPets
-- Decompile time: 0.17 ms

return {
    Name = "mountPets",
    Description = "List owned pets, their UIDs, scales and rideable status.",
    Group = "Admin",
    Args = {{Name = "Player", Type = "player", Description = "Owner; defaults to you.", Optional = true}},
}