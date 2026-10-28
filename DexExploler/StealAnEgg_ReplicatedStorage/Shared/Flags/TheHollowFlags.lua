-- Script path: ReplicatedStorage.Shared.Flags.TheHollowFlags
-- Decompile time: 2.12 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function isEnabledByDefault() -- Line: 10 -- upvalues: Environment (val), RunService (val)
    return Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
end

return table.freeze({
    ContentEnabled = FastFlags.Replicated(
        "Game.TheHollow.ContentEnabled",
        Asserts.Boolean,
        Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
    ),
    JoinSeconds = FastFlags.Replicated("Game.TheHollow.JoinSeconds", Asserts.IntegerPositive, 30),
    Laps = FastFlags.Replicated("Game.TheHollow.Laps", Asserts.IntegerPositive, 3),
    RacersWithBots = FastFlags.Replicated("Game.TheHollow.RacersWithBots", Asserts.IntegerNonNegative, 6),
    MaxConcurrentRaces = FastFlags.Replicated("Game.TheHollow.MaxConcurrentRaces", Asserts.IntegerRange(1, 16), 8),
    WinsForBadge = FastFlags.Replicated("Game.TheHollow.WinsForBadge", Asserts.IntegerPositive, 3),
    AnnounceRaceStart = FastFlags.Replicated("Game.TheHollow.AnnounceRaceStart", Asserts.Boolean, false),
    PodiumPlaces = FastFlags.Replicated("Game.TheHollow.PodiumPlaces", Asserts.IntegerNonNegative, 3),
    BotsFillWhileJoining = FastFlags.Replicated("Game.TheHollow.BotsFillWhileJoining", Asserts.Boolean, true),
    BotSkillMin = FastFlags.Replicated("Game.TheHollow.BotSkillMin", Asserts.Range(0, 1), 0.93),
    BotSkillMax = FastFlags.Replicated("Game.TheHollow.BotSkillMax", Asserts.Range(0, 1), 0.99),
    BotCornerSlow = FastFlags.Replicated("Game.TheHollow.BotCornerSlow", Asserts.Range(0, 1), 0.86),
    BotCatchUpMax = FastFlags.Replicated("Game.TheHollow.BotCatchUpMax", Asserts.FinitePositive, 1.31),
    BotFarCatchUpMax = FastFlags.Replicated("Game.TheHollow.BotFarCatchUpMax", Asserts.FinitePositive, 1.44),
    BotHoldBackMin = FastFlags.Replicated("Game.TheHollow.BotHoldBackMin", Asserts.Range(0, 1), 0.86),
    BotBandStuds = FastFlags.Replicated("Game.TheHollow.BotBandStuds", Asserts.FinitePositive, 140),
    BotPackSpread = FastFlags.Replicated("Game.TheHollow.BotPackSpread", Asserts.FinitePositive, 70),
    BotReactionSeconds = FastFlags.Replicated("Game.TheHollow.BotReactionSeconds", Asserts.FinitePositive, 0.5),
    BotItemHoldSeconds = FastFlags.Replicated("Game.TheHollow.BotItemHoldSeconds", Asserts.FinitePositive, 7),
    BotAttackCooldown = FastFlags.Replicated("Game.TheHollow.BotAttackCooldown", Asserts.FinitePositive, 3.5),
    BotUsesBoostPads = FastFlags.Replicated("Game.TheHollow.BotUsesBoostPads", Asserts.Boolean, true),
    BotSkywhaleScale = FastFlags.Replicated("Game.TheHollow.BotSkywhaleScale", Asserts.FinitePositive, 1.45),
    BotSerumScale = FastFlags.Replicated("Game.TheHollow.BotSerumScale", Asserts.FinitePositive, 1.3),
    BotFinishDelaySeconds = FastFlags.Replicated("Game.TheHollow.BotFinishDelaySeconds", Asserts.FiniteNonNegative, 0.3),
    BotThrowHitChance = FastFlags.Replicated("Game.TheHollow.BotThrowHitChance", Asserts.Range(0, 1), 0.55),
    BotThrowSpreadDegrees = FastFlags.Replicated("Game.TheHollow.BotThrowSpreadDegrees", Asserts.Range(0, 45), 3),
    MountName = FastFlags.Replicated("Game.TheHollow.MountName", Asserts.String, "ShelltideVoyager"),
    RiderFollowsDeck = FastFlags.Replicated("Game.TheHollow.RiderFollowsDeck", Asserts.Boolean, true),
    CrownImage = FastFlags.Replicated("Game.TheHollow.CrownImage", Asserts.String, "rbxassetid://76336013947157"),
    UseRacerRoster = FastFlags.Replicated("Game.TheHollow.UseRacerRoster", Asserts.Boolean, true),
    RosterIncludesDefaults = FastFlags.Replicated("Game.TheHollow.RosterIncludesDefaults", Asserts.Boolean, false),
    HideBadgeAfterGrandPrize = FastFlags.Replicated("Game.TheHollow.HideBadgeAfterGrandPrize", Asserts.Boolean, true),
    BadgeReveal = FastFlags.Replicated("Game.TheHollow.BadgeReveal", Asserts.Boolean, true),
    BadgeRevealImage = FastFlags.Replicated("Game.TheHollow.BadgeRevealImage", Asserts.String, "rbxassetid://123501512178420"),
    QueueWhenFull = FastFlags.Replicated("Game.TheHollow.QueueWhenFull", Asserts.Boolean, true),
    StopOnBlockingEvents = FastFlags.Replicated("Game.TheHollow.StopOnBlockingEvents", Asserts.Boolean, true),
    LogAbortedRaces = FastFlags.Replicated("Game.TheHollow.LogAbortedRaces", Asserts.Boolean, true),
    CountWinsAttribute = FastFlags.Replicated("Game.TheHollow.CountWinsAttribute", Asserts.Boolean, true),
})