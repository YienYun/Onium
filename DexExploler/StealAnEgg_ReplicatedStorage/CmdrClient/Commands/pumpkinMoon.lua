-- Script path: ReplicatedStorage.CmdrClient.Commands.pumpkinMoon
-- Decompile time: 0.20 ms

return {
    Name = "pumpkinMoon",
    Description = "Starts or stops the Pumpkin Moon (Return Pumpkins) event in the Halloween dimension on this server.",
    Group = "Admin",
    Args = {{Type = "string", Name = "Action", Description = "start or stop", Default = "start"}},
}