-- Script path: ReplicatedStorage.Shared.Eggs.EggPlacementRaycast
-- Decompile time: 0.87 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Input = require(ReplicatedStorage.Packages.Input)
local PlacedEggRenderer = require(script.Parent.PlacedEggRenderer)
local t = require(ReplicatedStorage.Packages.t)
local u21 = Input.Mouse.new()
local v1 = {}

local function placementRaycastParams(a1, a2) -- Line: 24
    -- upvalues: PlacedEggRenderer (val)
    local v1 = {a1}
    PlacedEggRenderer.AppendRaycastTargets(v1, a2)
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Include
    v2.FilterDescendantsInstances = v1
    v2.IgnoreWater = true
    return v2
end

function v1.Raycast(a1, a2) -- Line: 39
    -- upvalues: t (val), u21 (val), placementRaycastParams (val)
    t.strict(t.instanceIsA("BasePart"))(a1)
    t.strict(t.number)(a2)
    return u21:Raycast(placementRaycastParams(a1, a2), 500)
end

return v1