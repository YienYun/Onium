-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController
-- Decompile time: 11.80 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Globals.Constants)
local GuardTutorialFlags = require(ReplicatedStorage.Shared.Flags.GuardTutorialFlags)
local GuardTutorialPresentation = require(ReplicatedStorage.Client.GuardTutorialPresentation)
local GuardTutorialSteps = require(ReplicatedStorage.Data.GuardTutorialSteps)
local GuardTutorial = require(ReplicatedStorage.Shared.Types.GuardTutorial)
local Log = require(ReplicatedStorage.Packages.Log)
local MilestoneAdapter = require(script.MilestoneAdapter)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local Promise = require(ReplicatedStorage.Packages.Promise)
local OnboardingTiming = require(ReplicatedStorage.Shared.Util.OnboardingTiming)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local EquipEgg = require(script.Steps.EquipEgg)
local ExpandPen = require(script.Steps.ExpandPen)
local HatchEgg = require(script.Steps.HatchEgg)
local HeadToPen = require(script.Steps.HeadToPen)
local PlaceEgg = require(script.Steps.PlaceEgg)
local PlacePet = require(script.Steps.PlacePet)
local StealEgg = require(script.Steps.StealEgg)
local TreadmillIntro = require(script.Steps.TreadmillIntro)
local u120 = {}
u120.__index = u120
u120.__class = "GuardTutorialController"
local u122 = {
    [StealEgg.StepId] = StealEgg,
    [HeadToPen.StepId] = HeadToPen,
    [EquipEgg.StepId] = EquipEgg,
    [PlaceEgg.StepId] = PlaceEgg,
    [HatchEgg.StepId] = HatchEgg,
    [PlacePet.StepId] = PlacePet,
    [ExpandPen.StepId] = ExpandPen,
    [TreadmillIntro.StepId] = TreadmillIntro,
}
local u133 = Log.new()
local LocalPlayer = Players.LocalPlayer

local function isRacing() -- Line: 97 -- upvalues: LocalPlayer (val), MountRace (val)
    return LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil
end

local function getProgressIndex(a1) -- Line: 101 -- upvalues: GuardTutorialSteps (val)
    if a1.Completed then
        return (1 / 0)
    end
    local CurrentStepId = a1.CurrentStepId
    if CurrentStepId == nil then
        return 0
    end
    return GuardTutorialSteps.GetIndex(CurrentStepId) or 0
end

function u120.new() -- Line: 118
    -- upvalues: u120 (val), MilestoneAdapter (val), GuardTutorial (val), GuardTutorialPresentation (val), Trove (val)
    local v1 = setmetatable({}, u120)
    v1._activeStepCleanup = nil
    v1._activeStepId = nil
    v1._adapter = MilestoneAdapter.new()
    v1._currentProgress = GuardTutorial.CopyProgress(GuardTutorial.DEFAULT_PROGRESS)
    v1._lastStoredIndex = nil
    v1._presentation = GuardTutorialPresentation.new()
    v1._refreshGeneration = 0
    v1._retryScheduled = false
    v1._runtimeEnabled = false
    v1._runtimeRevision = -1
    v1._runtimeStateReady = false
    v1._runtimeStateRequestPending = false
    v1._pauseNotificationShown = false
    v1._pausedForAdminAbuse = false
    v1._started = false
    v1._trove = Trove.new()
    return v1
end

function u120:_clearActiveStep() -- Line: 145
    local _activeStepCleanup = self._activeStepCleanup
    if _activeStepCleanup ~= nil then
        self._activeStepCleanup = nil
        _activeStepCleanup()
    end
    self._presentation:DropEverything()
    self._activeStepId = nil
end

function u120:_maybeShowPauseNotification() -- Line: 155
    -- upvalues: GuardTutorialFlags (val), Save (val), ReplicatedStorage (val)
    if not self._pauseNotificationShown
        and self._runtimeStateReady
        and not self._runtimeEnabled
        and self._pausedForAdminAbuse
        and GuardTutorialFlags.PauseNotificationEnabled:Get()
        and Save.IsLoaded() then
        if self:_readStoredProgress().Completed then
            return
        end
        self._pauseNotificationShown = true
        ;(require(ReplicatedStorage.Client.Notifications.Toast)).Show({
            Lane = "Banner",
            Text = "Tutorial paused during Admin Abuse. It will resume after the event.",
            Seconds = 5,
            ShowShadow = true,
            Unique = true,
            Color = Color3.new(1, 1, 1),
        })
        return
    end
end

function u120:_applyRuntimeState(a2) -- Line: 183 -- upvalues: OnboardingTiming (val) -- types: a2: table
    if a2.Revision < self._runtimeRevision then
        return
    end
    local _runtimeStateReady = self._runtimeStateReady
    local _runtimeEnabled = self._runtimeEnabled
    self._runtimeEnabled = a2.Enabled
    self._runtimeRevision = a2.Revision
    self._runtimeStateReady = true
    OnboardingTiming.Mark("TutorialRuntimeReady")
    self._pausedForAdminAbuse = a2.PausedForAdminAbuse
    if not a2.PausedForAdminAbuse then
        self._pauseNotificationShown = false
    end
    if not a2.Enabled then
        self:_clearActiveStep()
        self._refreshGeneration = self._refreshGeneration + 1
        self:_maybeShowPauseNotification()
        return
    end
    if not _runtimeStateReady or not _runtimeEnabled then
        self:RefreshProgress()
    end
end

function u120:_requestRuntimeState() -- Line: 215 -- upvalues: Promise (val), Remotes (val), GuardTutorial (val)
    if self._runtimeStateRequestPending then
        return false
    end
    self._runtimeStateRequestPending = true
    local v1, v2 = Promise.try(function() -- Line: 221 -- upvalues: Remotes (upval)
        return Remotes.GuardOnboarding.AskLiveState:InvokeServer()
    end):timeout(30):await()
    self._runtimeStateRequestPending = false
    if v1 and self._started then
        if not GuardTutorial.SchemaValidation.RuntimeState(v2) then
            return false
        end
        self:_applyRuntimeState(v2)
        return true
    end
    return false
end

function u120:_queueRuntimeStateRetry() -- Line: 238 -- upvalues: Timer (val)
    if not self._runtimeStateReady and self._started then
        local u3 = nil
        u3 = Timer.Simple(0.5, function() -- Line: 244 -- upvalues: self (val), u3 (ref)
            if not self._started or self._runtimeStateReady or self:_requestRuntimeState() then
                local v1 = u3
                if v1 ~= nil then
                    v1:Disconnect()
                end
            end
        end)
        self._trove:Add(u3)
        return
    end
end

function u120._readStoredProgress(a1) -- Line: 255 -- upvalues: Save (val), GuardTutorial (val)
    local v1 = Save.Await()
    if v1 == nil then
        return GuardTutorial.CopyProgress(GuardTutorial.DEFAULT_PROGRESS)
    end
    return GuardTutorial.SanitizeProgress(v1.GuardTutorialProgress)
end

function u120._syncProgress(a1, a2) -- Line: 266 -- upvalues: TryCall (val), Remotes (val), GuardTutorial (val)
    local v1, v2, v3 = TryCall(function() -- Line: 271 -- upvalues: Remotes (upval), a2 (val)
        return Remotes.GuardOnboarding.AskProgressSync:InvokeServer(a2)
    end)
    if not v1 or v2 ~= true then
        return nil
    end
    local v4, v5 = GuardTutorial.SchemaValidation.Progress(v3)
    assert(v4, v5)
    return GuardTutorial.SanitizeProgress(v3)
end

function u120:_queueSyncRetry() -- Line: 285 -- upvalues: u133 (val)
    if not self._retryScheduled and self._started and self._runtimeStateReady and self._runtimeEnabled then
        u133:AtTrace():Log("[GuardTutorialController] Queueing tutorial progress sync retry")
        self._retryScheduled = true
        task.delay(0.5, function() -- Line: 297 -- upvalues: self (val)
            if self._started and self._runtimeStateReady and self._runtimeEnabled then
                self._retryScheduled = false
                self:RefreshProgress()
                return
            end
            self._retryScheduled = false
        end)
        return
    end
end

function u120:_resolveNextProgress(a2) -- Line: 308
    -- upvalues: GuardTutorial (val), GuardTutorialSteps (val), u122 (val)
    local v1, v2, v3, v4
    if a2.Completed then
        return GuardTutorial.CopyProgress(a2)
    end
    if self._currentProgress.Completed then
        return {Completed = true}
    end
    local v5 = GuardTutorialSteps.GetOrderedStepIds()
    local v6 = 1
    if a2.CurrentStepId ~= nil then
        v2 = GuardTutorialSteps.GetIndex(a2.CurrentStepId)
        local v7 = ("Unknown guard tutorial step id: %*"):format(a2.CurrentStepId)
        assert(v2 ~= nil, v7)
        v6 = v2
    end
    local CurrentStepId_2 = self._currentProgress.CurrentStepId
    if CurrentStepId_2 ~= nil then
        v3 = GuardTutorialSteps.GetIndex(CurrentStepId_2)
        if v3 ~= nil and v6 < v3 then
            v6 = v3
        end
    end
    v3 = #v5
    for i = v6, v3 do
        v2 = v5[i]
        v4 = u122[v2]
        v1 = ("Missing guard tutorial step module for %*"):format(v2)
        assert(v4 ~= nil, v1)
        if not v4.IsSatisfied(self._adapter) then
            return {Completed = false, CurrentStepId = v2}
        end
    end
    return {Completed = true}
end

function u120:_bindCurrentStep() -- Line: 361 -- upvalues: u122 (val)
    local CurrentStepId = self._currentProgress.CurrentStepId
    if not self._currentProgress.Completed and CurrentStepId ~= nil then
        if self._activeStepId == CurrentStepId and self._activeStepCleanup ~= nil then
            return
        end
        self:_clearActiveStep()
        local v1 = u122[CurrentStepId]
        local v2 = ("Missing guard tutorial step module for %*"):format(CurrentStepId)
        assert(v1 ~= nil, v2)
        self._activeStepId = CurrentStepId
        local u33 = nil
        if v1.Present ~= nil then
            u33 = v1.Present(self._presentation, self._adapter)
        end
        local u40 = v1.Bind(self._adapter, function() -- Line: 383 -- upvalues: self (val), CurrentStepId (val)
            if not self._currentProgress.Completed and self._currentProgress.CurrentStepId == CurrentStepId then
                self:RefreshProgress()
                return
            end
        end)

        function self._activeStepCleanup() -- Line: 390 -- upvalues: u40 (val), u33 (ref), self (val)
            u40()
            if u33 ~= nil then
                u33()
            end
            self._presentation:DropEverything()
        end

        return
    end
    self:_clearActiveStep()
end

function u120:_startAfterReadiness() -- Line: 399
    local v1 = self:_readStoredProgress()
    self._currentProgress = v1
    if v1.Completed then
        self:_clearActiveStep()
        return
    end
    self:RefreshProgress()
    self:_maybeShowPauseNotification()
end

function u120.Start(a1) -- Line: 416
    -- upvalues: Remotes (val), GuardTutorial (val), GuardTutorialFlags (val), LocalPlayer (val), MountRace (val)
    -- upvalues: Save (val)
    if a1._started then
        return
    end
    a1._started = true
    a1._trove:Add((Remotes.GuardOnboarding.LiveStateShifted.OnClientEvent:Connect(function(a1_2) -- Line: 424 -- upvalues: GuardTutorial (upval), a1 (val)
        if GuardTutorial.SchemaValidation.RuntimeState(a1_2) then
            a1:_applyRuntimeState(a1_2)
        end
    end)))
    a1._trove:Add((GuardTutorialFlags.PauseNotificationEnabled.Changed:Connect(function(a1_2) -- Line: 432 -- upvalues: a1 (val) -- types: a1_2: boolean
        if not a1_2 then
            a1._pauseNotificationShown = false
            return
        end
        a1:_maybeShowPauseNotification()
    end)))
    task.spawn(function() -- Line: 440 -- upvalues: a1 (val)
        if not a1:_requestRuntimeState() then
            a1:_queueRuntimeStateRetry()
        end
    end)
    a1._trove:Add((a1._adapter.Changed:Connect(function() -- Line: 446 -- upvalues: a1 (val)
        a1:RefreshProgress()
    end)))
    a1._trove:Add(((LocalPlayer:GetAttributeChangedSignal(MountRace.PlayerAttributes.RaceId)):Connect(function() -- Line: 448 -- upvalues: LocalPlayer (upval), MountRace (upval), a1 (val)
        if not (LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil) then
            a1:RefreshProgress()
            return
        end
        a1:_clearActiveStep()
        local v1 = a1
        v1._refreshGeneration = v1._refreshGeneration + 1
    end)))
    a1._trove:Add(((Save.Watch("GuardTutorialProgress")):Connect(function() -- Line: 458 -- upvalues: a1 (val)
        a1:RefreshProgress()
    end)))
    if Save.IsLoaded() then
        a1:_startAfterReadiness()
        return
    end
    local v1 = Save.Loaded:Connect(function() -- Line: 466 -- upvalues: a1 (val)
        a1:_startAfterReadiness()
    end)
    a1._trove:Add(v1)
    if Save.IsLoaded() then
        v1:Disconnect()
        a1:_startAfterReadiness()
    end
end

function u120:RefreshProgress() -- Line: 475
    -- upvalues: Save (val), LocalPlayer (val), MountRace (val), GuardTutorialSteps (val), GuardTutorial (val)
    -- upvalues: OnboardingTiming (val)
    if self._started and self._runtimeStateReady and self._runtimeEnabled and Save.IsLoaded() then
        local v1 = LocalPlayer
        if not (v1:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil) then
            local v2
            self._refreshGeneration = self._refreshGeneration + 1
            local _refreshGeneration = self._refreshGeneration
            v1 = self:_readStoredProgress()
            if not v1.Completed then
                local CurrentStepId = v1.CurrentStepId
                v2 = CurrentStepId ~= nil and GuardTutorialSteps.GetIndex(CurrentStepId) or 0
            else
                v2 = (1 / 0)
            end
            if self._lastStoredIndex ~= nil and v2 < self._lastStoredIndex then
                self._currentProgress = GuardTutorial.CopyProgress(v1)
            end
            self._lastStoredIndex = v2
            v2 = self:_resolveNextProgress(v1)
            local v3 = true
            if v1.Completed == v2.Completed then
                v3 = v1.CurrentStepId ~= v2.CurrentStepId
            end
            self._currentProgress = v2
            self:_bindCurrentStep()
            if self._activeStepId ~= nil then
                OnboardingTiming.Mark("FirstStepBound")
            end
            if not v3 then
                return
            end
            v1 = self:_syncProgress(v2)
            if self._started and _refreshGeneration == self._refreshGeneration then
                if v1 == nil then
                    self:_queueSyncRetry()
                    return
                end
                self._currentProgress = v1
                self:_bindCurrentStep()
                return
            end
            return
        end
    end
end

function u120:Destroy() -- Line: 520
    self._started = false
    self:_clearActiveStep()
    self._trove:Destroy()
    self._presentation:Destroy()
    self._adapter:Destroy()
end

return u120