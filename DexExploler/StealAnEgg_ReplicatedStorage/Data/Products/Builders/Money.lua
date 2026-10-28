-- Script path: ReplicatedStorage.Data.Products.Builders.Money
-- Decompile time: 2.59 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(script.Parent.Parent.Internal.ProductTypes)
local t = require(ReplicatedStorage.Packages.t)
local u31 = {Desc = "Purchase bonus money!", HoldWhilePending = true}

local function withDefaults(a1) -- Line: 21 -- upvalues: u31 (val) -- types: a1: table
    local v1 = table.clone(u31)
    for i, j in a1 do
        v1[i] = j
    end
    return v1
end

local function rewardAmountFrom(a1) -- Line: 29 -- types: a1: string
    local v1 = string.match(a1, "^Money_(%d+)$")
    if v1 == nil then
        error((("money product \"%*\" must be named Money_<amount>"):format(a1)))
    end
    local v2 = tonumber(v1)
    if v2 == nil or v2 <= 0 then
        error((("money product \"%*\" must carry a positive amount"):format(a1)))
    end
    return v2
end

local function moneyLabel(a1) -- Line: 41 -- upvalues: Simple (val) -- types: a1: number
    return (("$%* Money"):format((Simple.FormatCompact(a1, ".#"))))
end

local function profileReady(a1) -- Line: 45
    if a1 then
        return true
    end
    return false, "Player data is not loaded yet."
end

return function(a1, a2) -- Line: 52
    -- upvalues: t (val), BalanceConfig (val), rewardAmountFrom (val), ServerScriptService (val), profileReady (val)
    -- upvalues: ReplicatedStorage (val), Simple (val), u31 (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    local u28 = BalanceConfig.Bind("Game.Balance.ProductRewards." .. a1, {Amount = rewardAmountFrom(a1)}, true, false, function(a1) -- Line: 64
        assert(0 < a1.Amount)
    end)
    local v1 = {
        Name = a1,
        ProductId = a2,
        DisplayName = ("$%* Money"):format((Simple.FormatCompact(u28.Amount, ".#"))),
        Precheck = function() -- Line: 78 -- upvalues: ReplicatedStorage (upval), profileReady (upval)
            return profileReady((require(ReplicatedStorage.Shared.Save)).Await())
        end,
        Authorize = function(a1) -- Line: 69 -- upvalues: ServerScriptService (upval), profileReady (upval) -- types: a1: userdata
            local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
            if not v1 then
                return false, "Failed to retrieve player data."
            end
            return profileReady(v2)
        end,
        Grant = function(a1) -- Line: 83 -- upvalues: ServerScriptService (upval), u28 (val) -- types: a1: userdata
            require(ServerScriptService.Controllers.MoneyService).AddMoney(a1, u28.Amount, {source = "DevProduct"})
            return true
        end,
    }
    local u47 = table.clone(u31)
    for i, j in v1 do
        u47[i] = j
    end
    BalanceConfig.Changed:Connect(function() -- Line: 99 -- upvalues: u47 (val), u28 (val), Simple (upval)
        u47.DisplayName = ("$%* Money"):format((Simple.FormatCompact(u28.Amount, ".#")))
    end)
    return u47
end