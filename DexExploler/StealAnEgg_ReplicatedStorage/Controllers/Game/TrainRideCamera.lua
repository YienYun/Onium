-- Script path: ReplicatedStorage.Controllers.Game.TrainRideCamera
-- Decompile time: 9.92 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local u21 = require(script.Parent.BeeEffectController)
local TrainVisuals = require(script.Parent.TrainVisuals)
local u27 = {}
local u28 = nil
local u29 = false
local u30 = false

local function humanoid() -- Line: 14 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChildOfClass("Humanoid")
end

local function restoreCamera(a1, a2, a3) -- Line: 18 -- upvalues: LocalPlayer (val)
    if a1 and a1.Parent then
        local Character = LocalPlayer.Character
        local Subject = Character and Character:FindFirstChildOfClass("Humanoid")
        if not a3 and a2.Subject and a2.Subject.Parent then
            Subject = a2.Subject
        end
        a1.CameraType = if not a3 then a2.Type else Enum.CameraType.Custom
        a1.FieldOfView = a2.Fov
        if Subject then
            a1.CameraSubject = Subject
        end
        return
    end
end

function u27.Stop(a1, a2) -- Line: 26
    -- upvalues: u28 (ref), TrainVisuals (val), u30 (ref), RunService (val), LocalPlayer (val), Workspace (val)
    -- upvalues: u21 (val)
    local v1 = u28
    if not v1 then
        return
    end
    if a1 and a1 ~= v1.Id then
        return
    end
    u28 = nil
    TrainVisuals.EndRide(v1.Id)
    if a2 then
        u30 = true
    end
    RunService:UnbindFromRenderStep("TrainEventRideCamera")
    if v1.Death then
        v1.Death:Disconnect()
    end
    local Camera = v1.Camera
    local Saved = v1.Saved
    local v2 = a2 == true
    if Camera and Camera.Parent then
        local Character = LocalPlayer.Character
        local Subject = Character and Character:FindFirstChildOfClass("Humanoid")
        if not v2 and Saved.Subject and Saved.Subject.Parent then
            Subject = Saved.Subject
        end
        Camera.CameraType = if not v2 then Saved.Type else Enum.CameraType.Custom
        Camera.FieldOfView = Saved.Fov
        if Subject then
            Camera.CameraSubject = Subject
        end
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= v1.Camera then
        local v3 = {Type = Enum.CameraType.Custom, Fov = v1.Saved.Fov}
        if CurrentCamera and CurrentCamera.Parent then
            local Character_2 = LocalPlayer.Character
            v2 = Character_2 and Character_2:FindFirstChildOfClass("Humanoid")
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = v3.Fov
            if v2 then
                CurrentCamera.CameraSubject = v2
            end
        end
    end
    u21.SetTrainCameraActive(false)
end

function u27.Begin(a1) -- Line: 39
    -- upvalues: LocalPlayer (val), Workspace (val), u27 (val), u21 (val), TrainVisuals (val), u28 (ref)
    -- upvalues: RunService (val)
    if typeof(a1) == "table"
        and typeof(a1.Id) == "string"
        and typeof(a1.StartFocus) == "Vector3"
        and typeof(a1.EndFocus) == "Vector3"
        and typeof(a1.Character) == "Instance"
        and a1.Character == LocalPlayer.Character then
        local Character_2 = LocalPlayer.Character
        local u26 = Character_2
        if u26 then
            u26 = Character_2:FindFirstChildOfClass("Humanoid")
        end
        local CurrentCamera = Workspace.CurrentCamera
        if u26 and not (u26.Health <= 0) and CurrentCamera then
            local ViewRotation_2
            u27.Stop()
            u21.SetTrainCameraActive(true)
            local u48 = if type(a1.Duration) ~= "number" then 15 else math.clamp(a1.Duration, 1, 60)
            local u52 = if a1.Mode ~= "Departure" then 1.5 else 0.5
            local StartFocus = a1.StartFocus
            local CameraEndOffset_2 = if a1.Mode ~= "Departure" then Vector3.new(74, 12, -65) else Vector3.new(70, 12, -90)
            local CameraStartOffset_2 = if a1.Mode ~= "Departure" then Vector3.new(70, 11, 125) else Vector3.new(74, 12, -65)
            if typeof(a1.CameraStartOffset) == "Vector3" then
                CameraStartOffset_2 = a1.CameraStartOffset
            end
            if typeof(a1.CameraEndOffset) == "Vector3" then
                CameraEndOffset_2 = a1.CameraEndOffset
            end
            local v1 = (if typeof(a1.ViewRotation) ~= "CFrame" then CFrame.identity else a1.ViewRotation):VectorToWorldSpace(CameraEndOffset_2)
            local u97 = ViewRotation_2:VectorToWorldSpace(CameraStartOffset_2)
            local u100 = a1.EndFocus + v1
            v1 = CFrame.lookAt(StartFocus + u97, StartFocus)
            local u111 = {Id = a1.Id, Character = a1.Character, Camera = CurrentCamera}
            u111.Saved = {
                Type = CurrentCamera.CameraType,
                Subject = CurrentCamera.CameraSubject,
                Fov = CurrentCamera.FieldOfView,
            }
            u111.Started = os.clock()
            u111.Duration = u48
            u111.Focus = StartFocus
            u111.Shot = v1
            u111.Fixed = v1
            if a1.Private then
                u111.Visual = TrainVisuals.BeginRide(a1)
            end
            u28 = u111
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.FieldOfView = 60
            CurrentCamera.CFrame = v1
            CurrentCamera.Focus = CFrame.new(StartFocus)
            u111.Death = u26.Died:Connect(function() -- Line: 67 -- upvalues: u27 (upval), u111 (val)
                u27.Stop(u111.Id, true)
            end)
            RunService:BindToRenderStep("TrainEventRideCamera", Enum.RenderPriority.Camera.Value + 1, function(a1_2) -- Line: 68
                -- upvalues: u28 (upval), u111 (val), LocalPlayer (upval), u26 (val), Workspace (upval)
                -- upvalues: CurrentCamera (val), u48 (val), u27 (upval), a1 (val), StartFocus (val), u97 (ref)
                -- upvalues: u100 (val), u52 (val)
                if u28 ~= u111 then
                    return
                end
                if LocalPlayer.Character == u111.Character
                    and not (u26.Health <= 0)
                    and Workspace.CurrentCamera == CurrentCamera then
                    local v1 = os.clock() - u111.Started
                    if not (u48 + 10 < v1) then
                        if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                            u27.Stop(u111.Id)
                            return
                        end
                        v1 = os.clock() - u111.Started
                        local Visual = u111.Visual or a1.Train
                        if typeof(Visual) ~= "Instance" or not Visual:IsA("Model") or not Visual.Parent then
                            local TrainEventRuntime = Workspace:FindFirstChild("TrainEventRuntime")
                            Visual = TrainEventRuntime and TrainEventRuntime:FindFirstChild(a1.TrainName or "GhostTrainArrival")
                        end
                        local v2 = a1.StartFocus:Lerp(a1.EndFocus, (math.clamp(v1 / u48, 0, 1)))
                        local TrainEventVisuals = Workspace:FindFirstChild("TrainEventVisuals")
                        local v3 = TrainEventVisuals and TrainEventVisuals:FindFirstChild(a1.TrainName or "GhostTrainArrival")
                        if not a1.Private and v3 and v3:IsA("Model") then
                            Visual = v3
                        end
                        if Visual and Visual:IsA("Model") and Visual.PrimaryPart then
                            v2 = Visual.PrimaryPart.Position + Vector3.new(0, 6, 0)
                        end
                        u111.Focus = u111.Focus:Lerp(v2, 1 - math.exp(-(math.min(a1_2, 0.1)) * 5))
                        v3 = math.clamp(v1 / u48, 0, 1)
                        v3 = CFrame.lookAt((StartFocus + u97):Lerp(u100, v3), u111.Focus)
                        local v4 = math.clamp((v1 - u52) / 1.2, 0, 1)
                        v4 = v4 * v4 * (3 - v4 * 2)
                        CurrentCamera.CFrame = u111.Fixed:Lerp(v3, v4)
                        CurrentCamera.Focus = CFrame.new(if v4 ~= 0 then u111.Focus else StartFocus)
                        return
                    end
                end
                u27.Stop(u111.Id, true)
            end)
            return
        end
        return
    end
end

function u27.Start() -- Line: 95
    -- upvalues: u29 (ref), LocalPlayer (val), u27 (val), u30 (ref), Workspace (val), u28 (ref)
    if u29 then
        return
    end
    u29 = true
    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 97 -- upvalues: u27 (upval)
        u27.Stop(nil, true)
    end)
    LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 98 -- upvalues: u27 (upval), u30 (upval), Workspace (upval), LocalPlayer (upval), u28 (upval)
        u27.Stop(nil, true)
        if u30 then
            u30 = false
            task.spawn(function() -- Line: 102 -- upvalues: a1 (val), Workspace (upval), LocalPlayer (upval), u28 (upval)
                local Humanoid = a1:WaitForChild("Humanoid", 5)
                local CurrentCamera = Workspace.CurrentCamera
                if Humanoid and LocalPlayer.Character == a1 and not u28 and CurrentCamera then
                    CurrentCamera.CameraType = Enum.CameraType.Custom
                    CurrentCamera.CameraSubject = Humanoid
                end
            end)
        end
    end)
    ;(LocalPlayer:GetAttributeChangedSignal("TrainEventPhase")):Connect(function() -- Line: 111 -- upvalues: LocalPlayer (upval), u27 (upval)
        if LocalPlayer:GetAttribute("TrainEventPhase") == nil then
            u27.Stop()
        end
    end)
    ;(Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 114 -- upvalues: u28 (upval), Workspace (upval), u27 (upval)
        if u28 and Workspace.CurrentCamera ~= u28.Camera then
            u27.Stop(nil, true)
        end
    end)
    script.Destroying:Connect(function() -- Line: 117 -- upvalues: u27 (upval)
        u27.Stop(nil, true)
    end)
end

return u27