-- Script path: ReplicatedStorage.Shared.Types.RaceRally
-- Decompile time: 1.37 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.integer, t.numberMin(0))
local v2 = {Purchase = t.strictInterface({Period = t.integer, Count = v1})}
v2.State = t.strictInterface({
    Tokens = v1,
    Wins = v1,
    Races = v1,
    Milestones = t.map(t.string, t.boolean),
    Repeats = v1,
    Racers = t.map(t.string, t.boolean),
    EquippedRacer = t.string,
    Purchases = t.map(t.string, v2.Purchase),
    MutationConsumables = v1,
    LastRacedWindow = t.optional(t.integer),
})

function v2.Blank() -- Line: 43
    return {
        Tokens = 0,
        Wins = 0,
        Races = 0,
        Repeats = 0,
        EquippedRacer = "",
        MutationConsumables = 0,
        Milestones = {},
        Racers = {},
        Purchases = {},
    }
end

return table.freeze(v2)