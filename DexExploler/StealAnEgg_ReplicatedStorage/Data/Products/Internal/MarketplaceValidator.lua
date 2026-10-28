-- Script path: ReplicatedStorage.Data.Products.Internal.MarketplaceValidator
-- Decompile time: 3.28 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local Marketplace = require(ReplicatedStorage.Shared.Utils.Marketplace)
require(script.Parent.ProductTypes)
local u24 = if game.CreatorType ~= Enum.CreatorType.Group then "User" else "Group"
local CreatorId = game.CreatorId
local u29 = Log.new()
local v1 = {}

local function creatorId(a1) -- Line: 19 -- types: a1: table?
    if not a1 then
        return nil
    end
    local CreatorTargetId = a1.CreatorTargetId or a1.Id
    if CreatorTargetId and CreatorTargetId > 0 then
        return CreatorTargetId
    end
    return nil
end

function v1.Validate(a1, a2) -- Line: 27
    -- upvalues: Marketplace (val), u29 (val), u24 (val), CreatorId (val)
    local v1 = Marketplace.Current(a2.ProductId, Enum.InfoType.Product)
    if v1 == nil then
        (u29:AtWarning()):Log(("Failed to validate marketplace product info for %*"):format(a1), {ProductId = a2.ProductId})
        return
    end
    local v2 = v1.PriceInRobux or 0
    if v2 <= 0 then
        (u29:AtWarning()):Log(("Product %* has an invalid Robux price"):format(a1), {ProductId = a2.ProductId, PriceInRobux = v2})
    elseif v2 > 10000 then
        (u29:AtWarning()):Log(
            ("Product %* is priced above the Studio validation threshold"):format(a1),
            {MaxAllowedPrice = 10000, ProductId = a2.ProductId, PriceInRobux = v2}
        )
    end
    local Creator = v1.Creator
    if Creator then
        local CreatorTargetId = Creator.CreatorTargetId or Creator.Id
        v1 = if not CreatorTargetId then nil else if not (CreatorTargetId > 0) then nil else CreatorTargetId
    else
        v1 = nil
    end
    if Creator and Creator.CreatorType and v1 then
        if Creator.CreatorType ~= u24 or v1 ~= CreatorId then
            (u29:AtWarning()):Log(("Product %* is owned by the wrong creator"):format(a1), {ProductId = a2.ProductId})
        end
    end
end

return v1