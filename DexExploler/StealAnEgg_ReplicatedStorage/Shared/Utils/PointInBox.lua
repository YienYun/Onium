-- Script path: ReplicatedStorage.Shared.Utils.PointInBox
-- Decompile time: 0.65 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u12 = t.strict(t.CFrame)
local u15 = t.strict(t.Vector3)
return function(a1, a2, a3) -- Line: 15 -- upvalues: u12 (val), u15 (val) -- types: a1: userdata, a2: vector, a3: vector
    u12(a1)
    u15(a2)
    u15(a3)
    local v1 = a1:PointToObjectSpace(a3):Abs()
    local v2 = a2 / 2
    return v1:Max(v2) == v2
end