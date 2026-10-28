-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.SpeedLines
-- Decompile time: 0.44 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local SpeedLines = require(ReplicatedStorage.Client.SpeedLines)
require(ReplicatedStorage.Packages.Trove)
return {
    Run = function(a1, a2) -- Line: 18 -- upvalues: SpeedLines (val), GUI (val) -- types: a2: function
        SpeedLines.Run(a1, GUI.BeanstalkEventUI().SpeedLines, a2)
    end,
}