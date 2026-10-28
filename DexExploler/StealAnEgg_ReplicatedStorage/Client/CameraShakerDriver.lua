-- Script path: ReplicatedStorage.Client.CameraShakerDriver
-- Decompile time: 2.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local u24 = {}
local u25 = nil
local u26 = nil
local u27 = nil

local function advance(a1, a2) -- Line: 38 -- upvalues: Asserts (val) -- types: a2: number
    local v1 = math.min(a2, 1)
    local v2 = math.max(math.ceil(v1 / 0.02), 1)
    local identity = CFrame.identity
    for i = 1, v2 do
        identity = a1:Update(v1 / v2)
    end
    if Asserts.IsCFrameFinite(identity) then
        return identity
    end
    return CFrame.identity
end

local function apply(a1) -- Line: 50 -- upvalues: Workspace (val), u25 (ref), u26 (ref) -- types: a1: userdata
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and a1 ~= CFrame.identity then
        local CFrame_2 = CurrentCamera.CFrame
        if CFrame_2 ~= u25 then
            u26 = CFrame_2
        end
        CurrentCamera.CFrame = CFrame_2 * a1
        u25 = CurrentCamera.CFrame
        return
    end
end

local function unwind() -- Line: 68 -- upvalues: Workspace (val), u25 (ref), u26 (ref)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = u25
    local v2 = u26
    u25 = nil
    u26 = nil
    if CurrentCamera ~= nil and v1 ~= nil and v2 ~= nil and CurrentCamera.CFrame == v1 then
        CurrentCamera.CFrame = v2
    end
end

return (table.freeze({
    Advance = advance,
    Start = function(a1, a2) -- Line: 88
        -- upvalues: u24 (val), u27 (ref), RunService (val), unwind (val), CameraShaker (val), advance (val)
        -- upvalues: Workspace (val), u25 (ref), u26 (ref)
        if u24[a1] ~= nil then
            return
        end
        if u27 == nil then
            RunService.PostSimulation:Connect(unwind)
        end
        local v1 = ("CameraShakerDriver%*"):format((CameraShaker.NextRenderName()))
        u24[a1] = v1
        RunService:BindToRenderStep(v1, a2, function(a1_2) -- Line: 98
            -- upvalues: advance (upval), a1 (val), Workspace (upval), u25 (upval), u26 (upval)
            local v1 = advance(a1, a1_2)
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera ~= nil then
                if v1 == CFrame.identity then
                    return
                end
                local CFrame_2 = CurrentCamera.CFrame
                if CFrame_2 ~= u25 then
                    u26 = CFrame_2
                end
                CurrentCamera.CFrame = CFrame_2 * v1
                u25 = CurrentCamera.CFrame
            end
        end)
    end,
    Stop = function(a1) -- Line: 103 -- upvalues: u24 (val), RunService (val)
        local v1 = u24[a1]
        if v1 == nil then
            return
        end
        u24[a1] = nil
        RunService:UnbindFromRenderStep(v1)
    end,
}))