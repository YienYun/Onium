-- Script path: ReplicatedStorage.Client.GuardTutorialPresentation.TutorialProp
-- Decompile time: 1.01 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tutorial = ReplicatedStorage.Assets.UI.Tutorial
local u18 = Log.new()
return {
    Clone = function(a1, a2) -- Line: 16 -- upvalues: Trove (val), Tutorial (val) -- types: a1: string, a2: string
        local v1 = Trove.new()
        local v2 = Tutorial[a1]:Clone()
        v2.Name = a2
        v1:Add(v2)
        return v2, v1
    end,
    Teardown = function(a1, a2) -- Line: 25 -- upvalues: u18 (val) -- types: a1: string
        return function() -- Line: 26 -- upvalues: u18 (upval), a1 (val), a2 (val)
            (u18:AtTrace()):Log(a1)
            a2:Destroy()
        end
    end,
}