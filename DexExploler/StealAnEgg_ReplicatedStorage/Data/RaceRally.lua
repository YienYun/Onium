-- Script path: ReplicatedStorage.Data.RaceRally
-- Decompile time: 6.37 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)

local function wholes(a1, a2) -- Line: 36 -- types: a1: table, a2: string
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = ("%*.%* must be a whole number"):format(v4, i)
        assert(j % 1 == 0, v1)
    end
end

local u11 = {
    EventName = "RaceRally",
    Currency = "RaceTokens",
    CurrencyName = "Trophies",
    CurrencyIcon = "rbxassetid://119210375463488",
    Track = "RaceTrack",
    Zone = "Abyss Ocean",
    DefaultRacer = "Ostrich",
}
u11.Attributes = table.freeze({
    JoinEndsAt = "RaceRallyJoinEndsAt",
    HeatJoinEndsAt = "RaceRallyHeatJoinEndsAt",
    Window = "RaceRallyWindow",
    Running = "RaceRallyRunning",
})
u11.PlayerAttributes = table.freeze({Queued = "RaceRallyQueued"})
u11.Racers = table.freeze({
    Ostrich = table.freeze({Order = 1, DisplayName = "Ostrich", Mount = "Ostrich", Asset = "Ostrich"}),
    Seahorse = table.freeze({Order = 2, DisplayName = "Seahorse", Mount = "RaceSeahorse", Asset = "Race Seahorse"}),
    Lizard = table.freeze({Order = 3, DisplayName = "Lizard", Mount = "RaceLizard", Asset = "Race Lizard"}),
    Bird = table.freeze({Order = 4, DisplayName = "Bird", Mount = "RaceBird", Asset = "Race Bird"}),
    Cheetah = table.freeze({Order = 5, DisplayName = "Cheetah", Mount = "RaceCheetah", Asset = "Race Cheetah"}),
    Snail = table.freeze({Order = 6, DisplayName = "Engine Snail", Mount = "EngineSnail", Asset = "Engine Snail"}),
})
u11.Payouts = BalanceConfig.Bind("Game.Balance.RaceRallyPayouts", {
    First = 2500,
    Second = 2025,
    Third = 1550,
    Finish = 1750,
    Unfinished = 0,
    WinPoints = 1,
}, true, false, function(a1) -- Line: 114 -- types: a1: table
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = ("RaceRallyPayouts.%* must be a whole number"):format(i)
        assert(j % 1 == 0, v1)
    end
end)
u11.Shop = BalanceConfig.Bind("Game.Balance.RaceRallyShop", {
    MutationToken = {
        Order = 1,
        Price = 475,
        Limit = 0,
        RestockSeconds = 0,
        Reward = {Kind = "MutationConsumable", MutationId = "Nitro", Amount = 1},
    },
    CashBooster = {
        Order = 2,
        Price = 275,
        Limit = 0,
        RestockSeconds = 0,
        Reward = {Kind = "CashBooster"},
    },
    SpeedBoost = {
        Order = 3,
        Price = 375,
        Limit = 0,
        RestockSeconds = 0,
        Reward = {Kind = "SpeedBoost"},
    },
    TreadmillBoost = {
        Order = 4,
        Price = 375,
        Limit = 0,
        RestockSeconds = 0,
        Reward = {Kind = "TreadmillBoost"},
    },
    RacingBat = {
        Order = 5,
        Price = 10000,
        Limit = 1,
        RestockSeconds = 0,
        Reward = {Kind = "Gear", GearId = "Racing Bat", Amount = 1},
    },
}, {Price = true, Limit = true, RestockSeconds = true}, true, function(a1) -- Line: 160 -- types: a1: table
    local v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    for i, j in a1, v5, v6 do
        v2 = ("RaceRallyShop.%*"):format(i)
        v3 = nil
        v4 = nil
        for k, n in j, v3, v4 do
            v1 = ("%*.%* must be a whole number"):format(v2, k)
            assert(n % 1 == 0, v1)
        end
        assert(0 < j.Price, (("RaceRallyShop.%*.Price must be positive"):format(i)))
    end
end)
u11.Milestones = BalanceConfig.Bind("Game.Balance.RaceRallyMilestones", {
    Wins1 = {
        Order = 1,
        Wins = 1,
        Rewards = {{Kind = "Egg", Category = "Race Seahorse"}, {Kind = "Racer", Racer = "Seahorse"}},
    },
    Wins3 = {Order = 2, Wins = 3, Rewards = {{Kind = "Tokens", Amount = 475}}},
    Wins5 = {
        Order = 3,
        Wins = 5,
        Rewards = {{Kind = "Egg", Category = "Race Lizard"}, {Kind = "Racer", Racer = "Lizard"}},
    },
    Wins7 = {Order = 4, Wins = 7, Rewards = {{Kind = "Tokens", Amount = 475}}},
    Wins10 = {Order = 5, Wins = 10, Rewards = {{Kind = "Tokens", Amount = 625}}},
    Wins12 = {Order = 6, Wins = 12, Rewards = {{Kind = "Tokens", Amount = 625}}},
    Wins15 = {
        Order = 7,
        Wins = 15,
        Rewards = {{Kind = "Egg", Category = "Race Bird"}, {Kind = "Racer", Racer = "Bird"}},
    },
    Wins17 = {Order = 8, Wins = 17, Rewards = {{Kind = "Tokens", Amount = 845}}},
    Wins19 = {Order = 9, Wins = 19, Rewards = {{Kind = "Tokens", Amount = 845}}},
    Wins21 = {
        Order = 10,
        Wins = 21,
        Rewards = {{Kind = "Egg", Category = "Race Cheetah"}, {Kind = "Racer", Racer = "Cheetah"}},
    },
    Wins24 = {Order = 11, Wins = 24, Rewards = {{Kind = "Tokens", Amount = 1250}}},
    Wins27 = {Order = 12, Wins = 27, Rewards = {{Kind = "Tokens", Amount = 1250}}},
    Wins30 = {
        Order = 13,
        Wins = 30,
        Rewards = {{Kind = "Egg", Category = "Engine Snail"}, {Kind = "Racer", Racer = "Snail"}},
    },
}, {Wins = true}, true, function(a1) -- Line: 222 -- types: a1: table
    local v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    for i, j in a1, v5, v6 do
        v2 = ("RaceRallyMilestones.%*"):format(i)
        v3 = nil
        v4 = nil
        for k, n in j, v3, v4 do
            v1 = ("%*.%* must be a whole number"):format(v2, k)
            assert(n % 1 == 0, v1)
        end
        assert(1 <= j.Wins, (("RaceRallyMilestones.%*.Wins must be at least 1"):format(i)))
    end
end)
u11.RepeatId = "Repeat"
u11.Repeat = BalanceConfig.Bind("Game.Balance.RaceRallyRepeat", {After = 30, Every = 5, Rewards = {{Kind = "Tokens", Amount = 1250}}}, {After = true, Every = true}, false, function(a1) -- Line: 242 -- types: a1: table
    local v1
    local v2 = nil
    local v3 = nil
    local v4 = a1
    for i, j in a1, v2, v3 do
        v1 = ("RaceRallyRepeat.%* must be a whole number"):format(i)
        assert(j % 1 == 0, v1)
    end
    assert(0 <= v4.After, "RaceRallyRepeat.After can't be negative")
    assert(1 <= v4.Every, "RaceRallyRepeat.Every must be at least 1")
end)

local function ordered(a1) -- Line: 249 -- types: a1: table
    local v1 = {}
    for i, j in a1 do
        table.insert(v1, {Id = i, Config = j})
    end
    table.sort(v1, function(a1, a2) -- Line: 254
        return a1.Config.Order < a2.Config.Order
    end)
    return v1
end

function u11.OrderedRacers() -- Line: 260 -- upvalues: ordered (val), u11 (val)
    return (ordered(u11.Racers))
end

function u11.OrderedOffers() -- Line: 264 -- upvalues: ordered (val), u11 (val)
    return (ordered(u11.Shop))
end

function u11.OrderedMilestones() -- Line: 268 -- upvalues: ordered (val), u11 (val)
    return (ordered(u11.Milestones))
end

function u11.RepeatsEarned(a1) -- Line: 273 -- upvalues: u11 (val) -- types: a1: number
    local Repeat = u11.Repeat
    return (math.max(a1 - Repeat.After, 0)) // Repeat.Every
end

function u11.RepeatWins(a1) -- Line: 279 -- upvalues: u11 (val) -- types: a1: number
    local Repeat = u11.Repeat
    return Repeat.After + a1 * Repeat.Every
end

function u11.PlaceTokens(a1, a2) -- Line: 285 -- upvalues: u11 (val) -- types: a1: number, a2: boolean
    local Payouts = u11.Payouts
    if not a2 then
        return Payouts.Unfinished
    end
    if a1 == 1 then
        return Payouts.First
    end
    if a1 == 2 then
        return Payouts.Second
    end
    if a1 == 3 then
        return Payouts.Third
    end
    return Payouts.Finish
end

function u11.RestockPeriod(a1, a2) -- Line: 298 -- types: a1: table, a2: number
    if 0 < a1.RestockSeconds then
        return a2 // a1.RestockSeconds
    end
    return 0
end

function u11.PurchasedCount(a1, a2, a3) -- Line: 303 -- upvalues: u11 (val) -- types: a1: table?, a2: table, a3: number
    if a1 ~= nil and a1.Period == u11.RestockPeriod(a2, a3) then
        return a1.Count
    end
    return 0
end

function u11.ResolveRacer(a1, a2) -- Line: 315 -- upvalues: u11 (val) -- types: a1: string, a2: table
    if u11.Racers[a1] == nil then
        return u11.DefaultRacer
    end
    if not a2[a1] and a1 ~= u11.DefaultRacer then
        return u11.DefaultRacer
    end
    return a1
end

u11.DoubleTrophies = table.freeze({
    Key = "DoubleTrophies",
    ProductId = 3717648487,
    DevProductId = 3717648477,
    Icon = "rbxassetid://137714350382416",
})

function u11.DoubleTrophiesProductId() -- Line: 332 -- upvalues: u11 (val)
    local DoubleTrophies = u11.DoubleTrophies
    if game.GameId == 10650210095 then
        return DoubleTrophies.DevProductId
    end
    return DoubleTrophies.ProductId
end

function u11.OwnsDoubleTrophies(a1) -- Line: 337 -- upvalues: u11 (val) -- types: a1: table?
    local v1 = false
    if a1 ~= nil then
        v1 = a1[tostring((u11.DoubleTrophiesProductId()))] == true
    end
    return v1
end

return table.freeze(u11)