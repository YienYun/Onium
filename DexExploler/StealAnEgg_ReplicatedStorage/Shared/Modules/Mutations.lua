-- Script path: ReplicatedStorage.Shared.Modules.Mutations
-- Decompile time: 7.74 ms

local Id, v1, v2
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Catalog = require(script.Catalog)
local u184 = require(ReplicatedStorage.Packages.Log).new()
local Types = require(script.Types)
local t = require(ReplicatedStorage.Packages.t)
local u179 = require(script.Visuals)
local u159 = {}
local u162 = {}
local v3 = {}
local v4 = 0
local v5 = nil
local v6 = nil
for i, j in Catalog, v5, v6 do
    v2 = i == j.Id
    Id = j.Id
    assert(v2, (("Mutations | Catalog key \"%*\" does not match its Id \"%*\""):format(i, Id)))
    if Constants.IS_STUDIO then
        v1, v2 = Types.MutationSpec(j)
        assert(v1, (("Mutations | \"%*\" does not match the MutationSpec schema: %*"):format(i, v2)))
    end
    u159[i] = true
    u162[i] = i
    v4 = v4 + j.RollWeight
    table.insert(v3, (table.freeze({i, j.RollWeight})))
end
local v7 = math.max(0, 100 - v4)
if Constants.IS_STUDIO then
    v6 = ("Mutations | Roll weights total %*, which leaves no room for \"None\""):format(v4)
    assert(v7 > 0, v6)
end
table.insert(v3, (table.freeze({"None", v7})))
table.freeze(u159)
table.freeze(u162)
table.freeze(v3)
local u95 = {NO_MUTATION = "None", TOTAL_ROLL_WEIGHT = 100, IdSet = u159}

function u95.All() -- Line: 72 -- upvalues: Catalog (val)
    return Catalog
end

function u95.Ids() -- Line: 76 -- upvalues: u162 (val)
    return u162
end

function u95.IsKnown(a1) -- Line: 80 -- upvalues: t (val), u159 (val) -- types: a1: string
    t.strict(t.string)(a1)
    return u159[a1] == true
end

function u95.Get(a1) -- Line: 87 -- upvalues: Catalog (val), u184 (val) -- types: a1: string
    local v1 = Catalog[a1]
    if v1 then
        return v1
    end
    ;(u184:AtWarning()):Log((("Mutations.Get | Unknown mutation \"%*\""):format((tostring(a1)))))
    return nil
end

function u95.LabelOf(a1) -- Line: 99 -- upvalues: t (val), Catalog (val) -- types: a1: string
    t.strict(t.string)(a1)
    local v1 = Catalog[a1]
    if v1 then
        return v1.Label
    end
    return a1
end

function u95.RollTable() -- Line: 107 -- upvalues: Catalog (val)
    local v1 = {}
    local v2 = 0
    for i, j in Catalog do
        v2 = v2 + j.RollWeight
        table.insert(v1, {i, j.RollWeight})
    end
    table.insert(v1, {"None", (math.max(0, 100 - v2))})
    return v1
end

function u95.RollChanceOf(a1) -- Line: 121 -- upvalues: Catalog (val) -- types: a1: string
    local v1 = Catalog[a1]
    if v1 and not (v1.RollWeight <= 0) then
        return v1.RollWeight / 100
    end
    return 0
end

function u95.Sanitize(a1, a2) -- Line: 133 -- upvalues: u159 (val) -- types: a1: table?, a2: string?
    local u2 = {}
    local u3 = {}

    local function include(a1) -- Line: 137 -- upvalues: u3 (val), u159 (upval), u2 (val) -- types: a1: string?
        if typeof(a1) == "string" and not u3[a1] and u159[a1] then
            u3[a1] = true
            table.insert(u2, a1)
            return
        end
    end

    if typeof(a2) == "string" and not u3[a2] and u159[a2] then
        u3[a2] = true
        table.insert(u2, a2)
    end
    if typeof(a1) == "table" then
        for i, v in ipairs(a1) do
            if typeof(v) == "string" and not u3[v] and u159[v] then
                u3[v] = true
                table.insert(u2, v)
            end
        end
    end
    return u2
end

function u95.EggModelName(a1, a2) -- Line: 157 -- upvalues: u95 (val), Catalog (val) -- types: a1: table?, a2: string?
    local v1
    for i, j in u95.Sanitize(a1, a2) do
        v1 = Catalog[j]
        if v1 and v1.EggModelName then
            return v1.EggModelName
        end
    end
    return nil
end

function u95.EggDisplayName(a1, a2) -- Line: 169 -- upvalues: u95 (val), Catalog (val) -- types: a1: table?, a2: string?
    local v1
    for i, j in u95.Sanitize(a1, a2) do
        v1 = Catalog[j]
        if v1 and v1.EggDisplayName then
            return v1.EggDisplayName
        end
    end
    return nil
end

function u95.EggIcon(a1, a2) -- Line: 181 -- upvalues: u95 (val), Catalog (val) -- types: a1: table?, a2: string?
    local v1
    for i, j in u95.Sanitize(a1, a2) do
        v1 = Catalog[j]
        if v1 and v1.EggIcon then
            return v1.EggIcon
        end
    end
    return nil
end

function u95.EarningsFor(a1) -- Line: 194 -- upvalues: Catalog (val), u184 (val) -- types: a1: table
    local v1
    local v2 = 1
    for i, j in a1 do
        v1 = Catalog[j]
        if not v1 then
            (u184:AtError()):Log((("Mutations.EarningsFor | Unknown mutation \"%*\""):format((tostring(j)))))
        else
            v2 = v2 + math.max(0, v1.EarningsScalar - 1)
        end
    end
    return (math.max(1, v2))
end

function u95.RarityFactorFor(a1, a2) -- Line: 211 -- upvalues: u95 (val) -- types: a1: table?, a2: string?
    local v1
    local v2 = 1
    for i, j in u95.Sanitize(a1, a2) do
        v1 = u95.RollChanceOf(j)
        if v1 > 0 then
            v2 = v2 * (1 / v1)
        end
    end
    return v2
end

function u95.ApplyTo(a1, a2, a3) -- Line: 225
    -- upvalues: t (val), Catalog (val), u179 (val)
    t.strict(t.Instance)(a1)
    t.strict(t.string)(a2)
    t.strict(t.optional(t.number))(a3)
    local u35 = assert(Catalog[a2], (("Mutations.ApplyTo | Unknown mutation \"%*\""):format(a2)))
    local u39 = u179.GetFXPart(a1)
    if not u39 then
        return
    end
    local u44 = u179.ShouldApplyMetalCombo(a1, a2)
    u179.WithVisualRandom(if a3 == nil then nil else Random.new(u179.SeedFor(a3, a2)), function() -- Line: 243 -- upvalues: u35 (val), a1 (val), u39 (val), u44 (val), a3 (val), u179 (upval)
        u35:Apply(a1, u39)
        if u44 then
            local v1 = assert(a3, "A Golden and Silver combination requires a visual seed")
            u179.ApplyMetalCombo(a1, v1)
        end
    end)
end

function u95.ClearFrom(a1, a2) -- Line: 254
    -- upvalues: t (val), Catalog (val), u179 (val)
    t.strict(t.Instance)(a1)
    t.strict(t.string)(a2)
    local v1 = assert(Catalog[a2], (("Mutations.ClearFrom | Unknown mutation \"%*\""):format(a2)))
    local v2 = u179.GetFXPart(a1)
    if not v2 then
        return
    end
    v1:Clear(a1, v2)
end

function u95.ClearAllFrom(a1) -- Line: 268 -- upvalues: t (val), u179 (val), Catalog (val) -- types: a1: userdata
    t.strict(t.Instance)(a1)
    local u11 = u179.GetFXPart(a1)
    if not u11 then
        return
    end
    for i, j in Catalog do
        task.spawn(function() -- Line: 278 -- upvalues: j (val), a1 (val), u11 (val)
            j:Clear(a1, u11)
        end)
    end
end

return u95