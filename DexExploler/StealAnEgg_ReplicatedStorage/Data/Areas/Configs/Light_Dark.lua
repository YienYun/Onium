-- Script path: ReplicatedStorage.Data.Areas.Configs.Light Dark
-- Decompile time: 3.50 ms

require(script.Parent.Parent.Types)
local v1 = {
    {"Dove", 37.51},
    {"Lamb", 26.27},
    {"Moth", 16.83},
    {"Peacock", 13.96},
    {"Jellyfish", 4.36},
    {"Centaur", 0.74},
    {"Pegasus", 0.31},
    {"ArchAngel", 0.02},
}
local v2 = {
    {"Flame Sprite", 37.51},
    {"Toro", 26.27},
    {"Imp", 16.83},
    {"Demon Hound", 13.96},
    {"Dark Gargoyle", 4.36},
    {"RazorFang", 0.74},
    {"Skeleton Horse", 0.31},
    {"World Burner", 0.02},
}
local v3 = {
    {"Moth", 23.23},
    {"Peacock", 19.27},
    {"Jellyfish", 6.02},
    {"Centaur", 1.02},
    {"Pegasus", 0.43},
    {"ArchAngel", 0.03},
    {"Imp", 23.23},
    {"Demon Hound", 19.27},
    {"Dark Gargoyle", 6.02},
    {"RazorFang", 1.02},
    {"Skeleton Horse", 0.43},
    {"World Burner", 0.03},
}

local function poolOf(a1) -- Line: 41 -- types: a1: table
    local v1 = {}
    for i, j in a1 do
        table.insert(v1, j[1])
    end
    return v1
end

local v4 = table.move(v2, 1, #v2, #v1 + 1, table.clone(v1))
local v5 = {
    DisplayName = "Angels & Demons",
    Emoji = "☯️",
    GuardId = "Light Dark",
    Icon = "rbxassetid://129135259472825",
    IndexBatGearId = "Light Dark Staff",
    _id = "Light Dark",
    Color = Color3.fromRGB(196, 148, 255),
    DropTable = v4,
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.LightDark,
    Reveal = {Flag = "LightDarkReveal", RevealSubBiome = "Mixed"},
}
local v6 = {}
local v7 = {
    Id = "Light",
    DisplayName = "Angels",
    Emoji = "👼",
    Weight = 45,
    LuckRolls = 1,
    Props = "Light",
    Announcement = "☀️ The Light has risen over the Angels & Demons biome!",
}
local v8 = {}
for i, j in v1 do
    table.insert(v8, j[1])
end
v7.Pool = v8
v7.DropTable = v1
v7.Color = Color3.fromRGB(255, 255, 255)
v7.Gradient = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    (ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 226, 255))),
})
v7.GuardIds = {"Light Dark Light"}
v8 = {
    Id = "Dark",
    DisplayName = "Demons",
    Emoji = "😈",
    Weight = 45,
    LuckRolls = 1,
    Props = "Dark",
    Announcement = "🌑 The Dark has fallen over the Angels & Demons biome!",
}
local v9 = {}
for k, n in v2 do
    table.insert(v9, n[1])
end
v8.Pool = v9
v8.DropTable = v2
v8.Color = Color3.fromRGB(224, 46, 46)
v8.Gradient = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 92, 92)),
    (ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 18, 18))),
})
v8.GuardIds = {"Light Dark Dark"}
v9 = {
    Id = "Mixed",
    DisplayName = "Angels & Demons",
    Emoji = "☯️",
    Weight = 10,
    LuckRolls = 1,
    Props = "MixedRealm",
    HidesZoneFloor = true,
    Announcement = "🌗 A rare Mixed night! The rarest Angels & Demons eggs share the biome tonight!",
}
local v10 = {}
for m, i5 in v3 do
    table.insert(v10, i5[1])
end
v9.Pool = v10
v9.DropTable = v3
v9.Color = Color3.fromRGB(255, 150, 150)
v9.Gradient = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 246, 246)),
    ColorSequenceKeypoint.new(0.58, Color3.fromRGB(255, 92, 92)),
    (ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 18, 18))),
})
v9.GuardIds = {"Light Dark Mixed"}
v6[1] = v7
v6[2] = v8
v6[3] = v9
v5.SubBiomes = v6
return table.freeze(v5)