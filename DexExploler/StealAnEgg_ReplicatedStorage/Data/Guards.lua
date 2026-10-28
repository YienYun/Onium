-- Script path: ReplicatedStorage.Data.Guards
-- Decompile time: 1.80 ms

require(script.Types)
local Configs = script.Configs
local v1 = table.freeze({
    ["Abyss Ocean"] = require(Configs["Abyss Ocean"]),
    ["Cherry Blossom"] = require(Configs["Cherry Blossom"]),
    Cosmic = require(Configs.Cosmic),
    Desert = require(Configs.Desert),
    Forest = require(Configs.Forest),
    Jungle = require(Configs.Jungle),
    ["Titan Temple"] = require(Configs["Titan Temple"]),
    ["Light Dark"] = require(Configs["Light Dark"]),
    ["Enchanted Forest"] = require(Configs["Enchanted Forest"]),
    ["Light Dark Light"] = require(Configs["Light Dark Light"]),
    ["Light Dark Dark"] = require(Configs["Light Dark Dark"]),
    ["Light Dark Mixed"] = require(Configs["Light Dark Mixed"]),
    Lake = require(Configs.Lake),
    Prehistoric = require(Configs.Prehistoric),
    Snow = require(Configs.Snow),
    Volcano = require(Configs.Volcano),
})
local u74 = require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.Guards", v1, {
    WalkSpeed = true,
    FlatRadius = true,
    HitDistance = true,
    EggPickupDistance = true,
    HomeImpulseBoostDistanceXZ = true,
}, true, function(a1) -- Line: 40
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = false
        if 0 < j.WalkSpeed then
            v1 = false
            if 0 < j.FlatRadius then
                v1 = 0 < j.HitDistance
            end
        end
        assert(v1)
    end
end)
return (table.freeze({
    Directory = u74,
    GuardNameExists = function(a1) -- Line: 49 -- upvalues: u74 (ref) -- types: a1: string
        local v1 = u74
        if rawget(v1, a1) ~= nil then
            return true
        end
        return false, (("Guard name \"%*\" does not exist in the Guards directory."):format(a1))
    end,
    GetLowestWalkSpeed = function() -- Line: 57
        return require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardMovement.MIN_REFERENCE_WALK_SPEED
    end,
    GetHighestWalkSpeed = function() -- Line: 61
        return require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardMovement.MAX_REFERENCE_WALK_SPEED
    end,
}))