-- Script path: ReplicatedStorage.Data.SpeedPacks
-- Decompile time: 1.48 ms

local u0 = {
    TestName = "SpeedPackSizingTest",
    AttributeKey = "Economy.SpeedPacks.Group",
    ReadyAttribute = "SpeedPacksReady",
    RevisionAttribute = "SpeedPackQuoteRevision",
    MaxAttribute = "SpeedPackAtMax",
    AmountPrefix = "SpeedPackAmount",
    Static = {150000, 1000000, 10000000, 50000000, 500000000, 1000000000},
    Prices = {79, 249, 699, 1499, 1999, 2999},
    ProductIds = {3611606545, 3611606516, 3611606528, 3611606552, 3611606562, 3611606539},
    Names = {
        "Speed Pack I",
        "Speed Pack II",
        "Speed Pack III",
        "Speed Pack IV",
        "Speed Pack V",
        "Speed Pack VI",
    },
}

function u0.FindSlot(a1) -- Line: 15 -- upvalues: u0 (val) -- types: a1: number
    return table.find(u0.ProductIds, a1)
end

function u0.GetShownAmount(a1, a2) -- Line: 18 -- upvalues: u0 (val) -- types: a1: userdata, a2: number
    if a1:GetAttribute(u0.ReadyAttribute) ~= true then
        return nil
    end
    local Attribute = a1:GetAttribute(u0.AmountPrefix .. a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return nil
end

function u0.ObserveShownAmount(a1, a2, a3) -- Line: 27
    -- upvalues: u0 (val)
    local u3 = {}
    for i, j in {u0.ReadyAttribute, u0.RevisionAttribute, u0.AmountPrefix .. a2} do
        table.insert(u3, ((a1:GetAttributeChangedSignal(j)):Connect(a3)))
    end
    a3()
    return function() -- Line: 33 -- upvalues: u3 (val)
        for i, j in u3 do
            j:Disconnect()
        end
    end
end

return u0