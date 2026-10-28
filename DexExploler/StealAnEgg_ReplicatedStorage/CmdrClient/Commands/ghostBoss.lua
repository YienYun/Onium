-- Script path: ReplicatedStorage.CmdrClient.Commands.ghostBoss
-- Decompile time: 0.25 ms

return {
    Name = "ghostBoss",
    Description = "Spawns, stops or reports Ghouler on this server. start spawns him in the Forgotten Town of the train run that is there now, start here spawns him in front of you (your realm decides who can fight him), finish deals the damage down to the capture for you.",
    Group = "Admin",
    Args = {
        {
            Type = "string",
            Name = "Action",
            Description = "start, stop, finish or status",
            Default = "start",
        },
        {
            Type = "string",
            Name = "Where",
            Description = "spot (his spawn in the Forgotten Town) or here (in front of you)",
            Default = "spot",
        },
    },
}