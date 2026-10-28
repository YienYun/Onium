-- Script path: ReplicatedStorage.CmdrClient.Types.AssetDisplayNameType
-- Decompile time: 1.87 ms

local DisplayName
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local v1 = {}
for i in Assets.Directory do
    table.insert(v1, i)
end
table.sort(v1)
local u23 = {}
local u24 = {}
for j, k in v1 do
    DisplayName = Assets.Directory[k].DisplayName
    if type(DisplayName) == "string" and DisplayName ~= "" and u24[DisplayName] == nil then
        u24[DisplayName] = k
        table.insert(u23, DisplayName)
    end
end
for n, m in v1 do end
table.sort(u23)
return function(a1) -- Line: 37 -- upvalues: u23 (val), u24 (val)
    local u6 = a1.Cmdr.Util.MakeEnumType("AssetDisplayName", u23)
    a1:RegisterType("assetDisplayName", {
        Validate = u6.Validate,
        Autocomplete = u6.Autocomplete,
        Parse = function(a1) -- Line: 42 -- upvalues: u24 (upval), u6 (val)
            return u24[u6.Parse(a1)]
        end,
    })
end