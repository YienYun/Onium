-- Script path: ReplicatedStorage.Shared.Modules.TrexRunHerd
-- Decompile time: 3.37 ms

local u2 = table.freeze({
    Course = "TrexRun_Course",
    Lanes = "TrexRun_Lanes",
    LaneWidth = "TrexRun_LaneWidth",
    Near = "TrexRun_Near",
    Far = "TrexRun_Far",
    FloorY = "TrexRun_FloorY",
    IntroAt = "TrexRun_IntroAt",
    StartAt = "TrexRun_StartAt",
    Alpha = "TrexRun_Alpha",
    Phase = "TrexRun_Phase",
    Herd = "TrexRun_Herd",
    EggPosition = "TrexRun_EggPosition",
    CarrierUserId = "TrexRun_CarrierUserId",
    EggLabel = "TrexRun_EggLabel",
})
local u3 = {Attributes = u2}

function u3.DepthAt(a1, a2) -- Line: 53 -- types: a1: table, a2: number
    if a2 <= a1.At then
        return a1.Depth
    end
    return a1.Depth + a1.Direction * a1.Speed * (a2 - a1.At)
end

function u3.IsMoving(a1, a2) -- Line: 61 -- types: a1: table, a2: number
    return a1.At < a2
end

function u3.TurnAlpha(a1, a2) -- Line: 65 -- types: a1: table, a2: number
    local TurnFrom = a1.TurnFrom
    if TurnFrom ~= nil and not (a1.At <= a2) then
        return (math.clamp((a2 - TurnFrom) / math.max(a1.At - TurnFrom, 0.001), 0, 1))
    end
    return 1
end

function u3.Turn(a1, a2, a3) -- Line: 75 -- upvalues: u3 (val) -- types: a1: table, a2: number, a3: number
    a1.Depth = u3.DepthAt(a1, a2)
    a1.TurnFrom = a2
    a1.At = a2 + a3
    a1.Direction = -a1.Direction
end

function u3.IsExpired(a1, a2, a3) -- Line: 82 -- upvalues: u3 (val) -- types: a1: table, a2: table, a3: number
    local v1 = u3.DepthAt(a1, a3)
    if a1.Direction < 0 then
        return v1 < a2.Near - 40
    end
    return a2.Far + 40 < v1
end

function u3.LaneOffset(a1, a2) -- Line: 92 -- types: a1: table, a2: number
    return (a2 - (a1.Lanes + 1) * 0.5) * a1.LaneWidth
end

function u3.TrexLateral(a1, a2, a3) -- Line: 96 -- upvalues: u3 (val) -- types: a1: table, a2: table, a3: number
    local Offsets = a2.Offsets
    local v1 = not (Offsets == nil) and Offsets[a3] or 0
    return u3.LaneOffset(a1, a2.Lanes[a3]) + v1
end

function u3.Forward(a1) -- Line: 103 -- types: a1: table
    return a1.Origin.LookVector
end

function u3.Across(a1) -- Line: 107 -- types: a1: table
    return a1.Origin.RightVector
end

function u3.Point(a1, a2, a3) -- Line: 111 -- types: a1: table, a2: number, a3: number
    local Origin = a1.Origin
    local v1 = Origin.Position + Origin.LookVector * a2 + Origin.RightVector * a3
    return (Vector3.new(v1.X, a1.FloorY, v1.Z))
end

function u3.Locate(a1, a2) -- Line: 118 -- types: a1: table, a2: vector
    local v1 = a2 - a1.Origin.Position
    return (v1:Dot(a1.Origin.LookVector)), v1:Dot(a1.Origin.RightVector)
end

function u3.LaneAt(a1, a2) -- Line: 124 -- types: a1: table, a2: number
    return (math.clamp(math.floor(a2 / a1.LaneWidth + (a1.Lanes + 1) * 0.5 + 0.5), 1, a1.Lanes))
end

function u3.ReadCourse(a1) -- Line: 130 -- upvalues: u2 (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute(u2.Course)
    local Attribute_2 = a1:GetAttribute(u2.Lanes)
    local Attribute_3 = a1:GetAttribute(u2.LaneWidth)
    local Attribute_4 = a1:GetAttribute(u2.Near)
    local Attribute_5 = a1:GetAttribute(u2.Far)
    local Attribute_6 = a1:GetAttribute(u2.FloorY)
    if typeof(Attribute) == "CFrame"
        and type(Attribute_2) == "number"
        and type(Attribute_3) == "number"
        and type(Attribute_4) == "number"
        and type(Attribute_5) == "number"
        and type(Attribute_6) == "number" then
        return {
            Origin = Attribute,
            Lanes = Attribute_2,
            LaneWidth = Attribute_3,
            Near = Attribute_4,
            Far = Attribute_5,
            FloorY = Attribute_6,
        }
    end
    return nil
end

function u3.WriteCourse(a1, a2) -- Line: 159 -- upvalues: u2 (val) -- types: a1: userdata, a2: table?
    a1:SetAttribute(u2.Course, if a2 == nil then nil else a2.Origin)
    a1:SetAttribute(u2.Lanes, if a2 == nil then nil else a2.Lanes)
    a1:SetAttribute(u2.LaneWidth, if a2 == nil then nil else a2.LaneWidth)
    a1:SetAttribute(u2.Near, if a2 == nil then nil else a2.Near)
    a1:SetAttribute(u2.Far, if a2 == nil then nil else a2.Far)
    a1:SetAttribute(u2.FloorY, if a2 == nil then nil else a2.FloorY)
end

return table.freeze(u3)