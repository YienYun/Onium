-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Cutscenes.IntroCutscene2
-- Decompile time: 15.42 ms

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
local IntroCutscene2 = ReplicatedStorage.CutsceneAssets.ScrambleBossCutsceneAssets.IntroCutscene2
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

local function restoreCamera() -- Line: 48 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 58
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
    pcall(function() -- Line: 73 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u68 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u79 = v1
end

local function restoreAllUi() -- Line: 83
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
    pcall(function() -- Line: 96 -- upvalues: LocalPlayer (upval)
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

local function hideCutsceneUi() -- Line: 108 -- upvalues: u76 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u76 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 115 -- upvalues: restoreAllUi (val), u76 (ref), Tabs (val)
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

local function restoreGuard(a1, a2) -- Line: 140 -- upvalues: u80 (val) -- types: a1: userdata, a2: userdata
    u80[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 149 -- upvalues: u80 (val), setTransparency (val)
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
        v4:Add(function() -- Line: 163
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

local function restoreAllGuardsAndNests() -- Line: 172 -- upvalues: u80 (val), setTransparency (val)
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

return function(a1) -- Line: 186
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), hideCutsceneUi (val), restoreAllUi (val), u76 (ref)
    -- upvalues: Tabs (val), Workspace (val), ReplicatedStorage (val), hideAllGuardsAndNests (val), IntroCutscene2 (val)
    -- upvalues: Lighting (val), SoundService (val), TweenService (val), ContentProvider (val), restoreCamera (val)
    -- upvalues: RunService (val), CurrentCamera (val), restoreAllGuardsAndNests (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u13 = {}
    u13[0] = {
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(106.2726, 5.5588, 56.7516, 0.2516, -0.278, 0.927, -0, 0.9579, 0.2872, -0.9678, -0.0723, 0.241)
        ),
        SetProperty("Workspace.CurrentCamera.FieldOfView", 61.55506),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 1),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", Color3.new(0, 0, 0)),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
        SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true),
        SetProperty("Lighting.CutsceneBlur.Enabled", true),
        SetProperty("Lighting.CutsceneBlur.Size", 2),
        SetProperty("Lighting.DepthOfField.Enabled", true),
        SetProperty("Lighting.DepthOfField.FarIntensity", 1),
        SetProperty("Lighting.DepthOfField.FocusDistance", 0.05),
        SetProperty("Lighting.DepthOfField.InFocusRadius", 8),
        (SetProperty("Lighting.DepthOfField.NearIntensity", 0)),
    }
    u13[61] = {
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear),
            Color3.new(1, 1, 1)
        )),
    }
    u13[67] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 15)),
    }
    u13[69] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 0)),
    }
    u13[77] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.35, Enum.EasingStyle.Linear), 0)),
    }
    u13[86] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.5, Enum.EasingStyle.Linear), 1)),
    }
    u13[98] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear), 1)),
    }
    u13[109] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 7)),
    }
    u13[138] = {
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(6.016666666666667, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u13[178] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.4833333333333334, Enum.EasingStyle.Linear), 0)),
    }
    u13[193] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Linear), 12)),
    }
    u13[268] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.9833333333333333, Enum.EasingStyle.Linear), 4)),
    }
    u13[425] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.5, Enum.EasingStyle.Linear), 1)),
    }
    u13[453] = {
        TweenProperty("Lighting.DepthOfField.FocusDistance", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 28),
        TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 9.5),
        (TweenProperty("Lighting.DepthOfField.NearIntensity", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 0.05)),
    }
    u13[503] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 20)),
    }
    u13[508] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 279
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u76 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval)
            -- upvalues: IntroCutscene2 (upval), Lighting (upval), CutsceneUI (val), Black (val), Vignette (val)
            -- upvalues: SoundService (upval), TweenService (upval), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CurrentCamera (upval), LocalPlayer (upval)
            -- upvalues: u13 (val), restoreAllGuardsAndNests (upval)
            local Animation, Animation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 284 -- upvalues: u0 (ref), restoreAllUi (upval), u76 (upval), Tabs (upval)
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
            pcall(function() -- Line: 292 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 294 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            hideAllGuardsAndNests(a1)
            local u21 = {}
            for i, j in IntroCutscene2.LightingAssets:GetChildren() do
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
            a1:Add(function() -- Line: 318 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u53 = IntroCutscene2.ScrambleBossIntro2VFX:Clone()
            u53.Parent = Workspace
            a1:Add(u53)
            local u64 = IntroCutscene2.ScrambleBossIntro2WorkspaceAssets:Clone()
            u64.Parent = Workspace
            a1:Add(u64)
            local u75 = IntroCutscene2.CutsceneMusic:Clone()
            u75.Parent = SoundService
            a1:Add(u75)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 336 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local u103 = IntroCutscene2.ScrambleBossIntro2Rigs:Clone()
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
            a1:Add(function() -- Line: 372 -- upvalues: u156 (ref)
                u156 = false
            end)
            a1:Add(function() -- Line: 373 -- upvalues: u156 (ref), restoreCamera (upval)
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
            RunService.RenderStepped:Connect(function() -- Line: 399 -- upvalues: u156 (ref), u212 (ref), CurrentCamera (upval), LocalPlayer (upval), Torso (val)
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
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 413 -- upvalues: u222 (ref), u223 (ref), u142 (val), u75 (val), u13 (upval), u221 (val)
                local v1
                u222 = u222 + a1
                u223 = u223 - 0.1
                if u223 <= 0 then
                    u223 = 0.1
                    for i, j in u142 do
                        if j.IsPlaying and 0.4 <= (math.abs(u222 - j.TimePosition)) then
                            xpcall(function() -- Line: 425 -- upvalues: j (val), u222 (upval)
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
                    if u13[v1] and not u221[v1] then
                        u221[v1] = true
                        for n, m in u13[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(9.366666666666667)
            v5:Disconnect()
            xpcall(function() -- Line: 457 -- upvalues: u53 (val)
                u53:Destroy()
            end, warn)
            xpcall(function() -- Line: 458 -- upvalues: u64 (val)
                u64:Destroy()
            end, warn)
            xpcall(function() -- Line: 459 -- upvalues: u75 (val)
                u75:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 465 -- upvalues: u21 (val)
                for i, j in u21 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 471 -- upvalues: u103 (val)
                u103:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 482 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 486 -- upvalues: restoreAllUi (upval), u76 (upval), Tabs (upval), u0 (ref)
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