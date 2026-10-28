-- Script path: ReplicatedStorage.Client.Types.ShakeRequestData
-- Decompile time: 0.49 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return {
    SchemaValidation = t.interface({
        FadeInTime = t.optional(t.number),
        FadeOutTime = t.numberConstrainedExclusive(0, (1 / 0)),
        Magnitude = t.number,
        PosInfluence = t.optional(t.Vector3),
        RotInfluence = t.optional(t.Vector3),
        Roughness = t.number,
    }),
}