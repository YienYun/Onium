-- Script path: ReplicatedStorage.UserGenerated.Collections.DropTable
-- Decompile time: 3.85 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local u17 = require(ReplicatedStorage.UserGenerated.Randoms.ISAAC).Unique()
local u22 = Asserts.Table({Weight = Asserts.FinitePositive, Value = Asserts.Any})
local v1 = Asserts.Table({
    Weight = Asserts.FinitePositive,
    Chance = Asserts.Range(0, 1),
    Value = Asserts.Any,
})
local v2 = {}

local function Search(a1, a2) -- Line: 74 -- types: a1: table, a2: number
    local v1
    local v2 = 1
    local v3 = #a1
    local v4, v5 = a1, a2
    while v2 < v3 do
        v1 = v2 + (v3 - v2) // 2
        if not (v5 < v4[v1]) then
            v2 = v1 + 1
        else
            v3 = v1
        end
    end
    return v2
end

function v2.Next(a1) -- Line: 88 -- upvalues: u17 (val), Search (val)
    local v1 = a1.Entries[(Search(a1.Uppers, a1.TotalWeight * (u17:NextDouble())))]
    return v1.Value, v1
end

function v2.Pick(a1, a2) -- Line: 100 -- upvalues: Search (val)
    local v1 = false
    if a2 >= 0 then
        v1 = a2 <= 1
    end
    assert(v1)
    v1 = a1.Entries[(Search(a1.Uppers, a1.TotalWeight * a2))]
    return v1.Value, v1
end

local u41 = table.freeze({__index = table.freeze(v2)})

local function CompareOrderedEntry(a1, a2) -- Line: 113 -- types: a1: table, a2: table
    if a1.Weight ~= a2.Weight then
        return a1.Weight < a2.Weight
    end
    return a1.Index < a2.Index
end

local function new(a1) -- Line: 121
    -- upvalues: Asserts (val), u22 (val), CompareOrderedEntry (val), u41 (val)
    local Weight, v1
    Asserts.Array(u22)(a1)
    local v2 = #a1
    assert(v2 > 0)
    local v3 = {}
    for i, v in ipairs(a1) do
        table.insert(v3, {Index = i, Weight = v.Weight})
    end
    table.sort(v3, CompareOrderedEntry)
    local v4 = 0
    local v5 = table.create(v2, 0)
    v2 = {}
    for i2, i3 in ipairs(v3) do
        v1 = a1[i3.Index]
        Weight = v1.Weight
        v4 = v4 + Weight
        v5[i2] = v4
        table.insert(v2, {Chance = 0, Weight = Weight, Value = v1.Value})
    end
    table.freeze(v5)
    for i4, j in ipairs(v2) do
        j.Chance = j.Weight / v4
        table.freeze(j)
    end
    table.freeze(v2)
    v3 = {TotalWeight = v4, Entries = v2, Uppers = v5}
    v5 = setmetatable(v3, u41)
    table.freeze(v5)
    return v5
end

local u54 = table.freeze({
    __index = table.freeze({
        Add = function(a1, a2, a3) -- Line: 209 -- upvalues: Asserts (val)
            Asserts.FinitePositive(a2)
            a1.AssertValue(a3)
            table.insert(a1.Entries, {Weight = a2, Value = a3})
            return a1
        end,
        Build = function(a1) -- Line: 219 -- upvalues: new (val)
            return (new(a1.Entries))
        end,
    }),
})
return table.freeze({
    new = new,
    IsA = function(a1) -- Line: 172 -- upvalues: u41 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u41
        end
        return v1
    end,
    Assert = function(a1) -- Line: 176 -- upvalues: u41 (val)
        if type(a1) ~= "table" then
            error("table", 2)
        end
        if (getmetatable(a1)) ~= u41 then
            error("DropTable", 2)
        end
        return a1
    end,
    AssertEntry = v1,
    Builder = function(a1) -- Line: 225 -- upvalues: Asserts (val), u54 (val) -- types: a1: function
        Asserts.Function(a1)
        local v1 = {AssertValue = a1, Entries = {}}
        local v2 = setmetatable(v1, u54)
        table.freeze(v2)
        return v2
    end,
    IsABuilder = function(a1) -- Line: 236 -- upvalues: u54 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u54
        end
        return v1
    end,
    AssertBuilder = function(a1) -- Line: 240 -- upvalues: u54 (val)
        if type(a1) ~= "table" then
            error("table", 2)
        end
        if (getmetatable(a1)) ~= u54 then
            error("table", 2)
        end
        return a1
    end,
    AssertBuilderEntry = u22,
})