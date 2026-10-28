-- Script path: ReplicatedStorage.Data.HalloweenIndex
-- Decompile time: 1.53 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HalloweenPets = require(ReplicatedStorage.Data.HalloweenPets)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local u16 = table.freeze({})
return table.freeze({
    Category = "HalloweenPart1",
    DisplayName = "Halloween Part 1",
    BackgroundImage = "rbxassetid://91240205245018",
    Entries = u16,
    HasEntries = function() -- Line: 32 -- upvalues: u16 (val)
        return #u16 > 0
    end,
    IsComplete = function(a1) -- Line: 37 -- upvalues: u16 (val) -- types: a1: table?
        if #u16 ~= 0 and a1 ~= nil then
            for i, j in u16 do
                if not a1[j.AssetId] then
                    return false
                end
            end
            return true
        end
        return false
    end,
    GetSections = function() -- Line: 51 -- upvalues: LimitedEgg (val), HalloweenPets (val)
        local v1 = {}
        for i, j in LimitedEgg.Halloween.Entries do
            table.insert(v1, {AssetId = j.AssetId, Weight = j.Weight})
        end
        local MechaReroll = LimitedEgg.Halloween.MechaReroll
        if MechaReroll then
            for k, n in MechaReroll.Entries do
                table.insert(v1, {AssetId = n.AssetId, Weight = n.Weight})
            end
        end
        local v2 = {}
        for m, i5 in HalloweenPets.Specs do
            if i5.Group == "World" then
                table.insert(v2, {AssetId = m, Weight = i5.Weight})
            end
        end
        for i6, i7 in {
            {AssetId = "Candy Corn", Weight = 51},
            {AssetId = "Hollow Bat", Weight = 24},
            {AssetId = "Scarecrow", Weight = 18},
            {AssetId = "Pumpkin Golem", Weight = 6.5},
            {AssetId = "Soul Phantom", Weight = 0.5},
        } do
            table.insert(v2, i7)
        end
        return {
            {
                Category = "HalloweenPaidEggs",
                DisplayName = "Halloween Robux Eggs",
                BackgroundImage = "rbxassetid://125651352019259",
                Entries = v1,
            },
            {
                Category = "HalloweenWorldEggs",
                DisplayName = "Halloween World & Event Eggs",
                BackgroundImage = "rbxassetid://91240205245018",
                Entries = v2,
            },
        }
    end,
})