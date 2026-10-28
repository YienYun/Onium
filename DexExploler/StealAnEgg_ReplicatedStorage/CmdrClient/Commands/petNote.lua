-- Script path: ReplicatedStorage.CmdrClient.Commands.petNote
-- Decompile time: 0.18 ms

return {
    Name = "petNote",
    Description = "Save mount feedback for the pet currently in mount review.",
    Group = "Admin",
    Aliases = {"note"},
    Args = {{Name = "Text", Type = "string", Description = "Feedback for this pet."}},
}