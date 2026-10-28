-- Script path: ReplicatedStorage.CmdrClient.Types.StoredKey
-- Decompile time: 0.86 ms

local Util = require(script.Parent.Parent.Shared.Util)
local u7 = {"^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$"}
return function(a1) -- Line: 10 -- upvalues: u7 (val), Util (val)
    local v1 = {
        Autocomplete = function(a1_2) -- Line: 12 -- upvalues: a1 (val)
            return a1.Cmdr.Util.MakeFuzzyFinder(a1.Cmdr.Util.DictionaryKeys(a1:GetStore("vars_used") or {}))(a1_2)
        end,
        Validate = function(a1) -- Line: 18 -- upvalues: u7 (upval)
            for i, v in ipairs(u7) do
                if a1:match(v) then
                    return true
                end
            end
            return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
        end,
        Parse = function(a1) -- Line: 28
            return a1
        end,
    }
    a1:RegisterType("storedKey", v1)
    a1:RegisterType("storedKeys", (Util.MakeListableType(v1)))
end