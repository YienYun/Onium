-- Script path: ReplicatedStorage.Data.Gears
-- Decompile time: 1.93 ms

require(script.Types)
local Configs = script.Configs
local v1 = table.freeze({
    ["Abyss Ocean Bat"] = require(Configs["Abyss Ocean Bat"]),
    Bat = require(Configs.Bat),
    BeeLauncher = require(Configs.BeeLauncher),
    BigTrap = require(Configs.BigTrap),
    ["Cosmic Bat"] = require(Configs["Cosmic Bat"]),
    ["Cricket's Banjo"] = require(Configs["Cricket's Banjo"]),
    ["Desert Bat"] = require(Configs["Desert Bat"]),
    EnchantedHammer = require(Configs.EnchantedHammer),
    Flyswatter = require(Configs.Flyswatter),
    ["Forest Bat"] = require(Configs["Forest Bat"]),
    GravityDisruptor = require(Configs.GravityDisruptor),
    ["Haunted Rod"] = require(Configs["Haunted Rod"]),
    ["Jungle Bat"] = require(Configs["Jungle Bat"]),
    Katana = require(Configs.Katana),
    ["Lake Bat"] = require(Configs["Lake Bat"]),
    ["Light Dark Staff"] = require(Configs["Light Dark Staff"]),
    ["Manor Key"] = require(Configs["Manor Key"]),
    ["Prehistoric Bat"] = require(Configs["Prehistoric Bat"]),
    ["Pumpkin Scythe"] = require(Configs["Pumpkin Scythe"]),
    ["Scramble Sword"] = require(Configs["Scramble Sword"]),
    ["Racing Bat"] = require(Configs["Racing Bat"]),
    ["Snow Bat"] = require(Configs["Snow Bat"]),
    ["The Scrambler"] = require(Configs["The Scrambler"]),
    ["Titan Axe"] = require(Configs["Titan Axe"]),
    Trap = require(Configs.Trap),
    ["Volcano Bat"] = require(Configs["Volcano Bat"]),
})
local u104 = require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.Gears", v1, {
    MoneyCost = true,
    ShopDropWeight = true,
    MinShopStockQuantity = true,
    MaxShopStockQuantity = true,
    SlapPower = true,
    MaxActiveDeployments = true,
    BatControllerData = true,
    ControllerData = true,
    COOLDOWN = true,
    MAX_RANGE = true,
    MOB_DAMAGE = true,
    RAGDOLL_DURATION = true,
    SLAP_DURATION = true,
    SLAP_FORCE = true,
    DETECTION_RANGE = true,
    LIFETIME = true,
    PULL_SPEED = true,
    PULL_DURATION = true,
    MAX_PULL_DISTANCE = true,
    DANCE_DURATION = true,
    STUN_DURATION = true,
    USE_LIMIT = true,
}, true, function(a1) -- Line: 84
    local MaxShopStockQuantity, v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = false
        if j.MinShopStockQuantity % 1 == 0 then
            v1 = j.MaxShopStockQuantity % 1 == 0
        end
        assert(v1)
        MaxShopStockQuantity = j.MaxShopStockQuantity
        assert(j.MinShopStockQuantity <= MaxShopStockQuantity)
        if j.MaxActiveDeployments then
            assert(j.MaxActiveDeployments % 1 == 0)
        end
    end
end)
return (table.freeze({
    Directory = u104,
    GearNameExists = function(a1) -- Line: 98 -- upvalues: u104 (ref) -- types: a1: string
        local v1 = u104
        if rawget(v1, a1) ~= nil then
            return true
        end
        return false, (("Gears name \"%*\" does not exist in the Gears directory."):format(a1))
    end,
}))