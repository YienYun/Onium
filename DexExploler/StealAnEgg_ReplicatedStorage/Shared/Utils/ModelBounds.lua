-- Script path: ReplicatedStorage.Shared.Utils.ModelBounds
-- Decompile time: 1.94 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PartBounds = require(ReplicatedStorage.Shared.Utils.PartBounds)

local function isBoxSubject(a1) -- Line: 13
    local v1 = false
    if typeof(a1) == "Instance" then
        v1 = a1:IsA("Model") or a1:IsA("Tool")
    end
    return v1
end

local function opaqueParts(a1) -- Line: 17 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            table.insert(v1, j)
        end
    end
    return v1
end

return function(a1) -- Line: 29 -- upvalues: opaqueParts (val), PartBounds (val) -- types: a1: userdata
    local v1 = false
    if typeof(a1) == "Instance" then
        v1 = a1:IsA("Model") or a1:IsA("Tool")
    end
    assert(v1, "ModelBounds needs a Model or a Tool")
    local CustomBoundingBox = a1:FindFirstChild("CustomBoundingBox", true)
    if CustomBoundingBox ~= nil and CustomBoundingBox:IsA("BasePart") then
        return CustomBoundingBox.CFrame, CustomBoundingBox.Size
    end
    local Pivot = a1:GetPivot()
    v1 = opaqueParts(a1)
    if #v1 == 0 then
        return Pivot, (Vector3.new(0, 0, 0))
    end
    return PartBounds(v1, Pivot.Rotation)
end