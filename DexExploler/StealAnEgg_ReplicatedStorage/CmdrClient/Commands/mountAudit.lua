-- Script path: ReplicatedStorage.CmdrClient.Commands.mountAudit
-- Decompile time: 0.18 ms

return {
    Name = "mountAudit",
    Description = "Audit every pet, or one species, for mount attachments and R15 reach at four sizes.",
    Group = "Admin",
    Args = {
        {
            Name = "Species",
            Type = "string",
            Description = "Optional exact species; omit to scan all pets.",
            Optional = true,
        },
    },
}