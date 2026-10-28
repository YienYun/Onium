-- Script path: ReplicatedStorage.CmdrClient.Types.BeforeRun
-- Decompile time: 2.31 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local u15 = {[1927880506] = true, [2790707588] = true}
if RunService:IsServer() then
    local AdminPanelService = require(ServerScriptService.Controllers.AdminPanelService)
    return function(a1) -- Line: 13 -- upvalues: u15 (val), AdminPanelService (val)
        a1:RegisterHook("BeforeRun", function(a1) -- Line: 14 -- upvalues: u15 (upval), AdminPanelService (upval)
            local Executor = a1.Executor
            local Group = a1.Group
            if u15[Executor.UserId] then
                return "You do not have permission to run this function."
            end
            if AdminPanelService.IsAdmin(Executor) then
                return
            end
            return "You do not have permission to run this function."
        end)
    end
end
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Shared.Globals.Constants)
local u37 = false
Remotes.StaffConsole.StaffVerdict.OnClientEvent:Connect(function(a1) -- Line: 36 -- upvalues: u37 (ref) -- types: a1: boolean
    u37 = a1
end)
Remotes.StaffConsole.ProbeStaffStatus:FireServer()
return function(a1) -- Line: 40 -- upvalues: u15 (val), u37 (ref)
    a1:RegisterHook("BeforeRun", function(a1) -- Line: 41 -- upvalues: u15 (upval), u37 (upval)
        local Executor = a1.Executor
        local Group = a1.Group
        if u15[Executor.UserId] then
            return "You do not have permission to run this function."
        end
        if u37 then
            return
        end
        return "You do not have permission to run this function."
    end)
end