-- Script path: ReplicatedStorage.Data.Products.Builders.SpeedPower
-- Decompile time: 2.40 ms

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Packages.FormatNumber.Simple)
local t = require(ReplicatedStorage.Packages.t)
local SpeedPacks = require(ReplicatedStorage.Data.SpeedPacks)
local Players = game:GetService("Players")
return function(a1, a2) -- Line: 22
    -- upvalues: t (val), SpeedPacks (val), ReplicatedStorage (val), ServerScriptService (val), Players (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    local u22 = assert(SpeedPacks.FindSlot(a2), "Unknown speed pack product")
    local v1 = tonumber(((a1:gsub("SpeedPower_", "")):gsub("%D", "")))
    assert(v1 ~= nil, "Speed power product name must include a numeric reward amount")
    assert(v1 > 0, "Speed power reward must be positive")
    local u68 = (require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Bind("Game.Balance.ProductRewards." .. a1, {Amount = v1}, true, false, function(a1) -- Line: 38
        assert(0 < a1.Amount)
    end)

    local function ensureDataLoaded(a1) -- Line: 43
        if a1 then
            return true
        end
        return false, "Player data is not loaded yet."
    end

    local u75 = {Desc = "Purchase bonus speed!", HoldWhilePending = true, Name = a1, ProductId = a2}
    u75.DisplayName = SpeedPacks.Names[u22]
    u75.SpeedPowerReward = u68.Amount

    function u75.Precheck() -- Line: 66
        -- upvalues: ReplicatedStorage (upval), SpeedPacks (upval), Players (upval), u22 (val), ensureDataLoaded (val)
        local v1 = (require(ReplicatedStorage.Shared.Save)).Await()
        if SpeedPacks.GetShownAmount(Players.LocalPlayer, u22) == nil then
            return false, "Speed packs are still loading."
        end
        return ensureDataLoaded(v1)
    end

    function u75.Authorize(a1) -- Line: 51
        -- upvalues: ServerScriptService (upval), u22 (val), ensureDataLoaded (val)
        local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(a1)
        if not v1 then
            return false, "Failed to retrieve player data."
        end
        if require(ServerScriptService.Controllers.SpeedPackService).GetAmount(a1, u22) == nil then
            return false, "Speed packs are still loading."
        end
        return ensureDataLoaded(v2)
    end

    function u75.Grant(a1, a2) -- Line: 77 -- upvalues: ServerScriptService (upval), u22 (val) -- types: a1: userdata
        return require(ServerScriptService.Controllers.SpeedPackService).Grant(a1, u22, a2)
    end

    ;(require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Changed:Connect(function() -- Line: 92 -- upvalues: u75 (val), SpeedPacks (upval), u22 (val), u68 (val)
        u75.DisplayName = SpeedPacks.Names[u22]
        u75.SpeedPowerReward = u68.Amount
    end)
    return u75
end