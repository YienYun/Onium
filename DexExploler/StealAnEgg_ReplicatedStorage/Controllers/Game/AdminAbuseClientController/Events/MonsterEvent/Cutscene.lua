-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.MonsterEvent.Cutscene
-- Decompile time: 34.65 ms

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
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u75 = nil
local u76 = nil
local u77 = nil
local u78 = nil
local u79 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}

local function restoreCamera() -- Line: 44 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 54
    -- upvalues: u76 (ref), u77 (ref), Tabs (val), LocalPlayer (val), u79 (val), StarterGui (val), u78 (ref)
    if u76 ~= nil then
        return
    end
    local v1 = {}
    Tabs.Active()
    for i, j in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if j:IsA("ScreenGui") and j.Name ~= "DragonCinematic" and j.Enabled then
            v1[j] = true
            j.Enabled = false
        end
    end
    u76 = v1
    pcall(function() -- Line: 69 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u79 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u78 = v1
end

local function restoreAllUi() -- Line: 79
    -- upvalues: u76 (ref), u77 (ref), LocalPlayer (val), u78 (ref), StarterGui (val)
    local v1 = u76
    local v2 = u77
    u76 = nil
    u77 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 92 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u78
    u78 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 104 -- upvalues: u75 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u75 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 111 -- upvalues: restoreAllUi (val), u75 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u75
    u75 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 123 -- types: a1: table, a2: number?
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

return function(a1) -- Line: 136
    -- upvalues: CutsceneHelperFunctions (val), ReplicatedStorage (val), LocalPlayer (val), hideCutsceneUi (val)
    -- upvalues: Workspace (val), restoreAllUi (val), u75 (ref), Tabs (val), setTransparency (val), TweenService (val)
    -- upvalues: Lighting (val), ContentProvider (val), restoreCamera (val), RunService (val), CurrentCamera (val)
    -- upvalues: Remotes (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local PlaySequenceAsync = v1.PlaySequenceAsync
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local MonsterEventCutscene = ReplicatedStorage.CutsceneAssets.MonsterEventCutscene
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u19 = nil
    local u20 = {}
    local v2 = {}
    local v3 = SetProperty("Workspace.CurrentCamera.FieldOfView", 45)
    local v4 = SetProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(0, 0, 0))
    local v5 = TweenProperty(
        "Player.PlayerGui.CutsceneUI.Vignette.ImageColor3",
        TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear),
        Color3.new(0.419608, 0.733246, 1)
    )
    local v6 = SetProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency", 0)
    local v7 = SetProperty("Lighting.Blizzard.Enabled", true)
    local v8 = SetProperty("Lighting.Blizzard.Saturation", 0.1)
    local v9 = SetProperty("Lighting.Blizzard.Contrast", -0.1)
    local v10 = SetProperty("Lighting.Blizzard.TintColor", Color3.new(0.811765, 0.94902, 0.988235))
    local v11 = SetProperty("Lighting.Blizzard.Brightness", 0.05)
    local v12 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v13 = SetProperty("Lighting.CutsceneBlur.Size", 25)
    local v14 = SetProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)
    local v15 = TweenProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), 1)
    local v16 = SetProperty("Lighting.EndDepth.Enabled", false)
    v2[1] = v3

    v2[2] = function() -- Line: 155 -- upvalues: u19 (ref)
        for i, v in ipairs((u19:WaitForChild("ZZZ")):GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true
            end
        end
    end

    v2[3] = v4
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
    v2[16] = (SetProperty("Lighting.General.Enabled", true))
    v3 = SetProperty("Lighting.Orange.Enabled", false)
    local v17 = SetProperty("Lighting.BlackOrange.Enabled", false)
    v4 = SetProperty("Lighting.Purple.Enabled", false)
    v5 = SetProperty("Lighting.BlackPurple.Enabled", false)
    v6 = SetProperty("Lighting.Black+White.Enabled", false)
    v2[17] = v3
    v2[18] = v17
    v2[19] = v4
    v2[20] = v5
    v2[21] = v6
    v2[22] = SetProperty("Lighting.White+Black.Enabled", false)
    u20[0] = v2
    u20[23] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7666666666666667, Enum.EasingStyle.Linear), 2)),
    }
    u20[297] = {
        function() -- Line: 191 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("ZZZ")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end,
    }
    u20[300] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            12
        )),
    }
    u20[311] = {
        function() -- Line: 207 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1

            local function check(a1) -- Line: 210 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for i, j in u19.Exclaim:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    Attribute = j:GetAttribute("EmitCount")
                    Attribute_2 = j:GetAttribute("EmitDuration")
                    v1 = false
                    if Attribute ~= nil then
                        v1 = Attribute ~= 0
                    end
                    if v1 then
                        j:Emit(Attribute)
                    end
                    v1 = false
                    if Attribute_2 ~= nil then
                        v1 = Attribute_2 ~= 0
                    end
                    if v1 then
                        j.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 225 -- upvalues: j (val)
                            j.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[319] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)),
    }
    u20[455] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            1
        )),
    }
    u20[596] = {
        TweenProperty(
            "Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            0
        ),
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            20
        )),
    }
    u20[597] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)),
    }
    u20[627] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            15
        )),
    }
    u20[631] = {
        function() -- Line: 255 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Land = u19.Land

            local function check(a1) -- Line: 258 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Land:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 273 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[645] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.0666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)),
    }
    u20[781] = {
        function() -- Line: 286 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("Roar")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u20[783] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            10
        )),
    }
    u20[815] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            4
        )),
    }
    u20[819] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            5
        )),
    }
    u20[825] = {
        function() -- Line: 310 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("Roar")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end,
    }
    u20[827] = {
        function() -- Line: 322 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("Scream")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    v2 = {}
    v5 = TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

    v2[1] = function() -- Line: 334 -- upvalues: u19 (ref)
        for i, v in ipairs((u19:WaitForChild("Scream")):GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false
            end
        end
    end

    v2[2] = TweenProperty("Lighting.CutsceneBlur.Size", v5, 15)
    u20[915] = v2
    u20[916] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)),
    }
    u20[1362] = {
        function() -- Line: 351 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("Roar2")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u20[1411] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            9
        )),
    }
    u20[1413] = {
        function() -- Line: 367 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("Roar2")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end,
    }
    u20[1414] = {
        function() -- Line: 379 -- upvalues: u19 (ref)
            local v1
            local TweenService = game:GetService("TweenService")
            local v2 = u19
            if not v2 then
                warn("cutsceneVFX folder not found!")
                return
            end
            local u13 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

            local function halfTimeScale(a1) -- Line: 397
                -- upvalues: TweenService (val), u13 (val)
                TweenService:Create(a1, u13, {TimeScale = a1.TimeScale / 3}):Play()
            end

            for i, v in ipairs(v2:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v1 = {TimeScale = v.TimeScale / 3}
                    TweenService:Create(v, u13, v1):Play()
                end
            end
        end,
    }
    u20[1415] = {
        function() -- Line: 416 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local FirstPunch = u19.Punches.FirstPunch

            local function check(a1) -- Line: 419 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(FirstPunch:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 434 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[1418] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)),
    }
    u20[1478] = {SetProperty("Lighting.General.Enabled", false)}
    u20[1479] = {
        function() -- Line: 451 -- upvalues: u19 (ref)
            local v1
            local TweenService = game:GetService("TweenService")
            local v2 = u19
            if not v2 then
                warn("cutsceneVFX folder not found!")
                return
            end
            local u13 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

            local function doubleTimeScale(a1) -- Line: 469
                -- upvalues: TweenService (val), u13 (val)
                TweenService:Create(a1, u13, {TimeScale = a1.TimeScale * 3}):Play()
            end

            for i, v in ipairs(v2:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v1 = {TimeScale = v.TimeScale * 3}
                    TweenService:Create(v, u13, v1):Play()
                end
            end
        end,
    }
    u20[1483] = {SetProperty("Lighting.EndDepth.Enabled", true)}
    u20[1488] = {
        function() -- Line: 492 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Smash = u19.Smash

            local function check(a1) -- Line: 495 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smash:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 510 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[1489] = {
        function() -- Line: 519 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Dust = u19.Dust

            local function check(a1) -- Line: 522 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Dust:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 537 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[1505] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            11
        )),
    }
    u20[1533] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)),
    }
    u20[1683] = {
        TweenProperty("Lighting.Blizzard.Saturation", TweenInfo.new(1.65, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Blizzard.Contrast", TweenInfo.new(1.65, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Blizzard.TintColor", TweenInfo.new(1.65, Enum.EasingStyle.Linear), Color3.new(0.988235, 0.988235, 0.988235)),
        (TweenProperty("Lighting.Blizzard.Brightness", TweenInfo.new(1.65, Enum.EasingStyle.Linear), 0)),
    }
    u20[1693] = {
        (TweenProperty(
            "Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency",
            TweenInfo.new(1.5666666666666667, Enum.EasingStyle.Linear),
            1
        )),
    }
    u20[1738] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.8833333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)),
    }
    u20[1782] = {SetProperty("Lighting.Blizzard.Enabled", false)}
    u20[1814] = {SetProperty("Lighting.White+Black.Enabled", true)}
    v2 = {}
    v17 = SetProperty("Lighting.BlackOrange.Enabled", true)

    v2[1] = function() -- Line: 577 -- upvalues: u19 (ref)
        local Attribute, Attribute_2, v1
        local Punch1 = u19.Punches.Punch1

        local function check(a1) -- Line: 580 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Punch1:GetDescendants()) do
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
                    task.delay(Attribute_2, function() -- Line: 595 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end

    v2[2] = v17
    v2[3] = SetProperty("Lighting.White+Black.Enabled", false)
    u20[1816] = v2
    v2 = {}
    v17 = SetProperty("Lighting.Orange.Enabled", true)

    v2[1] = function() -- Line: 606 -- upvalues: u19 (ref)
        local Attribute, Attribute_2, v1
        local Smoke = u19.Smoke

        local function check(a1) -- Line: 609 -- types: a1: number?
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
                    task.delay(Attribute_2, function() -- Line: 624 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end

    v2[2] = v17
    v2[3] = SetProperty("Lighting.BlackOrange.Enabled", false)
    u20[1818] = v2
    u20[1820] = {SetProperty("Lighting.Orange.Enabled", false)}
    u20[1854] = {
        function() -- Line: 639 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Smoke2 = u19.Smoke2

            local function check(a1) -- Line: 642 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke2:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 657 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[2033] = {SetProperty("Lighting.White+Black.Enabled", true)}
    u20[2034] = {
        function() -- Line: 670 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Punch2 = u19.Punches.Punch2

            local function check(a1) -- Line: 673 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Punch2:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 688 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[2035] = {
        SetProperty("Lighting.BlackPurple.Enabled", true),
        (SetProperty("Lighting.White+Black.Enabled", false)),
    }
    u20[2037] = {
        SetProperty("Lighting.Purple.Enabled", true),
        (SetProperty("Lighting.BlackPurple.Enabled", false)),
    }
    u20[2039] = {SetProperty("Lighting.Purple.Enabled", false)}
    u20[2041] = {SetProperty("Lighting.Black+White.Enabled", true)}
    u20[2043] = {SetProperty("Lighting.Black+White.Enabled", false)}
    u20[2052] = {
        function() -- Line: 719 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Smoke3 = u19.Smoke3

            local function check(a1) -- Line: 722 -- types: a1: number?
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
                        task.delay(Attribute_2, function() -- Line: 737 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[2160] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            10
        )),
    }
    u20[2161] = {SetProperty("Lighting.White+Black.Enabled", true)}
    u20[2163] = {
        SetProperty("Lighting.Black+White.Enabled", true),
        (SetProperty("Lighting.White+Black.Enabled", false)),
    }
    u20[2165] = {SetProperty("Lighting.Black+White.Enabled", false)}
    u20[2166] = {
        function() -- Line: 763 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Punch3 = u19.Punches.Punch3

            local function check(a1) -- Line: 766 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Punch3:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 781 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[2167] = {
        function() -- Line: 790 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1
            local Stomp = u19.Punches.Stomp

            local function check(a1) -- Line: 793 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Stomp:GetDescendants()) do
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
                        task.delay(Attribute_2, function() -- Line: 808 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
        SetProperty("Lighting.Orange.Enabled", true),
    }
    u20[2169] = {
        SetProperty("Lighting.Orange.Enabled", false),
        (SetProperty("Lighting.BlackOrange.Enabled", true)),
    }
    u20[2171] = {
        SetProperty("Lighting.BlackOrange.Enabled", false),
        (SetProperty("Lighting.White+Black.Enabled", true)),
    }
    u20[2173] = {SetProperty("Lighting.White+Black.Enabled", false)}
    u20[2175] = {SetProperty("Lighting.BlackOrange.Enabled", true)}
    u20[2177] = {SetProperty("Lighting.BlackOrange.Enabled", false)}
    u20[2180] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            2
        )),
    }
    v2 = {}
    v5 = TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Linear)

    v2[1] = function() -- Line: 844 -- upvalues: u19 (ref)
        local Attribute, Attribute_2, v1
        local Smoke4 = u19.Smoke4

        local function check(a1) -- Line: 847 -- types: a1: number?
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
                    task.delay(Attribute_2, function() -- Line: 862 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end

    v2[2] = TweenProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", v5, 0)
    u20[2183] = v2
    return {
        Run = function() -- Line: 874
            -- upvalues: hideCutsceneUi (upval), Workspace (upval), a1 (val), restoreAllUi (upval), u75 (upval)
            -- upvalues: Tabs (upval), ReplicatedStorage (upval), setTransparency (upval), TweenService (upval)
            -- upvalues: Lighting (upval), CutsceneUI (val), Black (val), Vignette (val), u19 (ref)
            -- upvalues: MonsterEventCutscene (val), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CutsceneMusic (val), CurrentCamera (upval)
            -- upvalues: LocalPlayer (upval), u20 (val), Remotes (upval)
            local Animation, Animation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            local MonsterEventMap = Workspace:FindFirstChild("MonsterEventMap")
            if MonsterEventMap then
                MonsterEventMap.WallStartVisual2.Transparency = 1
            end
            a1:Add(function() -- Line: 884 -- upvalues: u0 (ref), restoreAllUi (upval), u75 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u75
                    u75 = nil
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
            pcall(function() -- Line: 892 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 894 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            local Descendants = game.Workspace.World.Areas.GuardAreas.Snow.Nests:GetDescendants()
            setTransparency(Descendants, 1)
            a1:Add(function() -- Line: 901 -- upvalues: setTransparency (upval), Descendants (val)
                setTransparency(Descendants)
            end)
            pcall(function() -- Line: 905 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 906 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0}):Play()
                end)
            end)
            local u48 = {}
            for i, j in script.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(j.Name) then
                    v1 = j:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u48, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = true
            a1:Add(function() -- Line: 932 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u80 = script.CutsceneVFX:Clone()
            u80.Parent = Workspace
            u19 = u80
            a1:Add(u80)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 943 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            local u107 = MonsterEventCutscene:Clone()
            for k, n in u107:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            u107.Parent = workspace
            a1:Add(u107)
            local v2 = {}
            for m, i5 in u107:GetChildren() do
                Animation_2 = i5:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    table.insert(v2, Animation_2)
                end
            end
            ContentProvider:PreloadAsync(v2)
            local u146 = {}
            for i6, i7 in u107:GetChildren() do
                Animation = i7:FindFirstChildOfClass("Animation")
                if Animation then
                    u146[i7] = (LoadAnimationIntoRig(i7, Animation.AnimationId))
                end
            end
            local u160 = true
            a1:Add(function() -- Line: 978 -- upvalues: u160 (ref)
                u160 = false
            end)
            a1:Add(function() -- Line: 979 -- upvalues: u160 (ref), restoreCamera (upval)
                if not u160 then
                    return
                end
                restoreCamera()
            end)
            for i8, i9 in u146 do
                i9:Play(0)
            end
            local v3 = u146[u107["Camera Rig"]]
            assert(v3, "Camera Rig needs an Animation")
            v1 = os.clock() + 2
            while u160 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            CutsceneMusic:Play()
            local Cam = u107["Camera Rig"].Cam
            local u214 = nil
            RunService.RenderStepped:Connect(function() -- Line: 1006 -- upvalues: u160 (ref), u214 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u160 then
                    u214:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u223 = {}
            local u224 = 0
            local u225 = 0.1
            local v4 = RunService.Heartbeat:Connect(function(a1) -- Line: 1020
                -- upvalues: u224 (ref), u225 (ref), u146 (val), CutsceneMusic (upval), u20 (upval), u223 (val)
                local v1
                u224 = u224 + a1
                u225 = u225 - 0.1
                if u225 <= 0 then
                    u225 = 0.1
                    for i, j in u146 do
                        if j.IsPlaying and 0.1 <= (math.abs(u224 - j.TimePosition)) then
                            xpcall(function() -- Line: 1032 -- upvalues: j (val), u224 (upval)
                                j.TimePosition = u224
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u224 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u224 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u224 * 60 - k)
                    if u20[v1] and not u223[v1] then
                        u223[v1] = true
                        for n, m in u20[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v4)
            task.wait(37.516666666666666)
            v4:Disconnect()
            xpcall(function() -- Line: 1062 -- upvalues: u80 (val)
                u80:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 1068 -- upvalues: u48 (val)
                for i, j in u48 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 1074 -- upvalues: u107 (val)
                u107:Destroy()
            end, warn)
            pcall(function() -- Line: 1076 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 1077 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0.5}):Play()
                end)
            end)
            xpcall(restoreCamera, warn)
            local u273 = false
            task.spawn(function() -- Line: 1089 -- upvalues: Remotes (upval), u273 (ref)
                Remotes.MonsterEvent.RequestTeleport:InvokeServer()
                u273 = true
            end)
            v4 = 0
            while not u273 do
                if not (v4 < 5) then
                    break
                end
                v4 = v4 + task.wait()
            end
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            v4 = Workspace:FindFirstChild("MonsterEventMap")
            if v4 then
                v4.WallStartVisual2.Transparency = 0
            end
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 1110 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 1114 -- upvalues: restoreAllUi (upval), u75 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u75
                u75 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                u0 = true
            end, warn)
            setTransparency(Descendants)
        end,
    }
end