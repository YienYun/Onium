-- Script path: ReplicatedStorage.Controllers.Game.Eggs.HotbarImagePreloadController
-- Decompile time: 0.49 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HotbarImagePreloadController = require(ReplicatedStorage.Client.HotbarImagePreloadController)
local Trove = require(ReplicatedStorage.Packages.Trove)
return {
    Start = function() -- Line: 10 -- upvalues: Trove (val), HotbarImagePreloadController (val)
        local v1 = Trove.new()
        v1:Add((HotbarImagePreloadController.new())):Start()
        v1:AttachToInstance(script)
    end,
}