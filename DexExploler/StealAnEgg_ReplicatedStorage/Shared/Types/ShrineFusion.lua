-- Script path: ReplicatedStorage.Shared.Types.ShrineFusion
-- Decompile time: 0.61 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return table.freeze({
    State = t.map(t.string, t.union(t.literal(false), (t.strictInterface({TransactionId = t.string, EggUid = t.string, CompletedAt = t.number})))),
    Blank = function() -- Line: 17
        return {Divine = false, Eternal = false}
    end,
})