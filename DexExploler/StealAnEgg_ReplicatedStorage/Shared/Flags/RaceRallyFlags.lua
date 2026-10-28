-- Script path: ReplicatedStorage.Shared.Flags.RaceRallyFlags
-- Decompile time: 3.59 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function isEnabledByDefault() -- Line: 10 -- upvalues: Environment (val), RunService (val)
    return Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
end

local function isScheduledByDefault() -- Line: 14 -- upvalues: Environment (val), RunService (val)
    return if Environment.IsDevPlace() then not RunService:IsStudio() else Environment.IsTestPlace() and not RunService:IsStudio()
end

local freeze = table.freeze
local v1 = {
    ContentEnabled = FastFlags.Replicated("Game.RaceRally.ContentEnabled", Asserts.Boolean, false),
}
v1.ScheduleEnabled = FastFlags.Replicated(
    "Game.RaceRally.ScheduleEnabled",
    Asserts.Boolean,
    if Environment.IsDevPlace() then not RunService:IsStudio() else Environment.IsTestPlace() and not RunService:IsStudio()
)
v1.ScheduleIntervalSeconds = FastFlags.Replicated("Game.RaceRally.ScheduleIntervalSeconds", Asserts.IntegerRange(300, 86400), 1800)
v1.ScheduleOffsetSeconds = FastFlags.Replicated("Game.RaceRally.ScheduleOffsetSeconds", Asserts.IntegerNonNegative, 0)
v1.JoinSeconds = FastFlags.Replicated("Game.RaceRally.JoinSeconds", Asserts.IntegerPositive, 300)
v1.HeatJoinSeconds = FastFlags.Replicated("Game.RaceRally.HeatJoinSeconds", Asserts.IntegerPositive, 30)
v1.MaxConcurrentHeats = FastFlags.Replicated("Game.RaceRally.MaxConcurrentHeats", Asserts.IntegerRange(1, 8), 4)
v1.OneRacePerWindow = FastFlags.Replicated("Game.RaceRally.OneRacePerWindow", Asserts.Boolean, true)
v1.Laps = FastFlags.Replicated("Game.RaceRally.Laps", Asserts.IntegerPositive, 3)
v1.RacersWithBots = FastFlags.Replicated("Game.RaceRally.RacersWithBots", Asserts.IntegerNonNegative, 6)
v1.TimerLeadSeconds = FastFlags.Replicated("Game.RaceRally.TimerLeadSeconds", Asserts.IntegerNonNegative, 300)
v1.NitroSuccessPercent = FastFlags.Replicated("Game.RaceRally.NitroSuccessPercent", Asserts.Range(0, 100), 10)
v1.SpeedPowerRequirement = FastFlags.Replicated("Game.RaceRally.SpeedPowerRequirement", Asserts.FiniteNonNegative, 2500000)
v1.DoubleTrophiesMultiplier = FastFlags.Replicated("Game.RaceRally.DoubleTrophiesMultiplier", Asserts.IntegerRange(1, 10), 2)
return freeze(v1)