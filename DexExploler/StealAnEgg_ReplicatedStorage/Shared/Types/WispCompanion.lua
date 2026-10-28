-- Script path: ReplicatedStorage.Shared.Types.WispCompanion
-- Decompile time: 0.83 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.integer, t.numberMin(0))
return table.freeze({
    State = t.strictInterface({
        Accepted = t.boolean,
        MenuOpened = t.boolean,
        Stage = t.intersection(t.integer, t.numberMin(1), t.numberMax(4)),
        Essence = v1,
        Progress = t.map(t.string, v1),
        Claimed = t.map(t.string, t.boolean),
        Returning = t.boolean,
        Unlocked = t.boolean,
    }),
    Blank = function() -- Line: 28
        return {
            Accepted = false,
            MenuOpened = false,
            Stage = 1,
            Essence = 0,
            Returning = false,
            Unlocked = false,
            Progress = {},
            Claimed = {},
        }
    end,
    Copy = function(a1) -- Line: 32 -- types: a1: table
        local v1 = table.clone(a1)
        v1.Progress = table.clone(a1.Progress)
        v1.Claimed = table.clone(a1.Claimed)
        return v1
    end,
})