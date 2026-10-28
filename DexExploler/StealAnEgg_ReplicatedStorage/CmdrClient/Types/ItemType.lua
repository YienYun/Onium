-- Script path: ReplicatedStorage.CmdrClient.Types.ItemType
-- Decompile time: 0.50 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminItemCatalog = require(ReplicatedStorage.Shared.AdminItemCatalog)
return function(a1) -- Line: 5 -- upvalues: AdminItemCatalog (val)
    local u7 = a1.Cmdr.Util.MakeEnumType("Item", AdminItemCatalog.Choices)
    a1:RegisterType("item", {
        Validate = u7.Validate,
        Autocomplete = u7.Autocomplete,
        Parse = function(a1) -- Line: 11 -- upvalues: AdminItemCatalog (upval), u7 (val)
            return AdminItemCatalog.IdByChoice[u7.Parse(a1)]
        end,
    })
end