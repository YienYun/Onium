-- Script path: ReplicatedStorage.Data.Products.Builders.ServerLuckExtension
-- Decompile time: 1.48 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage.Packages.t)
return function(a1, a2, a3) -- Line: 12
    -- upvalues: t (val), ServerScriptService (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    local u43 = (require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.ProductRewards." .. a1 .. "", {Minutes = a3}, true, false, function(a1) -- Line: 26
        assert(0 < a1.Minutes)
    end)
    return {
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        ProductId = a2,
        DisplayName = a1,
        Authorize = function(a1) -- Line: 31 -- upvalues: ServerScriptService (upval) -- types: a1: userdata
            return 1 < require(ServerScriptService.Controllers.ServerLuck).GetState().Multiplier
        end,
        Grant = function(a1) -- Line: 49 -- upvalues: ServerScriptService (upval), u43 (val) -- types: a1: userdata
            return (require(ServerScriptService.Controllers.ServerLuck)).AddTime(u43.Minutes * 60, a1)
        end,
        ResolveFailedReceipt = function(a1, a2, a3) -- Line: 39 -- upvalues: ServerScriptService (upval) -- types: a1: userdata, a3: string?
            if require(ServerScriptService.Library.Database).IsPlayerLoaded(a1) then
                return "Credit"
            end
            return "Retry"
        end,
    }
end