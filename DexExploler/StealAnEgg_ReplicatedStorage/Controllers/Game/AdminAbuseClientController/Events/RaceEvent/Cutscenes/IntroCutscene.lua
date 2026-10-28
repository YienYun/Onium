-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RaceEvent.Cutscenes.IntroCutscene
-- Decompile time: 18.93 ms

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
local MountRace = require(ReplicatedStorage.Data.MountRace)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local IntroCutscene = ReplicatedStorage.CutsceneAssets.RaceEventCutsceneAssets.IntroCutscene
local u76 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u84 = nil
local u85 = nil
local u86 = nil
local u87 = nil

local function onTrack(a1) -- Line: 60 -- types: a1: userdata
    return a1 + Vector3.new(-4009, 0, 9397)
end

local function restoreCamera() -- Line: 64 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 73
    -- upvalues: u85 (ref), u86 (ref), Tabs (val), LocalPlayer (val), u76 (val), StarterGui (val), u87 (ref)
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
    pcall(function() -- Line: 88 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u76 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u87 = v1
end

local function restoreAllUi() -- Line: 98
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
    pcall(function() -- Line: 111 -- upvalues: LocalPlayer (upval)
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

local function hideCutsceneUi() -- Line: 123 -- upvalues: u84 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u84 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 130
    -- upvalues: restoreCamera (val), restoreAllUi (val), u84 (ref), Tabs (val)
    restoreCamera()
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

local function hideRacers(a1) -- Line: 144 -- upvalues: RunService (val), Players (val), Workspace (val)
    local u1 = {}
    local u2 = {}

    local function collect(a1) -- Line: 147 -- upvalues: u1 (val), u2 (val) -- types: a1: userdata
        for i, j in a1:GetDescendants() do
            if j:IsA("BasePart") or j:IsA("Decal") then
                u1[j] = true
            elseif j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") or j:IsA("BillboardGui") then
                if u2[j] == nil then
                    u2[j] = j.Enabled
                    j.Enabled = false
                end
            elseif j:IsA("Highlight") and u2[j] == nil then
                u2[j] = j.Enabled
                j.Enabled = false
            end
        end
    end

    local u4 = 0
    RunService:BindToRenderStep("RaceIntroHideRacers", Enum.RenderPriority.Camera.Value + 2, function() -- Line: 163 -- upvalues: u4 (ref), Players (upval), collect (val), Workspace (upval), u1 (val)
        local v1 = os.clock()
        if u4 <= v1 then
            local Character
            u4 = os.clock() + 0.25
            for i, j in Players:GetPlayers() do
                Character = j.Character
                if Character ~= nil then
                    collect(Character)
                end
            end
            local RaceBots = Workspace:FindFirstChild("RaceBots")
            if RaceBots ~= nil then
                collect(RaceBots)
            end
        end
        for k in u1 do
            k.LocalTransparencyModifier = 1
        end
    end)
    a1:Add(function() -- Line: 181 -- upvalues: RunService (upval), u1 (val), u2 (val)
        RunService:UnbindFromRenderStep("RaceIntroHideRacers")
        for i in u1 do
            i.LocalTransparencyModifier = 0
        end
        for j, k in u2 do
            j.Enabled = k
        end
    end)
end

local function setEmitting(a1, a2) -- Line: 192 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emitBurst(a1) -- Line: 201 -- types: a1: userdata
    local Attribute_3
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")
            task.delay(if type(Attribute_3) ~= "number" then 0 else Attribute_3, function() -- Line: 210 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute ~= 0 then
                    j:Emit(Attribute)
                end
                if type(Attribute_2) == "number" and Attribute_2 ~= 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 216 -- upvalues: j (upval)
                        j.Enabled = false
                    end)
                end
            end)
        end
    end
end

return function(a1) -- Line: 226
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), setEmitting (val), emitBurst (val), MountRace (val)
    -- upvalues: hideCutsceneUi (val), restoreCutsceneUi (val), hideRacers (val), MusicDirector (val)
    -- upvalues: IntroCutscene (val), Lighting (val), Workspace (val), SoundService (val), TweenService (val)
    -- upvalues: ContentProvider (val), restoreCamera (val), RunService (val), CurrentCamera (val)
    local u3 = a1:Extend()
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(u3)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u16 = nil
    local v2 = CFrame.new(0, 0, 0, 0.9999, 0.0102, 0.0001, -0.0102, 0.9982, 0.059, 0.0005, -0.059, 0.9983)
    local v3 = CFrame.new(0, 0, 0, 0.9999, 0.0102, -0.0004, -0.0102, 0.9999, 0.0092, 0.0005, -0.0092, 1)
    local u58 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)

    local function brakes(a1, a2, a3, a4) -- Line: 241 -- types: a1: number, a2: number, a3: number, a4: userdata
        return CFrame.new(a1, a2, a3) * a4 + Vector3.new(-4009, 0, 9397)
    end

    local function speedBuff(a1, a2, a3) -- Line: 244
        -- upvalues: u58 (val)
        return (CFrame.new(a1, a2, a3)) * u58 + Vector3.new(-4009, 0, 9397)
    end

    local u61 = {}
    u61[0] = {
        SetProperty("Workspace.CurrentCamera.FieldOfView", 50),
        SetProperty("Lighting.CutsceneBlur.Size", 15),
        SetProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            CFrame.new(600.513, 172.0128, 53.7681) * u58 + Vector3.new(-4009, 0, 9397)
        ),
        TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(7.233333333333333, Enum.EasingStyle.Linear),
            CFrame.new(600.513, 134.862, 53.7681) * u58 + Vector3.new(-4009, 0, 9397)
        ),
        SetProperty("Workspace.RaceIntroVFX.Brakes.CFrame", CFrame.new(597.338, 205.8216, 450.1992) * v2 + Vector3.new(-4009, 0, 9397)),
        TweenProperty(
            "Workspace.RaceIntroVFX.Brakes.CFrame",
            TweenInfo.new(11.1, Enum.EasingStyle.Linear),
            CFrame.new(597.3363, 205.1604, 439.0122) * v2 + Vector3.new(-4009, 0, 9397)
        ),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", Color3.new(0, 0, 0)),
        SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true),
        SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.5, Enum.EasingStyle.Linear), 1),
        SetProperty("Lighting.Croc.Enabled", false),
        SetProperty("Lighting.Croc.Saturation", 0.3),
        SetProperty("Lighting.Croc.Contrast", 0.4),
        SetProperty("Lighting.Croc.TintColor", Color3.new(0.929412, 1, 0.941177)),
        (SetProperty("Lighting.Croc.Brightness", 0.3)),
    }
    u61[22] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.05, Enum.EasingStyle.Linear), 2)),
    }
    u61[434] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.2, Enum.EasingStyle.Linear),
            CFrame.new(600.963, 187.1631, -40.1157) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[446] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
            CFrame.new(600.7661, 187.9726, -0.1618) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[460] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.15, Enum.EasingStyle.Linear),
            CFrame.new(600.6395, 188.8895, 27.5817) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[469] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.15, Enum.EasingStyle.Linear),
            CFrame.new(600.513, 190.52, 53.7681) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[471] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.6166666666666667, Enum.EasingStyle.Linear), 0.5)),
    }
    u61[478] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.3, Enum.EasingStyle.Linear),
            CFrame.new(600.513, 191.9059, 109.858) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[496] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(600.513, 194.1781, 158.7036) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[512] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear),
            CFrame.new(600.513, 197.7077, 228.384) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[517] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 1)),
    }
    u61[535] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.55, Enum.EasingStyle.Linear),
            CFrame.new(600.513, 200.8587, 282.8826) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[568] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear),
            CFrame.new(598.5856, 202.3643, 285.6259) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[585] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u61[586] = {SetProperty("Lighting.Croc.Enabled", true)}
    u61[588] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.25, Enum.EasingStyle.Linear),
            CFrame.new(598.6507, 202.7567, 314.9995) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[603] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.6833333333333333, Enum.EasingStyle.Linear),
            CFrame.new(598.024, 206.5802, 394.2784) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[614] = {
        function() -- Line: 333 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.Brakes, true)
        end,
    }
    u61[625] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.55, Enum.EasingStyle.Linear), 1)),
    }
    u61[626] = {
        TweenProperty("Lighting.Croc.Saturation", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Croc.Contrast", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Croc.TintColor", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        (TweenProperty("Lighting.Croc.Brightness", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    u61[644] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear),
            CFrame.new(597.9403, 207.7471, 426.6629) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[661] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(597.9403, 207.7471, 435.8149) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[665] = {
        (TweenProperty(
            "Workspace.RaceIntroRigs.CROCANIMS.SpeedBuff.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(597.9403, 174.5771, 435.8149) * u58 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[666] = {
        (TweenProperty(
            "Workspace.RaceIntroVFX.Brakes.CFrame",
            TweenInfo.new(0.1, Enum.EasingStyle.Linear),
            CFrame.new(597.338, 205.8216, 450.1992) * v2 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[672] = {
        (TweenProperty(
            "Workspace.RaceIntroVFX.Brakes.CFrame",
            TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(597.7242, 206.6158, 463.7007) * v2 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[682] = {
        (TweenProperty(
            "Workspace.RaceIntroVFX.Brakes.CFrame",
            TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(597.7205, 206.8149, 476.3184) * v2 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[692] = {
        (TweenProperty(
            "Workspace.RaceIntroVFX.Brakes.CFrame",
            TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear),
            CFrame.new(597.7206, 207.6047, 493.7596) * v2 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[703] = {
        (TweenProperty(
            "Workspace.RaceIntroVFX.Brakes.CFrame",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
            CFrame.new(597.7156, 207.7132, 507.1371) * v3 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[717] = {
        (TweenProperty(
            "Workspace.RaceIntroVFX.Brakes.CFrame",
            TweenInfo.new(0.95, Enum.EasingStyle.Linear),
            CFrame.new(597.7064, 207.947, 532.5401) * v3 + Vector3.new(-4009, 0, 9397)
        )),
    }
    u61[740] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.7666666666666667, Enum.EasingStyle.Linear), 0.5)),
    }
    u61[748] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Linear), 10)),
    }
    u61[783] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 13)),
    }
    u61[790] = {
        TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2),
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1)),
    }
    u61[791] = {
        function() -- Line: 403 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.Brakes, false)
        end,
    }
    u61[1899] = {
        function() -- Line: 409 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.AreaVFX, true)
        end,
    }
    u61[1924] = {
        function() -- Line: 415 -- upvalues: emitBurst (upval), u16 (ref)
            emitBurst(u16.Fireworks)
        end,
    }
    u61[2089] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 15)),
    }
    u61[2134] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    u61[2154] = {
        function() -- Line: 429 -- upvalues: setEmitting (upval), u16 (ref)
            setEmitting(u16.AreaVFX, false)
        end,
    }
    return {
        Run = function() -- Line: 436
            -- upvalues: LocalPlayer (upval), MountRace (upval), u3 (val), hideCutsceneUi (upval)
            -- upvalues: restoreCutsceneUi (upval), hideRacers (upval), MusicDirector (upval), IntroCutscene (upval)
            -- upvalues: Lighting (upval), CutsceneUI (val), Black (val), Vignette (val), a1 (val), Workspace (upval)
            -- upvalues: u16 (ref), SoundService (upval), TweenService (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CurrentCamera (upval)
            -- upvalues: u61 (val)
            local v1
            LocalPlayer:SetAttribute(MountRace.CutsceneAttribute, true)
            u3:Add(function() -- Line: 439 -- upvalues: LocalPlayer (upval), MountRace (upval)
                LocalPlayer:SetAttribute(MountRace.CutsceneAttribute, nil)
            end)
            xpcall(hideCutsceneUi, warn)
            u3:Add(restoreCutsceneUi)
            hideRacers(u3)
            MusicDirector.SetEventMusic(true)
            u3:Add(function() -- Line: 448 -- upvalues: MusicDirector (upval)
                MusicDirector.SetEventMusic(false)
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
            u3:Add(function() -- Line: 465 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            a1:Add(function() -- Line: 470 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local v2 = IntroCutscene.RaceIntroVFX:Clone()
            v2.Parent = Workspace
            u16 = v2
            u3:Add(v2)
            local u80 = IntroCutscene.CutsceneMusic:Clone()
            u80.Parent = SoundService
            u3:Add(u80)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            local v3 = IntroCutscene.RaceIntroRigs:Clone()
            u3:Add(v3)
            for k, n in v3:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            local SPEED = v3.CROCANIMS.SpeedBuff:FindFirstChild("SPEED")
            SPEED.Part1 = v2.SPEED
            v2.SPEED.Anchored = false
            v3.Parent = Workspace
            local v4 = {}
            for m, i5 in v3:GetChildren() do
                table.insert(v4, (i5:FindFirstChild("Animation")))
            end
            ContentProvider:PreloadAsync(v4)
            local u152 = {}
            for i6, i7 in v3:GetChildren() do
                v2 = i7:FindFirstChild("Animation")
                u152[i7] = (LoadAnimationIntoRig(i7, v2.AnimationId))
            end
            local u166 = true
            u3:Add(function() -- Line: 513 -- upvalues: u166 (ref), restoreCamera (upval)
                u166 = false
                restoreCamera()
            end)
            for i8, i9 in u152 do
                i9:Play(0)
            end
            v1 = u152[v3.CameraRig]
            local v5 = os.clock() + 2
            while u166 do
                if not (v1.TimePosition <= 0) or not (os.clock() < v5) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u80:Play()
            local Head = v3.CameraRig.Head
            u3:Connect(RunService.RenderStepped, function() -- Line: 535 -- upvalues: u166 (ref), CurrentCamera (upval), LocalPlayer (upval), Head (val)
                if not u166 then
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Head
                CurrentCamera.Focus = Head.CFrame
                CurrentCamera.CFrame = Head.CFrame
            end)
            local u221 = {}
            local u222 = 0
            local u223 = 0.1
            v3 = u3:Connect(RunService.Heartbeat, function(a1) -- Line: 548
                -- upvalues: u222 (ref), u223 (ref), u152 (val), u80 (val), u61 (upval), u221 (val)
                local v1, v2
                u222 = u222 + a1
                u223 = u223 - a1
                for i, j in u152 do
                    v2 = j.Length - 0.05
                    if 0 < j.Length and v2 <= u222 and j.Speed ~= 0 then
                        j.TimePosition = v2
                        j:AdjustSpeed(0)
                    end
                end
                if u223 <= 0 then
                    u223 = 0.1
                    for k, n in u152 do
                        if n.IsPlaying and n.Speed ~= 0 and 0.4 <= (math.abs(u222 - n.TimePosition)) then
                            xpcall(function() -- Line: 567 -- upvalues: n (val), u222 (upval)
                                n.TimePosition = u222
                            end, warn)
                        end
                    end
                end
                if not (u80.TimePosition < u222 - 0.001) then
                    local TimePosition_2 = u80.TimePosition
                    if not (u222 + 0.001 < TimePosition_2) then
                        u80.PlaybackSpeed = 1
                    else
                        u80.PlaybackSpeed = 0.99
                    end
                else
                    u80.PlaybackSpeed = 1.01
                end
                for m = 0, 9 do
                    v1 = math.floor(u222 * 60 - m)
                    if u61[v1] and not u221[v1] then
                        u221[v1] = true
                        for i5, i6 in u61[v1] do
                            task.spawn(i6)
                        end
                    end
                end
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(36.4)
            v3:Disconnect()
            Black.BackgroundTransparency = 0
            u3:Clean()
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
        end,
    }
end