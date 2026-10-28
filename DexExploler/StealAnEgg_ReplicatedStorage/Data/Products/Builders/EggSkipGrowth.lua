-- Script path: ReplicatedStorage.Data.Products.Builders.EggSkipGrowth
-- Decompile time: 2.63 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Timecode = require(ReplicatedStorage.Shared.Utils.Time).Timecode
local t = require(ReplicatedStorage.Packages.t)
return function(a1, a2, a3) -- Line: 16
    -- upvalues: t (val), ReplicatedStorage (val), ServerScriptService (val), Timecode (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    t.strict(t.intersection(t.integer, t.numberPositive))(a3)
    local u43 = (require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Bind("Game.Balance.ProductRewards." .. a1, {MaxRemainingSeconds = a3}, true, false, function(a1) -- Line: 32
        local v1 = false
        if 0 < a1.MaxRemainingSeconds then
            v1 = a1.MaxRemainingSeconds % 1 == 0
        end
        assert(v1)
    end)
    local u50 = {
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        ProductId = a2,
        DisplayName = a1,
    }
    u50.Desc = ("Skip the growth of your egg by %*!"):format((Timecode(u43.MaxRemainingSeconds)))
    u50.EggSkipGrowthMaxRemainingSeconds = u43.MaxRemainingSeconds

    function u50.Precheck() -- Line: 65 -- upvalues: ReplicatedStorage (upval)
        return require(ReplicatedStorage.Client.EggState).MayBuyChosenSkip()
    end

    function u50.Authorize(a1_2, a2) -- Line: 37
        -- upvalues: t (upval), ServerScriptService (upval), a1 (val)
        t.strict(t.instanceIsA("Player"))(a1_2)
        local Eggs = require(ServerScriptService.Controllers.Eggs)
        if a2 ~= nil then
            return Eggs.CanRedeemSkipGrowth(a1_2, a1)
        end
        return Eggs.CanPurchaseSkipGrowth(a1_2, a1)
    end

    function u50.ReservePrompt(a1_2) -- Line: 49
        -- upvalues: t (upval), ServerScriptService (upval), a1 (val)
        t.strict(t.instanceIsA("Player"))(a1_2)
        return require(ServerScriptService.Controllers.Eggs).ReserveSkipGrowthPrompt(a1_2, a1)
    end

    function u50.CancelPrompt(a1_2) -- Line: 57
        -- upvalues: t (upval), ServerScriptService (upval), a1 (val)
        t.strict(t.instanceIsA("Player"))(a1_2)
        require(ServerScriptService.Controllers.Eggs).CancelSkipGrowthPrompt(a1_2, a1)
    end

    function u50.Grant(a1_2) -- Line: 81
        -- upvalues: t (upval), ServerScriptService (upval), a1 (val)
        t.strict(t.instanceIsA("Player"))(a1_2)
        return require(ServerScriptService.Controllers.Eggs).PurchaseSkipGrowth(a1_2, a1)
    end

    function u50.ResolveFailedReceipt(a1, a2, a3) -- Line: 71
        -- upvalues: ServerScriptService (upval)
        if require(ServerScriptService.Library.Database).IsPlayerLoaded(a1) then
            return "Credit"
        end
        return "Retry"
    end

    ;(require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Changed:Connect(function() -- Line: 104 -- upvalues: u50 (val), u43 (val), Timecode (upval)
        u50.EggSkipGrowthMaxRemainingSeconds = u43.MaxRemainingSeconds
        u50.Desc = ("Skip the growth of your egg by %*!"):format((Timecode(u43.MaxRemainingSeconds)))
    end)
    return u50
end