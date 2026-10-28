-- Script path: ReplicatedStorage.UserGenerated.Roblox.JobId
-- Decompile time: 0.65 ms

local Attribute
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local JobId = game.JobId
if #JobId ~= 0 and JobId ~= "00000000-0000-0000-0000-000000000000" then
    return JobId
end
assert((RunService:IsStudio()))
if RunService:IsServer() then
    local v1 = HttpService:GenerateGUID(false):lower()
    script:SetAttribute("Studio", v1)
    return v1
end
while true do
    Attribute = script:GetAttribute("Studio")
    if type(Attribute) == "string" then
        break
    end
    task.wait()
end
return Attribute