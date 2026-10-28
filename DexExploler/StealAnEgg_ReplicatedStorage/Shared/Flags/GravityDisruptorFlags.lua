-- Script path: ReplicatedStorage.Shared.Flags.GravityDisruptorFlags
-- Decompile time: 0.65 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    LingerSeconds = FastFlags.Replicated("Game.GravityDisruptor.LingerSeconds", Asserts.FinitePositive, 2),
    MaxPlaced = FastFlags.Replicated("Game.GravityDisruptor.MaxPlaced", Asserts.IntegerPositive, 3),
    ProjectSeconds = FastFlags.Replicated("Game.GravityDisruptor.ProjectSeconds", Asserts.FinitePositive, 7),
    SlowPercent = FastFlags.Replicated("Game.GravityDisruptor.SlowPercent", Asserts.FinitePositive, 70),
})