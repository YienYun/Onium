-- Script path: ReplicatedStorage.Data.StarBundles
-- Decompile time: 2.43 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarHandlerFlags = require(ReplicatedStorage.Shared.Flags.StarHandlerFlags)
local UnixTimestamp = (DateTime.fromUniversalTime(2026, 10, 17, 15)).UnixTimestamp
local u22 = {
    SoldOutMessage = "No more stock!",
    Bundles = {
        {Key = "StarBundle1", Count = 1, ProductId = 3717079594, DevProductId = 3717079602},
        {
            Key = "StarBundle3",
            Count = 3,
            ProductId = 3717079596,
            DevProductId = 3717079603,
            Badge = "POPULAR",
        },
        {
            Key = "StarBundle10",
            Count = 5,
            ProductId = 3717079601,
            DevProductId = 3717079604,
            Badge = "BEST VALUE",
        },
    },
}

function u22.WeeklyLimit() -- Line: 48 -- upvalues: StarHandlerFlags (val)
    return StarHandlerFlags.WeeklyLimit:Get()
end

function u22.ProductIdFor(a1) -- Line: 52 -- types: a1: table
    if game.GameId == 10650210095 then
        return a1.DevProductId
    end
    return a1.ProductId
end

local function sundayOnOrAfter(a1, a2, a3) -- Line: 56 -- types: a1: number, a2: number, a3: number
    local UnixTimestamp = DateTime.fromUniversalTime(a1, a2, a3).UnixTimestamp
    return UnixTimestamp + (7 - (UnixTimestamp // 86400 + 4) % 7) % 7 * 86400
end

local function easternOffset(a1) -- Line: 62 -- types: a1: number
    local Year = DateTime.fromUnixTimestamp(a1):ToUniversalTime().Year
    local UnixTimestamp = DateTime.fromUniversalTime(Year, 3, 8).UnixTimestamp
    local v1 = UnixTimestamp + (7 - (UnixTimestamp // 86400 + 4) % 7) % 7 * 86400 + 25200
    local UnixTimestamp_2 = DateTime.fromUniversalTime(Year, 11, 1).UnixTimestamp
    local v2 = UnixTimestamp_2 + (7 - (UnixTimestamp_2 // 86400 + 4) % 7) % 7 * 86400 + 21600
    if v1 <= a1 and a1 < v2 then
        return -14400
    end
    return -18000
end

function u22.StockPeriod(a1) -- Line: 69 -- upvalues: UnixTimestamp (val), easternOffset (val) -- types: a1: number
    local v1 = math.floor((math.max(a1, UnixTimestamp - 1)))
    return (v1 + easternOffset(v1) - 212400) // 604800
end

function u22.NextRestockAt(a1) -- Line: 74 -- upvalues: u22 (val), easternOffset (val) -- types: a1: number
    local v1 = (u22.StockPeriod(a1) + 1) * 604800 + 212400
    for i, j in {-14400, -18000} do
        if easternOffset(v1 - j) == j then
            return v1 - j
        end
    end
    return v1 + 18000
end

function u22.Remaining(a1, a2) -- Line: 84 -- upvalues: u22 (val) -- types: a2: number
    return (math.max(
        u22.WeeklyLimit() - (if typeof(a1) ~= "table" or a1.Period ~= u22.StockPeriod(a2) then 0 else if type(a1.Bought) ~= "number" then 0 else a1.Bought),
        0
    ))
end

function u22.StockRefusal(a1, a2, a3) -- Line: 93 -- upvalues: u22 (val) -- types: a2: number, a3: number
    local v1 = u22.Remaining(a1, a3)
    if a2 <= v1 then
        return nil
    end
    if v1 <= 0 then
        return u22.SoldOutMessage
    end
    return (("Only %* Star%* left this week!"):format(v1, if v1 ~= 1 then "s" else ""))
end

return table.freeze(u22)