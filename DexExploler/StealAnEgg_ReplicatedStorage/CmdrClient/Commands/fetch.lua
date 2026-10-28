-- Script path: ReplicatedStorage.CmdrClient.Commands.fetch
-- Decompile time: 0.14 ms

return {
    Name = "fetch",
    Description = "Fetch a value from the Internet",
    Group = "DefaultDebug",
    Aliases = {},
    Args = {{Type = "url", Name = "URL", Description = "The URL to fetch."}},
}