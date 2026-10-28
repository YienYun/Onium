-- Script path: ReplicatedStorage.CmdrClient.Types.URL
-- Decompile time: 0.64 ms

local Util = require(script.Parent.Parent.Shared.Util)
local u7 = {}

function u7.Validate(a1) -- Line: 4
    if a1:match("^https?://.+$") then
        return true
    end
    return false, "URLs must begin with http:// or https://"
end

function u7.Parse(a1) -- Line: 12
    return a1
end

return function(a1) -- Line: 17 -- upvalues: u7 (val), Util (val)
    a1:RegisterType("url", u7)
    a1:RegisterType("urls", (Util.MakeListableType(u7)))
end