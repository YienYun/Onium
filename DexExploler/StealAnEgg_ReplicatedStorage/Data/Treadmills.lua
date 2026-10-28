-- Script path: ReplicatedStorage.Data.Treadmills
-- Decompile time: 2.06 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Data.Rarity)
local Configs = script.Configs
local v1 = {
    AngelicTreadmill = require(Configs.AngelicTreadmill),
    AstralTreadmill = require(Configs.AstralTreadmill),
    CelebrityTreadmill = require(Configs.CelebrityTreadmill),
    DemonicTreadmill = require(Configs.DemonicTreadmill),
    FlameTreadmill = require(Configs.FlameTreadmill),
    GoldenTreadmill = require(Configs.GoldenTreadmill),
    GuardianTreadmill = require(Configs.GuardianTreadmill),
    HackerTreadmill = require(Configs.HackerTreadmill),
    ["Lucky BlockTreadmill"] = require(Configs["Lucky BlockTreadmill"]),
    ["Sci-FiTreadmill"] = require(Configs["Sci-FiTreadmill"]),
    ["The FreezeTreadmill"] = require(Configs["The FreezeTreadmill"]),
    Treadmill = require(Configs.Treadmill),
}
table.freeze(v1)
local u51 = {}
u51.BrockTreadmill = require(Configs.BrockTreadmill)
table.freeze(u51)
local u58 = {}
local u59 = {}
for k, v in pairs(v1) do
    table.insert(u58, v)
end
table.sort(u58, function(a1, a2) -- Line: 50
    return a1.Price < a2.Price
end)
for i, i2 in ipairs(u58) do
    u59[i2._id] = i
end
local u107 = require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.Treadmills", v1, {Price = true, SpeedMultiplier = true}, true, function(a1) -- Line: 63
    local v1 = nil
    local v2 = nil
    for i, j in a1, v1, v2 do
        assert(0 < j.SpeedMultiplier)
    end
end)
for j, k2 in u58 do
    u58[j] = u107[k2._id]
end
table.freeze(u58)
table.freeze(u59)
return (table.freeze({
    OverrideAttribute = "TreadmillOverride",
    Directory = u107,
    SessionOnly = u51,
    TreadmillNameExists = function(a1) -- Line: 83 -- upvalues: u107 (ref) -- types: a1: string
        if u107[a1] ~= nil then
            return true
        end
        return false, (("Treadmills name \"%*\" does not exist in the Treadmills directory."):format(a1))
    end,
    GetOrdered = function() -- Line: 91 -- upvalues: u58 (val)
        return table.clone(u58)
    end,
    GetByUpgradeLevel = function(a1) -- Line: 95 -- upvalues: u58 (val) -- types: a1: number
        return u58[a1]
    end,
    GetUpgradeLevel = function(a1) -- Line: 99 -- upvalues: u59 (val) -- types: a1: string
        return u59[a1]
    end,
    GetById = function(a1) -- Line: 103 -- upvalues: u107 (ref), u51 (val) -- types: a1: string
        return u107[a1] or u51[a1]
    end,
    ResolveForPlayer = function(a1, a2) -- Line: 107 -- upvalues: u51 (val), u58 (val) -- types: a1: userdata, a2: number
        local Attribute = a1:GetAttribute("TreadmillOverride")
        if typeof(Attribute) == "string" and u51[Attribute] ~= nil then
            return u51[Attribute]
        end
        return u58[a2]
    end,
}))