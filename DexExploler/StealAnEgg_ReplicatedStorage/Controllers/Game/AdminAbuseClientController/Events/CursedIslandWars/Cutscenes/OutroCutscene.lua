-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.Cutscenes.OutroCutscene
-- Decompile time: 16.50 ms

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.Parent.CutsceneHelperFunctions)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local OutroCutscene = ReplicatedStorage.CutsceneAssets.CursedIslandWarsCutsceneAssets.OutroCutscene
local u77 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u85 = nil
local u86 = nil
local u87 = nil
local u88 = nil

local function onMap(a1) -- Line: 61 -- types: a1: userdata
    return a1 + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
end

local function restoreCamera() -- Line: 65 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 74
    -- upvalues: u86 (ref), u87 (ref), Tabs (val), LocalPlayer (val), u77 (val), StarterGui (val), u88 (ref)
    if u86 ~= nil then
        return
    end
    local v1 = {}
    Tabs.Active()
    for i, j in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if j:IsA("ScreenGui") and j.Name ~= "CutsceneUI" and j.Enabled then
            v1[j] = true
            j.Enabled = false
        end
    end
    u86 = v1
    pcall(function() -- Line: 89 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u77 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u88 = v1
end

local function restoreAllUi() -- Line: 99
    -- upvalues: u86 (ref), u87 (ref), LocalPlayer (val), u88 (ref), StarterGui (val)
    local v1 = u86
    local v2 = u87
    u86 = nil
    u87 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 112 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u88
    u88 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 124 -- upvalues: u85 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u85 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 131
    -- upvalues: restoreCamera (val), restoreAllUi (val), u85 (ref), Tabs (val)
    restoreCamera()
    local v1 = restoreAllUi()
    local v2 = u85
    u85 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setEmitting(a1, a2) -- Line: 144 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emitBurst(a1) -- Line: 153 -- types: a1: userdata
    local Attribute_3
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")
            task.delay(if type(Attribute_3) ~= "number" then 0 else Attribute_3, function() -- Line: 162 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute ~= 0 then
                    j:Emit(Attribute)
                end
                if type(Attribute_2) == "number" and Attribute_2 ~= 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 168 -- upvalues: j (upval)
                        j.Enabled = false
                    end)
                end
            end)
        end
    end
end

return function(a1) -- Line: 178
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), setEmitting (val), emitBurst (val)
    -- upvalues: hideCutsceneUi (val), restoreCutsceneUi (val), MusicDirector (val), LightingController (val)
    -- upvalues: OutroCutscene (val), Lighting (val), TweenService (val), Workspace (val), SoundService (val)
    -- upvalues: ContentProvider (val), restoreCamera (val), RunService (val), CurrentCamera (val)
    local u3 = a1:Extend()
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(u3)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u16 = nil

    local function breakage(a1) -- Line: 191 -- types: a1: number
        return (CFrame.new(18.447, a1, -578.4)) + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
    end

    local function linear(a1, a2) -- Line: 194 -- types: a1: number, a2: number
        return TweenInfo.new((a2 - a1) / 60, Enum.EasingStyle.Linear)
    end

    local function sine(a1, a2) -- Line: 197 -- types: a1: number, a2: number
        return TweenInfo.new((a2 - a1) / 60, Enum.EasingStyle.Sine)
    end

    local u20 = {}
    local v2 = {}
    local v3 = SetProperty("Workspace.CurrentCamera.FieldOfView", 45)
    local v4 = SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)
    local v5 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    local v6 = SetProperty(
        "Workspace.CursedOutroVFX.Breakage.CFrame",
        (CFrame.new(18.447, 233.985, -578.4)) + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
    )
    local v7 = TweenProperty(
        "Workspace.CursedOutroVFX.Breakage.CFrame",
        TweenInfo.new(1.5166666666666666, Enum.EasingStyle.Linear),
        (CFrame.new(18.447, 190.9959, -578.4)) + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
    )
    local v8 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v9 = SetProperty("Lighting.CutsceneBlur.Size", 15)
    local v10 = SetProperty("Lighting.DepthOfField.Enabled", true)
    local v11 = SetProperty("Lighting.DepthOfField.InFocusRadius", 50)
    local v12 = SetProperty("Lighting.DepthOfField.FocusDistance", 0.05)
    local v13 = SetProperty("Lighting.DepthOfField.FarIntensity", 0.75)
    local v14 = SetProperty("Lighting.Contrast.Enabled", false)
    local v15 = SetProperty("Lighting.Contrast.Saturation", 0.3)
    local v16 = TweenProperty("Lighting.Contrast.Saturation", TweenInfo.new(14.966666666666667, Enum.EasingStyle.Linear), 0)
    v2[1] = v3

    v2[2] = function() -- Line: 204 -- upvalues: setEmitting (upval), u16 (ref)
        setEmitting(u16.Breakage, true)
    end

    v2[3] = v4
    v2[4] = v5
    v2[5] = v6
    v2[6] = v7
    v2[7] = v8
    v2[8] = v9
    v2[9] = v10
    v2[10] = v11
    v2[11] = v12
    v2[12] = v13
    v2[13] = v14
    v2[14] = v15
    v2[15] = v16
    v2[16] = (SetProperty("Lighting.Contrast.Contrast", 0.2))
    v3 = TweenProperty("Lighting.Contrast.Contrast", TweenInfo.new(14.966666666666667, Enum.EasingStyle.Linear), 0)
    local v17 = SetProperty("Lighting.Contrast.TintColor", Color3.new(1, 0.890196, 0.792157))
    v4 = TweenProperty("Lighting.Contrast.TintColor", TweenInfo.new(14.966666666666667, Enum.EasingStyle.Linear), Color3.new(1, 1, 1))
    v5 = SetProperty("Lighting.Contrast.Brightness", 0.075)
    v6 = TweenProperty("Lighting.Contrast.Brightness", TweenInfo.new(14.966666666666667, Enum.EasingStyle.Linear), 0)
    v2[17] = v3
    v2[18] = v17
    v2[19] = v4
    v2[20] = v5
    v2[21] = v6
    v2[22] = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 1)
    u20[0] = v2
    u20[21] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 2)),
    }
    u20[37] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.0166666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u20[91] = {
        (TweenProperty(
            "Workspace.CursedOutroVFX.Breakage.CFrame",
            TweenInfo.new(1.5333333333333334, Enum.EasingStyle.Linear),
            (CFrame.new(18.447, 159.254, -578.4)) + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
        )),
    }
    u20[183] = {
        (TweenProperty(
            "Workspace.CursedOutroVFX.Breakage.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            (CFrame.new(18.447, 131.169, -578.4)) + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
        )),
    }
    u20[184] = {
        (TweenProperty(
            "Workspace.CursedOutroVFX.Breakage.CFrame",
            TweenInfo.new(1.4166666666666667, Enum.EasingStyle.Linear),
            (CFrame.new(18.447, 81.3715, -578.4)) + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
        )),
    }
    u20[269] = {
        (TweenProperty(
            "Workspace.CursedOutroVFX.Breakage.CFrame",
            TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear),
            (CFrame.new(18.447, 56.3333, -578.4)) + Vector3.new(-5849.154296875, -207.86573791503906, -6767.255859375)
        )),
    }
    u20[270] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 35)),
    }
    u20[293] = {
        function() -- Line: 258 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.RockFall)
        end,
    }
    u20[294] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 32),
        function() -- Line: 265 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Fall)
        end,
    }
    u20[295] = {
        function() -- Line: 271 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.RockFall2)
        end,
    }
    u20[296] = {
        function() -- Line: 277 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.Breakage, false)
        end,
    }
    u20[298] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 35)),
    }
    u20[317] = {
        function() -- Line: 287 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.RockFall3)
        end,
    }
    u20[318] = {
        function() -- Line: 293 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Fall2)
        end,
    }
    u20[504] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 28)),
    }
    u20[505] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.15, Enum.EasingStyle.Sine), 25)),
    }
    u20[603] = {
        (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(1.4333333333333333, Enum.EasingStyle.Linear), 0.25)),
    }
    u20[666] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.7166666666666667, Enum.EasingStyle.Linear), 200)),
    }
    u20[720] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6166666666666667, Enum.EasingStyle.Linear), 7)),
    }
    u20[811] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 15)),
    }
    u20[821] = {
        function() -- Line: 323 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Bats)
        end,
    }
    u20[850] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.3, Enum.EasingStyle.Linear), 2)),
    }
    u20[898] = {
        SetProperty("Lighting.Contrast.Enabled", true),
        TweenProperty("Lighting.Contrast.Saturation", TweenInfo.new(1.4, Enum.EasingStyle.Linear), 0.3),
        TweenProperty("Lighting.Contrast.Contrast", TweenInfo.new(1.4, Enum.EasingStyle.Linear), 0.2),
        TweenProperty("Lighting.Contrast.TintColor", TweenInfo.new(1.4, Enum.EasingStyle.Linear), Color3.new(1, 0.890196, 0.792157)),
        (TweenProperty("Lighting.Contrast.Brightness", TweenInfo.new(1.4, Enum.EasingStyle.Linear), 0.075)),
    }
    u20[923] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(1.0833333333333333, Enum.EasingStyle.Linear), 800)),
    }
    u20[1019] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 350
            -- upvalues: hideCutsceneUi (upval), u3 (val), restoreCutsceneUi (upval), MusicDirector (upval)
            -- upvalues: LightingController (upval), OutroCutscene (upval), Lighting (upval), CutsceneUI (val)
            -- upvalues: Black (val), Vignette (val), a1 (val), TweenService (upval), Workspace (upval), u16 (ref)
            -- upvalues: SoundService (upval), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CurrentCamera (upval), LocalPlayer (upval)
            -- upvalues: u20 (val)
            local Animation, v1
            xpcall(hideCutsceneUi, warn)
            u3:Add(restoreCutsceneUi)
            MusicDirector.SetEventMusic(true)
            u3:Add(function() -- Line: 355 -- upvalues: MusicDirector (upval)
                MusicDirector.SetEventMusic(false)
            end)
            LightingController.SetAuthoredLayer("CursedIslandWarsCutscene", OutroCutscene.SceneLighting, 999, 0)
            u3:Add(function() -- Line: 361 -- upvalues: LightingController (upval)
                LightingController.ClearLayer("CursedIslandWarsCutscene", 0)
            end)
            for i, j in OutroCutscene.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(j.Name) then
                    v1 = j:Clone()
                    v1.Parent = Lighting
                    u3:Add(v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            u3:Add(function() -- Line: 377 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            a1:Add(function() -- Line: 382 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
            task.wait(0.5)
            local v2 = OutroCutscene.CursedOutroVFX:Clone()
            v2.Parent = Workspace
            u16 = v2
            u3:Add(v2)
            local u93 = OutroCutscene.CutsceneMusic:Clone()
            u93.Parent = SoundService
            u3:Add(u93)
            local v3 = OutroCutscene.CursedOutroRigs:Clone()
            u3:Add(v3)
            for k, n in v3:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            v3.Parent = Workspace
            local v4 = {}
            for m, i5 in v3:GetChildren() do
                table.insert(v4, (i5:FindFirstChild("Animation")))
            end
            ContentProvider:PreloadAsync(v4)
            local u143 = {}
            for i6, i7 in v3:GetChildren() do
                Animation = i7:FindFirstChild("Animation")
                u143[i7] = (LoadAnimationIntoRig(i7, Animation.AnimationId))
            end
            local u157 = true
            u3:Add(function() -- Line: 427 -- upvalues: u157 (ref), restoreCamera (upval)
                u157 = false
                restoreCamera()
            end)
            for i8, i9 in u143 do
                i9:Play(0)
            end
            local v5 = u143[v3.CameraRig]
            v1 = os.clock() + 2
            while u157 do
                if not (v5.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u93:Play()
            local Cam = v3.CameraRig.Cam
            u3:Connect(RunService.RenderStepped, function() -- Line: 449 -- upvalues: u157 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u157 then
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u212 = {}
            local u213 = 0
            local u214 = 0.1
            v3 = u3:Connect(RunService.Heartbeat, function(a1) -- Line: 462
                -- upvalues: u213 (ref), u214 (ref), u143 (val), u93 (val), u20 (upval), u212 (val)
                local v1, v2
                u213 = u213 + a1
                u214 = u214 - a1
                for i, j in u143 do
                    v2 = j.Length - 0.05
                    if 0 < j.Length and v2 <= u213 and j.Speed ~= 0 then
                        j.TimePosition = v2
                        j:AdjustSpeed(0)
                    end
                end
                if u214 <= 0 then
                    u214 = 0.1
                    for k, n in u143 do
                        if n.IsPlaying and n.Speed ~= 0 and 0.4 <= (math.abs(u213 - n.TimePosition)) then
                            xpcall(function() -- Line: 481 -- upvalues: n (val), u213 (upval)
                                n.TimePosition = u213
                            end, warn)
                        end
                    end
                end
                if not (u93.TimePosition < u213 - 0.001) then
                    local TimePosition_2 = u93.TimePosition
                    if not (u213 + 0.001 < TimePosition_2) then
                        u93.PlaybackSpeed = 1
                    else
                        u93.PlaybackSpeed = 0.99
                    end
                else
                    u93.PlaybackSpeed = 1.01
                end
                for m = 0, 9 do
                    v1 = math.floor(u213 * 60 - m)
                    if u20[v1] and not u212[v1] then
                        u212[v1] = true
                        for i5, i6 in u20[v1] do
                            task.spawn(i6)
                        end
                    end
                end
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(17.75)
            v3:Disconnect()
            Black.BackgroundTransparency = 0
            u3:Clean()
            task.delay(1.5, function() -- Line: 513 -- upvalues: TweenService (upval), Black (upval)
                TweenService:Create(Black, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
                task.wait(0.8)
                Black.Visible = false
            end)
        end,
    }
end