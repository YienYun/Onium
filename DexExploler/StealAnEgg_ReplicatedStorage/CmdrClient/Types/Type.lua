-- Script path: ReplicatedStorage.CmdrClient.Types.Type
-- Decompile time: 0.91 ms

local Util = require(script.Parent.Parent.Shared.Util)
return function(a1) -- Line: 3 -- upvalues: Util (val)
    local v1 = {
        Transform = function(a1_2) -- Line: 5 -- upvalues: Util (upval), a1 (val)
            return Util.MakeFuzzyFinder(a1:GetTypeNames())(a1_2)
        end,
        Validate = function(a1) -- Line: 11
            return #a1 > 0, "No type with that name could be found."
        end,
        Autocomplete = function(a1) -- Line: 15
            return a1
        end,
        Parse = function(a1) -- Line: 19
            return a1[1]
        end,
    }
    a1:RegisterType("type", v1)
    a1:RegisterType("types", (Util.MakeListableType(v1)))
end