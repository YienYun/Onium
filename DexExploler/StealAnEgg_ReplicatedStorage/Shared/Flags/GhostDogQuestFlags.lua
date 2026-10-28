-- Script path: ReplicatedStorage.Shared.Flags.GhostDogQuestFlags
-- Decompile time: 0.73 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    Enabled = FastFlags.Replicated("Game.GhostDogQuest.Enabled", Asserts.Boolean, true),
    ChaseSeconds = FastFlags.Replicated("Game.GhostDogQuest.ChaseSeconds", Asserts.IntegerRange(10, 120), 50),
    FishChaseSeconds = FastFlags.Replicated("Game.GhostDogQuest.FishChaseSeconds", Asserts.IntegerRange(10, 120), 25),
    ChaseSpeed = FastFlags.Replicated("Game.GhostDogQuest.ChaseSpeed", Asserts.FiniteNonNegative, 58),
    ChaseHearts = FastFlags.Replicated("Game.GhostDogQuest.ChaseHearts", Asserts.IntegerRange(1, 9), 3),
    ChaseMineGapSeconds = FastFlags.Replicated("Game.GhostDogQuest.ChaseMineGapSeconds", Asserts.FiniteNonNegative, 1.15),
    ChaseLaneRepeatSeconds = FastFlags.Replicated("Game.GhostDogQuest.ChaseLaneRepeatSeconds", Asserts.FiniteNonNegative, 0.2),
    ChaseGraceSeconds = FastFlags.Replicated("Game.GhostDogQuest.ChaseGraceSeconds", Asserts.FiniteNonNegative, 3.5),
    ClaimMinShare = FastFlags.Replicated("Game.GhostDogQuest.ClaimMinShare", Asserts.FiniteNonNegative, 1),
})