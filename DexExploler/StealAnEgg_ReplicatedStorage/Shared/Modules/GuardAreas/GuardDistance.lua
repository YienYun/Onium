-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardDistance
-- Decompile time: 0.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return {
    XZ = function(a1, a2) -- Line: 16 -- upvalues: t (val) -- types: a1: vector, a2: vector
        t.strict(t.Vector3)(a1)
        t.strict(t.Vector3)(a2)
        local v1 = a1 - a2
        return Vector3.new(v1.X, 0, v1.Z).Magnitude
    end,
}