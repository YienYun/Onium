-- Script path: ReplicatedStorage.CmdrClient.Types.AssetNameType
-- Decompile time: 0.66 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local u9 = {}
for k in pairs(Assets.Directory) do
    table.insert(u9, k)
end
table.sort(u9)
return function(a1) -- Line: 12 -- upvalues: u9 (val)
    a1:RegisterType("assetName", (a1.Cmdr.Util.MakeEnumType("AssetName", u9)))
end