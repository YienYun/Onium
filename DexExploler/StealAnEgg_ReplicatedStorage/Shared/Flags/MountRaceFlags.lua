-- Script path: ReplicatedStorage.Shared.Flags.MountRaceFlags
-- Decompile time: 3.91 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function positive(a1, a2) -- Line: 8 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.MountRace.%*"):format(a1), Asserts.FinitePositive, a2)
end

local function ratio(a1, a2) -- Line: 12 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.MountRace.%*"):format(a1), Asserts.Range(0, 1), a2)
end

local function whole(a1, a2) -- Line: 16 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: number
    return FastFlags.Replicated(("Game.MountRace.%*"):format(a1), Asserts.IntegerPositive, a2)
end

local function boolean(a1, a2) -- Line: 20 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: boolean
    return FastFlags.Replicated(("Game.MountRace.%*"):format(a1), Asserts.Boolean, a2)
end

return table.freeze({
    Laps = FastFlags.Replicated("Game.MountRace.Laps", Asserts.IntegerPositive, 3),
    JoinSeconds = FastFlags.Replicated("Game.MountRace.JoinSeconds", Asserts.FiniteNonNegative, 5),
    CountdownSeconds = FastFlags.Replicated("Game.MountRace.CountdownSeconds", Asserts.FinitePositive, 3),
    FinishGraceSeconds = FastFlags.Replicated("Game.MountRace.FinishGraceSeconds", Asserts.FinitePositive, 120),
    MaxRaceSeconds = FastFlags.Replicated("Game.MountRace.MaxRaceSeconds", Asserts.FinitePositive, 600),
    ResultsSeconds = FastFlags.Replicated("Game.MountRace.ResultsSeconds", Asserts.FinitePositive, 8),
    AllowLateJoin = FastFlags.Replicated("Game.MountRace.AllowLateJoin", Asserts.Boolean, true),
    TopSpeed = FastFlags.Replicated("Game.MountRace.TopSpeed", Asserts.FinitePositive, 110),
    AccelSeconds = FastFlags.Replicated("Game.MountRace.AccelSeconds", Asserts.FinitePositive, 3),
    BrakeSeconds = FastFlags.Replicated("Game.MountRace.BrakeSeconds", Asserts.FinitePositive, 0.8),
    CoastSeconds = FastFlags.Replicated("Game.MountRace.CoastSeconds", Asserts.FinitePositive, 6),
    ReverseSpeed = FastFlags.Replicated("Game.MountRace.ReverseSpeed", Asserts.FinitePositive, 25),
    SteerDegreesPerSecond = FastFlags.Replicated("Game.MountRace.SteerDegreesPerSecond", Asserts.FinitePositive, 140),
    HighSpeedSteerScale = FastFlags.Replicated("Game.MountRace.HighSpeedSteerScale", Asserts.Range(0, 1), 0.55),
    JumpPower = FastFlags.Replicated("Game.MountRace.JumpPower", Asserts.FinitePositive, 55),
    MaxGroundAngle = FastFlags.Replicated("Game.MountRace.MaxGroundAngle", Asserts.FinitePositive, 65),
    TouchAutoThrottle = FastFlags.Replicated("Game.MountRace.TouchAutoThrottle", Asserts.Boolean, false),
    TouchSteerGain = FastFlags.Replicated("Game.MountRace.TouchSteerGain", Asserts.FinitePositive, 1.25),
    TouchSteerAssistDegrees = FastFlags.Replicated("Game.MountRace.TouchSteerAssistDegrees", Asserts.FiniteNonNegative, 35),
    HandbrakeSteerScale = FastFlags.Replicated("Game.MountRace.HandbrakeSteerScale", Asserts.FinitePositive, 1.8),
    HandbrakeGrip = FastFlags.Replicated("Game.MountRace.HandbrakeGrip", Asserts.Range(0, 1), 0.3),
    HandbrakeSpeedBleed = FastFlags.Replicated("Game.MountRace.HandbrakeSpeedBleed", Asserts.Range(0, 1), 0.25),
    BoostPadMultiplier = FastFlags.Replicated("Game.MountRace.BoostPadMultiplier", Asserts.FinitePositive, 1.6),
    BoostPadSeconds = FastFlags.Replicated("Game.MountRace.BoostPadSeconds", Asserts.FinitePositive, 1.2),
    SlowPadMultiplier = FastFlags.Replicated("Game.MountRace.SlowPadMultiplier", Asserts.Range(0, 1), 0.5),
    WallSpeedKeep = FastFlags.Replicated("Game.MountRace.WallSpeedKeep", Asserts.Range(0, 1), 0.45),
    WallJoltMinSpeed = FastFlags.Replicated("Game.MountRace.WallJoltMinSpeed", Asserts.FinitePositive, 50),
    GhostContactSmoothing = FastFlags.Replicated("Game.MountRace.GhostContactSmoothing", Asserts.Boolean, true),
    LoopMinSpeedRatio = FastFlags.Replicated("Game.MountRace.LoopMinSpeedRatio", Asserts.Range(0, 1), 0.7),
    FovBase = FastFlags.Replicated("Game.MountRace.FovBase", Asserts.FinitePositive, 70),
    FovMax = FastFlags.Replicated("Game.MountRace.FovMax", Asserts.FinitePositive, 100),
    RiderAnimationsEnabled = FastFlags.Replicated("Game.MountRace.RiderAnimationsEnabled", Asserts.Boolean, true),
    AirFallSeconds = FastFlags.Replicated("Game.MountRace.AirFallSeconds", Asserts.FinitePositive, 2.5),
    RespawnFadeSeconds = FastFlags.Replicated("Game.MountRace.RespawnFadeSeconds", Asserts.FinitePositive, 0.35),
    UnstickEnabled = FastFlags.Replicated("Game.MountRace.UnstickEnabled", Asserts.Boolean, true),
    UnstickSeconds = FastFlags.Replicated("Game.MountRace.UnstickSeconds", Asserts.FinitePositive, 0.3),
    UnstickBuryStuds = FastFlags.Replicated("Game.MountRace.UnstickBuryStuds", Asserts.FinitePositive, 0.4),
    UnstickStallSeconds = FastFlags.Replicated("Game.MountRace.UnstickStallSeconds", Asserts.FinitePositive, 0.75),
    UnstickStallSpeed = FastFlags.Replicated("Game.MountRace.UnstickStallSpeed", Asserts.FinitePositive, 3),
    UnstickLift = FastFlags.Replicated("Game.MountRace.UnstickLift", Asserts.FinitePositive, 0.5),
    UnstickGhostSeconds = FastFlags.Replicated("Game.MountRace.UnstickGhostSeconds", Asserts.FiniteNonNegative, 0.2),
    UnstickCooldownSeconds = FastFlags.Replicated("Game.MountRace.UnstickCooldownSeconds", Asserts.FinitePositive, 1),
    EventRacersWithBots = FastFlags.Replicated("Game.MountRace.EventRacersWithBots", Asserts.IntegerPositive, 7),
    EventSkipsRacers = FastFlags.Replicated("Game.MountRace.EventSkipsRacers", Asserts.Boolean, true),
    BotSkillMin = FastFlags.Replicated("Game.MountRace.BotSkillMin", Asserts.Range(0, 1), 0.93),
    BotSkillMax = FastFlags.Replicated("Game.MountRace.BotSkillMax", Asserts.Range(0, 1), 0.99),
    BotCornerSlow = FastFlags.Replicated("Game.MountRace.BotCornerSlow", Asserts.Range(0, 1), 0.86),
    BotCatchUpMax = FastFlags.Replicated("Game.MountRace.BotCatchUpMax", Asserts.FinitePositive, 1.35),
    BotFarCatchUpMax = FastFlags.Replicated("Game.MountRace.BotFarCatchUpMax", Asserts.FinitePositive, 1.5),
    BotHoldBackMin = FastFlags.Replicated("Game.MountRace.BotHoldBackMin", Asserts.Range(0, 1), 0.86),
    BotBandStuds = FastFlags.Replicated("Game.MountRace.BotBandStuds", Asserts.FinitePositive, 140),
    BotPackSpread = FastFlags.Replicated("Game.MountRace.BotPackSpread", Asserts.FinitePositive, 70),
    BotReactionSeconds = FastFlags.Replicated("Game.MountRace.BotReactionSeconds", Asserts.FinitePositive, 0.5),
    BotItemHoldSeconds = FastFlags.Replicated("Game.MountRace.BotItemHoldSeconds", Asserts.FinitePositive, 7),
    BotAttackCooldown = FastFlags.Replicated("Game.MountRace.BotAttackCooldown", Asserts.FinitePositive, 3.5),
    BotUsesBoostPads = FastFlags.Replicated("Game.MountRace.BotUsesBoostPads", Asserts.Boolean, true),
    BotSkywhaleScale = FastFlags.Replicated("Game.MountRace.BotSkywhaleScale", Asserts.FinitePositive, 1.45),
    BotSerumScale = FastFlags.Replicated("Game.MountRace.BotSerumScale", Asserts.FinitePositive, 1.3),
    BotFinishDelaySeconds = FastFlags.Replicated("Game.MountRace.BotFinishDelaySeconds", Asserts.FiniteNonNegative, 0.3),
    HazardsEnabled = FastFlags.Replicated("Game.MountRace.HazardsEnabled", Asserts.Boolean, true),
    HazardCount = FastFlags.Replicated("Game.MountRace.HazardCount", Asserts.IntegerPositive, 6),
    HazardRespawnSeconds = FastFlags.Replicated("Game.MountRace.HazardRespawnSeconds", Asserts.FinitePositive, 5),
    HazardStun = FastFlags.Replicated("Game.MountRace.HazardStun", Asserts.FinitePositive, 1.2),
})