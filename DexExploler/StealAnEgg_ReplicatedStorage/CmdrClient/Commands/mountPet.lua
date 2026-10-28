-- Script path: ReplicatedStorage.CmdrClient.Commands.mountPet
-- Decompile time: 0.16 ms

return {
    Name = "mountPet",
    Description = "Start riding an owned rideable pet.",
    Group = "Admin",
    Args = {
        {Name = "UID", Type = "string", Description = "Pet UID; use mountPets to list your pets."},
        {Name = "Player", Type = "player", Description = "Rider; defaults to you.", Optional = true},
    },
}