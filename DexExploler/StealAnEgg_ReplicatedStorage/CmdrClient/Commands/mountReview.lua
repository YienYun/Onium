-- Script path: ReplicatedStorage.CmdrClient.Commands.mountReview
-- Decompile time: 0.22 ms

return {
    Name = "mountReview",
    Description = "Start temporary mounted-pet review in DEV, TEST or Studio; optional catalogue number and pet scale.",
    Group = "Admin",
    Aliases = {"mountSimulator"},
    Args = {
        {
            Name = "Index",
            Type = "integer",
            Description = "Catalogue number, defaults to 1.",
            Optional = true,
        },
        {
            Name = "Scale",
            Type = "number",
            Description = "Pet scale, defaults to 1 (0.1 to 150).",
            Optional = true,
        },
    },
}