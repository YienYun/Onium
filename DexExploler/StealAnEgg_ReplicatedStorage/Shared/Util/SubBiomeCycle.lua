-- Script path: ReplicatedStorage.Shared.Util.SubBiomeCycle
-- Decompile time: 8.92 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local Areas = require(ReplicatedStorage.Data.Areas)
require(ReplicatedStorage.Data.Areas.Types)
local LiveEventFlags = require(ReplicatedStorage.Shared.Flags.LiveEventFlags)
local t = require(ReplicatedStorage.Packages.t)
local u41 = t.strict(t.string)
local u44 = t.strict(t.number)
local u45 = {}
local u46 = {}

local function hash(a1) -- Line: 34 -- types: a1: string
    local v1 = 2166136261
    local v2 = #a1
    for i = 1, v2 do
        v1 = bit32.bxor(v1, (string.byte(a1, i))) * 16777619 % 4294967296
    end
    return v1
end

local function variantsOf(a1) -- Line: 43 -- upvalues: Areas (val) -- types: a1: string
    local v1 = Areas.Directory[a1]
    if v1 == nil then
        return nil
    end
    local SubBiomes = v1.SubBiomes
    if SubBiomes ~= nil and #SubBiomes ~= 0 then
        return SubBiomes
    end
    return nil
end

function u46.OverrideAttributeName(a1) -- Line: 55 -- upvalues: u41 (val) -- types: a1: string
    u41(a1)
    return "SubBiomeOverride_" .. a1:gsub("[^%w]", "_")
end

function u46.LocalRevealAttributeName(a1) -- Line: 60 -- upvalues: u41 (val) -- types: a1: string
    u41(a1)
    return "SubBiomeLocalReveal_" .. a1:gsub("[^%w]", "_")
end

function u46.IsRotating(a1) -- Line: 65 -- upvalues: u41 (val), Areas (val) -- types: a1: string
    local v1
    u41(a1)
    local v2 = Areas.Directory[a1]
    if v2 ~= nil then
        local SubBiomes = v2.SubBiomes
        v1 = if SubBiomes == nil then nil else if #SubBiomes ~= 0 then SubBiomes else nil
    else
        v1 = nil
    end
    return v1 ~= nil
end

function u46.Variants(a1) -- Line: 70 -- upvalues: u41 (val), Areas (val) -- types: a1: string
    local v1
    u41(a1)
    local v2 = Areas.Directory[a1]
    if v2 ~= nil then
        local SubBiomes = v2.SubBiomes
        v1 = if SubBiomes == nil then nil else if #SubBiomes ~= 0 then SubBiomes else nil
    else
        v1 = nil
    end
    if not v1 then
        v1 = {}
    end
    return v1
end

function u46.ById(a1, a2) -- Line: 75 -- upvalues: u41 (val), u46 (val) -- types: a1: string, a2: string
    u41(a1)
    u41(a2)
    for i, j in u46.Variants(a1) do
        if j.Id == a2 then
            return j
        end
    end
    return nil
end

local function localRevealOf(a1) -- Line: 88 -- upvalues: Workspace (val), u46 (val) -- types: a1: string
    local Attribute = Workspace:GetAttribute((u46.LocalRevealAttributeName(a1)))
    if type(Attribute) == "string" then
        return (u46.ById(a1, Attribute))
    end
    return nil
end

local function revealStateOf(a1) -- Line: 93 -- upvalues: Areas (val), LiveEventFlags (val) -- types: a1: string
    local Reveal
    local v1 = Areas.Directory[a1]
    if (if v1 == nil then nil else v1.Reveal) == nil then
        return nil, nil
    end
    v1 = LiveEventFlags.Get(Reveal.Flag):Get()
    local v2 = Reveal
    if type(v1) == "table" then
        return v2, v1
    end
    return v2, nil
end

function u46.RevealPhaseAt(a1, a2) -- Line: 105
    -- upvalues: u41 (val), u44 (val), Areas (val), LiveEventFlags (val), Workspace (val), u46 (val), AreaEggCycle (val)
    local v1, v2
    u41(a1)
    u44(a2)
    local v3 = Areas.Directory[a1]
    local Reveal = if v3 == nil then nil else v3.Reveal
    if Reveal ~= nil then
        v3 = LiveEventFlags.Get(Reveal.Flag):Get()
        v1 = Reveal
        v2 = if type(v3) ~= "table" then nil else v3
    else
        v1 = nil
        v2 = nil
    end
    if v1 == nil then
        return nil
    end
    if v2 ~= nil then
        if (AreaEggCycle.ActivePeriodIndexAt(a2)) <= v2.RevealPeriod then
            return "RevealNight"
        end
        return "Open"
    end
    v1 = Workspace:GetAttribute((u46.LocalRevealAttributeName(a1)))
    if (if type(v1) ~= "string" then nil else u46.ById(a1, v1)) ~= nil then
        return "RevealNight"
    end
    return "Sealed"
end

function u46.RolledForPeriod(a1, a2) -- Line: 122
    -- upvalues: u41 (val), u44 (val), Areas (val)
    local v1
    u41(a1)
    u44(a2)
    local v2 = Areas.Directory[a1]
    if v2 ~= nil then
        local SubBiomes = v2.SubBiomes
        v1 = if SubBiomes == nil then nil else if #SubBiomes ~= 0 then SubBiomes else nil
    else
        v1 = nil
    end
    if v1 == nil then
        return nil
    end
    v2 = 0
    for i, j in v1 do
        v2 = v2 + j.Weight
    end
    if v2 <= 0 then
        return v1[1]
    end
    local new = Random.new
    local v3 = ("%*:%*"):format(a1, a2)
    local v4 = 2166136261
    local v5 = #v3
    for k = 1, v5 do
        v4 = bit32.bxor(v4, (string.byte(v3, k))) * 16777619 % 4294967296
    end
    local v6 = new(v4 % 2147483647):NextNumber() * v2
    for n, m in v1 do
        v6 = v6 - m.Weight
        if v6 <= 0 then
            return m
        end
    end
    return v1[#v1]
end

function u46.ForPeriod(a1, a2) -- Line: 150
    -- upvalues: u41 (val), u44 (val), Workspace (val), u46 (val), Areas (val), LiveEventFlags (val)
    local v1, v2
    u41(a1)
    u44(a2)
    local Attribute = Workspace:GetAttribute((u46.OverrideAttributeName(a1)))
    if type(Attribute) == "string" then
        v1 = u46.ById(a1, Attribute)
        if v1 ~= nil then
            return v1
        end
    end
    local Attribute_2 = Workspace:GetAttribute((u46.LocalRevealAttributeName(a1)))
    local v3 = if type(Attribute_2) ~= "string" then nil else u46.ById(a1, Attribute_2)
    if v3 ~= nil then
        return v3
    end
    v3 = Areas.Directory[a1]
    local Reveal = if v3 == nil then nil else v3.Reveal
    if Reveal ~= nil then
        v3 = LiveEventFlags.Get(Reveal.Flag):Get()
        v1 = Reveal
        v2 = if type(v3) ~= "table" then nil else v3
    else
        v1 = nil
        v2 = nil
    end
    if v1 ~= nil then
        local v4
        if v2 ~= nil then
            local WinnerPeriod = v2.WinnerPeriod or v2.RevealPeriod
            if a2 <= WinnerPeriod + 1 then
                v4 = u46.ById(a1, v2.Winner)
                if v4 ~= nil then
                    return v4
                end
            end
        else
            v4 = u46.ById(a1, v1.RevealSubBiome)
            if v4 ~= nil then
                return v4
            end
        end
    end
    local v5, v6 = a1, a2
    return u46.RolledForPeriod(v5, v6)
end

function u46.ActiveAt(a1, a2) -- Line: 188
    -- upvalues: u41 (val), u44 (val), u46 (val), AreaEggCycle (val)
    u41(a1)
    u44(a2)
    return u46.ForPeriod(a1, AreaEggCycle.ActivePeriodIndexAt(a2))
end

function u46.Active(a1) -- Line: 195 -- upvalues: u41 (val), u46 (val), Workspace (val) -- types: a1: string
    u41(a1)
    return u46.ActiveAt(a1, Workspace:GetServerTimeNow())
end

function u46.PoolDropTable(a1, a2) -- Line: 202 -- upvalues: u41 (val), u45 (val), Areas (val) -- types: a1: string
    u41(a1)
    local v1 = ("%*|%*"):format(a1, a2.Id)
    local v2 = u45[v1]
    if v2 ~= nil then
        return v2
    end
    local DropTable = a2.DropTable
    if DropTable ~= nil then
        u45[v1] = DropTable
        return DropTable
    end
    v2 = {}
    for i, j in a2.Pool do
        v2[j] = true
    end
    local v3 = Areas.Directory[a1]
    local v4 = {}
    for k, n in v3.DropTable do
        if v2[n[1]] then
            table.insert(v4, n)
        end
    end
    assert(#v4 > 0, (("Sub-biome \"%*\" of area \"%*\" has no pool entry in the area drop table"):format(a2.Id, a1)))
    u45[v1] = v4
    return v4
end

function u46.SetOverride(a1, a2) -- Line: 238
    -- upvalues: RunService (val), u41 (val), u46 (val), Workspace (val)
    assert(RunService:IsServer(), "Only the server may force a sub-biome")
    u41(a1)
    if a2 ~= nil then
        local v1 = ("Area \"%*\" has no sub-biome \"%*\""):format(a1, a2)
        assert(u46.ById(a1, a2) ~= nil, v1)
    end
    Workspace:SetAttribute(u46.OverrideAttributeName(a1), a2)
end

function u46.SetLocalReveal(a1, a2) -- Line: 251
    -- upvalues: RunService (val), u41 (val), u46 (val), Workspace (val)
    assert(RunService:IsServer(), "Only the server may set a local reveal")
    u41(a1)
    if a2 ~= nil then
        local v1 = ("Area \"%*\" has no sub-biome \"%*\""):format(a1, a2)
        assert(u46.ById(a1, a2) ~= nil, v1)
    end
    Workspace:SetAttribute(u46.LocalRevealAttributeName(a1), a2)
end

function u46.IsOverridden(a1) -- Line: 264 -- upvalues: u41 (val), Workspace (val), u46 (val) -- types: a1: string
    u41(a1)
    return type((Workspace:GetAttribute((u46.OverrideAttributeName(a1))))) == "string"
end

return table.freeze(u46)