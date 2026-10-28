-- Script path: ReplicatedStorage.Data.SamplePacks
-- Decompile time: 2.29 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local ScrambleRules = require(ReplicatedStorage.Shared.Util.ScrambleRules)
local u14 = {
    {ProductId = 3713243987, EventId = "DrScrambleOutbreak", Amount = 100, Label = "Sample Pack 1"},
    {ProductId = 3713244009, EventId = "DrScrambleOutbreak", Amount = 500, Label = "Sample Pack 2"},
    {ProductId = 3713244032, EventId = "DrScrambleOutbreak", Amount = 1500, Label = "Sample Pack 3"},
    {ProductId = 3714309175, EventId = "DrScrambleOutbreak", Amount = 3000, Label = "Sample Pack 4"},
}
local u24 = FastFlags.Replicated("Game.Scramble.SamplePacks", function(a1) -- Line: 42 -- upvalues: ScrambleRules (val) -- types: a1: table
    local v1
    local v2 = false
    if type(a1) == "table" then
        v2 = #a1 <= 32
    end
    assert(v2, "Scramble: invalid pack catalog")
    local v3 = {}
    local v4 = nil
    local v5 = nil
    for i, j in a1, v4, v5 do
        assert(type(j) == "table", "Scramble: invalid Sample pack")
        assert(ScrambleRules.Integer(j.ProductId, 1, 9000000000000) and not v3[j.ProductId], "Scramble: invalid product ID")
        assert(ScrambleRules.Integer(j.Amount, 1, ScrambleRules.MAX_SAMPLES), "Scramble: invalid Sample pack amount")
        v1 = false
        if type(j.EventId) == "string" then
            v1 = false
            if #j.EventId > 0 then
                v1 = #j.EventId <= 64
            end
        end
        assert(v1, "Scramble: invalid pack event")
        v1 = false
        if type(j.Label) == "string" then
            v1 = #j.Label <= 80
        end
        assert(v1, "Scramble: invalid pack label")
        v3[j.ProductId] = true
    end
    return a1
end, u14)
local u25 = {Offers = u14}

function u25.Get() -- Line: 77 -- upvalues: u24 (val), u14 (val)
    local v1 = {}
    local v2 = {}
    for i, j in u24:Get() do
        table.insert(v1, j)
        v2[j.ProductId] = true
    end
    for k, n in u14 do
        if not v2[n.ProductId] then
            table.insert(v1, n)
        end
    end
    return v1
end

function u25.Find(a1) -- Line: 93 -- upvalues: u25 (val) -- types: a1: number
    for i, j in u25.Get() do
        if j.ProductId == a1 then
            return j
        end
    end
    return nil
end

function u25.getChangedSignal() -- Line: 102 -- upvalues: u24 (val)
    return u24.Changed
end

return table.freeze(u25)