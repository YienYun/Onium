-- Script path: ReplicatedStorage.Shared.Types.Butterflies
-- Decompile time: 0.62 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.integer, t.numberMin(0))
local v2 = {Counts = t.strictInterface({Green = v1, Blue = v1, Purple = v1, Golden = v1})}
v2.State = t.strictInterface({NetClaimed = t.boolean, Counts = v2.Counts, Essence = v1, TotalCaught = v1})

function v2.Blank() -- Line: 39
    return {
        NetClaimed = false,
        Essence = 0,
        TotalCaught = 0,
        Counts = {Green = 0, Blue = 0, Purple = 0, Golden = 0},
    }
end

return table.freeze(v2)