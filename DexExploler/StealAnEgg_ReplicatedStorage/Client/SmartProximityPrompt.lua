-- Script path: ReplicatedStorage.Client.SmartProximityPrompt
-- Decompile time: 0.55 ms

local FollowerLoop = require(script.FollowerLoop)
local SurfaceTracker = require(script.SurfaceTracker)
return {
    AttachToModel = function(a1, a2, a3) -- Line: 16
        -- upvalues: FollowerLoop (val), SurfaceTracker (val)
        FollowerLoop.Drop(a1)
        local v1 = a3 or {}
        if v1.MaxActivationDistance ~= nil then
            a1.MaxActivationDistance = v1.MaxActivationDistance
        end
        local v2 = FollowerLoop.MakeAnchor(v1.PartName, a2:GetPivot())
        local v3 = SurfaceTracker.new(a2, v2)
        a1.RequiresLineOfSight = false
        return FollowerLoop.Add(a1, a2, v2, v3, v1)
    end,
}