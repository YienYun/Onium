-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.Cutscenes.IntroCutscene
-- Decompile time: 22.53 ms

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CursedIslandWars = require(ReplicatedStorage.Data.CursedIslandWars)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.Parent.CutsceneHelperFunctions)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local State = require(script.Parent.Parent.State)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local IntroCutscene = ReplicatedStorage.CutsceneAssets.CursedIslandWarsCutsceneAssets.IntroCutscene
local u87 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u95 = nil
local u96 = nil
local u97 = nil
local u98 = nil

local function onTrack(a1) -- Line: 61 -- types: a1: userdata
    return a1 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
end

local function restoreCamera() -- Line: 65 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 74
    -- upvalues: u96 (ref), u97 (ref), Tabs (val), LocalPlayer (val), u87 (val), StarterGui (val), u98 (ref)
    if u96 ~= nil then
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
    u96 = v1
    pcall(function() -- Line: 89 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u87 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u98 = v1
end

local function restoreAllUi() -- Line: 99
    -- upvalues: u96 (ref), u97 (ref), LocalPlayer (val), u98 (ref), StarterGui (val)
    local v1 = u96
    local v2 = u97
    u96 = nil
    u97 = nil
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
    v1 = u98
    u98 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 124 -- upvalues: u95 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u95 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 131
    -- upvalues: restoreCamera (val), restoreAllUi (val), u95 (ref), Tabs (val)
    restoreCamera()
    local v1 = restoreAllUi()
    local v2 = u95
    u95 = nil
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
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), TweenService (val), setEmitting (val)
    -- upvalues: emitBurst (val), hideCutsceneUi (val), restoreCutsceneUi (val), MusicDirector (val)
    -- upvalues: LightingController (val), IntroCutscene (val), Lighting (val), Workspace (val), SoundService (val)
    -- upvalues: ContentProvider (val), restoreCamera (val), RunService (val), CurrentCamera (val)
    -- upvalues: CursedIslandWars (val), State (val)
    local u3 = a1:Extend()
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(u3)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local Letterbox = CutsceneUI.Letterbox
    local u17 = nil
    local u31 = CFrame.new(0, 0, 0, 0.0022, -0.0008, 1, -0.0495, 0.9988, 0.0009, -0.9988, -0.0495, 0.0021)

    local function drag(a1, a2, a3) -- Line: 192 -- upvalues: u31 (val) -- types: a1: number, a2: number, a3: number
        return (CFrame.new(a1, a2, a3)) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
    end

    local u46 = CFrame.new(0, 0, 0, 0.0468, -0.9805, 0.191, 0.0082, -0.1909, -0.9816, 0.9989, 0.0475, -0.0009)

    local function portalRift(a1, a2, a3) -- Line: 196
        -- upvalues: u46 (val)
        return (CFrame.new(a1, a2, a3)) * u46 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
    end

    local function tweenLetterbox(a1, a2) -- Line: 200
        -- upvalues: Letterbox (val), TweenService (upval)
        return function() -- Line: 201 -- upvalues: Letterbox (upval), TweenService (upval), a1 (val), a2 (val)
            for i, j in Letterbox:GetChildren() do
                if j:IsA("Frame") then
                    TweenService:Create(j, a1, {BackgroundTransparency = a2}):Play()
                end
            end
        end
    end

    local function linear(a1, a2) -- Line: 209 -- types: a1: number, a2: number
        return TweenInfo.new((a2 - a1) / 60, Enum.EasingStyle.Linear)
    end

    local u50 = {}
    local v2 = {}
    local v3 = SetProperty("Workspace.CurrentCamera.FieldOfView", 50)
    local v4 = SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)
    local v5 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 0.5)
    local v6 = SetProperty(
        "Workspace.CursedIntroVFX.Drag.CFrame",
        CFrame.new(610.7825, 186.3109, 64.6345) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
    )
    local v7 = SetProperty(
        "Workspace.CursedIntroVFX.PortalRift.CFrame",
        CFrame.new(783.3271, -359.9731, 61.5337) * u46 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
    )
    local u90 = TweenInfo.new(0)
    local u91 = 1
    local v8 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v9 = SetProperty("Lighting.CutsceneBlur.Size", 20)
    local v10 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.0833333333333333, Enum.EasingStyle.Linear), 2)
    local v11 = SetProperty("Lighting.Cut.Enabled", false)
    local v12 = SetProperty("Lighting.Cut.InFocusRadius", 0)
    local v13 = SetProperty("Lighting.Cut.FarIntensity", 1)
    local v14 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 1)
    local v15 = SetProperty("Lighting.Portal.Enabled", false)
    v2[1] = v3

    v2[2] = function() -- Line: 216 -- upvalues: setEmitting (upval), u17 (ref)
        setEmitting(u17.Drag, false)
        setEmitting(u17.RiftSuck, false)
    end

    v2[3] = v4
    v2[4] = v5
    v2[5] = v6
    v2[6] = v7

    v2[7] = function() -- Line: 201 -- upvalues: Letterbox (val), TweenService (upval), u90 (val), u91 (val)
        for i, j in Letterbox:GetChildren() do
            if j:IsA("Frame") then
                TweenService:Create(j, u90, {BackgroundTransparency = u91}):Play()
            end
        end
    end

    v2[8] = v8
    v2[9] = v9
    v2[10] = v10
    v2[11] = v11
    v2[12] = v12
    v2[13] = v13
    v2[14] = v14
    v2[15] = v15
    v2[16] = (SetProperty("Lighting.Portal.Saturation", 1))
    v3 = SetProperty("Lighting.Portal.Contrast", 1)
    local v16 = SetProperty("Lighting.Portal.TintColor", Color3.new(1, 0.701961, 0.341176))
    v4 = TweenProperty("Lighting.Portal.TintColor", TweenInfo.new(41.016666666666666, Enum.EasingStyle.Linear), Color3.new(1, 1, 1))
    v5 = SetProperty("Lighting.Portal.Brightness", 0.5)
    local v17 = TweenInfo.new(41.016666666666666, Enum.EasingStyle.Linear)
    v2[17] = v3
    v2[18] = v16
    v2[19] = v4
    v2[20] = v5
    v2[21] = TweenProperty("Lighting.Portal.Brightness", v17, 0)
    u50[0] = v2
    u50[121] = {SetProperty("Lighting.Cut.Enabled", true)}
    u50[178] = {
        (TweenProperty("Lighting.Cut.InFocusRadius", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 15)),
    }
    u50[785] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u50[796] = {
        function() -- Line: 254 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Rock)
        end,
    }
    u50[801] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 2)),
    }
    u50[849] = {
        function() -- Line: 264 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Fall)
        end,
    }
    u50[1219] = {SetProperty("Lighting.Cut.Enabled", false)}
    u50[1288] = {
        function() -- Line: 274 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Explosion)
        end,
    }
    u50[1318] = {SetProperty("Lighting.Cut.Enabled", true)}
    u50[1389] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u50[1401] = {
        function() -- Line: 288 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Trophy)
        end,
    }
    u50[1405] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 2)),
    }
    u50[1498] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 10)),
    }
    u50[1500] = {
        function() -- Line: 302 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Trophy2)
        end,
    }
    u50[1543] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7166666666666667, Enum.EasingStyle.Linear), 2)),
    }
    v2 = {}
    v5 = TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear)
    v7 = CFrame.new(609.4865, 186.356, 65.5653) * u31

    v2[1] = function() -- Line: 312 -- upvalues: setEmitting (upval), u17 (ref)
        setEmitting(u17.Drag, true)
    end

    v2[2] = TweenProperty("Workspace.CursedIntroVFX.Drag.CFrame", v5, v7 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875))
    u50[1588] = v2
    u50[1596] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear),
            CFrame.new(608.1913, 186.3826, 66.1231) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1604] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(605.6266, 186.3639, 65.7866) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1617] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(604.2318, 186.3022, 64.5627) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1627] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
            CFrame.new(603.7445, 186.1794, 62.0949) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1641] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
            CFrame.new(604.8831, 186.0538, 59.5438) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1655] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(607.7219, 186.0271, 58.9605) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1671] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(609.9418, 186.0977, 60.3489) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1684] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(611.1519, 186.2253, 62.9039) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1700] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(608.8846, 186.3498, 65.4508) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1716] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(606.3488, 186.3731, 65.9603) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1732] = {
        (TweenProperty(
            "Workspace.CursedIntroVFX.Drag.CFrame",
            TweenInfo.new(0.3, Enum.EasingStyle.Linear),
            CFrame.new(603.7178, 186.2299, 63.1155) * u31 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        )),
    }
    u50[1840] = {
        function() -- Line: 363 -- upvalues: setEmitting (upval), u17 (ref)
            setEmitting(u17.Drag, false)
        end,
    }
    u50[1857] = {
        function() -- Line: 369 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Crack.Cloud.Crack.EYES)
        end,
    }
    u50[1860] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 10)),
    }
    u50[1861] = {
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.8833333333333333, Enum.EasingStyle.Linear), 4),
        SetProperty("Lighting.Cut.Enabled", false),
    }
    u50[1863] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.0833333333333333, Enum.EasingStyle.Linear), 0)),
    }
    u50[1887] = {
        function() -- Line: 388 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Crack.Cloud.Crack.EYES2)
        end,
    }
    u50[1946] = {
        function() -- Line: 394 -- upvalues: setEmitting (upval), u17 (ref)
            setEmitting(u17.RiftSuck, true)
        end,
    }
    v2 = {}
    local u526 = TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear)
    local u527 = 0

    v2[1] = function() -- Line: 201 -- upvalues: Letterbox (val), TweenService (upval), u526 (val), u527 (val)
        for i, j in Letterbox:GetChildren() do
            if j:IsA("Frame") then
                TweenService:Create(j, u526, {BackgroundTransparency = u527}):Play()
            end
        end
    end

    u50[1993] = v2
    u50[2279] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.8, Enum.EasingStyle.Linear), 15)),
    }
    u50[2387] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 5)),
    }
    v2 = {}
    v16 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 20)
    v6 = TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear)

    v2[1] = function() -- Line: 412 -- upvalues: setEmitting (upval), u17 (ref)
        setEmitting(u17.RiftSuck, false)
    end

    v2[2] = v16
    v2[3] = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", v6, 0)
    u50[2407] = v2
    u50[2414] = {
        TweenProperty(
            "Workspace.CursedIntroVFX.PortalRift.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(669.1818, 226.5289, 62.072) * u46 + Vector3.new(-4008.899658203125, 0.0213775634765625, 9396.921875)
        ),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 9)),
    }
    u50[2415] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.3833333333333333, Enum.EasingStyle.Linear), 20)),
    }
    u50[2417] = {
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 1),
        SetProperty("Lighting.Portal.Enabled", true),
        TweenProperty("Lighting.Portal.Saturation", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0.2),
        (TweenProperty("Lighting.Portal.Contrast", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0)),
    }
    u50[2432] = {
        (TweenProperty("Lighting.Portal.Saturation", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 0)),
    }
    u50[2461] = {
        TweenProperty("Lighting.Portal.Saturation", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 1),
        TweenProperty("Lighting.Portal.Contrast", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 1),
        TweenProperty(
            "Lighting.Portal.TintColor",
            TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear),
            Color3.new(1, 0.701961, 0.341176)
        ),
        (TweenProperty("Lighting.Portal.Brightness", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 0.5)),
    }
    u50[2481] = {
        (TweenProperty("Lighting.Portal.Brightness", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 5)),
    }
    u50[2484] = {
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 20),
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 457
            -- upvalues: a1 (val), hideCutsceneUi (upval), u3 (val), restoreCutsceneUi (upval), MusicDirector (upval)
            -- upvalues: LightingController (upval), IntroCutscene (upval), Lighting (upval), CutsceneUI (val)
            -- upvalues: Black (val), Vignette (val), Letterbox (val), Workspace (upval), u17 (ref)
            -- upvalues: SoundService (upval), TweenService (upval), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CurrentCamera (upval), LocalPlayer (upval)
            -- upvalues: u50 (val), CursedIslandWars (upval), State (upval)
            local Animation, v1
            local v2 = os.clock()
            local u2 = false
            a1:Add(function() -- Line: 460 -- upvalues: u2 (ref)
                u2 = true
            end)
            xpcall(hideCutsceneUi, warn)
            u3:Add(restoreCutsceneUi)
            MusicDirector.SetEventMusic(true)
            u3:Add(function() -- Line: 468 -- upvalues: MusicDirector (upval)
                MusicDirector.SetEventMusic(false)
            end)
            LightingController.SetAuthoredLayer("CursedIslandWarsCutscene", IntroCutscene.SceneLighting, 999, 0)
            u3:Add(function() -- Line: 473 -- upvalues: LightingController (upval)
                LightingController.ClearLayer("CursedIslandWarsCutscene", 0)
            end)
            for i, j in IntroCutscene.LightingAssets:GetChildren() do
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
            Letterbox.Visible = true
            u3:Add(function() -- Line: 490 -- upvalues: Vignette (upval), Letterbox (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
                Letterbox.Visible = false
            end)
            a1:Add(function() -- Line: 496 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local v3 = IntroCutscene.CursedIntroVFX:Clone()
            v3.Parent = Workspace
            u17 = v3
            u3:Add(v3)
            local u88 = IntroCutscene.CutsceneMusic:Clone()
            u88.Parent = SoundService
            u3:Add(u88)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            local v4 = IntroCutscene.CursedIntroRigs:Clone()
            u3:Add(v4)
            for k, n in v4:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            v4.Parent = Workspace
            local v5 = {}
            for m, i5 in v4:GetChildren() do
                table.insert(v5, (i5:FindFirstChild("Animation")))
            end
            ContentProvider:PreloadAsync(v5)
            local u150 = {}
            for i6, i7 in v4:GetChildren() do
                Animation = i7:FindFirstChild("Animation")
                u150[i7] = (LoadAnimationIntoRig(i7, Animation.AnimationId))
            end
            local u164 = true
            u3:Add(function() -- Line: 535 -- upvalues: u164 (ref), restoreCamera (upval)
                u164 = false
                restoreCamera()
            end)
            for i8, i9 in u150 do
                i9:Play(0)
            end
            local v6 = u150[v4.CameraRig]
            v1 = os.clock() + 2
            while u164 do
                if not (v6.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u88:Play()
            local Head = v4.CameraRig.Head
            u3:Connect(RunService.RenderStepped, function() -- Line: 557 -- upvalues: u164 (ref), CurrentCamera (upval), LocalPlayer (upval), Head (val)
                if not u164 then
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Head
                CurrentCamera.Focus = Head.CFrame
                CurrentCamera.CFrame = Head.CFrame
            end)
            local u219 = {}
            local u220 = 0
            local u221 = 0.1
            v4 = u3:Connect(RunService.Heartbeat, function(a1) -- Line: 570
                -- upvalues: u220 (ref), u221 (ref), u150 (val), u88 (val), u50 (upval), u219 (val)
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
                            xpcall(function() -- Line: 589 -- upvalues: n (val), u220 (upval)
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
                    if u50[v1] and not u219[v1] then
                        u219[v1] = true
                        for i5, i6 in u50[v1] do
                            task.spawn(i6)
                        end
                    end
                end
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(42.166666666666664)
            v4:Disconnect()
            Black.BackgroundTransparency = 0
            u3:Clean()
            v4 = v2 + CursedIslandWars.Timing.Intro + 10
            while not u2 do
                if State.Phase() == "Reveal" or not (os.clock() < v4) then
                    break
                end
                task.wait(0.1)
            end
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
        end,
    }
end