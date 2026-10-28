-- Script path: ReplicatedStorage.Shared.Modules.RaceRallyRewards
-- Decompile time: 11.83 ms

local Asset, Mount_2, Mounts, err, err_2, err_3, success, success_2, success_3, v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local Gears = require(ReplicatedStorage.Data.Gears)
local GearToolLookup = require(ReplicatedStorage.Shared.Util.GearToolLookup)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local RaceRally = require(ReplicatedStorage.Data.RaceRally)
local RaceRallyFlags = require(ReplicatedStorage.Shared.Flags.RaceRallyFlags)
local ScrambleMutationFlags = require(ReplicatedStorage.Shared.Flags.ScrambleMutationFlags)
local u62 = table.freeze({
    Boss = {
        Title = "Fractured Mutation",
        Icon = "rbxassetid://74755693699202",
        Success = function() -- Line: 41 -- upvalues: BossMasteryFlags (val)
            return BossMasteryFlags.MutationConsumableSuccessPercent:Get()
        end,
    },
    Scrambled = {
        Title = "Scrambled Mutation",
        Icon = "rbxassetid://134710848063255",
        Success = function() -- Line: 48 -- upvalues: ScrambleMutationFlags (val)
            return ScrambleMutationFlags.SuccessPercent:Get()
        end,
    },
    Enchanted = {
        Title = "Enchanted Essence",
        Icon = "rbxassetid://73528861998418",
        Success = function() -- Line: 55
            return 100
        end,
    },
    Nitro = {
        Title = "Nitro Mutation",
        Icon = "rbxassetid://134287739122547",
        Success = function() -- Line: 62 -- upvalues: RaceRallyFlags (val)
            return RaceRallyFlags.NitroSuccessPercent:Get()
        end,
    },
})

local function duration(a1) -- Line: 68 -- types: a1: number
    if a1 >= 3600 and a1 % 3600 == 0 then
        return (("%*h"):format(a1 // 3600))
    end
    if a1 >= 60 and a1 % 60 == 0 then
        return (("%*m"):format(a1 // 60))
    end
    return (("%*s"):format(a1))
end

local function count(a1, a2) -- Line: 77 -- types: a2: string
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if a1 >= 1 then
            v1 = a1 % 1 == 0
        end
    end
    assert(v1, (("%* must be a whole number of at least 1"):format(a2)))
end

local function asset(a1) -- Line: 81 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    local v2 = ("Unknown pet \"%*\""):format(a1)
    assert(v1 ~= nil, v2)
    return v1
end

local function boost(a1, a2, a3, a4, a5) -- Line: 88
    -- upvalues: 
    return {
        Validate = function(a1) -- Line: 90 -- upvalues: a5 (val)
            local v1
            if a1.Seconds ~= nil then
                local Seconds = a1.Seconds
                v1 = ("%*.Seconds"):format(a1.Kind)
                local v2 = false
                if type(Seconds) == "number" then
                    v2 = false
                    if Seconds >= 1 then
                        v2 = Seconds % 1 == 0
                    end
                end
                assert(v2, (("%* must be a whole number of at least 1"):format(v1)))
            end
            if a1.Multiplier ~= nil then
                assert(a5, (("%* rewards can't set a Multiplier"):format(a1.Kind)))
                v1 = false
                if type(a1.Multiplier) == "number" then
                    v1 = false
                    if 1 < a1.Multiplier then
                        v1 = a1.Multiplier < (1 / 0)
                    end
                end
                assert(v1, (("%*.Multiplier must be above 1"):format(a1.Kind)))
            end
        end,
        Present = function(a1_2) -- Line: 102 -- upvalues: a3 (val), a1 (val), a2 (val), a4 (val)
            local v1 = ("%*x"):format(a1_2.Multiplier or a3())
            local v2 = {Title = ("%* %*"):format(v1, a1), Icon = a2}
            local Seconds = a1_2.Seconds or a4()
            v2.Amount = if not (Seconds >= 3600) then if not (Seconds >= 60) or Seconds % 60 ~= 0 then ("%*s"):format(Seconds) else ("%*m"):format(Seconds // 60) else if Seconds % 3600 == 0 then ("%*h"):format(Seconds // 3600) else if not (Seconds >= 60) or Seconds % 60 ~= 0 then ("%*s"):format(Seconds) else ("%*m"):format(Seconds // 60)
            v2.Multiplier = v1
            return v2
        end,
    }
end

local u67 = {}
u67.Gear = {
    Validate = function(a1) -- Line: 116 -- upvalues: Gears (val), GearToolLookup (val)
        local v1 = Gears.Directory[a1.GearId]
        local v2 = false
        if v1 ~= nil then
            v2 = false
            if v1.Persistent == true then
                v2 = v1.OneTime == true
            end
        end
        assert(v2, "Gear reward needs a permanent one-time gear")
        assert(a1.Amount == 1, "Gear rewards grant exactly one")
        assert(GearToolLookup(v1.ToolModel or a1.GearId) ~= nil, "Gear reward tool is missing")
    end,
    Present = function(a1) -- Line: 122 -- upvalues: Gears (val)
        local v1 = Gears.Directory[a1.GearId]
        return {
            Amount = "Permanent",
            Title = v1.DisplayName,
            Icon = v1.Icon,
            Rarity = v1.Rarity,
        }
    end,
}
u67.Egg = {
    Validate = function(a1) -- Line: 128 -- upvalues: Assets (val), Mutations (val)
        assert(type(a1.Category) == "string", "Egg reward needs a Category")
        local Category_2 = a1.Category
        assert(Assets.Directory[Category_2] ~= nil, (("Unknown pet \"%*\""):format(Category_2)))
        if a1.Mutation ~= nil then
            assert(Mutations.All()[a1.Mutation] ~= nil, (("Unknown mutation \"%*\""):format(a1.Mutation)))
        end
        if a1.Scale ~= nil then
            local v1 = false
            if type(a1.Scale) == "number" then
                v1 = 0 < a1.Scale
            end
            assert(v1, "Egg reward Scale must be positive")
        end
    end,
    Present = function(a1) -- Line: 138 -- upvalues: Assets (val), Mutations (val)
        local Category = a1.Category
        local v1 = Assets.Directory[Category]
        local v2 = ("Unknown pet \"%*\""):format(Category)
        assert(v1 ~= nil, v2)
        local DisplayName = if v1.Egg == nil or v1.Egg.DisplayName == nil then ("%* Egg"):format(v1.DisplayName) else v1.Egg.DisplayName
        if a1.Mutation ~= nil then
            DisplayName = ("%* %*"):format((Mutations.All())[a1.Mutation].Label, DisplayName)
        end
        local v3 = {Amount = "x1", Title = DisplayName}
        local Icon = if v1.Egg == nil then v1.Icon else if v1.Egg.Icon == nil then v1.Icon else v1.Egg.Icon
        v3.Icon = Icon
        v3.Rarity = v1.Rarity._id
        v3.Asset = a1.Category
        return v3
    end,
}
u67.MutationConsumable = {
    Validate = function(a1) -- Line: 157 -- upvalues: u62 (val)
        assert(u62[a1.MutationId] ~= nil, (("Unsupported mutation token \"%*\""):format(a1.MutationId)))
        local Amount = a1.Amount
        local v1 = false
        if type(Amount) == "number" then
            v1 = false
            if Amount >= 1 then
                v1 = Amount % 1 == 0
            end
        end
        assert(v1, "MutationConsumable.Amount must be a whole number of at least 1")
    end,
    Present = function(a1) -- Line: 161 -- upvalues: u62 (val)
        local v1 = u62[a1.MutationId]
        return {
            Title = v1.Title,
            Icon = v1.Icon,
            Amount = ("x%* · %*%%"):format(a1.Amount, (v1.Success())),
        }
    end,
}
u67.CashBooster = boost("Cash Booster", "rbxassetid://119640363267627", function() -- Line: 167 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.CashBoosterMultiplier:Get()
end, function() -- Line: 169 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.CashBoosterDurationSeconds:Get()
end, true)
u67.SpeedBoost = boost("Speed", "rbxassetid://78137530993637", function() -- Line: 173 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.SpeedBoostMultiplier:Get()
end, function() -- Line: 175 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.SpeedBoostDurationSeconds:Get()
end, false)
u67.TreadmillBoost = boost("Treadmill Booster", "rbxassetid://107126944152347", function() -- Line: 179 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.TreadmillBoostMultiplier:Get()
end, function() -- Line: 181 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.TreadmillBoostDurationSeconds:Get()
end, false)
u67.Racer = {
    Validate = function(a1) -- Line: 186 -- upvalues: RaceRally (val)
        assert(RaceRally.Racers[a1.Racer] ~= nil, (("Unknown racer \"%*\""):format(a1.Racer)))
    end,
    Present = function(a1) -- Line: 189 -- upvalues: RaceRally (val), Assets (val)
        local v1 = RaceRally.Racers[a1.Racer]
        local Asset = v1.Asset
        local v2 = Assets.Directory[Asset]
        local v3 = ("Unknown pet \"%*\""):format(Asset)
        assert(v2 ~= nil, v3)
        return {
            Amount = "Racer",
            Title = ("%* Racer"):format(v1.DisplayName),
            Icon = v2.Icon,
            Rarity = v2.Rarity._id,
            Asset = v1.Asset,
        }
    end,
}
u67.Tokens = {
    Validate = function(a1) -- Line: 203
        local Amount = a1.Amount
        local v1 = false
        if type(Amount) == "number" then
            v1 = false
            if Amount >= 1 then
                v1 = Amount % 1 == 0
            end
        end
        assert(v1, "Tokens.Amount must be a whole number of at least 1")
    end,
    Present = function(a1) -- Line: 206 -- upvalues: RaceRally (val), Numbers (val)
        return {
            Title = RaceRally.CurrencyName,
            Icon = RaceRally.CurrencyIcon,
            Amount = ("x%*"):format((Numbers.AddCommas(a1.Amount))),
        }
    end,
}
local v2 = {
    Kinds = u67,
    Validate = function(a1) -- Line: 220 -- upvalues: u67 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = type(a1.Kind) == "string"
        end
        assert(v1, "A reward needs a Kind")
        local v2 = u67[a1.Kind]
        local v3 = ("Unknown reward kind \"%*\""):format(a1.Kind)
        assert(v2 ~= nil, v3)
        v2.Validate(a1)
        local v4 = true
        if a1.DisplayName ~= nil then
            v4 = type(a1.DisplayName) == "string"
        end
        assert(v4, "DisplayName must be a string")
        v4 = true
        if a1.Icon ~= nil then
            v4 = type(a1.Icon) == "string"
        end
        assert(v4, "Icon must be a string")
    end,
    Present = function(a1) -- Line: 230 -- upvalues: u67 (val)
        local v1 = u67[a1.Kind].Present(a1)
        if a1.DisplayName ~= nil then
            v1.Title = a1.DisplayName
        end
        if a1.Icon ~= nil then
            v1.Icon = a1.Icon
        end
        return v1
    end,
}
assert(RaceRally.Racers[RaceRally.DefaultRacer] ~= nil, (("Default racer \"%*\" is missing"):format(RaceRally.DefaultRacer)))
local v3 = nil
local v4 = nil
for i, j in RaceRally.Racers, v3, v4 do
    Mounts = MountRace.Mounts
    Mount_2 = j.Mount
    v1 = ("Racer %* has no mount model \"%*\""):format(i, Mount_2)
    assert(Mounts:FindFirstChild(j.Mount) ~= nil, v1)
    Asset = j.Asset
    assert(Assets.Directory[Asset] ~= nil, (("Unknown pet \"%*\""):format(Asset)))
end
for k, n in RaceRally.Shop do
    success_3, err_3 = pcall(v2.Validate, n.Reward)
    assert(success_3, (("Race shop offer %*: %*"):format(k, err_3)))
end
v3 = nil
v4 = nil
for m, i5 in RaceRally.Milestones, v3, v4 do
    assert(#i5.Rewards > 0, (("Race milestone %* has no rewards"):format(m)))
    for i6, i7 in i5.Rewards do
        success_2, err_2 = pcall(v2.Validate, i7)
        assert(success_2, (("Race milestone %*: %*"):format(m, err_2)))
    end
end
assert(#RaceRally.Repeat.Rewards > 0, "The race repeat reward has no rewards")
for i8, i9 in RaceRally.Repeat.Rewards do
    success, err = pcall(v2.Validate, i9)
    assert(success, (("Race repeat reward: %*"):format(err)))
end
return table.freeze(v2)