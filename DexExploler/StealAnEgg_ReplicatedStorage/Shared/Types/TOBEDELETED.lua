-- Script path: ReplicatedStorage.Shared.Types.TOBEDELETED
-- Decompile time: 0.38 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return table.freeze({
    State = t.strictInterface({Met = t.boolean, KeyClaimed = t.boolean, GateUnlocked = t.boolean}),
    Blank = function() -- Line: 14
        return {Met = false, KeyClaimed = false, GateUnlocked = false}
    end,
})