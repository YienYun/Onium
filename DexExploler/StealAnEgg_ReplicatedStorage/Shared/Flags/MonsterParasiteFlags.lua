-- Script path: ReplicatedStorage.Shared.Flags.MonsterParasiteFlags
-- Decompile time: 0.54 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    Enabled = FastFlags.Replicated("Game.MonsterParasite.Enabled", Asserts.Boolean, true),
    SpawnChanceByArea = FastFlags.Replicated("Game.MonsterParasite.SpawnChanceByArea", Asserts.Map(Asserts.String, Asserts.Range(0, 100)), {}),
    RewardWeights = FastFlags.Replicated("Game.MonsterParasite.RewardWeights", Asserts.Map(Asserts.String, Asserts.FiniteNonNegative), {}),
})