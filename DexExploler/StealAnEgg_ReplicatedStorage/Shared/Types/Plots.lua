-- Script path: ReplicatedStorage.Shared.Types.Plots
-- Decompile time: 0.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return {
    SchemaValidation = {
        PlotStateUpdate = t.interface({
            Revision = t.number,
            Slot = t.number,
            UserId = t.optional(t.number),
        }),
        PlotStateSnapshot = t.interface({Revision = t.number, OwnersBySlot = t.map(t.string, t.number)}),
    },
}