-- Script path: ReplicatedStorage.CmdrClient.Types.MutationType
-- Decompile time: 0.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local u10 = {}
local u11 = {}
for i, j in Mutations.All() do
    u11[j.Label] = i
    table.insert(u10, j.Label)
end
table.sort(u10)
return function(a1) -- Line: 13 -- upvalues: u10 (val), u11 (val)
    local u6 = a1.Cmdr.Util.MakeEnumType("Mutation", u10)
    local v1 = {
        Validate = u6.Validate,
        Autocomplete = u6.Autocomplete,
        Parse = function(a1) -- Line: 18 -- upvalues: u11 (upval), u6 (val)
            return u11[u6.Parse(a1)]
        end,
    }
    a1:RegisterType("mutation", v1)
    a1:RegisterType("mutations", (a1.Cmdr.Util.MakeListableType(v1)))
end