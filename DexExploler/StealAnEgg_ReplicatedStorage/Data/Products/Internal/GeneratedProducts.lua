-- Script path: ReplicatedStorage.Data.Products.Internal.GeneratedProducts
-- Decompile time: 2.24 ms

local ProductId_2, ProductId_3
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trails = require(ReplicatedStorage.Data.Trails)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
require(script.Parent.ProductTypes)
local v1 = require(script.Parent.Parent.Builders.Trail)
local Treadmill = require(script.Parent.Parent.Builders.Treadmill)
local TreadmillSpeedEquivalent = require(script.Parent.Parent.Builders.TreadmillSpeedEquivalent)
local v2 = table.freeze({
    table.freeze({ProductName = "TreadmillSpeed_5Minutes", DurationSeconds = 300, ProductId = 3612508008}),
    table.freeze({ProductName = "TreadmillSpeed_30Minutes", DurationSeconds = 1800, ProductId = 3612508088}),
    table.freeze({ProductName = "TreadmillSpeed_1Hour", DurationSeconds = 3600, ProductId = 3612508192}),
    (table.freeze({ProductName = "TreadmillSpeed_4Hours", DurationSeconds = 14400, ProductId = 3612508244})),
})
local v3 = {}
for i, j in Treadmills.Directory do
    ProductId_3 = j.ProductId
    if type(ProductId_3) == "number" then
        table.insert(v3, (Treadmill(("Treadmill_%*"):format(i), i, ProductId_3)))
    end
end
for k, n in Trails.Directory do
    ProductId_2 = n.ProductId
    if type(ProductId_2) == "number" then
        table.insert(v3, (v1(("Trail_%*"):format(k), k, ProductId_2)))
    end
end
local v4 = nil
local v5 = nil
for m, i5 in v2, v4, v5 do
    assert(0 < i5.ProductId, (("Treadmill speed product \"%*\" must have a positive ProductId"):format(i5.ProductName)))
    table.insert(v3, (TreadmillSpeedEquivalent(i5.ProductName, i5.ProductId, i5.DurationSeconds)))
end
return table.freeze({Records = table.freeze(v3), TreadmillSpeedEquivalentOffers = v2})