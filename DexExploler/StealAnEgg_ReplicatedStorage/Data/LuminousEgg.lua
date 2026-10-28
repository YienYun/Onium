-- Script path: ReplicatedStorage.Data.LuminousEgg
-- Decompile time: 2.19 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = table.freeze({
    table.freeze({"Spike", 39}),
    table.freeze({"Manta Ray", 24}),
    table.freeze({"Megalodon", 18}),
    table.freeze({"Electric Eel", 11}),
    table.freeze({"Terra Snapper", 6.5}),
    (table.freeze({"Cthulhu", 0.5})),
})
local v2 = table.freeze({
    table.freeze({"Depths Spike", 39}),
    table.freeze({"Depths Manta Ray", 24}),
    table.freeze({"Depths Megalodon", 18}),
    table.freeze({"Depths Electric Eel", 11}),
    table.freeze({"Depths Terra Snapper", 6.5}),
    (table.freeze({"Depths Cthulhu", 0.5})),
})
assert(#v1 == 6, "Luminous egg presentation requires exactly six drop entries")
assert(#v2 == 6, "Luminous egg presentation requires exactly six mecha drop entries")

local function buildEntries(a1) -- Line: 42 -- upvalues: t (val) -- types: a1: table
    local v1, v2, v3
    local v4 = {}
    for i, v in ipairs(a1) do
        v2 = v[1]
        v3 = v[2]
        t.strict(t.string)(v2)
        t.strict(t.number)(v3)
        v1 = ("Luminous egg drop entry %* requires positive weight"):format(i)
        assert(v3 > 0, v1)
        table.insert(v4, (table.freeze({AssetId = v2, Weight = v3})))
    end
    return table.freeze(v4)
end

return (table.freeze({
    DisplayName = "Luminous Egg",
    BackgroundImage = "rbxassetid://108209625322017",
    DropTable = v1,
    Entries = buildEntries(v1),
    MechaEntries = buildEntries(v2),
}))