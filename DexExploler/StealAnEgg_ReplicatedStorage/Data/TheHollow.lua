-- Script path: ReplicatedStorage.Data.TheHollow
-- Decompile time: 1.80 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
require(ReplicatedStorage.Data.RaceRally)
local u14 = {}
u14.Prizes = BalanceConfig.Bind("Game.Balance.TheHollowPrizes", {
    Win1 = {Order = 1, Wins = 1, Rewards = {{Kind = "CashBooster", Multiplier = 1.5, Seconds = 300}}},
    Win2 = {Order = 2, Wins = 2, Rewards = {{Kind = "CashBooster", Multiplier = 2, Seconds = 600}}},
    Win3 = {Order = 3, Wins = 3, Rewards = {{Kind = "SpeedBoost", Seconds = 600}}},
}, {Wins = true}, true, function(a1) -- Line: 23 -- types: a1: table
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = false
        if 1 <= j.Wins then
            v1 = j.Wins % 1 == 0
        end
        assert(v1, (("TheHollowPrizes.%*.Wins must be a whole number of at least 1"):format(i)))
    end
end)

function u14.OrderedPrizes() -- Line: 30 -- upvalues: u14 (val)
    local v1 = {}
    for i, j in u14.Prizes do
        table.insert(v1, {Id = i, Config = j})
    end
    table.sort(v1, function(a1, a2) -- Line: 35
        return a1.Config.Order < a2.Config.Order
    end)
    return v1
end

return table.freeze(u14)