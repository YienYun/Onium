-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.DemonicEvent
-- Decompile time: 7.77 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LocalPlayer = Players.LocalPlayer
local u30 = false
local u31 = nil

local function resolveMarker() -- Line: 39 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("AdminAbuseEggSpawn")
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local function restoreCamera() -- Line: 50 -- upvalues: Workspace (val), LocalPlayer (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.FieldOfView = 70
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Humanoid ~= nil then
        CurrentCamera.CameraSubject = Humanoid
    end
end

local function stopCutscene() -- Line: 66 -- upvalues: u30 (ref), Workspace (val), LocalPlayer (val), u31 (ref)
    if not u30 then
        return
    end
    u30 = false
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid ~= nil then
            CurrentCamera.CameraSubject = Humanoid
        end
    end
    local v1 = u31
    u31 = nil
    if v1 ~= nil then
        v1()
    end
end

local function resolveEggShot(a1) -- Line: 80 -- types: a1: userdata
    local Attribute = a1:GetAttribute("Facing")
    local Attribute_2 = a1:GetAttribute("Finish")
    if typeof(Attribute) == "Vector3" and typeof(Attribute_2) == "Vector3" then
        local v1 = Vector3.new(Attribute.X, 0, Attribute.Z)
        if v1.Magnitude <= 0 then
            return nil
        end
        local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
        local v2 = Attribute_2 + (BoundingBox.Position - a1:GetPivot().Position)
        return CFrame.lookAt(
            v2 + (v1.Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)) * (BoundingBox_2.Y / 0.8 * 0.5 / 0.22169466264293988),
            v2
        )
    end
    return nil
end

local function startCutscene() -- Line: 103
    -- upvalues: u30 (ref), Workspace (val), u31 (ref), HiddenUIHandler (val), TweenService (val), RunService (val)
    -- upvalues: resolveEggShot (val)
    if u30 then
        return
    end
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("AdminAbuseEggSpawn")
    local v2 = if v1 == nil then nil else if not v1:IsA("BasePart") then nil else v1
    local CurrentCamera = Workspace.CurrentCamera
    if v2 ~= nil and CurrentCamera ~= nil then
        HiddenUIHandler.Acquire()
        u30 = true
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        TweenService:Create(CurrentCamera, TweenInfo.new(2), {FieldOfView = 80}):Play()
        local v3 = v2.Position + Vector3.new(0, 165, 0)
        local u55 = CFrame.lookAt(v2.Position + Vector3.new(-200, 25, 0), v3)
        CurrentCamera.CFrame = u55
        task.spawn(function() -- Line: 126
            -- upvalues: u30 (upval), RunService (upval), CurrentCamera (val), Workspace (upval), u55 (val)
            -- upvalues: resolveEggShot (upval)
            local AdminAbuseEggDrop, Attribute, Attribute_2, Position, v1, v2, v3, v4, v5
            while u30 do
                v1 = RunService.RenderStepped:Wait()
                if not u30 then
                    break
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                AdminAbuseEggDrop = Workspace:FindFirstChild("AdminAbuseEggDrop")
                if AdminAbuseEggDrop == nil then
                    CurrentCamera.CFrame = u55
                elseif AdminAbuseEggDrop:IsA("Model") then
                    v3 = resolveEggShot(AdminAbuseEggDrop)
                    if v3 == nil then
                        CurrentCamera.CFrame = u55
                    elseif not AdminAbuseEggDrop:GetAttribute("Done") then
                        Position = AdminAbuseEggDrop:GetPivot().Position
                        Attribute = AdminAbuseEggDrop:GetAttribute("Start")
                        Attribute_2 = AdminAbuseEggDrop:GetAttribute("Finish")
                        v2 = Attribute.Y - Attribute_2.Y
                        v5 = if not (v2 > 0) then 1 else 1 - (Position.Y - Attribute_2.Y) / v2
                        CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.lookAt(v3.Position, Position), (math.clamp(v1 * 2, 0, 1)))
                        CurrentCamera.FieldOfView = math.lerp(80, 25, (math.clamp(v5, 0, 1)))
                    else
                        v4 = math.clamp(v1 * 2.5, 0, 1)
                        CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v3, v4)
                        v5 = CurrentCamera
                        v5.FieldOfView = v5.FieldOfView + (25 - CurrentCamera.FieldOfView) * v4
                    end
                else
                    CurrentCamera.CFrame = u55
                end
            end
        end)
        return
    end
end

local v1 = {
    StartEvent = function(a1, a2, a3) end,
    StopEvent = function(a1) -- Line: 184 -- upvalues: u30 (ref), Workspace (val), LocalPlayer (val), u31 (ref)
        if not u30 then
            return
        end
        u30 = false
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = 70
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Humanoid ~= nil then
                CurrentCamera.CameraSubject = Humanoid
            end
        end
        local v1 = u31
        u31 = nil
        if v1 ~= nil then
            v1()
        end
    end,
}
;(Workspace:GetAttributeChangedSignal("AdminAbusePhase")):Connect(function() -- Line: 170 -- upvalues: Workspace (val), startCutscene (val), u30 (ref), LocalPlayer (val), u31 (ref)
    if Workspace:GetAttribute("AdminAbusePhase") == "Cutscene" then
        startCutscene()
        return
    end
    if not u30 then
        return
    end
    u30 = false
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid ~= nil then
            CurrentCamera.CameraSubject = Humanoid
        end
    end
    local v1 = u31
    u31 = nil
    if v1 ~= nil then
        v1()
    end
end)
LocalPlayer.CharacterAdded:Connect(function() -- Line: 187 -- upvalues: u30 (ref), Workspace (val), LocalPlayer (val)
    if not u30 then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera == nil then
            return
        end
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid ~= nil then
            CurrentCamera.CameraSubject = Humanoid
        end
    end
end)
if Workspace:GetAttribute("AdminAbusePhase") == "Cutscene" then
    startCutscene()
elseif u30 then
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid ~= nil then
            CurrentCamera.CameraSubject = Humanoid
        end
    end
    local v2 = u31
    if v2 ~= nil then
        v2()
    end
end
return v1