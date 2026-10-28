-- Script path: ReplicatedStorage.Shared.Modules.KrakenRig
-- Decompile time: 18.89 ms

local Workspace = game:GetService("Workspace")
local u5 = {0, 8, 14}
local u9 = {-30, -15, 0, 15}
local u14 = {-45, -30, -15, 0, 15}
local u20 = {}
u20.Timing = table.freeze({
    Windup = 1.05,
    Hold = 0.25,
    Strike = 0.3,
    Settle = 0.3,
    Down = 0.85,
    Recover = 0.55,
})
u20.Raise = table.freeze({-30, -16, -28})
u20.Whip = table.freeze(u5)
u20.Hump = 4.5
u20.Attribute = "KrakenPose"

local function closestOnBox(a1, a2, a3) -- Line: 72 -- types: a1: userdata, a2: userdata, a3: vector
    local v1 = a2:PointToObjectSpace(a3)
    local v2 = a1.Size / 2
    return a2:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))))
end

local function extentAlong(a1, a2, a3) -- Line: 84 -- types: a1: userdata, a2: userdata, a3: vector
    return (math.abs((a2.RightVector:Dot(a3)))) * a1.Size.X + (math.abs((a2.UpVector:Dot(a3)))) * a1.Size.Y + (math.abs((a2.LookVector:Dot(a3)))) * a1.Size.Z
end

local function restFrames(a1) -- Line: 90 -- types: a1: table
    local CFrame, Part0, Part1
    local v1 = {}
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        Part0 = j.Part0
        Part1 = j.Part1
        CFrame = v1[Part0] or Part0.CFrame
        v1[Part0] = CFrame
        v1[Part1] = CFrame * j.C0 * j.C1:Inverse()
    end
    return v1
end

local function makeJoint(a1, a2, a3) -- Line: 101 -- types: a1: userdata, a2: table, a3: vector
    local v1 = a2[a1.Part0] * a1.C0
    return {Motor = a1, Rest = v1, Inverse = v1:Inverse(), Pivot = a3}
end

local function chainOf(a1) -- Line: 106 -- types: a1: userdata
    local v1
    local v2 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("Motor6D") and j.Part0 and j.Part1 then
            v2[j.Part0] = j
        end
    end
    local v3 = {}
    local Root = a1:FindFirstChild("Root")
    while Root do
        if not Root:IsA("BasePart") or not v2[Root] or not (#v3 < 8) then
            break
        end
        v1 = v2[Root]
        table.insert(v3, v1)
        Root = v1.Part1
    end
    return v3
end

local function probe(a1, a2) -- Line: 123 -- upvalues: Workspace (val) -- types: a1: vector, a2: userdata
    return Workspace:Raycast(Vector3.new(a1.X, 900, a1.Z), Vector3.new(0, -1600, 0), a2)
end

function u20.About(a1, a2) -- Line: 131 -- types: a1: vector, a2: userdata
    return CFrame.new(a1) * a2 * CFrame.new(-a1)
end

function u20.Drive(a1, a2) -- Line: 135 -- types: a1: table, a2: userdata
    a1.Motor.Transform = a1.Inverse * a2 * a1.Rest
end

function u20.StrikeAngle(a1, a2) -- Line: 139 -- types: a1: table, a2: number
    return a1.Pose[a2] or 0
end

function u20.Head(a1) -- Line: 143
    -- upvalues: chainOf (val), restFrames (val), closestOnBox (val)
    local v1 = chainOf(a1)
    if #v1 ~= 1 then
        return nil
    end
    local Part1 = v1[1].Part1
    local v2 = restFrames(v1)
    local v3 = v2[Part1]
    local v4 = v1[1]
    local v5 = closestOnBox(Part1, v3, v3.Position - Vector3.new(0, 10000, 0))
    local v6 = v2[v4.Part0] * v4.C0
    return {Motor = v4, Rest = v6, Inverse = v6:Inverse(), Pivot = v5}
end

local function geometryOf(a1) -- Line: 172
    -- upvalues: chainOf (val), restFrames (val), closestOnBox (val), extentAlong (val)
    local v1, v2, v3, v4
    local v5 = chainOf(a1)
    if #v5 < 2 then
        return nil
    end
    local v6 = {}
    for i, j in v5 do
        table.insert(v6, j.Part1)
    end
    local v7 = v6[1]
    local v8 = v6[#v6]
    local v9 = restFrames(v5)
    local v10 = closestOnBox(v7, v9[v7], v9[v7].Position - Vector3.new(0, 10000, 0))
    v7 = {v10}
    local v11 = #v6
    for k = 2, v11 do
        v1 = v6[k - 1]
        v2 = v6[k]
        table.insert(v7, ((closestOnBox(v1, v9[v1], v9[v2].Position)) + (closestOnBox(v2, v9[v2], v9[v1].Position))) / 2)
    end
    v11 = v9[v8].Position + (v9[v8].Position - v7[#v7])
    v8 = Vector3.new(v11.X - v10.X, 0, v11.Z - v10.Z)
    if v8.Magnitude < 1 then
        return nil
    end
    local Unit = v8.Unit
    local Unit_2 = Vector3.new(0, 1, 0):Cross(Unit).Unit
    v1 = {}
    for n, m in v5 do
        v3 = v7[n]
        v4 = v9[m.Part0] * m.C0
        table.insert(v1, {Motor = m, Rest = v4, Inverse = v4:Inverse(), Pivot = v3})
    end
    v5 = {}
    for i5, i6 in v6 do
        v5[i5] = extentAlong(i6, v9[i6], Unit_2) / 2
    end
    v9 = table.clone(v7)
    table.insert(v9, v11)
    return {
        Model = a1,
        Joints = v1,
        Segments = v6,
        Pivots = v7,
        Line = v9,
        Thickness = v5,
        Base = v10,
        Tip = v11,
        Reach = v8,
        Heading = Unit,
        Curl = Unit_2,
    }
end

local function sample(a1, a2) -- Line: 235 -- upvalues: u20 (val) -- types: a1: table, a2: table
    local v1, v2, v3
    local v4 = {}
    local v5 = {}
    local identity = CFrame.identity
    local Pivots = a1.Pivots
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a2
    for i, j in Pivots, v6, v7 do
        v1 = CFrame.fromAxisAngle(v8.Curl, (math.rad(v9[i] or 0)))
        identity = identity * u20.About(j, v1)
        v2 = v8.Line[i]
        v3 = v8.Line[i + 1]
        for k = 0, 11 do
            table.insert(v4, identity * (v2:Lerp(v3, k / 12)))
            table.insert(v5, v8.Thickness[i])
        end
    end
    return v4, v5, identity * v8.Tip
end

local function crossingsAt(a1, a2, a3) -- Line: 251
    -- upvalues: sample (val), Workspace (val)
    local v1, v2, v3, v4, v5
    local v6, v7 = sample(a1, a2)
    local v8 = {}
    local v9 = nil
    for i, j in v6 do
        v1 = Workspace:Raycast(Vector3.new(j.X, 900, j.Z), Vector3.new(0, -1600, 0), a3)
        if v1 ~= nil then
            v2 = v7[i]
            v3 = j.Y + v2 - v1.Position.Y
            v9 = math.max(v9 or (-1 / 0), v3)
            if not (v3 < 0.5) then
                v4 = math.max(v2 - math.min(v3, v2), 0)
                v5 = math.sqrt((math.max(v2 * v2 - v4 * v4, 0)))
                table.insert(v8, {
                    Point = j,
                    Surface = v1.Position.Y,
                    Top = j.Y + v2,
                    Radius = math.max(v5 * 0.8, 5),
                })
            end
        end
    end
    return v8, v9
end

local function includeParams(a1) -- Line: 282 -- types: a1: userdata
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = {a1}
    return v1
end

local function excludeParams(a1) -- Line: 289 -- types: a1: table
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = a1
    v1.IgnoreWater = false
    return v1
end

local function waterlineOf(a1) -- Line: 297 -- types: a1: table
    return a1.Model:FindFirstChild("Root").Position.Y
end

local function surfaceUnder(a1, a2, a3) -- Line: 301
    -- upvalues: Workspace (val)
    local Y = a1.Model:FindFirstChild("Root").Position.Y
    local v1 = Workspace:Raycast(Vector3.new(a2.X, 900, a2.Z), Vector3.new(0, -1600, 0), a3)
    if v1 == nil then
        return (Vector3.new(a2.X, Y, a2.Z)), true
    end
    local Position = v1.Position
    local v2 = true
    if v1.Material ~= Enum.Material.Water then
        v2 = v1.Position.Y <= Y + 1
    end
    return Position, v2
end

local function visibleCount(a1, a2, a3) -- Line: 314
    -- upvalues: sample (val), Workspace (val)
    local Y, v1, v2
    local v3, v4 = sample(a1, a2)
    local v5 = 0
    local v6 = nil
    local v7 = nil
    local v8, v9 = a3, a1
    for i, j in v3, v6, v7 do
        v1 = Workspace:Raycast(Vector3.new(j.X, 900, j.Z), Vector3.new(0, -1600, 0), v8)
        Y = if not v1 then v9.Model:FindFirstChild("Root").Position.Y else v1.Position.Y
        v2 = j.Y + v4[i]
        if Y + 0.5 < v2 then
            v5 = v5 + 1
        end
    end
    return v5
end

local function sceneryPose(a1, a2) -- Line: 327
    -- upvalues: u5 (val), sample (val), Workspace (val)
    local Position, v1
    local v2 = a1.Tip - a1.Base
    local Magnitude = v2.Magnitude
    local u10 = math.atan2(v2.Y, a1.Reach.Magnitude)

    local function toward(a1_2) -- Line: 331 -- upvalues: a1 (val), Magnitude (val), u10 (val) -- types: a1_2: number
        return (math.clamp(math.deg(u10 - (math.asin((math.clamp((a1_2 - a1.Base.Y) / Magnitude, -1, 1))))), 18, 78))
    end

    local v3 = table.clone(u5)
    v3[1] = (math.clamp(
        math.deg(u10 - (math.asin((math.clamp((a1.Model:FindFirstChild("Root").Position.Y + 3 - a1.Base.Y) / Magnitude, -1, 1))))),
        18,
        78
    ))
    _, _, v1 = sample(a1, v3)
    local Y_2 = a1.Model:FindFirstChild("Root").Position.Y
    local v4 = Workspace:Raycast(Vector3.new(v1.X, 900, v1.Z), Vector3.new(0, -1600, 0), a2)
    if v4 ~= nil then
        Position = v4.Position
        if v4.Material ~= Enum.Material.Water and v4.Position.Y <= Y_2 + 1 then end
    else
        Position = Vector3.new(v1.X, Y_2, v1.Z)
    end
    v3[1] = (math.clamp(math.deg(u10 - (math.asin((math.clamp((Position.Y + 3 - a1.Base.Y) / Magnitude, -1, 1))))), 18, 78))
    return v3
end

local function slamFor(a1, a2, a3) -- Line: 343
    -- upvalues: crossingsAt (val)
    local v1, v2, v3, v4
    local v5 = table.clone(a2)
    local v6 = 0
    local v7, v8 = a1, a3
    while v6 <= 95 do
        v5[1] = v6
        _, v2 = crossingsAt(v7, v5, v8)
        if v2 ~= nil and v2 <= 4.5 then
            v3 = math.max(v6 - 1, 0)
            v4 = v6
            for i = 1, 6 do
                v5[1] = (v3 + v4) / 2
                _, v1 = crossingsAt(v7, v5, v8)
                if v1 == nil or not (v1 <= 4.5) then
                    v3 = v5[1]
                else
                    v4 = v5[1]
                end
            end
            v5[1] = v4
            v3 = crossingsAt(v7, v5, v8)
            if #v3 > 0 then
                return v4, v3
            end
            return nil, {}
        end
        v6 = v6 + 1
    end
    return nil, {}
end

function u20.Solve(a1, a2, a3, a4) -- Line: 376
    -- upvalues: geometryOf (val), u9 (val), u14 (val), slamFor (val), visibleCount (val), sceneryPose (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = geometryOf(a1)
    if v7 == nil then
        return nil
    end
    local v8 = RaycastParams.new()
    v8.FilterType = Enum.RaycastFilterType.Include
    v8.FilterDescendantsInstances = {a2}
    local v9 = RaycastParams.new()
    v9.FilterType = Enum.RaycastFilterType.Exclude
    v9.FilterDescendantsInstances = a3
    v9.IgnoreWater = false
    local v10 = nil
    local v11 = (-1 / 0)
    local v12 = nil
    local v13 = nil
    local v14 = a4
    for i, j in u9, v12, v13 do
        v1 = nil
        v2 = nil
        for k, n in u14, v1, v2 do
            v3 = {0, j, n}
            v4, v5 = slamFor(v7, v3, v8)
            if v4 ~= nil then
                v3[1] = v4
                v6 = (visibleCount(v7, v3, v9)) + #v5 * 3 - ((math.abs(j)) + math.abs(n)) * 0.02
                if v11 < v6 then
                    v10 = v3
                end
            end
            if v14 then
                v14()
            end
        end
    end
    return v10 or sceneryPose(v7, v9)
end

function u20.Encode(a1) -- Line: 412 -- types: a1: table
    local v1 = table.create(#a1, "")
    for i, j in a1 do
        v1[i] = (string.format("%.3f", j))
    end
    return table.concat(v1, ",")
end

function u20.Decode(a1) -- Line: 420
    local v1
    if type(a1) ~= "string" then
        return nil
    end
    local v2 = {}
    for i in string.gmatch(a1, "[^,]+") do
        v1 = tonumber(i)
        if v1 ~= nil and v1 == v1 and not (180 < (math.abs(v1))) then
            table.insert(v2, v1)
            continue
        end
        return nil
    end
    if #v2 > 0 then
        return v2
    end
    return nil
end

function u20.Arm(a1, a2, a3, a4) -- Line: 435
    -- upvalues: geometryOf (val), crossingsAt (val), sample (val), Workspace (val)
    local v1, v2
    local v3 = geometryOf(a1)
    if v3 == nil then
        return nil
    end
    local v4 = RaycastParams.new()
    v4.FilterType = Enum.RaycastFilterType.Include
    v4.FilterDescendantsInstances = {a2}
    local v5 = RaycastParams.new()
    v5.FilterType = Enum.RaycastFilterType.Exclude
    v5.FilterDescendantsInstances = a3
    v5.IgnoreWater = false
    local v6 = crossingsAt(v3, a4, v4)
    v4 = false
    if not (#v6 > 0) then
        local Position, v7, v8
        _, _, v7 = sample(v3, a4)
        local Y = v3.Model:FindFirstChild("Root").Position.Y
        v2 = Workspace:Raycast(Vector3.new(v7.X, 900, v7.Z), Vector3.new(0, -1600, 0), v5)
        if v2 ~= nil then
            Position = v2.Position
            v8 = true
            if v2.Material ~= Enum.Material.Water then
                v8 = v2.Position.Y <= Y + 1
            end
        else
            Position = Vector3.new(v7.X, Y, v7.Z)
            v8 = true
        end
        v1 = Position
        v4 = v8
    else
        local v9
        v2 = v6[1]
        for i, j in v6 do
            v9 = j.Top - j.Surface
            if v2.Top - v2.Surface < v9 then
                v2 = j
            end
        end
        v1 = Vector3.new(v2.Point.X, v2.Surface, v2.Point.Z)
    end
    return {
        Model = a1,
        Joints = v3.Joints,
        Segments = v3.Segments,
        Curl = v3.Curl,
        Heading = v3.Heading,
        Tip = v3.Tip,
        Pose = a4,
        Impact = v1,
        Wet = v4,
        Crossings = v6,
    }
end

return table.freeze(u20)