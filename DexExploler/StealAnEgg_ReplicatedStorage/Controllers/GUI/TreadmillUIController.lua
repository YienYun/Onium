-- Script path: ReplicatedStorage.Controllers.GUI.TreadmillUIController
-- Decompile time: 17.13 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
require(ReplicatedStorage.Shared.Types.AreaEggs)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local EggState = require(ReplicatedStorage.Client.EggState)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local Hud = require(ReplicatedStorage.Client.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local SpeedGainPopup = require(ReplicatedStorage.Client.UI.VFX.SpeedGainPopup)
local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
local Trails = require(ReplicatedStorage.Data.Trails)
local TreadmillCharacterPresentationController = require(script.Parent.Parent.Game.Plots.TreadmillCharacterPresentationController)
local Visibility = require(script.Visibility)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
return {
    Start = function() -- Line: 50
        -- upvalues: Hud (val), Save (val), SpeedPowerProjection (val), TreadmillUtil (val), AdminBoosts (val)
        -- upvalues: Trails (val), Workspace (val), BossMasteryFlags (val), Elapsed (val), Preferences (val)
        -- upvalues: TreadmillVideoGate (val), TreadmillVideoController (val), SpeedGainPopup (val)
        -- upvalues: TreadmillCharacterPresentationController (val), EggState (val), RunService (val), Remotes (val)
        -- upvalues: Visibility (val), Treadmills (val), UserInputService (val)
        local SpeedValue = Hud.Get("SpeedValue")
        local u8 = Hud.Find("SpeedValue", "Treadmill")
        local u13 = Hud.Find("SpeedMultiShine", "Treadmill")
        local TextColor3 = SpeedValue.TextColor3
        local TemporarySpeedBoost = Hud.Find("TemporarySpeedBoost")
        local CurrentBoost = if TemporarySpeedBoost == nil then nil else TemporarySpeedBoost:FindFirstChild("CurrentBoost")
        local u24 = false
        local u25 = nil
        local u26 = 0
        local u27 = 0
        local u28 = nil
        local u29 = 1

        local function visibleSpeedLabel() -- Line: 75 -- upvalues: u25 (ref), u8 (val), SpeedValue (val)
            if u25 ~= nil and u8 ~= nil then
                return u8
            end
            return SpeedValue
        end

        local function updateSpeedPower() -- Line: 82
            -- upvalues: Save (upval), SpeedPowerProjection (upval), TreadmillUtil (upval), u29 (ref)
            -- upvalues: AdminBoosts (upval), TextColor3 (val), Trails (upval), u25 (ref), SpeedValue (val), u8 (val)
            local v1 = Save.Await()
            if not v1 then
                return
            end
            local v2 = SpeedPowerProjection.ReadProjected()
            local v3 = (TreadmillUtil.ResolveEffectiveSpeedPower(v2, u29)) * AdminBoosts.ReadMultiplier(AdminBoosts.SPEED)
            v2 = TreadmillUtil.FormatSpeedPower((math.floor(v3)))
            v3 = TreadmillUtil.ResolveSpeedBoostSpeedStepMultiplier(v1)
            local v4 = TextColor3
            local EquippedTrail = v1.EquippedTrail
            if EquippedTrail ~= nil
                and Trails.TrailNameExists(EquippedTrail)
                and v1.TrailInventory[EquippedTrail] then
                local v5 = Trails.Directory[EquippedTrail]
                v4 = v5.SpeedNumberColor or v5.Rarity.Color
            end
            if u25 ~= nil and TreadmillUtil.DEFAULT_SPEED_STEP_MULTIPLIER < v3 then
                v2 = v2 .. (" <font color=\"#00FF00\">(%*)</font>"):format((TreadmillUtil.FormatSpeedMultiplierValue(v3)))
            end
            SpeedValue.Text = v2
            SpeedValue.TextColor3 = v4
            if u8 ~= nil then
                u8.Text = v2
                u8.TextColor3 = v4
            end
        end

        local function updateTemporarySpeedBoostDisplay() -- Line: 121
            -- upvalues: Save (upval), TreadmillUtil (upval), Workspace (upval), TemporarySpeedBoost (val)
            -- upvalues: CurrentBoost (val), BossMasteryFlags (upval), Elapsed (upval)
            local v1 = Save.Await()
            local v2 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(v1, Workspace:GetServerTimeNow())
            if TemporarySpeedBoost ~= nil and CurrentBoost ~= nil then
                if v2 <= 0 then
                    TemporarySpeedBoost.Visible = false
                    return false
                end
                TemporarySpeedBoost.Visible = true
                CurrentBoost.Text = ("X%* Treadmill Boost (%*)"):format(BossMasteryFlags.TreadmillBoostMultiplier:Get(), (Elapsed(v2)))
                return true
            end
            return v2 > 0
        end

        local function startTemporarySpeedBoostCountdown() -- Line: 144
            -- upvalues: u27 (ref), updateTemporarySpeedBoostDisplay (val), updateSpeedPower (val)
            u27 = u27 + 1
            local u2 = u27
            if not updateTemporarySpeedBoostDisplay() then
                return
            end
            task.spawn(function() -- Line: 152
                -- upvalues: u2 (val), u27 (upval), updateTemporarySpeedBoostDisplay (upval), updateSpeedPower (upval)
                while u2 == u27 do
                    task.wait(1)
                    if not updateTemporarySpeedBoostDisplay() then
                        updateSpeedPower()
                        return
                    end
                    updateSpeedPower()
                end
            end)
        end

        local function stopActiveTreadmillVisualSimulation() -- Line: 164
            -- upvalues: u28 (ref), SpeedPowerProjection (upval), u26 (ref)
            local v1 = u28
            if v1 ~= nil then
                SpeedPowerProjection.CloseSession(v1.Token)
            end
            u26 = u26 + 1
            u28 = nil
        end

        local function applyTreadmillVideoSetting(a1) -- Line: 173
            -- upvalues: u25 (ref), Preferences (upval), TreadmillVideoGate (upval), TreadmillVideoController (upval)
            -- upvalues: Save (upval)
            local v1 = u25
            if v1 ~= nil
                and not Preferences.IsOn("DisableVideos")
                and not TreadmillVideoGate.IsVideoPlayerDisabled() then
                if a1 ~= nil then
                    TreadmillVideoController.Start(v1, a1)
                    return
                end
                local v2 = Save.Await()
                assert(v2 ~= nil, "Save data must be loaded before enabling treadmill videos")
                TreadmillVideoController.Start(v1, v2.TreadmillMediaFeedState)
                return
            end
            TreadmillVideoController.Stop()
        end

        local function resolveCurrentSpeedPowerPerStep(a1, a2) -- Line: 194
            -- upvalues: TreadmillUtil (upval), Save (upval)
            return TreadmillUtil.ResolveSpeedPowerPerStep(Save.Await(), a1, a2)
        end

        local function flushPendingScreenSpeedGain(a1) -- Line: 198
            -- upvalues: SpeedGainPopup (upval), u25 (ref), u8 (val), SpeedValue (val), SpeedPowerProjection (upval)
            if a1.PendingScreenSpeedPowerDelta <= 0 then
                return
            end
            local PendingScreenSpeedPowerDelta = a1.PendingScreenSpeedPowerDelta
            SpeedGainPopup.Play(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, PendingScreenSpeedPowerDelta, nil, function() -- Line: 204 -- upvalues: SpeedPowerProjection (upval), a1 (val), PendingScreenSpeedPowerDelta (val)
                SpeedPowerProjection.CreditRevealedGain(a1.Token, PendingScreenSpeedPowerDelta)
            end)
            a1.PendingScreenSpeedPowerDelta = 0
        end

        local function resetNextScreenPopupAt(a1, a2) -- Line: 210
            -- upvalues: TreadmillUtil (upval)
            a1.NextScreenPopupAt = a2 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
        end

        local function handleTransparentModeSpeedGainPulse(a1, a2, a3) -- Line: 214
            -- upvalues: SpeedGainPopup (upval), u25 (ref), u8 (val), SpeedValue (val), SpeedPowerProjection (upval)
            -- upvalues: TreadmillUtil (upval)
            a1.PendingScreenSpeedPowerDelta = a1.PendingScreenSpeedPowerDelta + a2
            if a1.NextScreenPopupAt <= a3 then
                if not (a1.PendingScreenSpeedPowerDelta <= 0) then
                    local PendingScreenSpeedPowerDelta = a1.PendingScreenSpeedPowerDelta
                    SpeedGainPopup.Play(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, PendingScreenSpeedPowerDelta, nil, function() -- Line: 204 -- upvalues: SpeedPowerProjection (upval), a1 (val), PendingScreenSpeedPowerDelta (val)
                        SpeedPowerProjection.CreditRevealedGain(a1.Token, PendingScreenSpeedPowerDelta)
                    end)
                    a1.PendingScreenSpeedPowerDelta = 0
                end
                a1.NextScreenPopupAt = a3 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
            end
        end

        local function handleVisibleModeSpeedGainPulse(a1, a2, a3) -- Line: 226
            -- upvalues: TreadmillUtil (upval), SpeedGainPopup (upval), u25 (ref), u8 (val), SpeedValue (val)
            -- upvalues: SpeedPowerProjection (upval)
            a1.PendingScreenSpeedPowerDelta = 0
            a1.NextScreenPopupAt = a3 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
            local PlayWalk = SpeedGainPopup.PlayWalk
            local RarityColor = a1.RarityColor
            PlayWalk(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, a2, RarityColor, function() -- Line: 233 -- upvalues: SpeedPowerProjection (upval), a1 (val), a2 (val)
                SpeedPowerProjection.CreditRevealedGain(a1.Token, a2)
            end)
        end

        local function startActiveTreadmillVisualSimulation(a1, a2, a3) -- Line: 264
            -- upvalues: u28 (ref), SpeedPowerProjection (upval), u26 (ref), Workspace (upval), Save (upval)
            -- upvalues: TreadmillUtil (upval), TreadmillCharacterPresentationController (upval), SpeedGainPopup (upval)
            -- upvalues: u25 (ref), u8 (val), SpeedValue (val)
            local v1 = u28
            if v1 ~= nil then
                SpeedPowerProjection.CloseSession(v1.Token)
            end
            u26 = u26 + 1
            u28 = nil
            local ServerTimeNow = Workspace:GetServerTimeNow()
            local v2 = Save.Await()
            assert(v2 ~= nil, "Save data must be loaded before starting treadmill simulation")
            local u24 = u26
            u28 = {
                PendingScreenSpeedPowerDelta = 0,
                NextScreenPopupAt = ServerTimeNow + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL,
                NextSpeedAwardAt = a2,
                RarityColor = a3,
                SimulatedSpeedPower = TreadmillUtil.NormalizeSpeedPower(v2.SpeedPower),
                SpeedMultiplier = a1,
                Token = u24,
            }
            SpeedPowerProjection.OpenSession(u24)
            task.spawn(function() -- Line: 286
                -- upvalues: u28 (upval), u24 (val), Workspace (upval), TreadmillUtil (upval), Save (upval)
                -- upvalues: TreadmillCharacterPresentationController (upval), SpeedGainPopup (upval), u25 (upval)
                -- upvalues: u8 (upval), SpeedValue (upval), SpeedPowerProjection (upval)
                local NextSpeedAwardAt, PlayWalk, RarityColor, SpeedMultiplier, v1, v2, v3, v4
                while true do
                    v1 = u28
                    if v1 == nil or v1.Token ~= u24 then
                        break
                    end
                    v3 = math.max(v1.NextSpeedAwardAt - (Workspace:GetServerTimeNow()), 0)
                    if v3 > 0 then
                        task.wait(v3)
                    end
                    local u94 = u28
                    if u94 == nil or u94.Token ~= u24 then
                        break
                    end
                    while true do
                        v2 = Workspace:GetServerTimeNow()
                        if v2 < u94.NextSpeedAwardAt then
                            break
                        end
                        NextSpeedAwardAt = u94.NextSpeedAwardAt
                        SpeedMultiplier = u94.SpeedMultiplier
                        local u36 = TreadmillUtil.ResolveSpeedPowerPerStep(Save.Await(), SpeedMultiplier, NextSpeedAwardAt)
                        u94.SimulatedSpeedPower = u94.SimulatedSpeedPower + u36
                        if not TreadmillCharacterPresentationController.IsLocalCharacterFullyTransparent() then
                            u94.PendingScreenSpeedPowerDelta = 0
                            u94.NextScreenPopupAt = v2 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
                            PlayWalk = SpeedGainPopup.PlayWalk
                            RarityColor = u94.RarityColor
                            PlayWalk(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, u36, RarityColor, function() -- Line: 233 -- upvalues: SpeedPowerProjection (upval), u94 (val), u36 (val)
                                SpeedPowerProjection.CreditRevealedGain(u94.Token, u36)
                            end)
                        else
                            u94.PendingScreenSpeedPowerDelta = u94.PendingScreenSpeedPowerDelta + u36
                            if u94.NextScreenPopupAt <= v2 then
                                if not (u94.PendingScreenSpeedPowerDelta <= 0) then
                                    local PendingScreenSpeedPowerDelta = u94.PendingScreenSpeedPowerDelta
                                    SpeedGainPopup.Play(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, PendingScreenSpeedPowerDelta, nil, function() -- Line: 204 -- upvalues: SpeedPowerProjection (upval), u94 (val), PendingScreenSpeedPowerDelta (val)
                                        SpeedPowerProjection.CreditRevealedGain(u94.Token, PendingScreenSpeedPowerDelta)
                                    end)
                                    u94.PendingScreenSpeedPowerDelta = 0
                                end
                                u94.NextScreenPopupAt = v2 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
                            end
                        end
                        u94 = u28
                        if u94 ~= nil and u94.Token == u24 then
                            v4 = TreadmillUtil.SpeedPowerToProgressionWalkSpeed(u94.SimulatedSpeedPower)
                            u94.NextSpeedAwardAt = NextSpeedAwardAt + TreadmillUtil.ResolveWalkSpeedPowerAwardInterval(v4)
                            continue
                        end
                        return
                    end
                end
            end)
        end

        EggState.CarryChanged:Connect(function(a1) -- Line: 336 -- upvalues: u29 (ref), updateSpeedPower (val)
            u29 = a1.SpeedMultiplier
            updateSpeedPower()
        end)
        Save.Await()
        SpeedGainPopup.HideSource()
        TreadmillVideoController.Stop()
        TreadmillCharacterPresentationController.StopCameraTransparency()
        updateSpeedPower()
        u27 = u27 + 1
        local u69 = u27
        if updateTemporarySpeedBoostDisplay() then
            task.spawn(function() -- Line: 152
                -- upvalues: u69 (val), u27 (ref), updateTemporarySpeedBoostDisplay (val), updateSpeedPower (val)
                while u69 == u27 do
                    task.wait(1)
                    if not updateTemporarySpeedBoostDisplay() then
                        updateSpeedPower()
                        return
                    end
                    updateSpeedPower()
                end
            end)
        end
        if u13 ~= nil then
            RunService.RenderStepped:Connect(function(a1) -- Line: 353 -- upvalues: u13 (val) -- types: a1: number
                u13.Rotation = (u13.Rotation + a1 * 20) % 360
            end)
        end
        SpeedPowerProjection.Changed:Connect(updateSpeedPower)
        Save.WatchFields("SpeedBoostTierIndex", updateSpeedPower)
        Save.WatchFields({"EquippedTrail", "TrailInventory"}, updateSpeedPower)
        AdminBoosts.Observe(AdminBoosts.SPEED):Connect(updateSpeedPower)
        BossMasteryFlags.TreadmillBoostMultiplier.Changed:Connect(function() -- Line: 363 -- upvalues: updateSpeedPower (val), updateTemporarySpeedBoostDisplay (val)
            updateSpeedPower()
            updateTemporarySpeedBoostDisplay()
        end)
        Save.WatchFields("TemporarySpeedBoostRemainingSeconds", function() -- Line: 367 -- upvalues: updateSpeedPower (val), u27 (ref), updateTemporarySpeedBoostDisplay (val)
            updateSpeedPower()
            u27 = u27 + 1
            local u4 = u27
            if not updateTemporarySpeedBoostDisplay() then
                return
            end
            task.spawn(function() -- Line: 152
                -- upvalues: u4 (val), u27 (upval), updateTemporarySpeedBoostDisplay (upval), updateSpeedPower (upval)
                while u4 == u27 do
                    task.wait(1)
                    if not updateTemporarySpeedBoostDisplay() then
                        updateSpeedPower()
                        return
                    end
                    updateSpeedPower()
                end
            end)
        end)
        Save.WatchFields("TemporarySpeedBoostActiveStartedAt", function() -- Line: 371 -- upvalues: updateSpeedPower (val), u27 (ref), updateTemporarySpeedBoostDisplay (val)
            updateSpeedPower()
            u27 = u27 + 1
            local u4 = u27
            if not updateTemporarySpeedBoostDisplay() then
                return
            end
            task.spawn(function() -- Line: 152
                -- upvalues: u4 (val), u27 (upval), updateTemporarySpeedBoostDisplay (upval), updateSpeedPower (upval)
                while u4 == u27 do
                    task.wait(1)
                    if not updateTemporarySpeedBoostDisplay() then
                        updateSpeedPower()
                        return
                    end
                    updateSpeedPower()
                end
            end)
        end)
        Remotes.Treadmill.SpeedGained.OnClientEvent:Connect(function(a1, a2) -- Line: 238
            -- upvalues: u28 (ref), SpeedPowerProjection (upval), SpeedGainPopup (upval), u25 (ref), u8 (val)
            -- upvalues: SpeedValue (val), updateSpeedPower (val)
            if a2 == "Treadmill" and u28 ~= nil then
                return
            end
            if a2 == "Instant" and u28 ~= nil then
                local v1 = u28
                v1.SimulatedSpeedPower = v1.SimulatedSpeedPower + a1
                assert(
                    SpeedPowerProjection.CreditRevealedGain(v1.Token, a1),
                    "Instant Speed Power gain must target the active treadmill projection"
                )
                SpeedGainPopup.Play(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, a1, nil, updateSpeedPower)
                return
            end
            updateSpeedPower()
            if a2 == "Walk" then
                SpeedGainPopup.PlayWalk(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, a1, nil, updateSpeedPower)
                return
            end
            SpeedGainPopup.Play(if u25 == nil then SpeedValue else if u8 == nil then SpeedValue else u8, a1, nil, updateSpeedPower)
        end)
        local DisableVideos = Preferences.IsOn("DisableVideos")
        Preferences.Observe("DisableVideos", function(a1) -- Line: 379
            -- upvalues: DisableVideos (ref), u25 (ref), Preferences (upval), TreadmillVideoGate (upval)
            -- upvalues: TreadmillVideoController (upval), Save (upval)
            if a1 == DisableVideos then
                return
            end
            DisableVideos = a1
            local v1 = u25
            if v1 ~= nil
                and not Preferences.IsOn("DisableVideos")
                and not TreadmillVideoGate.IsVideoPlayerDisabled() then
                local v2 = Save.Await()
                assert(v2 ~= nil, "Save data must be loaded before enabling treadmill videos")
                TreadmillVideoController.Start(v1, v2.TreadmillMediaFeedState)
                return
            end
            TreadmillVideoController.Stop()
        end)
        TreadmillVideoGate.Changed:Connect(function() -- Line: 387
            -- upvalues: u25 (ref), Preferences (upval), TreadmillVideoGate (upval), TreadmillVideoController (upval)
            -- upvalues: Save (upval)
            local v1 = u25
            if v1 ~= nil
                and not Preferences.IsOn("DisableVideos")
                and not TreadmillVideoGate.IsVideoPlayerDisabled() then
                local v2 = Save.Await()
                assert(v2 ~= nil, "Save data must be loaded before enabling treadmill videos")
                TreadmillVideoController.Start(v1, v2.TreadmillMediaFeedState)
                return
            end
            TreadmillVideoController.Stop()
        end)
        Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 392
            -- upvalues: u25 (ref), u24 (ref), u28 (ref), SpeedPowerProjection (upval), u26 (ref)
            -- upvalues: updateSpeedPower (val), TreadmillVideoController (upval)
            -- upvalues: TreadmillCharacterPresentationController (upval), Visibility (upval), Treadmills (upval)
            -- upvalues: startActiveTreadmillVisualSimulation (val), applyTreadmillVideoSetting (val)
            local v1
            u25 = a1
            u24 = false
            if a1 == nil then
                v1 = u28
                if v1 ~= nil then
                    SpeedPowerProjection.CloseSession(v1.Token)
                end
                u26 = u26 + 1
                u28 = nil
                updateSpeedPower()
                TreadmillVideoController.Stop()
                TreadmillCharacterPresentationController.StopCameraTransparency()
                Visibility.Apply(false)
                return
            end
            assert(typeof(a2) == "number", "Active treadmill speed multiplier must be a number")
            assert(typeof(a3) == "number", "Active treadmill next award time must be a number")
            assert(typeof(a4) == "table", "Active treadmill media feed state must be a table")
            v1 = Treadmills.GetById(a1)
            local v2 = ("Treadmill \"%*\" does not exist"):format(a1)
            assert(v1 ~= nil, v2)
            local Color = v1.Rarity.Color
            updateSpeedPower()
            Visibility.Apply(true)
            startActiveTreadmillVisualSimulation(a2, a3, Color)
            TreadmillCharacterPresentationController.StartCameraTransparency(a1)
            applyTreadmillVideoSetting(a4)
        end)
        UserInputService.JumpRequest:Connect(function() -- Line: 433 -- upvalues: u25 (ref), u24 (ref), Remotes (upval)
            if u25 ~= nil and not u24 then
                u24 = true
                if Remotes.Treadmill.AskDoff:InvokeServer() ~= true then
                    u24 = false
                end
                return
            end
        end)
    end,
}