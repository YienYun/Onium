-- Script path: ReplicatedStorage.Client.Gamepasses
-- Decompile time: 0.87 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local Save = require((ReplicatedStorage:WaitForChild("Shared")):WaitForChild("Save"))
return table.freeze({
    Owns = function(a1, a2) -- Line: 14
        -- upvalues: Gamepasses (val), Save (val), Players (val)
        local v1 = Gamepasses.Directory[a1]
        if v1 == nil then
            error(("\"%*\" is not a gamepass"):format((tostring(a1))), 2)
        end
        local v2 = Save.Await(a2 or Players.LocalPlayer)
        if v2 == nil then
            return false
        end
        local Gamepasses_2 = v2.Gamepasses
        local v3 = false
        if typeof(Gamepasses_2) == "table" then
            v3 = Gamepasses_2[v1.Name] == true
        end
        return v3
    end,
})