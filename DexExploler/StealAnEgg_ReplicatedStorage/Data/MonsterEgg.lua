-- Script path: ReplicatedStorage.Data.MonsterEgg
-- Decompile time: 1.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = table.freeze({
    table.freeze({"Scorpio", 39}),
    table.freeze({"Froggo", 24}),
    table.freeze({"Crawler", 18}),
    table.freeze({"Crocodon", 11}),
    table.freeze({"Krakenoid", 6.5}),
    (table.freeze({"Dreadscale", 0.5})),
})
local v2 = table.freeze({
    table.freeze({"Mecha Scorpio", 40}),
    table.freeze({"Mecha Froggo", 24}),
    table.freeze({"Mecha Crawler", 18}),
    table.freeze({"Mecha Crocodon", 11}),
    table.freeze({"Mecha Krakenoid", 6.5}),
    (table.freeze({"Mecha Dreadscale", 0.5})),
})
assert(#v1 == 6, "Monster egg presentation requires exactly six drop entries")
assert(#v2 == 6, "Monster egg presentation requires exactly six mecha drop entries")

local function buildEntries(a1) -- Line: 42 -- upvalues: t (val) -- types: a1: table
    local v1, v2, v3
    local v4 = {}
    for i, v in ipairs(a1) do
        v2 = v[1]
        v3 = v[2]
        t.strict(t.string)(v2)
        t.strict(t.number)(v3)
        v1 = ("Monster egg drop entry %* requires positive weight"):format(i)
        assert(v3 > 0, v1)
        table.insert(v4, (table.freeze({AssetId = v2, Weight = v3})))
    end
    return table.freeze(v4)
end

return (table.freeze({
    DisplayName = "Monster Egg",
    BackgroundImage = "rbxassetid://97929357121314",
    DropTable = v1,
    Entries = buildEntries(v1),
    MechaEntries = buildEntries(v2),
}))