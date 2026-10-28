-- Script path: ReplicatedStorage.Data.Products.Builders.LimitedEgg
-- Decompile time: 7.94 ms

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
require(ReplicatedStorage.Shared.Types.Eggs)
require(ReplicatedStorage.Data.LimitedEgg.Types.Interface)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local Numeric = require(ReplicatedStorage.Shared.Utils.Numeric)
require(script.Parent.Parent.Internal.ProductTypes)
local t = require(ReplicatedStorage.Packages.t)
local u51 = {HoldWhilePending = true, Icon = "", Silent = true}
local u53 = Random.new()

local function withDefaults(a1) -- Line: 25 -- upvalues: u51 (val) -- types: a1: table
    local v1 = table.clone(u51)
    for i, j in a1 do
        v1[i] = j
    end
    return v1
end

local function presentation(a1) -- Line: 33 -- types: a1: number
    local v1 = if a1 ~= 1 then ("%* limited pet eggs."):format(a1) else "A limited pet egg."
    return (("Limited Egg x%*"):format(a1)), v1
end

local function rollGrants(a1, a2, a3) -- Line: 38
    -- upvalues: ReplicatedStorage (val), Numeric (val), u53 (val), t (val), HttpService (val)
    local v1, v2, v3
    local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
    local v4 = table.create(a2)
    for i = 1, a2 do
        v2 = Numeric.RollWeighted(a1.DropTable, u53)
        t.strict(t.string)(v2)
        v3 = EggRecords.NewEgg(v2)
        v3.PurchaseId = a3
        v1 = {Uid = (HttpService:GenerateGUID(false)):gsub("-", ""):lower(), Record = v3}
        v4[i] = v1
    end
    return v4
end

return function(a1, a2, a3, a4) -- Line: 57
    -- upvalues: t (val), LimitedEgg (val), ServerScriptService (val), ReplicatedStorage (val), rollGrants (val)
    -- upvalues: u51 (val), BalanceConfig (val)
    local Amount, u97, v1
    t.strict(t.string)(a1)
    t.strict(t.numberPositive)(a2)
    t.strict(t.intersection(t.integer, t.numberPositive))(a3)
    t.strict(t.table)(a4)

    local function liveCount() -- Line: 68 -- upvalues: a4 (val), a1 (val), a3 (val)
        for i, j in a4.Offers do
            if j.ProductName ~= a1 and j.GiftProductName ~= a1 then
                continue
            end
            return j.Amount
        end
        return a3
    end

    local function authorize(a1, a2) -- Line: 77
        -- upvalues: t (upval), LimitedEgg (upval), a4 (val), ServerScriptService (upval)
        t.strict(t.instanceIsA("Player"))(a1)
        if a2 == nil and not LimitedEgg.IsOnSale(a4) then
            return false, "This egg is no longer on sale."
        end
        if require(ServerScriptService.Library.Database).IsPlayerLoaded(a1) then
            return true
        end
        return false, "Data not loaded"
    end

    local function precheck() -- Line: 87 -- upvalues: LimitedEgg (upval), a4 (val), ReplicatedStorage (upval)
        if not LimitedEgg.IsOnSale(a4) then
            return false, "This egg is no longer on sale."
        end
        if require(ReplicatedStorage.Shared.Save).Await() ~= nil then
            return true
        end
        return false, "Data not loaded"
    end

    local function grant(a1_2, a2) -- Line: 96
        -- upvalues: t (upval), ServerScriptService (upval), rollGrants (upval), a4 (val), a1 (val), a3 (val)
        local Amount
        t.strict(t.instanceIsA("Player"))(a1_2)
        local Eggs = require(ServerScriptService.Controllers.Eggs)
        local v1 = if a2 == nil or a2.PurchaseId == nil then nil else tostring(a2.PurchaseId)
        local GrantPaidEggBatch = Eggs.GrantPaidEggBatch
        local v2 = a1_2
        local v3 = rollGrants
        local v4 = a4
        for i, j in a4.Offers do
            if j.ProductName == a1 then
                Amount = j.Amount
            elseif j.GiftProductName ~= a1 then
                continue
            else
                Amount = j.Amount
            end
            return GrantPaidEggBatch(v2, (v3(v4, Amount, v1)))
        end
        return GrantPaidEggBatch(v2, (v3(v4, a3, v1)))
    end

    local v2 = nil
    for i, j in a4.Offers, v2 do
        if j.ProductName == a1 then
            Amount = j.Amount
        elseif j.GiftProductName ~= a1 then
            continue
        else
            Amount = j.Amount
        end
        v1 = if Amount ~= 1 then ("%* limited pet eggs."):format(Amount) else "A limited pet egg."
        v2 = ("Limited Egg x%*"):format(Amount)
        u97 = table.clone(u51)
        v2 = {
            Name = a1,
            ProductId = a2,
            DisplayName = v2,
            Desc = v1,
            Precheck = precheck,
            Authorize = authorize,
            Grant = grant,
        }
        for k, n in v2 do
            u97[k] = n
        end
        BalanceConfig.Changed:Connect(function() -- Line: 114 -- upvalues: u97 (val), a4 (val), a1 (val), a3 (val)
            local Amount, v1
            local v2 = u97
            local v3 = u97
            for i, j in a4.Offers do
                if j.ProductName == a1 then
                    Amount = j.Amount
                elseif j.GiftProductName ~= a1 then
                    continue
                else
                    Amount = j.Amount
                end
                v1 = if Amount ~= 1 then ("%* limited pet eggs."):format(Amount) else "A limited pet egg."
                v2.DisplayName = ("Limited Egg x%*"):format(Amount)
                v3.Desc = v1
                return
            end
            Amount = a3
            v1 = if Amount ~= 1 then ("%* limited pet eggs."):format(Amount) else "A limited pet egg."
            v2.DisplayName = ("Limited Egg x%*"):format(Amount)
            v3.Desc = v1
        end)
        return u97
    end
    Amount = a3
    v1 = if Amount ~= 1 then ("%* limited pet eggs."):format(Amount) else "A limited pet egg."
    v2 = ("Limited Egg x%*"):format(Amount)
    u97 = table.clone(u51)
    v2 = {
        Name = a1,
        ProductId = a2,
        DisplayName = v2,
        Desc = v1,
        Precheck = precheck,
        Authorize = authorize,
        Grant = grant,
    }
    for m, i5 in v2 do
        u97[m] = i5
    end
    BalanceConfig.Changed:Connect(function() -- Line: 114 -- upvalues: u97 (val), a4 (val), a1 (val), a3 (val)
        local Amount, v1
        local v2 = u97
        local v3 = u97
        for i, j in a4.Offers do
            if j.ProductName == a1 then
                Amount = j.Amount
            elseif j.GiftProductName ~= a1 then
                continue
            else
                Amount = j.Amount
            end
            v1 = if Amount ~= 1 then ("%* limited pet eggs."):format(Amount) else "A limited pet egg."
            v2.DisplayName = ("Limited Egg x%*"):format(Amount)
            v3.Desc = v1
            return
        end
        Amount = a3
        v1 = if Amount ~= 1 then ("%* limited pet eggs."):format(Amount) else "A limited pet egg."
        v2.DisplayName = ("Limited Egg x%*"):format(Amount)
        v3.Desc = v1
    end)
    return u97
end