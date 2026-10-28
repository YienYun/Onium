-- Script path: ReplicatedStorage.Shared.Utils.VisibleBounds
-- Decompile time: 1.00 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PartBounds = require(ReplicatedStorage.Shared.Utils.PartBounds)

local function isBoxSubject(a1) -- Line: 10
    local v1 = false
    if typeof(a1) == "Instance" then
        v1 = a1:IsA("Model") or a1:IsA("Tool")
    end
    return v1
end

local function opaqueParts(a1) -- Line: 14 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            table.insert(v1, j)
        end
    end
    return v1
end

return function(a1) -- Line: 25 -- upvalues: opaqueParts (val), PartBounds (val) -- types: a1: userdata
    local v1 = false
    if typeof(a1) == "Instance" then
        v1 = a1:IsA("Model") or a1:IsA("Tool")
    end
    assert(v1, "VisibleBounds needs a Model or a Tool")
    local v2 = opaqueParts(a1)
    if #v2 == 0 then
        return (a1:GetPivot()), (Vector3.new(0, 0, 0))
    end
    return PartBounds(v2)
end