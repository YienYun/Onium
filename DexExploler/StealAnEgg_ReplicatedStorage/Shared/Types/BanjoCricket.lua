-- Script path: ReplicatedStorage.Shared.Types.BanjoCricket
-- Decompile time: 0.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return table.freeze({
    State = t.strictInterface({Solved = t.boolean, Claimed = t.boolean}),
    Blank = function() -- Line: 13
        return {Solved = false, Claimed = false}
    end,
})