-- Script path: ReplicatedStorage.Data.Areas
-- Decompile time: 1.45 ms

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
    Lake = require(Configs.Lake),
    Prehistoric = require(Configs.Prehistoric),
    Snow = require(Configs.Snow),
    Volcano = require(Configs.Volcano),
})
local u65 = require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.Areas", v1, {DropTable = true}, true, function(a1) -- Line: 29
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = 0
        for k, n in j.DropTable do
            v1 = v1 + n[2]
        end
        assert(v1 > 0)
    end
end)
return (table.freeze({
    Directory = u65,
    AreaNameExists = function(a1) -- Line: 44 -- upvalues: u65 (ref) -- types: a1: string
        local v1 = u65
        if rawget(v1, a1) ~= nil then
            return true
        end
        return false, (("Area name \"%*\" does not exist in the Areas directory."):format(a1))
    end,
    GetProgressionOrder = function(a1) -- Line: 52
        return a1.ProgressionOrder or a1.Rarity.Rank
    end,
}))