-- Script path: ReplicatedStorage.Shared.Util.ManorInterior
-- Decompile time: 5.16 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HalloweenDimensionFlags = require(ReplicatedStorage.Shared.Flags.HalloweenDimensionFlags)
local u15 = {"ZonesAssets", "Zone 3 - Abandoned Manor", "Structures", "Haunted Castle", "Doors"}
local u21 = {
    InteriorName = "ManorInterior",
    InteriorTag = "ManorInterior",
    MarkersName = "Markers",
    ExitMarkerName = "ManorDoorExit",
    DoorwayName = "ManorDoorway",
    LightingPreset = "ManorInterior",
    LockName = "Lock",
}
u21.DoorNames = table.freeze({"Door1", "Door2"})
u21.Markers = table.freeze({Spawn = "Spawn", Exit = "Exit", Bounds = "Bounds", DoorInside = "DoorInside"})
u21.Attributes = table.freeze({Inside = "InManorInterior"})
u21.Door = table.freeze({Reach = 40, Height = 50, Depth = 7})
u21.Sounds = table.freeze({
    Ambience = "rbxassetid://134369162018854",
    ChainRattle = "rbxassetid://96614250520996",
    PadlockClunk = "rbxassetid://116406137162867",
    GateClank = "rbxassetid://106997203137026",
    Creak = "rbxassetid://120769059226866",
    FloorCreak = "rbxassetid://130308112542819",
})
u21.Prompt = table.freeze({Object = "Manor Door", Locked = "Locked", Unlock = "Unlock"})
u21.Messages = table.freeze({
    Locked = "The door is chained shut. Fish up the Manor Key!",
    Unlocked = "The chains give way! Walk in through the open doors.",
    Ragdolled = "Wait until you recover first!",
    Mounted = "Get off your mount first!",
    TooFar = "Get closer to the manor door.",
    Closed = "The manor is sealed right now.",
    Fallback = "The manor door spat you out back in the lobby!",
})

function u21.GateOpen() -- Line: 73 -- upvalues: HalloweenDimensionFlags (val)
    return HalloweenDimensionFlags.ManorGateOpen:Get() == true
end

function u21.GateOpensAt(a1) -- Line: 77 -- upvalues: HalloweenDimensionFlags (val) -- types: a1: number
    for i, j in HalloweenDimensionFlags.ManorGateOpen:GetPendingSteps() do
        if j.Value == true and a1 < j.At then
            return j.At
        end
    end
    local v1 = HalloweenDimensionFlags.ManorGateUnlockTime:Get()
    if a1 < v1 then
        return v1
    end
    return nil
end

function u21.DescribeWait(a1) -- Line: 87 -- types: a1: number
    if a1 < 60 then
        return "less than a minute"
    end
    local v1 = math.ceil(a1 / 60)
    if v1 < 60 then
        if v1 == 1 then
            return "1 minute"
        end
        return (("%* minutes"):format(v1))
    end
    v1 = math.ceil(a1 / 3600)
    if not (v1 < 48) then
        return (("%* days"):format((math.ceil(a1 / 86400))))
    end
    if v1 == 1 then
        return "1 hour"
    end
    return (("%* hours"):format(v1))
end

function u21.Interior() -- Line: 102 -- upvalues: Workspace (val)
    local ManorInterior = Workspace:FindFirstChild("ManorInterior")
    if ManorInterior ~= nil and ManorInterior:IsA("Model") then
        return ManorInterior
    end
    return nil
end

function u21.Marker(a1) -- Line: 107 -- upvalues: u21 (val) -- types: a1: string
    local v1 = u21.Interior()
    local Markers = v1 and v1:FindFirstChild("Markers")
    v1 = Markers and Markers:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

function u21.Rooms() -- Line: 114 -- upvalues: u21 (val)
    local v1 = u21.Interior()
    local Collision = v1 and v1:FindFirstChild("Collision")
    v1 = Collision and Collision:FindFirstChild("Rooms")
    local v2 = {}
    if v1 ~= nil then
        for i, j in v1:GetChildren() do
            if j:IsA("BasePart") then
                table.insert(v2, j)
            end
        end
    end
    return v2
end

function u21.RealmMap() -- Line: 129 -- upvalues: Workspace (val)
    local HalloweenDimension = Workspace:FindFirstChild("HalloweenDimension")
    if HalloweenDimension ~= nil and HalloweenDimension:IsA("Model") then
        return HalloweenDimension
    end
    return nil
end

function u21.Doors() -- Line: 134 -- upvalues: u21 (val), u15 (val)
    local v1 = u21.RealmMap()
    local v2 = nil
    local v3 = nil
    for i, j in u15, v2, v3 do
        v1 = v1 and v1:FindFirstChild(j)
    end
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function realmPart(a1) -- Line: 142 -- upvalues: u21 (val) -- types: a1: string
    local v1 = u21.RealmMap()
    local v2 = v1 and v1:FindFirstChild(a1)
    if v2 ~= nil and v2:IsA("BasePart") then
        return v2
    end
    return nil
end

function u21.ExitMarker() -- Line: 148 -- upvalues: u21 (val)
    local ExitMarkerName = u21.ExitMarkerName
    local v1 = u21.RealmMap()
    local v2 = v1 and v1:FindFirstChild(ExitMarkerName)
    if v2 ~= nil and v2:IsA("BasePart") then
        return v2
    end
    return nil
end

function u21.Doorway() -- Line: 152 -- upvalues: u21 (val)
    local DoorwayName = u21.DoorwayName
    local v1 = u21.RealmMap()
    local v2 = v1 and v1:FindFirstChild(DoorwayName)
    if v2 ~= nil and v2:IsA("BasePart") then
        return v2
    end
    return nil
end

function u21.DoorOutside(a1) -- Line: 156 -- upvalues: u21 (val) -- types: a1: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    local v1 = Vector3.new(-BoundingBox.LookVector.X, 0, -BoundingBox.LookVector.Z)
    if v1.Magnitude < 0.01 then
        v1 = Vector3.new(-0, -0, -1)
    end
    return CFrame.lookAlong(BoundingBox.Position + v1.Unit * (BoundingBox_2.Z / 2 + u21.Door.Depth), -v1.Unit)
end

function u21.Within(a1, a2, a3) -- Line: 166 -- types: a1: userdata, a2: vector, a3: number
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size / 2 + Vector3.new(1, 1, 1) * a3
    local v3 = false
    if (math.abs(v1.X)) <= v2.X then
        v3 = false
        if (math.abs(v1.Y)) <= v2.Y then
            v3 = (math.abs(v1.Z)) <= v2.Z
        end
    end
    return v3
end

function u21.NearDoors(a1, a2, a3) -- Line: 174 -- upvalues: u21 (val) -- types: a1: userdata, a2: vector, a3: number
    local BoundingBox = a1:GetBoundingBox()
    local new = Vector2.new
    local v1 = false
    if (new(a2.X - BoundingBox.Position.X, a2.Z - BoundingBox.Position.Z)).Magnitude <= u21.Door.Reach + a3 then
        v1 = (math.abs(a2.Y - BoundingBox.Position.Y)) <= u21.Door.Height + a3
    end
    return v1
end

return table.freeze(u21)