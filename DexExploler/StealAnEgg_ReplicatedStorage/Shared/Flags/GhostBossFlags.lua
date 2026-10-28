-- Script path: ReplicatedStorage.Shared.Flags.GhostBossFlags
-- Decompile time: 5.05 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function isEnabledByDefault() -- Line: 12 -- upvalues: Environment (val), RunService (val)
    return Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
end

local function flag(a1, a2, a3) -- Line: 16 -- upvalues: FastFlags (val) -- types: a1: string
    return FastFlags.Replicated(("Game.GhostBoss.%*"):format(a1), a2, a3)
end

local function oneOf(a1) -- Line: 20 -- types: a1: table
    return function(a1_2) -- Line: 21 -- upvalues: a1 (val)
        if type(a1_2) ~= "string" then
            error("string", 2)
        end
        if table.find(a1, a1_2) == nil then
            error(("OneOf(%*)"):format((table.concat(a1, ","))), 2)
        end
        return a1_2
    end
end

local freeze = table.freeze
local v1 = {
    Enabled = FastFlags.Replicated(
        "Game.GhostBoss.Enabled",
        Asserts.Boolean,
        Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
    ),
    SpawnChancePerCycle = FastFlags.Replicated("Game.GhostBoss.SpawnChancePerCycle", Asserts.Range(0, 1), 0.3),
    MaxSpawnsPerEvent = FastFlags.Replicated("Game.GhostBoss.MaxSpawnsPerEvent", Asserts.IntegerRange(0, 20), 1),
    SpawnDelayMinSeconds = FastFlags.Replicated("Game.GhostBoss.SpawnDelayMinSeconds", Asserts.Range(0, 240), 20),
    SpawnDelayMaxSeconds = FastFlags.Replicated("Game.GhostBoss.SpawnDelayMaxSeconds", Asserts.Range(0, 240), 90),
    SpawnDistanceMinStuds = FastFlags.Replicated("Game.GhostBoss.SpawnDistanceMinStuds", Asserts.Range(0, 2000), 140),
    SpawnDistanceMaxStuds = FastFlags.Replicated("Game.GhostBoss.SpawnDistanceMaxStuds", Asserts.Range(0, 2000), 260),
    SpawnLateralStuds = FastFlags.Replicated("Game.GhostBoss.SpawnLateralStuds", Asserts.Range(0, 500), 40),
    SpawnSeconds = FastFlags.Replicated("Game.GhostBoss.SpawnSeconds", Asserts.Range(0.5, 10), 3),
    LifetimeSeconds = FastFlags.Replicated("Game.GhostBoss.LifetimeSeconds", Asserts.Range(30, 900), 240),
    CaptureSeconds = FastFlags.Replicated("Game.GhostBoss.CaptureSeconds", Asserts.Range(0.5, 8), 2.4),
    BaseHealth = FastFlags.Replicated("Game.GhostBoss.BaseHealth", Asserts.IntegerRange(1, 10000000), 300),
    HealthPerPlayer = FastFlags.Replicated("Game.GhostBoss.HealthPerPlayer", Asserts.IntegerRange(0, 10000000), 200),
    DamagePerSecond = FastFlags.Replicated("Game.GhostBoss.DamagePerSecond", Asserts.Range(0.1, 100000), 10),
    CaptureHealthFraction = FastFlags.Replicated("Game.GhostBoss.CaptureHealthFraction", Asserts.Range(0.01, 0.9), 0.15),
    StartScale = FastFlags.Replicated("Game.GhostBoss.StartScale", Asserts.Range(1, 4), 2),
    HoverStuds = FastFlags.Replicated("Game.GhostBoss.HoverStuds", Asserts.Range(0, 40), 5),
    WanderStudsPerSecond = FastFlags.Replicated("Game.GhostBoss.WanderStudsPerSecond", Asserts.Range(0, 40), 6),
    WanderRadiusStuds = FastFlags.Replicated("Game.GhostBoss.WanderRadiusStuds", Asserts.Range(0, 300), 50),
    SuckedSpeedMultiplier = FastFlags.Replicated("Game.GhostBoss.SuckedSpeedMultiplier", Asserts.Range(0, 1), 0.25),
    AttackMinSeconds = FastFlags.Replicated("Game.GhostBoss.AttackMinSeconds", Asserts.Range(0.5, 60), 4),
    AttackMaxSeconds = FastFlags.Replicated("Game.GhostBoss.AttackMaxSeconds", Asserts.Range(0.5, 60), 7),
    AttackRangeStuds = FastFlags.Replicated("Game.GhostBoss.AttackRangeStuds", Asserts.Range(0, 500), 60),
    AttackWindupSeconds = FastFlags.Replicated("Game.GhostBoss.AttackWindupSeconds", Asserts.Range(0.1, 3), 0.6),
    ChargeStudsPerSecond = FastFlags.Replicated("Game.GhostBoss.ChargeStudsPerSecond", Asserts.Range(1, 200), 45),
    ChargeMaxStuds = FastFlags.Replicated("Game.GhostBoss.ChargeMaxStuds", Asserts.Range(0, 200), 30),
    ChargeTurnDegreesPerSecond = FastFlags.Replicated("Game.GhostBoss.ChargeTurnDegreesPerSecond", Asserts.Range(0, 720), 60),
    SwingReachStuds = FastFlags.Replicated("Game.GhostBoss.SwingReachStuds", Asserts.Range(1, 100), 9),
    SwingConeDegrees = FastFlags.Replicated("Game.GhostBoss.SwingConeDegrees", Asserts.Range(10, 360), 140),
    SwingRecoverSeconds = FastFlags.Replicated("Game.GhostBoss.SwingRecoverSeconds", Asserts.Range(0, 5), 0.8),
    HitKnockbackMultiplier = FastFlags.Replicated("Game.GhostBoss.HitKnockbackMultiplier", Asserts.Range(0, 10), 2),
    HitRagdollSeconds = FastFlags.Replicated("Game.GhostBoss.HitRagdollSeconds", Asserts.Range(0.2, 5), 1.2),
    VacuumReachStuds = FastFlags.Replicated("Game.GhostBoss.VacuumReachStuds", Asserts.Range(5, 300), 45),
    VacuumConeDegrees = FastFlags.Replicated("Game.GhostBoss.VacuumConeDegrees", Asserts.Range(10, 179), 120),
    VacuumInputTimeoutSeconds = FastFlags.Replicated("Game.GhostBoss.VacuumInputTimeoutSeconds", Asserts.Range(0.3, 3), 0.8),
    EngageRadiusStuds = FastFlags.Replicated("Game.GhostBoss.EngageRadiusStuds", Asserts.Range(50, 10000), 900),
    SoulPool = FastFlags.Replicated("Game.GhostBoss.SoulPool", Asserts.IntegerRange(0, 10000000), 3000),
}
local u408 = {"DamageContribution", "Equal"}
v1.RewardDistribution = FastFlags.Replicated("Game.GhostBoss.RewardDistribution", function(a1) -- Line: 21 -- upvalues: u408 (val)
    if type(a1) ~= "string" then
        error("string", 2)
    end
    if table.find(u408, a1) == nil then
        error(("OneOf(%*)"):format((table.concat(u408, ","))), 2)
    end
    return a1
end, "DamageContribution")
v1.RewardOnDefeat = FastFlags.Replicated("Game.GhostBoss.RewardOnDefeat", Asserts.Boolean, true)
v1.SoulOrbsMinimum = FastFlags.Replicated("Game.GhostBoss.SoulOrbsMinimum", Asserts.IntegerRange(1, 300), 40)
v1.SoulOrbsMaximum = FastFlags.Replicated("Game.GhostBoss.SoulOrbsMaximum", Asserts.IntegerRange(1, 300), 150)
v1.SoulsPerOrb = FastFlags.Replicated("Game.GhostBoss.SoulsPerOrb", Asserts.Range(1, 1000000), 4)
v1.SoulAutoCollectSeconds = FastFlags.Replicated("Game.GhostBoss.SoulAutoCollectSeconds", Asserts.Range(2, 120), 14)
v1.SoulPickupRadiusStuds = FastFlags.Replicated("Game.GhostBoss.SoulPickupRadiusStuds", Asserts.Range(0.5, 40), 10)
return freeze(v1)