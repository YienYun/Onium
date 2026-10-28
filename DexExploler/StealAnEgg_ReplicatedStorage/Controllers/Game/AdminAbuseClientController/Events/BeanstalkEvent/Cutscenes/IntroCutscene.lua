-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Cutscenes.IntroCutscene
-- Decompile time: 18.54 ms

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
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local IntroCutscene = ReplicatedStorage.CutsceneAssets.BeanstalkEventCutsceneAssets.IntroCutscene
local u73 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local u79 = {"Sky", "Atmosphere"}
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u84 = nil
local u85 = nil
local u86 = nil
local u87 = nil
local u88 = {}

local function restoreCamera() -- Line: 56 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 65
    -- upvalues: u85 (ref), u86 (ref), Tabs (val), LocalPlayer (val), u73 (val), StarterGui (val), u87 (ref)
    if u85 ~= nil then
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
    u85 = v1
    pcall(function() -- Line: 80 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u73 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u87 = v1
end

local function restoreAllUi() -- Line: 90
    -- upvalues: u85 (ref), u86 (ref), LocalPlayer (val), u87 (ref), StarterGui (val)
    local v1 = u85
    local v2 = u86
    u85 = nil
    u86 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 103 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u87
    u87 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 115 -- upvalues: u84 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u84 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 122 -- upvalues: restoreAllUi (val), u84 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u84
    u84 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 134 -- types: a1: table, a2: number?
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

local function restoreGuard(a1, a2) -- Line: 147 -- upvalues: u88 (val) -- types: a1: userdata, a2: userdata
    u88[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 156 -- upvalues: u88 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u88[Guard] = j
        Guard.Parent = nil
        local Nests = j:FindFirstChild("Nests")
        local Descendants = Nests
        if Descendants then
            Descendants = Nests:GetDescendants()
        end
        if Descendants then
            setTransparency(Descendants, 1)
        end
        v4:Add(function() -- Line: 170
            -- upvalues: Guard (val), j (val), u88 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u88[v1] = nil
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

local function setEmitting(a1, a2) -- Line: 179 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emitBurst(a1) -- Line: 188 -- types: a1: userdata
    local Attribute_3
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")
            task.delay(if type(Attribute_3) ~= "number" then 0 else Attribute_3, function() -- Line: 197 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute ~= 0 then
                    j:Emit(Attribute)
                end
                if type(Attribute_2) == "number" and Attribute_2 ~= 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 203 -- upvalues: j (upval)
                        j.Enabled = false
                    end)
                end
            end)
        end
    end
end

return function(a1) -- Line: 213
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), emitBurst (val), setEmitting (val)
    -- upvalues: hideCutsceneUi (val), restoreCutsceneUi (val), Workspace (val), ReplicatedStorage (val)
    -- upvalues: hideAllGuardsAndNests (val), LightingController (val), u79 (val), Lighting (val), IntroCutscene (val)
    -- upvalues: SoundService (val), TweenService (val), ContentProvider (val), restoreCamera (val), RunService (val)
    -- upvalues: CurrentCamera (val)
    local u3 = a1:Extend()
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(u3)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u16 = nil
    local u17 = {}
    u17[0] = {
        SetProperty("Workspace.CurrentCamera.FieldOfView", 45),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 1),
        SetProperty("Lighting.CutsceneBlur.Enabled", true),
        SetProperty("Lighting.CutsceneBlur.Size", 15),
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.65, Enum.EasingStyle.Linear), 2),
        SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(0, 0, 0)),
        TweenProperty(
            "PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(4.8, Enum.EasingStyle.Linear),
            Color3.new(1, 0.702146, 0.282353)
        ),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
        SetProperty("Lighting.ColorCorrection.TintColor", Color3.new(1, 0.913726, 0.917647)),
        SetProperty("Lighting.ColorCorrection.Brightness", 0.05),
        SetProperty("Lighting.ColorCorrection.Saturation", 0.3),
        SetProperty("Lighting.ColorCorrection.Contrast", 0.3),
        SetProperty("Lighting.Close.Enabled", false),
        SetProperty("Lighting.Close.FarIntensity", 0.75),
        TweenProperty("Lighting.Close.FarIntensity", TweenInfo.new(24.016666666666666, Enum.EasingStyle.Linear), 0.63),
        SetProperty("Lighting.Close.FocusDistance", 14),
        TweenProperty("Lighting.Close.FocusDistance", TweenInfo.new(24.016666666666666, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Close.InFocusRadius", 0),
        TweenProperty("Lighting.Close.InFocusRadius", TweenInfo.new(24.016666666666666, Enum.EasingStyle.Linear), 13.5),
        SetProperty("Lighting.Close.NearIntensity", 0),
        (SetProperty("Workspace.BeanstalkIntroVFX.Water.CFrame", CFrame.new(6956.6724, 53.7656, 1633.7804, 1, 0, 0, 0, 1, 0, 0, 0, 1))),
    }
    u17[57] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            25
        )),
    }
    u17[58] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 12)),
    }
    u17[69] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 2)),
    }
    u17[288] = {
        TweenProperty(
            "PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(0.15, Enum.EasingStyle.Linear),
            Color3.new(1, 0.808247, 0.47451)
        ),
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 0.2),
        TweenProperty(
            "Lighting.ColorCorrection.TintColor",
            TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear),
            Color3.new(1, 0.976241, 0.705882)
        ),
        TweenProperty("Lighting.ColorCorrection.Saturation", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 0.5),
        (TweenProperty("Lighting.ColorCorrection.Contrast", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 1)),
    }
    u17[297] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.3166666666666667, Enum.EasingStyle.Linear), 0.2)),
    }
    u17[376] = {
        TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            35
        ),
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1),
        TweenProperty(
            "Lighting.ColorCorrection.TintColor",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            Color3.new(1, 0.913726, 0.917647)
        ),
        TweenProperty("Lighting.ColorCorrection.Saturation", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.3),
        (TweenProperty("Lighting.ColorCorrection.Contrast", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.3)),
    }
    u17[669] = {
        TweenProperty(
            "Lighting.ColorCorrection.TintColor",
            TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear),
            Color3.new(1, 0.639216, 0.922617)
        ),
        TweenProperty("Lighting.ColorCorrection.Brightness", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 0.2),
        TweenProperty("Lighting.ColorCorrection.Saturation", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 0.4),
        (TweenProperty("Lighting.ColorCorrection.Contrast", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 0.8)),
    }
    u17[726] = {
        TweenProperty(
            "Lighting.ColorCorrection.TintColor",
            TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear),
            Color3.new(1, 0.913726, 0.917647)
        ),
        TweenProperty("Lighting.ColorCorrection.Brightness", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0.05),
        TweenProperty("Lighting.ColorCorrection.Saturation", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0.3),
        (TweenProperty("Lighting.ColorCorrection.Contrast", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0.3)),
    }
    u17[884] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            30
        )),
    }
    u17[885] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(1.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            31.52174
        )),
    }
    u17[990] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 20)),
    }
    u17[991] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Sine), 35)),
    }
    u17[1002] = {
        function() -- Line: 315 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.GroundCrack)
        end,
    }
    u17[1090] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 45)),
    }
    u17[1107] = {
        function() -- Line: 325 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.GroundCrack3)
        end,
    }
    u17[1219] = {
        function() -- Line: 331 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.GroundCrack2)
        end,
    }
    u17[1230] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 30)),
    }
    u17[1241] = {
        function() -- Line: 341 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.Water, true)
        end,
    }
    local v2 = {}
    local v3 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 10)
    local v4 = TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear)

    v2[1] = function() -- Line: 347 -- upvalues: emitBurst (upval), u16 (ref)
        emitBurst(u16.GroundCrack4)
    end

    v2[2] = v3
    v2[3] = TweenProperty("Workspace.BeanstalkIntroVFX.Water.CFrame", v4, CFrame.new(6956.6724, 77.0232, 1632.0439, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    u17[1269] = v2
    u17[1274] = {
        function() -- Line: 355 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Break)
        end,
    }
    u17[1276] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.2833333333333334, Enum.EasingStyle.Linear), 4)),
    }
    u17[1282] = {
        (TweenProperty(
            "Workspace.BeanstalkIntroVFX.Water.CFrame",
            TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear),
            CFrame.new(6956.6724, 96.4883, 1632.0439, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u17[1299] = {
        (TweenProperty(
            "Workspace.BeanstalkIntroVFX.Water.CFrame",
            TweenInfo.new(1.1666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(6956.6724, 174.3108, 1632.0439, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u17[1369] = {
        function() -- Line: 373 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.Water, false)
        end,
    }
    u17[1440] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine), 50),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2)),
    }
    u17[1441] = {SetProperty("Lighting.Close.Enabled", true)}
    u17[1457] = {
        (TweenProperty("Lighting.Close.InFocusRadius", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 10)),
    }
    u17[1484] = {
        (TweenProperty("Lighting.Close.InFocusRadius", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 75)),
    }
    u17[1605] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 401
            -- upvalues: hideCutsceneUi (upval), u3 (val), restoreCutsceneUi (upval), Workspace (upval)
            -- upvalues: ReplicatedStorage (upval), hideAllGuardsAndNests (upval), LightingController (upval)
            -- upvalues: u79 (upval), Lighting (upval), IntroCutscene (upval), CutsceneUI (val), Black (val)
            -- upvalues: Vignette (val), a1 (val), u16 (ref), SoundService (upval), TweenService (upval)
            -- upvalues: ContentProvider (upval), LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval)
            -- upvalues: CurrentCamera (upval), LocalPlayer (upval), u17 (val)
            local Animation, v1
            xpcall(hideCutsceneUi, warn)
            u3:Add(restoreCutsceneUi)
            local AreaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
            if AreaEggSlotsClient ~= nil then
                AreaEggSlotsClient.Parent = ReplicatedStorage
                u3:Add(function() -- Line: 408 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end
            hideAllGuardsAndNests(u3)
            LightingController.Settle()
            for i, j in u79 do
                local u332 = Lighting:FindFirstChildOfClass(j)
                if u332 ~= nil then
                    u332.Parent = nil
                    u3:Add(function() -- Line: 422 -- upvalues: u332 (val), Lighting (upval)
                        u332.Parent = Lighting
                    end)
                end
            end
            u3:Add(function() -- Line: 426 -- upvalues: LightingController (upval)
                LightingController.Settle()
            end)
            for k, n in IntroCutscene.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(n.Name) then
                    v1 = n:Clone()
                    v1.Parent = Lighting
                    u3:Add(v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            u3:Add(function() -- Line: 442 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
                Vignette.ImageColor3 = Color3.new(0, 0, 0)
            end)
            a1:Add(function() -- Line: 448 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local v2 = IntroCutscene.BeanstalkIntroVFX:Clone()
            v2.Parent = Workspace
            u16 = v2
            u3:Add(v2)
            v2 = IntroCutscene.BeanstalkIntroWorkspaceAssets:Clone()
            v2.Parent = Workspace
            u3:Add(v2)
            local u99 = IntroCutscene.CutsceneMusic:Clone()
            u99.Parent = SoundService
            u3:Add(u99)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            local v3 = IntroCutscene.BeanstalkIntroRigs:Clone()
            u3:Add(v3)
            for m, i5 in v3:GetChildren() do
                if i5:IsA("Model") and i5.PrimaryPart then
                    i5.PrimaryPart.Anchored = true
                end
            end
            v3.Parent = Workspace
            local v4 = {}
            for i6, i7 in v3:GetChildren() do
                table.insert(v4, (i7:FindFirstChild("Animation")))
            end
            ContentProvider:PreloadAsync(v4)
            local u161 = {}
            for i8, i9 in v3:GetChildren() do
                Animation = i9:FindFirstChild("Animation")
                u161[i9] = (LoadAnimationIntoRig(i9, Animation.AnimationId))
            end
            local u175 = true
            u3:Add(function() -- Line: 492 -- upvalues: u175 (ref), restoreCamera (upval)
                u175 = false
                restoreCamera()
            end)
            for i10, i11 in u161 do
                i11:Play(0)
            end
            local v5 = u161[v3.CameraRig]
            v1 = os.clock() + 2
            while u175 do
                if not (v5.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u99:Play()
            local Cam = v3.CameraRig.Cam
            u3:Connect(RunService.RenderStepped, function() -- Line: 514 -- upvalues: u175 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u175 then
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u230 = {}
            local u231 = 0
            local u232 = 0.1
            v3 = u3:Connect(RunService.Heartbeat, function(a1) -- Line: 527
                -- upvalues: u231 (ref), u232 (ref), u161 (val), u99 (val), u17 (upval), u230 (val)
                local v1
                u231 = u231 + a1
                u232 = u232 - 0.1
                if u232 <= 0 then
                    u232 = 0.1
                    for i, j in u161 do
                        if j.IsPlaying and 0.4 <= (math.abs(u231 - j.TimePosition)) then
                            xpcall(function() -- Line: 539 -- upvalues: j (val), u231 (upval)
                                j.TimePosition = u231
                            end, warn)
                        end
                    end
                end
                if not (u99.TimePosition < u231 - 0.001) then
                    local TimePosition_2 = u99.TimePosition
                    if not (u231 + 0.001 < TimePosition_2) then
                        u99.PlaybackSpeed = 1
                    else
                        u99.PlaybackSpeed = 0.99
                    end
                else
                    u99.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u231 * 60 - k)
                    if u17[v1] and not u230[v1] then
                        u230[v1] = true
                        for n, m in u17[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(27.5)
            v3:Disconnect()
            Black.BackgroundTransparency = 0
            u3:Clean()
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
        end,
    }
end