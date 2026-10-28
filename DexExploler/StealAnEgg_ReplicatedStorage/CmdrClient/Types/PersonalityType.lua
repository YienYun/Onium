-- Script path: ReplicatedStorage.CmdrClient.Types.PersonalityType
-- Decompile time: 1.38 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Personalities = (require(ReplicatedStorage.Data.Assets)).Personalities
local u10 = {}
for k in pairs(Personalities.Personalities) do
    table.insert(u10, k)
end
table.sort(u10)
return function(a1) -- Line: 11 -- upvalues: u10 (val)
    a1:RegisterType("personality", (a1.Cmdr.Util.MakeEnumType("Personality", u10)))
end