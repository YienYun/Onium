-- Script path: ReplicatedStorage.UserGenerated.FastFlags
-- Decompile time: 0.39 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags)
if RunService:IsClient() then
    return (require(ReplicatedStorage.UserGenerated.Client.ClientFastFlags))
end
if RunService:IsServer() then
    return (require((game:GetService("ServerScriptService")).UserGenerated.Server.ServerFastFlags))
end
error("RunContext")
return nil