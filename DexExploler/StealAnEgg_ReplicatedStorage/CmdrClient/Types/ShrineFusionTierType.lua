-- Script path: ReplicatedStorage.CmdrClient.Types.ShrineFusionTierType
-- Decompile time: 0.68 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShrineFusionRules = require(ReplicatedStorage.Shared.Util.ShrineFusionRules)
local u10 = {"All"}
for i, j in ShrineFusionRules.Tiers do
    table.insert(u10, j)
end
return function(a1) -- Line: 10 -- upvalues: u10 (val)
    a1:RegisterType("shrineFusionTier", (a1.Cmdr.Util.MakeEnumType("ShrineFusionTier", u10)))
end