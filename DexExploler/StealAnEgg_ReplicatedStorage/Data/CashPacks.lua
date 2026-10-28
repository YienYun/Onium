-- Script path: ReplicatedStorage.Data.CashPacks
-- Decompile time: 4.67 ms

local u0 = {
    TestName = "ScaledCashPacks",
    AttributeKey = "Economy.CashPacks.Group",
    GroupAttribute = "CashPackGroup",
    ReadyAttribute = "CashPacksReady",
    RevisionAttribute = "CashPackQuoteRevision",
    AmountAttributePrefix = "CashPackAmount",
    Offers = {
        {
            Name = "CashPack1",
            FixedProductName = "Money_24000",
            ProductId = 3714500805,
            DisplayName = "Cash Pack I",
            Minutes = 40,
            Floor = 24000,
        },
        {
            Name = "CashPack2",
            FixedProductName = "Money_200000",
            ProductId = 3714500817,
            DisplayName = "Cash Pack II",
            Minutes = 120,
            Floor = 200000,
        },
        {
            Name = "CashPack3",
            FixedProductName = "Money_800000",
            ProductId = 3714500825,
            DisplayName = "Cash Pack III",
            Minutes = 360,
            Floor = 800000,
        },
        {
            Name = "CashPack4",
            FixedProductName = "Money_4000000",
            ProductId = 3714500832,
            DisplayName = "Cash Pack IV",
            Minutes = 1080,
            Floor = 4000000,
        },
        {
            Name = "CashPack5",
            FixedProductName = "Money_8000000",
            ProductId = 3714500837,
            DisplayName = "Cash Pack V",
            Minutes = 2880,
            Floor = 8000000,
        },
    },
}
local u13 = {1, 1.2, 1.5, 2, 2.5, 3, 4, 5, 6, 8, 10}

function u0.RoundNice(a1) -- Line: 77 -- upvalues: u13 (val) -- types: a1: number
    local v1
    if a1 <= 0 then
        return 0
    end
    assert(a1 < (1 / 0), "Cash pack amount must be finite")
    local v2 = 10 ^ math.floor((math.log10(a1)))
    local v3 = a1 / v2
    local v4 = u13[1]
    local v5 = (1 / 0)
    for i, j in u13 do
        v1 = math.abs((math.log10(j)) - (math.log10(v3)))
        if v1 < v5 then
            v4 = j
        end
    end
    return v4 * v2
end

function u0.Amount(a1, a2) -- Line: 94 -- upvalues: u0 (val) -- types: a1: table, a2: number
    return (math.max(a1.Floor, (u0.RoundNice(a1.Minutes * 60 * a2))))
end

function u0.RefreshQuote(a1, a2) -- Line: 98 -- upvalues: u0 (val) -- types: a1: table, a2: table
    local Amount, Amounts, PeakBaseRate, v1, v2
    if a2.Day < a1.Day then
        return a1
    end
    if a2.Day == a1.Day and a2.AllowSameDay ~= true then
        return a1
    end
    local v3 = table.clone(a1)
    v3.Day = a2.Day
    local PeakBaseRate_2 = a2.PeakBaseRate
    local v4 = a1.PeakBaseRate * a2.GrowthMultiplier <= PeakBaseRate_2
    if #a1.Amounts == 0 then
        v3.PeakBaseRate = math.max(a1.PeakBaseRate, a2.PeakBaseRate)
        v3.Amounts = {}
        for i, j in a2.Offers do
            Amounts = v3.Amounts
            v1 = a1.Amounts[i] or 0
            Amount = u0.Amount
            PeakBaseRate = v3.PeakBaseRate
            v2 = Amount(j, PeakBaseRate)
            Amounts[i] = (math.max(v1, v2))
        end
    elseif v4 then
        v3.PeakBaseRate = math.max(a1.PeakBaseRate, a2.PeakBaseRate)
        v3.Amounts = {}
        for k, n in a2.Offers do
            Amounts = v3.Amounts
            v1 = a1.Amounts[k] or 0
            Amount = u0.Amount
            PeakBaseRate = v3.PeakBaseRate
            v2 = Amount(n, PeakBaseRate)
            Amounts[k] = (math.max(v1, v2))
        end
    end
    return v3
end

function u0.FindSlot(a1) -- Line: 118 -- upvalues: u0 (val) -- types: a1: number
    for i, j in u0.Offers do
        if j.ProductId == a1 then
            return i
        end
    end
    return nil
end

function u0.NormalizeGroup(a1) -- Line: 127
    if a1 ~= "VariantA" and a1 ~= "VariantB" then
        return "Control"
    end
    return a1
end

function u0.GetCanBuyProduct(a1, a2) -- Line: 131 -- types: a1: string?, a2: string
    local v1 = string.sub(a2, 1, 10) == "Treadmill_"
    local v2 = string.sub(a2, 1, 6) == "Trail_"
    if not v1 and not v2 then
        return true
    end
    if a1 == nil then
        return false
    end
    local v3 = true
    if a1 == "VariantB" then
        v3 = true
        if a2 ~= "Treadmill_AstralTreadmill" then
            v3 = true
            if a2 ~= "Treadmill_GuardianTreadmill" then
                v3 = a2 == "Trail_MoonbloomTrail"
            end
        end
    end
    return v3
end

function u0.GetPlayerGroup(a1) -- Line: 146 -- upvalues: u0 (val) -- types: a1: userdata
    if a1:GetAttribute(u0.ReadyAttribute) ~= true then
        return nil
    end
    return u0.NormalizeGroup(a1:GetAttribute(u0.GroupAttribute))
end

function u0.GetShownAmount(a1, a2) -- Line: 153 -- upvalues: u0 (val) -- types: a1: userdata, a2: number
    if a1:GetAttribute(u0.ReadyAttribute) ~= true then
        return nil
    end
    local Attribute = a1:GetAttribute(u0.AmountAttributePrefix .. a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return nil
end

return u0