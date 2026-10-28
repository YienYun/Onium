-- Script path: ReplicatedStorage.Client.Util.GunCatalog
-- Decompile time: 0.50 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gears = require(ReplicatedStorage.Data.Gears)
local u9 = {}
for k, v in pairs(Gears.Directory) do
    if v.ToolController == "Gun" then
        u9[#u9 + 1] = v._id
    end
end
table.freeze(u9)
return {
    ListGearNames = function() -- Line: 19 -- upvalues: u9 (val)
        return table.clone(u9)
    end,
}