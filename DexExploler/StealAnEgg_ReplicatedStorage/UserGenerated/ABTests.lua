-- Script path: ReplicatedStorage.UserGenerated.ABTests
-- Decompile time: 0.53 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.UserGenerated.ABTests.SharedABTests)
if RunService:IsServer() then
    return (require(ServerScriptService.UserGenerated.Server.ServerABTests))
end
return (require(ReplicatedStorage.UserGenerated.Client.ClientABTests))