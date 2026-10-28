-- Script path: ReplicatedStorage.CmdrClient.Commands.globalRemoveScheduledEvent
-- Decompile time: 0.69 ms

game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
return {
    Name = "globalRemoveScheduledEvent",
    Description = "Schedules an event in all servers",
    Group = "Moderator",
    Args = {
        function(a1) -- Line: 10 -- upvalues: RunService (val), ServerScriptService (val)
            local v1 = if not RunService:IsServer() then require(game:GetService("ReplicatedStorage").Shared.Remotes).LiveEvents.FetchScheduled:InvokeServer() else require(ServerScriptService.Controllers.AdminAbuseService).GetScheduledEvents()
            local v2 = {}
            for i in v1 do
                table.insert(v2, i)
            end
            return {
                Name = "ScheduledEventKey",
                Type = a1.Cmdr.Util.MakeEnumType("scheduleEventKey", v2),
            }
        end,
    },
}