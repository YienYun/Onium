-- Script path: ReplicatedStorage.Data.Products.Builders.RiftRefresh
-- Decompile time: 3.70 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Marketplace = require(ReplicatedStorage.Shared.Utils.Marketplace)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local ScrambleTradeInFlags = require(ReplicatedStorage.Shared.Flags.ScrambleTradeInFlags)
local RiftMachineSchedule = require(ReplicatedStorage.Shared.Util.RiftMachineSchedule)
local t = require(ReplicatedStorage.Packages.t)

local function resolveRobuxCost(a1, a2) -- Line: 16 -- upvalues: Marketplace (val) -- types: a1: number
    local CurrencySpent = if a2 == nil then nil else a2.CurrencySpent
    if type(CurrencySpent) == "number" and CurrencySpent > 0 then
        return CurrencySpent
    end
    local success, err, v1 = pcall(Marketplace.Price, a1, true)
    if success and v1 and type(err) == "number" and err > 0 then
        return err
    end
    return nil
end

return function(a1, a2) -- Line: 28
    -- upvalues: t (val), RiftMachineSchedule (val), ServerScriptService (val), ScrambleTradeInFlags (val)
    -- upvalues: RiftFlags (val), Marketplace (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    return {
        DisplayName = "Laboratory Refresh",
        Desc = "Instantly reroll the 3 eggs Dr. Scramble is asking for!",
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        ProductId = a2,
        Precheck = function() -- Line: 42
            -- upvalues: a2 (val), RiftMachineSchedule (upval), ScrambleTradeInFlags (upval), RiftFlags (upval)
            if a2 <= 0 then
                return false, "Rift refresh is not available yet"
            end
            if RiftMachineSchedule.IsLaboratoryTime() and not ScrambleTradeInFlags.Enabled:Get() then
                return false, "The trade-in machine is closed"
            end
            if not RiftMachineSchedule.IsLaboratoryTime() and RiftFlags.Retired:Get() then
                return false, "The trade-in machine is closed"
            end
            return true
        end,
        Authorize = function(a1, a2_2) -- Line: 32
            -- upvalues: t (upval), a2 (val), RiftMachineSchedule (upval), ServerScriptService (upval)
            t.strict(t.instanceIsA("Player"))(a1)
            if a2 <= 0 then
                return false, "Rift refresh is not available yet"
            end
            return (if not RiftMachineSchedule.IsLaboratoryTime() then require(ServerScriptService.Controllers.RiftService) else require(ServerScriptService.Controllers.ScrambleTradeInService)).CanPurchasePaidRefresh(
                a1,
                a2_2 ~= nil
            )
        end,
        Grant = function(a1, a2_2) -- Line: 61
            -- upvalues: t (upval), RiftMachineSchedule (upval), ServerScriptService (upval), a2 (val)
            -- upvalues: Marketplace (upval)
            local v1
            t.strict(t.instanceIsA("Player"))(a1)
            local ScrambleTradeInService = if not RiftMachineSchedule.IsLaboratoryTime() then require(ServerScriptService.Controllers.RiftService) else require(ServerScriptService.Controllers.ScrambleTradeInService)
            local RedeemPaidRefresh = ScrambleTradeInService.RedeemPaidRefresh
            local CurrencySpent = if a2_2 == nil then nil else a2_2.CurrencySpent
            if type(CurrencySpent) ~= "number" or not (CurrencySpent > 0) then
                local success, err, v2 = pcall(Marketplace.Price, a2, true)
                v1 = if not success then nil else if not v2 then nil else if type(err) ~= "number" then nil else if not (err > 0) then nil else err
            else
                v1 = CurrencySpent
            end
            return RedeemPaidRefresh(a1, v1)
        end,
        ResolveFailedReceipt = function(a1, a2, a3) -- Line: 52 -- upvalues: ServerScriptService (upval) -- types: a1: userdata, a3: string?
            if require(ServerScriptService.Library.Database).IsPlayerLoaded(a1) then
                return "Credit"
            end
            return "Retry"
        end,
    }
end