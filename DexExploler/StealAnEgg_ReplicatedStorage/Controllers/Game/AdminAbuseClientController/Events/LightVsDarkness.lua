-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness
-- Decompile time: 3.13 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ActiveAssetsController = require(script.Parent.Parent.Parent.Plots.ActiveAssetsController)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local SubBiomeCycle = require(ReplicatedStorage.Shared.Util.SubBiomeCycle)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u44 = require(script.RingSystem)(v1)
local u50 = require(script.FlyingSystem)(v1)
local u56 = require(script.TeamSystem)(v1)
local UISystem = require(script.UISystem)
local u66 = require(script.PowerUpSystem)(v1)
local u72 = require(script.MusicSystem)(v1)
local u77 = Color3.fromRGB(255, 138, 236)
local u79 = Trove.new()
local u80 = false

local function setPlotsHidden(a1) -- Line: 39
    -- upvalues: ActiveAssetsController (val), PlacedEggRenderer (val)
    ActiveAssetsController.SetAllPetsHidden(a1)
    PlacedEggRenderer.SetAllHidden(a1)
end

v1.AssetTrove = u79

function v1.IsEventActive() -- Line: 47 -- upvalues: u80 (ref)
    return u80
end

function v1.StartEvent(a1, a2, a3) -- Line: 51
    -- upvalues: u79 (val), u80 (ref), Workspace (val), ActiveAssetsController (val), PlacedEggRenderer (val), u44 (val)
    -- upvalues: u50 (val), u56 (val), u66 (val), u72 (val), UISystem (val)
    u79:Clean()
    u80 = true
    local v1 = 0
    if not a3 or not a3.WasInProgress then
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local v2 = require(script.Cutscenes.IntroCutscene)(u79)
        ActiveAssetsController.SetAllPetsHidden(true)
        PlacedEggRenderer.SetAllHidden(true)
        u79:Add(function() -- Line: 61 -- upvalues: ActiveAssetsController (upval), PlacedEggRenderer (upval)
            ActiveAssetsController.SetAllPetsHidden(false)
            PlacedEggRenderer.SetAllHidden(false)
        end)
        v2.Run()
        ActiveAssetsController.SetAllPetsHidden(false)
        PlacedEggRenderer.SetAllHidden(false)
        v1 = Workspace:GetServerTimeNow() - ServerTimeNow
    end
    u44.Start()
    u50.Start()
    u56.Start()
    u66.Start()
    u72.Start()
    UISystem.Start(u79, Workspace:GetServerTimeNow() + a2 - v1 - 5)
end

function v1.StopEvent(a1) -- Line: 75
    -- upvalues: u80 (ref), u79 (val), u50 (val), u56 (val), u66 (val), u72 (val), UISystem (val), Workspace (val)
    -- upvalues: SubBiomeCycle (val), Toast (val), u77 (val)
    u80 = false
    u79:Clean()
    u50.Stop()
    u56.Stop()
    u66.Stop()
    u72.Stop()
    UISystem.Stop()
    task.wait(0.1)
    local Attribute = Workspace:GetAttribute("LIGHT_VS_DARK_WINNER")
    if not Attribute then
        error("Winner is nil")
        return
    end
    if Attribute == "Light" then
        require(script.Cutscenes.EndCutsceneLight)(u79).Run()
        u79:Clean()
    elseif Attribute == "Darkness" then
        require(script.Cutscenes.EndCutsceneDark)(u79).Run()
        u79:Clean()
    end
    if SubBiomeCycle.RevealPhaseAt("Light Dark", Workspace:GetServerTimeNow()) == "RevealNight" then
        Toast.Show({
            Lane = "Banner",
            Text = "⚔️ The battle was won... the Light and Dark biomes have arrived! One of 3 biomes can appear each night!",
            Seconds = 8,
            Color = u77,
        })
    end
end

return v1