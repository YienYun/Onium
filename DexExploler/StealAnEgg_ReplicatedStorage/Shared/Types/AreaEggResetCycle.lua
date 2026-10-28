-- Script path: ReplicatedStorage.Shared.Types.AreaEggResetCycle
-- Decompile time: 0.66 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.interface({
    EggUid = t.string,
    Message = t.string,
    RarityId = t.string,
    SoundId = t.optional(t.number),
})
local v2 = t.array(v1)
return {
    SchemaValidation = {
        RareSpawnPresentation = v1,
        RareSpawnPresentations = v2,
        SequencePayload = t.strictInterface({DayStartsAt = t.number}),
        RevealPayload = t.strictInterface({PeriodIndex = t.number, DayStartsAt = t.number, RareSpawns = v2}),
    },
}