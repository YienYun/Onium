-- Script path: ReplicatedStorage.Shared.Flags.ScrambleBossFlags
-- Decompile time: 3.76 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)

local function isEnabledByDefault() -- Line: 11 -- upvalues: Environment (val), RunService (val)
    return Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
end

local function isScheduledByDefault() -- Line: 15 -- upvalues: Environment (val), RunService (val)
    return if Environment.IsDevPlace() then not RunService:IsStudio() else Environment.IsTestPlace() and not RunService:IsStudio()
end

local v1 = {
    ContentEnabled = FastFlags.Replicated(
        "Game.ScrambleBoss.ContentEnabled",
        Asserts.Boolean,
        Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
    ),
    BossMaxHealth = FastFlags.Replicated("Game.ScrambleBoss.BossMaxHealth", Asserts.FinitePositive, 9000),
}
v1.HealthPerExtraPlayer = FastFlags.Replicated("Game.ScrambleBoss.HealthPerExtraPlayer", Asserts.Range(0, 10), 0.45)
v1.PlayerHitDamage = FastFlags.Replicated("Game.ScrambleBoss.PlayerHitDamage", Asserts.FinitePositive, 60)
v1.OverheatDamageMultiplier = FastFlags.Replicated("Game.ScrambleBoss.OverheatDamageMultiplier", Asserts.Range(1, 20), 3)
v1.OverheatSeconds = FastFlags.Replicated("Game.ScrambleBoss.OverheatSeconds", Asserts.Range(2, 30), 8)
v1.PhaseTwoHealthFraction = FastFlags.Replicated("Game.ScrambleBoss.PhaseTwoHealthFraction", Asserts.Range(0.05, 0.95), 0.5)
v1.HazardDamage = FastFlags.Replicated("Game.ScrambleBoss.HazardDamage", Asserts.Range(0, 100), 8.333333333333334)
v1.CrocTargets = FastFlags.Replicated("Game.ScrambleBoss.CrocTargets", Asserts.IntegerRange(1, 10), 3)
v1.CrocChaseSeconds = FastFlags.Replicated("Game.ScrambleBoss.CrocChaseSeconds", Asserts.Range(1, 30), 6)
v1.DronesPerPlayer = FastFlags.Replicated("Game.ScrambleBoss.DronesPerPlayer", Asserts.IntegerRange(0, 10), 2)
v1.BallTargetSeconds = FastFlags.Replicated("Game.ScrambleBoss.BallTargetSeconds", Asserts.Range(1, 30), 5)
v1.BallSpeedFraction = FastFlags.Replicated("Game.ScrambleBoss.BallSpeedFraction", Asserts.Range(0.1, 3), 0.9)
v1.BallStunSeconds = FastFlags.Replicated("Game.ScrambleBoss.BallStunSeconds", Asserts.Range(1, 60), 30)
v1.GlassHitsPerPlayer = FastFlags.Replicated("Game.ScrambleBoss.GlassHitsPerPlayer", Asserts.IntegerRange(1, 100), 3)
v1.GlassCrashes = FastFlags.Replicated("Game.ScrambleBoss.GlassCrashes", Asserts.IntegerRange(1, 10), 3)
v1.HumanHits = FastFlags.Replicated("Game.ScrambleBoss.HumanHits", Asserts.IntegerRange(1, 10), 3)
v1.SamplesReward = FastFlags.Replicated("Game.ScrambleBoss.SamplesReward", Asserts.IntegerRange(0, 1000000), 1750)
v1.ScheduleEnabled = FastFlags.Replicated(
    "Game.ScrambleBoss.ScheduleEnabled",
    Asserts.Boolean,
    if Environment.IsDevPlace() then not RunService:IsStudio() else Environment.IsTestPlace() and not RunService:IsStudio()
)
v1.ScheduleIntervalSeconds = FastFlags.Replicated("Game.ScrambleBoss.ScheduleIntervalSeconds", Asserts.IntegerRange(300, 86400), 1800)
v1.PortalSpawnFrom = FastFlags.Replicated("Game.ScrambleBoss.PortalSpawnFrom", Asserts.String, "Volcano")
v1.PortalSpawnTo = FastFlags.Replicated("Game.ScrambleBoss.PortalSpawnTo", Asserts.String, "Titan Temple")
v1.PortalIdleCloseSeconds = FastFlags.Replicated("Game.ScrambleBoss.PortalIdleCloseSeconds", Asserts.Range(30, 3600), 300)
v1.SamplesWalletId = FastFlags.Replicated(
    "Game.ScrambleBoss.SamplesWalletId",
    Asserts.AllOf(Asserts.ASCIIRange(0, 64), Asserts.Pattern("^[%w_%-]*$")),
    "DrScrambleBoss"
)
v1.RemovalAt = FastFlags.Replicated("Game.ScrambleBoss.RemovalAt", Asserts.IntegerRange(0, 4102444800), 1791644400)
return table.freeze(v1)