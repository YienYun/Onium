-- Script path: ReplicatedStorage.Data.Products.Builders.Trail
-- Decompile time: 2.14 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local Trails = require(ReplicatedStorage.Data.Trails)
local t = require(ReplicatedStorage.Packages.t)
return function(a1, a2, a3) -- Line: 15
    -- upvalues: t (val), Trails (val), ServerScriptService (val), ReplicatedStorage (val)
    t.strict(t.string)(a1)
    t.strict(t.string)(a2)
    t.strict(t.number)(a3)
    local v1, v2 = Trails.TrailNameExists(a2)
    assert(v1, v2 or ("Trail \"%*\" does not exist"):format(a2))
    v2 = Trails.Directory[a2]

    local function validateData(a1) -- Line: 25 -- upvalues: a2 (val)
        if not a1 then
            return false, "Player data not found"
        end
        if a1.TrailInventory[a2] then
            return false, "You already own this trail"
        end
        return true
    end

    return {
        OneTime = true,
        HoldWhilePending = true,
        Name = a1,
        ProductId = a3,
        DisplayName = v2.DisplayName,
        Desc = ("Unlock the %* trail."):format(v2.DisplayName),
        Icon = v2.Icon,
        Precheck = function() -- Line: 67 -- upvalues: ReplicatedStorage (upval), validateData (val)
            local v1 = require(ReplicatedStorage.Shared.Save).Await()
            if not v1 then
                return false, "Data not loaded"
            end
            return validateData(v1)
        end,
        Authorize = function(a1) -- Line: 36 -- upvalues: t (upval), ServerScriptService (upval), validateData (val) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                return validateData(v2)
            end
            return false, "Player profile not found"
        end,
        Grant = function(a1) -- Line: 77 -- upvalues: t (upval), ServerScriptService (upval), a2 (val) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            return require(ServerScriptService.Controllers.TrailShop).GrantOwnedTrail(a1, a2, true)
        end,
        ResolveFailedReceipt = function(a1, a2_2, a3) -- Line: 48
            -- upvalues: ServerScriptService (upval), a2 (val)
            local Database = require(ServerScriptService.Library.Database)
            if not Database.IsPlayerLoaded(a1) then
                return "Retry"
            end
            local v1, v2 = Database.UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                if v2.TrailInventory[a2] then
                    return "Satisfied"
                end
                return "Retry"
            end
            return "Retry"
        end,
    }
end