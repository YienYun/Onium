-- Script path: ReplicatedStorage.Shared.Types.TheHollow
-- Decompile time: 0.82 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return table.freeze({
    State = t.strictInterface({
        Wins = t.intersection(t.integer, t.numberMin(0)),
        Claimed = t.map(t.string, t.boolean),
    }),
    Blank = function() -- Line: 21
        return {Wins = 0, Claimed = {}}
    end,
})