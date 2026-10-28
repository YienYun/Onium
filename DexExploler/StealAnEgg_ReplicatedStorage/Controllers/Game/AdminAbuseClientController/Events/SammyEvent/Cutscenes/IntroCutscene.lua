-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent.Cutscenes.IntroCutscene
-- Decompile time: 23.71 ms

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
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Shared.Remotes)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local SammyEventIntroRigs = ReplicatedStorage.CutsceneAssets.SammyEvent.SammyEventIntroRigs
local SammyEventIntroVFX = ReplicatedStorage.CutsceneAssets.SammyEvent.SammyEventIntroVFX
local u82 = nil
local u83 = nil
local u84 = nil
local u85 = nil
local u86 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local u92 = {}

local function restoreCamera() -- Line: 49 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 59
    -- upvalues: u83 (ref), u84 (ref), Tabs (val), LocalPlayer (val), u86 (val), StarterGui (val), u85 (ref)
    if u83 ~= nil then
        return
    end
    local v1 = {}
    Tabs.Active()
    for i, j in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if j:IsA("ScreenGui") and j.Name ~= "UI_NAME" and j.Enabled then
            v1[j] = true
            j.Enabled = false
        end
    end
    u83 = v1
    pcall(function() -- Line: 74 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u86 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u85 = v1
end

local function restoreAllUi() -- Line: 84
    -- upvalues: u83 (ref), u84 (ref), LocalPlayer (val), u85 (ref), StarterGui (val)
    local v1 = u83
    local v2 = u84
    u83 = nil
    u84 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 97 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u85
    u85 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 109 -- upvalues: u82 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u82 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 116 -- upvalues: restoreAllUi (val), u82 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u82
    u82 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 128 -- types: a1: table, a2: number?
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

local function restoreGuard(a1, a2) -- Line: 141 -- upvalues: u92 (val) -- types: a1: userdata, a2: userdata
    u92[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 150 -- upvalues: u92 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u92[Guard] = j
        Guard.Parent = nil
        local Nests = j:FindFirstChild("Nests")
        local Descendants = Nests
        if Descendants then
            Descendants = Nests:GetDescendants()
        end
        if Descendants then
            setTransparency(Descendants, 1)
        end
        v4:Add(function() -- Line: 164
            -- upvalues: Guard (val), j (val), u92 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u92[v1] = nil
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

local function restoreAllGuardsAndNests() -- Line: 173 -- upvalues: u92 (val), setTransparency (val)
    local Descendants, Guard, Nests
    local v1 = nil
    local v2 = nil
    for i, j in u92, v1, v2 do
        u92[i] = nil
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

return function(a1) -- Line: 187
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), hideCutsceneUi (val), restoreAllUi (val), u82 (ref)
    -- upvalues: Tabs (val), Workspace (val), ReplicatedStorage (val), hideAllGuardsAndNests (val), Lighting (val)
    -- upvalues: SammyEventIntroVFX (val), TweenService (val), SammyEventIntroRigs (val), ContentProvider (val)
    -- upvalues: restoreCamera (val), RunService (val), CurrentCamera (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local PlaySequenceAsync = v1.PlaySequenceAsync
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u16 = nil
    local u17 = nil
    local u18 = nil
    local u19 = {}
    local v2 = {}
    local v3 = SetProperty("Workspace.CurrentCamera.FieldOfView", 45)
    local v4 = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.75, Enum.EasingStyle.Linear), 35)
    local v5 = SetProperty(
        "Workspace.CurrentCamera.CFrame",
        CFrame.new(3796.665, 86.7965, -386.4179, -0.9931, 0.0378, -0.1106, -0, 0.9463, 0.3233, 0.1169, 0.3211, -0.9398)
    )
    local v6 = TweenProperty(
        "Workspace.CurrentCamera.CFrame",
        TweenInfo.new(8.516666666666667, Enum.EasingStyle.Linear),
        CFrame.new(3753.5005, 75.0279, -354.4407, 0.0198, -0.0393, -0.999, 0.0055, 0.9992, -0.0392, 0.9998, -0.0047, 0.02)
    )
    local v7 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)
    local v8 = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.9833333333333333, Enum.EasingStyle.Linear), 1)
    local v9 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", Color3.new(0, 0, 0))
    local v10 = SetProperty("Lighting.Close.Enabled", false)
    local v11 = SetProperty("Lighting.Far.Enabled", true)
    local v12 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(0, 0, 0))
    local v13 = TweenProperty(
        "PlayerGui.CutsceneUI.Vignette.ImageColor3",
        TweenInfo.new(9.683333333333334, Enum.EasingStyle.Linear),
        Color3.new(0.36618, 1, 0.258824)
    )
    local v14 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    local v15 = SetProperty("Lighting.Glitch.TintColor", Color3.new(1, 1, 1))
    local v16 = SetProperty("Lighting.Glitch.Brightness", 0)
    v2[1] = v3
    v2[2] = v4
    v2[3] = v5
    v2[4] = v6

    v2[5] = function() -- Line: 209 -- upvalues: u17 (ref), u16 (ref)
        for k, v in pairs(u17.Sammy.HypnoFace.Glitch:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = false
            end
        end
        for k2, i in pairs(u16.Hearts:GetDescendants()) do
            if i:IsA("ParticleEmitter") or i:IsA("Trail") or i:IsA("Beam") then
                i.Enabled = true
            end
        end
    end

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
    v2[16] = (SetProperty("Lighting.Glitch.Saturation", 0))
    v3 = SetProperty("Lighting.Glitch.Contrast", 0)
    v4 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    v5 = SetProperty("Lighting.CutsceneBlur.Size", 2)
    v6 = SetProperty("Workspace.SammyEventIntroVFX.Hearts.CFrame", CFrame.new(3808.9578, 71.9718, -354.5645, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    local v17 = TweenProperty(
        "Workspace.SammyEventIntroVFX.Hearts.CFrame",
        TweenInfo.new(0.7666666666666667, Enum.EasingStyle.Linear),
        CFrame.new(3804.4009, 71.9718, -354.5645, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    )
    v7 = SetProperty("Workspace.SammyEventIntroVFX.Dome.BlackDome.Color", Color3.new(0.180392, 0.388235, 0.168627))
    v8 = TweenProperty("Workspace.SammyEventIntroVFX.Dome.BlackDome.Color", TweenInfo.new(9.85, Enum.EasingStyle.Linear), Color3.new(0, 0, 0))
    v9 = SetProperty("Workspace.SammyEventIntroVFX.Dome.BlackDome.Transparency", 1)
    v2[17] = v3
    v2[18] = v4
    v2[19] = v5
    v2[20] = v6
    v2[21] = v17
    v2[22] = v7
    v2[23] = v8
    v2[24] = v9
    v2[25] = SetProperty("Workspace.SammyEventIntroVFX.Dome.BlackDome.CFrame", CFrame.new(3750.9365, 76.2239, -354.1235, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    u19[0] = v2
    u19[18] = {
        function() -- Line: 243 -- upvalues: u16 (ref)
            for k, v in pairs(u16.Aura:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u19[46] = {
        (TweenProperty(
            "Workspace.SammyEventIntroVFX.Hearts.CFrame",
            TweenInfo.new(2.2333333333333334, Enum.EasingStyle.Linear),
            CFrame.new(3790.2185, 71.9718, -354.5645, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u19[180] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 45),
        (TweenProperty(
            "Workspace.SammyEventIntroVFX.Hearts.CFrame",
            TweenInfo.new(1.5, Enum.EasingStyle.Linear),
            CFrame.new(3780.9097, 71.9718, -354.5645, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u19[181] = {SetProperty("Lighting.Close.Enabled", true), (SetProperty("Lighting.Far.Enabled", false))}
    u19[271] = {SetProperty("Lighting.Close.Enabled", false), (SetProperty("Lighting.Far.Enabled", true))}
    u19[273] = {
        function() -- Line: 271
            for k, v in pairs(workspace.SammyEventIntroVFX.Hearts:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u19[361] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.6, Enum.EasingStyle.Sine), 50)),
    }
    u19[397] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.8833333333333333, Enum.EasingStyle.Sine), 55)),
    }
    u19[433] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4, Enum.EasingStyle.Linear), 15)),
    }
    u19[457] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.05, Enum.EasingStyle.Linear), 4)),
    }
    u19[510] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 47.5)),
    }
    u19[511] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 45),
        (TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(12.483333333333333, Enum.EasingStyle.Linear),
            CFrame.new(3771.3481, 69.0059, -377.0066, -0.1228, -0.0156, -0.9923, -0.0066, 0.9999, -0.0149, 0.9924, 0.0047, -0.1228)
        )),
    }
    u19[543] = {
        function() -- Line: 305 -- upvalues: u16 (ref)
            local Attribute, Attribute_2, v1
            local Exclaim = u16.Exclaim

            local function check(a1) -- Line: 308 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Exclaim:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    Attribute = v:GetAttribute("EmitCount")
                    Attribute_2 = v:GetAttribute("EmitDuration")
                    v1 = false
                    if Attribute ~= nil then
                        v1 = Attribute ~= 0
                    end
                    if v1 then
                        v:Emit(Attribute)
                    end
                    v1 = false
                    if Attribute_2 ~= nil then
                        v1 = Attribute_2 ~= 0
                    end
                    if v1 then
                        v.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 323 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u19[579] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)),
    }
    u19[581] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), 0)),
    }
    u19[587] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.9833333333333333, Enum.EasingStyle.Linear), 4)),
    }
    u19[591] = {
        TweenProperty(
            "Workspace.SammyEventIntroVFX.Dome.BlackDome.Color",
            TweenInfo.new(1.15, Enum.EasingStyle.Linear),
            Color3.new(0.180392, 0.388235, 0.168627)
        ),
        (TweenProperty(
            "Workspace.SammyEventIntroVFX.Dome.BlackDome.Transparency",
            TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear),
            0
        )),
    }
    u19[606] = {
        function() -- Line: 349 -- upvalues: u16 (ref)
            for k, v in pairs(u16.Dome.BlackDome:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u19[657] = {
        function() -- Line: 358 -- upvalues: u17 (ref)
            for k, v in pairs(u17.Sammy.HypnoFace.Glitch:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    v2 = {}
    v3 = TweenProperty(
        "Workspace.CurrentCamera.FieldOfView",
        TweenInfo.new(2.316666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        95
    )
    v17 = TweenInfo.new(0.6, Enum.EasingStyle.Linear)
    v2[1] = v3

    v2[2] = function() -- Line: 368 -- upvalues: u18 (ref), u17 (ref)
        u18 = u17.Sammy.SammyFacecam.SamCam
    end

    v2[3] = TweenProperty("Lighting.Glitch.Saturation", v17, -2)
    u19[661] = v2
    u19[697] = {
        (TweenProperty("Lighting.Glitch.Contrast", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear), -2)),
    }
    u19[734] = {
        (TweenProperty("Lighting.Glitch.Saturation", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear), 2)),
    }
    u19[756] = {
        TweenProperty("Lighting.Glitch.Saturation", TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), -3),
        (TweenProperty("Lighting.Glitch.Contrast", TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    u19[769] = {
        (TweenProperty(
            "Lighting.Glitch.TintColor",
            TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear),
            Color3.new(0.421552, 1, 0.34902)
        )),
    }
    u19[795] = {
        function() -- Line: 392 -- upvalues: u17 (ref)
            for k, v in pairs(u17.Sammy.HypnoFace.Glitch:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u19[800] = {
        TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            70
        ),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0),
        TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0.0884083, 0.133333, 0.0522876)
        ),
        TweenProperty("Lighting.Glitch.TintColor", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        (TweenProperty("Lighting.Glitch.Saturation", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), -1.1)),
    }
    u19[801] = {
        TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            68.85742
        ),
        function() -- Line: 410 -- upvalues: u18 (ref), u17 (ref)
            u18 = u17["Camera Rig"].Cam
        end,
    }
    u19[806] = {
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.8666666666666667, Enum.EasingStyle.Linear), 1),
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(6.883333333333334, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u19[822] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            63.71582
        )),
    }
    u19[834] = {
        (TweenProperty("Lighting.Glitch.Saturation", TweenInfo.new(0.7, Enum.EasingStyle.Linear), 0)),
    }
    u19[835] = {
        TweenProperty(
            "PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        ),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), 7.5)),
    }
    u19[867] = {
        function() -- Line: 434 -- upvalues: u16 (ref)
            for k, v in pairs(u16.Dome.BlackDome:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u19[995] = {
        function() -- Line: 443 -- upvalues: u16 (ref)
            for k, v in pairs(u16.Aura:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u19[1013] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            25
        )),
    }
    u19[1014] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(4.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            22.80357
        )),
    }
    u19[1098] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.5833333333333333, Enum.EasingStyle.Linear), 4)),
    }
    u19[1219] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.6833333333333333, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 469
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u82 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval), Lighting (upval)
            -- upvalues: CutsceneUI (val), Black (val), Vignette (val), SammyEventIntroVFX (upval), u16 (ref)
            -- upvalues: TweenService (upval), u17 (ref), SammyEventIntroRigs (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CutsceneMusic (val)
            -- upvalues: u18 (ref), CurrentCamera (upval), LocalPlayer (upval), u19 (val)
            local Animation, Animation_2, Animation_3, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 474 -- upvalues: u0 (ref), restoreAllUi (upval), u82 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u82
                    u82 = nil
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
            pcall(function() -- Line: 482 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 484 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            hideAllGuardsAndNests(a1)
            local u21 = {}
            for i, j in script.LightingAssets:GetChildren() do
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
            a1:Add(function() -- Line: 508 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u52 = SammyEventIntroVFX:Clone()
            u52.Parent = Workspace
            a1:Add(u52)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 519 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            u17 = SammyEventIntroRigs:Clone()
            for k, n in u17:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            u17.Parent = workspace
            a1:Add(u17)
            local v2 = {}
            for m, i5 in u17:GetChildren() do
                Animation_3 = i5:FindFirstChildOfClass("Animation")
                if Animation_3 then
                    table.insert(v2, Animation_3)
                end
            end
            ContentProvider:PreloadAsync(v2)
            local u120 = {}
            for i6, i7 in u17:GetChildren() do
                Animation_2 = i7:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    u120[i7] = (LoadAnimationIntoRig(i7, Animation_2.AnimationId))
                end
            end
            for i8, i9 in u52:GetChildren() do
                Animation = i9:FindFirstChildOfClass("Animation")
                if Animation then
                    u120[i9] = (LoadAnimationIntoRig(i9, Animation.AnimationId))
                end
            end
            local u147 = true
            a1:Add(function() -- Line: 563 -- upvalues: u147 (ref)
                u147 = false
            end)
            a1:Add(function() -- Line: 564 -- upvalues: u147 (ref), restoreCamera (upval)
                if not u147 then
                    return
                end
                restoreCamera()
            end)
            for i10, i11 in u120 do
                i11:Play(0)
            end
            local v3 = u120[u17["Camera Rig"]]
            assert(v3, "Camera Rig needs an Animation")
            local v4 = os.clock() + 2
            while u147 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v4) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            CutsceneMusic:Play()
            u18 = u17["Camera Rig"].Cam
            local u200 = nil
            RunService.RenderStepped:Connect(function() -- Line: 591 -- upvalues: u147 (ref), u200 (ref), CurrentCamera (upval), LocalPlayer (upval), u18 (upval)
                if not u147 then
                    u200:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = u18
                CurrentCamera.Focus = u18.CFrame
                CurrentCamera.CFrame = u18.CFrame
            end)
            local u209 = {}
            local u210 = 0
            local u211 = 0.1
            v3 = RunService.Heartbeat:Connect(function(a1) -- Line: 605
                -- upvalues: u210 (ref), u211 (ref), u120 (val), CutsceneMusic (upval), u19 (upval), u209 (val)
                local v1
                u210 = u210 + a1
                u211 = u211 - 0.1
                if u211 <= 0 then
                    u211 = 0.1
                    for i, j in u120 do
                        if j.IsPlaying and 0.1 <= (math.abs(u210 - j.TimePosition)) then
                            xpcall(function() -- Line: 617 -- upvalues: j (val), u210 (upval)
                                j.TimePosition = u210
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u210 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u210 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u210 * 60 - k)
                    if u19[v1] and not u209[v1] then
                        u209[v1] = true
                        for n, m in u19[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v3)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(21.516666666666666)
            v3:Disconnect()
            xpcall(function() -- Line: 649 -- upvalues: u52 (val)
                u52:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 655 -- upvalues: u21 (val)
                for i, j in u21 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 661 -- upvalues: u17 (upval)
                u17:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 672 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 676 -- upvalues: restoreAllUi (upval), u82 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u82
                u82 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                u0 = true
            end, warn)
        end,
    }
end