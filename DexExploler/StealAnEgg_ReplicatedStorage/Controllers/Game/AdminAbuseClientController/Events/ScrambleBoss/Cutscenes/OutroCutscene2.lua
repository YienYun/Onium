-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Cutscenes.OutroCutscene2
-- Decompile time: 23.55 ms

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
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local BulkFade = require(ReplicatedStorage.Client.Modules.BulkFade)
local OutroCutscene2 = ReplicatedStorage.CutsceneAssets.ScrambleBossCutsceneAssets.OutroCutscene2
local u73 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u81 = nil
local u82 = nil
local u83 = nil
local u84 = nil
local u85 = {}

local function restoreCamera() -- Line: 48 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 58
    -- upvalues: u82 (ref), u83 (ref), Tabs (val), LocalPlayer (val), u73 (val), StarterGui (val), u84 (ref)
    if u82 ~= nil then
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
    u82 = v1
    pcall(function() -- Line: 73 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u73 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u84 = v1
end

local function restoreAllUi() -- Line: 83
    -- upvalues: u82 (ref), u83 (ref), LocalPlayer (val), u84 (ref), StarterGui (val)
    local v1 = u82
    local v2 = u83
    u82 = nil
    u83 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 96 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u84
    u84 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 108 -- upvalues: u81 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u81 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 115 -- upvalues: restoreAllUi (val), u81 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u81
    u81 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 127 -- types: a1: table, a2: number?
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

local function restoreGuard(a1, a2) -- Line: 140 -- upvalues: u85 (val) -- types: a1: userdata, a2: userdata
    u85[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 149 -- upvalues: u85 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u85[Guard] = j
        Guard.Parent = nil
        local Nests = j:FindFirstChild("Nests")
        local Descendants = Nests
        if Descendants then
            Descendants = Nests:GetDescendants()
        end
        if Descendants then
            setTransparency(Descendants, 1)
        end
        v4:Add(function() -- Line: 163
            -- upvalues: Guard (val), j (val), u85 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u85[v1] = nil
            local Guard_2 = v2:FindFirstChild("Guard")
            if Guard_2 == nil or Guard_2 == v1 then
                v1.Parent = v2
            end
            if Nests then
                setTransparency(Descendants)
            end
        end)
    end
end

local function restoreAllGuardsAndNests() -- Line: 172 -- upvalues: u85 (val), setTransparency (val)
    local Descendants, Guard, Nests
    local v1 = nil
    local v2 = nil
    for i, j in u85, v1, v2 do
        u85[i] = nil
        Guard = j:FindFirstChild("Guard")
        if Guard == nil or Guard == i then
            i.Parent = j
        end
        Nests = j:FindFirstChild("Nests")
        Descendants = Nests and Nests:GetDescendants()
        if Descendants then
            setTransparency(Descendants)
        end
    end
end

local function setEmitting(a1, a2) -- Line: 184 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emitBurst(a1) -- Line: 192 -- types: a1: userdata
    local Attribute, Attribute_2
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            Attribute = j:GetAttribute("EmitCount")
            Attribute_2 = j:GetAttribute("EmitDuration")
            if type(Attribute) == "number" and Attribute ~= 0 then
                j:Emit(Attribute)
            end
            if type(Attribute_2) == "number" and Attribute_2 ~= 0 then
                j.Enabled = true
                task.delay(Attribute_2, function() -- Line: 205 -- upvalues: j (val)
                    j.Enabled = false
                end)
            end
        end
    end
end

return function(a1) -- Line: 214
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), setEmitting (val), emitBurst (val)
    -- upvalues: hideCutsceneUi (val), restoreAllUi (val), u81 (ref), Tabs (val), Workspace (val)
    -- upvalues: ReplicatedStorage (val), hideAllGuardsAndNests (val), OutroCutscene2 (val), Lighting (val)
    -- upvalues: SoundService (val), TweenService (val), ContentProvider (val), restoreCamera (val), RunService (val)
    -- upvalues: CurrentCamera (val), BulkFade (val), restoreAllGuardsAndNests (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u13 = nil
    local u14 = {}
    local v2 = {}
    local v3 = SetProperty(
        "Workspace.CurrentCamera.CFrame",
        CFrame.new(-5252.8594, -234.99, 2545.4341, 0.791, 0.1643, -0.5893, -0, 0.9633, 0.2685, 0.6118, -0.2124, 0.762)
    )
    local v4 = SetProperty("Workspace.CurrentCamera.FieldOfView", 25)
    local v5 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)
    local v6 = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 1)
    local v7 = SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)
    local v8 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.Enabled", false)
    local v9 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.FillTransparency", 0.3)
    local v10 = TweenProperty(
        "Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.FillTransparency",
        TweenInfo.new(1.3, Enum.EasingStyle.Linear),
        0.2
    )
    local v11 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.OutlineTransparency", 0.3)
    local v12 = TweenProperty(
        "Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.OutlineTransparency",
        TweenInfo.new(1.3, Enum.EasingStyle.Linear),
        0.2
    )
    local v13 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.Enabled", false)
    local v14 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.FillTransparency", 0.3)
    local v15 = TweenProperty(
        "Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.FillTransparency",
        TweenInfo.new(1.3, Enum.EasingStyle.Linear),
        0.2
    )
    local v16 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.OutlineTransparency", 0.3)
    local v17 = TweenInfo.new(1.3, Enum.EasingStyle.Linear)
    v2[1] = v3
    v2[2] = v4

    v2[3] = function() -- Line: 230 -- upvalues: setEmitting (upval), u13 (ref)
        setEmitting(u13.Dizzy, false)
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
    v2[16] = (TweenProperty("Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.OutlineTransparency", v17, 0.2))
    v3 = SetProperty("Workspace.ScrambleBossOutro2VFX.Portal.Leap-In.Light.PointLight.Enabled", false)
    v4 = SetProperty("Workspace.ScrambleBossOutro2VFX.Portal.Leap-In.Light.PointLight.Brightness", 0)
    local v18 = SetProperty("Lighting.BlackGreen.Enabled", false)
    v5 = SetProperty("Lighting.WhiteGreen.Enabled", false)
    v6 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    v7 = SetProperty("Lighting.CutsceneBlur.Size", 15)
    v8 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.8666666666666667, Enum.EasingStyle.Linear), 4)
    v9 = SetProperty("Lighting.DepthOfField.Enabled", true)
    v10 = SetProperty("Lighting.DepthOfField.FarIntensity", 0.71)
    v11 = SetProperty("Lighting.DepthOfField.FocusDistance", 0)
    v12 = SetProperty("Lighting.DepthOfField.InFocusRadius", 27)
    v13 = SetProperty("Lighting.DepthOfField.NearIntensity", 0.66)
    v14 = SetProperty("Lighting.ColorCorrection.Saturation", 0.1)
    v15 = SetProperty("Lighting.ColorCorrection.Contrast", 0.2)
    v16 = SetProperty(
        "Workspace.ScrambleBossOutro2VFX.Sparkle.CFrame",
        CFrame.new(6522.7588, 300.0606, -388.7413, 0.9942, 0.0027, 0.1077, 0, 0.9997, -0.0246, -0.1077, 0.0245, 0.9939)
    )
    v17 = TweenInfo.new(7.266666666666667, Enum.EasingStyle.Linear)
    v2[17] = v3
    v2[18] = v4
    v2[19] = v18
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
    v2[32] = TweenProperty(
        "Workspace.ScrambleBossOutro2VFX.Sparkle.CFrame",
        v17,
        CFrame.new(6520.9277, 300.0616, -388.5854, 0.9964, 0.0027, 0.0848, -0.0006, 0.9997, -0.0246, -0.0848, 0.0245, 0.9961)
    )
    u14[0] = v2
    u14[64] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 10)),
    }
    u14[77] = {SetProperty("Lighting.WhiteGreen.Enabled", true)}
    local v19 = {}
    v3 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.Enabled", true)
    v4 = TweenProperty(
        "Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.FillTransparency",
        TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear),
        1
    )
    v18 = TweenProperty(
        "Workspace.ScrambleBossOutro2Rigs.BenRigWithHandles.Highlight.OutlineTransparency",
        TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear),
        1
    )
    v5 = SetProperty("Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.Enabled", true)
    v6 = TweenProperty(
        "Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.FillTransparency",
        TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear),
        1
    )
    v7 = TweenProperty(
        "Workspace.ScrambleBossOutro2Rigs.BrockkodileHeadRig.Highlight.OutlineTransparency",
        TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear),
        1
    )
    v8 = SetProperty("Workspace.ScrambleBossOutro2VFX.Portal.Leap-In.Light.PointLight.Enabled", true)
    v9 = TweenProperty(
        "Workspace.ScrambleBossOutro2VFX.Portal.Leap-In.Light.PointLight.Brightness",
        TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
        1.5
    )
    v12 = TweenInfo.new(0.1, Enum.EasingStyle.Linear)

    v19[1] = function() -- Line: 273 -- upvalues: emitBurst (upval), u13 (ref)
        emitBurst(u13.Portal)
    end

    v19[2] = v3
    v19[3] = v4
    v19[4] = v18
    v19[5] = v5
    v19[6] = v6
    v19[7] = v7
    v19[8] = v8
    v19[9] = v9
    v19[10] = TweenProperty("Lighting.CutsceneBlur.Size", v12, 15)
    u14[78] = v19
    u14[79] = {
        SetProperty("Lighting.BlackGreen.Enabled", true),
        (SetProperty("Lighting.WhiteGreen.Enabled", false)),
    }
    u14[81] = {
        SetProperty("Lighting.BlackGreen.Enabled", false),
        (SetProperty("Lighting.WhiteGreen.Enabled", true)),
    }
    u14[83] = {SetProperty("Lighting.WhiteGreen.Enabled", false)}
    u14[84] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 4)),
    }
    u14[89] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro2VFX.Portal.Leap-In.Light.PointLight.Brightness",
            TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear),
            0
        )),
    }
    u14[110] = {
        function() -- Line: 310 -- upvalues: emitBurst (upval), u13 (ref)
            emitBurst(u13.Smoke)
        end,
    }
    u14[113] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)),
    }
    u14[121] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 6)),
    }
    u14[132] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 10)),
    }
    u14[137] = {
        function() -- Line: 328 -- upvalues: setEmitting (upval), u13 (ref)
            setEmitting(u13.Dizzy, true)
        end,
    }
    u14[142] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 4)),
    }
    u14[225] = {
        (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 0)),
    }
    u14[252] = {
        (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(1.7166666666666666, Enum.EasingStyle.Linear), 0.71)),
    }
    u14[355] = {
        TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(1.8333333333333333, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.DepthOfField.FocusDistance", TweenInfo.new(1.8333333333333333, Enum.EasingStyle.Linear), 42),
        TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(1.8333333333333333, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.DepthOfField.NearIntensity", TweenInfo.new(1.2, Enum.EasingStyle.Linear), 0.3)),
    }
    u14[427] = {
        (TweenProperty("Lighting.DepthOfField.NearIntensity", TweenInfo.new(0.6166666666666667, Enum.EasingStyle.Linear), 1)),
    }
    u14[436] = {
        TweenProperty("Lighting.ColorCorrection.Saturation", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 0.3),
        TweenProperty("Lighting.ColorCorrection.Contrast", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 1),
        (TweenProperty(
            "Workspace.ScrambleBossOutro2VFX.Sparkle.CFrame",
            TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Linear),
            CFrame.new(6528.7046, 294.0695, -377.7816, 0.9883, 0.0222, 0.1506, 0.0094, 0.9785, -0.206, -0.152, 0.205, 0.9669)
        )),
    }
    u14[450] = {
        (TweenProperty("Lighting.ColorCorrection.Saturation", TweenInfo.new(3.283333333333333, Enum.EasingStyle.Linear), 0.3)),
    }
    u14[471] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro2VFX.Sparkle.CFrame",
            TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear),
            CFrame.new(6531.3262, 288.7675, -367.9813, 0.9804, 0.0305, 0.1947, 0.0262, 0.959, -0.2823, -0.1953, 0.2818, 0.9394)
        )),
    }
    u14[497] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro2VFX.Sparkle.CFrame",
            TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(6538.063, 287.3963, -358.272, 0.9749, 0.0287, 0.221, 0.0316, 0.9638, -0.2647, -0.2206, 0.265, 0.9387)
        )),
    }
    u14[525] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro2VFX.Sparkle.CFrame",
            TweenInfo.new(2.05, Enum.EasingStyle.Linear),
            CFrame.new(6565.7505, 275.9485, -317.0448, 0.985, -0.0108, 0.1721, 0.039, 0.9862, -0.1609, -0.168, 0.1652, 0.9719)
        )),
    }
    u14[647] = {
        TweenProperty("Lighting.ColorCorrection.Saturation", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 0.1),
        (TweenProperty("Lighting.ColorCorrection.Contrast", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 0.2)),
    }
    u14[653] = {
        TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.71),
        TweenProperty("Lighting.DepthOfField.FocusDistance", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 27),
        (TweenProperty("Lighting.DepthOfField.NearIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.66)),
    }
    u14[766] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 396
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u81 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval)
            -- upvalues: OutroCutscene2 (upval), Lighting (upval), CutsceneUI (val), Black (val), Vignette (val)
            -- upvalues: u13 (ref), SoundService (upval), TweenService (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CurrentCamera (upval)
            -- upvalues: LocalPlayer (upval), u14 (val), BulkFade (upval), restoreAllGuardsAndNests (upval)
            local Animation, Animation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 401 -- upvalues: u0 (ref), restoreAllUi (upval), u81 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u81
                    u81 = nil
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
            pcall(function() -- Line: 409 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 411 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            hideAllGuardsAndNests(a1)
            local u21 = {}
            for i, j in OutroCutscene2.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(j.Name) then
                    v1 = j:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u21, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            a1:Add(function() -- Line: 435 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u53 = OutroCutscene2.ScrambleBossOutro2VFX:Clone()
            u53.Parent = Workspace
            u13 = u53
            a1:Add(u53)
            local u64 = OutroCutscene2.ScrambleBossOutro2WorkspaceAssets:Clone()
            u64.Parent = Workspace
            a1:Add(u64)
            local u75 = OutroCutscene2.CutsceneMusic:Clone()
            u75.Parent = SoundService
            a1:Add(u75)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 454 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local u103 = OutroCutscene2.ScrambleBossOutro2Rigs:Clone()
            for k, n in u103:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            u103.Parent = Workspace
            a1:Add(u103)
            local v2 = {}
            for m, i5 in u103:GetChildren() do
                Animation_2 = i5:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    table.insert(v2, Animation_2)
                end
            end
            ContentProvider:PreloadAsync(v2)
            local u142 = {}
            for i6, i7 in u103:GetChildren() do
                Animation = i7:FindFirstChildOfClass("Animation")
                if Animation then
                    u142[i7] = (LoadAnimationIntoRig(i7, Animation.AnimationId))
                end
            end
            local u156 = true
            a1:Add(function() -- Line: 490 -- upvalues: u156 (ref)
                u156 = false
            end)
            a1:Add(function() -- Line: 491 -- upvalues: u156 (ref), restoreCamera (upval)
                if not u156 then
                    return
                end
                restoreCamera()
            end)
            for i8, i9 in u142 do
                i9:Play(0)
            end
            local v3 = u142[u103.HumanoidCameraRig]
            assert(v3, "HumanoidCameraRig needs an Animation")
            local v4 = os.clock() + 2
            while u156 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v4) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u75:Play()
            local Torso = u103.HumanoidCameraRig.Torso
            local u212 = nil
            RunService.RenderStepped:Connect(function() -- Line: 517 -- upvalues: u156 (ref), u212 (ref), CurrentCamera (upval), LocalPlayer (upval), Torso (val)
                if not u156 then
                    u212:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Torso
                CurrentCamera.Focus = Torso.CFrame
                CurrentCamera.CFrame = Torso.CFrame
            end)
            local u221 = {}
            local u222 = 0
            local u223 = 0.1
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 531 -- upvalues: u222 (ref), u223 (ref), u142 (val), u75 (val), u14 (upval), u221 (val)
                local v1
                u222 = u222 + a1
                u223 = u223 - 0.1
                if u223 <= 0 then
                    u223 = 0.1
                    for i, j in u142 do
                        if j.IsPlaying and 0.4 <= (math.abs(u222 - j.TimePosition)) then
                            xpcall(function() -- Line: 543 -- upvalues: j (val), u222 (upval)
                                j.TimePosition = u222
                            end, warn)
                        end
                    end
                end
                if not (u75.TimePosition < u222 - 0.001) then
                    local TimePosition_2 = u75.TimePosition
                    if not (u222 + 0.001 < TimePosition_2) then
                        u75.PlaybackSpeed = 1
                    else
                        u75.PlaybackSpeed = 0.99
                    end
                else
                    u75.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u222 * 60 - k)
                    if u14[v1] and not u221[v1] then
                        u221[v1] = true
                        for n, m in u14[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(13.616666666666667)
            v5:Disconnect()
            xpcall(function() -- Line: 575 -- upvalues: u53 (val)
                u53:Destroy()
            end, warn)
            xpcall(function() -- Line: 576 -- upvalues: u64 (val)
                u64:Destroy()
            end, warn)
            xpcall(function() -- Line: 577 -- upvalues: u75 (val)
                u75:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 583 -- upvalues: u21 (val)
                for i, j in u21 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 589 -- upvalues: u103 (val)
                u103:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            local u298 = BulkFade.new(CutsceneUI.NewBiome, TweenInfo.new(1))
            u298:FadeOutInstant()
            task.wait()
            u298:FadeIn()
            CutsceneUI.NewBiome.Visible = true
            task.spawn(function() -- Line: 599 -- upvalues: CutsceneUI (upval)
                local function toDHMS(a1) -- Line: 600 -- types: a1: number
                    return string.format("%02i:%02i:%02i:%02i", a1 / 86400, a1 / 3600 % 24, a1 / 60 % 60, a1 % 60)
                end

                local v1 = 604799
                while CutsceneUI.NewBiome.Visible do
                    CutsceneUI.NewBiome.TimeRemaining.Text = string.format("%02i:%02i:%02i:%02i", v1 / 86400, v1 / 3600 % 24, v1 / 60 % 60, v1 % 60)
                    script.ClockTick:Play()
                    task.wait(1)
                    v1 = v1 - 1
                end
            end)
            task.wait(5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            u298:FadeOut()
            task.delay(1, function() -- Line: 625 -- upvalues: CutsceneUI (upval), u298 (val)
                CutsceneUI.NewBiome.Visible = false
                u298:FadeIn()
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 637 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 641 -- upvalues: restoreAllUi (upval), u81 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u81
                u81 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                u0 = true
            end, warn)
            restoreAllGuardsAndNests()
        end,
    }
end