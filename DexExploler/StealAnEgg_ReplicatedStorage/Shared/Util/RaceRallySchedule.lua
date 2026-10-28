-- Script path: ReplicatedStorage.Shared.Util.RaceRallySchedule
-- Decompile time: 1.08 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceRallyFlags = require(ReplicatedStorage.Shared.Flags.RaceRallyFlags)
local u10 = {}

function u10.IsScheduled() -- Line: 11 -- upvalues: RaceRallyFlags (val)
    return RaceRallyFlags.ContentEnabled:Get() and RaceRallyFlags.ScheduleEnabled:Get()
end

function u10.Window(a1) -- Line: 16 -- upvalues: RaceRallyFlags (val) -- types: a1: number
    local v1 = RaceRallyFlags.ScheduleIntervalSeconds:Get()
    local v2 = RaceRallyFlags.ScheduleOffsetSeconds:Get()
    local v3 = (a1 - v2) // v1
    local v4 = v3 * v1 + v2
    return v3, v4, v4 + RaceRallyFlags.JoinSeconds:Get()
end

function u10.NextOpening(a1) -- Line: 25 -- upvalues: u10 (val), RaceRallyFlags (val) -- types: a1: number
    local v1, v2
    _, v1, v2 = u10.Window(a1)
    if a1 < v2 then
        return v1, v2
    end
    v2 = v1 + RaceRallyFlags.ScheduleIntervalSeconds:Get()
    return v2, v2 + RaceRallyFlags.JoinSeconds:Get()
end

function u10.ClaimsBoundary(a1) -- Line: 35 -- upvalues: u10 (val), RaceRallyFlags (val) -- types: a1: number
    return u10.IsScheduled() and (a1 - RaceRallyFlags.ScheduleOffsetSeconds:Get()) % RaceRallyFlags.ScheduleIntervalSeconds:Get() == 0
end

return table.freeze(u10)