-- Script path: ReplicatedStorage.Data.BrainrotEgg
-- Decompile time: 1.79 ms

local v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local freeze = table.freeze
local v2 = {}
local v3 = table.freeze({"Tung Tung Sahur", 39})
local v4 = table.freeze({"Bananita Dolphinita", 25})
local v5 = table.freeze({"Belula Beluga", 20})
local v6 = table.freeze({"Mangolini Parrochini", 10})
local freeze_6 = table.freeze
local v7 = {"Bomboclat Crocolat", 5}
local v8 = freeze_6(v7)
local freeze_7 = table.freeze
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
v2[5] = v8
v2[6] = freeze_7({"Strawberry Elephant", 1})
local v9 = freeze(v2)
assert(#v9 == 6, "Brainrot egg presentation requires exactly six drop entries")
local v10 = {}
for i, v in ipairs(v9) do
    v8 = v[1]
    v7 = v[2]
    t.strict(t.string)(v8)
    t.strict(t.number)(v7)
    v1 = ("Brainrot egg drop entry %* requires positive weight"):format(i)
    assert(v7 > 0, v1)
    table.insert(v10, (table.freeze({AssetId = v8, Weight = v7})))
end
return (table.freeze({
    DisplayName = "Brainrot Egg",
    BackgroundImage = "rbxassetid://70476079280223",
    DropTable = v9,
    Entries = table.freeze(v10),
}))