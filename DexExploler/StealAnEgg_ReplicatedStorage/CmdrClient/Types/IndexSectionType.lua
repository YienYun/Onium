-- Script path: ReplicatedStorage.CmdrClient.Types.IndexSectionType
-- Decompile time: 1.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Areas = require(ReplicatedStorage.Data.Areas)
local u9 = {}
for k in pairs(Areas.Directory) do
    table.insert(u9, k)
end
table.sort(u9, function(a1, a2) -- Line: 9 -- upvalues: Areas (val)
    local v1 = Areas.GetProgressionOrder(Areas.Directory[a1])
    local v2 = Areas.GetProgressionOrder(Areas.Directory[a2])
    if v1 ~= v2 then
        return v1 < v2
    end
    return a1 < a2
end)
for i, j in {"LimitedEgg", "LuminousEgg", "MonsterEgg", "BrainrotEgg", "Rift", "DrScramble", "HalloweenPart1"} do
    table.insert(u9, j)
end
return function(a1) -- Line: 22 -- upvalues: u9 (val)
    a1:RegisterType("indexSection", (a1.Cmdr.Util.MakeEnumType("IndexSection", u9)))
end