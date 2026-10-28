-- Script path: ReplicatedStorage.CmdrClient.Commands.globalStopEvent
-- Decompile time: 0.13 ms

return {
    Name = "globalStopEvent",
    Description = "Stops events in all servers",
    Group = "Moderator",
    Args = {{Type = "adminEventType", Name = "Event Name"}},
}