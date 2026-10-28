-- Script path: ReplicatedStorage.Shared.Flags.BeanstalkEventFlags
-- Decompile time: 0.79 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    FirefliesRequired = FastFlags.Replicated("Game.BeanstalkEvent.FirefliesRequired", Asserts.IntegerPositive, 20),
    MaxVisibleFireflies = FastFlags.Replicated("Game.BeanstalkEvent.MaxVisibleFireflies", Asserts.IntegerPositive, 5),
    PoursRequired = FastFlags.Replicated("Game.BeanstalkEvent.PoursRequired", Asserts.IntegerPositive, 3),
    MinCatchIntervalSeconds = FastFlags.Replicated("Game.BeanstalkEvent.MinCatchIntervalSeconds", Asserts.FinitePositive, 0.4),
    MinPourIntervalSeconds = FastFlags.Replicated("Game.BeanstalkEvent.MinPourIntervalSeconds", Asserts.FinitePositive, 1),
    GrowSeconds = FastFlags.Replicated("Game.BeanstalkEvent.GrowSeconds", Asserts.FinitePositive, 4),
    FlightSeconds = FastFlags.Replicated("Game.BeanstalkEvent.FlightSeconds", Asserts.FinitePositive, 59),
    SlideSeconds = FastFlags.Replicated("Game.BeanstalkEvent.SlideSeconds", Asserts.FinitePositive, 90),
    MinFlightSeconds = FastFlags.Replicated("Game.BeanstalkEvent.MinFlightSeconds", Asserts.FinitePositive, 15),
    MinSlideSeconds = FastFlags.Replicated("Game.BeanstalkEvent.MinSlideSeconds", Asserts.FinitePositive, 25),
    FillSeconds = FastFlags.Replicated("Game.BeanstalkEvent.FillSeconds", Asserts.FinitePositive, 5),
    LeafRespawnSeconds = FastFlags.Replicated("Game.BeanstalkEvent.LeafRespawnSeconds", Asserts.FinitePositive, 2),
    RideLateralStuds = FastFlags.Replicated("Game.BeanstalkEvent.RideLateralStuds", Asserts.FinitePositive, 50),
    LockedWalkSpeed = FastFlags.Replicated("Game.BeanstalkEvent.LockedWalkSpeed", Asserts.FinitePositive, 50),
    EnrollLateJoiners = FastFlags.Replicated("Game.BeanstalkEvent.EnrollLateJoiners", Asserts.Boolean, false),
    FlightHearts = FastFlags.Replicated("Game.BeanstalkEvent.FlightHearts", Asserts.IntegerPositive, 3),
    FlightSpiralTurns = FastFlags.Replicated("Game.BeanstalkEvent.FlightSpiralTurns", Asserts.FinitePositive, 1.4),
    FlightSpiralBulge = FastFlags.Replicated("Game.BeanstalkEvent.FlightSpiralBulge", Asserts.FinitePositive, 0.35),
    FlightRockSpacingStuds = FastFlags.Replicated("Game.BeanstalkEvent.FlightRockSpacingStuds", Asserts.FinitePositive, 170),
    FlightRockFallStuds = FastFlags.Replicated("Game.BeanstalkEvent.FlightRockFallStuds", Asserts.FinitePositive, 45),
    BumpSlowdownSeconds = FastFlags.Replicated("Game.BeanstalkEvent.BumpSlowdownSeconds", Asserts.FinitePositive, 2),
})