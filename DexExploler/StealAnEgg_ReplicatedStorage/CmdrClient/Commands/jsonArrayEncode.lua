-- Script path: ReplicatedStorage.CmdrClient.Commands.jsonArrayEncode
-- Decompile time: 0.31 ms

local HttpService = game:GetService("HttpService")
return {
    Name = "json-array-encode",
    Description = "Encodes a comma-separated list into a JSON array",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {{Type = "string", Name = "CSV", Description = "The comma-separated list"}},
    Run = function(a1, a2) -- Line: 16 -- upvalues: HttpService (val)
        return HttpService:JSONEncode((a2:split(",")))
    end,
}