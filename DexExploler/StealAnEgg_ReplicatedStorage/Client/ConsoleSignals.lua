-- Script path: ReplicatedStorage.Client.ConsoleSignals
-- Decompile time: 0.29 ms

local Signal = require(game:GetService("ReplicatedStorage").Packages.Signal)
return table.freeze({ButtonDown = Signal.new(), ButtonUp = Signal.new()})