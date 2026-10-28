-- Script path: ReplicatedStorage.UserGenerated.ABTests.SharedABTests
-- Decompile time: 0.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
return table.freeze({
    UpdateRemote = script:WaitForChild("Update"),
    ABTestDefaults = FastFlags.Replicated("UserGenerated.ABTestDefaults", Asserts.Map(Asserts.String, Asserts.Any), {}),
})