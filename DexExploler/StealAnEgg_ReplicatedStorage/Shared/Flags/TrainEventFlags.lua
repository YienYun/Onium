-- Script path: ReplicatedStorage.Shared.Flags.TrainEventFlags
-- Decompile time: 8.19 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function flag(a1, a2, a3) -- Line: 6 -- upvalues: FastFlags (val) -- types: a1: string
    return FastFlags.Replicated(("Game.TrainEvent.%*"):format(a1), a2, a3)
end

local function seconds(a1, a2) -- Line: 9 -- upvalues: flag (val), Asserts (val) -- types: a1: string, a2: number
    return flag(a1, Asserts.FinitePositive, a2)
end

local function whole(a1, a2) -- Line: 12 -- upvalues: flag (val), Asserts (val) -- types: a1: string, a2: number
    return flag(a1, Asserts.IntegerNonNegative, a2)
end

return table.freeze({
    ReturnRecoverySeconds = FastFlags.Replicated("Game.TrainEvent.ReturnRecoverySeconds", Asserts.Range(10, 60), 30),
    TravelReadySeconds = FastFlags.Replicated("Game.TrainEvent.TravelReadySeconds", Asserts.Range(2, 12), 6),
    TravelSettleSeconds = FastFlags.Replicated("Game.TrainEvent.TravelSettleSeconds", Asserts.Range(1, 8), 4),
    ReturnAttemptLimit = FastFlags.Replicated("Game.TrainEvent.ReturnAttemptLimit", Asserts.Range(1, 3), 2),
    DeathTransitionDelaySeconds = FastFlags.Replicated("Game.TrainEvent.DeathTransitionDelaySeconds", Asserts.Range(1, 4), 2),
    TrainSpeedStuds = FastFlags.Replicated("Game.TrainEvent.TrainSpeedStuds", Asserts.Range(5, 60), 45),
    VacuumSafeCaptureProgress = FastFlags.Replicated("Game.TrainEvent.VacuumSafeCaptureProgress", Asserts.Range(0, 1), 0.5),
    VacuumCaptureRate = FastFlags.Replicated("Game.TrainEvent.VacuumCaptureRate", Asserts.Range(0.25, 4), 1.23),
    VacuumCloseRangeStuds = FastFlags.Replicated("Game.TrainEvent.VacuumCloseRangeStuds", Asserts.Range(0, 8), 5),
    VacuumVerticalToleranceStuds = FastFlags.Replicated("Game.TrainEvent.VacuumVerticalToleranceStuds", Asserts.Range(1, 12), 6),
    VacuumPullSpeedStuds = FastFlags.Replicated("Game.TrainEvent.VacuumPullSpeedStuds", Asserts.FinitePositive, 12),
    VacuumBackpackHeightStuds = FastFlags.Replicated("Game.TrainEvent.VacuumBackpackHeightStuds", Asserts.FinitePositive, 1.8),
    TravelCoverSeconds = FastFlags.Replicated("Game.TrainEvent.TravelCoverSeconds", Asserts.Range(0.75, 2), 0.75),
    GhostSnapshotSeconds = FastFlags.Replicated("Game.TrainEvent.GhostSnapshotSeconds", Asserts.Range(0.05, 0.3), 0.075),
    GhostInterpolationSeconds = FastFlags.Replicated("Game.TrainEvent.GhostInterpolationSeconds", Asserts.Range(0.05, 0.4), 0.16),
    GhostSizeMultiplier = FastFlags.Replicated("Game.TrainEvent.GhostSizeMultiplier", Asserts.Range(0.5, 3), 1.35),
    GhostRecoverySeconds = FastFlags.Replicated("Game.TrainEvent.GhostRecoverySeconds", Asserts.Range(0.1, 3), 0.65),
    GhostFadeSeconds = FastFlags.Replicated("Game.TrainEvent.GhostFadeSeconds", Asserts.Range(0.2, 3), 0.75),
    MaxActiveGhosts = FastFlags.Replicated("Game.TrainEvent.MaxActiveGhosts", Asserts.IntegerNonNegative, 3),
    MaxActiveGhostsServer = FastFlags.Replicated("Game.TrainEvent.MaxActiveGhostsServer", Asserts.IntegerRange(0, 500), 30),
    GhostSpawnDelayMin = FastFlags.Replicated("Game.TrainEvent.GhostSpawnDelayMin", Asserts.Range(0, 60), 0.5),
    GhostSpawnDelayMax = FastFlags.Replicated("Game.TrainEvent.GhostSpawnDelayMax", Asserts.Range(0, 60), 1.5),
    VacuumInputTimeoutSeconds = FastFlags.Replicated("Game.TrainEvent.VacuumInputTimeoutSeconds", Asserts.FinitePositive, 0.8),
    GhostAttackDistanceStuds = FastFlags.Replicated("Game.TrainEvent.GhostAttackDistanceStuds", Asserts.FinitePositive, 4),
    GhostAttackCooldownSeconds = FastFlags.Replicated("Game.TrainEvent.GhostAttackCooldownSeconds", Asserts.FinitePositive, 1.5),
    GhostLifetimeSeconds = FastFlags.Replicated("Game.TrainEvent.GhostLifetimeSeconds", Asserts.Range(0, 600), 25),
    GhostChaseDelaySeconds = FastFlags.Replicated("Game.TrainEvent.GhostChaseDelaySeconds", Asserts.Range(0, 10), 0.6),
    GhostStopDistanceStuds = FastFlags.Replicated("Game.TrainEvent.GhostStopDistanceStuds", Asserts.Range(0, 20), 3),
    GhostTurnRate = FastFlags.Replicated("Game.TrainEvent.GhostTurnRate", Asserts.Range(0, 100), 8),
    GhostStrikeReachMultiplier = FastFlags.Replicated("Game.TrainEvent.GhostStrikeReachMultiplier", Asserts.Range(0.5, 3), 1.3),
    GhostHitChance = FastFlags.Replicated("Game.TrainEvent.GhostHitChance", Asserts.Range(0, 1), 0.85),
    GhostSwipeSpeed = FastFlags.Replicated("Game.TrainEvent.GhostSwipeSpeed", Asserts.Range(0.1, 5), 1),
    GhostRagdollSeconds = FastFlags.Replicated("Game.TrainEvent.GhostRagdollSeconds", Asserts.Range(0, 10), 0),
    GhostKnockbackMultiplier = FastFlags.Replicated("Game.TrainEvent.GhostKnockbackMultiplier", Asserts.Range(0, 5), 1),
    VengefulInterruptSeconds = FastFlags.Replicated("Game.TrainEvent.VengefulInterruptSeconds", Asserts.FinitePositive, 1),
    GhostAggroStuds = FastFlags.Replicated("Game.TrainEvent.GhostAggroStuds", Asserts.FinitePositive, 35),
    GhostIntroSpawnsEnabled = FastFlags.Replicated("Game.TrainEvent.GhostIntroSpawnsEnabled", Asserts.Boolean, true),
    GhostSpawnMinDistanceStuds = FastFlags.Replicated("Game.TrainEvent.GhostSpawnMinDistanceStuds", Asserts.Range(0, 100), 12),
    GhostRoamTurnSeconds = FastFlags.Replicated("Game.TrainEvent.GhostRoamTurnSeconds", Asserts.Range(0.1, 60), 3),
    HauntedSpiritChaseSpeedMultiplier = FastFlags.Replicated("Game.TrainEvent.HauntedSpiritChaseSpeedMultiplier", Asserts.Range(0.1, 5), 1.5),
    HauntedSpiritChaseMinDistanceStuds = FastFlags.Replicated("Game.TrainEvent.HauntedSpiritChaseMinDistanceStuds", Asserts.Range(0, 100), 8),
    LostSpiritSpeedStuds = FastFlags.Replicated("Game.TrainEvent.LostSpiritSpeedStuds", Asserts.FinitePositive, 2.5),
    LostSpiritDamage = FastFlags.Replicated("Game.TrainEvent.LostSpiritDamage", Asserts.IntegerNonNegative, 6),
    LostSpiritSpawnWeight = FastFlags.Replicated("Game.TrainEvent.LostSpiritSpawnWeight", Asserts.IntegerNonNegative, 60),
    HauntedSpiritSpeedStuds = FastFlags.Replicated("Game.TrainEvent.HauntedSpiritSpeedStuds", Asserts.FinitePositive, 6.25),
    HauntedSpiritDamage = FastFlags.Replicated("Game.TrainEvent.HauntedSpiritDamage", Asserts.IntegerNonNegative, 9),
    HauntedSpiritSpawnWeight = FastFlags.Replicated("Game.TrainEvent.HauntedSpiritSpawnWeight", Asserts.IntegerNonNegative, 30),
    VengefulSpiritSpeedStuds = FastFlags.Replicated("Game.TrainEvent.VengefulSpiritSpeedStuds", Asserts.FinitePositive, 10),
    VengefulSpiritDamage = FastFlags.Replicated("Game.TrainEvent.VengefulSpiritDamage", Asserts.IntegerNonNegative, 12),
    VengefulSpiritSpawnWeight = FastFlags.Replicated("Game.TrainEvent.VengefulSpiritSpawnWeight", Asserts.IntegerNonNegative, 10),
    ReturnPromptReachStuds = FastFlags.Replicated("Game.TrainEvent.ReturnPromptReachStuds", Asserts.Range(14, 50), 40),
    InteractionReachStuds = FastFlags.Replicated("Game.TrainEvent.InteractionReachStuds", Asserts.FinitePositive, 14),
    SoulShopReachStuds = FastFlags.Replicated("Game.TrainEvent.SoulShopReachStuds", Asserts.Range(1, 50), 24),
    BoardedMaxDistanceStuds = FastFlags.Replicated("Game.TrainEvent.BoardedMaxDistanceStuds", Asserts.FinitePositive, 60),
    PrototypeStationX = FastFlags.Replicated("Game.TrainEvent.PrototypeStationX", Asserts.Range(-50000, 50000), -12000),
    PrototypeStationZ = FastFlags.Replicated("Game.TrainEvent.PrototypeStationZ", Asserts.Range(-50000, 50000), -2000),
    PrototypeFloorY = FastFlags.Replicated("Game.TrainEvent.PrototypeFloorY", Asserts.FiniteNonNegative, 100),
    AdminSoulGrantMax = FastFlags.Replicated("Game.TrainEvent.AdminSoulGrantMax", Asserts.IntegerNonNegative, 1000000000),
    AdminTicketGrantMax = FastFlags.Replicated("Game.TrainEvent.AdminTicketGrantMax", Asserts.IntegerNonNegative, 1000),
    Enabled = FastFlags.Replicated("Game.TrainEvent.Enabled", Asserts.Boolean, true),
    RewardsEnabled = FastFlags.Replicated("Game.TrainEvent.RewardsEnabled", Asserts.Boolean, true),
    HideSewerWhirlpool = FastFlags.Replicated("Game.TrainEvent.HideSewerWhirlpool", Asserts.Boolean, false),
    SpawnChancePerNight = FastFlags.Replicated("Game.TrainEvent.SpawnChancePerNight", Asserts.Range(0, 1), 0.25),
    SpawnIntervalSeconds = FastFlags.Replicated("Game.TrainEvent.SpawnIntervalSeconds", Asserts.Range(600, 86400), 1800),
    SpawnOffsetSeconds = FastFlags.Replicated("Game.TrainEvent.SpawnOffsetSeconds", Asserts.Range(0, 86400), 0),
    BoardingSeconds = FastFlags.Replicated("Game.TrainEvent.BoardingSeconds", Asserts.FinitePositive, 180),
    InvasionDelaySeconds = FastFlags.Replicated("Game.TrainEvent.InvasionDelaySeconds", Asserts.FinitePositive, 15),
    InvasionSeconds = FastFlags.Replicated("Game.TrainEvent.InvasionSeconds", Asserts.FinitePositive, 300),
    CaptureGoal = FastFlags.Replicated("Game.TrainEvent.CaptureGoal", Asserts.IntegerNonNegative, 50),
    CompletionBonusSouls = FastFlags.Replicated("Game.TrainEvent.CompletionBonusSouls", Asserts.IntegerNonNegative, 500),
    LostSpiritCaptureSeconds = FastFlags.Replicated("Game.TrainEvent.LostSpiritCaptureSeconds", Asserts.FinitePositive, 1.5),
    LostSpiritSouls = FastFlags.Replicated("Game.TrainEvent.LostSpiritSouls", Asserts.IntegerNonNegative, 20),
    HauntedSpiritCaptureSeconds = FastFlags.Replicated("Game.TrainEvent.HauntedSpiritCaptureSeconds", Asserts.FinitePositive, 3),
    HauntedSpiritSouls = FastFlags.Replicated("Game.TrainEvent.HauntedSpiritSouls", Asserts.IntegerNonNegative, 50),
    VengefulSpiritCaptureSeconds = FastFlags.Replicated("Game.TrainEvent.VengefulSpiritCaptureSeconds", Asserts.FinitePositive, 5),
    VengefulSpiritSouls = FastFlags.Replicated("Game.TrainEvent.VengefulSpiritSouls", Asserts.IntegerNonNegative, 110),
    ShopReturnGraceSeconds = FastFlags.Replicated("Game.TrainEvent.ShopReturnGraceSeconds", Asserts.FinitePositive, 120),
    VacuumReachStuds = FastFlags.Replicated("Game.TrainEvent.VacuumReachStuds", Asserts.FinitePositive, 20),
    VacuumConeDegrees = FastFlags.Replicated("Game.TrainEvent.VacuumConeDegrees", Asserts.Range(1, 179), 120),
    VacuumMovementScalar = FastFlags.Replicated("Game.TrainEvent.VacuumMovementScalar", Asserts.Range(0.05, 1), 0.5),
    SpectralTradeEnabled = FastFlags.Replicated("Game.TrainEvent.SpectralTradeEnabled", Asserts.Boolean, true),
    SpectralSoulCost = FastFlags.Replicated("Game.TrainEvent.SpectralSoulCost", Asserts.IntegerNonNegative, 1000),
    SpectralEarningsMultiplier = FastFlags.Replicated("Game.TrainEvent.SpectralEarningsMultiplier", Asserts.FinitePositive, 1),
    SpectralSuccessPercent = FastFlags.Replicated("Game.TrainEvent.SpectralSuccessPercent", Asserts.Range(0, 100), 25),
})