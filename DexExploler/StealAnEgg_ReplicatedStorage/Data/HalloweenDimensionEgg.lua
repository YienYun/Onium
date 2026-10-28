-- Script path: ReplicatedStorage.Data.HalloweenDimensionEgg
-- Decompile time: 1.73 ms

local v1, v2
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local Numeric = require(ReplicatedStorage.Shared.Utils.Numeric)
local v3 = {
    table.freeze({AssetId = "Candy Corn", Weight = 51}),
    table.freeze({AssetId = "Hollow Bat", Weight = 24}),
    table.freeze({AssetId = "Scarecrow", Weight = 18}),
    table.freeze({AssetId = "Pumpkin Golem", Weight = 6.5}),
    (table.freeze({AssetId = "Soul Phantom", Weight = 0.5})),
}
local u103 = {}
local u117 = 0
local v4 = {
    DisplayName = "Halloween Dimension Egg",
    ModelName = "Halloween Dimension Egg",
    Price = 2250,
    Entries = table.freeze(v3),
    Chance = function(a1) -- Line: 49 -- upvalues: u117 (ref) -- types: a1: table
        return a1.Weight / u117 * 100
    end,
    Roll = function(a1) -- Line: 53 -- upvalues: Numeric (val), u103 (val) -- types: a1: userdata
        return (Numeric.RollWeighted(u103, a1))
    end,
}
local v5 = nil
local v6 = nil
for i, j in v3, v5, v6 do
    v1 = Assets.Directory[j.AssetId]
    v2 = ("%* is not in Data.Assets"):format(j.AssetId)
    assert(v1 ~= nil, v2)
    assert(v1.Egg.ModelName == "Halloween Dimension Egg", (("%* must hatch from the Halloween Dimension Egg"):format(j.AssetId)))
    assert(0 < j.Weight, (("%* needs a positive weight"):format(j.AssetId)))
    table.insert(u103, (table.freeze({j.AssetId, j.Weight})))
    u117 = u117 + j.Weight
end
table.freeze(u103)
return (table.freeze(v4))