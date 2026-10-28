-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RiftEvent.Cutscene1
-- Decompile time: 13.98 ms

local ContentProvider = game:GetService("ContentProvider")
game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
require(ReplicatedStorage.Client.Modules.BulkFade)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Shared.Remotes)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u75 = nil
local u76 = nil
local u77 = nil
local u78 = nil
local u79 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}

local function restoreCamera() -- Line: 44 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 54
    -- upvalues: u76 (ref), u77 (ref), Tabs (val), LocalPlayer (val), u79 (val), StarterGui (val), u78 (ref)
    if u76 ~= nil then
        return
    end
    local v1 = {}
    Tabs.Active()
    for i, j in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if j:IsA("ScreenGui") and j.Name ~= "DragonCinematic" and j.Enabled then
            v1[j] = true
            j.Enabled = false
        end
    end
    u76 = v1
    pcall(function() -- Line: 69 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u79 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u78 = v1
end

local function restoreAllUi() -- Line: 79
    -- upvalues: u76 (ref), u77 (ref), LocalPlayer (val), u78 (ref), StarterGui (val)
    local v1 = u76
    local v2 = u77
    u76 = nil
    u77 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 92 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u78
    u78 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 104 -- upvalues: u75 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u75 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 111 -- upvalues: restoreAllUi (val), u75 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u75
    u75 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 123 -- types: a1: table, a2: number?
    local Attribute, Transparency
    local v1 = nil
    local v2 = nil
    for i, j in a1, v1, v2 do
        if j:IsA("BasePart") then
            if not j:GetAttribute("OriginalTransparency") then
                Transparency = j.Transparency
                j:SetAttribute("OriginalTransparency", Transparency)
            end
            Attribute = a2 or j:GetAttribute("OriginalTransparency")
            j.Transparency = Attribute
        end
    end
end

return function(a1) -- Line: 136
    -- upvalues: CutsceneHelperFunctions (val), ReplicatedStorage (val), LocalPlayer (val), TweenService (val)
    -- upvalues: hideCutsceneUi (val), restoreAllUi (val), u75 (ref), Tabs (val), Workspace (val), setTransparency (val)
    -- upvalues: Lighting (val), ContentProvider (val), restoreCamera (val), RunService (val), CurrentCamera (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local PlaySequenceAsync = v1.PlaySequenceAsync
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local RiftCutscene = ReplicatedStorage.CutsceneAssets.RiftCutsceneAssets.RiftCutscene
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u20 = nil
    local u21 = {}
    u21[0] = {
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(4778.5664, 77.7973, -307.0335, -0.3841, 0.438, -0.8128, 0, 0.8803, 0.4744, 0.9233, 0.1822, -0.3381)
        ),
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(9.45, Enum.EasingStyle.Linear),
            CFrame.new(4802.2295, 73.7093, -297.8694, -0.8171, 0, 0.5766, -0.0083, 0.9999, -0.0119, -0.5765, -0.0145, -0.817)
        ),
        (SetProperty("Workspace.CurrentCamera.FieldOfView", 45)),
    }
    u21[407] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 35)),
    }
    u21[566] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 45)),
    }
    u21[567] = {
        (TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(2.216666666666667, Enum.EasingStyle.Linear),
            CFrame.new(4796.2349, 71.199, -303.4302, 0.8192, 0.06, 0.5704, -0.05, 0.9982, -0.0331, -0.5714, -0.0014, 0.8207)
        )),
    }
    u21[700] = {
        (TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(4, Enum.EasingStyle.Linear),
            CFrame.new(4797.2402, 71.2416, -292.843, -0.9137, -0.2377, -0.3295, -0.1682, 0.9595, -0.2258, 0.3699, -0.1509, -0.9167)
        )),
    }
    u21[940] = {
        (TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(4795.6162, 72.4162, -297.8404, -0.9994, 0, -0.0349, -0, 1, -0, 0.0349, 0, -0.9994)
        )),
    }
    u21[941] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.8666666666666667, Enum.EasingStyle.Sine), 90)),
    }
    u21[1066] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine), 75.51428)),
    }
    u21[1076] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Sine), 56.2)),
    }
    u21[1080] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Sine), 25)),
    }
    u21[1168] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 45)),
    }
    u21[1400] = {
        function() -- Line: 200 -- upvalues: TweenService (upval), Black (val)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        end,
    }
    return {
        Run = function() -- Line: 207
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u75 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), setTransparency (upval), TweenService (upval)
            -- upvalues: Lighting (upval), CutsceneUI (val), Black (val), Vignette (val), u20 (ref), RiftCutscene (val)
            -- upvalues: ContentProvider (upval), LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval)
            -- upvalues: CutsceneMusic (val), CurrentCamera (upval), LocalPlayer (upval), u21 (val)
            local Animation, Animation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 212 -- upvalues: u0 (ref), restoreAllUi (upval), u75 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u75
                    u75 = nil
                    if v2 ~= nil then
                        v2()
                    end
                    if v1 ~= nil then
                        Tabs.Activate(v1, {instant = true})
                    end
                    u0 = true
                end
            end)
            local AreaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
            pcall(function() -- Line: 220 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 222 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            local v2 = {}
            for i, j in (game.Workspace.World.Areas.GuardAreas:GetChildren()) do
                local Guard = j.Guard
                v2[Guard] = j
                Guard.Parent = nil
                a1:Add(function() -- Line: 233 -- upvalues: Guard (val), j (val)
                    Guard.Parent = j
                end)
            end
            local u47 = game.Workspace.World.Areas.GuardAreas["Titan Temple"].Nests:GetDescendants()
            setTransparency(u47, 1)
            a1:Add(function() -- Line: 240 -- upvalues: setTransparency (upval), u47 (val)
                setTransparency(u47)
            end)
            pcall(function() -- Line: 244 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 245 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0}):Play()
                end)
            end)
            local u60 = {}
            for k, n in script.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(n.Name) then
                    v1 = n:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u60, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            a1:Add(function() -- Line: 271 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u92 = script.CutsceneVFX:Clone()
            u92.Parent = Workspace
            u20 = u92
            a1:Add(u92)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 282 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            local u119 = RiftCutscene:Clone()
            for m, i5 in u119:GetChildren() do
                if i5:IsA("Model") and i5.PrimaryPart then
                    i5.PrimaryPart.Anchored = true
                end
            end
            u119.Parent = workspace
            a1:Add(u119)
            local v3 = {}
            for i6, i7 in u119:GetChildren() do
                Animation_2 = i7:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    table.insert(v3, Animation_2)
                end
            end
            ContentProvider:PreloadAsync(v3)
            local u158 = {}
            for i8, i9 in u119:GetChildren() do
                Animation = i9:FindFirstChildOfClass("Animation")
                if Animation then
                    u158[i9] = (LoadAnimationIntoRig(i9, Animation.AnimationId))
                end
            end
            local u172 = true
            a1:Add(function() -- Line: 317 -- upvalues: u172 (ref)
                u172 = false
            end)
            a1:Add(function() -- Line: 318 -- upvalues: u172 (ref), restoreCamera (upval)
                if not u172 then
                    return
                end
                restoreCamera()
            end)
            for i10, i11 in u158 do
                i11:Play(0)
            end
            local v4 = u158[u119["Camera Rig"]]
            assert(v4, "Camera Rig needs an Animation")
            v1 = os.clock() + 2
            while u172 do
                if not (v4.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            CutsceneMusic:Play()
            local Cam = u119["Camera Rig"].Cam
            local u226 = nil
            RunService.RenderStepped:Connect(function() -- Line: 345 -- upvalues: u172 (ref), u226 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u172 then
                    u226:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u235 = {}
            local u236 = 0
            local u237 = 0.1
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 359
                -- upvalues: u236 (ref), u237 (ref), u158 (val), CutsceneMusic (upval), u21 (upval), u235 (val)
                local v1
                u236 = u236 + a1
                u237 = u237 - 0.1
                if u237 <= 0 then
                    u237 = 0.1
                    for i, j in u158 do
                        if j.IsPlaying and 0.1 <= (math.abs(u236 - j.TimePosition)) then
                            xpcall(function() -- Line: 371 -- upvalues: j (val), u236 (upval)
                                j.TimePosition = u236
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u236 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u236 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u236 * 60 - k)
                    if u21[v1] and not u235[v1] then
                        u235[v1] = true
                        for n, m in u21[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(24.5)
            v5:Disconnect()
            xpcall(function() -- Line: 403 -- upvalues: u92 (val)
                u92:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 409 -- upvalues: u60 (val)
                for i, j in u60 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 415 -- upvalues: u119 (val)
                u119:Destroy()
            end, warn)
            pcall(function() -- Line: 417 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 418 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0.5}):Play()
                end)
            end)
            xpcall(restoreCamera, warn)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 436 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 440 -- upvalues: restoreAllUi (upval), u75 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u75
                u75 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                u0 = true
            end, warn)
            setTransparency(u47)
            for i12, i13 in v2 do
                i12.Parent = i13
            end
        end,
    }
end