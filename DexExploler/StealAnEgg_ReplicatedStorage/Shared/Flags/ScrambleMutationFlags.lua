-- Script path: ReplicatedStorage.Shared.Flags.ScrambleMutationFlags
-- Decompile time: 0.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
return table.freeze({
    SuccessPercent = (require(ReplicatedStorage.UserGenerated.FastFlags)).Replicated(
        "Game.Scramble.MutationConsumableSuccessPercent",
        (require(ReplicatedStorage.UserGenerated.Lang.Asserts)).Range(0, 100),
        10
    ),
})