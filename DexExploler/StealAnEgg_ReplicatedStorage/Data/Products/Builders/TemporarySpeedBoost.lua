-- Script path: ReplicatedStorage.Data.Products.Builders.TemporarySpeedBoost
-- Decompile time: 2.81 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)

local function canPurchaseTemporarySpeedBoost(a1) -- Line: 27
    if a1 == nil then
        return false, "Data not loaded"
    end
    return true
end

return function(a1, a2, a3) -- Line: 35
    -- upvalues: t (val), ReplicatedStorage (val), TreadmillUtil (val), ServerScriptService (val)
    -- upvalues: canPurchaseTemporarySpeedBoost (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    assert(a3 > 0, "Temporary speed boost duration must be positive")
    local u47 = (require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Bind("Game.Balance.ProductRewards." .. a1, {DurationSeconds = a3}, true, false, function(a1) -- Line: 50
        assert(0 < a1.DurationSeconds)
    end)

    local function durationLabel() -- Line: 55 -- upvalues: TreadmillUtil (upval), u47 (val)
        return TreadmillUtil.FormatTemporarySpeedBoostProductDuration(u47.DurationSeconds)
    end

    local u52 = {HoldWhilePending = true, Name = a1, ProductId = a2}
    u52.DisplayName = ("x2 Speed Boost (%*)"):format((TreadmillUtil.FormatTemporarySpeedBoostProductDuration(u47.DurationSeconds)))
    u52.Desc = ("Double all speed gains for %*."):format((TreadmillUtil.FormatTemporarySpeedBoostProductDuration(u47.DurationSeconds)))
    u52.TemporarySpeedBoostDurationSeconds = u47.DurationSeconds
    u52.TemporarySpeedBoostMultiplier = TreadmillUtil.GetTemporarySpeedBoostMultiplier()

    function u52.Precheck() -- Line: 73 -- upvalues: ReplicatedStorage (upval), canPurchaseTemporarySpeedBoost (upval)
        return canPurchaseTemporarySpeedBoost((require(ReplicatedStorage.Shared.Save)).Await())
    end

    function u52.Authorize(a1) -- Line: 59
        -- upvalues: t (upval), ServerScriptService (upval), canPurchaseTemporarySpeedBoost (upval)
        t.strict(t.instanceIsA("Player"))(a1)
        local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
        if v1 and v2 then
            return canPurchaseTemporarySpeedBoost(v2)
        end
        return false, "Player profile not found"
    end

    function u52.Grant(a1) -- Line: 79
        -- upvalues: t (upval), ServerScriptService (upval), u47 (val)
        t.strict(t.instanceIsA("Player"))(a1)
        return require(ServerScriptService.Controllers.SpeedPowerService).AddTemporarySpeedBoostDuration(a1, u47.DurationSeconds)
    end

    ;(require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Changed:Connect(function() -- Line: 99 -- upvalues: u52 (val), u47 (val), TreadmillUtil (upval)
        u52.TemporarySpeedBoostDurationSeconds = u47.DurationSeconds
        u52.TemporarySpeedBoostMultiplier = TreadmillUtil.GetTemporarySpeedBoostMultiplier()
        u52.DisplayName = ("x2 Speed Boost (%*)"):format((TreadmillUtil.FormatTemporarySpeedBoostProductDuration(u47.DurationSeconds)))
        u52.Desc = ("Double all speed gains for %*."):format((TreadmillUtil.FormatTemporarySpeedBoostProductDuration(u47.DurationSeconds)))
    end)
    return u52
end