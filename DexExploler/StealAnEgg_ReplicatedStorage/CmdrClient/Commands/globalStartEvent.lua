-- Script path: ReplicatedStorage.CmdrClient.Commands.globalStartEvent
-- Decompile time: 0.15 ms

return {
    Name = "globalStartEvent",
    Description = "Start an event in all servers",
    Group = "Moderator",
    Args = {{Type = "adminStartEventType", Name = "Event Name"}, {Type = "number", Name = "Duration"}},
}