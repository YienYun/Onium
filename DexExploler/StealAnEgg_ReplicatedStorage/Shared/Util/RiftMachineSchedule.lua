-- Script path: ReplicatedStorage.Shared.Util.RiftMachineSchedule
-- Decompile time: 2.18 ms

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local u25 = {
    TestDelayAttribute = "RiftMachineTestDelaySeconds",
    TestSwapAtAttribute = "RiftMachineTestSwapAtUnix",
    ActiveSwapAtAttribute = "RiftMachineActiveSwapAt",
    EmergencyLabAttribute = "RiftMachineEmergencyLab",
}

function u25.GetSwapAt() -- Line: 15 -- upvalues: RunService (val), Workspace (val), u25 (val), RiftFlags (val)
    if RunService:IsStudio() then
        local Attribute = Workspace:GetAttribute(u25.TestDelayAttribute)
        local Attribute_2 = Workspace:GetAttribute(u25.ActiveSwapAtAttribute)
        local Attribute_3 = Workspace:GetAttribute(u25.TestSwapAtAttribute)
        if type(Attribute) == "number" and Attribute > 0 then
            if type(Attribute_2) == "number" then
                return Attribute_2
            end
            return RiftFlags.SwapAtUnix:Get()
        end
        if type(Attribute_3) == "number" and type(Attribute_2) == "number" then
            return Attribute_2
        end
    end
    return RiftFlags.SwapAtUnix:Get()
end

function u25.IsLaboratoryTime() -- Line: 27 -- upvalues: Workspace (val), u25 (val), RunService (val), Environment (val)
    local ServerTimeNow
    if Workspace:GetAttribute(u25.EmergencyLabAttribute) == true then
        return true
    end
    if not RunService:IsStudio() then
        if Environment.GetEnvironmentName() ~= "test" and Environment.GetEnvironmentName() ~= "dev" then
            ServerTimeNow = Workspace:GetServerTimeNow()
            return u25.GetSwapAt() <= ServerTimeNow
        end
        return true
    end
    local Attribute = Workspace:GetAttribute(u25.TestDelayAttribute)
    local Attribute_2 = Workspace:GetAttribute(u25.TestSwapAtAttribute)
    if type(Attribute) == "number" and not (Attribute <= 0) then
        ServerTimeNow = Workspace:GetServerTimeNow()
        return u25.GetSwapAt() <= ServerTimeNow
    end
    if type(Attribute_2) ~= "number" then
        return true
    end
    ServerTimeNow = Workspace:GetServerTimeNow()
    return u25.GetSwapAt() <= ServerTimeNow
end

return table.freeze(u25)