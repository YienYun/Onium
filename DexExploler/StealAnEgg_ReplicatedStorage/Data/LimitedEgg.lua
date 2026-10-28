-- Script path: ReplicatedStorage.Data.LimitedEgg
-- Decompile time: 8.60 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local HalloweenEggSettings = require(ReplicatedStorage.Data.HalloweenEggSettings)
require(script.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
local u38 = {1, 3, 10, 50}
local v1 = {
    DisplayName = "Luminous Egg",
    RerollName = "Luminous Re-roll",
    BalanceKey = "Game.Balance.LimitedEgg",
    ProductName = "Limited Egg",
    MechaPrefix = "Depths ",
    EndsAt = Constants.UPDATE_LIVE_AT,
    BaseOdds = table.freeze({
        table.freeze({AssetId = "Spike", Weight = 39}),
        table.freeze({AssetId = "Manta Ray", Weight = 24}),
        table.freeze({AssetId = "Megalodon", Weight = 18}),
        table.freeze({AssetId = "Electric Eel", Weight = 11}),
        table.freeze({AssetId = "Terra Snapper", Weight = 6.5}),
        (table.freeze({AssetId = "Cthulhu", Weight = 0.5})),
    }),
}
local v2 = {
    DisplayName = "Extinction Egg",
    RerollName = "Skeletal Re-roll",
    EndsAt = 1792249200,
    BalanceKey = "Game.Balance.ExtinctionEgg",
    ProductName = "Extinction Egg",
    MechaPrefix = "Skeletal ",
    BaseOdds = table.freeze({
        table.freeze({AssetId = "Glyptodon", Weight = 39}),
        table.freeze({AssetId = "Terrorbird", Weight = 24}),
        table.freeze({AssetId = "Megatherium", Weight = 18}),
        table.freeze({AssetId = "Dunkleosteus", Weight = 11}),
        table.freeze({AssetId = "Gigantopithecus", Weight = 6.5}),
        (table.freeze({AssetId = "Sabertooth", Weight = 0.5})),
    }),
}
local u88 = {
    DisplayName = "Halloween Egg",
    RerollName = "Zombified Re-roll",
    BalanceKey = "Game.Balance.HalloweenEgg",
    ProductName = "Halloween Egg",
    MechaPrefix = "Zombified ",
    EndsAt = HalloweenEggSettings.EndsAt,
}
u88.BaseOdds = table.freeze({
    table.freeze({AssetId = "Halloween Glyptodon", Weight = 39}),
    table.freeze({AssetId = "Halloween Terrorbird", Weight = 24}),
    table.freeze({AssetId = "Halloween Megatherium", Weight = 18}),
    table.freeze({AssetId = "Halloween Dunkleosteus", Weight = 11}),
    table.freeze({AssetId = "Halloween Gigantopithecus", Weight = 6.5}),
    (table.freeze({AssetId = "Halloween Sabertooth", Weight = 0.5})),
})
local v3 = t.array(function(a1) -- Line: 85
    if type(a1) == "table" and type(a1[1]) == "string" and type(a1[2]) == "number" and not (a1[2] <= 0) then
        return true
    end
    return false, "expected { assetName, positiveWeight }"
end)
local v4 = t.intersection(t.numberPositive, t.numberMax(1))
local u147 = t.interface({
    EndsAt = t.intersection(t.integer, t.numberPositive),
    DropTable = v3,
    MechaReroll = t.interface({Chance = t.numberMax(1), DisplayChance = t.numberMax(1), DropTable = v3}),
    Offers = t.array(t.interface({Amount = t.intersection(t.integer, t.numberMin(1))})),
})

local function toRows(a1) -- Line: 112 -- types: a1: table
    local freeze, v1
    local v2 = table.create(#a1)
    for i, j in a1 do
        freeze = table.freeze
        v1 = {j.AssetId, j.Weight}
        v2[i] = (freeze(v1))
    end
    return table.freeze(v2)
end

local function toEntries(a1) -- Line: 120 -- types: a1: table
    local freeze, v1, v2, v3
    local v4 = table.create(#a1)
    local v5 = nil
    local v6 = nil
    for i, j in a1, v5, v6 do
        if type(j) ~= "table" or type(j[1]) ~= "string" or type(j[2]) ~= "number" then
            v2 = false
            v3 = "expected { assetName, positiveWeight }"
        elseif not (j[2] <= 0) then
            v2 = true
            v3 = nil
        else
            v2 = false
            v3 = "expected { assetName, positiveWeight }"
        end
        if not v2 then
            error((("limited egg drop row %*: %*"):format(i, v3)))
        end
        freeze = table.freeze
        v1 = {AssetId = j[1], Weight = j[2]}
        v4[i] = (freeze(v1))
    end
    return table.freeze(v4)
end

local function prefixed(a1, a2) -- Line: 132 -- types: a1: table, a2: string
    local freeze, v1
    local v2 = table.create(#a1)
    for i, j in a1 do
        freeze = table.freeze
        v1 = {AssetId = a2 .. j.AssetId, Weight = j.Weight}
        v2[i] = (freeze(v1))
    end
    return table.freeze(v2)
end

local function offersFor(a1, a2) -- Line: 140 -- types: a1: table, a2: string
    local freeze, v1
    local v2 = table.create(#a1)
    local v3 = nil
    local v4 = nil
    local v5 = a2
    for i, j in a1, v3, v4 do
        freeze = table.freeze
        v1 = {
            Amount = j,
            ProductName = if j ~= 1 then ("%* x%*"):format(v5, j) else v5,
            GiftProductName = if v5 ~= "Halloween Egg" then nil else if j ~= 1 then ("Halloween Egg Gift x%*"):format(j) else "Halloween Egg Gift",
        }
        v2[i] = (freeze(v1))
    end
    return table.freeze(v2)
end

local u156 = if not RunService:IsStudio() then 0.01 else 0.5
assert((v4(u156)))
assert((v4(0.01)))

local function bind(a1) -- Line: 157
    -- upvalues: prefixed (val), offersFor (val), u38 (val), toRows (val), u88 (val), u156 (val), u147 (val)
    -- upvalues: BalanceConfig (val), toEntries (val)
    local v1 = prefixed(a1.BaseOdds, a1.MechaPrefix)
    assert(#a1.BaseOdds == 6, (("the limited egg shop expects %* drop rows"):format(6)))
    local u58 = BalanceConfig.Bind(a1.BalanceKey, table.freeze({
        InfoText = "Pets can have different <font color=\"#55FF77\"><b>sizes</b></font>, <font color=\"#55FF77\"><b>colors</b></font> and <font color=\"#55FF77\"><b>mutations</b></font>. Huge pets and pets with rare mutations earn <font color=\"#1AFF00\"><b>way more money</b></font>!",
        DisplayName = a1.DisplayName,
        RerollName = a1.RerollName,
        EndsAt = a1.EndsAt,
        Offers = offersFor(u38, a1.ProductName),
        DropTable = toRows(a1.BaseOdds),
        Entries = a1.BaseOdds,
        MechaReroll = table.freeze({
            DisplayChance = 0.01,
            Chance = if a1 ~= u88 then u156 else 0.01,
            DropTable = toRows(v1),
            Entries = v1,
        }),
    }), {
        EndsAt = true,
        DropTable = true,
        Offers = true,
        MechaReroll = {Chance = true, DisplayChance = true, DropTable = true},
    }, false, function(a1_2) -- Line: 177 -- upvalues: u147 (upval), a1 (val)
        local v1, v2 = u147(a1_2)
        if not v1 then
            error((("%* override rejected: %*"):format(a1.BalanceKey, v2)))
        end
    end)
    u58.Entries = toEntries(u58.DropTable)
    local MechaReroll = u58.MechaReroll
    if MechaReroll ~= nil then
        MechaReroll.Entries = toEntries(MechaReroll.DropTable)
    end
    BalanceConfig.Changed:Connect(function() -- Line: 191 -- upvalues: u58 (val), toEntries (upval)
        u58.Entries = toEntries(u58.DropTable)
        local MechaReroll = u58.MechaReroll
        if MechaReroll ~= nil then
            MechaReroll.Entries = toEntries(MechaReroll.DropTable)
        end
    end)
    return u58
end

local u182 = bind(v1)
local u187 = bind(v2)
local u191 = bind(u88)

local function onSale() -- Line: 215
    -- upvalues: u191 (val), HalloweenEggSettings (val), u187 (val), Workspace (val), Constants (val), u182 (val)
    u191.EndsAt = HalloweenEggSettings.EndsAt
    u187.EndsAt = HalloweenEggSettings.StartsAt
    local ServerTimeNow = Workspace:GetServerTimeNow()
    return (if not HalloweenEggSettings.IsActive(ServerTimeNow) then if not (HalloweenEggSettings.EndsAt <= ServerTimeNow) then if not (Constants.UPDATE_LIVE_AT <= ServerTimeNow) then u182 else u187 else nil else u191) or u191
end

return (setmetatable({
    SwitchesAt = Constants.UPDATE_LIVE_AT,
    Luminous = u182,
    Extinction = u187,
    Halloween = u191,
    Active = function(a1) -- Line: 208
        -- upvalues: u191 (val), HalloweenEggSettings (val), u187 (val), Workspace (val), Constants (val), u182 (val)
        u191.EndsAt = HalloweenEggSettings.EndsAt
        u187.EndsAt = HalloweenEggSettings.StartsAt
        local ServerTimeNow = a1 or Workspace:GetServerTimeNow()
        if HalloweenEggSettings.IsActive(ServerTimeNow) then
            return u191
        end
        if HalloweenEggSettings.EndsAt <= ServerTimeNow then
            return nil
        end
        if Constants.UPDATE_LIVE_AT <= ServerTimeNow then
            return u187
        end
        return u182
    end,
    ForCategory = function(a1) -- Line: 218 -- upvalues: u182 (val), u187 (val), u191 (val) -- types: a1: string
        local v1 = {u182, u187, u191}
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            for k, n in j.Entries do
                if n.AssetId == v4 then
                    return j
                end
            end
            if j.MechaReroll then
                for m, i5 in j.MechaReroll.Entries do
                    if i5.AssetId == v4 then
                        return j
                    end
                end
            end
        end
        return nil
    end,
    IsOnSale = function(a1, a2) -- Line: 246
        -- upvalues: u191 (val), HalloweenEggSettings (val), u187 (val), Workspace (val), Constants (val), u182 (val)
        u191.EndsAt = HalloweenEggSettings.EndsAt
        u187.EndsAt = HalloweenEggSettings.StartsAt
        local ServerTimeNow = a2 or Workspace:GetServerTimeNow()
        return (if not HalloweenEggSettings.IsActive(ServerTimeNow) then if not (HalloweenEggSettings.EndsAt <= ServerTimeNow) then if not (Constants.UPDATE_LIVE_AT <= ServerTimeNow) then u182 else u187 else nil else u191) == a1
    end,
}, {
    __index = function(a1, a2) -- Line: 248
        -- upvalues: u191 (val), HalloweenEggSettings (val), u187 (val), Workspace (val), Constants (val), u182 (val)
        u191.EndsAt = HalloweenEggSettings.EndsAt
        u187.EndsAt = HalloweenEggSettings.StartsAt
        local ServerTimeNow = Workspace:GetServerTimeNow()
        return ((if not HalloweenEggSettings.IsActive(ServerTimeNow) then if not (HalloweenEggSettings.EndsAt <= ServerTimeNow) then if not (Constants.UPDATE_LIVE_AT <= ServerTimeNow) then u182 else u187 else nil else u191) or u191)[a2]
    end,
}))