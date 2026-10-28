-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Cutscenes.IntroCutscene1
-- Decompile time: 23.05 ms

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
local IntroCutscene1 = ReplicatedStorage.CutsceneAssets.ScrambleBossCutsceneAssets.IntroCutscene1
local u68 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u76 = nil
local u77 = nil
local u78 = nil
local u79 = nil
local u80 = {}

local function restoreCamera() -- Line: 47 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 57
    -- upvalues: u77 (ref), u78 (ref), Tabs (val), LocalPlayer (val), u68 (val), StarterGui (val), u79 (ref)
    if u77 ~= nil then
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
    u77 = v1
    pcall(function() -- Line: 72 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u68 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u79 = v1
end

local function restoreAllUi() -- Line: 82
    -- upvalues: u77 (ref), u78 (ref), LocalPlayer (val), u79 (ref), StarterGui (val)
    local v1 = u77
    local v2 = u78
    u77 = nil
    u78 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 95 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u79
    u79 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 107 -- upvalues: u76 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u76 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 114 -- upvalues: restoreAllUi (val), u76 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u76
    u76 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 126 -- types: a1: table, a2: number?
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

local function restoreGuard(a1, a2) -- Line: 139 -- upvalues: u80 (val) -- types: a1: userdata, a2: userdata
    u80[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 148 -- upvalues: u80 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u80[Guard] = j
        Guard.Parent = nil
        local Nests = j:FindFirstChild("Nests")
        local Descendants = Nests
        if Descendants then
            Descendants = Nests:GetDescendants()
        end
        if Descendants then
            setTransparency(Descendants, 1)
        end
        v4:Add(function() -- Line: 162
            -- upvalues: Guard (val), j (val), u80 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u80[v1] = nil
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

local function restoreAllGuardsAndNests() -- Line: 171 -- upvalues: u80 (val), setTransparency (val)
    local Descendants, Guard, Nests
    local v1 = nil
    local v2 = nil
    for i, j in u80, v1, v2 do
        u80[i] = nil
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

local function setEmitting(a1, a2) -- Line: 183 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emitBurst(a1) -- Line: 191 -- types: a1: userdata
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
                task.delay(Attribute_2, function() -- Line: 204 -- upvalues: j (val)
                    j.Enabled = false
                end)
            end
        end
    end
end

return function(a1) -- Line: 213
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), setEmitting (val), emitBurst (val)
    -- upvalues: hideCutsceneUi (val), restoreAllUi (val), u76 (ref), Tabs (val), Workspace (val)
    -- upvalues: ReplicatedStorage (val), hideAllGuardsAndNests (val), IntroCutscene1 (val), Lighting (val)
    -- upvalues: SoundService (val), TweenService (val), ContentProvider (val), restoreCamera (val), RunService (val)
    -- upvalues: CurrentCamera (val), restoreAllGuardsAndNests (val)
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
    local v4 = SetProperty("Workspace.CurrentCamera.FieldOfView", 30)
    local v5 = SetProperty("Lighting.DepthOfField.Enabled", true)
    local v6 = SetProperty("Lighting.DepthOfField.InFocusRadius", 10)
    local v7 = SetProperty("Lighting.DepthOfField.FocusDistance", 5)
    local v8 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v9 = SetProperty("Lighting.CutsceneBlur.Size", 10)
    local v10 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 2)
    local v11 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 1)
    local v12 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", Color3.new(0, 0, 0))
    local v13 = TweenProperty(
        "PlayerGui.CutsceneUI.Black.BackgroundColor3",
        TweenInfo.new(14.633333333333333, Enum.EasingStyle.Linear),
        Color3.new(0.596974, 1, 0.384314)
    )
    local v14 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    local v15 = SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)
    local v16 = SetProperty("Lighting.CrazyBrock.Enabled", false)
    v2[1] = v3
    v2[2] = v4

    v2[3] = function() -- Line: 229 -- upvalues: setEmitting (upval), u13 (ref)
        setEmitting(u13.MainPortal, false)
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
    v2[16] = (SetProperty("Lighting.CrazyBrock.Saturation", -0.5))
    v3 = TweenProperty("Lighting.CrazyBrock.Saturation", TweenInfo.new(10.583333333333334, Enum.EasingStyle.Linear), 0)
    v4 = SetProperty("Lighting.CrazyBrock.Contrast", 0.7)
    local v17 = TweenProperty("Lighting.CrazyBrock.Contrast", TweenInfo.new(10.583333333333334, Enum.EasingStyle.Linear), 0)
    v5 = SetProperty("Lighting.CrazyBrock.TintColor", Color3.new(0.698039, 1, 0.643137))
    v6 = TweenProperty("Lighting.CrazyBrock.TintColor", TweenInfo.new(10.583333333333334, Enum.EasingStyle.Linear), Color3.new(1, 1, 1))
    v7 = SetProperty("Lighting.CrazyBrock.Brightness", -0.1)
    v8 = TweenProperty("Lighting.CrazyBrock.Brightness", TweenInfo.new(10.583333333333334, Enum.EasingStyle.Linear), 0)
    v9 = SetProperty("Lighting.WhiteGreen.Enabled", false)
    v10 = SetProperty("Lighting.BlackGreen.Enabled", false)
    v11 = SetProperty("Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.FillColor", Color3.new(0.392157, 1, 0.254902))
    v12 = TweenProperty(
        "Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.FillColor",
        TweenInfo.new(14.433333333333334, Enum.EasingStyle.Linear),
        Color3.new(0, 0, 0)
    )
    v13 = SetProperty("Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.Enabled", false)
    v14 = SetProperty("Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.FillColor", Color3.new(0.392157, 1, 0.254902))
    v15 = TweenProperty(
        "Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.FillColor",
        TweenInfo.new(14.433333333333334, Enum.EasingStyle.Linear),
        Color3.new(0, 0, 0)
    )
    v16 = SetProperty("Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.Enabled", false)
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
    v2[32] = (SetProperty("Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.FillColor", Color3.new(0.392157, 1, 0.254902)))
    v2[33] = (TweenProperty(
        "Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.FillColor",
        TweenInfo.new(14.433333333333334, Enum.EasingStyle.Linear),
        Color3.new(0, 0, 0)
    ))
    v2[34] = SetProperty("Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.Enabled", false)
    u14[0] = v2
    u14[87] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), 15)),
    }
    u14[89] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 5)),
    }
    u14[114] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 15)),
    }
    u14[115] = {
        function() -- Line: 278 -- upvalues: emitBurst (upval), u13 (ref)
            emitBurst(u13.Smoke)
        end,
    }
    u14[118] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 2)),
    }
    u14[263] = {
        (TweenProperty("Lighting.DepthOfField.FocusDistance", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    u14[265] = {
        (TweenProperty("Lighting.DepthOfField.FocusDistance", TweenInfo.new(15.7, Enum.EasingStyle.Linear), 5)),
    }
    u14[298] = {
        function() -- Line: 296 -- upvalues: setEmitting (upval), u13 (ref)
            setEmitting(u13.ClawPortal1, true)
        end,
    }
    u14[381] = {
        function() -- Line: 302 -- upvalues: setEmitting (upval), u13 (ref)
            setEmitting(u13.ClawPortal2, true)
        end,
    }
    u14[397] = {
        function() -- Line: 308 -- upvalues: setEmitting (upval), u13 (ref)
            setEmitting(u13.ClawPortal3, true)
        end,
    }
    u14[501] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6166666666666667, Enum.EasingStyle.Linear), 10)),
    }
    u14[538] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.5666666666666667, Enum.EasingStyle.Linear), 7)),
    }
    u14[632] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear), 4)),
    }
    u14[635] = {
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.CrazyBrock.Enabled", true),
        TweenProperty("Lighting.CrazyBrock.Saturation", TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear), -0.5),
        TweenProperty("Lighting.CrazyBrock.Contrast", TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear), 0.7),
        TweenProperty(
            "Lighting.CrazyBrock.TintColor",
            TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear),
            Color3.new(0.698039, 1, 0.643137)
        ),
        (TweenProperty("Lighting.CrazyBrock.Brightness", TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear), -0.1)),
    }
    u14[726] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 10)),
    }
    u14[738] = {
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 5),
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), 1),
        TweenProperty("Lighting.CrazyBrock.Saturation", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.CrazyBrock.Contrast", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.CrazyBrock.TintColor", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        (TweenProperty("Lighting.CrazyBrock.Brightness", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    u14[754] = {
        function() -- Line: 348 -- upvalues: setEmitting (upval), u13 (ref)
            setEmitting(u13.ClawPortal1, false)
            setEmitting(u13.ClawPortal2, false)
            setEmitting(u13.ClawPortal3, false)
            setEmitting(u13.MainPortal, true)
        end,
    }
    u14[814] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 0)),
    }
    u14[859] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 25)),
    }
    u14[866] = {
        SetProperty("Lighting.BlackGreen.Enabled", true),
        SetProperty("Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.Enabled", true),
        SetProperty("Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.Enabled", true),
        (SetProperty("Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.Enabled", true)),
    }
    u14[867] = {
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0.392157, 1, 0.254902)
        ),
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0.392157, 1, 0.254902)
        ),
        (TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0.392157, 1, 0.254902)
        )),
    }
    u14[868] = {
        SetProperty("Lighting.WhiteGreen.Enabled", true),
        (SetProperty("Lighting.BlackGreen.Enabled", false)),
    }
    u14[869] = {
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        ),
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        ),
        (TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u14[870] = {
        SetProperty("Lighting.WhiteGreen.Enabled", false),
        (SetProperty("Lighting.BlackGreen.Enabled", true)),
    }
    u14[871] = {
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0.392157, 1, 0.254902)
        ),
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0.392157, 1, 0.254902)
        ),
        (TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0.392157, 1, 0.254902)
        )),
    }
    u14[872] = {
        SetProperty("Lighting.WhiteGreen.Enabled", true),
        (SetProperty("Lighting.BlackGreen.Enabled", false)),
    }
    u14[873] = {
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        ),
        TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        ),
        (TweenProperty(
            "Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.FillColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u14[874] = {
        SetProperty("Lighting.WhiteGreen.Enabled", false),
        (SetProperty("Lighting.BlackGreen.Enabled", true)),
    }
    u14[876] = {
        SetProperty("Lighting.BlackGreen.Enabled", false),
        SetProperty("Workspace.ScrambleBossIntro1Rigs.BenRigWithHandles.Highlight.Enabled", false),
        SetProperty("Workspace.ScrambleBossIntro1Rigs.HatRig.Highlight.Enabled", false),
        (SetProperty("Workspace.ScrambleBossIntro1Rigs.BrockkodileHeadRig.Highlight.Enabled", false)),
    }
    u14[877] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u14[880] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 5)),
    }
    u14[881] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 1)),
    }
    u14[893] = {
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u14[934] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 0)),
    }
    u14[1207] = {
        (TweenProperty("Lighting.DepthOfField.FocusDistance", TweenInfo.new(0.35, Enum.EasingStyle.Linear), 20)),
    }
    return {
        Run = function() -- Line: 448
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u76 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval)
            -- upvalues: IntroCutscene1 (upval), Lighting (upval), CutsceneUI (val), Black (val), Vignette (val)
            -- upvalues: u13 (ref), SoundService (upval), TweenService (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CurrentCamera (upval)
            -- upvalues: LocalPlayer (upval), u14 (val), restoreAllGuardsAndNests (upval)
            local Animation, Animation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 453 -- upvalues: u0 (ref), restoreAllUi (upval), u76 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u76
                    u76 = nil
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
            pcall(function() -- Line: 461 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 463 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            hideAllGuardsAndNests(a1)
            local u21 = {}
            for i, j in IntroCutscene1.LightingAssets:GetChildren() do
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
            a1:Add(function() -- Line: 487 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u53 = IntroCutscene1.ScrambleBossIntro1VFX:Clone()
            u53.Parent = Workspace
            u13 = u53
            a1:Add(u53)
            local u64 = IntroCutscene1.ScrambleBossIntro1WorkspaceAssets:Clone()
            u64.Parent = Workspace
            a1:Add(u64)
            local u75 = IntroCutscene1.CutsceneMusic:Clone()
            u75.Parent = SoundService
            a1:Add(u75)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 507 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local u103 = IntroCutscene1.ScrambleBossIntro1Rigs:Clone()
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
            a1:Add(function() -- Line: 543 -- upvalues: u156 (ref)
                u156 = false
            end)
            a1:Add(function() -- Line: 544 -- upvalues: u156 (ref), restoreCamera (upval)
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
            RunService.RenderStepped:Connect(function() -- Line: 570 -- upvalues: u156 (ref), u212 (ref), CurrentCamera (upval), LocalPlayer (upval), Torso (val)
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
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 584 -- upvalues: u222 (ref), u223 (ref), u142 (val), u75 (val), u14 (upval), u221 (val)
                local v1
                u222 = u222 + a1
                u223 = u223 - 0.1
                if u223 <= 0 then
                    u223 = 0.1
                    for i, j in u142 do
                        if j.IsPlaying and 0.4 <= (math.abs(u222 - j.TimePosition)) then
                            xpcall(function() -- Line: 596 -- upvalues: j (val), u222 (upval)
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
            task.wait(16.966666666666665)
            v5:Disconnect()
            xpcall(function() -- Line: 628 -- upvalues: u53 (val)
                u53:Destroy()
            end, warn)
            xpcall(function() -- Line: 629 -- upvalues: u64 (val)
                u64:Destroy()
            end, warn)
            xpcall(function() -- Line: 630 -- upvalues: u75 (val)
                u75:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 636 -- upvalues: u21 (val)
                for i, j in u21 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 642 -- upvalues: u103 (val)
                u103:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            task.wait(0.5)
            Vignette.Visible = false
            pcall(function() -- Line: 651 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 655 -- upvalues: restoreAllUi (upval), u76 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u76
                u76 = nil
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