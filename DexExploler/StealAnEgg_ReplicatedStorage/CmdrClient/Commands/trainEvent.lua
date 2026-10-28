-- Script path: ReplicatedStorage.CmdrClient.Commands.trainEvent
-- Decompile time: 0.20 ms

return {
    Name = "trainEvent",
    Description = "Studio/DEV/Testing Train Event journey review: start, station, depart, return, expire, stop, status, hunt, rewardson, rewardsoff.",
    Group = "Admin",
    Args = {
        {
            Type = "string",
            Name = "Action",
            Description = "start / station / depart / return / expire / stop / status / hunt / rewardson / rewardsoff",
            Default = "start",
        },
        {
            Type = "positiveInteger",
            Name = "Seconds",
            Description = "Boarding window for start (1..600); defaults to the TrainEvent FastFlag.",
            Optional = true,
        },
    },
}