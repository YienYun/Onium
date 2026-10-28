-- Script path: ReplicatedStorage.UserGenerated.Roblox.MarketplaceServiceHelper
-- Decompile time: 1.56 ms

local MarketplaceService = game:GetService("MarketplaceService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Asserts.TablePermissive({
    PurchaseId = Asserts.String,
    PlayerId = Asserts.Integer,
    ProductId = Asserts.Integer,
    PlaceIdWherePurchased = Asserts.Integer,
    CurrencySpent = Asserts.IntegerNonNegative,
    CurrencyType = Asserts.AnyOf(Asserts.Enum(Enum.CurrencyType), Asserts.String),
    ProductPurchaseChannel = Asserts.Enum(Enum.ProductPurchaseChannel),
})
local u42 = Asserts.Table({AssetId = Asserts.Integer, InfoType = Asserts.Enum(Enum.InfoType)})
local u47 = Cache.new({
    Callback = function(a1) -- Line: 158 -- upvalues: MarketplaceService (val) -- types: a1: table
        return MarketplaceService:GetProductInfo(a1.AssetId, a1.InfoType)
    end,
    AssertKey = function(a1) -- Line: 161 -- upvalues: u42 (val)
        u42(a1)
        return (("%*,%*"):format(a1.AssetId, a1.InfoType.Value))
    end,
})
return table.freeze({
    AssertReceiptInfo = v1,
    GetInfoAsync = function(a1, a2, a3) -- Line: 171 -- upvalues: Asserts (val), u47 (val) -- types: a1: number, a3: boolean?
        Asserts.Integer(a1)
        Asserts.Enum(Enum.InfoType)(a2)
        Asserts.Optional(Asserts.Boolean)(a3)
        local v1 = {AssetId = a1, InfoType = a2}
        if a3 then
            return u47:Get(v1)
        end
        return u47:GetAsync(v1)
    end,
})