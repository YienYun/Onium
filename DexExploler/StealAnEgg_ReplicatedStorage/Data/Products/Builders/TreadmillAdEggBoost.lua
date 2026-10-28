-- Script path: ReplicatedStorage.Data.Products.Builders.TreadmillAdEggBoost
-- Decompile time: 0.84 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage.Packages.t)
return function(a1, a2) -- Line: 12 -- upvalues: t (val), ServerScriptService (val) -- types: a1: string, a2: number
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    return {
        Desc = "Treadmill Egg Ad Boost — 5 min x2 egg growth from rewarded video.",
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        ProductId = a2,
        DisplayName = a1,
        Authorize = function(a1) -- Line: 16 -- upvalues: ServerScriptService (upval) -- types: a1: userdata
            local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                return true
            end
            return false, "Player data is not loaded yet."
        end,
        Grant = function(a1) -- Line: 25 -- upvalues: ServerScriptService (upval) -- types: a1: userdata
            require(ServerScriptService.Controllers.AdEggBoostServer.AdEggBoostReward).Grant(a1)
            return true
        end,
    }
end