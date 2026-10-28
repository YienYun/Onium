-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent
-- Decompile time: 3.40 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
game:GetService("ContentProvider")
game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SammyGuardSystem = require(script.SammyGuardSystem)
local StealingSystem = require(script.StealingSystem)
local Trove = require(ReplicatedStorage.Packages.Trove)
local UISystem = require(script.UISystem)
local u57 = require(script.CollectSystem)(v1)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local SammyEventVisuals = ReplicatedStorage.Assets.SammyEventVisuals
local u67 = Trove.new()
local u68 = false
local u69 = false

local function PlayMusic() -- Line: 36 -- upvalues: u67 (val)
    script.Music:Play()
    u67:Add(function() -- Line: 38
        script.Music:Stop()
    end)
end

local function MuteDefaultMusic() -- Line: 43 -- upvalues: TweenService (val), SoundService (val), u67 (val)
    TweenService:Create(SoundService.Music.GameMusic, TweenInfo.new(0.5), {Volume = 0}):Play()
    u67:Add(function() -- Line: 45 -- upvalues: TweenService (upval), SoundService (upval)
        TweenService:Create(SoundService.Music.GameMusic, TweenInfo.new(0.5), {Volume = 1}):Play()
    end)
end

local function SetupSammyLightingAndMap() -- Line: 50
    -- upvalues: LightingController (val), u67 (val), SammyEventVisuals (val), Workspace (val)
    LightingController.SetLayer("SammyEventLighting", "SammyEvent", 999, 0.01)
    u67:Add(function() -- Line: 53 -- upvalues: LightingController (upval)
        LightingController.ClearLayer("SammyEventLighting")
    end)
    local v1 = SammyEventVisuals.Map:Clone()
    v1.Parent = Workspace
    u67:Add(v1)
end

v1.AssetTrove = u67

function v1.IsEventActive() -- Line: 66 -- upvalues: u68 (ref)
    return u68
end

function v1.StartEvent(a1, a2, a3) -- Line: 70
    -- upvalues: u67 (val), u68 (ref), u69 (ref), Workspace (val), SetupSammyLightingAndMap (val)
    -- upvalues: MuteDefaultMusic (val), u57 (val), SammyGuardSystem (val), StealingSystem (val), UISystem (val)
    local v1 = a3 or {}
    u67:Clean()
    u68 = true
    Workspace:SetAttribute("ScrambleHUDAwaitingSammyOutro", not v1.SkipCutscenes and Workspace:GetAttribute("ScrambleHUDUnlocked") ~= true)
    local ServerTimeNow = Workspace:GetServerTimeNow()
    if not v1.SkipCutscenes and not v1.WasInProgress then
        require(script.Cutscenes.IntroCutscene)(u67).Run()
    end
    local v2 = (Workspace:GetServerTimeNow()) - ServerTimeNow
    SetupSammyLightingAndMap()
    MuteDefaultMusic()
    script.Music:Play()
    u67:Add(function() -- Line: 38
        script.Music:Stop()
    end)
    u57.Start()
    SammyGuardSystem.Start(u67)
    StealingSystem.Start(u67)
    UISystem.Start(u67, Workspace:GetServerTimeNow() + a2 - v2)
end

function v1.StopEvent(a1) -- Line: 100
    -- upvalues: u68 (ref), UISystem (val), StealingSystem (val), u57 (val), u67 (val), u69 (ref), Workspace (val)
    u68 = false
    UISystem.Stop()
    StealingSystem.Stop()
    u57.Clear()
    u67:Clean()
    if not u69 then
        require(script.Cutscenes.OutroCutscene1)(u67).Run()
        require(script.Cutscenes.OutroCutscene2)(u67).Run()
        u67:Clean()
    end
    Workspace:SetAttribute("ScrambleHUDAwaitingSammyOutro", nil)
end

return v1