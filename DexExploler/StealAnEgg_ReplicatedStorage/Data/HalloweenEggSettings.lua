-- Script path: ReplicatedStorage.Data.HalloweenEggSettings
-- Decompile time: 1.69 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local u24 = BalanceConfig.Bind("Game.HalloweenEgg", {
    StartsAt = 1792249200,
    EndsAt = 1793458800,
    ProductIds = {Single = 3718848856, Triple = 3718848909, Ten = 3718848926, Fifty = 3718848956},
    GiftProductIds = {Single = 3718849262, Triple = 3718849356, Ten = 3718849452, Fifty = 3718849572},
}, {StartsAt = true, EndsAt = true, ProductIds = true, GiftProductIds = true}, false, function(a1) -- Line: 9
    local v1, v2, v3
    local v4 = false
    if a1.StartsAt % 1 == 0 then
        v4 = false
        if a1.EndsAt % 1 == 0 then
            v4 = a1.StartsAt < a1.EndsAt
        end
    end
    assert(v4, "Invalid Halloween sale schedule")
    local v5 = {}
    v4 = {}
    v4[1] = a1.ProductIds
    v4[2] = a1.GiftProductIds
    local v6 = nil
    local v7 = nil
    for i, j in v4, v6, v7 do
        v2 = nil
        v3 = nil
        for k, n in j, v2, v3 do
            v1 = false
            if n % 1 == 0 then
                v1 = n >= 0
            end
            assert(v1, "Invalid Halloween product ID")
            if n > 0 then
                assert(not v5[n], "Duplicate Halloween product ID")
                v5[n] = true
            end
        end
    end
end)

function u24.IsPreview() -- Line: 17 -- upvalues: Environment (val)
    return Environment.IsDevPlace() or Environment.IsTestPlace()
end

function u24.Time(a1) -- Line: 20 -- upvalues: u24 (val) -- types: a1: number
    if u24.IsPreview() and a1 < u24.StartsAt then
        return u24.StartsAt
    end
    return a1
end

function u24.IsActive(a1) -- Line: 23 -- upvalues: u24 (val) -- types: a1: number
    local v1 = u24.Time(a1)
    local v2 = false
    if u24.StartsAt <= v1 then
        v2 = v1 < u24.EndsAt
    end
    return v2
end

return u24