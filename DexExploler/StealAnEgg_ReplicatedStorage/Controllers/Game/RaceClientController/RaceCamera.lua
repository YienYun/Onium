-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.RaceCamera
-- Decompile time: 8.27 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
require(script.Parent.MountController)
require(ReplicatedStorage.Packages.Trove)

local function cameraModule() -- Line: 33 -- upvalues: Players (val)
    local PlayerScripts = Players.LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = if not PlayerScripts then nil else PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        return require(PlayerModule):GetCameras()
    end
    return nil
end

local function flatYaw(a1) -- Line: 43 -- types: a1: vector
    local v1 = Vector3.new(a1.X, 0, a1.Z)
    if v1.Magnitude < 0.3 then
        return nil
    end
    return (math.atan2(-v1.X, -v1.Z))
end

local function wrapAngle(a1) -- Line: 52 -- types: a1: number
    return (a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
end

local u45 = {}
u45.__index = u45

function u45.Run(a1, a2, a3) -- Line: 69
    -- upvalues: Workspace (val), CameraShaker (val), u45 (val), CameraShakerDriver (val), cameraModule (val)
    -- upvalues: RunService (val), MountRaceFlags (val)
    local CurrentCamera = Workspace.CurrentCamera
    local CameraType = CurrentCamera.CameraType
    local FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.CameraType = Enum.CameraType.Custom
    a1:Add(function() -- Line: 77 -- upvalues: CurrentCamera (val), CameraType (val), FieldOfView (val)
        CurrentCamera.CameraType = CameraType
        CurrentCamera.FieldOfView = FieldOfView
    end)
    local v1 = {Punch = 0, Shaker = CameraShaker.new()}
    local u18 = setmetatable(v1, u45)
    CameraShakerDriver.Start(u18.Shaker, Enum.RenderPriority.Last.Value)
    a1:Add(function() -- Line: 84 -- upvalues: CameraShakerDriver (upval), u18 (val)
        CameraShakerDriver.Stop(u18.Shaker)
    end)

    local function faceHeading() -- Line: 88 -- upvalues: a2 (val), cameraModule (upval), a3 (val), CurrentCamera (val)
        local v1
        local Heading = a2.Heading
        local v2 = Vector3.new(Heading.X, 0, Heading.Z)
        if (if not (v2.Magnitude < 0.3) then math.atan2(-v2.X, -v2.Z) else nil) == nil then
            return
        end
        local v3 = cameraModule()
        local Position = (if not v3 then nil else v3:GetCameraSubjectPosition(Enum.CameraType.Custom)) or a3.Root.Position
        v2 = (CFrame.Angles(0, v1, 0)) * CFrame.Angles(-0.24434609527920614, 0, 0)
        v1 = CFrame.lookAlong(Position - v2.LookVector * 14, v2.LookVector)
        CurrentCamera.CFrame = v1
        if v3 then
            v3:CommitCameraCFrame(v1, Enum.CameraType.Custom)
        end
    end

    faceHeading()
    local u32 = nil
    local u33 = (-1 / 0)
    local Position = a3.Root.Position
    RunService:BindToRenderStep("MountRaceCamera", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 116
        -- upvalues: a3 (val), Position (ref), faceHeading (val), u32 (ref), CurrentCamera (val), u33 (ref), a2 (val)
        -- upvalues: u18 (val), MountRaceFlags (upval)
        local v1, v2
        local Position_2 = a3.Root.Position
        local v3 = 80 < (Position_2 - Position).Magnitude
        Position = Position_2
        if not v3 then
            local LookVector_2 = CurrentCamera.CFrame.LookVector
            v2 = Vector3.new(LookVector_2.X, 0, LookVector_2.Z)
            v1 = if not (v2.Magnitude < 0.3) then math.atan2(-v2.X, -v2.Z) else nil
            if v1 ~= nil
                and u32 ~= nil
                and 0.0008726646259971648 < (math.abs((v1 - u32 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793)) then
                u33 = os.clock()
            end
            local Heading = a2.Heading
            local v4 = Vector3.new(Heading.X, 0, Heading.Z)
            local v5 = if not (v4.Magnitude < 0.3) then math.atan2(-v4.X, -v4.Z) else nil
            if v1 ~= nil and v5 ~= nil then
                v2 = os.clock() - u33
                if v2 > 1.25 then
                    v2 = ((v5 - v1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * (1 - math.exp(a1 * -4))
                    if 1e-05 < (math.abs(v2)) then
                        local Position_3 = CurrentCamera.Focus.Position
                        CurrentCamera.CFrame = (CFrame.new(Position_3)) * CFrame.Angles(0, v2, 0) * CFrame.new(-Position_3) * CurrentCamera.CFrame
                        v1 = v1 + v2
                    end
                end
            end
            u32 = v1
        else
            faceHeading()
            local LookVector = CurrentCamera.CFrame.LookVector
            local v6 = Vector3.new(LookVector.X, 0, LookVector.Z)
            u32 = if not (v6.Magnitude < 0.3) then math.atan2(-v6.X, -v6.Z) else nil
            u33 = (-1 / 0)
        end
        u18.Punch = math.max(0, u18.Punch - u18.Punch * 2.5 * a1)
        v1 = MountRaceFlags.FovBase:Get()
        v3 = v1 + ((MountRaceFlags.FovMax:Get()) - v1) * math.min(a2:SpeedRatio(), 1) + u18.Punch
        v2 = CurrentCamera
        v2.FieldOfView = v2.FieldOfView + (v3 - CurrentCamera.FieldOfView) * math.min(1, a1 * 5)
    end)
    a1:Add(function() -- Line: 162 -- upvalues: RunService (upval)
        RunService:UnbindFromRenderStep("MountRaceCamera")
    end)
    return u18
end

function u45.PunchFov(a1, a2) -- Line: 169 -- types: a2: number
    a1.Punch = math.max(a1.Punch, a2)
end

function u45.Shake(a1, a2) -- Line: 173 -- types: a2: number
    a1.Shaker:ShakeOnce(a2, 12, 0, 0.45)
end

return u45