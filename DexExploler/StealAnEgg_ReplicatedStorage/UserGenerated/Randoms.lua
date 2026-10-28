-- Script path: ReplicatedStorage.UserGenerated.Randoms
-- Decompile time: 0.37 ms

require(game.ReplicatedStorage.UserGenerated.Randoms.Base)
local Xorshift128 = require(game.ReplicatedStorage.UserGenerated.Randoms.Xorshift128)
return table.freeze({
    DefaultXorshift128 = Xorshift128.R,
    Xorshift128 = function(a1) -- Line: 28 -- upvalues: Xorshift128 (val)
        return Xorshift128.new(a1)
    end,
    UniqueXorshift128 = function(a1) -- Line: 31 -- upvalues: Xorshift128 (val) -- types: a1: number?
        return Xorshift128.Unique(a1)
    end,
})