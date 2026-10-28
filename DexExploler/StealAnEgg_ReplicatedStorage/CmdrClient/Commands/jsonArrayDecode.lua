-- Script path: ReplicatedStorage.CmdrClient.Commands.jsonArrayDecode
-- Decompile time: 0.29 ms

return {
    Name = "json-array-decode",
    Description = "Decodes a JSON Array into a comma-separated list",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {{Type = "json", Name = "JSON", Description = "The JSON array."}},
    ClientRun = function(a1, a2) -- Line: 14
        if type(a2) ~= "table" then
            a2 = {a2}
        end
        return table.concat(a2, ",")
    end,
}