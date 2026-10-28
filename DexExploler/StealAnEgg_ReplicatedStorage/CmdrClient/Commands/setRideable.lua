-- Script path: ReplicatedStorage.CmdrClient.Commands.setRideable
-- Decompile time: 0.19 ms

return {
    Name = "setRideable",
    Description = "Set the rideable status of one owned pet (persistent).",
    Group = "Admin",
    Args = {
        {Name = "UID", Type = "string", Description = "Pet UID; use mountPets to list your pets."},
        {
            Name = "Enabled",
            Type = "boolean",
            Description = "true to enable, false to remove riding.",
            Optional = true,
        },
        {
            Name = "Player",
            Type = "player",
            Description = "Pet owner; defaults to you.",
            Optional = true,
        },
    },
}