-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.Cutscenes.IntroCutscene
-- Decompile time: 31.21 ms

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
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local LightVSDarkCutscene1Rigs = ReplicatedStorage.CutsceneAssets.LightVSDarkness.LightVSDarkCutscene1Rigs
local u84 = nil
local u85 = nil
local u86 = nil
local u87 = nil
local u88 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local u94 = {}

local function restoreCamera() -- Line: 49 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 59
    -- upvalues: u85 (ref), u86 (ref), Tabs (val), LocalPlayer (val), u88 (val), StarterGui (val), u87 (ref)
    if u85 ~= nil then
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
    u85 = v1
    pcall(function() -- Line: 74 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u88 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u87 = v1
end

local function restoreAllUi() -- Line: 84
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
    pcall(function() -- Line: 97 -- upvalues: LocalPlayer (upval)
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

local function hideCutsceneUi() -- Line: 109 -- upvalues: u84 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u84 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 116 -- upvalues: restoreAllUi (val), u84 (ref), Tabs (val)
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

local function restoreGuard(a1, a2) -- Line: 141 -- upvalues: u94 (val) -- types: a1: userdata, a2: userdata
    u94[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 150 -- upvalues: u94 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u94[Guard] = j
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
            -- upvalues: Guard (val), j (val), u94 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u94[v1] = nil
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

local function restoreAllGuardsAndNests() -- Line: 173 -- upvalues: u94 (val), setTransparency (val)
    local Descendants, Guard, Nests
    local v1 = nil
    local v2 = nil
    for i, j in u94, v1, v2 do
        u94[i] = nil
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

local u104 = nil
local u105 = nil
local u106 = nil
local u107 = nil
local u108 = nil

local function hideZone12(a1) -- Line: 190 -- upvalues: u104 (ref), u105 (ref), u106 (ref), u107 (ref), u108 (ref)
    local Zone12Props = game.Workspace.World.Build.Props:FindFirstChild("Zone12Props")
    if Zone12Props then
        Zone12Props.Parent = nil
        u104 = Zone12Props
        a1:Add(function() -- Line: 195 -- upvalues: Zone12Props (val)
            Zone12Props.Parent = game.Workspace.World.Build.Props
        end)
    end
    local Board = game.Workspace.World.Areas.LightDark:FindFirstChild("Board")
    if Board then
        Board.Parent = nil
        u105 = Board
        a1:Add(function() -- Line: 204 -- upvalues: Zone12Props (val)
            Zone12Props.Parent = game.Workspace.World.Areas.LightDark
        end)
    end
    local LightDarkZone = game.Workspace.World.Build:FindFirstChild("LightDarkZone")
    if LightDarkZone then
        LightDarkZone.Parent = nil
        u106 = LightDarkZone
        a1:Add(function() -- Line: 213 -- upvalues: LightDarkZone (val)
            LightDarkZone.Parent = game.Workspace.World.Build
        end)
    end
    local FakeLightDarkWall = game.Workspace:FindFirstChild("FakeLightDarkWall")
    if FakeLightDarkWall then
        u107 = FakeLightDarkWall
        u108 = FakeLightDarkWall.Parent
        FakeLightDarkWall.Parent = nil
        a1:Add(function() -- Line: 224 -- upvalues: FakeLightDarkWall (val), u108 (upval)
            FakeLightDarkWall.Parent = u108
        end)
    end
end

local function restoreZone12() -- Line: 230 -- upvalues: u104 (ref), u105 (ref), u106 (ref), u107 (ref), u108 (ref)
    if u104 then
        u104.Parent = game.Workspace.World.Build.Props
    end
    if u105 then
        u105.Parent = game.Workspace.World.Areas.LightDark
    end
    if u106 then
        u106.Parent = game.Workspace.World.Build
    end
    if u107 then
        u107.Parent = u108
    end
end

return function(a1) -- Line: 250
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), LightingController (val), hideCutsceneUi (val)
    -- upvalues: restoreAllUi (val), u84 (ref), Tabs (val), Workspace (val), ReplicatedStorage (val)
    -- upvalues: hideAllGuardsAndNests (val), hideZone12 (val), Lighting (val), TweenService (val)
    -- upvalues: LightVSDarkCutscene1Rigs (val), ContentProvider (val), restoreCamera (val), RunService (val)
    -- upvalues: CurrentCamera (val), u104 (ref), u105 (ref), u106 (ref), u107 (ref), u108 (ref)
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
    local u18 = {}
    local v2 = {}
    local v3 = SetProperty(
        "Workspace.CurrentCamera.CFrame",
        CFrame.new(5012.6948, 73.4391, -369.3411, -0.9624, -0.1056, 0.2503, -0, 0.9214, 0.3888, -0.2716, 0.3742, -0.8868)
    )
    local v4 = TweenProperty(
        "Workspace.CurrentCamera.CFrame",
        TweenInfo.new(22.516666666666666, Enum.EasingStyle.Linear),
        CFrame.new(4959.1108, 69.6647, -357.4677, -0.9912, -0.0969, -0.0901, 0.0391, 0.4358, -0.8992, 0.1264, -0.8948, -0.4282)
    )
    local v5 = SetProperty("Workspace.CurrentCamera.FieldOfView", 45)
    local v6 = SetProperty(
        "Workspace.LightVSDarkCutscene1.VFX.Plates.HeavenSide.CFrame",
        CFrame.new(5306.4995, 67.7776, -378.3783, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    )
    local v7 = SetProperty(
        "Workspace.LightVSDarkCutscene1.VFX.Plates.HellSide.CFrame",
        CFrame.new(5314.0996, 67.7776, -349.8495, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    )
    local v8 = SetProperty("Lighting.White.Enabled", false)
    local v9 = SetProperty("Lighting.Black.Enabled", false)
    local v10 = SetProperty("Lighting.RedBlack.Enabled", false)
    local v11 = SetProperty("Lighting.RedWhite.Enabled", false)
    local v12 = SetProperty("Lighting.GoldWhite.Enabled", false)
    local v13 = SetProperty("Lighting.GoldBlack.Enabled", false)
    local v14 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v15 = SetProperty("Lighting.CutsceneBlur.Size", 2)
    local v16 = SetProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", 1)
    v2[1] = v3
    v2[2] = v4
    v2[3] = v5

    v2[4] = function() -- Line: 270
        for k, v in pairs(workspace.LightVSDarkCutscene1.ZoneExtras.Asteroid:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = true
            end
        end
        for k2, i in pairs(workspace.LightVSDarkCutscene1.VFX.Aura:GetDescendants()) do
            if i:IsA("ParticleEmitter") or i:IsA("Trail") or i:IsA("Beam") then
                i.Enabled = false
            end
        end
    end

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
    v2[16] = (SetProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundColor3", Color3.new(0, 0, 0)))
    v3 = TweenProperty(
        "Player.PlayerGui.CutsceneUI.Black.BackgroundColor3",
        TweenInfo.new(22.216666666666665, Enum.EasingStyle.Linear),
        Color3.new(1, 1, 1)
    )
    v4 = SetProperty("Lighting.Cut.Enabled", true)
    v5 = SetProperty("Lighting.Cut.FarIntensity", 0.37)
    local v17 = SetProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(0, 0, 0))
    v6 = SetProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    v7 = SetProperty("Player.PlayerGui.CutsceneUI.Vignette.Visible", true)
    v8 = SetProperty("Lighting.Contrast.Enabled", true)
    v9 = SetProperty("Lighting.Contrast.Saturation", 0)
    v2[17] = v3
    v2[18] = v4
    v2[19] = v5
    v2[20] = v17
    v2[21] = v6
    v2[22] = v7
    v2[23] = v8
    v2[24] = v9
    v2[25] = SetProperty("Lighting.Contrast.Contrast", 0)
    u18[0] = v2
    u18[63] = {
        (TweenProperty("Lighting.Cut.FarIntensity", TweenInfo.new(0.8, Enum.EasingStyle.Linear), 0)),
    }
    u18[112] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 15)),
    }
    u18[125] = {
        function() -- Line: 313
            local triggerParticles, v1, v2
            local MeteorImpact = workspace.LightVSDarkCutscene1.VFX.MeteorImpact

            local function check(a1) -- Line: 316 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(MeteorImpact:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 327 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
                        local v1 = Attribute
                        local v2 = false
                        if v1 ~= nil then
                            v2 = v1 ~= 0
                        end
                        if v2 then
                            v:Emit(Attribute)
                        end
                        v1 = Attribute_2
                        v2 = false
                        if v1 ~= nil then
                            v2 = v1 ~= 0
                        end
                        if v2 then
                            v.Enabled = true
                            task.delay(Attribute_2, function() -- Line: 334 -- upvalues: v (upval)
                                v.Enabled = false
                            end)
                        end
                    end

                    v1 = false
                    if v2 ~= nil then
                        v1 = v2 ~= 0
                    end
                    if not v1 then
                        triggerParticles()
                    else
                        task.delay(v2, triggerParticles)
                    end
                end
            end
        end,
    }
    u18[126] = {
        function() -- Line: 350
            local triggerParticles, v1, v2
            for k, v in pairs(workspace.LightVSDarkCutscene1.ZoneExtras.Asteroid:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
            local Smoke = workspace.LightVSDarkCutscene1.VFX.Smoke

            local function check(a1) -- Line: 358 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k2, i in pairs(Smoke:GetDescendants()) do
                if i:IsA("ParticleEmitter") then
                    local Attribute = i:GetAttribute("EmitCount")
                    local Attribute_2 = i:GetAttribute("EmitDuration")
                    v2 = i:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 369 -- upvalues: Attribute (val), i (val), Attribute_2 (val)
                        local v1 = Attribute
                        local v2 = false
                        if v1 ~= nil then
                            v2 = v1 ~= 0
                        end
                        if v2 then
                            i:Emit(Attribute)
                        end
                        v1 = Attribute_2
                        v2 = false
                        if v1 ~= nil then
                            v2 = v1 ~= 0
                        end
                        if v2 then
                            i.Enabled = true
                            task.delay(Attribute_2, function() -- Line: 376 -- upvalues: i (upval)
                                i.Enabled = false
                            end)
                        end
                    end

                    v1 = false
                    if v2 ~= nil then
                        v1 = v2 ~= 0
                    end
                    if not v1 then
                        triggerParticles()
                    else
                        task.delay(v2, triggerParticles)
                    end
                end
            end
        end,
    }
    u18[127] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 14.91385)),
    }
    u18[137] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.7666666666666666, Enum.EasingStyle.Linear), 2)),
    }
    u18[307] = {
        (TweenProperty("Lighting.Cut.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.37)),
    }
    u18[486] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency",
            TweenInfo.new(1.0666666666666667, Enum.EasingStyle.Linear),
            0.5
        )),
    }
    u18[540] = {
        function() -- Line: 408 -- upvalues: u17 (ref)
            u17.ChatBubble.Text.SurfaceGui.SPEECHBUBBLE.Text = "MINE!"
        end,
    }
    u18[689] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(0.35, Enum.EasingStyle.Linear),
            Color3.new(1, 0.0431373, 0.0431373)
        )),
    }
    u18[720] = {
        function() -- Line: 418 -- upvalues: u17 (ref)
            u17.ChatBubble.Text.SurfaceGui.SPEECHBUBBLE.Text = "Uh oh..."
        end,
    }
    u18[730] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(0.3, Enum.EasingStyle.Linear),
            Color3.new(1, 0.823366, 0.176471)
        )),
    }
    u18[755] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u18[786] = {
        function() -- Line: 432
            local triggerParticles, v1, v2
            local Split = workspace.LightVSDarkCutscene1.VFX.Split

            local function check(a1) -- Line: 435 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Split:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 446 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
                        local v1 = Attribute
                        local v2 = false
                        if v1 ~= nil then
                            v2 = v1 ~= 0
                        end
                        if v2 then
                            v:Emit(Attribute)
                        end
                        v1 = Attribute_2
                        v2 = false
                        if v1 ~= nil then
                            v2 = v1 ~= 0
                        end
                        if v2 then
                            v.Enabled = true
                            task.delay(Attribute_2, function() -- Line: 453 -- upvalues: v (upval)
                                v.Enabled = false
                            end)
                        end
                    end

                    v1 = false
                    if v2 ~= nil then
                        v1 = v2 ~= 0
                    end
                    if not v1 then
                        triggerParticles()
                    else
                        task.delay(v2, triggerParticles)
                    end
                end
            end
        end,
    }
    u18[807] = {
        (TweenProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 1)),
    }
    u18[808] = {SetProperty("Lighting.GoldWhite.Enabled", true)}
    u18[810] = {
        SetProperty("Lighting.RedBlack.Enabled", true),
        (SetProperty("Lighting.GoldWhite.Enabled", false)),
    }
    u18[812] = {
        SetProperty("Lighting.White.Enabled", true),
        (SetProperty("Lighting.RedBlack.Enabled", false)),
    }
    u18[814] = {
        SetProperty("Lighting.White.Enabled", false),
        (SetProperty("Lighting.GoldBlack.Enabled", true)),
    }
    u18[816] = {
        SetProperty("Lighting.RedWhite.Enabled", true),
        (SetProperty("Lighting.GoldBlack.Enabled", false)),
    }
    u18[818] = {
        SetProperty("Lighting.Black.Enabled", true),
        (SetProperty("Lighting.RedWhite.Enabled", false)),
    }
    u18[820] = {SetProperty("Lighting.Black.Enabled", false)}
    u18[822] = {
        SetProperty("Lighting.GoldWhite.Enabled", false),
        SetProperty("Lighting.RedBlack.Enabled", false),
        SetProperty("Lighting.White.Enabled", false),
        SetProperty("Lighting.GoldBlack.Enabled", false),
        SetProperty("Lighting.RedWhite.Enabled", false),
        (SetProperty("Lighting.Black.Enabled", false)),
    }
    u18[830] = {
        SetProperty("Lighting.GoldWhite.Enabled", false),
        SetProperty("Lighting.RedBlack.Enabled", false),
        SetProperty("Lighting.White.Enabled", false),
        SetProperty("Lighting.GoldBlack.Enabled", false),
        SetProperty("Lighting.RedWhite.Enabled", false),
        (SetProperty("Lighting.Black.Enabled", false)),
    }
    u18[840] = {
        SetProperty("Lighting.GoldWhite.Enabled", false),
        SetProperty("Lighting.RedBlack.Enabled", false),
        SetProperty("Lighting.White.Enabled", false),
        SetProperty("Lighting.GoldBlack.Enabled", false),
        SetProperty("Lighting.RedWhite.Enabled", false),
        (SetProperty("Lighting.Black.Enabled", false)),
    }
    u18[850] = {
        SetProperty("Lighting.GoldWhite.Enabled", false),
        SetProperty("Lighting.RedBlack.Enabled", false),
        SetProperty("Lighting.White.Enabled", false),
        SetProperty("Lighting.GoldBlack.Enabled", false),
        SetProperty("Lighting.RedWhite.Enabled", false),
        (SetProperty("Lighting.Black.Enabled", false)),
    }
    u18[1085] = {
        function() -- Line: 542
            for i, v in ipairs((((workspace.LightVSDarkCutscene1Rigs.Ben:WaitForChild("DarkCrystal")):WaitForChild("DGem")):WaitForChild("Radiate1")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u18[1120] = {
        function() -- Line: 554
            for i, v in ipairs((((workspace.LightVSDarkCutscene1Rigs.Ben:WaitForChild("LightCrystal")):WaitForChild("LGem")):WaitForChild("Radiate2")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u18[1150] = {
        function() -- Line: 566
            for k, v in pairs(workspace.LightVSDarkCutscene1.VFX.Aura:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u18[1265] = {
        function() -- Line: 575
            for i, v in ipairs((((workspace.LightVSDarkCutscene1Rigs.Ben:WaitForChild("DarkCrystal")):WaitForChild("DGem")):WaitForChild("Radiate1")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
            for i2, i3 in ipairs((((workspace.LightVSDarkCutscene1Rigs.Ben:WaitForChild("LightCrystal")):WaitForChild("LGem")):WaitForChild("Radiate2")):GetDescendants()) do
                if i3:IsA("ParticleEmitter") then
                    i3.Enabled = false
                end
            end
        end,
    }
    u18[1277] = {
        TweenProperty("Lighting.Contrast.Saturation", TweenInfo.new(1.2333333333333334, Enum.EasingStyle.Linear), -0.1),
        (TweenProperty("Lighting.Contrast.Contrast", TweenInfo.new(1.2333333333333334, Enum.EasingStyle.Linear), 2)),
    }
    u18[1333] = {
        (TweenProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 0)),
    }
    u18[1351] = {
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(4.733333333333333, Enum.EasingStyle.Linear),
            CFrame.new(5044.5688, 77.7031, -364.1059, 0.0085, 0.0175, -0.9998, -0.0001, 0.9998, 0.0175, 1, 0, 0.0085)
        ),
        TweenProperty(
            "Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency",
            TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear),
            0.0202
        ),
        TweenProperty("Lighting.Contrast.Saturation", TweenInfo.new(0.9166666666666666, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.Contrast.Contrast", TweenInfo.new(0.9166666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u18[1350] = {
        function() -- Line: 611 -- upvalues: LightingController (upval), a1 (val)
            LightingController.SetLayer("LightVsDarknessCutscene", "LightDarkness", 999, 0.05)
            a1:Add(function() -- Line: 614 -- upvalues: LightingController (upval)
                LightingController.ClearLayer("LightVsDarknessCutscene")
            end)
        end,
    }
    u18[1359] = {
        TweenProperty(
            "Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency",
            TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear),
            1
        ),
        SetProperty("Lighting.Cut.Enabled", false),
    }
    u18[1367] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.25, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u18[1382] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(4.4, Enum.EasingStyle.Linear),
            Color3.new(1, 1, 1)
        )),
    }
    u18[1428] = {
        function() -- Line: 634
            for k, v in pairs(workspace.LightVSDarkCutscene1.VFX.Aura:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u18[1500] = {
        function() -- Line: 643
            for k, v in pairs(workspace.LightVSDarkCutscene1.VFX.Plates:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    }
    u18[1531] = {
        TweenProperty(
            "Workspace.LightVSDarkCutscene1.VFX.Plates.HeavenSide.CFrame",
            TweenInfo.new(1.8666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(5306.4995, 67.7776, -370.2783, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        (TweenProperty(
            "Workspace.LightVSDarkCutscene1.VFX.Plates.HellSide.CFrame",
            TweenInfo.new(1.8666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(5314.0996, 67.7776, -361.8634, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u18[1612] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6166666666666667, Enum.EasingStyle.Linear), 35)),
    }
    u18[1635] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency",
            TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear),
            0
        )),
    }
    u18[1645] = {
        function() -- Line: 665
            for k, v in pairs(workspace.LightVSDarkCutscene1.VFX.Plates:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    }
    u18[1646] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 25),
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u18[1649] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(2.35, Enum.EasingStyle.Linear), 4)),
    }
    u18[1726] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency",
            TweenInfo.new(1.0666666666666667, Enum.EasingStyle.Linear),
            1
        )),
    }
    u18[1770] = {
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(5126.2271, 70.3521, -364.1059, 0.0083, -0.1908, -0.9816, -0.0002, 0.9816, -0.1908, 1, 0.0017, 0.0081)
        ),
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 35)),
    }
    u18[1771] = {
        (TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(4.483333333333333, Enum.EasingStyle.Linear),
            CFrame.new(5127.7866, 70.5555, -364.106, 0.0084, -0.1564, -0.9877, -0.0002, 0.9877, -0.1564, 1, 0.0015, 0.0082)
        )),
    }
    u18[2000] = {
        (TweenProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.6, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 701
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u84 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval), hideZone12 (upval)
            -- upvalues: Lighting (upval), CutsceneUI (val), Black (val), Vignette (val), u16 (ref)
            -- upvalues: TweenService (upval), u17 (ref), LightVSDarkCutscene1Rigs (upval), ContentProvider (upval)
            -- upvalues: LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval), CutsceneMusic (val)
            -- upvalues: CurrentCamera (upval), LocalPlayer (upval), u18 (val), u104 (upval), u105 (upval), u106 (upval)
            -- upvalues: u107 (upval), u108 (upval)
            local Animation, Animation_2, Animation_3, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 706 -- upvalues: u0 (ref), restoreAllUi (upval), u84 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u84
                    u84 = nil
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
            pcall(function() -- Line: 714 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 716 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
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
            a1:Add(function() -- Line: 741 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u58 = ReplicatedStorage.CutsceneAssets.LightVSDarkness.LightVSDarkCutscene1:Clone()
            u58.Parent = Workspace
            a1:Add(u58)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 752 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            u17 = LightVSDarkCutscene1Rigs:Clone()
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
            local u126 = {}
            for i6, i7 in u17:GetChildren() do
                Animation_2 = i7:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    u126[i7] = (LoadAnimationIntoRig(i7, Animation_2.AnimationId))
                end
            end
            for i8, i9 in u58:GetChildren() do
                Animation = i9:FindFirstChildOfClass("Animation")
                if Animation then
                    u126[i9] = (LoadAnimationIntoRig(i9, Animation.AnimationId))
                end
            end
            local u153 = true
            a1:Add(function() -- Line: 796 -- upvalues: u153 (ref)
                u153 = false
            end)
            a1:Add(function() -- Line: 797 -- upvalues: u153 (ref), restoreCamera (upval)
                if not u153 then
                    return
                end
                restoreCamera()
            end)
            for i10, i11 in u126 do
                i11:Play(0)
            end
            local v3 = u126[u17["Camera Rig"]]
            assert(v3, "Camera Rig needs an Animation")
            local v4 = os.clock() + 2
            while u153 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v4) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            CutsceneMusic:Play()
            local Cam = u17["Camera Rig"].Cam
            local u206 = nil
            RunService.RenderStepped:Connect(function() -- Line: 824 -- upvalues: u153 (ref), u206 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u153 then
                    u206:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u215 = {}
            local u216 = 0
            local u217 = 0.1
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 838
                -- upvalues: u216 (ref), u217 (ref), u126 (val), CutsceneMusic (upval), u18 (upval), u215 (val)
                local v1
                u216 = u216 + a1
                u217 = u217 - 0.1
                if u217 <= 0 then
                    u217 = 0.1
                    for i, j in u126 do
                        if j.IsPlaying and 0.1 <= (math.abs(u216 - j.TimePosition)) then
                            xpcall(function() -- Line: 850 -- upvalues: j (val), u216 (upval)
                                j.TimePosition = u216
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u216 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u216 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u216 * 60 - k)
                    if u18[v1] and not u215[v1] then
                        u215[v1] = true
                        for n, m in u18[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(34.5)
            v5:Disconnect()
            xpcall(function() -- Line: 882 -- upvalues: u58 (val)
                u58:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 888 -- upvalues: u24 (val)
                for i, j in u24 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 894 -- upvalues: u17 (upval)
                u17:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 905 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 909 -- upvalues: restoreAllUi (upval), u84 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u84
                u84 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                u0 = true
            end, warn)
            if u104 then
                u104.Parent = game.Workspace.World.Build.Props
            end
            if u105 then
                u105.Parent = game.Workspace.World.Areas.LightDark
            end
            if u106 then
                u106.Parent = game.Workspace.World.Build
            end
            if u107 then
                u107.Parent = u108
            end
        end,
    }
end