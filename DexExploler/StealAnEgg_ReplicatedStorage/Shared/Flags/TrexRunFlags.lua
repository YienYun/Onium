-- Script path: ReplicatedStorage.Shared.Flags.TrexRunFlags
-- Decompile time: 1.87 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function positive(a1, a2) -- Line: 8 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.TrexRun.%*"):format(a1), Asserts.FinitePositive, a2)
end

local function chance(a1, a2) -- Line: 12 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.TrexRun.%*"):format(a1), Asserts.Range(0, 1), a2)
end

local function whole(a1, a2) -- Line: 16 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.TrexRun.%*"):format(a1), Asserts.IntegerNonNegative, a2)
end

return table.freeze({
    LaneWidthStuds = FastFlags.Replicated("Game.TrexRun.LaneWidthStuds", Asserts.FinitePositive, 26),
    MinLanes = FastFlags.Replicated("Game.TrexRun.MinLanes", Asserts.IntegerNonNegative, 3),
    MaxLanes = FastFlags.Replicated("Game.TrexRun.MaxLanes", Asserts.IntegerNonNegative, 7),
    StartSpeed = FastFlags.Replicated("Game.TrexRun.StartSpeed", Asserts.FinitePositive, 132),
    EndSpeed = FastFlags.Replicated("Game.TrexRun.EndSpeed", Asserts.FinitePositive, 204),
    StartIntervalSeconds = FastFlags.Replicated("Game.TrexRun.StartIntervalSeconds", Asserts.FinitePositive, 2.6),
    EndIntervalSeconds = FastFlags.Replicated("Game.TrexRun.EndIntervalSeconds", Asserts.FinitePositive, 1.5),
    RampSeconds = FastFlags.Replicated("Game.TrexRun.RampSeconds", Asserts.FinitePositive, 180),
    WideGapUntilSeconds = FastFlags.Replicated("Game.TrexRun.WideGapUntilSeconds", Asserts.FinitePositive, 45),
    ScatterChance = FastFlags.Replicated("Game.TrexRun.ScatterChance", Asserts.Range(0, 1), 0.35),
    GapDriftLanes = FastFlags.Replicated("Game.TrexRun.GapDriftLanes", Asserts.IntegerNonNegative, 2),
    WaveShiftLanes = FastFlags.Replicated("Game.TrexRun.WaveShiftLanes", Asserts.Range(0, 1), 1),
    TrexJitterStuds = FastFlags.Replicated("Game.TrexRun.TrexJitterStuds", Asserts.IntegerNonNegative, 3),
    TurnSeconds = FastFlags.Replicated("Game.TrexRun.TurnSeconds", Asserts.FinitePositive, 0.9),
    TurnSettleSeconds = FastFlags.Replicated("Game.TrexRun.TurnSettleSeconds", Asserts.FinitePositive, 0.6),
    TurnCooldownSeconds = FastFlags.Replicated("Game.TrexRun.TurnCooldownSeconds", Asserts.FinitePositive, 2.5),
    HitLengthScale = FastFlags.Replicated("Game.TrexRun.HitLengthScale", Asserts.FinitePositive, 0.8),
    HitWidthScale = FastFlags.Replicated("Game.TrexRun.HitWidthScale", Asserts.FinitePositive, 0.8),
    TrampleSpeed = FastFlags.Replicated("Game.TrexRun.TrampleSpeed", Asserts.FinitePositive, 120),
    TrampleSideSpeed = FastFlags.Replicated("Game.TrexRun.TrampleSideSpeed", Asserts.FinitePositive, 70),
    TrampleLift = FastFlags.Replicated("Game.TrexRun.TrampleLift", Asserts.FinitePositive, 90),
    RagdollSeconds = FastFlags.Replicated("Game.TrexRun.RagdollSeconds", Asserts.FinitePositive, 1.6),
    GraceSeconds = FastFlags.Replicated("Game.TrexRun.GraceSeconds", Asserts.FinitePositive, 2.5),
    CarrierSpeedMalus = FastFlags.Replicated("Game.TrexRun.CarrierSpeedMalus", Asserts.Range(-0.95, 0), -0.35),
    EggScale = FastFlags.Replicated("Game.TrexRun.EggScale", Asserts.FinitePositive, 2),
    RewardScale = FastFlags.Replicated("Game.TrexRun.RewardScale", Asserts.FinitePositive, 1),
    EggZonesAfter = FastFlags.Replicated("Game.TrexRun.EggZonesAfter", Asserts.String, "Volcano"),
})