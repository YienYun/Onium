-- Script path: ReplicatedStorage.Data.Products.Builders.Treadmill
-- Decompile time: 2.24 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local t = require(ReplicatedStorage.Packages.t)
return function(a1, a2, a3) -- Line: 14
    -- upvalues: t (val), Treadmills (val), ServerScriptService (val), ReplicatedStorage (val)
    t.strict(t.string)(a1)
    t.strict(t.string)(a2)
    t.strict(t.number)(a3)
    local v1, v2 = Treadmills.TreadmillNameExists(a2)
    assert(v1, v2 or ("Treadmill \"%*\" does not exist"):format(a2))
    v2 = Treadmills.Directory[a2]
    local u48 = Treadmills.GetUpgradeLevel(a2)
    local v3 = ("Treadmill \"%*\" has no upgrade level"):format(a2)
    assert(u48 ~= nil, v3)

    local function canBuyNextUpgrade(a1) -- Line: 26 -- upvalues: u48 (val) -- types: a1: number
        if a1 + 1 ~= u48 then
            return false, "This is not your next treadmill upgrade"
        end
        return true
    end

    return {
        OneTime = true,
        HoldWhilePending = true,
        Name = a1,
        ProductId = a3,
        DisplayName = v2.DisplayName,
        Desc = ("Upgrade to the %* treadmill."):format(v2.DisplayName),
        Icon = v2.Icon,
        Precheck = function() -- Line: 64 -- upvalues: ReplicatedStorage (upval), canBuyNextUpgrade (val)
            local v1 = require(ReplicatedStorage.Shared.Save).Await()
            if not v1 then
                return false, "Data not loaded"
            end
            return canBuyNextUpgrade(v1.TreadmillUpgradeLevel)
        end,
        Authorize = function(a1) -- Line: 33
            -- upvalues: t (upval), ServerScriptService (upval), canBuyNextUpgrade (val)
            t.strict(t.instanceIsA("Player"))(a1)
            local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                return canBuyNextUpgrade(v2.TreadmillUpgradeLevel)
            end
            return false, "Player profile not found"
        end,
        Grant = function(a1) -- Line: 74 -- upvalues: t (upval), ServerScriptService (upval), a2 (val) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            return require(ServerScriptService.Controllers.TreadmillService).UpgradeTreadmill(a1, a2, false)
        end,
        ResolveFailedReceipt = function(a1, a2, a3) -- Line: 45 -- upvalues: ServerScriptService (upval), u48 (val) -- types: a1: userdata, a3: string?
            local Database = require(ServerScriptService.Library.Database)
            if not Database.IsPlayerLoaded(a1) then
                return "Retry"
            end
            local v1, v2 = Database.UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                if u48 <= v2.TreadmillUpgradeLevel then
                    return "Satisfied"
                end
                return "Credit"
            end
            return "Retry"
        end,
    }
end