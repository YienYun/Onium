-- Script path: ReplicatedStorage.Shared.Flags.BanjoCricketFlags
-- Decompile time: 0.74 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    BridgeReach = FastFlags.Replicated("Game.BanjoCricket.BridgeReach", Asserts.FinitePositive, 10),
    BridgePlaySeconds = FastFlags.Replicated("Game.BanjoCricket.BridgePlaySeconds", Asserts.FinitePositive, 3),
    Enabled = FastFlags.Replicated("Game.BanjoCricket.Enabled", Asserts.Boolean, true),
    Stages = FastFlags.Replicated("Game.BanjoCricket.Stages", Asserts.IntegerRange(1, BanjoCricket.MaxStages), 5),
})