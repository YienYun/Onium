-- Script path: ReplicatedStorage.Data.Currency
-- Decompile time: 2.18 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Data.Rarity)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.interface({
    Single = t.interface({
        Ids = t.array(t.string),
        Data = t.interface({Speed = t.array(t.number), Volume = t.number}),
    }),
})
local u52 = t.interface({
    DisplayName = t.string,
    Rarity = t.optional(t.table),
    Desc = t.optional(t.string),
    Icon = t.optional(t.string),
    Sounds = t.optional(v1),
    CollectDistanceOverride = t.optional(t.numberPositive),
    PickupDistanceOverride = t.optional(t.numberPositive),
    _id = t.string,
})

local function byName(a1, a2) -- Line: 52 -- types: a1: userdata, a2: userdata
    return a1.Name < a2.Name
end

local u58 = (function(a1) -- Line: 56 -- upvalues: byName (val), u52 (val) -- types: a1: userdata
    local v1, v2, v3
    local Children = a1:GetChildren()
    table.sort(Children, byName)
    local v4 = {}
    local v5 = nil
    local v6 = nil
    for i, j in Children, v5, v6 do
        if j:IsA("ModuleScript") then
            v2 = require(j)
            v3, v1 = u52(v2)
            if not v3 then
                error((("currency config %* is malformed: %*"):format(j.Name, v1)))
            end
            if v2._id ~= j.Name then
                error((("currency config %* declares _id \"%*\""):format(j.Name, v2._id)))
            end
            v4[j.Name] = v2
        end
    end
    return table.freeze(v4)
end)(script.Configs)
return table.freeze({
    Directory = u58,
    Get = function(a1) -- Line: 85 -- upvalues: u58 (val) -- types: a1: string
        local v1 = u58[a1]
        if v1 == nil then
            error(("no currency is registered under \"%*\""):format(a1), 2)
        end
        return v1
    end,
    CurrencyNameExists = function(a1) -- Line: 93 -- upvalues: u58 (val) -- types: a1: string
        if u58[a1] ~= nil then
            return true
        end
        return false, (("no currency is registered under \"%*\""):format(a1))
    end,
})