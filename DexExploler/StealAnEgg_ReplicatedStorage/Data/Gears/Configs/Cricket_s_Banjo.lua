-- Script path: ReplicatedStorage.Data.Gears.Configs.Cricket's Banjo
-- Decompile time: 0.59 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
require(script.Parent.Parent.Types)
return table.freeze({
    _id = "Cricket's Banjo",
    DisplayName = "Cricket's Banjo",
    Description = "A secret musical weapon. Play it beside an enchanted bridge.",
    Icon = "rbxassetid://115673497063198",
    DisplayInShop = false,
    MaxShopStockQuantity = 99,
    MinShopStockQuantity = 0,
    MoneyCost = 0,
    Persistent = true,
    Rarity = "Secret",
    ShopDropWeight = 0,
    OneTime = false,
    SlapPower = 80,
    ToolController = "Slap",
    ControllerData = {
        Brainrot = {BrainrotDamage = 40, Duration = 0.5, Force = 35, MaxBrainrotTargets = 1},
        Player = {BrainrotDamage = 40, Duration = 1.03, Force = 35, MaxBrainrotTargets = 1},
    },
    Instrument = {
        AnimationId = "rbxassetid://126867686124159",
        Hand = "LeftHand",
        SwingHand = "RightHand",
        SwingAnimationId = "rbxassetid://92893116518492",
        SwingGrip = "SwingGrip",
        EquipLoop = "EquipLoop",
        Notes = BanjoCricket.Mushrooms,
    },
})