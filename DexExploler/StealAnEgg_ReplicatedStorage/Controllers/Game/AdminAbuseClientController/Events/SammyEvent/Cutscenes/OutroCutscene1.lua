-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent.Cutscenes.OutroCutscene1
-- Decompile time: 20.29 ms

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
local SammyEventOutro1Rigs = ReplicatedStorage.CutsceneAssets.SammyEvent.SammyEventOutro1Rigs
local SammyEventOutro1VFX = ReplicatedStorage.CutsceneAssets.SammyEvent.SammyEventOutro1VFX
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
    -- upvalues: SammyEventOutro1VFX (val), TweenService (val), SammyEventOutro1Rigs (val), ContentProvider (val)
    -- upvalues: restoreCamera (val), RunService (val), CurrentCamera (val), restoreAllGuardsAndNests (val)
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
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy Hat Rig.CFrame", CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)),
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(9.131, 16.6001, -21.2199, -0.4348, 0.101, -0.8948, -0, 0.9937, 0.1121, 0.9005, 0.0487, -0.4321)
        ),
        SetProperty("Workspace.CurrentCamera.FieldOfView", 30),
        SetProperty(
            "Workspace.SammyEventOutro1Rigs.ChatBubbleRig.CFrame",
            CFrame.new(0, 0, 0, 0.9942, 0, 0.1073, 0, 1, 0, -0.1073, 0, 0.9942)
        ),
        SetProperty("Workspace.SammyEventOutro1Rigs.Mind Control Hat Rig.RegularHelm.Transparency", 0),
        SetProperty("Workspace.SammyEventOutro1Rigs.Mind Control Hat Rig.BrokenHelm.Transparency", 1),
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Transparency", 0),
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Color3", Color3.new(1, 1, 1)),
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Texture", "rbxassetid://104450394167021"),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(0, 0, 0)),
        TweenProperty(
            "PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(12.433333333333334, Enum.EasingStyle.Linear),
            Color3.new(0.345098, 0.67711, 1)
        ),
        SetProperty("PlayerGui.CutsceneUI.Vignette.BackgroundColor3", Color3.new(1, 1, 1)),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.8833333333333333, Enum.EasingStyle.Linear), 1),
        SetProperty("Lighting.CutsceneBlur.Enabled", true),
        SetProperty("Lighting.CutsceneBlur.Size", 20),
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.2333333333333334, Enum.EasingStyle.Linear), 2),
        SetProperty("Lighting.CutBlue.Enabled", false),
        SetProperty("Lighting.CutBlue.Saturation", -3),
        TweenProperty("Lighting.CutBlue.Saturation", TweenInfo.new(13.833333333333334, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.CutBlue.Contrast", -3),
        TweenProperty("Lighting.CutBlue.Contrast", TweenInfo.new(13.833333333333334, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.CutBlue.TintColor", Color3.new(0.835294, 0.937255, 1)),
        TweenProperty("Lighting.CutBlue.TintColor", TweenInfo.new(13.833333333333334, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        SetProperty("Lighting.CutBlue.Brightness", 0.3),
        (TweenProperty("Lighting.CutBlue.Brightness", TweenInfo.new(13.833333333333334, Enum.EasingStyle.Linear), 0)),
    }
    u19[498] = {
        function() -- Line: 235 -- upvalues: u16 (ref)
            for k, v in pairs(u16.ChargingMachine1.Beams.Beams1.Charge:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u19[503] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.0166666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u19[564] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.4166666666666667, Enum.EasingStyle.Linear), 4)),
    }
    u19[765] = {
        (TweenProperty(
            "Workspace.SammyEventOutro1Rigs.ChatBubbleRig.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(0, -506.1769, 0, 0.9942, 0, 0.1073, 0, 1, 0, -0.1073, 0, 0.9942)
        )),
    }
    u19[782] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.9833333333333333, Enum.EasingStyle.Linear), 0)),
    }
    u19[830] = {
        SetProperty("Lighting.CutBlue.Enabled", true),
        TweenProperty("Lighting.CutBlue.Saturation", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), -3),
        TweenProperty("Lighting.CutBlue.Contrast", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), -3),
        TweenProperty(
            "Lighting.CutBlue.TintColor",
            TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear),
            Color3.new(0.835294, 0.937255, 1)
        ),
        (TweenProperty("Lighting.CutBlue.Brightness", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), 0.3)),
    }
    u19[832] = {
        TweenProperty("Lighting.CutBlue.Saturation", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.CutBlue.Contrast", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.CutBlue.TintColor", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        (TweenProperty("Lighting.CutBlue.Brightness", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 0)),
    }
    u19[834] = {
        function() -- Line: 275 -- upvalues: u16 (ref)
            for k, v in pairs(u16.ChargingMachine1.Beams:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u19[836] = {SetProperty("Lighting.CutBlue.Enabled", false)}
    u19[925] = {
        function() -- Line: 288 -- upvalues: u16 (ref)
            for k, v in pairs(u16.ChargingMachine1.Beams.Beams1:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u19[937] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 15)),
    }
    u19[942] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear), 1)),
    }
    u19[945] = {
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Texture", "rbxassetid://104450394167021 "),
    }
    u19[946] = {
        TweenProperty(
            "Workspace.SammyEventOutro1Rigs.Mind Control Hat Rig.RegularHelm.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            1
        ),
        (TweenProperty(
            "Workspace.SammyEventOutro1Rigs.Mind Control Hat Rig.BrokenHelm.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            0
        )),
    }
    u19[950] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.1, Enum.EasingStyle.Linear), 4)),
    }
    u19[954] = {
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Texture", "rbxassetid://1077395150"),
    }
    u19[972] = {
        (TweenProperty(
            "Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Color3",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u19[973] = {
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Texture", "rbxassetid://11389379146"),
    }
    u19[975] = {
        function() -- Line: 330 -- upvalues: u16 (ref)
            for k, v in pairs(u16.ChargingMachine1.Beams:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u19[986] = {
        function() -- Line: 339 -- upvalues: u16 (ref)
            local Attribute, Attribute_2, v1
            local Smoke = u16.Smoke

            local function check(a1) -- Line: 342 -- types: a1: number?
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
                        task.delay(Attribute_2, function() -- Line: 357 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u19[1128] = {
        (TweenProperty(
            "Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Color3",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(1, 1, 1)
        )),
    }
    u19[1129] = {
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Texture", "rbxassetid://103446416975797 "),
    }
    u19[1366] = {
        SetProperty("Workspace.SammyEventOutro1Rigs.Sammy.head.Handle.SammyFace.Texture", "rbxassetid://12637990841 "),
    }
    u19[1452] = {
        (TweenProperty(
            "Workspace.SammyEventOutro1Rigs.Sammy Hat Rig.CFrame",
            TweenInfo.new(0.05, Enum.EasingStyle.Linear),
            CFrame.new(0, 0, 0.1, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u19[1590] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.5, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 387
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u82 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval), Lighting (upval)
            -- upvalues: CutsceneUI (val), Black (val), Vignette (val), SammyEventOutro1VFX (upval), u16 (ref)
            -- upvalues: TweenService (upval), u17 (ref), SammyEventOutro1Rigs (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CutsceneMusic (val)
            -- upvalues: u18 (ref), CurrentCamera (upval), LocalPlayer (upval), u19 (val)
            -- upvalues: restoreAllGuardsAndNests (upval)
            local Animation, Animation_2, Animation_3, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 392 -- upvalues: u0 (ref), restoreAllUi (upval), u82 (upval), Tabs (upval)
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
            pcall(function() -- Line: 400 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 402 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
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
            a1:Add(function() -- Line: 426 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u52 = SammyEventOutro1VFX:Clone()
            u52.Parent = Workspace
            a1:Add(u52)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 437 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            u17 = SammyEventOutro1Rigs:Clone()
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
            a1:Add(function() -- Line: 481 -- upvalues: u147 (ref)
                u147 = false
            end)
            a1:Add(function() -- Line: 482 -- upvalues: u147 (ref), restoreCamera (upval)
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
            RunService.RenderStepped:Connect(function() -- Line: 509 -- upvalues: u147 (ref), u200 (ref), CurrentCamera (upval), LocalPlayer (upval), u18 (upval)
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
            v3 = RunService.Heartbeat:Connect(function(a1) -- Line: 523
                -- upvalues: u210 (ref), u211 (ref), u120 (val), CutsceneMusic (upval), u19 (upval), u209 (val)
                local v1
                u210 = u210 + a1
                u211 = u211 - 0.1
                if u211 <= 0 then
                    u211 = 0.1
                    for i, j in u120 do
                        if j.IsPlaying and 0.1 <= (math.abs(u210 - j.TimePosition)) then
                            xpcall(function() -- Line: 535 -- upvalues: j (val), u210 (upval)
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
            task.wait(27.833333333333332)
            v3:Disconnect()
            xpcall(function() -- Line: 567 -- upvalues: u52 (val)
                u52:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 573 -- upvalues: u21 (val)
                for i, j in u21 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 579 -- upvalues: u17 (upval)
                u17:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            task.wait(0.5)
            Vignette.Visible = false
            pcall(function() -- Line: 591 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 595 -- upvalues: restoreAllUi (upval), u82 (upval), Tabs (upval), u0 (ref)
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