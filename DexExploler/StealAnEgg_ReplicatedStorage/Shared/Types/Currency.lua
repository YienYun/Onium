-- Script path: ReplicatedStorage.Shared.Types.Currency
-- Decompile time: 0.61 ms

local v1 = {"BossTokens", "HalloweenTokens", "Money", "SakuraCrystals"}
return table.freeze({
    AllCurrencyTypes = table.freeze({
        BossTokens = "BossTokens",
        HalloweenTokens = "HalloweenTokens",
        Money = "Money",
        SakuraCrystals = "SakuraCrystals",
    }),
    AllCurrencyTypesArray = table.freeze(v1),
    SchemaValidation = table.freeze({
        AllCurrencyTypes = (require((game:GetService("ReplicatedStorage")).Packages.t)).valueOf(v1),
    }),
})