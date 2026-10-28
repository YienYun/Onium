-- Script path: ReplicatedStorage.Shared.Flags.ShootingStarFlags
-- Decompile time: 1.38 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function seconds(a1, a2) -- Line: 8 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.ShootingStar.%*"):format(a1), Asserts.FinitePositive, a2)
end

local function studs(a1, a2) -- Line: 12 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.ShootingStar.%*"):format(a1), Asserts.FiniteNonNegative, a2)
end

return table.freeze({
    Enabled = FastFlags.Replicated("Game.ShootingStar.Enabled", Asserts.Boolean, true),
    SpawnChancePerCycle = FastFlags.Replicated("Game.ShootingStar.SpawnChancePerCycle", Asserts.Range(0, 1), 0.0005),
    StarsPerClaim = FastFlags.Replicated("Game.ShootingStar.StarsPerClaim", Asserts.IntegerRange(1, 10), 1),
    FallDelayMinSeconds = FastFlags.Replicated("Game.ShootingStar.FallDelayMinSeconds", Asserts.FinitePositive, 20),
    FallDelayMaxSeconds = FastFlags.Replicated("Game.ShootingStar.FallDelayMaxSeconds", Asserts.FinitePositive, 90),
    MinLifetimeSeconds = FastFlags.Replicated("Game.ShootingStar.MinLifetimeSeconds", Asserts.FinitePositive, 120),
    MaxLifetimeSeconds = FastFlags.Replicated("Game.ShootingStar.MaxLifetimeSeconds", Asserts.FinitePositive, 300),
    CommandFallDelaySeconds = FastFlags.Replicated("Game.ShootingStar.CommandFallDelaySeconds", Asserts.FinitePositive, 3),
    LandAreaId = FastFlags.Replicated("Game.ShootingStar.LandAreaId", Asserts.String, "Cosmic"),
    LandDistanceMinStuds = FastFlags.Replicated("Game.ShootingStar.LandDistanceMinStuds", Asserts.FiniteNonNegative, 140),
    LandDistanceMaxStuds = FastFlags.Replicated("Game.ShootingStar.LandDistanceMaxStuds", Asserts.FiniteNonNegative, 420),
    LandLateralMaxStuds = FastFlags.Replicated("Game.ShootingStar.LandLateralMaxStuds", Asserts.FiniteNonNegative, 40),
    HoldSeconds = FastFlags.Replicated("Game.ShootingStar.HoldSeconds", Asserts.FinitePositive, 1.6),
    CatchReachStuds = FastFlags.Replicated("Game.ShootingStar.CatchReachStuds", Asserts.FiniteNonNegative, 18),
    NoticeRadiusStuds = FastFlags.Replicated("Game.ShootingStar.NoticeRadiusStuds", Asserts.FiniteNonNegative, 18),
    WanderRadiusStuds = FastFlags.Replicated("Game.ShootingStar.WanderRadiusStuds", Asserts.FiniteNonNegative, 42),
    WalkSpeedStuds = FastFlags.Replicated("Game.ShootingStar.WalkSpeedStuds", Asserts.FiniteNonNegative, 7),
    RestMinSeconds = FastFlags.Replicated("Game.ShootingStar.RestMinSeconds", Asserts.FinitePositive, 1.5),
    RestMaxSeconds = FastFlags.Replicated("Game.ShootingStar.RestMaxSeconds", Asserts.FinitePositive, 4.5),
    FleeEnabled = FastFlags.Replicated("Game.ShootingStar.FleeEnabled", Asserts.Boolean, true),
    FleeRadiusStuds = FastFlags.Replicated("Game.ShootingStar.FleeRadiusStuds", Asserts.FiniteNonNegative, 40),
    FleeSpeedStuds = FastFlags.Replicated("Game.ShootingStar.FleeSpeedStuds", Asserts.FiniteNonNegative, 12),
    FleeLegStuds = FastFlags.Replicated("Game.ShootingStar.FleeLegStuds", Asserts.FiniteNonNegative, 14),
    CinematicEnabled = FastFlags.Replicated("Game.ShootingStar.CinematicEnabled", Asserts.Boolean, true),
})