-- Script path: ReplicatedStorage.Shared.Util.SafeZoneBarriers
-- Decompile time: 8.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CaptureTheEgg = require(ReplicatedStorage.Data.CaptureTheEgg)
local GuardAreaGeometry = require(script.Parent.GuardAreaGeometry)
local t = require(ReplicatedStorage.Packages.t)
local u25 = t.strict(t.Vector3)
local u28 = t.strict(t.number)
local u31 = t.strict(t.boolean)
local u34 = t.strict(t.string)
local u35 = nil
local v1 = {}

local function areasFolder() -- Line: 44 -- upvalues: u35 (ref), Workspace (val)
    local v1 = u35
    if v1 ~= nil and v1.Parent ~= nil then
        return v1
    end
    local World = Workspace:FindFirstChild("World")
    assert(World ~= nil, "Workspace.World is missing")
    local Areas = World:FindFirstChild("Areas")
    local v2 = false
    if Areas ~= nil then
        v2 = Areas:IsA("Folder")
    end
    assert(v2, "Workspace.World.Areas must be a Folder")
    u35 = Areas
    return Areas
end

local function areaPart(a1) -- Line: 61 -- upvalues: areasFolder (val) -- types: a1: string
    local v1 = areasFolder():FindFirstChild(a1)
    local v2 = false
    if v1 ~= nil then
        v2 = v1:IsA("BasePart")
    end
    assert(v2, (("Workspace.World.Areas.%* must be a BasePart"):format(a1)))
    return v1
end

local function readBox(a1) -- Line: 70 -- types: a1: userdata
    return {CFrame = a1.CFrame, HalfSize = a1.Size * 0.5}
end

local function depth(a1) -- Line: 74 -- upvalues: GuardAreaGeometry (val), areasFolder (val) -- types: a1: vector
    local SignedDistanceToLine = GuardAreaGeometry.SignedDistanceToLine
    local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
    local v1 = false
    if SeparationLine ~= nil then
        v1 = SeparationLine:IsA("BasePart")
    end
    assert(v1, "Workspace.World.Areas.SeparationLine must be a BasePart")
    return SignedDistanceToLine(SeparationLine, a1)
end

local function barrierBoxes(a1) -- Line: 80
    -- upvalues: areasFolder (val), ReplicatedStorage (val)
    local v1 = {}
    local WallStartCollision = areasFolder():FindFirstChild("WallStartCollision")
    local v2 = false
    if WallStartCollision ~= nil then
        v2 = WallStartCollision:IsA("BasePart")
    end
    assert(v2, "Workspace.World.Areas.WallStartCollision must be a BasePart")
    v1[1] = {CFrame = WallStartCollision.CFrame, HalfSize = WallStartCollision.Size * 0.5}
    if not a1 then
        return v1
    end
    local SpawnLock = ReplicatedStorage.Assets:FindFirstChild("SpawnLock")
    if SpawnLock == nil then
        return v1
    end
    if SpawnLock:IsA("BasePart") then
        table.insert(v1, {CFrame = SpawnLock.CFrame, HalfSize = SpawnLock.Size * 0.5})
    end
    for i, j in SpawnLock:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v1, {CFrame = j.CFrame, HalfSize = j.Size * 0.5})
        end
    end
    return v1
end

local function projectedHalfExtent(a1, a2) -- Line: 101 -- types: a1: table, a2: vector
    return (math.abs((a2:Dot(a1.CFrame.XVector)))) * a1.HalfSize.X + (math.abs((a2:Dot(a1.CFrame.YVector)))) * a1.HalfSize.Y + (math.abs((a2:Dot(a1.CFrame.ZVector)))) * a1.HalfSize.Z
end

local function boxIntrusion(a1, a2, a3, a4) -- Line: 111
    -- upvalues: GuardAreaGeometry (val), areasFolder (val), projectedHalfExtent (val)
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.HalfSize + Vector3.new(1, 1, 1) * a3
    local v3 = math.abs(v1.X)
    if not (v2.X < v3) then
        v3 = math.abs(v1.Y)
        if not (v2.Y < v3) then
            v3 = math.abs(v1.Z)
            if not (v2.Z < v3) then
                local Position = a1.CFrame.Position
                local SignedDistanceToLine = GuardAreaGeometry.SignedDistanceToLine
                local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
                local v4 = false
                if SeparationLine ~= nil then
                    v4 = SeparationLine:IsA("BasePart")
                end
                assert(v4, "Workspace.World.Areas.SeparationLine must be a BasePart")
                v3 = (SignedDistanceToLine(SeparationLine, Position)) + projectedHalfExtent(a1, a4) + a3
                local SignedDistanceToLine_2 = GuardAreaGeometry.SignedDistanceToLine
                local SeparationLine_2 = areasFolder():FindFirstChild("SeparationLine")
                local v5 = false
                if SeparationLine_2 ~= nil then
                    v5 = SeparationLine_2:IsA("BasePart")
                end
                assert(v5, "Workspace.World.Areas.SeparationLine must be a BasePart")
                v1 = v3 - SignedDistanceToLine_2(SeparationLine_2, a2)
                if v1 > 0 then
                    return v1
                end
                return nil
            end
        end
    end
    return nil
end

local function segmentHitsBox(a1, a2, a3, a4) -- Line: 129 -- types: a1: table, a2: vector, a3: vector, a4: number
    local v1, v2, v3, v4, v5
    local v6 = a1.CFrame:PointToObjectSpace(a2)
    local v7 = a1.CFrame:PointToObjectSpace(a3) - v6
    local v8 = a1.HalfSize + Vector3.new(1, 1, 1) * a4
    local v9 = {v6.X, v6.Y, v6.Z}
    v6 = {v7.X, v7.Y, v7.Z}
    v7 = {v8.X, v8.Y, v8.Z}
    local v10 = 0
    local v11 = 1
    for i = 1, 3 do
        v1 = v9[i]
        v2 = v6[i]
        v3 = v7[i]
        v4 = math.abs(v2)
        if not (v4 < 0.0001) then
            v8 = (-v3 - v1) / v2
            v4 = (v3 - v1) / v2
            if v4 < v8 then
                v5 = v4
                v4 = v8
                v8 = v5
            end
            v10 = math.max(v10, v8)
            v11 = math.min(v11, v4)
            if v11 < v10 then
                return false
            end
        elseif v3 < math.abs(v1) then
            return false
        end
    end
    return true
end

function v1.IsFencedUid(a1) -- Line: 166
    -- upvalues: u34 (val), Workspace (val), CaptureTheEgg (val)
    u34(a1)
    return Workspace:GetAttribute(CaptureTheEgg.EggUidAttribute) == a1
end

function v1.Depth(a1) -- Line: 173 -- upvalues: u25 (val), depth (val) -- types: a1: vector
    u25(a1)
    return depth(a1)
end

function v1.Intrusion(a1, a2, a3, a4) -- Line: 181
    -- upvalues: u25 (val), u28 (val), u31 (val), GuardAreaGeometry (val), areasFolder (val), barrierBoxes (val)
    -- upvalues: boxIntrusion (val)
    local v1
    u25(a1)
    u28(a2)
    u31(a3)
    u25(a4)
    local u49 = nil

    local function consider(a1) -- Line: 193 -- upvalues: u49 (ref) -- types: a1: number?
        if a1 ~= nil then
            if u49 == nil or u49 < a1 then
                u49 = a1
            end
        end
    end

    local SignedDistanceToLine = GuardAreaGeometry.SignedDistanceToLine
    local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
    local v2 = false
    if SeparationLine ~= nil then
        v2 = SeparationLine:IsA("BasePart")
    end
    assert(v2, "Workspace.World.Areas.SeparationLine must be a BasePart")
    local v3 = a2 - SignedDistanceToLine(SeparationLine, a1)
    local v4 = if not (v3 > 0) then nil else v3
    if v4 ~= nil then
        if u49 == nil or u49 < v4 then
            u49 = v4
        end
    end
    local v5, v6, v7 = a1, a2, a4
    for i, j in barrierBoxes(a3) do
        v1 = boxIntrusion(j, v5, v6, v7)
        if v1 ~= nil then
            if u49 == nil or u49 < v1 then
                u49 = v1
            end
        end
    end
    return u49
end

function v1.Separates(a1, a2, a3) -- Line: 210
    -- upvalues: u25 (val), u31 (val), GuardAreaGeometry (val), areasFolder (val), barrierBoxes (val)
    -- upvalues: segmentHitsBox (val)
    u25(a1)
    u25(a2)
    u31(a3)
    local SignedDistanceToLine = GuardAreaGeometry.SignedDistanceToLine
    local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
    local v1 = false
    if SeparationLine ~= nil then
        v1 = SeparationLine:IsA("BasePart")
    end
    assert(v1, "Workspace.World.Areas.SeparationLine must be a BasePart")
    local v2 = 0 < (SignedDistanceToLine(SeparationLine, a1))
    local SignedDistanceToLine_2 = GuardAreaGeometry.SignedDistanceToLine
    local SeparationLine_2 = areasFolder():FindFirstChild("SeparationLine")
    local v3 = false
    if SeparationLine_2 ~= nil then
        v3 = SeparationLine_2:IsA("BasePart")
    end
    assert(v3, "Workspace.World.Areas.SeparationLine must be a BasePart")
    if v2 ~= (0 < (SignedDistanceToLine_2(SeparationLine_2, a2))) then
        return true
    end
    for i, j in barrierBoxes(a3) do
        if segmentHitsBox(j, a1, a2, 0) then
            return true
        end
    end
    return false
end

return v1