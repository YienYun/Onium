-- Script path: ReplicatedStorage.CmdrClient.Commands.manorKey
-- Decompile time: 0.13 ms

return {
    Name = "manorKey",
    Description = "Manor Key test tools. grant: give the key and mark it claimed. unlock: unlock the chained manor door without using the key. reset: clear manor progress and remove the key.",
    Group = "Admin",
    Args = {{Type = "manorKeyAction", Name = "Action"}},
}