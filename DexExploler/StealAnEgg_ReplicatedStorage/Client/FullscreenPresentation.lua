-- Script path: ReplicatedStorage.Client.FullscreenPresentation
-- Decompile time: 10.44 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local GameAudioMute = require(ReplicatedStorage.Client.GameAudioMute)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u48 = nil

local function watchingCFrame(a1, a2) -- Line: 17
    local ViewportSize = a1.ViewportSize
    local v1 = (math.max(ViewportSize.X, 1)) / math.max(ViewportSize.Y, 1)
    local v2 = math.tan((math.rad(a1.FieldOfView)) / 2)
    return CFrame.lookAt(a2.Position + a2.CFrame.LookVector * (math.max(a2.Size.Y / 2 / v2, a2.Size.X / 2 / v2 / v1) * 1.05), a2.Position)
end

function v1.Open(a1, a2, a3) -- Line: 25
    -- upvalues: LocalPlayer (val), Workspace (val), u48 (ref), HiddenUIHandler (val), Tabs (val), Signal (val)
    -- upvalues: watchingCFrame (val), GameAudioMute (val), TweenService (val), UserInputService (val), RunService (val)
    local Character = LocalPlayer.Character
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    local CurrentCamera = Workspace.CurrentCamera
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not u48
        and Humanoid
        and not (Humanoid.Health <= 0)
        and CurrentCamera
        and PlayerGui
        and a1:IsDescendantOf(Workspace)
        and a2:IsDescendantOf(a1)
        and CurrentCamera.CameraType ~= Enum.CameraType.Scriptable
        and not HiddenUIHandler.IsHidden()
        and not Tabs.IsActive() then
        local u39 = {}
        u39.Closed = Signal.new()
        local u43 = {}
        local u44 = nil
        local u45 = nil
        local u46 = nil
        local u47 = nil
        local CameraType = CurrentCamera.CameraType
        local CameraSubject = CurrentCamera.CameraSubject
        local CFrame = CurrentCamera.CFrame
        local Focus = CurrentCamera.Focus
        local u52 = false
        local u53 = true
        local u57 = watchingCFrame(CurrentCamera, a2)
        u48 = u39

        function u39.Close() -- Line: 60
            -- upvalues: u52 (ref), u48 (upval), u39 (val), u43 (val), u44 (ref), u45 (ref), u53 (ref)
            -- upvalues: CurrentCamera (val), Workspace (upval), CameraSubject (val), CFrame (val), Focus (val)
            -- upvalues: CameraType (val), u46 (ref), u47 (ref)
            if u52 then
                return
            end
            u52 = true
            if u48 == u39 then
                u48 = nil
            end
            for i, j in u43 do
                j:Disconnect()
            end
            if u44 then
                u44:Cancel()
                u44:Destroy()
            end
            if u45 then
                u45:Destroy()
            end
            if u53
                and CurrentCamera.Parent
                and Workspace.CurrentCamera == CurrentCamera
                and CurrentCamera.CameraType == Enum.CameraType.Scriptable
                and CurrentCamera.CameraSubject == CameraSubject then
                CurrentCamera.CFrame = CFrame
                CurrentCamera.Focus = Focus
                CurrentCamera.CameraType = CameraType
            end
            if u46 then
                u46()
            end
            if u47 then
                u47()
            end
            u39.Closed:Fire()
            u39.Closed:Destroy()
        end

        function u39.IsClosed() -- Line: 99 -- upvalues: u52 (ref)
            return u52
        end

        local success, result = xpcall(function() -- Line: 103
            -- upvalues: u45 (ref), a3 (val), u43 (val), u39 (val), u46 (ref), GameAudioMute (upval), u47 (ref)
            -- upvalues: HiddenUIHandler (upval), PlayerGui (val), CurrentCamera (val), u44 (ref), TweenService (upval)
            -- upvalues: u57 (ref), watchingCFrame (upval), a2 (val), Humanoid (val), LocalPlayer (upval)
            -- upvalues: Workspace (upval), a1 (val), UserInputService (upval), Tabs (upval), RunService (upval)
            -- upvalues: u53 (ref), Character (val), CameraSubject (val)
            u45 = a3:Clone()
            u45.Name = "ForbiddenIslandWatching"
            u45.ResetOnSpawn = false
            u45.DisplayOrder = math.max(a3.DisplayOrder, 100)
            u45.Enabled = true
            local Exit = u45:FindFirstChild("Exit")
            assert(Exit and Exit:IsA("GuiButton"), "ForbiddenIsland exit button is missing")
            table.insert(u43, (Exit.Activated:Connect(u39.Close)))
            table.insert(u43, (u45.Destroying:Connect(u39.Close)))
            GameAudioMute.Acquire()
            HiddenUIHandler.Acquire()
            u45.Parent = PlayerGui
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            u44 = TweenService:Create(CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CFrame = u57})
            u44:Play()
            table.insert(u43, ((CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function() -- Line: 124 -- upvalues: u44 (upval), u57 (upval), watchingCFrame (upval), CurrentCamera (upval), a2 (upval)
                u44:Cancel()
                u57 = watchingCFrame(CurrentCamera, a2)
                CurrentCamera.CFrame = u57
            end)))
            table.insert(u43, ((CurrentCamera:GetPropertyChangedSignal("FieldOfView")):Connect(function() -- Line: 132 -- upvalues: u44 (upval), u57 (upval), watchingCFrame (upval), CurrentCamera (upval), a2 (upval)
                u44:Cancel()
                u57 = watchingCFrame(CurrentCamera, a2)
                CurrentCamera.CFrame = u57
            end)))
            table.insert(u43, (Humanoid.Died:Connect(u39.Close)))
            table.insert(u43, (LocalPlayer.CharacterRemoving:Connect(u39.Close)))
            table.insert(u43, ((Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(u39.Close)))
            table.insert(u43, (a1.AncestryChanged:Connect(function() -- Line: 143 -- upvalues: a1 (upval), Workspace (upval), u39 (upval)
                if not a1:IsDescendantOf(Workspace) then
                    u39.Close()
                end
            end)))
            table.insert(u43, (a1.Destroying:Connect(u39.Close)))
            table.insert(u43, (UserInputService.InputBegan:Connect(function(a1) -- Line: 152 -- upvalues: u39 (upval)
                if a1.KeyCode == Enum.KeyCode.Escape or a1.KeyCode == Enum.KeyCode.ButtonB then
                    u39.Close()
                end
            end)))
            table.insert(u43, (Tabs.Activated:Connect(u39.Close)))
            table.insert(u43, (RunService.Heartbeat:Connect(function() -- Line: 161
                -- upvalues: CurrentCamera (upval), u57 (upval), u44 (upval), u53 (upval), u39 (upval), a1 (upval)
                -- upvalues: Workspace (upval), a2 (upval), u45 (upval), PlayerGui (upval), LocalPlayer (upval)
                -- upvalues: Character (upval), Humanoid (upval), CameraSubject (upval)
                local v1 = true
                if not (0.05 < (CurrentCamera.CFrame.Position - u57.Position).Magnitude) then
                    v1 = true
                    if not ((CurrentCamera.CFrame.LookVector:Dot(u57.LookVector)) < 0.9999) then
                        v1 = (CurrentCamera.CFrame.UpVector:Dot(u57.UpVector)) < 0.9999
                    end
                end
                if u44.PlaybackState ~= Enum.PlaybackState.Playing and v1 then
                    u53 = false
                    u39.Close()
                    return
                end
                if not a1:IsDescendantOf(Workspace)
                    or not a2:IsDescendantOf(a1)
                    or u45.Parent ~= PlayerGui
                    or not u45.Enabled
                    or LocalPlayer.Character ~= Character
                    or Humanoid.Health <= 0
                    or Workspace.CurrentCamera ~= CurrentCamera
                    or CurrentCamera.CameraType ~= Enum.CameraType.Scriptable
                    or CurrentCamera.CameraSubject ~= CameraSubject then
                    u39.Close()
                end
            end)))
        end, debug.traceback)
        if success then
            return u39
        end
        u39.Close()
        warn("ForbiddenIsland fullscreen failed", result)
        return nil
    end
    return nil
end

return (table.freeze(v1))