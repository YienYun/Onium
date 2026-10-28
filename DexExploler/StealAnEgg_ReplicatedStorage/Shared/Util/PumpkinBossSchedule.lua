-- Script path: ReplicatedStorage.Shared.Util.PumpkinBossSchedule
-- Decompile time: 2.86 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PumpkinBossFlags = require(ReplicatedStorage.Shared.Flags.PumpkinBossFlags)
local u10 = {}

local function cycleSeconds() -- Line: 9 -- upvalues: PumpkinBossFlags (val)
    return PumpkinBossFlags.CycleMinutes:Get() * 60
end

local function windowSeconds() -- Line: 13 -- upvalues: PumpkinBossFlags (val)
    return (math.min(PumpkinBossFlags.WindowMinutes:Get() * 60, (PumpkinBossFlags.CycleMinutes:Get()) * 60))
end

local function nextAt(a1, a2, a3) -- Line: 17 -- types: a1: number, a2: number, a3: number
    local v1 = a1 - a1 % a2 + a3 % a2
    if v1 <= a1 then
        v1 = v1 + a2
    end
    return v1
end

local function secondsLeftOpen(a1) -- Line: 26 -- upvalues: PumpkinBossFlags (val) -- types: a1: number
    local v1
    local v2 = PumpkinBossFlags.CycleMinutes:Get() * 60
    local v3 = math.min(PumpkinBossFlags.WindowMinutes:Get() * 60, (PumpkinBossFlags.CycleMinutes:Get()) * 60)
    local v4 = nil
    for i, j in PumpkinBossFlags.OpenMinutes:Get() do
        v1 = (a1 - j * 60) % v2
        if v1 < v3 then
            if v4 == nil or v4 < v3 - v1 then
                v4 = v3 - v1
            end
        end
    end
    return v4
end

function u10.Enabled() -- Line: 40 -- upvalues: PumpkinBossFlags (val)
    return PumpkinBossFlags.ScheduleEnabled:Get()
end

function u10.IsOpen(a1) -- Line: 44 -- upvalues: u10 (val), secondsLeftOpen (val) -- types: a1: number
    return u10.Enabled() and secondsLeftOpen(a1) ~= nil
end

function u10.NextOpensAt(a1) -- Line: 48 -- upvalues: PumpkinBossFlags (val) -- types: a1: number
    local v1, v2
    local v3 = PumpkinBossFlags.CycleMinutes:Get() * 60
    local v4 = nil
    local v5 = a1
    for i, j in PumpkinBossFlags.OpenMinutes:Get() do
        v2 = j * 60
        v1 = v5 - v5 % v3 + v2 % v3
        if v1 <= v5 then
            v1 = v1 + v3
        end
        if v4 == nil or v1 < v4 then
            v4 = v1
        end
    end
    return v4 or v5 + v3
end

function u10.ClosesAt(a1) -- Line: 61
    -- upvalues: secondsLeftOpen (val), u10 (val), PumpkinBossFlags (val)
    local v1 = secondsLeftOpen(a1)
    if v1 then
        return a1 + v1
    end
    return (u10.NextOpensAt(a1)) + math.min(PumpkinBossFlags.WindowMinutes:Get() * 60, (PumpkinBossFlags.CycleMinutes:Get()) * 60)
end

function u10.SecondsUntilOpen(a1) -- Line: 70 -- upvalues: u10 (val) -- types: a1: number
    if u10.IsOpen(a1) then
        return 0
    end
    return u10.NextOpensAt(a1) - a1
end

return table.freeze(u10)