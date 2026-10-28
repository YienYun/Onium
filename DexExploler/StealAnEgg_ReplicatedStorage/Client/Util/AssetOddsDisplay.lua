-- Script path: ReplicatedStorage.Client.Util.AssetOddsDisplay
-- Decompile time: 3.15 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local u35 = t.strict(t.table)
local u38 = t.strict(v1)
local u39 = {}

local function skeletonFor(a1) -- Line: 33 -- types: a1: number
    if a1 < 1000 then
        return "."
    end
    local v1 = a1 / 1000 ^ math.floor((math.log10(a1)) / 3)
    if v1 < 10 then
        return ".##"
    end
    if v1 < 100 then
        return ".#"
    end
    return "."
end

local function compactOdds(a1) -- Line: 46 -- upvalues: Simple (val) -- types: a1: number
    local v1
    local v2 = math.max(1, a1)
    local v3 = 10 ^ (math.floor((math.log10(v2))) - 3 + 1)
    local v4 = math.floor(v2 / v3) * v3
    local lower = string.lower
    local FormatCompact = Simple.FormatCompact
    if not (v4 < 1000) then
        v3 = v4 / 1000 ^ math.floor((math.log10(v4)) / 3)
        v1 = if not (v3 < 10) then if not (v3 < 100) then "." else ".#" else ".##"
    else
        v1 = "."
    end
    return lower(FormatCompact(v4, v1))
end

function u39.Resolve(a1, a2) -- Line: 54 -- upvalues: u35 (val), Mutations (val) -- types: a1: table
    u35(a1)
    local v1 = nil
    local VisualOdds = a1.VisualOdds
    if typeof(VisualOdds) ~= "number" or not (VisualOdds > 0) then
        local DropWeight = a1.DropWeight
        if typeof(DropWeight) == "number" and DropWeight > 0 then
            v1 = 1 / DropWeight
        end
    else
        v1 = VisualOdds
    end
    if v1 ~= nil and a2 ~= nil then
        return v1 * Mutations.RarityFactorFor(a2.Mutations, a2.BaseMutation)
    end
    return v1
end

function u39.Describe(a1, a2, a3) -- Line: 75
    -- upvalues: u35 (val), u39 (val), Simple (val)
    local v1
    u35(a1)
    local v2 = u39.Resolve(a1, a3)
    if v2 == nil then
        return "1/?"
    end
    local v3 = math.max(1, v2)
    local v4 = 10 ^ (math.floor((math.log10(v3))) - 3 + 1)
    local v5 = math.floor(v3 / v4) * v4
    local lower = string.lower
    local FormatCompact = Simple.FormatCompact
    if not (v5 < 1000) then
        v4 = v5 / 1000 ^ math.floor((math.log10(v5)) / 3)
        v1 = if not (v4 < 10) then if not (v4 < 100) then "." else ".#" else ".##"
    else
        v1 = "."
    end
    return (("%*%*"):format(if not a2 then "1/" else "1 in ", (lower((FormatCompact(v5, v1))))))
end

function u39.DescribeItem(a1, a2, a3) -- Line: 90
    -- upvalues: AssetItem (val), u39 (val)
    assert((AssetItem.AssetItemData(a2)))
    return u39.Describe(a1, a3, {Mutations = a2.Mutations, BaseMutation = a2.BaseMutation})
end

function u39.Compact(a1) -- Line: 97 -- upvalues: u38 (val), compactOdds (val) -- types: a1: number
    u38(a1)
    return compactOdds(a1)
end

return u39