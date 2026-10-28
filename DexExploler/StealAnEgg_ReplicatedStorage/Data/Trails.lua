-- Script path: ReplicatedStorage.Data.Trails
-- Decompile time: 3.18 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = {
    BlueTrail = table.freeze({
        _id = "BlueTrail",
        Price = 75000,
        ProductId = 3611606747,
        Icon = "rbxassetid://137035834049811",
        SpeedMultiplier = 2.5,
        DisplayInShop = true,
        DisplayName = "Blue Trail",
        Rarity = Rarity.Rarities.Rare,
    }),
    MoonbloomTrail = table.freeze({
        _id = "MoonbloomTrail",
        Price = 5e+15,
        ProductId = 3712487399,
        Icon = "rbxassetid://123538285077698",
        SpeedMultiplier = 20,
        DisplayInShop = true,
        DisplayName = "Moonbloom Trail",
        Rarity = Rarity.Rarities.Divine,
        SpeedNumberColor = Color3.fromRGB(29, 255, 210),
    }),
    DivineTrail = table.freeze({
        _id = "DivineTrail",
        Price = 300000000000000,
        ProductId = 3611606791,
        Icon = "rbxassetid://140597836052094",
        SpeedMultiplier = 14,
        DisplayInShop = true,
        DisplayName = "Divine Trail",
        Rarity = Rarity.Rarities.Divine,
    }),
    EternalTrail = table.freeze({
        _id = "EternalTrail",
        Price = 12500000000000,
        ProductId = 3611606787,
        Icon = "rbxassetid://127740746006344",
        SpeedMultiplier = 10,
        DisplayInShop = true,
        DisplayName = "Eternal Trail",
        Rarity = Rarity.Rarities.Eternal,
    }),
    GalaxyTrail = table.freeze({
        _id = "GalaxyTrail",
        Price = 20000000000,
        ProductId = 3611606773,
        Icon = "rbxassetid://86672420342894",
        SpeedMultiplier = 5,
        DisplayInShop = true,
        DisplayName = "Galaxy Trail",
        Rarity = Rarity.Rarities.Cosmic,
    }),
    GoldenTrail = table.freeze({
        _id = "GoldenTrail",
        Price = 30000000,
        ProductId = 3611606764,
        Icon = "rbxassetid://78957355975053",
        SpeedMultiplier = 3.5,
        DisplayInShop = true,
        DisplayName = "Golden Trail",
        Rarity = Rarity.Rarities.Legendary,
    }),
    GreenTrail = table.freeze({
        _id = "GreenTrail",
        Price = 5000,
        ProductId = 3611606739,
        Icon = "rbxassetid://123930672117029",
        SpeedMultiplier = 2,
        DisplayInShop = true,
        DisplayName = "Green Trail",
        Rarity = Rarity.Rarities.Uncommon,
    }),
    GreyTrail = table.freeze({
        _id = "GreyTrail",
        Price = 100,
        Icon = "rbxassetid://103930213073663",
        SpeedMultiplier = 1.5,
        DisplayInShop = true,
        DisplayName = "Grey Trail",
        Rarity = Rarity.Rarities.Common,
    }),
    PurpleTrail = table.freeze({
        _id = "PurpleTrail",
        Price = 1500000,
        ProductId = 3611606754,
        Icon = "rbxassetid://109475464579632",
        SpeedMultiplier = 3,
        DisplayInShop = true,
        DisplayName = "Purple Trail",
        Rarity = Rarity.Rarities.Epic,
    }),
    RedTrail = table.freeze({
        _id = "RedTrail",
        Price = 750000000,
        ProductId = 3611606768,
        Icon = "rbxassetid://72219596211828",
        SpeedMultiplier = 4,
        DisplayInShop = true,
        DisplayName = "Red Trail",
        Rarity = Rarity.Rarities.Mythic,
    }),
    SecretTrail = table.freeze({
        _id = "SecretTrail",
        Price = 500000000000,
        ProductId = 3611606784,
        Icon = "rbxassetid://124057247070872",
        SpeedMultiplier = 7,
        DisplayInShop = true,
        DisplayName = "Secret Trail",
        Rarity = Rarity.Rarities.Secret,
    }),
}
local u87 = require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.Trails", v1, {Price = true, SpeedMultiplier = true}, true, function(a1) -- Line: 138
    local v1 = nil
    local v2 = nil
    for i, j in a1, v1, v2 do
        assert(0 < j.SpeedMultiplier)
    end
end)
table.freeze(u87)
return (table.freeze({
    Directory = u87,
    TrailNameExists = function(a1) -- Line: 151 -- upvalues: u87 (ref) -- types: a1: string
        if u87[a1] ~= nil then
            return true
        end
        return false, (("Trails name \"%*\" does not exist in the Trails directory."):format(a1))
    end,
}))