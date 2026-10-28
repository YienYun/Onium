-- Script path: ReplicatedStorage.Shared.Flags.FishingFlags
-- Decompile time: 1.87 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    Enabled = FastFlags.Replicated("Game.Fishing.Enabled", Asserts.Boolean, true),
    DimensionOnly = FastFlags.Replicated("Game.Fishing.DimensionOnly", Asserts.Boolean, false),
    ChargeSeconds = FastFlags.Replicated("Game.Fishing.ChargeSeconds", Asserts.Range(0.4, 4), 1.2),
    PerfectMin = FastFlags.Replicated("Game.Fishing.PerfectMin", Asserts.Range(0, 1), 0.8),
    PerfectMax = FastFlags.Replicated("Game.Fishing.PerfectMax", Asserts.Range(0, 1), 0.95),
    ChargeLuck = FastFlags.Replicated("Game.Fishing.ChargeLuck", Asserts.Range(1, 10), 1.2),
    PerfectLuck = FastFlags.Replicated("Game.Fishing.PerfectLuck", Asserts.Range(1, 10), 1.5),
    MinCastDistance = FastFlags.Replicated("Game.Fishing.MinCastDistance", Asserts.Range(2, 100), 10),
    MaxCastDistance = FastFlags.Replicated("Game.Fishing.MaxCastDistance", Asserts.Range(4, 200), 42),
    CastCooldown = FastFlags.Replicated("Game.Fishing.CastCooldown", Asserts.Range(0, 30), 1),
    BiteMinSeconds = FastFlags.Replicated("Game.Fishing.BiteMinSeconds", Asserts.Range(0.5, 60), 2),
    BiteMaxSeconds = FastFlags.Replicated("Game.Fishing.BiteMaxSeconds", Asserts.Range(0.5, 60), 6),
    ReelStart = FastFlags.Replicated("Game.Fishing.ReelStart", Asserts.Range(0, 1), 0.3),
    ReelClickGain = FastFlags.Replicated("Game.Fishing.ReelClickGain", Asserts.Range(0.01, 1), 0.075),
    ReelDrainPerSecond = FastFlags.Replicated("Game.Fishing.ReelDrainPerSecond", Asserts.Range(0, 5), 0.3),
    ReelMinSeconds = FastFlags.Replicated("Game.Fishing.ReelMinSeconds", Asserts.Range(0, 30), 0.6),
    ReelMaxClicksPerSecond = FastFlags.Replicated("Game.Fishing.ReelMaxClicksPerSecond", Asserts.Range(1, 60), 25),
    ReelTimeoutSeconds = FastFlags.Replicated("Game.Fishing.ReelTimeoutSeconds", Asserts.Range(5, 300), 45),
    QuestRadius = FastFlags.Replicated("Game.Fishing.QuestRadius", Asserts.Range(2, 60), 14),
    ManorKeyChance = FastFlags.Replicated("Game.Fishing.ManorKeyChance", Asserts.Range(0, 1), 0.025),
})