-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Stages.EggEscape
-- Decompile time: 61.35 ms

local BoundingBox, BoundingBox_2, End, Position, Y_2, identity, v1, v2, v3, v4, v5, v6, v7
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local BeanstalkEventFlags = require(ReplicatedStorage.Shared.Flags.BeanstalkEventFlags)
local BeanstalkGrowth = require(script.Parent.Parent.BeanstalkGrowth)
local Music = require(script.Parent.Parent.Music)
local RailRide = require(script.Parent.Parent.RailRide)
local SpeedLines = require(script.Parent.Parent.SpeedLines)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local UISystem = require(script.Parent.Parent.UISystem)
local WhaleHearts = require(script.Parent.Parent.WhaleHearts)
local LocalPlayer = Players.LocalPlayer
local BeanstalkEventAssets = ReplicatedStorage.Assets.BeanstalkEventAssets
local Egg = BeanstalkEventAssets.Stage4.Egg
local CosmicLion = BeanstalkEventAssets.Stage4.CosmicLion
local SlideObstacles = BeanstalkEventAssets.SlideObstacles
local BeanstalkEvent_2 = ReplicatedStorage.Assets.Sounds.BeanstalkEvent
local Roar = ReplicatedStorage.Assets.Sounds.ScrambleBoss.Roar
local Step = ReplicatedStorage.Assets.Sounds.ScrambleBoss.Step
local Swoosh = ReplicatedStorage.Assets.Sounds.ScrambleBoss.Swoosh
local Stage = BeanstalkEvent.Stage
local u565 = CFrame.new(0, 1, -2.5)
local VineTrack = BeanstalkEventAssets.VineTrack
local u397 = Random.new()
local u578 = {}
for i, j in SlideObstacles.Hazards:GetChildren() do
    assert(j:IsA("Model"), (("SlideObstacles.Hazards.%* must be a Model"):format(j.Name)))
    BoundingBox, BoundingBox_2 = j:GetBoundingBox()
    identity = if not (BoundingBox_2.Z <= BoundingBox_2.X) then CFrame.Angles(0, 1.5707963267948966, 0) else CFrame.identity
    table.insert(u578, {
        Template = j,
        Across = identity * BoundingBox:ToObjectSpace((j:GetPivot())),
        HalfLength = math.max(BoundingBox_2.X, BoundingBox_2.Z) * 0.5,
        HalfHeight = BoundingBox_2.Y * 0.5,
    })
end
assert(#u578 > 0, "SlideObstacles.Hazards is empty")
local v8 = {}
local v9 = {Straight = 0, Left45 = 1, Right45 = -1}
local v10 = nil
local v11 = nil
for k, n in v9, v10, v11 do
    v1 = VineTrack:FindFirstChild(k)
    v3 = false
    if v1 ~= nil then
        v3 = v1:IsA("Model")
    end
    assert(v3, (("VineTrack.%* must be a Model"):format(k)))
    End = v1:FindFirstChild("End", true)
    v4 = false
    if End ~= nil then
        v4 = End:IsA("Attachment")
    end
    assert(v4, (("VineTrack.%* needs an End attachment"):format(k)))
    v3 = (v1:GetPivot()):ToObjectSpace(End.WorldCFrame)
    v2 = -n * 3.141592653589793 / 4
    v5 = -v3.YVector.X
    v6 = false
    if (math.abs((math.atan2(v5, v3.YVector.Y)) - v2)) < 0.017453292519943295 then
        v6 = 0.999 < v3.ZVector.Z
    end
    v7 = n * 45
    assert(v6, (("VineTrack.%*'s End must be a level %* degree turn"):format(k, v7)))
    Position = v3.Position
    v3 = if n ~= 0 then Position.Y / 0.7071067811865475 else 0
    Y_2 = if n ~= 0 then v3 * 3.141592653589793 / 4 else Position.Y
    v6 = {
        Template = v1,
        Turn = n,
        Offset = (CFrame.new(Position)) * CFrame.Angles(0, 0, v2),
        Radius = v3,
        Length = math.sqrt(Y_2 ^ 2 + Position.Z ^ 2),
    }
    v8[k] = v6
end
local Straight = v8.Straight
local Left45 = v8.Left45
local Right45 = v8.Right45
local u168 = {
    {Straight},
    {Straight, Straight},
    {Straight, Straight, Straight},
    {Left45, Straight},
    {Right45, Straight},
    {Left45, Left45, Straight},
    {Right45, Right45, Straight},
    {Straight, Left45, Right45, Straight},
    {Straight, Right45, Left45, Straight},
}

local function stage() -- Line: 236 -- upvalues: LocalPlayer (val), BeanstalkEvent (val)
    local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return nil
end

local function stealCounted() -- Line: 242 -- upvalues: LocalPlayer (val), BeanstalkEvent (val)
    local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
    local v1 = false
    if typeof(Attribute) == "number" then
        v1 = Attribute >= 1
    end
    return v1
end

local function floorTop(a1) -- Line: 247 -- types: a1: userdata
    return a1.Position.Y + a1.Size.Y * 0.5
end

local function waitUntilOver(a1, a2) -- Line: 251 -- upvalues: BeanstalkEvent (val) -- types: a1: userdata, a2: userdata
    while not BeanstalkEvent.IsOverFloor(a2, a1.Position, 60) do
        task.wait(0.2)
    end
end

local function flat(a1) -- Line: 257 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

local function isInside(a1, a2) -- Line: 261 -- types: a1: table, a2: vector
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = false
    if (math.abs(v1.X)) <= a1.Half.X then
        v2 = false
        if (math.abs(v1.Y)) <= a1.Half.Y then
            v2 = (math.abs(v1.Z)) <= a1.Half.Z
        end
    end
    return v2
end

local function paddedBox(a1, a2) -- Line: 266 -- types: a1: userdata, a2: number
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return {CFrame = BoundingBox, Half = BoundingBox_2 * 0.5 + Vector3.new(1, 1, 1) * a2}
end

local function pieceLocal(a1, a2) -- Line: 272 -- types: a1: table, a2: number
    local Position = a1.Offset.Position
    if a1.Turn == 0 then
        return Position * a2, Position.Unit
    end
    local Turn = a1.Turn
    local Radius = a1.Radius

    local function arc(a1) -- Line: 278 -- upvalues: Turn (val), Radius (val) -- types: a1: number
        return (Vector3.new(Turn * Radius * (1 - math.cos(a1)), Radius * math.sin(a1), 0))
    end

    local v1 = a2 * 3.141592653589793 / 4
    local v2 = (Vector3.new(Position.X, Position.Y, 0)) - (Vector3.new(Turn * Radius * 0.2928932188134524, Radius * 0.7071067811865475, 0))
    return (Vector3.new(Turn * Radius * (1 - math.cos(v1)), Radius * math.sin(v1), 0)) + v2 * a2 + Vector3.new(0, 0, Position.Z * a2), ((Vector3.new(Turn * math.sin(v1), math.cos(v1), 0)) * (Radius * 3.141592653589793 / 4) + Vector3.new(0, 0, Position.Z)).Unit
end

local function cellKey(a1, a2) -- Line: 289 -- types: a1: number, a2: number
    return (("%*,%*"):format(math.floor(a1 / 50), (math.floor(a2 / 50))))
end

local function randomWaypoint(a1, a2) -- Line: 293 -- types: a1: table, a2: userdata
    local v1 = a1.Bounds.Half * 0.85
    local v2 = a1.Bounds.CFrame:PointToWorldSpace((Vector3.new(a2:NextNumber(-v1.X, v1.X), 0, (a2:NextNumber(-v1.Z, v1.Z)))))
    return (Vector3.new(v2.X, 0, v2.Z))
end

local function tryGenerate(a1, a2, a3) -- Line: 300
    -- upvalues: pieceLocal (val), Straight (val), randomWaypoint (val), u168 (val), Left45 (val), Right45 (val)
    local Magnitude, Position_2, YVector, search, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local u411 = {}
    local u4 = {}
    local u414 = a1
    local u416 = 0
    local u419 = 0

    local function fits(a1, a2_2, a3) -- Line: 308
        -- upvalues: pieceLocal (upval), a2 (val), u4 (val)
        local v1, v2, v3, v4, v5, v6, v7
        local v8 = {}
        local v9 = math.ceil(a1.Length / 10)
        local v10, v11, v12 = a1, a2_2, a3
        for i = 1, v9 do
            v6 = v11:PointToWorldSpace((pieceLocal(v10, i / v9)))
            v1 = v6 - a2.Axis
            if Vector3.new(v1.X, 0, v1.Z).Magnitude < 65 then
                return nil
            end
            v7 = a2.Bounds.CFrame:PointToObjectSpace(v6)
            v1 = math.abs(v7.X)
            if not (a2.Bounds.Half.X < v1) then
                v1 = math.abs(v7.Z)
                if not (a2.Bounds.Half.Z < v1) then
                    if v12 > 2 then
                        v2 = nil
                        v3 = nil
                        for j, k in a2.Boxes, v2, v3 do
                            v7 = k.CFrame:PointToObjectSpace(v6)
                            v4 = false
                            if (math.abs(v7.X)) <= k.Half.X then
                                v4 = false
                                if (math.abs(v7.Y)) <= k.Half.Y then
                                    v4 = (math.abs(v7.Z)) <= k.Half.Z
                                end
                            end
                            if v4 then
                                return nil
                            end
                        end
                    end
                    v1 = math.floor(v6.X / 50)
                    v2 = math.floor(v6.Z / 50)
                    for n = -1, 1 do
                        for m = -1, 1 do
                            for i5, i6 in u4[("%*,%*"):format(v1 + n, v2 + m)] or {} do
                                if i6.Index < v12 - 2 then
                                    v5 = i6.Position - v6
                                    if Vector3.new(v5.X, 0, v5.Z).Magnitude < 50
                                        and (math.abs(i6.Position.Y - v6.Y)) < 60 then
                                        return nil
                                    end
                                end
                            end
                        end
                    end
                    continue
                end
            end
            return nil
        end
        return v8
    end

    local function nextRun(a1, a2) -- Line: 347 -- types: a1: number, a2: table
        if a2.Turn == 0 then
            return 0
        end
        if 0 < a1 * a2.Turn then
            return a1 + a2.Turn
        end
        return a2.Turn
    end

    local function commit(a1, a2) -- Line: 354
        -- upvalues: u411 (val), u414 (ref), u416 (ref), u4 (val), u419 (ref)
        local X, Z, v1, v2
        table.insert(u411, {Piece = a1, Joint = u414, StartDistance = u416})
        local v3 = nil
        local v4 = nil
        local v5 = a1
        for i, j in a2, v3, v4 do
            X = j.X
            Z = j.Z
            v1 = ("%*,%*"):format(math.floor(X / 50), (math.floor(Z / 50)))
            v2 = u4[v1]
            if v2 == nil then
                u4[v1] = {}
            end
            table.insert(v2, {Position = j, Index = #u411})
        end
        u414 = u414 * v5.Offset
        u416 = u416 + v5.Length
        v3 = u419
        u419 = if v5.Turn ~= 0 then if not (0 < v3 * v5.Turn) then v5.Turn else v3 + v5.Turn else 0
    end

    local function uncommit(a1) -- Line: 371 -- upvalues: u4 (val), u411 (val) -- types: a1: table
        local X, Z, v1, v2
        for i, j in a1 do
            v2 = u4
            X = j.X
            Z = j.Z
            v1 = v2[("%*,%*"):format(math.floor(X / 50), (math.floor(Z / 50)))]
            v1[#v1] = nil
        end
        table.remove(u411)
    end

    local function tryMove(a1) -- Line: 380
        -- upvalues: u414 (ref), u419 (ref), fits (val), u411 (val)
        local v1
        local v2 = u414
        local v3 = {}
        local v4 = nil
        local v5 = nil
        for i, j in a1, v4, v5 do
            v1 = u419
            v1 = if not ((math.abs(if j.Turn ~= 0 then if not (0 < v1 * j.Turn) then j.Turn else v1 + j.Turn else 0)) <= 2) then nil else fits(j, v2, #u411 + i)
            if v1 == nil then
                return nil, v2
            end
            table.insert(v3, v1)
            v2 = v2 * j.Offset
        end
        return v3, v2
    end

    for i = 1, 2 do
        v1 = fits(Straight, u414, #u411 + 1)
        if v1 == nil then
            return nil
        end
        commit(Straight, v1)
    end
    local Position = a2.Landing.Position
    local v13 = Vector3.new(Position.X, 0, Position.Z)
    local v14 = a3:NextNumber(a2.MinLength, a2.MaxLength)
    local v15 = nil
    for j = 1, 400 do
        v4 = {}
        Position_2 = u414.Position
        v5 = Vector3.new(Position_2.X, 0, Position_2.Z)
        v6 = 0
        v7 = true
        for k = 1, 3 do
            v9 = randomWaypoint(a2, a3)
            v6 = v6 + (v9 - v5).Magnitude
            v7 = v7 and 400 < (v9 - v13).Magnitude
            table.insert(v4, v9)
            v5 = v9
        end
        v5 = (u416 + (v6 + (v13 - v5).Magnitude) * 1.08) / v14
        if v5 > 0.92 and v5 < 1.04 and v7 then
            table.insert(v4, v13)
            v15 = v4
            break
        end
    end
    if v15 == nil then
        return nil
    end
    v14 = 1
    while true do
        v13 = v15[v14]
        v2 = v13 - u414.Position
        Magnitude = Vector3.new(v2.X, 0, v2.Z).Magnitude
        if v14 < #v15 and Magnitude < 200 then
            v14 = v14 + 1
            continue
        end
        if v14 == #v15 and Magnitude < 300 then
            break
        end
        if a2.MaxLength < u416 then
            return nil
        end
        v2 = nil
        v3 = nil
        v4 = (-1 / 0)
        v6 = nil
        v7 = nil
        for n, m in u168, v6, v7 do
            v8, v9 = tryMove(m)
            if v8 ~= nil then
                v10 = 0
                for i5, i6 in m do
                    v10 = v10 + i6.Length
                end
                v12 = v13 - v9.Position
                v11 = Vector3.new(v12.X, 0, v12.Z)
                v12 = (Magnitude - v11.Magnitude) / v10
                if not (1 < v11.Magnitude) then
                    v10 = 1
                else
                    YVector = v9.YVector
                    v10 = (Vector3.new(YVector.X, 0, YVector.Z)).Unit:Dot(v11.Unit)
                end
                v11 = v12 + v10 * 0.5 + a3:NextNumber() * 0.6
                if v4 < v11 then
                    v2 = m
                    v3 = v8
                end
            end
        end
        if v2 ~= nil and v3 ~= nil then
            for i7, i8 in v2 do
                commit(i8, v3[i7])
            end
            continue
        end
        return nil
    end
    local Landing = a2.Landing
    local u210 = 6000

    function search(a1) -- Line: 475
        -- upvalues: Landing (val), u414 (ref), u210 (ref), Straight (upval), Left45 (upval), Right45 (upval)
        -- upvalues: tryMove (val), u416 (ref), u419 (ref), commit (val), search (val), uncommit (val)
        local v1 = Landing.CFrame:PointToObjectSpace(u414.Position)
        if (math.abs(v1.X)) <= Landing.Size.X * 0.5 and (math.abs(v1.Z)) <= Landing.Size.Z * 0.5 then
            return true
        end
        if a1 ~= 0 and not (u210 <= 0) then
            local v2, v3, v4, v5
            v1 = {}
            for i, j in {Straight, Left45, Right45} do
                v4, v5 = tryMove({j})
                if v4 ~= nil then
                    v2 = {Piece = j, Points = v4[1]}
                    v3 = Landing.Position - v5.Position
                    v2.Distance = Vector3.new(v3.X, 0, v3.Z).Magnitude
                    table.insert(v1, v2)
                end
            end
            table.sort(v1, function(a1, a2) -- Line: 489
                return a1.Distance < a2.Distance
            end)
            for k, n in v1 do
                u210 = u210 - 1
                commit(n.Piece, n.Points)
                if search(a1 - 1) then
                    return true
                end
                uncommit(n.Points)
                u414 = u414
                u416 = u416
                u419 = u419
            end
            return false
        end
        return false
    end

    if not search(8) then
        return nil
    end
    if not (u416 < a2.MinLength) and not (a2.MaxLength < u416) and not (u414.Position.Y < a2.MinEndHeight) then
        return u411
    end
    return nil
end

local function buildSlide(a1, a2, a3) -- Line: 514
    -- upvalues: BeanstalkGrowth (val), BeanstalkEventFlags (val), tryGenerate (val), pieceLocal (val), Straight (val)
    local Sections = a3.Sections
    local SlideEntrance = Sections.Stage4.SlideEntrance
    local LookVector = SlideEntrance.CFrame.LookVector
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
    local v1 = CFrame.fromMatrix(SlideEntrance.Position + Vector3.new(0, SlideEntrance.Size.Y * 0.5, 0), Vector3.new(0, 1, 0):Cross(Unit), Unit)
    local v2 = BeanstalkGrowth.Axis(0)
    local BoundingBox, BoundingBox_2 = Sections.Stage2:GetBoundingBox()
    local v3 = {CFrame = BoundingBox, Half = BoundingBox_2 * 0.5 + Vector3.new(50, 50, 50)}
    local v4 = BeanstalkEventFlags.SlideSeconds:Get()
    local v5 = {}
    local v6 = {}
    local BoundingBox_3, BoundingBox_4 = Sections.Stage3:GetBoundingBox()
    local v7 = {CFrame = BoundingBox_3, Half = BoundingBox_4 * 0.5 + Vector3.new(50, 50, 50)}
    local BoundingBox_5, BoundingBox_6 = Sections.Stage4:GetBoundingBox()
    local v8 = {CFrame = BoundingBox_5, Half = BoundingBox_6 * 0.5 + Vector3.new(40, 40, 40)}
    v6[1] = v3
    v6[2] = v7
    v6[3] = v8
    v5.Boxes = v6
    v5.Axis = v2
    v5.Bounds = {Half = Vector3.new(1400, 0, 1400), CFrame = CFrame.new(v2)}
    v5.Landing = Sections.Stage1.SlideLanding
    v5.MinLength = (v4 - 2) * 75 - 78.125
    v5.MaxLength = (v4 + 2) * 75 - 78.125
    v5.MinEndHeight = v3.CFrame.Position.Y + v3.Half.Y + 100
    v4 = Random.new()
    local u108 = nil
    for i = 1, 60 do
        u108 = tryGenerate(v1, v5, v4)
        if u108 ~= nil then
            break
        end
    end
    v8 = ("No vine track fit in %* attempts; check the map layout and SlideLanding"):format(60)
    assert(u108 ~= nil, v8)
    v5 = {}
    for j, k in u108 do
        v4 = a1:Clone(k.Piece.Template)
        v4:PivotTo(k.Joint)
        v4.Parent = a2
        if k.Piece.Turn == 0 then
            table.insert(v5, k.StartDistance + k.Piece.Length * 0.5)
        end
    end
    v1 = u108[#u108]
    return {
        Path = function(a1) -- Line: 553 -- upvalues: u108 (ref), pieceLocal (upval) -- types: a1: number
            local v1, v2
            local v3 = 1
            local v4 = #u108
            local v5 = a1
            while v3 < v4 do
                v1 = (v3 + v4 + 1) // 2
                if not (u108[v1].StartDistance <= v5) then
                    v4 = v1 - 1
                else
                    v3 = v1
                end
            end
            v4 = u108[v3]
            v3 = math.clamp((v5 - v4.StartDistance) / v4.Piece.Length, 0, 1)
            v1, v2 = pieceLocal(v4.Piece, v3)
            v3 = (v4.Joint:PointToWorldSpace(v1)) + Vector3.new(0, 3, 0)
            return CFrame.lookAt(v3, v3 + v4.Joint:VectorToWorldSpace(v2))
        end,
        Length = v1.StartDistance + v1.Piece.Length,
        EntryLength = 2 * Straight.Length,
        StraightMiddles = v5,
    }
end

local function standOn(a1, a2) -- Line: 579 -- types: a1: userdata, a2: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return a2 * (BoundingBox * (CFrame.new(0, -BoundingBox_2.Y * 0.5, 0))):ToObjectSpace((a1:GetPivot()))
end

local function onMarker(a1, a2) -- Line: 585 -- types: a1: userdata, a2: userdata
    local CFrame_2 = a2.CFrame
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return CFrame_2 * (BoundingBox * (CFrame.new(0, -BoundingBox_2.Y * 0.5, 0))):ToObjectSpace((a1:GetPivot()))
end

local function isNear(a1, a2, a3, a4) -- Line: 589 -- types: a1: userdata, a2: vector, a3: number, a4: number
    local v1 = a1.Position - a2
    local v2 = false
    if Vector3.new(v1.X, 0, v1.Z).Magnitude <= a3 then
        v2 = math.abs(v1.Y) <= a4
    end
    return v2
end

local function placeObstacles(a1, a2, a3) -- Line: 594
    -- upvalues: u397 (val), u578 (val)
    local Template, v1, v2, v3, v4
    local v5 = {}
    local v6 = 250
    local v7 = a3
    while v6 < v7.Length - 150 do
        v1 = v7.Path(v6)
        v2 = u578[u397:NextInteger(1, #u578)]
        v3 = math.max(10 - v2.HalfLength, v2.HalfLength - 6)
        Template = v2.Template
        v4 = v8:Clone(Template)
        v4:PivotTo(v1 * CFrame.new((if not ((u397:NextNumber()) < 0.5) then 1 else -1) * v3, v2.HalfHeight + -3, 0) * v2.Across)
        v4.Parent = v9
        table.insert(v5, v4)
        v6 = v6 + 140
    end
    return v5
end

local function punchCamera(a1) -- Line: 612 -- upvalues: Workspace (val), TweenService (val)
    local CurrentCamera = Workspace.CurrentCamera
    local FieldOfView = CurrentCamera.FieldOfView
    a1:Add(function() -- Line: 615 -- upvalues: CurrentCamera (val), FieldOfView (val)
        CurrentCamera.FieldOfView = FieldOfView
    end)
    TweenService:Create(CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FieldOfView = 50}):Play()
    task.delay(0.25, function() -- Line: 619 -- upvalues: TweenService (upval), CurrentCamera (val), FieldOfView (val)
        TweenService:Create(
            CurrentCamera,
            TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            {FieldOfView = FieldOfView}
        ):Play()
    end)
end

local function dropLion(a1, a2) -- Line: 625
    -- upvalues: SoundService (val), Roar (val), RailRide (val)
    local v1
    local v2 = a2 + Vector3.new(0, 250, 0)
    local v3 = os.clock()
    while true do
        v1 = math.min((os.clock() - v3) / 1.2, 1)
        a1:PivotTo((v2:Lerp(a2, v1 * v1)))
        if v1 >= 1 then
            break
        end
        task.wait()
    end
    SoundService:PlayLocalSound(Roar)
    RailRide.Shake(8)
end

local function playLionRun(a1, a2) -- Line: 640 -- types: a2: userdata
    local u18 = ((a2:FindFirstChildWhichIsA("AnimationController", true)):FindFirstChildOfClass("Animator")):LoadAnimation((a2:FindFirstChildOfClass("Animation")))
    u18.Looped = true
    u18:Play()
    a1:Add(function() -- Line: 646 -- upvalues: u18 (val)
        u18:Stop()
        u18:Destroy()
    end)
    return u18
end

local function carryEgg(a1, a2, a3) -- Line: 655 -- upvalues: u565 (val) -- types: a3: userdata
    local v1 = a1:Extend()
    local Animator = a2.Humanoid:FindFirstChildOfClass("Animator")
    local v2 = v1:Add((Instance.new("Animation")))
    v2.AnimationId = "rbxassetid://102039335618606"
    local u21 = Animator:LoadAnimation(v2)
    u21.Looped = true
    u21:Play()
    v1:Add(function() -- Line: 663 -- upvalues: u21 (val)
        u21:Stop()
    end)
    local u33 = a3:GetScale()
    local u36 = os.clock()
    local u37 = false
    v1:BindToRenderStep("BeanstalkEggCarry", Enum.RenderPriority.Camera.Value + 3, function() -- Line: 670 -- upvalues: u37 (ref), u36 (val), a3 (val), u33 (val), a2 (val), u565 (upval)
        if not u37 then
            local v1 = math.min((os.clock() - u36) / 0.3, 1)
            a3:ScaleTo(u33 + (0.55 - u33) * v1)
            u37 = v1 >= 1
        end
        a3:PivotTo(a2.Root.CFrame * u565)
    end)
end

local function nearestDistance(a1, a2) -- Line: 681 -- types: a1: table, a2: vector
    local Magnitude
    local v1 = 0
    local v2 = (1 / 0)
    local Length = a1.Length
    local v3, v4 = a1, a2
    for i = 0, Length, 10 do
        Magnitude = (v3.Path(i).Position - v4).Magnitude
        if Magnitude < v2 then
            v1 = i
        end
    end
    return v1
end

local function newChase() -- Line: 693
    return {
        CloseUntil = (-1 / 0),
        PounceAt = (-1 / 0),
        ImpactAt = (-1 / 0),
        RecoverUntil = (-1 / 0),
        LastHit = (-1 / 0),
    }
end

local function canCrash(a1, a2) -- Line: 697 -- types: a1: table, a2: number
    local v1 = false
    if a1.PounceAt == (-1 / 0) then
        v1 = false
        if a1.RecoverUntil <= a2 then
            v1 = 0.65 <= a2 - a1.LastHit
        end
    end
    return v1
end

local function hitChase(a1, a2) -- Line: 701 -- types: a1: table, a2: number
    local v1 = false
    if a1.PounceAt == (-1 / 0) then
        v1 = false
        if a1.RecoverUntil <= a2 then
            v1 = 0.65 <= a2 - a1.LastHit
        end
    end
    if not v1 then
        return nil
    end
    a1.LastHit = a2
    if a2 < a1.CloseUntil then
        a1.PounceAt = a2
        return "Pounce"
    end
    a1.CloseUntil = a2 + 5
    return "Close"
end

local function impactChase(a1, a2) -- Line: 714 -- types: a1: table, a2: number
    if a1.PounceAt ~= (-1 / 0) and not (a2 - a1.PounceAt < 0.7) then
        a1.PounceAt = (-1 / 0)
        a1.CloseUntil = (-1 / 0)
        a1.ImpactAt = a2
        a1.RecoverUntil = a2 + 1.5
        return true
    end
    return false
end

local function chaseSpeed(a1, a2) -- Line: 725 -- types: a1: table, a2: number
    local v1 = a2 - a1.ImpactAt
    if v1 < 1.1 then
        return math.max(v1, 0) * 0.55 / 1.1 + 0.45
    end
    return 1
end

local function playMovementAnimation(a1, a2, a3) -- Line: 730 -- types: a3: string
    local Animator = a2.Humanoid:FindFirstChildOfClass("Animator")
    if Animator ~= nil and not (a2.Humanoid.Health <= 0) then
        local v1 = a1:Add((Instance.new("Animation")))
        v1.AnimationId = a3
        local u20 = Animator:LoadAnimation(v1)
        u20.Priority = Enum.AnimationPriority.Action2
        u20.Looped = true
        local u23 = false

        local function stop() -- Line: 741 -- upvalues: u23 (ref), u20 (val)
            if u23 then
                return
            end
            u23 = true
            u20:Stop(0)
            u20:Destroy()
        end

        a1:Add(stop)
        a1:Connect(a2.Humanoid.Died, stop)
        u20:Play(0.2)
        return
    end
end

local function addRunDust(a1, a2) -- Line: 754
    local v1 = a1:Add((Instance.new("Attachment")))
    v1.Name = "BeanstalkRunDust"
    v1.Position = Vector3.new(0, -2.700000047683716, 0)
    v1.Parent = a2.Root
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Dust"
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(193, 210, 134))
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), (NumberSequenceKeypoint.new(1, 1))})
    ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.7), (NumberSequenceKeypoint.new(1, 1))})
    ParticleEmitter.Lifetime = NumberRange.new(0.2, 0.4)
    ParticleEmitter.Speed = NumberRange.new(1, 3)
    ParticleEmitter.SpreadAngle = Vector2.new(25, 25)
    ParticleEmitter.Acceleration = Vector3.new(0, 2, 0)
    ParticleEmitter.Rate = 14
    ParticleEmitter.Parent = v1
    return ParticleEmitter
end

return {
    Run = function(a1, a2, a3, a4) -- Line: 778
        -- upvalues: UISystem (val), waitUntilOver (val), Workspace (val), Egg (val), buildSlide (val), RunService (val)
        -- upvalues: LocalPlayer (val), BeanstalkEvent (val), Remotes (val), Music (val), carryEgg (val)
        -- upvalues: punchCamera (val), RailRide (val), TutorialBeam (val), CosmicLion (val), dropLion (val)
        -- upvalues: nearestDistance (val), SpeedLines (val), WhaleHearts (val), Audio (val), BeanstalkEvent_2 (val)
        -- upvalues: SoundService (val), playMovementAnimation (val), addRunDust (val), placeObstacles (val)
        -- upvalues: playLionRun (val), Step (val), BeanstalkEventFlags (val), Roar (val), Swoosh (val), Lighting (val)
        -- upvalues: Stage (val)
        local Y_4, v1, v2
        local u4 = 2
        local Stage4 = a2.Sections.Stage4
        UISystem.SetTask("STEAL THE GIANT EGG")
        waitUntilOver(a3.Root, Stage4.Floor)
        local v3 = a1:Add((Instance.new("Folder")))
        v3.Name = "BeanstalkEggEscape"
        v3.Parent = Workspace
        local v4 = a1:Clone(Egg)
        local v5 = Egg
        local CFrame_3 = Stage4.EggSpot.CFrame
        local BoundingBox, BoundingBox_2 = v5:GetBoundingBox()
        v4:PivotTo(CFrame_3 * ((BoundingBox * (CFrame.new(0, -BoundingBox_2.Y * 0.5, 0))):ToObjectSpace((v5:GetPivot()))))
        v4.Parent = v3
        local u56 = buildSlide(a1, v3, a2)
        while true do
            v1 = a3.Root.Position - Stage4.EggSpot.Position
            v2 = false
            if Vector3.new(v1.X, 0, v1.Z).Magnitude <= 26 then
                v2 = (math.abs(v1.Y)) <= 15
            end
            if v2 then
                break
            end
            RunService.Heartbeat:Wait()
        end
        v5 = task.spawn(function() -- Line: 798 -- upvalues: LocalPlayer (upval), BeanstalkEvent (upval), Remotes (upval)
            local Attribute, v1
            while true do
                Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
                v1 = false
                if typeof(Attribute) == "number" then
                    v1 = Attribute >= 1
                end
                if v1 then
                    break
                end
                Remotes.BeanstalkEvent.AskStealEgg:FireServer()
                task.wait(1)
            end
        end)
        v6:Add(v5)
        Music.Play("Stage4TrackB")
        carryEgg(v6, a3, v4)
        punchCamera(v6)
        RailRide.Shake(6)
        v4 = v6:Extend()
        UISystem.SetPrompt("Escape down the slide!")
        local u123 = TutorialBeam.Attach(Stage4.SlideEntrance)
        v4:Add(function() -- Line: 813 -- upvalues: TutorialBeam (upval), u123 (val), UISystem (upval)
            TutorialBeam.Destroy(u123)
            UISystem.SetPrompt(nil)
        end)
        local u131 = v6:Clone(CosmicLion)
        u131:ScaleTo((u131:GetScale()) * 0.33)
        local Position_2 = Stage4.GriffinSpot.Position
        local v7 = CFrame.lookAt(Position_2, (Vector3.new(a3.Root.Position.X, Position_2.Y, a3.Root.Position.Z)))
        local BoundingBox_3, BoundingBox_4 = u131:GetBoundingBox()
        local v8 = v7 * (BoundingBox_3 * (CFrame.new(0, -BoundingBox_4.Y * 0.5, 0))):ToObjectSpace((u131:GetPivot()))
        u131:PivotTo(v8 + Vector3.new(0, 250, 0))
        u131.Parent = v3
        dropLion(u131, v8)
        local Floor = Stage4.Floor
        v8 = Floor.Position.Y + Floor.Size.Y * 0.5
        while true do
            v1 = a3.Root.Position - Stage4.SlideEntrance.Position
            v7 = false
            if Vector3.new(v1.X, 0, v1.Z).Magnitude <= 8 then
                v7 = (math.abs(v1.Y)) <= 10
            end
            if v7 then
                break
            end
            Y_4 = a3.Root.Position.Y
            if not (v8 - 10 < Y_4) then
                break
            end
            RunService.Heartbeat:Wait()
        end
        v4:Clean()
        while true do
            v5 = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
            v7 = false
            if typeof(v5) == "number" then
                v7 = v5 >= 1
            end
            if v7 then
                break
            end
            RunService.Heartbeat:Wait()
        end
        local Y_5 = a3.Root.Position.Y
        v4 = if not (v8 - 10 < Y_5) then nearestDistance(u56, a3.Root.Position) else 0
        local u284 = v6:Extend()
        local u285 = 0
        SpeedLines.Run(u284, function() -- Line: 843 -- upvalues: u4 (ref), a3 (val), LocalPlayer (upval), u285 (ref)
            if not (u4 <= 0) and not (a3.Humanoid.Health <= 0) and LocalPlayer.Character == a3.Character then
                return u285
            end
            return 0
        end)
        WhaleHearts.Show(u284, u4, UISystem.ShowSlideHearts(u284))
        local u316 = Audio.Play(BeanstalkEvent_2.SlideLoop, SoundService, {Looped = true})
        if u316 then
            u284:Add(u316)
        end
        playMovementAnimation(u284, a3, "rbxassetid://98935124024246")
        local u331 = addRunDust(u284, a3)
        local u332 = nil
        local u334 = os.clock()
        local u335 = u334
        local CFrame_2 = Workspace.CurrentCamera.CFrame
        local v9 = placeObstacles(v6, v3, u56)
        local u354 = {
            CloseUntil = (-1 / 0),
            PounceAt = (-1 / 0),
            ImpactAt = (-1 / 0),
            RecoverUntil = (-1 / 0),
            LastHit = (-1 / 0),
        }
        local u357 = v4 + 150
        local u358 = nil
        local Pivot = u131:GetPivot()
        local u369 = (-1 / 0)
        local Pivot_2 = u131:GetPivot()
        local u373 = 28
        local u375 = os.clock()
        local u376 = (-1 / 0)
        local u377 = 0

        local function cue(a1, a2, a3) -- Line: 872
            -- upvalues: Audio (upval), u131 (val), u284 (val)
            local v1 = Audio.Play(a1, u131, {MaxDistance = 200, SoundGroup = "SFX", Volume = a2, PlaybackSpeed = a3 or 1})
            if v1 then
                u284:Add(v1)
            end
        end

        local u384 = os.clock()
        RailRide.Run(u284, {
            Lateral = 10,
            BumpSpeedScale = 0.55,
            HitCooldownSeconds = 0.65,
            FieldOfView = 72,
            FieldOfViewPerSpeed = 8,
            Rig = a3,
            Path = u56.Path,
            Length = u56.Length,
            StartDistance = v4,
            Seconds = u56.Length / 100,
            Lift = function(a1) -- Line: 942 -- types: a1: number
                return (a1 / 10) ^ 2 * 3
            end,
            BumpSeconds = BeanstalkEventFlags.BumpSlowdownSeconds:Get(),
            CanHit = function() -- Line: 948 -- upvalues: u354 (val)
                local v1 = u354
                local v2 = os.clock()
                local v3 = false
                if v1.PounceAt == (-1 / 0) then
                    v3 = false
                    if v1.RecoverUntil <= v2 then
                        v3 = 0.65 <= v2 - v1.LastHit
                    end
                end
                return v3
            end,
            SpeedScale = function() -- Line: 951 -- upvalues: u4 (ref), u384 (val), u354 (val)
                if u4 <= 0 then
                    return 0
                end
                local v1 = os.clock()
                local v2 = math.clamp((v1 - u384) / 5, 0, 1)
                local v3 = (v2 * v2 * (3 - v2 * 2) * 31.25 + 43.75) / 100
                local v4 = v1 - u354.ImpactAt
                return v3 * (if not (v4 < 1.1) then 1 else math.max(v4, 0) * 0.55 / 1.1 + 0.45)
            end,
            Obstacles = v9,
            SteerLocked = function(a1) -- Line: 962 -- upvalues: u56 (val) -- types: a1: number
                return a1 * u56.Length < u56.EntryLength
            end,
            Mount = function(a1) -- Line: 965 -- upvalues: u354 (val), u377 (ref) -- types: a1: userdata
                local v1 = math.clamp(1 - (os.clock() - u354.ImpactAt) / 1.1, 0, 1)
                local v2 = math.clamp(1 - (os.clock() - u354.LastHit) / 0.35, 0, 1)
                return a1 * CFrame.Angles(math.rad(-8 - v1 * 18 - v2 * 10), 0, (math.rad(u377)))
            end,
            Camera = function(a1, a2) -- Line: 971
                -- upvalues: u334 (ref), u332 (ref), u354 (val), u335 (val), CFrame_2 (val)
                local Unit_2
                local v1 = os.clock()
                local v2 = math.max(v1 - u334, 0)
                local LookVector = a1.LookVector
                local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
                local v3 = u332
                u332 = if not v3 then Unit else v3:Lerp(Unit, 1 - (math.exp(-v2 * 9))).Unit
                u334 = v1
                v3 = (a1.Position:Lerp(a2.Position, 0.35)) + Vector3.new(0, 2, 0)
                local v4 = if not (v1 < u354.CloseUntil) then Vector3.new(0, 0, 0) else Vector3.new(math.sin(v1 * 27) * 0.06, math.sin(v1 * 33) * 0.04, 0)
                v2 = (CFrame.lookAt(v3 - Unit_2 * 44 + Vector3.new(0, 46, 0), v3 + Unit_2 * 6)) * CFrame.new(v4)
                v4 = math.clamp((v1 - u335) / 0.6, 0, 1)
                return (CFrame_2:Lerp(v2, v4 * v4 * (3 - v4 * 2)))
            end,
            OnHit = function() -- Line: 988
                -- upvalues: u354 (val), u4 (ref), WhaleHearts (upval), Remotes (upval), a3 (val), Pivot_2 (ref)
                -- upvalues: u131 (val), Roar (upval), Audio (upval), u284 (val), Swoosh (upval)
                -- upvalues: BeanstalkEvent_2 (upval)
                local v1 = os.clock()
                local v2 = u354
                local v3 = false
                if v2.PounceAt == (-1 / 0) then
                    v3 = false
                    if v2.RecoverUntil <= v1 then
                        v3 = 0.65 <= v1 - v2.LastHit
                    end
                end
                if v3 and not (u4 <= 0) then
                    local v4
                    u4 = u4 - 1
                    u354.LastHit = v1
                    if u4 ~= 0 then
                        u354.CloseUntil = v1 + 5
                        v4 = "Close"
                    else
                        u354.PounceAt = v1
                        u354.CloseUntil = v1 + 0.7
                        v4 = "Pounce"
                    end
                    WhaleHearts.Lose(u4)
                    Remotes.BeanstalkEvent.AskSlideCrash:FireServer(a3.Character)
                    if v4 ~= "Pounce" then
                        if v4 == "Close" then
                            v2 = Audio.Play(
                                BeanstalkEvent_2.SlideHit,
                                u131,
                                {Volume = 0.5, PlaybackSpeed = 1, MaxDistance = 200, SoundGroup = "SFX"}
                            )
                            if v2 then
                                u284:Add(v2)
                            end
                            v2 = Audio.Play(Roar, u131, {Volume = 0.5, PlaybackSpeed = 0.9, MaxDistance = 200, SoundGroup = "SFX"})
                            if v2 then
                                u284:Add(v2)
                            end
                        end
                        return
                    end
                    u131:GetPivot()
                    v1 = Audio.Play(Roar, u131, {Volume = 0.65, PlaybackSpeed = 1.1, MaxDistance = 200, SoundGroup = "SFX"})
                    if v1 then
                        u284:Add(v1)
                    end
                    v2 = Audio.Play(Swoosh, u131, {Volume = 0.5, PlaybackSpeed = 1, MaxDistance = 200, SoundGroup = "SFX"})
                    if not v2 then
                        return
                    end
                    u284:Add(v2)
                    return
                end
            end,
            OnStep = function(a1, a2, a3) -- Line: 879
                -- upvalues: u285 (ref), u375 (ref), u354 (val), BeanstalkEvent_2 (upval), Audio (upval), u131 (val)
                -- upvalues: u284 (val), RailRide (upval), u331 (val), u316 (val), u357 (val), u358 (ref)
                -- upvalues: playLionRun (upval), u369 (ref), u373 (ref), u56 (val), u377 (ref), u4 (ref), Pivot_2 (ref)
                -- upvalues: Pivot (val), u376 (ref), Step (upval)
                local BoundingBox_5, BoundingBox_6, v1, v2, v3, v4
                u285 = a3
                local v5 = os.clock()
                local v6 = v5 - u375
                u375 = v5
                local v7 = u354
                if v7.PounceAt == (-1 / 0) then
                    v4 = false
                elseif not (v5 - v7.PounceAt < 0.7) then
                    v7.PounceAt = (-1 / 0)
                    v7.CloseUntil = (-1 / 0)
                    v7.ImpactAt = v5
                    v7.RecoverUntil = v5 + 1.5
                    v4 = true
                else
                    v4 = false
                end
                if v4 then
                    v7 = Audio.Play(BeanstalkEvent_2.SlideHit, u131, {Volume = 0.7, PlaybackSpeed = 0.85, MaxDistance = 200, SoundGroup = "SFX"})
                    if v7 then
                        u284:Add(v7)
                    end
                    RailRide.Shake(5)
                    u331:Emit(12)
                end
                v7 = if not (v5 < u354.CloseUntil) then 0 else 1
                u331.Rate = a3 * 14 + v7 * 8
                if u316 then
                    u316.PlaybackSpeed = BeanstalkEvent_2.SlideLoop.PlaybackSpeed * (a3 * 0.15 + 0.85 + v7 * 0.08)
                    u316.Volume = BeanstalkEvent_2.SlideLoop.Volume * (a3 * 0.25 + 0.75 + v7 * 0.15)
                end
                if a1 < u357 then
                    return
                end
                if u358 == nil then
                    u358 = playLionRun(u284, u131)
                    u369 = v5
                end
                u358:AdjustSpeed((math.clamp(a3 + v7 * 0.35, 0.7, 1.5)))
                u373 = u373 + ((if not v4 then 28 else 18) - u373) * math.min(v6 * 5, 1)
                v7 = u56.Path((math.max(a1 - u373, 0)))
                v6 = u56.Path(a1)
                local v8 = v6.RightVector:Dot(a2.Position - v6.Position)
                u377 = -8 * v8 / 10
                local v9 = u131
                local v10 = v7 * CFrame.new(v8 * 0.5, -4.98, 0)
                local BoundingBox, BoundingBox_2 = v9:GetBoundingBox()
                v6 = v10 * (BoundingBox * (CFrame.new(0, -BoundingBox_2.Y * 0.5, 0))):ToObjectSpace((v9:GetPivot()))
                if u4 <= 0 then
                    v9 = v5 - u354.LastHit
                    if v9 >= 0.7 then
                        v9 = u131
                        v10 = a2 * CFrame.new(0, -4.98, 0)
                        local BoundingBox_3, BoundingBox_4 = v9:GetBoundingBox()
                        v6 = v10 * (BoundingBox_3 * (CFrame.new(0, -BoundingBox_4.Y * 0.5, 0))):ToObjectSpace((v9:GetPivot()))
                    elseif u354.PounceAt == (-1 / 0) then
                        v9 = v5 - u369
                        if v9 < 0.6 then
                            v9 = (v5 - u369) / 0.6
                            v10 = Pivot:Lerp(v6, v9)
                            v3 = 56 * v9
                            v6 = v10 + Vector3.new(0, 1, 0) * (v3 * (1 - v9))
                        end
                    else
                        v7 = v5 - u354.PounceAt
                        if not (v7 < 0.12) then
                            v9 = math.clamp((v7 - 0.12) / 0.58, 0, 1)
                            v1 = u131
                            v2 = a2 * CFrame.new(0, -4.98, 0)
                            BoundingBox_5, BoundingBox_6 = v1:GetBoundingBox()
                            v10 = v2 * ((BoundingBox_5 * (CFrame.new(0, -BoundingBox_6.Y * 0.5, 0))):ToObjectSpace((v1:GetPivot())))
                            v6 = (Pivot_2:Lerp(v10, v9)) + Vector3.new(0, 1, 0) * (v9 * 24 * (1 - v9))
                            u373 = 12
                        else
                            v6 = Pivot_2 - Vector3.new(0, 1, 0) * (2 * v7 / 0.12)
                        end
                    end
                elseif u354.PounceAt == (-1 / 0) then
                    v9 = v5 - u369
                    if v9 < 0.6 then
                        v9 = (v5 - u369) / 0.6
                        v10 = Pivot:Lerp(v6, v9)
                        v3 = 56 * v9
                        v6 = v10 + Vector3.new(0, 1, 0) * (v3 * (1 - v9))
                    end
                else
                    v7 = v5 - u354.PounceAt
                    if not (v7 < 0.12) then
                        v9 = math.clamp((v7 - 0.12) / 0.58, 0, 1)
                        v1 = u131
                        v2 = a2 * CFrame.new(0, -4.98, 0)
                        BoundingBox_5, BoundingBox_6 = v1:GetBoundingBox()
                        v10 = v2 * ((BoundingBox_5 * (CFrame.new(0, -BoundingBox_6.Y * 0.5, 0))):ToObjectSpace((v1:GetPivot())))
                        v6 = (Pivot_2:Lerp(v10, v9)) + Vector3.new(0, 1, 0) * (v9 * 24 * (1 - v9))
                        u373 = 12
                    else
                        v6 = Pivot_2 - Vector3.new(0, 1, 0) * (2 * v7 / 0.12)
                    end
                end
                u131:PivotTo(v6)
                v9 = v5 - u376
                if (if not v4 then 0.38 else 0.24) <= v9 and u354.PounceAt == (-1 / 0) then
                    u376 = v5
                    v6 = Audio.Play(Step, u131, {
                        MaxDistance = 200,
                        SoundGroup = "SFX",
                        Volume = if not v4 then 0.22 else 0.55,
                        PlaybackSpeed = (if not v4 then 0.95 else 1.1) or 1,
                    })
                    if v6 then
                        u284:Add(v6)
                    end
                end
            end,
        })
        u284:Clean()
        if not (u4 <= 0) and not (a3.Humanoid.Health <= 0) and LocalPlayer.Character == a3.Character then
            playMovementAnimation(v6, a3, "rbxassetid://88564428092864")
            local CurrentCamera = Workspace.CurrentCamera
            local FieldOfView = CurrentCamera.FieldOfView
            v6:Add(function() -- Line: 1023 -- upvalues: CurrentCamera (val), FieldOfView (val)
                CurrentCamera.FieldOfView = FieldOfView
            end)
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
            local u434 = v6:Add(ColorCorrectionEffect)
            u434.Parent = Lighting
            local Y_6 = a3.Root.Position.Y
            local Floor_2 = v10.Sections.Stage1.Floor
            local v11 = (Y_6 + (Floor_2.Position.Y + Floor_2.Size.Y * 0.5)) * 0.5
            local u465 = math.sqrt(1600 + 120 * (Y_6 - v11))
            local u466 = 40
            local v12 = v6:Extend()
            v12:Connect(RunService.Heartbeat, function(a1) -- Line: 1033
                -- upvalues: u466 (ref), a3 (val), u465 (val), CurrentCamera (val), FieldOfView (val), u434 (val)
                u466 = u466 + a1 * 60
                a3.Root.AssemblyLinearVelocity = Vector3.new(0, -u466, 0)
                local v1 = math.clamp((u466 - 40) / (u465 - 40), 0, 1)
                CurrentCamera.FieldOfView = FieldOfView + v1 * 30
                u434.Brightness = v1 * 0.3
            end)
            local v13 = os.clock()
            while v11 < a3.Root.Position.Y do
                if not (os.clock() - v13 < 5) then
                    break
                end
                RunService.Heartbeat:Wait()
            end
            v12:Clean()
            local Heartbeat_2 = RunService.Heartbeat
            v6:Connect(Heartbeat_2, function() -- Line: 1048 -- upvalues: a3 (val)
                a3.Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
            while true do
                v13 = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
                if (if typeof(v13) ~= "number" then nil else v13) ~= Stage.EggEscape then
                    break
                end
                Remotes.BeanstalkEvent.AskFinishEscape:FireServer()
                task.wait(0.5)
            end
            return
        end
    end,
}