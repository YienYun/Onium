-- Script path: ReplicatedStorage.Shared.Modules.AssetDisplayText
-- Decompile time: 3.31 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local t = require(ReplicatedStorage.Packages.t)
local u23 = {["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;"}
local u28 = {}

local function escape(a1) -- Line: 21 -- upvalues: u23 (val) -- types: a1: string
    return (a1:gsub("[&<>\"]", u23))
end

local function colourRun(a1) -- Line: 23 -- upvalues: Mutations (val), u23 (val) -- types: a1: string
    local v1 = Mutations.Get(a1)
    return v1 and ("<font color=\"#%*\">%*</font>"):format(v1.Tint:ToHex(), (v1.Label:gsub("[&<>\"]", u23)))
end

function u28.IsDroppable(a1) -- Line: 28 -- upvalues: Mutations (val) -- types: a1: string?
    local v1 = false
    if typeof(a1) == "string" then
        v1 = false
        if a1 ~= "" then
            v1 = 0 < (Mutations.RollChanceOf(a1))
        end
    end
    return v1
end

function u28.FirstDroppable(a1, a2) -- Line: 34 -- upvalues: u28 (val) -- types: a1: string?, a2: table?
    local v1
    local v2 = if typeof(a2) ~= "table" then {} else a2
    local v3 = nil
    local v4 = #v2
    for i = 0, v4 do
        v1 = if i ~= 0 then v2[i] else a1
        if u28.IsDroppable(v1) then
            return v1
        end
    end
    return v3
end

function u28.Compose(a1, a2, a3) -- Line: 49 -- upvalues: Mutations (val) -- types: a1: string, a2: table, a3: string?
    local v1 = Mutations.Sanitize(a2, a3)
    local v2 = table.create(#v1)
    for i, v in ipairs(v1) do
        v2[i] = (Mutations.LabelOf(v))
    end
    if #v1 == 0 then
        return a1
    end
    return (("%* %*"):format(table.concat(v2, " + "), a1))
end

function u28.WithMass(a1, a2, a3, a4) -- Line: 60
    -- upvalues: u28 (val)
    return string.format("%s (%.2f kg)", u28.Compose(a1, a2, a3), a4)
end

function u28.ForRecord(a1) -- Line: 64 -- upvalues: AssetItem (val), Assets (val), u28 (val)
    assert((AssetItem.AssetItemData(a1)))
    return u28.Compose(Assets.Directory[a1.Category].DisplayName or "Unknown", a1.Mutations, a1.BaseMutation)
end

function u28.MutationRun(a1, a2) -- Line: 73
    -- upvalues: t (val), Mutations (val), u23 (val)
    local v1, v2
    t.strict(t.table)(a1)
    t.strict(t.optional(t.string))(a2)
    local v3 = {}
    for i, j in Mutations.Sanitize(a1, a2) do
        v2 = #v3 + 1
        v1 = Mutations.Get(j)
        v3[v2] = v1 and ("<font color=\"#%*\">%*</font>"):format(v1.Tint:ToHex(), (v1.Label:gsub("[&<>\"]", u23)))
    end
    if #v3 == 0 then
        return nil
    end
    return (table.concat(v3, ", "))
end

return u28