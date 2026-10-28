-- Script path: ReplicatedStorage.Data.Products.Builders.TreadmillSpeedEquivalent
-- Decompile time: 2.59 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)

local function canPurchase(a1) -- Line: 23
    if a1 == nil then
        return false, "Player data is not loaded yet."
    end
    return true, nil
end

return function(a1, a2, a3) -- Line: 31
    -- upvalues: t (val), ReplicatedStorage (val), TreadmillUtil (val), ServerScriptService (val), canPurchase (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    assert(a2 > 0, "Treadmill equivalent product id must be positive")
    assert(a3 > 0, "Treadmill equivalent duration must be positive")
    local u58 = require(ReplicatedStorage.Shared.Flags.BalanceConfig).Bind("Game.Balance.TreadmillProductRewards." .. tostring(a2), {DurationSeconds = a3}, true, false, function(a1) -- Line: 47
        assert(0 < a1.DurationSeconds)
    end)

    local function durationLabel() -- Line: 52 -- upvalues: TreadmillUtil (upval), u58 (val)
        return TreadmillUtil.FormatTreadmillSpeedEquivalentDuration(u58.DurationSeconds)
    end

    local u63 = {
        Desc = "Instantly gain the speed you currently earn on your treadmill.",
        HoldWhilePending = true,
        Name = a1,
        ProductId = a2,
    }
    u63.DisplayName = ("Speed - %*"):format((TreadmillUtil.FormatTreadmillSpeedEquivalentDuration(u58.DurationSeconds)))
    u63.TreadmillSpeedEquivalentDurationSeconds = u58.DurationSeconds

    function u63.Precheck() -- Line: 69 -- upvalues: ReplicatedStorage (upval), canPurchase (upval)
        return canPurchase((require(ReplicatedStorage.Shared.Save)).Await())
    end

    function u63.Authorize(a1) -- Line: 56
        -- upvalues: t (upval), ServerScriptService (upval), canPurchase (upval)
        t.strict(t.instanceIsA("Player"))(a1)
        local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
        if not v1 then
            return false, "Player data is not loaded yet."
        end
        return canPurchase(v2)
    end

    function u63.Grant(a1) -- Line: 75
        -- upvalues: t (upval), ServerScriptService (upval), u58 (val)
        t.strict(t.instanceIsA("Player"))(a1)
        local v1, v2 = require(ServerScriptService.Controllers.SpeedPowerService).AddTreadmillEquivalentSpeedPower(a1, u58.DurationSeconds)
        if not v1 then
            return false, 0
        end
        require(ServerScriptService.Library.Functions.NotifyItem)(a1, {Kind = "SpeedPower", Amount = v2})
        return true, v2
    end

    ;(require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Changed:Connect(function() -- Line: 103 -- upvalues: u63 (val), u58 (val), TreadmillUtil (upval)
        u63.TreadmillSpeedEquivalentDurationSeconds = u58.DurationSeconds
        u63.DisplayName = ("Speed - %*"):format((TreadmillUtil.FormatTreadmillSpeedEquivalentDuration(u58.DurationSeconds)))
    end)
    return u63
end