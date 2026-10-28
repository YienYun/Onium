-- Script path: ReplicatedStorage.Controllers.Game.FuseBiomePortalController
-- Decompile time: 5.76 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
return {
    Start = function() -- Line: 24
        -- upvalues: GUI (val), Players (val), RunService (val), Workspace (val), Remotes (val), TweenService (val)
        local u2 = GUI.FadeFrame()
        local LocalPlayer = Players.LocalPlayer
        local u5 = 0
        local u6 = nil
        local u7 = nil

        local function characterRoot() -- Line: 32 -- upvalues: LocalPlayer (val)
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                return HumanoidRootPart
            end
            return nil
        end

        local function waitForArrival(a1) -- Line: 38
            -- upvalues: LocalPlayer (val), RunService (upval)
            local Character, HumanoidRootPart, v1, v2
            local v3 = os.clock() + 2
            while os.clock() < v3 do
                Character = LocalPlayer.Character
                HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
                v2 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
                if v2 ~= nil and 200 <= (v2.Position - v1).Magnitude then
                    return
                end
                RunService.Heartbeat:Wait()
            end
        end

        local function faceCameraForward() -- Line: 49 -- upvalues: LocalPlayer (val), Workspace (upval)
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            local v1 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            local CurrentCamera = Workspace.CurrentCamera
            if v1 ~= nil and CurrentCamera ~= nil then
                CurrentCamera.CFrame = CFrame.lookAt(v1.Position - v1.CFrame.LookVector * 12 + Vector3.new(0, 5, 0), v1.Position)
                return
            end
        end

        Remotes.FuseBiome.PortalTransition.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 62
            -- upvalues: u6 (ref), u7 (ref), u5 (ref), LocalPlayer (val), u2 (val), TweenService (upval)
            -- upvalues: Remotes (upval), RunService (upval), waitForArrival (val), Workspace (upval)
            local Character_2, Character_3, CurrentCamera, HumanoidRootPart_2, v1, v2, v3
            if a3 then
                if u6 and u6.Id == a2 then
                    u6.Complete = true
                end
                return
            end
            if u7 then
                u7:Cancel()
            end
            u5 = u5 + 1
            local v4 = u5
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
                u2.BackgroundTransparency = 1
                u6 = nil
                return
            end
            local v5 = if not a2 then nil else {Complete = false, Id = a2}
            u6 = v5
            local Position = v1.Position
            local v6 = TweenService:Create(u2, TweenInfo.new(a1, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
            u7 = v6
            v6:Play()
            v6.Completed:Wait()
            if v4 ~= u5 then
                return
            end
            if not v5 then
                waitForArrival(Position)
                task.wait(0.1)
                if v4 ~= u5 then
                    return
                end
                Character_3 = LocalPlayer.Character
                v1 = if Character_3 == nil then nil else Character_3:FindFirstChild("HumanoidRootPart")
                v2 = if v1 == nil then nil else if not v1:IsA("BasePart") then nil else v1
                CurrentCamera = Workspace.CurrentCamera
                if v2 ~= nil and CurrentCamera ~= nil then
                    CurrentCamera.CFrame = CFrame.lookAt(v2.Position - v2.CFrame.LookVector * 12 + Vector3.new(0, 5, 0), v2.Position)
                end
                u6 = nil
                u7 = TweenService:Create(u2, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {BackgroundTransparency = 1})
                u7:Play()
                return
            end
            if not v5.Complete then
                Remotes.FuseBiome.PortalTransition:FireServer(v5.Id)
            end
            v6 = os.clock() + 5
            while not v5.Complete do
                if not (os.clock() < v6) or v4 ~= u5 then
                    break
                end
                RunService.Heartbeat:Wait()
            end
            if v4 ~= u5 then
                return
            end
            v6 = os.clock() + 2
            while v5.Complete do
                if not (os.clock() < v6) or v4 ~= u5 then
                    break
                end
                Character_2 = LocalPlayer.Character
                HumanoidRootPart_2 = if Character_2 == nil then nil else Character_2:FindFirstChild("HumanoidRootPart")
                if not (if HumanoidRootPart_2 == nil then nil else if not HumanoidRootPart_2:IsA("BasePart") then nil else HumanoidRootPart_2)
                    or v3 ~= v1
                    or 1 <= (v3.Position - Position).Magnitude then
                    break
                end
                RunService.Heartbeat:Wait()
            end
            task.wait(0.1)
            if v4 ~= u5 then
                return
            end
            Character_3 = LocalPlayer.Character
            v1 = if Character_3 == nil then nil else Character_3:FindFirstChild("HumanoidRootPart")
            v2 = if v1 == nil then nil else if not v1:IsA("BasePart") then nil else v1
            CurrentCamera = Workspace.CurrentCamera
            if v2 ~= nil and CurrentCamera ~= nil then
                CurrentCamera.CFrame = CFrame.lookAt(v2.Position - v2.CFrame.LookVector * 12 + Vector3.new(0, 5, 0), v2.Position)
            end
            u6 = nil
            u7 = TweenService:Create(u2, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {BackgroundTransparency = 1})
            u7:Play()
        end)
    end,
}