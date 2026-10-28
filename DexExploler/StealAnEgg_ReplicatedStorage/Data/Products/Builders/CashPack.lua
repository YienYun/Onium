-- Script path: ReplicatedStorage.Data.Products.Builders.CashPack
-- Decompile time: 1.33 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
require(script.Parent.Parent.Internal.ProductTypes)
return function(a1, a2) -- Line: 10
    -- upvalues: CashPacks (val), ServerScriptService (val), Players (val)
    local u5 = CashPacks.FindSlot(a2)
    local v1 = ("Unknown cash pack %*"):format(a2)
    assert(u5 ~= nil, v1)
    local v2 = CashPacks.Offers[u5]
    assert(v2.Name == a1, "Cash pack catalog key does not match its product")
    return {
        Desc = "",
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        ProductId = a2,
        DisplayName = v2.DisplayName,
        Precheck = function() -- Line: 31 -- upvalues: CashPacks (upval), Players (upval), u5 (val)
            if CashPacks.GetShownAmount(Players.LocalPlayer, u5) == nil then
                return false, "Your cash packs are still loading. Please try again."
            end
            return true
        end,
        Authorize = function(a1) -- Line: 22 -- upvalues: ServerScriptService (upval), u5 (val) -- types: a1: userdata
            if require(ServerScriptService.Controllers.CashPackService).GetAmount(a1, u5) == nil then
                return false, "Your cash packs are still loading. Please try again."
            end
            return true
        end,
        Grant = function(a1, a2) -- Line: 38 -- upvalues: ServerScriptService (upval), u5 (val) -- types: a1: userdata
            return require(ServerScriptService.Controllers.CashPackService).Grant(a1, u5, a2)
        end,
    }
end