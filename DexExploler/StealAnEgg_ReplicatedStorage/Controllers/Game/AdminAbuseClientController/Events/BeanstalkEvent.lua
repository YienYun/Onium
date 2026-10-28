-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent
-- Decompile time: 5.19 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
game:GetService("ContentProvider")
game:GetService("RunService")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local BeanstalkGrowth = require(script.BeanstalkGrowth)
local Completion = require(script.Stages.Completion)
local EggEscape = require(script.Stages.EggEscape)
local Fireflies = require(script.Stages.Fireflies)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Music = require(script.Music)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u69 = require(script.UISystem)
local Watering = require(script.Stages.Watering)
local WhaleFlight = require(script.Stages.WhaleFlight)
local LocalPlayer = Players.LocalPlayer
local Stage = BeanstalkEvent.Stage
local u82 = {
    [Stage.Fireflies] = Fireflies,
    [Stage.Watering] = Watering,
    [Stage.WhaleFlight] = WhaleFlight,
    [Stage.EggEscape] = EggEscape,
    [Stage.Complete] = Completion,
}
local u88 = {
    [Stage.Fireflies] = "Stage1",
    [Stage.Watering] = "Stage2",
    [Stage.WhaleFlight] = "Stage3",
    [Stage.EggEscape] = "Stage4TrackA",
}
local u99 = Trove.new()
local u102 = Trove.new()
local u103 = false
local u104 = nil

local function waitForRig() -- Line: 70 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return {
        Character = Character,
        Humanoid = Character:WaitForChild("Humanoid"),
        Root = Character:WaitForChild("HumanoidRootPart"),
    }
end

local function applySky() -- Line: 77 -- upvalues: LightingController (val)
    LightingController.SetLayer("BeanstalkEventSky", {Sky = LightingController.Presets.AdminAbuse.Sky}, 200)
end

local function runStage(a1) -- Line: 85
    -- upvalues: u102 (val), LocalPlayer (val), BeanstalkEvent (val), u104 (ref), u82 (val), BeanstalkGrowth (val)
    -- upvalues: Stage (val), u88 (val), Music (val), waitForRig (val)
    u102:Clean()
    local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
    local u11 = u104
    if typeof(Attribute) == "number" and u11 ~= nil then
        local u16 = u82[Attribute]
        local v1 = ("No Beanstalk stage module for stage %*"):format(Attribute)
        assert(u16 ~= nil, v1)
        BeanstalkGrowth.GrowTo(BeanstalkGrowth.HeightFor(Attribute))
        if Stage.Fireflies < Attribute then
            BeanstalkGrowth.SetBaseGrowth(1)
        end
        if Stage.Watering < Attribute then
            BeanstalkGrowth.SetWilted(0)
        end
        local v2 = u88[Attribute]
        if v2 == nil then
            Music.Release()
        else
            Music.Play(v2)
        end
        u102:Add((task.spawn(function() -- Line: 109 -- upvalues: u16 (val), u102 (upval), u11 (val), waitForRig (upval), a1 (val)
            u16.Run(u102, u11, waitForRig(), a1)
        end)))
        return
    end
end

return {
    StartEvent = function(a1, a2, a3) -- Line: 118
        -- upvalues: u99 (val), u102 (val), u103 (ref), Workspace (val), BeanstalkEvent (val), u104 (ref)
        -- upvalues: LightingController (val), Remotes (val), LocalPlayer (val), u69 (val), Music (val)
        -- upvalues: BeanstalkGrowth (val), runStage (val)
        u99:Clean()
        u102:Clean()
        u103 = true
        local u18 = Workspace:WaitForChild(BeanstalkEvent.MapFolderName, 30)
        local v1 = false
        if u18 ~= nil then
            v1 = u18:IsA("Folder")
        end
        assert(v1, "The Beanstalk map never replicated")
        if not u103 then
            return
        end
        u104 = u18
        u99:Add(function() -- Line: 130 -- upvalues: u104 (upval)
            u104 = nil
        end)
        u99:Add(function() -- Line: 133 -- upvalues: LightingController (upval)
            LightingController.ClearLayer("BeanstalkEventSky")
        end)
        local v2 = a3 or {}
        if not v2.SkipCutscenes and not v2.WasInProgress then
            LightingController.SetLayer("BeanstalkEventSky", {Sky = LightingController.Presets.AdminAbuse.Sky}, 200)
            require(script.Cutscenes.IntroCutscene)(u99).Run()
            if not u103 then
                return
            end
            Remotes.BeanstalkEvent.AskStartTimer:FireServer(v2.EnchantedForestRevealRunId)
        end
        local u74 = false

        local function onStage(a1) -- Line: 153
            -- upvalues: LocalPlayer (upval), BeanstalkEvent (upval), u74 (ref), LightingController (upval), u69 (upval)
            -- upvalues: u99 (upval), Music (upval), BeanstalkGrowth (upval), u18 (val), runStage (upval)
            if typeof((LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute))) ~= "number" then
                return
            end
            if not u74 then
                u74 = true
                LightingController.SetLayer("BeanstalkEventSky", {Sky = LightingController.Presets.AdminAbuse.Sky}, 200)
                u69.Start(u99)
                Music.Start(u99)
                BeanstalkGrowth.Start(u99, u18)
            end
            runStage(a1)
        end

        u99:Connect(LocalPlayer:GetAttributeChangedSignal(BeanstalkEvent.StageAttribute), function() -- Line: 168 -- upvalues: onStage (val)
            onStage(false)
        end)
        u99:Connect(LocalPlayer.CharacterAdded, function() -- Line: 172 -- upvalues: onStage (val)
            onStage(true)
        end)
        onStage(false)
    end,
    StopEvent = function(a1) -- Line: 178 -- upvalues: u103 (ref), u102 (val), u99 (val)
        u103 = false
        u102:Clean()
        u99:Clean()
    end,
}