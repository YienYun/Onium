-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RaceEvent.Cutscenes.OutroCutscene
-- Decompile time: 25.42 ms

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BulkFade = require(ReplicatedStorage.Client.Modules.BulkFade)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.Parent.CutsceneHelperFunctions)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local OutroCutscene = ReplicatedStorage.CutsceneAssets.RaceEventCutsceneAssets.OutroCutscene
local u81 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local u91 = Color3.new(1, 0.574242, 0.247059)
local UnixTimestamp = (DateTime.fromUniversalTime(2026, 10, 17, 15)).UnixTimestamp
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u101 = nil
local u102 = nil
local u103 = nil
local u104 = nil

local function onTrack(a1) -- Line: 63 -- types: a1: userdata
    return a1 + Vector3.new(-4009, 0, 9397)
end

local function restoreCamera() -- Line: 67 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 76
    -- upvalues: u102 (ref), u103 (ref), Tabs (val), LocalPlayer (val), u81 (val), StarterGui (val), u104 (ref)
    if u102 ~= nil then
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
    u102 = v1
    pcall(function() -- Line: 91 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u81 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u104 = v1
end

local function restoreAllUi() -- Line: 101
    -- upvalues: u102 (ref), u103 (ref), LocalPlayer (val), u104 (ref), StarterGui (val)
    local v1 = u102
    local v2 = u103
    u102 = nil
    u103 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 114 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u104
    u104 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 126 -- upvalues: u101 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u101 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 133
    -- upvalues: restoreCamera (val), restoreAllUi (val), u101 (ref), Tabs (val)
    restoreCamera()
    local v1 = restoreAllUi()
    local v2 = u101
    u101 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setEmitting(a1, a2) -- Line: 146 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emitBurst(a1) -- Line: 155 -- types: a1: userdata
    local Attribute_3
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")
            task.delay(if type(Attribute_3) ~= "number" then 0 else Attribute_3, function() -- Line: 164 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute ~= 0 then
                    j:Emit(Attribute)
                end
                if type(Attribute_2) == "number" and Attribute_2 ~= 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 170 -- upvalues: j (upval)
                        j.Enabled = false
                    end)
                end
            end)
        end
    end
end

local function countdown(a1) -- Line: 178 -- types: a1: number
    local v1 = math.max(0, (math.floor(a1)))
    return string.format("%02i:%02i:%02i:%02i", v1 // 86400, v1 // 3600 % 24, v1 // 60 % 60, v1 % 60)
end

return function(a1) -- Line: 185
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), setEmitting (val), u91 (val), emitBurst (val)
    -- upvalues: MountRace (val), hideCutsceneUi (val), restoreCutsceneUi (val), MusicDirector (val)
    -- upvalues: OutroCutscene (val), Lighting (val), Workspace (val), SoundService (val), TweenService (val)
    -- upvalues: ContentProvider (val), restoreCamera (val), RunService (val), CurrentCamera (val), BulkFade (val)
    -- upvalues: UnixTimestamp (val)
    local u3 = a1:Extend()
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(u3)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u16 = nil
    local u30 = CFrame.new(0, 0, 0, 0.0022, -0.0008, 1, -0.0495, 0.9988, 0.0009, -0.9988, -0.0495, 0.0021)

    local function brakes(a1, a2, a3) -- Line: 198 -- upvalues: u30 (val) -- types: a1: number, a2: number, a3: number
        return (CFrame.new(a1, a2, a3)) * u30 + Vector3.new(-4009, 0, 9397)
    end

    local u45 = CFrame.new(0, 0, 0, 0.0755, -0.9569, 0.2803, -0.0885, -0.2864, -0.954, 0.9932, 0.0473, -0.1063)

    local function portal(a1, a2, a3) -- Line: 202 -- upvalues: u45 (val) -- types: a1: number, a2: number, a3: number
        return (CFrame.new(a1, a2, a3)) * u45 + Vector3.new(-4009, 0, 9397)
    end

    local u60 = CFrame.new(0, 0, 0, 0.9397, -0.342, 0, 0.342, 0.9397, 0, 0, 0, 1)

    local function crack(a1, a2, a3) -- Line: 206 -- upvalues: u60 (val) -- types: a1: number, a2: number, a3: number
        return (CFrame.new(a1, a2, a3)) * u60 + Vector3.new(-4009, 0, 9397)
    end

    local u75 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)

    local function cameraRig(a1, a2, a3) -- Line: 210
        -- upvalues: u75 (val)
        return (CFrame.new(a1, a2, a3)) * u75 + Vector3.new(-4009, 0, 9397)
    end

    local function backdrop(a1, a2) -- Line: 213 -- upvalues: TweenProperty (val) -- types: a1: userdata, a2: number
        local v1 = {}
        for i, j in {"1", "2", "3", "4"} do
            table.insert(v1, (TweenProperty(("Workspace.RaceOutroMap.%*.Transparency"):format(j), a1, a2)))
        end
        return v1
    end

    local u78 = {}
    local v2 = {}
    local v3 = SetProperty("Workspace.CurrentCamera.FieldOfView", 55)
    local v4 = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.2333333333333334, Enum.EasingStyle.Linear), 35)
    local v5 = SetProperty("Workspace.RaceOutroVFX.Brakes2.CFrame", CFrame.new(615.9109, 198.1829, 313.325) * u30 + Vector3.new(-4009, 0, 9397))
    local v6 = TweenProperty(
        "Workspace.RaceOutroVFX.Brakes2.CFrame",
        TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear),
        CFrame.new(616.0109, 195.8869, 267.0224) * u30 + Vector3.new(-4009, 0, 9397)
    )
    local v7 = SetProperty("Workspace.RaceOutroVFX.Brakes.CFrame", CFrame.new(601.9868, 198.2261, 314.4173) * u30 + Vector3.new(-4009, 0, 9397))
    local v8 = TweenProperty(
        "Workspace.RaceOutroVFX.Brakes.CFrame",
        TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear),
        CFrame.new(602.0861, 195.9467, 268.4474) * u30 + Vector3.new(-4009, 0, 9397)
    )
    local v9 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v10 = SetProperty("Lighting.CutsceneBlur.Size", 10)
    local v11 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 2)
    local v12 = SetProperty("Workspace.RaceOutroVFX.blackDome.Transparency", 1)
    local v13 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 1)
    local v14 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", Color3.new(0, 0, 0))
    local v15 = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", TweenInfo.new(21.033333333333335, Enum.EasingStyle.Linear), u91)
    local v16 = SetProperty("Lighting.Portal1.Enabled", false)
    v2[1] = v3
    v2[2] = v4

    v2[3] = function() -- Line: 225 -- upvalues: setEmitting (upval), u16 (ref)
        setEmitting(u16.Brakes, true)
        setEmitting(u16.Brakes2, true)
    end

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
    v2[16] = (SetProperty("Lighting.Portal1.Saturation", -0.3))
    v3 = TweenProperty("Lighting.Portal1.Saturation", TweenInfo.new(12.266666666666667, Enum.EasingStyle.Linear), 0)
    v4 = SetProperty("Lighting.Portal1.Contrast", 0.3)
    local v17 = TweenProperty("Lighting.Portal1.Contrast", TweenInfo.new(12.266666666666667, Enum.EasingStyle.Linear), 0)
    v5 = SetProperty("Lighting.Portal1.TintColor", Color3.new(1, 0.956863, 0.792157))
    v6 = TweenProperty("Lighting.Portal1.TintColor", TweenInfo.new(12.266666666666667, Enum.EasingStyle.Linear), Color3.new(1, 1, 1))
    v7 = SetProperty("Lighting.Portal1.Brightness", 0)
    v8 = SetProperty("Lighting.Portal2.Enabled", false)
    v9 = SetProperty("Lighting.Portal2.Saturation", 1)
    v10 = TweenProperty("Lighting.Portal2.Saturation", TweenInfo.new(20.4, Enum.EasingStyle.Linear), 0)
    v11 = SetProperty("Lighting.Portal2.Contrast", 1)
    v12 = TweenProperty("Lighting.Portal2.Contrast", TweenInfo.new(20.4, Enum.EasingStyle.Linear), 0)
    v13 = SetProperty("Lighting.Portal2.TintColor", Color3.new(1, 0.737255, 0.368627))
    v14 = TweenProperty("Lighting.Portal2.TintColor", TweenInfo.new(20.4, Enum.EasingStyle.Linear), Color3.new(1, 1, 1))
    v15 = SetProperty("Lighting.Portal2.Brightness", 0)
    v16 = SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)
    v2[17] = v3
    v2[18] = v4
    v2[19] = v17
    v2[20] = v5
    v2[21] = v6
    v2[22] = v7
    v2[23] = v8
    v2[24] = v9
    v2[25] = v10
    v2[26] = v11
    v2[27] = v12
    v2[28] = v13
    v2[29] = v14
    v2[30] = v15
    v2[31] = v16
    v2[32] = (SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1))
    v3 = SetProperty("Workspace.RaceOutroVFX.Portal.CFrame", CFrame.new(1110.4214, -87.4107, 54.751) * u45 + Vector3.new(-4009, 0, 9397))
    v4 = SetProperty("Lighting.CutsceneDepthOfField.Enabled", true)
    v17 = SetProperty("Lighting.CutsceneDepthOfField.FarIntensity", 0.55)
    v5 = SetProperty("Workspace.RaceOutroVFX.Crack.Cloud.CFrame", CFrame.new(960.9952, -106.5977, 93.9837) * u60 + Vector3.new(-4009, 0, 9397))
    v6 = SetProperty("Workspace.RaceOutroMap.2.Transparency", 0)
    v7 = SetProperty("Workspace.RaceOutroMap.1.Transparency", 0)
    v8 = SetProperty("Workspace.RaceOutroMap.3.Transparency", 0)
    v9 = SetProperty("Workspace.RaceOutroMap.4.Transparency", 0)
    v10 = SetProperty("Workspace.RaceOutroVFX.CastleCloudTwmp.CFrame", (CFrame.new(526.3013, 1293.6385, -382.0035)) + Vector3.new(-4009, 0, 9397))
    v11 = TweenProperty(
        "Workspace.RaceOutroVFX.CastleCloudTwmp.CFrame",
        TweenInfo.new(26.366666666666667, Enum.EasingStyle.Linear),
        (CFrame.new(517.3013, 1293.6385, -382.0035)) + Vector3.new(-4009, 0, 9397)
    )
    v12 = SetProperty("Workspace.RaceOutroVFX.CastleCloudTwmp.Size", (Vector3.new(58, 299, 688)))
    v15 = TweenInfo.new(26.366666666666667, Enum.EasingStyle.Linear)
    v2[33] = v3
    v2[34] = v4
    v2[35] = v17
    v2[36] = v5
    v2[37] = v6
    v2[38] = v7
    v2[39] = v8
    v2[40] = v9
    v2[41] = v10
    v2[42] = v11
    v2[43] = v12
    v2[44] = TweenProperty("Workspace.RaceOutroVFX.CastleCloudTwmp.Size", v15, (Vector3.new(249.22410583496094, 299, 688)))
    u78[0] = v2
    u78[47] = {
        TweenProperty(
            "Workspace.RaceOutroVFX.Brakes2.CFrame",
            TweenInfo.new(0.85, Enum.EasingStyle.Linear),
            CFrame.new(616.1057, 193.7084, 223.0885) * u30 + Vector3.new(-4009, 0, 9397)
        ),
        (TweenProperty(
            "Workspace.RaceOutroVFX.Brakes.CFrame",
            TweenInfo.new(0.85, Enum.EasingStyle.Linear),
            CFrame.new(602.1823, 193.7351, 223.848) * u30 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u78[98] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 45),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 10)),
    }
    u78[99] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u78[130] = {
        function() -- Line: 287 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.Brakes, false)
            setEmitting(u16.Brakes2, false)
        end,
    }
    u78[150] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 55)),
    }
    u78[216] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u78[269] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u78[270] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 45)),
    }
    u78[355] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 15)),
    }
    u78[358] = {
        function() -- Line: 314 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Fall)
        end,
    }
    u78[361] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u78[380] = (backdrop(TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 1))
    u78[407] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 12)),
    }
    u78[416] = {
        function() -- Line: 330 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Fall2)
        end,
    }
    u78[417] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6833333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u78[471] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Sine), 35)),
    }
    u78[487] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.85, Enum.EasingStyle.Sine), 45)),
    }
    u78[529] = {
        (TweenProperty(
            "Workspace.RaceOutroVFX.Crack.Cloud.CFrame",
            TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(807.8547, 314.1525, 93.9837) * u60 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u78[637] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.2, Enum.EasingStyle.Sine), 55)),
    }
    u78[666] = {
        (TweenProperty("Workspace.RaceOutroVFX.blackDome.Transparency", TweenInfo.new(1.0166666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u78[732] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 45)),
    }
    u78[736] = {
        SetProperty("Lighting.Portal1.Enabled", true),
        TweenProperty("Lighting.Portal1.Saturation", TweenInfo.new(2.683333333333333, Enum.EasingStyle.Linear), -0.3),
        TweenProperty("Lighting.Portal1.Contrast", TweenInfo.new(2.683333333333333, Enum.EasingStyle.Linear), 0.3),
        (TweenProperty(
            "Lighting.Portal1.TintColor",
            TweenInfo.new(2.683333333333333, Enum.EasingStyle.Linear),
            Color3.new(1, 0.956863, 0.792157)
        )),
    }
    u78[756] = {
        function() -- Line: 371 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Crack.Cloud.Crack)
        end,
    }
    u78[1157] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.1, Enum.EasingStyle.Linear), 0)),
    }
    u78[1209] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), 3.54762)),
    }
    u78[1214] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6166666666666667, Enum.EasingStyle.Linear), 15)),
    }
    u78[1224] = {
        SetProperty("Lighting.Portal2.Enabled", true),
        TweenProperty("Lighting.Portal2.Saturation", TweenInfo.new(1, Enum.EasingStyle.Linear), 1),
        TweenProperty("Lighting.Portal2.Contrast", TweenInfo.new(1, Enum.EasingStyle.Linear), 1),
        TweenProperty("Lighting.Portal2.TintColor", TweenInfo.new(1, Enum.EasingStyle.Linear), Color3.new(1, 0.737255, 0.368627)),
        (TweenProperty("Lighting.Portal2.Brightness", TweenInfo.new(1, Enum.EasingStyle.Linear), 0.5)),
    }
    u78[1262] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 0)),
    }
    u78[1291] = {
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear),
            Color3.new(1, 1, 1)
        )),
    }
    u78[1305] = {
        (TweenProperty(
            "Workspace.RaceOutroVFX.Portal.CFrame",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(993.9536, 309.0101, 98.9344) * u45 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u78[1312] = {
        (TweenProperty(
            "Workspace.RaceOutroVFX.Crack.Cloud.CFrame",
            TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear),
            CFrame.new(960.9952, -106.5977, 93.9837) * u60 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u78[1326] = {
        (TweenProperty(
            "Workspace.RaceOutroVFX.Portal.CFrame",
            TweenInfo.new(3.4166666666666665, Enum.EasingStyle.Linear),
            CFrame.new(743.2354, 233.9696, 111.3165) * u45 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u78[1328] = {SetProperty("Lighting.Portal2.Enabled", false)}
    u78[1332] = {
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.4166666666666667, Enum.EasingStyle.Linear), 7),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 1),
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", TweenInfo.new(0.65, Enum.EasingStyle.Linear), Color3.new(0, 0, 0))),
    }
    u78[1371] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", TweenInfo.new(2, Enum.EasingStyle.Linear), u91)),
    }
    u78[1417] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.7166666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u78[1454] = (backdrop(TweenInfo.new(0.35, Enum.EasingStyle.Linear), 0))
    u78[1491] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 0)),
    }
    u78[1520] = {
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear),
            Color3.new(1, 1, 1)
        )),
    }
    u78[1561] = {
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 1),
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", TweenInfo.new(0.65, Enum.EasingStyle.Linear), Color3.new(0, 0, 0))),
    }
    u78[1562] = {
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2),
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.8166666666666667, Enum.EasingStyle.Linear), 0)),
    }
    u78[1563] = {}
    u78[1582] = {
        TweenProperty(
            "Workspace.RaceOutroVFX.CastleCloudTwmp.CFrame",
            TweenInfo.new(0.7, Enum.EasingStyle.Linear),
            (CFrame.new(581.3223, 1293.6385, -382.0035)) + Vector3.new(-4009, 0, 9397)
        ),
        (TweenProperty(
            "Workspace.RaceOutroVFX.CastleCloudTwmp.Size",
            TweenInfo.new(0.7, Enum.EasingStyle.Linear),
            (Vector3.new(99.2240982055664, 299, 688))
        )),
    }
    u78[1957] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(1.3666666666666667, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 469
            -- upvalues: LocalPlayer (upval), MountRace (upval), u3 (val), hideCutsceneUi (upval)
            -- upvalues: restoreCutsceneUi (upval), MusicDirector (upval), OutroCutscene (upval), Lighting (upval)
            -- upvalues: CutsceneUI (val), Black (val), Vignette (val), a1 (val), Workspace (upval), u16 (ref)
            -- upvalues: SoundService (upval), TweenService (upval), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CurrentCamera (upval), u78 (val), BulkFade (upval)
            -- upvalues: UnixTimestamp (upval)
            local Animation, v1
            LocalPlayer:SetAttribute(MountRace.CutsceneAttribute, true)
            u3:Add(function() -- Line: 472 -- upvalues: LocalPlayer (upval), MountRace (upval)
                LocalPlayer:SetAttribute(MountRace.CutsceneAttribute, nil)
            end)
            xpcall(hideCutsceneUi, warn)
            u3:Add(restoreCutsceneUi)
            MusicDirector.SetEventMusic(true)
            u3:Add(function() -- Line: 480 -- upvalues: MusicDirector (upval)
                MusicDirector.SetEventMusic(false)
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
            u3:Add(function() -- Line: 497 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            a1:Add(function() -- Line: 502 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local v2 = OutroCutscene.RaceOutroVFX:Clone()
            v2.Parent = Workspace
            u16 = v2
            u3:Add(v2)
            v2 = OutroCutscene.RaceOutroMap:Clone()
            v2.Parent = Workspace
            u3:Add(v2)
            local u88 = OutroCutscene.CutsceneMusic:Clone()
            u88.Parent = SoundService
            u3:Add(u88)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            local v3 = OutroCutscene.RaceOutroRigs:Clone()
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
            local u150 = {}
            for i6, i7 in v3:GetChildren() do
                Animation = i7:FindFirstChild("Animation")
                u150[i7] = (LoadAnimationIntoRig(i7, Animation.AnimationId))
            end
            local u164 = true
            u3:Add(function() -- Line: 545 -- upvalues: u164 (ref), restoreCamera (upval)
                u164 = false
                restoreCamera()
            end)
            for i8, i9 in u150 do
                i9:Play(0)
            end
            local v5 = u150[v3.CameraRig]
            v1 = os.clock() + 2
            while u164 do
                if not (v5.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u88:Play()
            local CamFocus = v3.CameraRig.CamFocus
            u3:Connect(RunService.RenderStepped, function() -- Line: 568 -- upvalues: u164 (ref), CurrentCamera (upval), LocalPlayer (upval), CamFocus (val)
                if not u164 then
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = CamFocus
                CurrentCamera.Focus = CamFocus.CFrame
                CurrentCamera.CFrame = CamFocus.CFrame
            end)
            local u219 = {}
            local u220 = 0
            local u221 = 0.1
            v3 = u3:Connect(RunService.Heartbeat, function(a1) -- Line: 581
                -- upvalues: u220 (ref), u221 (ref), u150 (val), u88 (val), u78 (upval), u219 (val)
                local v1, v2
                u220 = u220 + a1
                u221 = u221 - a1
                for i, j in u150 do
                    v2 = j.Length - 0.05
                    if 0 < j.Length and v2 <= u220 and j.Speed ~= 0 then
                        j.TimePosition = v2
                        j:AdjustSpeed(0)
                    end
                end
                if u221 <= 0 then
                    u221 = 0.1
                    for k, n in u150 do
                        if n.IsPlaying and n.Speed ~= 0 and 0.4 <= (math.abs(u220 - n.TimePosition)) then
                            xpcall(function() -- Line: 600 -- upvalues: n (val), u220 (upval)
                                n.TimePosition = u220
                            end, warn)
                        end
                    end
                end
                if not (u88.TimePosition < u220 - 0.001) then
                    local TimePosition_2 = u88.TimePosition
                    if not (u220 + 0.001 < TimePosition_2) then
                        u88.PlaybackSpeed = 1
                    else
                        u88.PlaybackSpeed = 0.99
                    end
                else
                    u88.PlaybackSpeed = 1.01
                end
                for m = 0, 9 do
                    v1 = math.floor(u220 * 60 - m)
                    if u78[v1] and not u219[v1] then
                        u219[v1] = true
                        for i5, i6 in u78[v1] do
                            task.spawn(i6)
                        end
                    end
                end
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(34.5)
            v3:Disconnect()
            Black.BackgroundTransparency = 0
            Black.BackgroundColor3 = Color3.new(0, 0, 0)
            local u360 = CutsceneUI:FindFirstChild("HalloweenTeaser")
            local u352 = if not u360 or not u360:IsA("GuiObject") then nil else BulkFade.new(u360, TweenInfo.new(1))
            if u360 and u360:IsA("GuiObject") and u352 then
                local v6
                a1:Add(function() -- Line: 635 -- upvalues: u360 (val)
                    u360.Visible = false
                end)
                u352:FadeOutInstant()
                u360.Visible = true
                u352:FadeIn()
                local Sound = Instance.new("Sound")
                Sound.SoundId = "rbxassetid://119317416196943"
                Sound.Volume = 0.2
                Sound.Parent = SoundService
                local TimeRemaining = u360:FindFirstChild("TimeRemaining")
                local v7 = os.clock() + 5
                while os.clock() < v7 do
                    if TimeRemaining and TimeRemaining:IsA("TextLabel") then
                        v6 = math.max(0, (math.floor(UnixTimestamp - Workspace:GetServerTimeNow())))
                        TimeRemaining.Text = string.format("%02i:%02i:%02i:%02i", v6 // 86400, v6 // 3600 % 24, v6 // 60 % 60, v6 % 60)
                    end
                    Sound:Play()
                    task.wait(1)
                end
                Sound:Destroy()
                u352:FadeOut()
                task.delay(1, function() -- Line: 656 -- upvalues: u360 (val), u352 (val)
                    u360.Visible = false
                    u352:FadeIn()
                end)
            end
            u3:Clean()
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
        end,
    }
end