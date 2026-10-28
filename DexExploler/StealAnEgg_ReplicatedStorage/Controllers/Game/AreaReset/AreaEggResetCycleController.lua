-- Script path: ReplicatedStorage.Controllers.Game.AreaReset.AreaEggResetCycleController
-- Decompile time: 5.26 ms

local ServerClock = require(game:GetService("ReplicatedStorage").Shared.Util.ServerClock)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local Audio = require(ReplicatedStorage.Shared.Audio)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Signal = require(ReplicatedStorage.Packages.Signal)
local WarmSounds = require(ReplicatedStorage.Shared.Utils.Preload).WarmSounds
local DayTransitionSoundId = AreaEggResetCycle.DayTransitionSoundId
local u58 = nil
local u59 = {}
u59.PhaseChanged = Signal.new()

function u59.GetPhase() -- Line: 32 -- upvalues: u58 (ref)
    return u58
end

function u59.Start() -- Line: 36
    -- upvalues: Workspace (val), AreaEggCycle (val), AreaEggResetCycle (val), u58 (ref), LightingController (val)
    -- upvalues: MusicDirector (val), u59 (val), DayTransitionSoundId (val), Audio (val), SoundService (val)
    -- upvalues: ServerClock (val), WarmSounds (val)
    local function resolvePhase(a1) -- Line: 41
        -- upvalues: Workspace (upval), AreaEggCycle (upval), AreaEggResetCycle (upval)
        if Workspace:GetAttribute("Event_AdminAbuse") == true then
            return "Day"
        end
        if AreaEggCycle.IsNightPhase(a1) then
            return "Night"
        end
        if AreaEggCycle.IsWithinNightTransition(
            a1,
            AreaEggResetCycle.NightLightingTransitionSeconds,
            AreaEggResetCycle.NightLightingStartDelaySeconds
        ) then
            return "NightTransition"
        end
        return "Day"
    end

    local function setPhase(a1, a2, a3) -- Line: 60
        -- upvalues: u58 (upval), AreaEggCycle (upval), AreaEggResetCycle (upval), LightingController (upval)
        -- upvalues: MusicDirector (upval), u59 (upval), DayTransitionSoundId (upval), Audio (upval)
        -- upvalues: SoundService (upval)
        local v1
        if u58 == a1 then
            return
        end
        local v2 = u58
        u58 = a1
        if a1 == "NightTransition" then
            v1 = math.max((AreaEggCycle.NightStartTime(a3)) + AreaEggResetCycle.NightLightingStartDelaySeconds - a3, 0)
            LightingController.SetLayer(
                "AreaEggResetNight",
                AreaEggResetCycle.NightLighting,
                AreaEggResetCycle.LightingModifierPriority,
                v1
            )
            MusicDirector.SetResetNight(false)
            u59.PhaseChanged:Fire(a1, v1)
            return
        end
        if a1 == "Night" then
            v1 = math.max((AreaEggCycle.NightStartTime(a3)) + AreaEggResetCycle.NightLightingStartDelaySeconds - a3, 0)
            if v2 ~= "NightTransition" then
                LightingController.SetLayer(
                    "AreaEggResetNight",
                    AreaEggResetCycle.NightLighting,
                    AreaEggResetCycle.LightingModifierPriority,
                    v1
                )
            end
            MusicDirector.SetResetNight(true, true)
            u59.PhaseChanged:Fire(a1, v1)
            return
        end
        local DayLightingTransitionSeconds = if a2 then 0 else if v2 ~= nil then AreaEggResetCycle.DayLightingTransitionSeconds else 0
        LightingController.ClearLayer("AreaEggResetNight", DayLightingTransitionSeconds)
        MusicDirector.SetResetNight(false)
        if not a2 and DayTransitionSoundId ~= nil then
            Audio.Play(DayTransitionSoundId, SoundService)
        end
        u59.PhaseChanged:Fire(a1, DayLightingTransitionSeconds)
    end

    local function runCycle() -- Line: 109
        -- upvalues: ServerClock (upval), Workspace (upval), AreaEggCycle (upval), AreaEggResetCycle (upval)
        -- upvalues: setPhase (val)
        local v1, v2
        local v3 = true
        while true do
            v1 = ServerClock.Now()
            if Workspace:GetAttribute("Event_AdminAbuse") ~= true then
                setPhase(if not AreaEggCycle.IsNightPhase(v1) then if not AreaEggCycle.IsWithinNightTransition(
                    v1,
                    AreaEggResetCycle.NightLightingTransitionSeconds,
                    AreaEggResetCycle.NightLightingStartDelaySeconds
                ) then "Day" else "NightTransition" else "Night", v3, v1)
            else
                setPhase("Day", v3, v1)
            end
            task.wait((math.clamp((if v2 ~= "Night" then if v2 ~= "NightTransition" then AreaEggCycle.NightTransitionStartTime(
                v1,
                AreaEggResetCycle.NightLightingTransitionSeconds,
                AreaEggResetCycle.NightLightingStartDelaySeconds
            ) else AreaEggCycle.NightStartTime(v1) else AreaEggCycle.NextResetTime(v1)) - ServerClock.Now(), 0.05, AreaEggCycle.SchedulePollSeconds)))
        end
    end

    if DayTransitionSoundId ~= nil then
        task.spawn(WarmSounds, DayTransitionSoundId)
    end
    ;(Workspace:GetAttributeChangedSignal("Event_AdminAbuse")):Connect(function() -- Line: 148
        -- upvalues: ServerClock (upval), setPhase (val), Workspace (upval), AreaEggCycle (upval)
        -- upvalues: AreaEggResetCycle (upval)
        local v1 = ServerClock.Now()
        setPhase(if Workspace:GetAttribute("Event_AdminAbuse") ~= true then if not AreaEggCycle.IsNightPhase(v1) then if not AreaEggCycle.IsWithinNightTransition(
            v1,
            AreaEggResetCycle.NightLightingTransitionSeconds,
            AreaEggResetCycle.NightLightingStartDelaySeconds
        ) then "Day" else "NightTransition" else "Night" else "Day", false, v1)
    end)
    runCycle()
end

return u59