-- Script path: ReplicatedStorage.Data.Products.Builders.SamplePack
-- Decompile time: 1.40 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(script.Parent.Parent.Internal.ProductTypes)
local SamplePacks = require(ReplicatedStorage.Data.SamplePacks)
return function(a1, a2) -- Line: 10
    -- upvalues: ServerScriptService (val), SamplePacks (val), Simple (val)
    local u2 = {
        SamplePackProduct = true,
        HoldWhilePending = true,
        Giftable = true,
        Name = a1,
        ProductId = a2,
    }

    function u2.Authorize(a1, a2_2) -- Line: 20
        -- upvalues: ServerScriptService (upval), a2 (val)
        return (require(ServerScriptService.Controllers.ScrambleService.Commerce)).getCanPurchase(a1, {productId = a2, receipt = a2_2})
    end

    function u2.Precheck() -- Line: 32
        return false, "Samples are no longer available for purchase."
    end

    function u2.Grant(a1, a2) -- Line: 35 -- upvalues: ServerScriptService (upval) -- types: a1: userdata
        if a2 == nil then
            return false
        end
        return require(ServerScriptService.Controllers.ScrambleService.Commerce).GrantGift(a1, a2)
    end

    local v1 = SamplePacks.Find(a2)
    if v1 ~= nil then
        local v2 = (Simple.Format(v1.Amount, "precision-integer")) .. " Samples"
        u2.DisplayName = v2
        u2.Desc = "Purchase " .. v2 .. "."
    end
    SamplePacks.getChangedSignal():Connect(function() -- Line: 50 -- upvalues: SamplePacks (upval), a2 (val), Simple (upval), u2 (val)
        local v1 = SamplePacks.Find(a2)
        if v1 == nil then
            return
        end
        local v2 = (Simple.Format(v1.Amount, "precision-integer")) .. " Samples"
        u2.DisplayName = v2
        u2.Desc = "Purchase " .. v2 .. "."
    end)
    return u2
end