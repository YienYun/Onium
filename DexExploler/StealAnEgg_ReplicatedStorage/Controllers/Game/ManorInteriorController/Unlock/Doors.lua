-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Unlock.Doors
-- Decompile time: 17.73 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Trove = require(ReplicatedStorage.Packages.Trove)
local u29 = table.freeze({"Door1", "Door2"})
local u34 = Color3.fromRGB(9, 5, 7)
local u39 = Color3.fromRGB(210, 190, 200)
local u44 = Color3.fromRGB(255, 168, 86)
local u51 = table.freeze({
    {Up = 0.35, Out = 1.5, Range = 30, Brightness = 1.1},
    {Up = 0.12, Out = 2.5, Range = 18, Brightness = 0.5},
    {Up = 0.3, Out = -12, Range = 28, Brightness = 1.2},
    {Up = 0.3, Out = -24, Range = 26, Brightness = 1},
})
local u56 = Color3.fromRGB(34, 20, 30)
local u61 = Color3.fromRGB(16, 9, 14)
local u66 = Color3.fromRGB(96, 20, 26)
local u71 = Color3.fromRGB(176, 128, 52)
local u75 = setmetatable({}, {__mode = "k"})
local u79 = setmetatable({}, {__mode = "k"})
local u80 = {OpenAngle = 1.3962634015954636}

local function flat(a1, a2) -- Line: 77 -- types: a1: vector, a2: vector
    local v1 = Vector3.new(a1.X, 0, a1.Z)
    if 0.01 < v1.Magnitude then
        return v1.Unit
    end
    return a2
end

local function closedPivot(a1) -- Line: 82 -- types: a1: userdata
    local Attribute = a1:GetAttribute("ManorClosedPivot")
    if typeof(Attribute) == "CFrame" then
        return Attribute
    end
    local Pivot = a1:GetPivot()
    a1:SetAttribute("ManorClosedPivot", Pivot)
    return Pivot
end

local function measure(a1, a2) -- Line: 92 -- types: a1: userdata, a2: userdata
    local Pivot = a1:GetPivot()
    if Pivot ~= a2 then
        a1:PivotTo(a2)
    end
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    if Pivot ~= a2 then
        a1:PivotTo(Pivot)
    end
    return BoundingBox, BoundingBox_2
end

local function inwardOf(a1, a2, a3) -- Line: 104 -- types: a1: userdata, a2: vector, a3: userdata?
    local v1
    if a3 ~= nil then
        local v2 = a2 - a3:GetBoundingBox().Position
        if 0.5 < Vector3.new(v2.X, 0, v2.Z).Magnitude then
            v1 = Vector3.new(v2.X, 0, v2.Z)
            if 0.01 < v1.Magnitude then
                return v1.Unit
            end
            return (Vector3.new(0, 0, 1))
        end
    end
    local Attribute = a1:GetAttribute("ManorInward")
    if typeof(Attribute) == "Vector3" then
        return Attribute
    end
    local LookVector = a1:GetPivot().LookVector
    v1 = Vector3.new(LookVector.X, 0, LookVector.Z)
    if 0.01 < v1.Magnitude then
        return v1.Unit
    end
    return (Vector3.new(0, 0, 1))
end

local function build(a1, a2) -- Line: 119 -- upvalues: u29 (val), inwardOf (val) -- types: a1: userdata, a2: userdata?
    local Attribute, BoundingBox, BoundingBox_2, Box, Pivot, Pivot_2, v1, v2, v3, v4, v5, v6
    local v7 = {}
    local v8 = nil
    local v9 = nil
    local v10, v11 = a1, a2
    for i, j in u29, v8, v9 do
        v5 = v10:FindFirstChild(j)
        if v5 ~= nil and v5:IsA("Model") then
            Attribute = v5:GetAttribute("ManorClosedPivot")
            if typeof(Attribute) ~= "CFrame" then
                Pivot = v5:GetPivot()
                v5:SetAttribute("ManorClosedPivot", Pivot)
                v6 = Pivot
            else
                v6 = Attribute
            end
            Pivot_2 = v5:GetPivot()
            if Pivot_2 ~= v6 then
                v5:PivotTo(v6)
            end
            BoundingBox, BoundingBox_2 = v5:GetBoundingBox()
            if Pivot_2 ~= v6 then
                v5:PivotTo(Pivot_2)
            end
            table.insert(v7, {Door = v5, Closed = v6, Box = BoundingBox, Size = BoundingBox_2})
        end
    end
    if #v7 == 0 then
        return nil
    end
    local v12 = Vector3.new(0, 0, 0)
    v8 = (1 / 0)
    v9 = (-1 / 0)
    for k, n in v7 do
        v12 = v12 + n.Box.Position
        v8 = math.min(v8, n.Box.Position.Y - n.Size.Y / 2)
        v9 = math.max(v9, n.Box.Position.Y + n.Size.Y / 2)
    end
    local v13 = v12 / #v7
    v12 = inwardOf(v10, v13, v11)
    v10:SetAttribute("ManorInward", v12)
    local Unit = Vector3.new(0, 1, 0):Cross(v12).Unit
    v5 = {}
    v6 = 0
    local v14 = 0
    local v15 = nil
    local v16 = nil
    for m, i5 in v7, v15, v16 do
        Box = i5.Box
        v1 = (math.abs((Box.RightVector:Dot(Unit)))) * i5.Size.X + (math.abs((Box.LookVector:Dot(Unit)))) * i5.Size.Z
        v2 = (math.abs((Box.RightVector:Dot(v12)))) * i5.Size.X + (math.abs((Box.LookVector:Dot(v12)))) * i5.Size.Z
        v14 = math.max(v14, v2)
        v3 = (Box.Position - v13):Dot(Unit)
        v6 = math.max(v6, (math.abs(v3)) + v1 / 2)
        v3 = Box.Position + Unit * ((if not (v3 >= 0) then -1 else 1) * v1 / 2) - v12 * (v2 / 2)
        v4 = CFrame.new(v3.X, Box.Position.Y, v3.Z)
        v2 = if not ((((v4 * CFrame.Angles(0, 1.3962634015954636, 0) * v4:Inverse() * Box).Position - Box.Position):Dot(v12)) <= 0) then -1.3962634015954636 else 1.3962634015954636
        table.insert(v5, {
            Door = i5.Door,
            Closed = i5.Closed,
            Hinge = v4,
            Angle = v2,
            Reach = v1,
        })
    end
    local v17 = Vector3.new(v13.X, v8, v13.Z)
    return {
        Doors = v10,
        Swings = v5,
        Frame = CFrame.lookAt(v17, v17 + v12),
        Width = v6 * 2,
        Height = v9 - v8,
        Depth = v14,
    }
end

local function slab(a1, a2, a3, a4, a5) -- Line: 181
    -- upvalues: 
    local Part = Instance.new("Part")
    Part.Name = a2
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.WoodPlanks
    Part.Color = a5
    Part.Size = a4
    Part.CFrame = a3
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Parent = a1
    return Part
end

local function floorLift(a1) -- Line: 199 -- upvalues: Players (val), Workspace (val) -- types: a1: table
    local v1 = {a1.Doors}
    for i, j in Players:GetPlayers() do
        if j.Character ~= nil then
            table.insert(v1, j.Character)
        end
    end
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.FilterDescendantsInstances = v1
    v2.IgnoreWater = true
    local v3 = Workspace:Raycast((a1.Frame * (CFrame.new(0, 15, 4))).Position, Vector3.new(-0, -30, -0), v2)
    if v3 == nil then
        return 0
    end
    return (math.clamp(v3.Position.Y - a1.Frame.Position.Y, 0, 15))
end

local function hall(a1, a2) -- Line: 218
    -- upvalues: floorLift (val), slab (val), u66 (val), u71 (val), u56 (val), u61 (val)
    local Frame = a2.Frame
    local Width = a2.Width
    local Height = a2.Height
    local v1 = floorLift(a2)
    local v2 = slab(a1, "Carpet", Frame * CFrame.new(0, v1 - 0.5, -15), Vector3.new(Width, 1, 30), u66)
    v2.Material = Enum.Material.Fabric
    for i, j in {-1, 1} do
        v2 = slab(a1, "Trim", Frame * CFrame.new(j * Width * 0.18, v1 + 0.03, -15), Vector3.new(1.399999976158142, 0.05999999865889549, 30), u71)
        v2.Material = Enum.Material.Fabric
        slab(a1, "Wall", Frame * CFrame.new(j * (Width / 2 + 0.5), Height / 2, -15), Vector3.new(1, Height, 30), u56)
    end
    v1 = slab(a1, "Ceiling", Frame * CFrame.new(0, Height + 0.5, -15), Vector3.new(Width + 2, 1, 30), u61)
    v1.Material = Enum.Material.SmoothPlastic
end

local function flicker(a1, a2) -- Line: 258 -- upvalues: RunService (val) -- types: a1: table, a2: table
    local u4 = math.random() * 100
    a1.Trove:Connect(RunService.Heartbeat, function() -- Line: 260 -- upvalues: u4 (val), a1 (val), a2 (val)
        local v1
        local v2 = os.clock() + u4
        local v3 = 0.92 + math.noise(v2 * 3.1, 0.5) * 0.12 + math.sin(v2 * 17) * 0.02
        for i, j in a1.Lights do
            v1 = a2[i]
            j.Brightness = v1 * a1.Lit * v3
        end
        a1.Room.ImageTransparency = 1 - math.clamp(a1.Lit * (0.9 + v3 * 0.1), 0, 1)
    end)
end

function u80.Rig(a1, a2) -- Line: 274 -- upvalues: u75 (val), build (val) -- types: a1: userdata, a2: userdata?
    local v1 = u75[a1]
    if v1 ~= nil then
        return v1
    end
    v1 = build(a1, a2)
    if v1 ~= nil then
        u75[a1] = v1
    end
    return v1
end

function u80.PoseSwing(a1, a2, a3) -- Line: 286 -- types: a1: table, a2: number, a3: number
    local v1 = a1.Swings[a2]
    if v1 == nil then
        return
    end
    v1.Door:PivotTo(v1.Hinge * CFrame.Angles(0, v1.Angle * a3, 0) * v1.Hinge:Inverse() * v1.Closed)
end

function u80.Pose(a1, a2) -- Line: 295 -- upvalues: u80 (val) -- types: a1: table, a2: number
    for i in a1.Swings do
        u80.PoseSwing(a1, i, a2)
    end
end

function u80.Tip(a1, a2) -- Line: 301 -- types: a1: table, a2: number
    local v1 = a1.Swings[a2]
    if v1 == nil then
        return nil
    end
    return v1.Door:GetBoundingBox().Position * 2 - v1.Hinge.Position
end

function u80.Leaf(a1, a2) -- Line: 309 -- types: a1: table, a2: number
    local v1 = a1.Swings[a2]
    if v1 == nil then
        return nil, nil, 0
    end
    local Position = v1.Hinge.Position
    local v2 = a1.Frame.Position - Position
    local RightVector = a1.Frame.RightVector
    local v3 = Vector3.new(v2.X, 0, v2.Z)
    local Unit = if not (0.01 < v3.Magnitude) then RightVector else v3.Unit
    local RightVector_2 = a1.Frame.RightVector
    local v4 = if not (0 <= (Unit:Dot(RightVector_2))) then -RightVector_2 else RightVector_2
    local v5 = ((v1.Door:GetPivot()) * v1.Closed:Inverse()).Rotation:VectorToWorldSpace(v4)
    local v6 = Vector3.new(v5.X, 0, v5.Z)
    return Position, if not (0.01 < v6.Magnitude) then v4 else v6.Unit, v1.Reach
end

function u80.Point(a1, a2, a3, a4) -- Line: 322 -- types: a1: table, a2: number, a3: number, a4: number
    return (a1.Frame * CFrame.new(-a2, a3, -a4)).Position
end

function u80.Inward(a1) -- Line: 326 -- types: a1: table
    return a1.Frame.LookVector
end

function u80.Clearing(a1, a2, a3) -- Line: 330 -- types: a1: table, a2: vector, a3: number
    local v1, v2, v3, v4, v5
    local Frame = a1.Frame
    local v6 = Frame:PointToObjectSpace(a2)
    local v7 = false
    local v8 = a1.Depth / 2
    local v9 = nil
    local v10 = nil
    local v11 = a3
    for i, j in a1.Swings, v9, v10 do
        v1 = Frame:PointToObjectSpace(j.Hinge.Position)
        v2 = j.Reach + v11
        v3 = v6.X - v1.X
        v4 = v6.Z - v1.Z
        if (math.abs(v6.X)) < math.abs(v1.X) + v11 and -v11 < v4 and v3 * v3 + v4 * v4 < v2 * v2 then
            v7 = true
        end
        v5 = math.abs(v1.X)
        v8 = math.max(v8, v1.Z + (math.sqrt((math.max(v2 * v2 - v5 * v5, 0)))) + 0.5)
    end
    if not v7 then
        return nil
    end
    return Frame:PointToWorldSpace((Vector3.new(0, v6.Y, (math.max(v6.Z, v8)))))
end

function u80.Foyer(a1) -- Line: 353 -- upvalues: u79 (val) -- types: a1: table
    return u79[a1.Doors]
end

function u80.SetFoyer(a1, a2) -- Line: 357
    -- upvalues: u79 (val), Trove (val), hall (val), slab (val), u34 (val), u39 (val), u51 (val), u44 (val)
    -- upvalues: RunService (val)
    local PointLight, v1
    local v2 = u79[a1.Doors]
    if not a2 then
        if v2 ~= nil then
            u79[a1.Doors] = nil
            v2.Trove:Destroy()
        end
        return nil
    end
    if v2 ~= nil and v2.Folder.Parent ~= nil then
        return v2
    end
    v2 = Trove.new()
    local v3 = v2:Add((Instance.new("Folder")))
    v3.Name = "ManorFoyer"
    local Frame = a1.Frame
    hall(v3, a1)
    local v4 = slab(v3, "Veil", Frame * CFrame.new(0, a1.Height / 2, -30), Vector3.new(a1.Width, a1.Height, 0.2), u34)
    v4.Material = Enum.Material.SmoothPlastic
    local SurfaceGui = Instance.new("SurfaceGui")
    SurfaceGui.Name = "Glow"
    SurfaceGui.Face = Enum.NormalId.Back
    SurfaceGui.LightInfluence = 0
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    SurfaceGui.PixelsPerStud = 12
    SurfaceGui.ResetOnSpawn = false
    SurfaceGui.Parent = v4
    v4 = Instance.new("Frame")
    v4.Name = "Shade"
    v4.Size = UDim2.fromScale(1, 1)
    v4.BorderSizePixel = 0
    v4.BackgroundColor3 = u34
    v4.Parent = SurfaceGui
    v4 = Instance.new("ImageLabel")
    v4.Name = "Room"
    v4.Size = UDim2.fromScale(1, 1)
    v4.BackgroundTransparency = 1
    v4.Image = "rbxassetid://77767765912332"
    v4.ImageColor3 = u39
    v4.ImageTransparency = 1
    v4.ScaleType = Enum.ScaleType.Crop
    v4.Parent = SurfaceGui
    local v5 = {}
    local u84 = {}
    for i, j in u51 do
        v1 = slab(
            v3,
            "Candle",
            Frame * CFrame.new(0, a1.Height * j.Up, j.Out),
            Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
            u44
        )
        v1.Transparency = 1
        PointLight = Instance.new("PointLight")
        PointLight.Color = u44
        PointLight.Range = j.Range
        PointLight.Brightness = j.Brightness
        PointLight.Shadows = false
        PointLight.Parent = v1
        table.insert(v5, PointLight)
        table.insert(u84, j.Brightness)
    end
    local u95 = {
        Lit = 1,
        Folder = v3,
        Lights = v5,
        Room = v4,
        Trove = v2,
    }
    local u102 = math.random() * 100
    u95.Trove:Connect(RunService.Heartbeat, function() -- Line: 260 -- upvalues: u102 (val), u95 (val), u84 (val)
        local v1
        local v2 = os.clock() + u102
        local v3 = 0.92 + math.noise(v2 * 3.1, 0.5) * 0.12 + math.sin(v2 * 17) * 0.02
        for i, j in u95.Lights do
            v1 = u84[i]
            j.Brightness = v1 * u95.Lit * v3
        end
        u95.Room.ImageTransparency = 1 - math.clamp(u95.Lit * (0.9 + v3 * 0.1), 0, 1)
    end)
    v3.Parent = a1.Doors
    u79[a1.Doors] = u95
    v2:Connect(v3.Destroying, function() -- Line: 435 -- upvalues: u79 (upval), a1 (val), u95 (val)
        if u79[a1.Doors] == u95 then
            u79[a1.Doors] = nil
        end
    end)
    return u95
end

return table.freeze(u80)