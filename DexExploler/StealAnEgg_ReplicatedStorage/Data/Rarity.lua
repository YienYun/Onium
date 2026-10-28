-- Script path: ReplicatedStorage.Data.Rarity
-- Decompile time: 2.08 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u9 = {
    "BrainrotGod",
    "Common",
    "Cosmic",
    "Divine",
    "Epic",
    "Eternal",
    "Legendary",
    "LightDark",
    "Limited",
    "Mythic",
    "Rainbow",
    "Rare",
    "Secret",
    "SuperRare",
    "Titan",
    "Transcendent",
    "Uncommon",
}
local u27 = {Prismatic = "Rainbow"}
local u40 = t.interface({
    _id = t.string,
    DisplayName = t.string,
    Rank = t.integer,
    Color = t.Color3,
    RarityGradient = t.instanceIsA("UIGradient"),
    ItemTemplate = t.instanceIsA("TextButton"),
})

local function byName(a1, a2) -- Line: 75 -- types: a1: userdata, a2: userdata
    return a1.Name < a2.Name
end

local u46 = (function(a1) -- Line: 79 -- upvalues: byName (val), u40 (val), u9 (val), u27 (val) -- types: a1: userdata
    local v1, v2, v3
    local Children = a1:GetChildren()
    table.sort(Children, byName)
    local v4 = {}
    local v5 = nil
    local v6 = nil
    for i, j in Children, v5, v6 do
        if j:IsA("ModuleScript") then
            v2 = require(j)
            v3, v1 = u40(v2)
            if not v3 then
                error((("rarity config %* is malformed: %*"):format(j.Name, v1)))
            end
            if v2._id ~= j.Name then
                error((("rarity config %* declares _id \"%*\""):format(j.Name, v2._id)))
            end
            v4[j.Name] = v2
        end
    end
    for k, n in u9 do
        if v4[n] == nil then
            error((("rarity tier \"%*\" has no config module"):format(n)))
        end
    end
    for m, i5 in u27 do
        v4[m] = v4[i5]
    end
    return table.freeze(v4)
end)(script.Configs)
return table.freeze({
    Rarities = u46,
    Get = function(a1) -- Line: 117 -- upvalues: u46 (val) -- types: a1: string
        local v1 = u46[a1]
        if v1 == nil then
            error(("\"%*\" is not a registered rarity tier"):format(a1), 2)
        end
        return v1
    end,
    RarityNameExists = function(a1) -- Line: 125 -- upvalues: u46 (val) -- types: a1: string
        if u46[a1] ~= nil then
            return true
        end
        return false, (("\"%*\" is not a registered rarity tier"):format(a1))
    end,
})