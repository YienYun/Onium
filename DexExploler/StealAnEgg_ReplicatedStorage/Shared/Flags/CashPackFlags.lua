-- Script path: ReplicatedStorage.Shared.Flags.CashPackFlags
-- Decompile time: 2.17 ms

local Bind, v1, v2
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local BalanceConfig = require(script.Parent.BalanceConfig)
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local u23 = {}
for i, j in CashPacks.Offers do
    Bind = BalanceConfig.Bind
    v1 = "Game.Balance.ProductRewards." .. j.Name
    v2 = {Amount = j.Floor}
    u23[i] = (Bind(v1, v2, true, false, function(a1) -- Line: 17 -- types: a1: table
        assert(0 < a1.Amount)
    end))
end
local u47 = FastFlags.Replicated("Game.CashPacks.Minutes", function(a1) -- Line: 23 -- upvalues: Asserts (val), CashPacks (val) -- types: a1: table
    Asserts.Array(Asserts.FinitePositive)(a1)
    assert(#a1 == #CashPacks.Offers, "Cash packs require five durations")
    return a1
end, {40, 120, 360, 1080, 2880})
return {
    GrowthMultiplier = FastFlags.Replicated("Game.CashPacks.GrowthMultiplier", Asserts.Range(1, 10), 1.2),
    RefreshEverySession = FastFlags.Replicated("Game.CashPacks.RefreshEverySession", Asserts.Boolean, true),
    GetOffers = function() -- Line: 36 -- upvalues: CashPacks (val), u47 (val), u23 (val)
        local v1
        local v2 = {}
        for i, j in CashPacks.Offers do
            v1 = table.clone(j)
            v1.Minutes = u47:Get()[i]
            v1.Floor = math.max(j.Floor, u23[i].Amount)
            v2[i] = v1
        end
        return v2
    end,
}