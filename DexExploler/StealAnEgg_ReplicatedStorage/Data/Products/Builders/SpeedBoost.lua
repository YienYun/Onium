-- Script path: ReplicatedStorage.Data.Products.Builders.SpeedBoost
-- Decompile time: 2.93 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)

local function validateTier(a1, a2) -- Line: 28 -- upvalues: TreadmillUtil (val) -- types: a2: number
    if a1 == nil then
        return false, "Data not loaded"
    end
    local v1 = TreadmillUtil.ResolveSpeedBoostTierIndex(a1)
    if TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX <= v1 then
        return false, "Max speed boost owned"
    end
    if a2 ~= v1 + 1 then
        return false, "Purchase the previous speed boost first"
    end
    return true
end

return function(a1, a2, a3, a4) -- Line: 45
    -- upvalues: t (val), Constants (val), TreadmillUtil (val), ServerScriptService (val), validateTier (val)
    -- upvalues: ReplicatedStorage (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    t.strict(t.number)(a4)
    if Constants.IS_STUDIO then
        local v1 = false
        if a3 >= 1 then
            v1 = a3 <= TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX
        end
        assert(v1, (("Invalid speed boost tier index %*"):format(a3)))
        local v2 = ("Invalid speed boost multiplier %* for tier %*"):format(a4, a3)
        assert(TreadmillUtil.GetSpeedBoostMultiplierForTierIndex(a3) == a4, v2)
    end
    local v3 = TreadmillUtil.FormatSpeedMultiplierValue(a4)
    return {
        OneTime = true,
        HoldWhilePending = true,
        Name = a1,
        ProductId = a2,
        DisplayName = ("%* Speed Boost"):format(v3),
        Desc = ("Upgrade your permanent speed boost to %*."):format(v3),
        SpeedBoostTierIndex = a3,
        SpeedBoostMultiplier = a4,
        Precheck = function() -- Line: 100 -- upvalues: ReplicatedStorage (upval), validateTier (upval), a3 (val)
            return validateTier((require(ReplicatedStorage.Shared.Save)).Await(), a3)
        end,
        Authorize = function(a1) -- Line: 69
            -- upvalues: t (upval), ServerScriptService (upval), validateTier (upval), a3 (val)
            t.strict(t.instanceIsA("Player"))(a1)
            local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                return validateTier(v2, a3)
            end
            return false, "Player profile not found"
        end,
        Grant = function(a1) -- Line: 105
            -- upvalues: t (upval), ServerScriptService (upval), a3 (val), TreadmillUtil (upval)
            t.strict(t.instanceIsA("Player"))(a1)
            local v1, v2 = (require(ServerScriptService.Library.Database)).UpdateProfileImmutable(a1, function(a1) -- Line: 109 -- upvalues: a3 (upval), TreadmillUtil (upval)
                local v1
                local v2 = a3
                if a1 ~= nil then
                    local v3 = TreadmillUtil.ResolveSpeedBoostTierIndex(a1)
                    v1 = if not (TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX <= v3) then v2 == v3 + 1 else false
                else
                    v1 = false
                end
                if not v1 then
                    return false
                end
                v1 = table.clone(a1)
                v1.SpeedBoostTierIndex = a3
                return v1
            end):await()
            if v1 and v2 then
                return true
            end
            return false, "Purchase the previous speed boost first"
        end,
        ResolveFailedReceipt = function(a1, a2, a3_2) -- Line: 81
            -- upvalues: ServerScriptService (upval), TreadmillUtil (upval), a3 (val)
            local Database = require(ServerScriptService.Library.Database)
            if not Database.IsPlayerLoaded(a1) then
                return "Retry"
            end
            local v1, v2 = Database.UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                if a3 <= (TreadmillUtil.ResolveSpeedBoostTierIndex(v2)) then
                    return "Satisfied"
                end
                return "Credit"
            end
            return "Retry"
        end,
    }
end