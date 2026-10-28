-- Script path: ReplicatedStorage.Data.Products.Builders.ServerLuck
-- Decompile time: 1.33 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage.Packages.t)
return function(a1, a2, a3) -- Line: 12
    -- upvalues: t (val), ServerScriptService (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    local u43 = (require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.ProductRewards." .. a1 .. "", {Multiplier = a3}, true, false, function(a1) -- Line: 26
        assert(1 < a1.Multiplier)
    end)
    return {
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        ProductId = a2,
        DisplayName = a1,
        Authorize = function(a1) -- Line: 31 -- upvalues: ServerScriptService (upval), u43 (val) -- types: a1: userdata
            if u43.Multiplier <= ((require(ServerScriptService.Controllers.ServerLuck)).GetState()).Multiplier then
                return false, "Server already has equal or better luck"
            end
            return true
        end,
        Grant = function(a1) -- Line: 53 -- upvalues: ServerScriptService (upval), u43 (val) -- types: a1: userdata
            require(ServerScriptService.Controllers.ServerLuck).HandlePurchase(u43.Multiplier, a1)
            return true
        end,
        ResolveFailedReceipt = function(a1, a2, a3) -- Line: 43 -- upvalues: ServerScriptService (upval) -- types: a1: userdata, a3: string?
            if require(ServerScriptService.Library.Database).IsPlayerLoaded(a1) then
                return "Credit"
            end
            return "Retry"
        end,
    }
end