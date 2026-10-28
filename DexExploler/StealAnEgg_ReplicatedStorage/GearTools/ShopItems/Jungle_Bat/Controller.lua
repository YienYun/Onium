-- Script path: ReplicatedStorage.GearTools.ShopItems.Jungle Bat.Controller
-- Decompile time: 0.62 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = require(ReplicatedStorage.Shared.Modules.BatController.Client)
local Gears = require(ReplicatedStorage.Data.Gears)
local Parent = script.Parent
local Attribute = Parent:GetAttribute("GearName")
assert(typeof(Attribute) == "string", "Bat Tool requires a GearName attribute")
Client.new(Parent, (assert(Gears.Directory[Attribute].BatControllerData, (("%* requires BatControllerData"):format(Attribute)))))