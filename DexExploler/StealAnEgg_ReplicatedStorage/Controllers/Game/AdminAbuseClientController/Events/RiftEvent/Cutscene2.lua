-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RiftEvent.Cutscene2
-- Decompile time: 24.43 ms

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
require(ReplicatedStorage.Shared.Remotes)
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
    -- upvalues: CutsceneHelperFunctions (val), ReplicatedStorage (val), LocalPlayer (val), TweenService (val)
    -- upvalues: hideCutsceneUi (val), restoreAllUi (val), u75 (ref), Tabs (val), Workspace (val), setTransparency (val)
    -- upvalues: Lighting (val), ContentProvider (val), restoreCamera (val), RunService (val), CurrentCamera (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local PlaySequenceAsync = v1.PlaySequenceAsync
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local RiftCutscene2 = ReplicatedStorage.CutsceneAssets.RiftCutsceneAssets.RiftCutscene2
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u20 = nil
    local u21 = {}
    u21[0] = {
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(4804.1978, 73.1938, -341.0876, -0.8189, -0.0967, 0.5657, 0, 0.9857, 0.1684, -0.5739, 0.1379, -0.8073)
        ),
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(26.65, Enum.EasingStyle.Linear),
            CFrame.new(4795.2813, 70.9149, -313.1396, -0.9998, -0.0092, -0.0186, -0.0054, 0.9809, -0.1945, 0.0201, -0.1944, -0.9807)
        ),
        SetProperty("Workspace.CurrentCamera.FieldOfView", 70),
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), 45),
        SetProperty("Lighting.CutsceneBlur.Enabled", true),
        SetProperty("Lighting.CutsceneBlur.Size", 25),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u21[31] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.4, Enum.EasingStyle.Linear), 35)),
    }
    u21[55] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.9, Enum.EasingStyle.Linear), 45)),
    }
    u21[57] = {
        function() -- Line: 172 -- upvalues: u20 (ref)
            local triggerParticles, v1, v2
            local Smoke = u20.Smoke

            local function check(a1) -- Line: 175 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 186 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
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
                            task.delay(Attribute_2, function() -- Line: 193 -- upvalues: v (upval)
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
    u21[59] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 10)),
    }
    u21[66] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 4)),
    }
    u21[103] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 10)),
    }
    u21[105] = {
        function() -- Line: 221 -- upvalues: u20 (ref)
            local triggerParticles, v1, v2
            local Smoke2 = u20.Smoke2

            local function check(a1) -- Line: 224 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke2:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 235 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
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
                            task.delay(Attribute_2, function() -- Line: 242 -- upvalues: v (upval)
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
    u21[110] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 4)),
    }
    u21[137] = {
        function() -- Line: 262 -- upvalues: u20 (ref)
            local triggerParticles, v1, v2
            local Smoke3 = u20.Smoke3

            local function check(a1) -- Line: 265 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke3:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 276 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
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
                            task.delay(Attribute_2, function() -- Line: 283 -- upvalues: v (upval)
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
    u21[138] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 10)),
    }
    u21[145] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 4)),
    }
    u21[155] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 9)),
    }
    u21[166] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u21[890] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), 8)),
    }
    u21[892] = {
        function() -- Line: 319 -- upvalues: u20 (ref)
            for i, v in ipairs((u20:WaitForChild("Roar")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u21[910] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.8, Enum.EasingStyle.Linear), 2)),
    }
    u21[927] = {
        function() -- Line: 335 -- upvalues: u20 (ref)
            for i, v in ipairs((u20:WaitForChild("Roar")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end,
    }
    u21[1324] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(2.566666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            75
        )),
    }
    u21[1392] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 10)),
    }
    u21[1420] = {
        function() -- Line: 355
            for i, v in ipairs((((workspace:WaitForChild("RiftCutscene2")):WaitForChild("Portal")):WaitForChild("Charge")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u21[1430] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 2)),
    }
    u21[1599] = {
        TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(4795.5762, 69.3859, -353.8327, 0.6834, 0, -0.7301, 0.0038, 1, 0.0036, 0.7301, -0.0052, 0.6834)
        ),
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            35
        )),
    }
    u21[1600] = {
        (TweenProperty(
            "Workspace.CurrentCamera.CFrame",
            TweenInfo.new(9.333333333333334, Enum.EasingStyle.Linear),
            CFrame.new(4791.5317, 69.3774, -356.0904, 0.5039, 0.0021, -0.8638, 0.0106, 0.9999, 0.0086, 0.8637, -0.0135, 0.5038)
        )),
    }
    u21[1713] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            55
        )),
    }
    u21[1788] = {
        function() -- Line: 384
            local triggerParticles, v1, v2
            local EggSpawn = workspace.RiftCutscene2.Portal.EggSpawn

            local function check(a1) -- Line: 387 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(EggSpawn:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 398 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
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
                            task.delay(Attribute_2, function() -- Line: 405 -- upvalues: v (upval)
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
    u21[1843] = {
        function() -- Line: 421
            for i, v in ipairs((((workspace:WaitForChild("RiftCutscene2")):WaitForChild("Portal")):WaitForChild("Charge")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end,
    }
    u21[1896] = {
        function() -- Line: 433 -- upvalues: u20 (ref)
            local triggerParticles, v1, v2
            local Smoke4 = u20.Smoke4

            local function check(a1) -- Line: 436 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke4:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 447 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
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
                            task.delay(Attribute_2, function() -- Line: 454 -- upvalues: v (upval)
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
    u21[1897] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            40
        )),
    }
    u21[1923] = {
        function() -- Line: 474 -- upvalues: u20 (ref)
            local triggerParticles, v1, v2
            local Smoke5 = u20.Smoke5

            local function check(a1) -- Line: 477 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Smoke5:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    local Attribute = v:GetAttribute("EmitCount")
                    local Attribute_2 = v:GetAttribute("EmitDuration")
                    v2 = v:GetAttribute("EmitDelay") or 0

                    function triggerParticles() -- Line: 488 -- upvalues: Attribute (val), v (val), Attribute_2 (val)
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
                            task.delay(Attribute_2, function() -- Line: 495 -- upvalues: v (upval)
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
    u21[2115] = {
        function() -- Line: 511 -- upvalues: TweenService (upval), Black (val)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        end,
    }
    return {
        Run = function() -- Line: 518
            -- upvalues: hideCutsceneUi (upval), LocalPlayer (upval), a1 (val), restoreAllUi (upval), u75 (upval)
            -- upvalues: Tabs (upval), ReplicatedStorage (upval), Workspace (upval), setTransparency (upval)
            -- upvalues: TweenService (upval), Lighting (upval), CutsceneUI (val), Black (val), Vignette (val)
            -- upvalues: u20 (ref), RiftCutscene2 (val), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CutsceneMusic (val), CurrentCamera (upval)
            -- upvalues: u21 (val)
            local Animation, Animation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            pcall(function() -- Line: 523 -- upvalues: LocalPlayer (upval)
                LocalPlayer.PlayerGui.BossFightUI.Enabled = false
            end)
            a1:Add(function() -- Line: 527
                -- upvalues: u0 (ref), restoreAllUi (upval), u75 (upval), Tabs (upval), LocalPlayer (upval)
                -- upvalues: ReplicatedStorage (upval)
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
                    LocalPlayer.PlayerGui.BossFightUI.Enabled = false
                    ReplicatedStorage.Controllers.Game.BossEventClientController.BossArenaMusic.Volume = 0
                    u0 = true
                end
            end)
            local AreaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
            pcall(function() -- Line: 537 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 539 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            local v2 = {}
            for i, j in (game.Workspace.World.Areas.GuardAreas:GetChildren()) do
                local Guard = j.Guard
                v2[Guard] = j
                Guard.Parent = nil
                a1:Add(function() -- Line: 550 -- upvalues: Guard (val), j (val)
                    Guard.Parent = j
                end)
            end
            local u50 = game.Workspace.World.Areas.GuardAreas["Titan Temple"].Nests:GetDescendants()
            setTransparency(u50, 1)
            a1:Add(function() -- Line: 557 -- upvalues: setTransparency (upval), u50 (val)
                setTransparency(u50)
            end)
            pcall(function() -- Line: 561 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 562 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0}):Play()
                end)
            end)
            local u63 = {}
            for k, n in script.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(n.Name) then
                    v1 = n:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u63, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            a1:Add(function() -- Line: 588 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u95 = script.CutsceneVFX:Clone()
            u95.Parent = Workspace
            u20 = u95
            a1:Add(u95)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 599 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            local u122 = RiftCutscene2:Clone()
            for m, i5 in u122:GetChildren() do
                if i5:IsA("Model") and i5.PrimaryPart then
                    i5.PrimaryPart.Anchored = true
                end
            end
            u122.Parent = workspace
            a1:Add(u122)
            local v3 = {}
            for i6, i7 in u122:GetChildren() do
                Animation_2 = i7:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    table.insert(v3, Animation_2)
                end
            end
            ContentProvider:PreloadAsync(v3)
            local u161 = {}
            for i8, i9 in u122:GetChildren() do
                Animation = i9:FindFirstChildOfClass("Animation")
                if Animation then
                    u161[i9] = (LoadAnimationIntoRig(i9, Animation.AnimationId))
                end
            end
            local u175 = true
            a1:Add(function() -- Line: 634 -- upvalues: u175 (ref)
                u175 = false
            end)
            a1:Add(function() -- Line: 635 -- upvalues: u175 (ref), restoreCamera (upval)
                if not u175 then
                    return
                end
                restoreCamera()
            end)
            for i10, i11 in u161 do
                i11:Play(0)
            end
            local v4 = u161[u122["Camera Rig"]]
            assert(v4, "Camera Rig needs an Animation")
            v1 = os.clock() + 2
            while u175 do
                if not (v4.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            CutsceneMusic:Play()
            local Cam = u122["Camera Rig"].Cam
            local u229 = nil
            RunService.RenderStepped:Connect(function() -- Line: 662 -- upvalues: u175 (ref), u229 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u175 then
                    u229:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u238 = {}
            local u239 = 0
            local u240 = 0.1
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 676
                -- upvalues: u239 (ref), u240 (ref), u161 (val), CutsceneMusic (upval), u21 (upval), u238 (val)
                local v1
                u239 = u239 + a1
                u240 = u240 - 0.1
                if u240 <= 0 then
                    u240 = 0.1
                    for i, j in u161 do
                        if j.IsPlaying and 0.1 <= (math.abs(u239 - j.TimePosition)) then
                            xpcall(function() -- Line: 688 -- upvalues: j (val), u239 (upval)
                                j.TimePosition = u239
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u239 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u239 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u239 * 60 - k)
                    if u21[v1] and not u238[v1] then
                        u238[v1] = true
                        for n, m in u21[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(36.5)
            v5:Disconnect()
            xpcall(function() -- Line: 720 -- upvalues: u95 (val)
                u95:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 726 -- upvalues: u63 (val)
                for i, j in u63 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 732 -- upvalues: u122 (val)
                u122:Destroy()
            end, warn)
            pcall(function() -- Line: 734 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 735 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                    if not DragonEggEventMusic then
                        return
                    end
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0.5}):Play()
                end)
            end)
            xpcall(restoreCamera, warn)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.Visible = false
            Vignette.Visible = false
            pcall(function() -- Line: 753 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 757
                -- upvalues: restoreAllUi (upval), u75 (upval), Tabs (upval), LocalPlayer (upval)
                -- upvalues: ReplicatedStorage (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u75
                u75 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                LocalPlayer.PlayerGui.BossFightUI.Enabled = false
                ReplicatedStorage.Controllers.Game.BossEventClientController.BossArenaMusic.Volume = 0
                u0 = true
            end, warn)
            setTransparency(u50)
            for i12, i13 in v2 do
                i12.Parent = i13
            end
        end,
    }
end