-- Script path: ReplicatedStorage.Shared.Flags.OnboardingQuestlineFlags
-- Decompile time: 0.45 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    Enabled = FastFlags.Replicated("Game.OnboardingQuestline.Enabled", Asserts.Boolean, false),
    DurationSeconds = FastFlags.Replicated("Game.OnboardingQuestline.DurationSeconds", Asserts.FinitePositive, 604800),
    AutoOpenEnabled = FastFlags.Replicated("Game.OnboardingQuestline.AutoOpenEnabled", Asserts.Boolean, true),
    QuestTargets = FastFlags.Replicated("Game.OnboardingQuestline.QuestTargets", Asserts.Map(Asserts.String, Asserts.FinitePositive), {}),
})