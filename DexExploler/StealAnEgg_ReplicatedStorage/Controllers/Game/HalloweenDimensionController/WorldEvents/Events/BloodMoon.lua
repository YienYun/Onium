-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.WorldEvents.Events.BloodMoon
-- Decompile time: 0.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Parent.Types)
local WaterTint = require(script.Parent.Parent.WaterTint)
local u31 = Color3.fromRGB(96, 4, 8)
local u36 = Color3.new(2.2, 0.25, 0.2)
return table.freeze({
    Preset = "HalloweenBloodMoon",
    Icon = "rbxassetid://85674946431202",
    Id = HalloweenDimension.WorldEvents.BloodMoon,
    MoonColor = Color3.fromRGB(200, 30, 30),
    Bind = function(a1, a2) -- Line: 23 -- upvalues: WaterTint (val), u31 (val), u36 (val) -- types: a1: userdata
        WaterTint.Bind(a1, a2, u31, u36)
    end,
})