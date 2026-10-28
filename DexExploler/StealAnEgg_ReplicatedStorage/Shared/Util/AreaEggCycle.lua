-- Script path: ReplicatedStorage.Shared.Util.AreaEggCycle
-- Decompile time: 17.06 ms

local AreaEggCycle = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).AreaEggCycle
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)

local function periodSeconds() -- Line: 15 -- upvalues: Workspace (val), AreaEggCycle (val)
    return Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
end

local function defaultNightSeconds() -- Line: 19 -- upvalues: Workspace (val), AreaEggCycle (val)
    return Workspace:GetAttribute("AreaEggCycleDefaultNightSeconds") or AreaEggCycle.NIGHT_SECONDS_DEFAULT
end

local u39 = t.strict(t.boolean)
local u44 = t.strict(t.optional(t.number))
local u47 = t.strict(t.number)
local u48 = {EndingSoonSeconds = 20, FinalBlinkSeconds = 10, SchedulePollSeconds = 0.25}
local Attribute = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
u48.ResetPeriodSeconds = Attribute
u48.NightGrowthSkipSeconds = AreaEggCycle.NIGHT_SKIP_SECONDS
u48.MinNightDurationSeconds = AreaEggCycle.NIGHT_SECONDS_FLOOR

local function scheduleNumber(a1, a2) -- Line: 48 -- upvalues: Workspace (val) -- types: a1: string, a2: number
    local Attribute = Workspace:GetAttribute(a1)
    if type(Attribute) ~= "number" then
        return a2
    end
    return Attribute
end

local function frozenAt(a1) -- Line: 60 -- upvalues: Workspace (val) -- types: a1: number
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    return (math.min(a1, if type(Attribute) == "number" then Attribute else a1))
end

local function requireServer() -- Line: 64 -- upvalues: RunService (val)
    assert(RunService:IsServer(), "Only the server may rewrite the area egg schedule")
end

local function requireLegalNightLength(a1) -- Line: 68
    -- upvalues: AreaEggCycle (val), Workspace (val)
    local v1 = false
    if AreaEggCycle.NIGHT_SECONDS_FLOOR <= a1 then
        local Attribute = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
        v1 = a1 <= Attribute
    end
    assert(v1, (("A night of %*s falls outside %*..%*"):format(
        a1,
        AreaEggCycle.NIGHT_SECONDS_FLOOR,
        Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    )))
end

function u48.NightLengthSeconds() -- Line: 75 -- upvalues: Workspace (val), AreaEggCycle (val)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDefaultNightSeconds") or AreaEggCycle.NIGHT_SECONDS_DEFAULT
    local Attribute_2 = Workspace:GetAttribute("AreaEggCycleNightSeconds")
    return (math.clamp(
        if type(Attribute_2) == "number" then Attribute_2 else Attribute,
        AreaEggCycle.NIGHT_SECONDS_FLOOR,
        Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    ))
end

function u48.NightGrowthRate() -- Line: 83 -- upvalues: AreaEggCycle (val), u48 (val)
    return AreaEggCycle.NIGHT_SKIP_SECONDS / u48.NightLengthSeconds()
end

function u48.IsRunning() -- Line: 87 -- upvalues: Workspace (val)
    return Workspace:GetAttribute("AreaEggCycleDisabledAt") == nil
end

function u48.HasScheduleOverride() -- Line: 91 -- upvalues: Workspace (val), u48 (val)
    if Workspace:GetAttribute("AreaEggCycleAnchorAt") ~= nil
        or Workspace:GetAttribute("AreaEggCycleNightSeconds") ~= nil then
        return true
    end
    return not u48.IsRunning()
end

function u48.PeriodStartTime(a1) -- Line: 103
    -- upvalues: u47 (val), Workspace (val), AreaEggCycle (val)
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleAnchorIndex")
    local v1 = if type(Attribute) == "number" then Attribute else 0
    local Attribute_2 = Workspace:GetAttribute("AreaEggCycleAnchorAt")
    local v2 = if type(Attribute_2) == "number" then Attribute_2 else 0
    local v3 = a1 - v1
    local Attribute_3 = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    return v2 + v3 * Attribute_3
end

function u48.PeriodIndexAt(a1) -- Line: 111
    -- upvalues: u47 (val), Workspace (val), AreaEggCycle (val)
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    local v1 = math.min(a1, if type(Attribute) == "number" then Attribute else a1)
    local Attribute_2 = Workspace:GetAttribute("AreaEggCycleAnchorAt")
    local v2 = v1 - (if type(Attribute_2) == "number" then Attribute_2 else 0)
    local Attribute_3 = Workspace:GetAttribute("AreaEggCycleAnchorIndex")
    return (math.max(
        (if type(Attribute_3) == "number" then Attribute_3 else 0) + math.floor(v2 / (Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS)),
        0
    ))
end

function u48.NextResetTime(a1) -- Line: 121 -- upvalues: u47 (val), u48 (val) -- types: a1: number
    u47(a1)
    return u48.PeriodStartTime(u48.PeriodIndexAt(a1) + 1)
end

function u48.SecondsUntilReset(a1) -- Line: 127 -- upvalues: u47 (val), Workspace (val), u48 (val) -- types: a1: number
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    local v1 = math.min(a1, if type(Attribute) == "number" then Attribute else a1)
    return (math.max(0, (u48.NextResetTime(v1)) - v1))
end

function u48.NightStartTime(a1) -- Line: 135 -- upvalues: u47 (val), Workspace (val), u48 (val) -- types: a1: number
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    return (u48.NextResetTime((math.min(a1, if type(Attribute) == "number" then Attribute else a1)))) - u48.NightLengthSeconds()
end

function u48.IsNightPhase(a1) -- Line: 143 -- upvalues: u47 (val), Workspace (val), u48 (val) -- types: a1: number
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    return (u48.SecondsUntilReset((math.min(a1, if type(Attribute) == "number" then Attribute else a1)))) <= u48.NightLengthSeconds()
end

function u48.NightTransitionStartTime(a1, a2, a3) -- Line: 151
    -- upvalues: u47 (val), u48 (val)
    u47(a1)
    u47(a2)
    u47(a3)
    return u48.NightStartTime(a1) - a2 + a3
end

function u48.IsWithinNightTransition(a1, a2, a3) -- Line: 163
    -- upvalues: u47 (val), Workspace (val), u48 (val)
    u47(a1)
    u47(a2)
    u47(a3)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    local v1 = math.min(a1, if type(Attribute) == "number" then Attribute else a1)
    if u48.IsNightPhase(v1) then
        return false
    end
    return u48.NightTransitionStartTime(v1, a2, a3) <= v1
end

function u48.ActivePeriodIndexAt(a1) -- Line: 183
    -- upvalues: u47 (val), Workspace (val), u48 (val)
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    local v1 = math.min(a1, if type(Attribute) == "number" then Attribute else a1)
    local v2 = u48.PeriodIndexAt(v1)
    if u48.IsNightPhase(v1) then
        return v2 + 1
    end
    return v2
end

function u48.SecondsUntilPhaseEnd(a1) -- Line: 196
    -- upvalues: u47 (val), Workspace (val), u48 (val)
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    local v1 = math.min(a1, if type(Attribute) == "number" then Attribute else a1)
    local v2 = u48.SecondsUntilReset(v1)
    if u48.IsNightPhase(v1) then
        return v2
    end
    return (math.max(0, v2 - (u48.NightLengthSeconds())))
end

function u48.NextNightTime(a1) -- Line: 209
    -- upvalues: u47 (val), Workspace (val), u48 (val), AreaEggCycle (val)
    u47(a1)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    local v1 = math.min(a1, if type(Attribute) == "number" then Attribute else a1)
    local v2 = u48.NightStartTime(v1)
    if v1 < v2 then
        return v2
    end
    local Attribute_2 = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    return v2 + Attribute_2
end

function u48.NightGrowthCreditAt(a1, a2) -- Line: 222
    -- upvalues: u47 (val), Workspace (val), u48 (val)
    u47(a1)
    u47(a2)
    local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    return (math.clamp((math.min(a1, if type(Attribute) == "number" then Attribute else a1)) - a2, 0, (u48.NightLengthSeconds()))) * u48.NightGrowthRate()
end

function u48.IsCloseToReset(a1) -- Line: 232 -- upvalues: u47 (val) -- types: a1: number
    u47(a1)
    return a1 <= 20
end

function u48.IsInFinalBlink(a1) -- Line: 238 -- upvalues: u47 (val) -- types: a1: number
    u47(a1)
    return a1 <= 10
end

function u48.IsBlinkOnRedFrame(a1) -- Line: 244 -- upvalues: u47 (val) -- types: a1: number
    u47(a1)
    return math.ceil(a1) % 2 == 0
end

function u48.IsNearResetBoundary(a1, a2) -- Line: 250
    -- upvalues: u47 (val), u48 (val), Workspace (val), AreaEggCycle (val)
    u47(a1)
    u47(a2)
    local v1 = u48.NextNightTime(a1)
    if v1 - a1 <= a2 then
        return true
    end
    local Attribute = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    return a1 - (v1 - Attribute) <= a2
end

function u48.SetRunning(a1) -- Line: 263
    -- upvalues: RunService (val), u39 (val), u48 (val), Workspace (val)
    assert(RunService:IsServer(), "Only the server may rewrite the area egg schedule")
    u39(a1)
    if u48.IsRunning() == a1 then
        return
    end
    Workspace:SetAttribute("AreaEggCycleDisabledAt", if not a1 then Workspace:GetServerTimeNow() else nil)
end

function u48.OverrideNightLength(a1) -- Line: 274
    -- upvalues: RunService (val), u44 (val), AreaEggCycle (val), Workspace (val)
    assert(RunService:IsServer(), "Only the server may rewrite the area egg schedule")
    u44(a1)
    if a1 ~= nil then
        local v1 = false
        if AreaEggCycle.NIGHT_SECONDS_FLOOR <= a1 then
            local Attribute = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
            v1 = a1 <= Attribute
        end
        assert(v1, (("A night of %*s falls outside %*..%*"):format(
            a1,
            AreaEggCycle.NIGHT_SECONDS_FLOOR,
            Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
        )))
    end
    Workspace:SetAttribute("AreaEggCycleNightSeconds", a1)
end

function u48.BeginNight(a1, a2) -- Line: 285
    -- upvalues: RunService (val), u47 (val), u44 (val), u48 (val), AreaEggCycle (val), Workspace (val)
    assert(RunService:IsServer(), "Only the server may rewrite the area egg schedule")
    u47(a1)
    u44(a2)
    if u48.IsNightPhase(a1) then
        return false, "Night is already running"
    end
    local v1 = a2 or u48.NightLengthSeconds()
    local v2 = false
    if AreaEggCycle.NIGHT_SECONDS_FLOOR <= v1 then
        local Attribute = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
        v2 = v1 <= Attribute
    end
    assert(v2, (("A night of %*s falls outside %*..%*"):format(
        v1,
        AreaEggCycle.NIGHT_SECONDS_FLOOR,
        Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    )))
    local v3 = u48.PeriodIndexAt(a1)
    Workspace:SetAttribute("AreaEggCycleNightSeconds", v1)
    Workspace:SetAttribute("AreaEggCycleAnchorIndex", v3 + 1)
    Workspace:SetAttribute("AreaEggCycleAnchorAt", a1 + v1)
    return true, nil
end

function u48.FinishNight(a1) -- Line: 308
    -- upvalues: RunService (val), u47 (val), u48 (val), Workspace (val)
    assert(RunService:IsServer(), "Only the server may rewrite the area egg schedule")
    u47(a1)
    if not u48.IsNightPhase(a1) then
        return false, "Night is not running"
    end
    Workspace:SetAttribute("AreaEggCycleAnchorIndex", (u48.ActivePeriodIndexAt(a1)))
    Workspace:SetAttribute("AreaEggCycleAnchorAt", a1)
    return true, nil
end

function u48.PostponeReset(a1) -- Line: 323
    -- upvalues: RunService (val), u47 (val), Workspace (val), u48 (val)
    assert(RunService:IsServer(), "Only the server may rewrite the area egg schedule")
    u47(a1)
    Workspace:SetAttribute("AreaEggCycleAnchorIndex", (u48.PeriodIndexAt(a1)))
    Workspace:SetAttribute("AreaEggCycleAnchorAt", a1)
end

function u48.ResetSchedule() -- Line: 331 -- upvalues: RunService (val), Workspace (val)
    assert(RunService:IsServer(), "Only the server may rewrite the area egg schedule")
    Workspace:SetAttribute("AreaEggCycleAnchorAt", nil)
    Workspace:SetAttribute("AreaEggCycleAnchorIndex", nil)
    Workspace:SetAttribute("AreaEggCycleNightSeconds", nil)
    Workspace:SetAttribute("AreaEggCycleDisabledAt", nil)
end

local NIGHT_SECONDS_FLOOR = AreaEggCycle.NIGHT_SECONDS_FLOOR
if RunService:IsServer() then
    Workspace:SetAttribute("AreaEggCyclePeriodSeconds", AreaEggCycle.PERIOD_SECONDS)
    Workspace:SetAttribute("AreaEggCycleDefaultNightSeconds", AreaEggCycle.NIGHT_SECONDS_DEFAULT)
end
require(ReplicatedStorage.Shared.Flags.BalanceConfig).Changed:Connect(function(a1) -- Line: 342
    -- upvalues: RunService (val), Workspace (val), AreaEggCycle (val), NIGHT_SECONDS_FLOOR (ref), u48 (val)
    if a1 ~= "Game.Balance.AreaEggCycle" then
        return
    end
    if RunService:IsServer() then
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local Attribute = Workspace:GetAttribute("AreaEggCycleDisabledAt")
        local v1 = math.min(ServerTimeNow, if type(Attribute) == "number" then Attribute else ServerTimeNow)
        local Attribute_2 = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
        local Attribute_3 = Workspace:GetAttribute("AreaEggCycleDefaultNightSeconds") or AreaEggCycle.NIGHT_SECONDS_DEFAULT
        local Attribute_4 = Workspace:GetAttribute("AreaEggCycleNightSeconds")
        local v2 = math.min(NIGHT_SECONDS_FLOOR, Attribute_2)
        local v3 = math.clamp(if type(Attribute_4) == "number" then Attribute_4 else Attribute_3, v2, Attribute_2)
        local PERIOD_SECONDS = AreaEggCycle.PERIOD_SECONDS
        local NIGHT_SECONDS_DEFAULT = AreaEggCycle.NIGHT_SECONDS_DEFAULT
        local Attribute_5 = Workspace:GetAttribute("AreaEggCycleNightSeconds")
        local NIGHT_SECONDS_FLOOR_2 = AreaEggCycle.NIGHT_SECONDS_FLOOR
        v2 = math.clamp(if type(Attribute_5) == "number" then Attribute_5 else NIGHT_SECONDS_DEFAULT, NIGHT_SECONDS_FLOOR_2, PERIOD_SECONDS)
        if Attribute_2 ~= PERIOD_SECONDS or v3 ~= v2 then
            local v4 = u48.PeriodIndexAt(v1)
            local v5 = math.clamp(v1 - u48.PeriodStartTime(v4), 0, Attribute_2)
            Workspace:SetAttribute("AreaEggCycleAnchorIndex", v4)
            Workspace:SetAttribute(
                "AreaEggCycleAnchorAt",
                v1 - (if not (Attribute_2 - v3 <= v5) then v5 / (Attribute_2 - v3) * (PERIOD_SECONDS - v2) else PERIOD_SECONDS - v2 + (v5 - (Attribute_2 - v3)) / v3 * v2)
            )
        end
        Workspace:SetAttribute("AreaEggCyclePeriodSeconds", PERIOD_SECONDS)
        Workspace:SetAttribute("AreaEggCycleDefaultNightSeconds", AreaEggCycle.NIGHT_SECONDS_DEFAULT)
    end
    NIGHT_SECONDS_FLOOR = AreaEggCycle.NIGHT_SECONDS_FLOOR
    local Attribute_6 = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    u48.ResetPeriodSeconds = Attribute_6
    u48.NightGrowthSkipSeconds = AreaEggCycle.NIGHT_SKIP_SECONDS
    u48.MinNightDurationSeconds = AreaEggCycle.NIGHT_SECONDS_FLOOR
end)
;(Workspace:GetAttributeChangedSignal("AreaEggCyclePeriodSeconds")):Connect(function() -- Line: 398 -- upvalues: u48 (val), Workspace (val), AreaEggCycle (val)
    local Attribute = Workspace:GetAttribute("AreaEggCyclePeriodSeconds") or AreaEggCycle.PERIOD_SECONDS
    u48.ResetPeriodSeconds = Attribute
end)
return u48