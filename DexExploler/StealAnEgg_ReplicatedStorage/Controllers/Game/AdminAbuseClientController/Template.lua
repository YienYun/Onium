-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Template
-- Decompile time: 0.58 ms

game:GetService("Debris")
game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
game:GetService("ServerStorage")
game:GetService("Workspace")
local u36 = require(ReplicatedStorage.Packages.Trove).new()
local u37 = false
return {
    StartEvent = function(a1, a2) -- Line: 26 -- upvalues: u36 (val), u37 (ref) -- types: a1: table, a2: number
        u36:Clean()
        u37 = true
    end,
    StopEvent = function(a1) -- Line: 31 -- upvalues: u36 (val), u37 (ref)
        u36:Clean()
        u37 = false
    end,
}