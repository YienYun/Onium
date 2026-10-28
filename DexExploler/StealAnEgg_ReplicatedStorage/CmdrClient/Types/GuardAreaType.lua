-- Script path: ReplicatedStorage.CmdrClient.Types.GuardAreaType
-- Decompile time: 0.98 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Areas = require(ReplicatedStorage.Data.Areas)
local u9 = {}
for k in pairs(Areas.Directory) do
    table.insert(u9, k)
end
table.sort(u9, function(a1, a2) -- Line: 10 -- upvalues: Areas (val)
    local v1 = Areas.GetProgressionOrder(Areas.Directory[a1])
    local v2 = Areas.GetProgressionOrder(Areas.Directory[a2])
    if v1 ~= v2 then
        return v1 < v2
    end
    return a1 < a2
end)
return function(a1) -- Line: 19 -- upvalues: u9 (val)
    a1:RegisterType("guardArea", (a1.Cmdr.Util.MakeEnumType("GuardArea", u9)))
end