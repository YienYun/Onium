-- Script path: ReplicatedStorage.Data.Products.Builders.BillboardReward
-- Decompile time: 2.45 ms

local AdRewards = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).AdRewards
require(script.Parent.Parent.Internal.ProductTypes)
local CollectionService = game:GetService("CollectionService")
game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage.Packages.t)
return function(a1, a2) -- Line: 19
    -- upvalues: t (val), ServerScriptService (val), CollectionService (val), AdRewards (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    return {
        Desc = "Rewarded video billboard cash reward.",
        Giftable = false,
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        ProductId = a2,
        DisplayName = a1,
        Authorize = function(a1) -- Line: 23 -- upvalues: ServerScriptService (upval) -- types: a1: userdata
            local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
            if v1 and v2 then
                return true
            end
            return false, "Player data is not loaded yet."
        end,
        Grant = function(a1) -- Line: 35
            -- upvalues: CollectionService (upval), a2 (val), AdRewards (upval), ServerScriptService (upval)
            local leaderstats = a1:FindFirstChild("leaderstats")
            local v1 = leaderstats and leaderstats:FindFirstChild("Money/s")
            if v1 and v1:IsA("NumberValue") then
                local RewardSelector, ServerCode, err, success
                local v2 = 0
                local v3 = CollectionService:GetTagged("RVBillboard")
                local v4 = nil
                local v5 = nil
                local v6 = a1
                for i, j in v3, v4, v5 do
                    ServerCode = j:FindFirstChild("ServerCode")
                    RewardSelector = ServerCode and ServerCode:FindFirstChild("RewardSelector")
                    if RewardSelector then
                        success, err = pcall(require, RewardSelector)
                        if success and err and err.CalculateReward then
                            v2 = err:CalculateReward(v1.Value, a2)
                            break
                        end
                    end
                end
                if v2 <= 0 then
                    v2 = v1.Value * AdRewards.FALLBACK_DURATION
                end
                if v2 <= 0 then
                    warn("[BillboardReward] Calculated reward is 0 for " .. v6.Name)
                    return false, "Reward amount is zero"
                end
                require(ServerScriptService.Controllers.MoneyService).AddMoney(v6, v2, {source = "BillboardReward", feature = "Ads"})
                require(ServerScriptService.Library.Functions.NotifyItem)(v6, {Kind = "Currency", Id = "Money", Amount = math.round(v2)})
                return true
            end
            warn("[BillboardReward] No Money/s leaderstat for " .. a1.Name)
            return false, "Missing leaderstat"
        end,
    }
end