-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.DragonEggEvent.CutscenePart2
-- Decompile time: 14.01 ms

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BulkFade = require(ReplicatedStorage.Client.Modules.BulkFade)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function restoreCamera() -- Line: 26 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

return function(a1) -- Line: 38
    -- upvalues: CutsceneHelperFunctions (val), ReplicatedStorage (val), LocalPlayer (val), Workspace (val)
    -- upvalues: TweenService (val), Lighting (val), ContentProvider (val), restoreCamera (val), RunService (val)
    -- upvalues: CurrentCamera (val), BulkFade (val), Debris (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local PlaySequenceAsync = v1.PlaySequenceAsync
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local DragonEggEventCutscene2 = ReplicatedStorage.CutsceneAssets.DragonEggEvent.DragonEggEventCutscene2
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local u19 = nil
    local u20 = {}
    u20[0] = {
        SetProperty("Workspace.CurrentCamera.FieldOfView", 25),
        SetProperty(
            "Workspace.World.Build.1.BOTTOMS.Footprint.Meshes/untitled2 (1).CFrame",
            CFrame.new(3438.9807, 35.8888, -354.9071, -0.3907, 0, 0.9205, 0, 1, 0, -0.9205, 0, -0.3907)
        ),
        SetProperty(
            "Workspace.World.Build.1.BOTTOMS.Footprint.FogMesh.CFrame",
            CFrame.new(3438.9807, 35.6132, -354.9067, 0.5446, 0, -0.8387, 0, 1, 0, 0.8387, 0, 0.5446)
        ),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Linear), 1),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
        SetProperty("Lighting.CutsceneBlur.Enabled", true),
        (SetProperty("Lighting.CutsceneBlur.Size", 2)),
    }
    u20[326] = {
        function() -- Line: 76 -- upvalues: u19 (ref)
            for i, j in u19.Charge.Orb:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    j.Enabled = true
                end
            end
        end,
    }
    u20[457] = {
        function() -- Line: 88 -- upvalues: u19 (ref)
            for i, j in u19.Charge.Ball:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    j.Enabled = true
                end
            end
        end,
    }
    u20[484] = {
        function() -- Line: 100 -- upvalues: u19 (ref)
            for i, j in u19.Charge.Orb:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    j.Enabled = false
                end
            end
        end,
    }
    u20[622] = {
        function() -- Line: 112 -- upvalues: u19 (ref)
            for i, j in u19.Charge.Ball:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    j.Enabled = false
                end
            end
        end,
    }
    u20[821] = {
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 20)),
    }
    u20[822] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.9833333333333334, Enum.EasingStyle.Linear), 30),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.2, Enum.EasingStyle.Linear), 4)),
    }
    u20[917] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0.5)),
    }
    u20[930] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 15)),
    }
    u20[933] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 1)),
    }
    u20[939] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4, Enum.EasingStyle.Linear), 2)),
    }
    u20[941] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear), 25)),
    }
    u20[943] = {
        TweenProperty(
            "Workspace.World.Build.1.BOTTOMS.Footprint.Meshes/untitled2 (1).CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(3438.9807, 69.4803, -354.9071, -0.3907, 0, 0.9205, 0, 1, 0, -0.9205, 0, -0.3907)
        ),
        TweenProperty(
            "Workspace.World.Build.1.BOTTOMS.Footprint.FogMesh.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(3438.9807, 69.2047, -354.9067, 0.5446, 0, -0.8387, 0, 1, 0, 0.8387, 0, 0.5446)
        ),
        (SetProperty("Workspace.World.Build.1.BOTTOMS.Floor.Transparency", 1)),
    }
    u20[946] = {
        function() -- Line: 204 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1

            local function check(a1) -- Line: 207 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for i, j in u19.Stomp:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    Attribute = j:GetAttribute("EmitCount")
                    Attribute_2 = j:GetAttribute("EmitDuration")
                    v1 = false
                    if Attribute ~= nil then
                        v1 = Attribute ~= 0
                    end
                    if v1 then
                        j:Emit(Attribute)
                    end
                    v1 = false
                    if Attribute_2 ~= nil then
                        v1 = Attribute_2 ~= 0
                    end
                    if v1 then
                        j.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 222 -- upvalues: j (val)
                            j.Enabled = false
                        end)
                    end
                end
            end
        end,
        function() -- Line: 227 -- upvalues: u19 (ref)
            for i, j in u19.Decay:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    j.Enabled = true
                end
            end
        end,
    }
    u20[957] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.3833333333333333, Enum.EasingStyle.Linear), 1)),
    }
    u20[1200] = {}
    u20[1380] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.6833333333333333, Enum.EasingStyle.Linear), 50)),
    }
    u20[1410] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.5, Enum.EasingStyle.Linear), 1)),
    }
    return {
        Run = function() -- Line: 283
            -- upvalues: Workspace (upval), TweenService (upval), Lighting (upval), a1 (val), CutsceneUI (val)
            -- upvalues: Black (val), u19 (ref), DragonEggEventCutscene2 (val), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CutsceneMusic (val)
            -- upvalues: CurrentCamera (upval), LocalPlayer (upval), u20 (val), BulkFade (upval)
            -- upvalues: ReplicatedStorage (upval), Debris (upval), SetProperty (val)
            local Animation, Animation_2, v1
            Workspace.World.Build:WaitForChild("AAEventProps")
            task.wait()
            pcall(function() -- Line: 288 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 289 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0}):Play()
                end)
            end)
            local u12 = {}
            for i, j in script.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(j.Name) then
                    v1 = j:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u12, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            local u37 = script.CutsceneVFX:Clone()
            u37.Parent = Workspace
            u19 = u37
            a1:Add(u37)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 320 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            local u64 = DragonEggEventCutscene2:Clone()
            for k, n in u64:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            u64.Parent = workspace
            a1:Add(u64)
            local v2 = {}
            for m, i5 in u64:GetChildren() do
                Animation_2 = i5:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    table.insert(v2, Animation_2)
                end
            end
            ContentProvider:PreloadAsync(v2)
            local u103 = {}
            for i6, i7 in u64:GetChildren() do
                Animation = i7:FindFirstChildOfClass("Animation")
                if Animation then
                    u103[i7] = (LoadAnimationIntoRig(i7, Animation.AnimationId))
                end
            end
            local u117 = true
            a1:Add(function() -- Line: 355 -- upvalues: u117 (ref)
                u117 = false
            end)
            a1:Add(function() -- Line: 356 -- upvalues: u117 (ref), restoreCamera (upval)
                if not u117 then
                    return
                end
                restoreCamera()
            end)
            for i8, i9 in u103 do
                i9:Play(0)
            end
            local v3 = u103[u64["Camera Rig"]]
            assert(v3, "Camera Rig needs an Animation")
            v1 = os.clock() + 2
            while u117 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            local Vignette = CutsceneUI.Vignette
            a1:Add(function() -- Line: 377 -- upvalues: Vignette (val)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            CutsceneMusic:Play()
            local Cam = u64["Camera Rig"].Cam
            local u178 = nil
            RunService.RenderStepped:Connect(function() -- Line: 389 -- upvalues: u117 (ref), u178 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u117 then
                    u178:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u187 = {}
            local u188 = 0
            local u189 = 0.1
            local v4 = RunService.Heartbeat:Connect(function(a1) -- Line: 403
                -- upvalues: u188 (ref), u189 (ref), u103 (val), CutsceneMusic (upval), u20 (upval), u187 (val)
                local v1
                u188 = u188 + a1
                u189 = u189 - 0.1
                if u189 <= 0 then
                    u189 = 0.1
                    for i, j in u103 do
                        if j.IsPlaying and 0.1 <= (math.abs(u188 - j.TimePosition)) then
                            xpcall(function() -- Line: 415 -- upvalues: j (val), u188 (upval)
                                j.TimePosition = u188
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u188 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u188 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u188 * 60 - k)
                    if u20[v1] and not u187[v1] then
                        u187[v1] = true
                        for n, m in u20[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v4)
            task.wait(24.666666666666668)
            v4:Disconnect()
            xpcall(function() -- Line: 445 -- upvalues: u37 (val)
                u37:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 451 -- upvalues: u12 (val)
                for i, j in u12 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 457 -- upvalues: u64 (val)
                u64:Destroy()
            end, warn)
            pcall(function() -- Line: 459 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 460 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0.5}):Play()
                end)
            end)
            v4 = BulkFade.new(CutsceneUI.MonstersAreComing, TweenInfo.new(1))
            v4:FadeOutInstant()
            task.wait()
            v4:FadeIn()
            CutsceneUI.MonstersAreComing.Visible = true
            task.spawn(function() -- Line: 477 -- upvalues: CutsceneUI (upval)
                local function toDHMS(a1) -- Line: 478 -- types: a1: number
                    return string.format("%02i:%02i:%02i:%02i", a1 / 86400, a1 / 3600 % 24, a1 / 60 % 60, a1 % 60)
                end

                local v1 = 604799
                script.Roar:Play()
                while CutsceneUI.MonstersAreComing.Visible do
                    CutsceneUI.MonstersAreComing.TimeRemaining.Text = string.format("%02i:%02i:%02i:%02i", v1 / 86400, v1 / 3600 % 24, v1 / 60 % 60, v1 % 60)
                    script.ClockTick:Play()
                    task.wait(1)
                    v1 = v1 - 1
                end
            end)
            task.wait(5)
            local u263 = ReplicatedStorage.CutsceneAssets.DragonEggEvent.DragonEggEventRareEgg:Clone()
            for i10, i11 in u263:GetDescendants() do
                if i11:IsA("BasePart") then
                    i11.Anchored = true
                end
            end
            a1:Add(u263)
            Debris:AddItem(u263, 20)
            u263.Parent = Workspace
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.CFrame = CFrame.lookAt(Vector3.new(3307, 100, -341), u263:GetPivot().Position)
            CurrentCamera.FieldOfView = 40
            TweenService:Create(Black, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
            v4:FadeOut()
            pcall(function() -- Line: 518 -- upvalues: Workspace (upval)
                Workspace.World.Build["1"].BOTTOMS.Floor.Transparency = 0
                Workspace.World.Build["1"].BOTTOMS.Footprint["Meshes/untitled2 (1)"].Position = Vector3.new(0, 0, 0)
                Workspace.World.Build["1"].BOTTOMS.Footprint.FogMesh.Position = Vector3.new(0, 0, 0)
            end)
            pcall(function() -- Line: 527 -- upvalues: SetProperty (upval)
                SetProperty("Workspace.World.Build.1.BOTTOMS.Footprint.Meshes/untitled2 (1).Position", (Vector3.new(0, 0, 0)))()
                SetProperty("Workspace.World.Build.1.BOTTOMS.Footprint.FogMesh.Position", (Vector3.new(0, 0, 0)))()
            end)
            TweenService:Create(CurrentCamera, TweenInfo.new(4.5), {FieldOfView = 35}):Play()
            task.wait(1)
            Black.Visible = false
            CutsceneUI.MonstersAreComing.Visible = false
            task.wait(5)
            local Character = LocalPlayer.Character
            if Character then
                Character:FindFirstChild("HumanoidRootPart")
            end
            TweenService:Create(CurrentCamera, TweenInfo.new(5), {
                FieldOfView = 70,
                CFrame = CFrame.lookAt(Vector3.new(485, 100.5, -365), (Vector3.new(515, 80.5, -365))),
            }):Play()
            task.wait(5)
            xpcall(restoreCamera, warn)
            xpcall(function() -- Line: 560 -- upvalues: Workspace (upval)
                Workspace.World.Build["1"].BOTTOMS.Floor.Transparency = 0
            end, warn)
            pcall(function() -- Line: 561 -- upvalues: u263 (val)
                u263:Destroy()
            end)
        end,
    }
end