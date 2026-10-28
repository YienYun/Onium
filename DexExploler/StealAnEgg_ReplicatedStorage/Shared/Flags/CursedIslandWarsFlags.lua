-- Script path: ReplicatedStorage.Shared.Flags.CursedIslandWarsFlags
-- Decompile time: 3.65 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function positive(a1, a2) -- Line: 8 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.CursedIslandWars.%*"):format(a1), Asserts.FinitePositive, a2)
end

local function nonNegative(a1, a2) -- Line: 12
    -- upvalues: FastFlags (val), Asserts (val)
    return FastFlags.Replicated(("Game.CursedIslandWars.%*"):format(a1), Asserts.FiniteNonNegative, a2)
end

local function whole(a1, a2) -- Line: 16 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.CursedIslandWars.%*"):format(a1), Asserts.IntegerPositive, a2)
end

local function ratio(a1, a2) -- Line: 20 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.CursedIslandWars.%*"):format(a1), Asserts.Range(0, 1), a2)
end

local function boolean(a1, a2) -- Line: 24 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: boolean
    return FastFlags.Replicated(("Game.CursedIslandWars.%*"):format(a1), Asserts.Boolean, a2)
end

return table.freeze({
    ContentEnabled = FastFlags.Replicated("Game.CursedIslandWars.ContentEnabled", Asserts.Boolean, true),
    BotsEnabled = FastFlags.Replicated("Game.CursedIslandWars.BotsEnabled", Asserts.Boolean, true),
    RevealSeconds = FastFlags.Replicated("Game.CursedIslandWars.RevealSeconds", Asserts.FinitePositive, 9),
    PrepSeconds = FastFlags.Replicated("Game.CursedIslandWars.PrepSeconds", Asserts.FinitePositive, 20),
    MatchSeconds = FastFlags.Replicated("Game.CursedIslandWars.MatchSeconds", Asserts.FinitePositive, 240),
    CrumbleWarningSeconds = FastFlags.Replicated("Game.CursedIslandWars.CrumbleWarningSeconds", Asserts.FinitePositive, 60),
    FinalWarningSeconds = FastFlags.Replicated("Game.CursedIslandWars.FinalWarningSeconds", Asserts.FinitePositive, 10),
    SuddenDeathSeconds = FastFlags.Replicated("Game.CursedIslandWars.SuddenDeathSeconds", Asserts.FinitePositive, 60),
    EarlySuddenDeathSeconds = FastFlags.Replicated("Game.CursedIslandWars.EarlySuddenDeathSeconds", Asserts.FinitePositive, 10),
    CollapseWarnSeconds = FastFlags.Replicated("Game.CursedIslandWars.CollapseWarnSeconds", Asserts.FinitePositive, 3),
    CollapseStartSeconds = FastFlags.Replicated("Game.CursedIslandWars.CollapseStartSeconds", Asserts.FinitePositive, 8),
    CollapseStepSeconds = FastFlags.Replicated("Game.CursedIslandWars.CollapseStepSeconds", Asserts.FinitePositive, 4),
    WinSeconds = FastFlags.Replicated("Game.CursedIslandWars.WinSeconds", Asserts.FinitePositive, 5),
    OutroTimeoutSeconds = FastFlags.Replicated("Game.CursedIslandWars.OutroTimeoutSeconds", Asserts.FinitePositive, 60),
    RespawnSeconds = FastFlags.Replicated("Game.CursedIslandWars.RespawnSeconds", Asserts.FinitePositive, 5),
    SpawnShieldSeconds = FastFlags.Replicated("Game.CursedIslandWars.SpawnShieldSeconds", Asserts.FiniteNonNegative, 2),
    BotDamageScale = FastFlags.Replicated("Game.CursedIslandWars.BotDamageScale", Asserts.Range(0, 1), 0.45),
    BotBatHitChance = FastFlags.Replicated("Game.CursedIslandWars.BotBatHitChance", Asserts.Range(0, 1), 0.4),
    BotAimSpread = FastFlags.Replicated("Game.CursedIslandWars.BotAimSpread", Asserts.FinitePositive, 1.35),
    BotBatPauseSeconds = FastFlags.Replicated("Game.CursedIslandWars.BotBatPauseSeconds", Asserts.FinitePositive, 1.4),
    BotWaveSeconds = FastFlags.Replicated("Game.CursedIslandWars.BotWaveSeconds", Asserts.FinitePositive, 30),
    BotWaveGapSeconds = FastFlags.Replicated("Game.CursedIslandWars.BotWaveGapSeconds", Asserts.FinitePositive, 14),
    BotRocketsHome = FastFlags.Replicated("Game.CursedIslandWars.BotRocketsHome", Asserts.Boolean, false),
    PlayerHealth = FastFlags.Replicated("Game.CursedIslandWars.PlayerHealth", Asserts.FinitePositive, 100),
    WalkSpeed = FastFlags.Replicated("Game.CursedIslandWars.WalkSpeed", Asserts.FinitePositive, 50),
    KnockoutScore = FastFlags.Replicated("Game.CursedIslandWars.KnockoutScore", Asserts.FiniteNonNegative, 50),
    CrystalHealth = FastFlags.Replicated("Game.CursedIslandWars.CrystalHealth", Asserts.FinitePositive, 1750),
    BarrierHealth = FastFlags.Replicated("Game.CursedIslandWars.BarrierHealth", Asserts.FinitePositive, 1500),
    BrickHealth = FastFlags.Replicated("Game.CursedIslandWars.BrickHealth", Asserts.FinitePositive, 60),
    BatCooldown = FastFlags.Replicated("Game.CursedIslandWars.BatCooldown", Asserts.FinitePositive, 0.7),
    BatDamage = FastFlags.Replicated("Game.CursedIslandWars.BatDamage", Asserts.FiniteNonNegative, 15),
    LauncherCooldown = FastFlags.Replicated("Game.CursedIslandWars.LauncherCooldown", Asserts.FinitePositive, 1.2),
    LauncherSpeed = FastFlags.Replicated("Game.CursedIslandWars.LauncherSpeed", Asserts.FinitePositive, 110),
    LauncherRange = FastFlags.Replicated("Game.CursedIslandWars.LauncherRange", Asserts.FinitePositive, 500),
    LauncherLockRadius = FastFlags.Replicated("Game.CursedIslandWars.LauncherLockRadius", Asserts.FiniteNonNegative, 25),
    LauncherTurnRate = FastFlags.Replicated("Game.CursedIslandWars.LauncherTurnRate", Asserts.FinitePositive, 240),
    LauncherRadius = FastFlags.Replicated("Game.CursedIslandWars.LauncherRadius", Asserts.FinitePositive, 12),
    LauncherStructureRadius = FastFlags.Replicated("Game.CursedIslandWars.LauncherStructureRadius", Asserts.FinitePositive, 7),
    LauncherDamage = FastFlags.Replicated("Game.CursedIslandWars.LauncherDamage", Asserts.FiniteNonNegative, 20),
    LauncherStructureDamage = FastFlags.Replicated("Game.CursedIslandWars.LauncherStructureDamage", Asserts.FiniteNonNegative, 25),
    LauncherCrystalDamage = FastFlags.Replicated("Game.CursedIslandWars.LauncherCrystalDamage", Asserts.FiniteNonNegative, 25),
    LauncherBarrierDamage = FastFlags.Replicated("Game.CursedIslandWars.LauncherBarrierDamage", Asserts.FiniteNonNegative, 25),
    LauncherKnockback = FastFlags.Replicated("Game.CursedIslandWars.LauncherKnockback", Asserts.FiniteNonNegative, 45),
    MineCooldown = FastFlags.Replicated("Game.CursedIslandWars.MineCooldown", Asserts.FinitePositive, 2),
    MineArmSeconds = FastFlags.Replicated("Game.CursedIslandWars.MineArmSeconds", Asserts.FiniteNonNegative, 0.7),
    MineFuseSeconds = FastFlags.Replicated("Game.CursedIslandWars.MineFuseSeconds", Asserts.FiniteNonNegative, 0.25),
    MineLifetimeSeconds = FastFlags.Replicated("Game.CursedIslandWars.MineLifetimeSeconds", Asserts.FinitePositive, 60),
    MineLimit = FastFlags.Replicated("Game.CursedIslandWars.MineLimit", Asserts.IntegerPositive, 3),
    MineDamage = FastFlags.Replicated("Game.CursedIslandWars.MineDamage", Asserts.FiniteNonNegative, 60),
    MineStructureDamage = FastFlags.Replicated("Game.CursedIslandWars.MineStructureDamage", Asserts.FiniteNonNegative, 120),
    MineCrystalDamage = FastFlags.Replicated("Game.CursedIslandWars.MineCrystalDamage", Asserts.FiniteNonNegative, 150),
    MineBarrierDamage = FastFlags.Replicated("Game.CursedIslandWars.MineBarrierDamage", Asserts.FiniteNonNegative, 150),
    MineKnockback = FastFlags.Replicated("Game.CursedIslandWars.MineKnockback", Asserts.FiniteNonNegative, 90),
    WallCooldown = FastFlags.Replicated("Game.CursedIslandWars.WallCooldown", Asserts.FinitePositive, 6),
    WallLimit = FastFlags.Replicated("Game.CursedIslandWars.WallLimit", Asserts.IntegerPositive, 3),
    PadCooldown = FastFlags.Replicated("Game.CursedIslandWars.PadCooldown", Asserts.FinitePositive, 2),
    PadLifetimeSeconds = FastFlags.Replicated("Game.CursedIslandWars.PadLifetimeSeconds", Asserts.FinitePositive, 25),
    PadLaunchUp = FastFlags.Replicated("Game.CursedIslandWars.PadLaunchUp", Asserts.FinitePositive, 150),
    PadLaunchForward = FastFlags.Replicated("Game.CursedIslandWars.PadLaunchForward", Asserts.FiniteNonNegative, 55),
    MinePickupUses = FastFlags.Replicated("Game.CursedIslandWars.MinePickupUses", Asserts.IntegerPositive, 2),
    MineMaxCarried = FastFlags.Replicated("Game.CursedIslandWars.MineMaxCarried", Asserts.IntegerPositive, 3),
    MineDropSeconds = FastFlags.Replicated("Game.CursedIslandWars.MineDropSeconds", Asserts.FinitePositive, 18),
    MineDropMax = FastFlags.Replicated("Game.CursedIslandWars.MineDropMax", Asserts.IntegerPositive, 3),
    PadPickupUses = FastFlags.Replicated("Game.CursedIslandWars.PadPickupUses", Asserts.IntegerPositive, 1),
    PadMaxCarried = FastFlags.Replicated("Game.CursedIslandWars.PadMaxCarried", Asserts.IntegerPositive, 2),
    PadDropSeconds = FastFlags.Replicated("Game.CursedIslandWars.PadDropSeconds", Asserts.FinitePositive, 9),
    PadDropMax = FastFlags.Replicated("Game.CursedIslandWars.PadDropMax", Asserts.IntegerPositive, 4),
})