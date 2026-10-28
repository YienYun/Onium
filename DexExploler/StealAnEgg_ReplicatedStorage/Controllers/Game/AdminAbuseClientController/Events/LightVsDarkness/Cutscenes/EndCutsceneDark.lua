-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.Cutscenes.EndCutsceneDark
-- Decompile time: 28.84 ms

local ContentProvider = game:GetService("ContentProvider")
game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local BulkFade = require(ReplicatedStorage.Client.Modules.BulkFade)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Shared.Remotes)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local LightVsDarkCutsceneEndRigs = ReplicatedStorage.CutsceneAssets.LightVSDarkness.LightVsDarkCutsceneEndRigs
local u79 = nil
local u80 = nil
local u81 = nil
local u82 = nil
local u83 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local u89 = {}

local function restoreCamera() -- Line: 48 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 58
    -- upvalues: u80 (ref), u81 (ref), Tabs (val), LocalPlayer (val), u83 (val), StarterGui (val), u82 (ref)
    if u80 ~= nil then
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
    u80 = v1
    pcall(function() -- Line: 73 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u83 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u82 = v1
end

local function restoreAllUi() -- Line: 83
    -- upvalues: u80 (ref), u81 (ref), LocalPlayer (val), u82 (ref), StarterGui (val)
    local v1 = u80
    local v2 = u81
    u80 = nil
    u81 = nil
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
    v1 = u82
    u82 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 108 -- upvalues: u79 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u79 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 115 -- upvalues: restoreAllUi (val), u79 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u79
    u79 = nil
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

local function restoreGuard(a1, a2) -- Line: 140 -- upvalues: u89 (val) -- types: a1: userdata, a2: userdata
    u89[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 149 -- upvalues: u89 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u89[Guard] = j
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
            -- upvalues: Guard (val), j (val), u89 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u89[v1] = nil
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

local function restoreAllGuardsAndNests() -- Line: 172 -- upvalues: u89 (val), setTransparency (val)
    local Descendants, Guard, Nests
    local v1 = nil
    local v2 = nil
    for i, j in u89, v1, v2 do
        u89[i] = nil
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

local u99 = nil
local u100 = nil
local u101 = nil

local function hideZone12(a1) -- Line: 187 -- upvalues: u99 (ref), u100 (ref), u101 (ref)
    local Zone12Props = game.Workspace.World.Build.Props:FindFirstChild("Zone12Props")
    if Zone12Props then
        Zone12Props.Parent = nil
        u99 = Zone12Props
        a1:Add(function() -- Line: 192 -- upvalues: Zone12Props (val)
            Zone12Props.Parent = game.Workspace.World.Build.Props
        end)
    end
    local Board = game.Workspace.World.Areas.LightDark:FindFirstChild("Board")
    if Board then
        Board.Parent = nil
        u100 = Board
        a1:Add(function() -- Line: 201 -- upvalues: Zone12Props (val)
            Zone12Props.Parent = game.Workspace.World.Areas.LightDark
        end)
    end
    local LightDarkZone = game.Workspace.World.Build:FindFirstChild("LightDarkZone")
    if LightDarkZone then
        LightDarkZone.Parent = nil
        u101 = LightDarkZone
        a1:Add(function() -- Line: 210 -- upvalues: LightDarkZone (val)
            LightDarkZone.Parent = game.Workspace.World.Build
        end)
    end
end

local function restoreZone12() -- Line: 216 -- upvalues: u99 (ref), u100 (ref), u101 (ref)
    if u99 then
        u99.Parent = game.Workspace.World.Build.Props
    end
    if u100 then
        u100.Parent = game.Workspace.World.Areas.LightDark
    end
    if u101 then
        u101.Parent = game.Workspace.World.Build
    end
end

return function(a1) -- Line: 232
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), hideCutsceneUi (val), restoreAllUi (val), u79 (ref)
    -- upvalues: Tabs (val), Workspace (val), ReplicatedStorage (val), hideAllGuardsAndNests (val), hideZone12 (val)
    -- upvalues: Lighting (val), TweenService (val), LightVsDarkCutsceneEndRigs (val), ContentProvider (val)
    -- upvalues: restoreCamera (val), RunService (val), CurrentCamera (val), BulkFade (val)
    -- upvalues: restoreAllGuardsAndNests (val), u99 (ref), u100 (ref), u101 (ref)
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
    local u17 = {}
    u17[0] = {
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(4982.5005, 142.036, -415.143, -0.0078, 0.4663, -0.8846, -0.0122, 0.8845, 0.4664, 0.9999, 0.0144, -0.0012)
        ),
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(5, Enum.EasingStyle.Linear),
            CFrame.new(5495.7603, 71.3227, -358.1957, -0.4007, -0.0489, -0.9149, -0.155, 0.9878, 0.0151, 0.903, 0.1478, -0.4034)
        ),
        SetProperty("Workspace.CurrentCamera.FieldOfView", 45),
        SetProperty(
            "Workspace.LightVSDarkCutsceneEnd.VFX.DarkWin.Aura.Floor.CFrame",
            CFrame.new(5508.5933, 68.4898, 508.6608, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        SetProperty(
            "Workspace.LightVSDarkCutsceneEnd.VFX.DarkWin.Aura.Halo.CFrame",
            CFrame.new(5524.729, 119.1384, 509.4725, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        SetProperty("Lighting.CutsceneBlur.Enabled", true),
        SetProperty("Lighting.CutsceneBlur.Size", 25),
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.0333333333333334, Enum.EasingStyle.Linear), 2),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.55, Enum.EasingStyle.Linear), 1),
        SetProperty("Lighting.White.Enabled", false),
        SetProperty("Lighting.Black.Enabled", false),
        SetProperty("Lighting.REDWhite.Enabled", false),
        SetProperty("Lighting.REDBlack.Enabled", false),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(0, 0, 0)),
        TweenProperty(
            "PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(5.25, Enum.EasingStyle.Linear),
            Color3.new(0.0586241, 0, 0)
        ),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
        (SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)),
    }
    u17[8] = {
        function() -- Line: 269 -- upvalues: u16 (ref)
            for k, v in pairs(u16.VFX.DarkWin.FloorSammy:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u17[20] = {
        function() -- Line: 278 -- upvalues: u16 (ref)
            for k, v in pairs(u16.VFX.DarkWin.Hearts:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u17[101] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 15)),
    }
    u17[106] = {
        function() -- Line: 291 -- upvalues: u16 (ref)
            local Attribute, Attribute_2, v1
            local Hit = u16.VFX.DarkWin.Hit

            local function check(a1) -- Line: 294 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Hit:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 309 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u17[107] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 2)),
    }
    u17[220] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 15)),
    }
    u17[227] = {
        function() -- Line: 326 -- upvalues: u16 (ref)
            local Attribute, Attribute_2, v1
            local Smoke = u16.VFX.DarkWin.Smoke

            local function check(a1) -- Line: 329 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 344 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u17[231] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.75, Enum.EasingStyle.Linear), 2)),
    }
    u17[300] = {
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(5442.0625, 110.1231, 508.3064, 0.0085, -0.0872, -0.9962, -0, 0.9962, -0.0872, 1, 0.0007, 0.0085)
        ),
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 75),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u17[301] = {
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(8.666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(5626.7803, 75.4134, 505.1515, -0.226, -0.3605, -0.905, -0.2128, 0.9248, -0.3152, 0.9506, 0.1214, -0.2857)
        ),
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Sine), 50),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 2)),
    }
    u17[314] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u17[315] = {
        SetProperty("Lighting.REDWhite.Enabled", true),
        (TweenProperty(
            "PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(19.333333333333332, Enum.EasingStyle.Linear),
            Color3.new(0.27451, 0, 0)
        )),
    }
    u17[317] = {
        SetProperty("Lighting.REDWhite.Enabled", false),
        (SetProperty("Lighting.REDBlack.Enabled", true)),
    }
    u17[319] = {
        SetProperty("Lighting.White.Enabled", true),
        (SetProperty("Lighting.REDBlack.Enabled", false)),
    }
    u17[321] = {SetProperty("Lighting.White.Enabled", false), (SetProperty("Lighting.Black.Enabled", true))}
    u17[323] = {
        SetProperty("Lighting.Black.Enabled", false),
        (SetProperty("Lighting.REDWhite.Enabled", true)),
    }
    u17[325] = {
        SetProperty("Lighting.REDWhite.Enabled", false),
        (SetProperty("Lighting.REDBlack.Enabled", true)),
    }
    u17[327] = {SetProperty("Lighting.REDBlack.Enabled", false)}
    u17[340] = {
        SetProperty("Lighting.REDWhite.Enabled", false),
        SetProperty("Lighting.REDBlack.Enabled", false),
        SetProperty("Lighting.White.Enabled", false),
        SetProperty("Lighting.Black.Enabled", false),
        SetProperty("Lighting.REDWhite.Enabled", false),
        (SetProperty("Lighting.REDBlack.Enabled", false)),
    }
    u17[350] = {
        SetProperty("Lighting.REDWhite.Enabled", false),
        SetProperty("Lighting.REDBlack.Enabled", false),
        SetProperty("Lighting.White.Enabled", false),
        SetProperty("Lighting.Black.Enabled", false),
        SetProperty("Lighting.REDWhite.Enabled", false),
        (SetProperty("Lighting.REDBlack.Enabled", false)),
    }
    u17[600] = {
        TweenProperty(
            "Workspace.LightVSDarkCutsceneEnd.VFX.DarkWin.Aura.Floor.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(5508.5933, -165.5602, 508.6608, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        TweenProperty(
            "Workspace.LightVSDarkCutsceneEnd.VFX.DarkWin.Aura.Halo.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(5524.729, -147.5948, 509.4725, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1)),
    }
    u17[821] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.25, Enum.EasingStyle.Sine), 35)),
    }
    u17[872] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.35, Enum.EasingStyle.Sine), 45)),
    }
    u17[890] = {
        function() -- Line: 439 -- upvalues: u16 (ref)
            local Attribute, Attribute_2, v1
            local SammyHit = u16.VFX.DarkWin.SammyHit

            local function check(a1) -- Line: 442 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(SammyHit:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 457 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u17[956] = {
        function() -- Line: 466 -- upvalues: u16 (ref)
            local Attribute, Attribute_2, v1
            local Smoke3 = u16.VFX.DarkWin.Smoke3

            local function check(a1) -- Line: 469 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke3:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 484 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u17[976] = {
        function() -- Line: 493 -- upvalues: u16 (ref)
            local Attribute, Attribute_2, v1
            local Smoke4 = u16.VFX.DarkWin.Smoke4

            local function check(a1) -- Line: 496 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke4:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 511 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u17[1219] = {
        function() -- Line: 520 -- upvalues: u16 (ref)
            for k, v in pairs(u16.VFX.DarkWin.Hearts:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u17[1305] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u17[1306] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u17[1376] = {
        function() -- Line: 537 -- upvalues: u16 (ref)
            for k, v in pairs(u16.VFX.DarkWin.Hearts:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u17[1393] = {
        function() -- Line: 546 -- upvalues: u16 (ref)
            for k, v in pairs(u16.VFX.DarkWin.FloorSammy:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u17[1471] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 70)),
    }
    u17[1472] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.25, Enum.EasingStyle.Sine), 40)),
    }
    u17[1475] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0)),
    }
    u17[1570] = {
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.3), 0),
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 1)),
    }
    return {
        Run = function() -- Line: 572
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u79 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval), hideZone12 (upval)
            -- upvalues: Lighting (upval), CutsceneUI (val), Black (val), Vignette (val), u16 (ref)
            -- upvalues: TweenService (upval), LightVsDarkCutsceneEndRigs (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CutsceneMusic (val)
            -- upvalues: CurrentCamera (upval), LocalPlayer (upval), u17 (val), BulkFade (upval)
            -- upvalues: restoreAllGuardsAndNests (upval), u99 (upval), u100 (upval), u101 (upval)
            local DarkWinAnimation, DarkWinAnimation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 577 -- upvalues: u0 (ref), restoreAllUi (upval), u79 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u79
                    u79 = nil
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
            pcall(function() -- Line: 585 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 587 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            hideAllGuardsAndNests(a1)
            hideZone12(a1)
            local u24 = {}
            for i, j in script.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(j.Name) then
                    v1 = j:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u24, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            a1:Add(function() -- Line: 612 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u58 = ReplicatedStorage.CutsceneAssets.LightVSDarkness.LightVSDarkCutsceneEnd:Clone()
            u58.Parent = Workspace
            u16 = u58
            a1:Add(u58)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 623 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            local u85 = LightVsDarkCutsceneEndRigs:Clone()
            for k, n in u85:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            u85.Parent = workspace
            a1:Add(u85)
            local v2 = {}
            for m, i5 in u85:GetChildren() do
                DarkWinAnimation_2 = i5:FindFirstChild("DarkWinAnimation")
                if DarkWinAnimation_2 then
                    table.insert(v2, DarkWinAnimation_2)
                end
            end
            ContentProvider:PreloadAsync(v2)
            local u124 = {}
            for i6, i7 in u85:GetChildren() do
                DarkWinAnimation = i7:FindFirstChild("DarkWinAnimation")
                if DarkWinAnimation then
                    u124[i7] = (LoadAnimationIntoRig(i7, DarkWinAnimation.AnimationId))
                end
            end
            local u138 = true
            a1:Add(function() -- Line: 658 -- upvalues: u138 (ref)
                u138 = false
            end)
            a1:Add(function() -- Line: 659 -- upvalues: u138 (ref), restoreCamera (upval)
                if not u138 then
                    return
                end
                restoreCamera()
            end)
            for i8, i9 in u124 do
                i9:Play(0)
            end
            local v3 = u124[u85["Camera Rig"]]
            assert(v3, "Camera Rig needs an Animation")
            v1 = os.clock() + 2
            while u138 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            CutsceneMusic:Play()
            local Cam = u85["Camera Rig"].Cam
            local u192 = nil
            RunService.RenderStepped:Connect(function() -- Line: 686 -- upvalues: u138 (ref), u192 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u138 then
                    u192:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u201 = {}
            local u202 = 0
            local u203 = 0.1
            local v4 = RunService.Heartbeat:Connect(function(a1) -- Line: 700
                -- upvalues: u202 (ref), u203 (ref), u124 (val), CutsceneMusic (upval), u17 (upval), u201 (val)
                local v1
                u202 = u202 + a1
                u203 = u203 - 0.1
                if u203 <= 0 then
                    u203 = 0.1
                    for i, j in u124 do
                        if j.IsPlaying and 0.1 <= (math.abs(u202 - j.TimePosition)) then
                            xpcall(function() -- Line: 712 -- upvalues: j (val), u202 (upval)
                                j.TimePosition = u202
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u202 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u202 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u202 * 60 - k)
                    if u17[v1] and not u201[v1] then
                        u201[v1] = true
                        for n, m in u17[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v4)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(26.983333333333334)
            v4:Disconnect()
            xpcall(function() -- Line: 744 -- upvalues: u58 (val)
                u58:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 750 -- upvalues: u24 (val)
                for i, j in u24 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 756 -- upvalues: u85 (val)
                u85:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            local u267 = BulkFade.new(CutsceneUI.SammyIsComing, TweenInfo.new(1))
            u267:FadeOutInstant()
            task.wait()
            u267:FadeIn()
            CutsceneUI.SammyIsComing.Visible = true
            task.spawn(function() -- Line: 766 -- upvalues: CutsceneUI (upval)
                local function toDHMS(a1) -- Line: 767 -- types: a1: number
                    return string.format("%02i:%02i:%02i:%02i", a1 / 86400, a1 / 3600 % 24, a1 / 60 % 60, a1 % 60)
                end

                local v1 = 604799
                while CutsceneUI.SammyIsComing.Visible do
                    CutsceneUI.SammyIsComing.TimeRemaining.Text = string.format("%02i:%02i:%02i:%02i", v1 / 86400, v1 / 3600 % 24, v1 / 60 % 60, v1 % 60)
                    script.ClockTick:Play()
                    task.wait(1)
                    v1 = v1 - 1
                end
            end)
            task.wait(5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            u267:FadeOut()
            task.wait(0.5)
            task.delay(1, function() -- Line: 794 -- upvalues: CutsceneUI (upval), u267 (val)
                CutsceneUI.SammyIsComing.Visible = false
                u267:FadeIn()
            end)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 802 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 806 -- upvalues: restoreAllUi (upval), u79 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u79
                u79 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                u0 = true
            end, warn)
            restoreAllGuardsAndNests()
            if u99 then
                u99.Parent = game.Workspace.World.Build.Props
            end
            if u100 then
                u100.Parent = game.Workspace.World.Areas.LightDark
            end
            if u101 then
                u101.Parent = game.Workspace.World.Build
            end
        end,
    }
end