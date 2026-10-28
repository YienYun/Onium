-- Script path: ReplicatedStorage.CmdrClient.Commands.approvePet
-- Decompile time: 0.21 ms

return {
    Name = "approvePet",
    Description = "Approve the mount fit of the pet currently in mount review.",
    Group = "Admin",
    Aliases = {"approve"},
    Args = {{Name = "Note", Type = "string", Description = "Optional comment.", Optional = true}},
}