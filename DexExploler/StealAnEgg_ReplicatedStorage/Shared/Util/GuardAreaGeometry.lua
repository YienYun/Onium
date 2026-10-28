-- Script path: ReplicatedStorage.Shared.Util.GuardAreaGeometry
-- Decompile time: 2.72 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u12 = t.strict(t.Instance)
local u17 = t.strict(t.instanceIsA("BasePart"))
local u20 = t.strict(t.Vector3)
local v1 = {}

local function depthPast(a1, a2) -- Line: 19 -- types: a1: userdata, a2: vector
    return a1.CFrame.LookVector:Dot(a2 - a1.Position)
end

local function checkStep(a1, a2, a3) -- Line: 24
    -- upvalues: u17 (val), u20 (val)
    u17(a1)
    u20(a2)
    u20(a3)
end

function v1.SignedDistanceToLine(a1, a2) -- Line: 30
    -- upvalues: u17 (val), u20 (val), depthPast (val)
    u17(a1)
    u20(a2)
    return depthPast(a1, a2)
end

function v1.IsPastLine(a1, a2) -- Line: 37 -- upvalues: u17 (val), u20 (val) -- types: a1: userdata, a2: vector
    u17(a1)
    u20(a2)
    return 0 < (a1.CFrame.LookVector:Dot(a2 - a1.Position))
end

function v1.CrossedLineInward(a1, a2, a3) -- Line: 44
    -- upvalues: u17 (val), u20 (val)
    u17(a1)
    u20(a2)
    u20(a3)
    local v1 = false
    if (a1.CFrame.LookVector:Dot(a2 - a1.Position)) <= 0 then
        v1 = 0 < (a1.CFrame.LookVector:Dot(a3 - a1.Position))
    end
    return v1
end

function v1.CrossedLineOutward(a1, a2, a3) -- Line: 50
    -- upvalues: u17 (val), u20 (val)
    u17(a1)
    u20(a2)
    u20(a3)
    local v1 = false
    if 0 < (a1.CFrame.LookVector:Dot(a2 - a1.Position)) then
        v1 = (a1.CFrame.LookVector:Dot(a3 - a1.Position)) <= 0
    end
    return v1
end

function v1.IsWithinFootprint(a1, a2) -- Line: 57 -- upvalues: u17 (val), u20 (val) -- types: a1: userdata, a2: vector
    u17(a1)
    u20(a2)
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size * 0.5
    local v3 = false
    if (math.abs(v1.X)) <= v2.X then
        v3 = (math.abs(v1.Z)) <= v2.Z
    end
    return v3
end

function v1.ReadAreaBounds(a1) -- Line: 67 -- upvalues: u12 (val) -- types: a1: userdata
    local Bounds
    u12(a1)
    assert(a1:IsA("Folder"), "Guard areas have to be collected under a single Folder")
    local v1 = {}
    for i, v in ipairs(a1:GetChildren()) do
        assert(v:IsA("Model"), (("%* sits under GuardAreas but is not a Model"):format((v:GetFullName()))))
        Bounds = v.Bounds
        assert(Bounds:IsA("BasePart"), (("%* has a Bounds child that is not a part"):format((v:GetFullName()))))
        table.insert(v1, {AreaId = v.Name, Bounds = Bounds})
    end
    assert(#v1 > 0, "GuardAreas is empty; the game needs at least one guard area")
    return v1
end

return v1