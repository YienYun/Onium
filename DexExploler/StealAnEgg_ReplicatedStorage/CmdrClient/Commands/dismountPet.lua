-- Script path: ReplicatedStorage.CmdrClient.Commands.dismountPet
-- Decompile time: 0.15 ms

return {
    Name = "dismountPet",
    Description = "Stop riding and restore your character.",
    Group = "Admin",
    Args = {{Name = "Player", Type = "player", Description = "Rider; defaults to you.", Optional = true}},
}