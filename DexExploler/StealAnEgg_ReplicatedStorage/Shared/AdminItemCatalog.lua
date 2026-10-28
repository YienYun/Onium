-- Script path: ReplicatedStorage.Shared.AdminItemCatalog
-- Decompile time: 2.00 ms

local DisplayName, freeze_2, v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v2 = {}
local Directory = require(ReplicatedStorage.Data.Gears).Directory
local v3 = nil
local v4 = nil
for i, j in Directory, v3, v4 do
    if i ~= "Bat" then
        freeze_2 = table.freeze
        v1 = {
            Kind = "Gear",
            DisplayName = j.DisplayName,
            MaxPerRun = if not j.OneTime then math.min(j.MaxShopStockQuantity or 1000, 1000) else 1,
        }
        v2[i] = (freeze_2(v1))
    end
end
v2.MonsterChest = table.freeze({Kind = "MonsterChest", DisplayName = "Monster Chest", MaxPerRun = 25})
v2.MutationConsumable = table.freeze({Kind = "MutationConsumable", DisplayName = "Fractured Crystal", MaxPerRun = 1000})
local u27 = {}
local u28 = {}

local function addChoice(a1, a2) -- Line: 42 -- upvalues: u28 (val), u27 (val) -- types: a1: string, a2: string
    if u28[a1] == nil then
        u28[a1] = a2
        table.insert(u27, a1)
    end
end

for k in v2 do
    if u28[k] == nil then
        u28[k] = k
        table.insert(u27, k)
    end
end
for n, m in v2 do
    DisplayName = m.DisplayName
    if u28[DisplayName] == nil then
        u28[DisplayName] = n
        table.insert(u27, DisplayName)
    end
end
for i5, i6 in {"Bee Gun", "BeeGun", "Bee Launcher"} do
    if u28[i6] == nil then
        u28[i6] = "BeeLauncher"
        table.insert(u27, i6)
    end
end
for i7, i8 in {"Fractured Crystals", "FracturedCrystal", "FracturedCrystals", "Mutation Consumable"} do
    if u28[i8] == nil then
        u28[i8] = "MutationConsumable"
        table.insert(u27, i8)
    end
end
table.sort(u27)
return table.freeze({
    Directory = table.freeze(v2),
    Choices = table.freeze(u27),
    IdByChoice = table.freeze(u28),
})