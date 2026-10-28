-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent.Cutscenes.OutroCutscene2
-- Decompile time: 15.24 ms

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
local SammyEventOutro2Rigs = ReplicatedStorage.CutsceneAssets.SammyEvent.SammyEventOutro2Rigs
local SammyEventOutro2VFX = ReplicatedStorage.CutsceneAssets.SammyEvent.SammyEventOutro2VFX
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
    -- upvalues: SammyEventOutro2VFX (val), TweenService (val), SammyEventOutro2Rigs (val), ContentProvider (val)
    -- upvalues: restoreCamera (val), RunService (val), CurrentCamera (val), BulkFade (val)
    -- upvalues: restoreAllGuardsAndNests (val)
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
    u19[0] = {
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(9.131, 16.6001, -21.2199, -0.4348, 0.101, -0.8948, -0, 0.9937, 0.1121, 0.9005, 0.0487, -0.4321)
        ),
        SetProperty("Workspace.CurrentCamera.FieldOfView", 25),
        SetProperty("Lighting.CutsceneDepthOfField.Enabled", true),
        SetProperty("Lighting.CutsceneDepthOfField.InFocusRadius", 10),
        SetProperty("Lighting.CutsceneDepthOfField.FocusDistance", 0.05),
        SetProperty("Workspace.SammyEventOutro2Rigs.Mind Control Hat Rig.BrokenHelm.Transparency", 0),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 1),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
        (SetProperty("Lighting.ClockTime", 2.3)),
    }
    u19[528] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0)),
    }
    u19[543] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 227
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u82 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval), Lighting (upval)
            -- upvalues: CutsceneUI (val), Black (val), Vignette (val), SammyEventOutro2VFX (upval), u16 (ref)
            -- upvalues: TweenService (upval), u17 (ref), SammyEventOutro2Rigs (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CutsceneMusic (val)
            -- upvalues: u18 (ref), CurrentCamera (upval), LocalPlayer (upval), u19 (val), BulkFade (upval)
            -- upvalues: restoreAllGuardsAndNests (upval)
            local Animation, Animation_2, Animation_3, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 232 -- upvalues: u0 (ref), restoreAllUi (upval), u82 (upval), Tabs (upval)
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
            pcall(function() -- Line: 240 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 242 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
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
            a1:Add(function() -- Line: 266 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u52 = SammyEventOutro2VFX:Clone()
            u52.Parent = Workspace
            a1:Add(u52)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 277 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            u17 = SammyEventOutro2Rigs:Clone()
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
            a1:Add(function() -- Line: 321 -- upvalues: u147 (ref)
                u147 = false
            end)
            a1:Add(function() -- Line: 322 -- upvalues: u147 (ref), restoreCamera (upval)
                if not u147 then
                    return
                end
                restoreCamera()
            end)
            for i10, i11 in u120 do
                i11:Play(0)
            end
            local v3 = u120[u17.HumanoidCameraRig]
            assert(v3, "HumanoidCameraRig needs an Animation")
            local v4 = os.clock() + 2
            while u147 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v4) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            CutsceneMusic:Play()
            u18 = u17.HumanoidCameraRig.Torso
            local u200 = nil
            RunService.RenderStepped:Connect(function() -- Line: 349 -- upvalues: u147 (ref), u200 (ref), CurrentCamera (upval), LocalPlayer (upval), u18 (upval)
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
            v3 = RunService.Heartbeat:Connect(function(a1) -- Line: 363
                -- upvalues: u210 (ref), u211 (ref), u120 (val), CutsceneMusic (upval), u19 (upval), u209 (val)
                local v1
                u210 = u210 + a1
                u211 = u211 - 0.1
                if u211 <= 0 then
                    u211 = 0.1
                    for i, j in u120 do
                        if j.IsPlaying and 0.1 <= (math.abs(u210 - j.TimePosition)) then
                            xpcall(function() -- Line: 375 -- upvalues: j (val), u210 (upval)
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
            task.wait(9.616666666666667)
            v3:Disconnect()
            xpcall(function() -- Line: 407 -- upvalues: u52 (val)
                u52:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 413 -- upvalues: u21 (val)
                for i, j in u21 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 419 -- upvalues: u17 (upval)
                u17:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            local u277 = BulkFade.new(CutsceneUI.ToBeContinued, TweenInfo.new(1))
            u277:FadeOutInstant()
            task.wait()
            u277:FadeIn()
            CutsceneUI.ToBeContinued.Visible = true
            task.spawn(function() -- Line: 430 -- upvalues: CutsceneUI (upval)
                local function toDHMS(a1) -- Line: 431 -- types: a1: number
                    return string.format("%02i:%02i:%02i:%02i", a1 / 86400, a1 / 3600 % 24, a1 / 60 % 60, a1 % 60)
                end

                local v1 = 604799
                while CutsceneUI.ToBeContinued.Visible do
                    CutsceneUI.ToBeContinued.TimeRemaining.Text = string.format("%02i:%02i:%02i:%02i", v1 / 86400, v1 / 3600 % 24, v1 / 60 % 60, v1 % 60)
                    script.ClockTick:Play()
                    task.wait(1)
                    v1 = v1 - 1
                end
            end)
            task.wait(5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            u277:FadeOut()
            task.delay(1, function() -- Line: 456 -- upvalues: CutsceneUI (upval), u277 (val)
                CutsceneUI.ToBeContinued.Visible = false
                u277:FadeIn()
            end)
            Lighting.ClockTime = 11.6
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 468 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 472 -- upvalues: restoreAllUi (upval), u82 (upval), Tabs (upval), u0 (ref)
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
            restoreAllGuardsAndNests()
        end,
    }
end