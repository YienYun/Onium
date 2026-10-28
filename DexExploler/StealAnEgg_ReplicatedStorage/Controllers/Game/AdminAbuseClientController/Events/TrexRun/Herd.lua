-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.TrexRun.Herd
-- Decompile time: 20.99 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
local TrexRunHerd = require(ReplicatedStorage.Shared.Modules.TrexRunHerd)
local u25 = Color3.fromRGB(255, 72, 40)
local u30 = CFrame.new(0, -5000, 0)
local u31 = {"Particles", "ScrambleBossVFX", "MechBoss", "Slam"}
local u36 = {}

local function byDistance(a1, a2) -- Line: 97 -- types: a1: table, a2: table
    return a1.Distance < a2.Distance
end

local function prepare(a1) -- Line: 105 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = false
        elseif j:IsA("Script") or j:IsA("LocalScript") then
            j:Destroy()
        end
    end
end

local function loadTrack(a1, a2) -- Line: 118 -- types: a1: userdata, a2: userdata?
    local Animator = a1:FindFirstChildWhichIsA("Animator", true)
    if Animator ~= nil and a2 ~= nil and a2:IsA("Animation") then
        local success, err = pcall(function() -- Line: 125 -- upvalues: Animator (val), a2 (val)
            return Animator:LoadAnimation(a2)
        end)
        if success and err ~= nil then
            err.Looped = true
            return err
        end
        return nil
    end
    return nil
end

local function newWarning(a1) -- Line: 138 -- upvalues: u25 (val) -- types: a1: table
    local Part = Instance.new("Part")
    Part.Name = "Warning"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = u25
    Part.Transparency = 1
    Part.Size = Vector3.new(a1.Course.LaneWidth * 0.7, 0.2, 70)
    Part.Parent = a1.Folder
    return Part
end

local function newSlot(a1) -- Line: 156 -- upvalues: prepare (val), loadTrack (val), u25 (val) -- types: a1: table
    local v1
    local v2 = a1.Template:Clone()
    prepare(v2)
    v2.Parent = a1.Folder
    local PrimaryPart = v2.PrimaryPart
    local v3 = loadTrack(v2, a1.Visuals:FindFirstChild("Run"))
    local Steps = a1.Visuals:FindFirstChild("Steps")
    local v4 = nil
    if v3 ~= nil then
        v3:Play(0)
        v3.TimePosition = (math.random()) * math.max(v3.Length, 0.1)
    end
    if Steps ~= nil and Steps:IsA("Sound") then
        v1 = Steps:Clone()
        v1.Looped = true
        local PrimaryPart_2 = v2.PrimaryPart or v2:FindFirstChildWhichIsA("BasePart", true)
        v1.Parent = PrimaryPart_2
        v4 = v1
    end
    v1 = {RunSpeed = 1, WarningShown = false, StepsPlaying = false, Key = 0}
    v1.Model = v2
    v1.Root = if PrimaryPart == nil then nil else if not PrimaryPart.Anchored then nil else PrimaryPart
    v1.Run = v3
    local Part = Instance.new("Part")
    Part.Name = "Warning"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = u25
    Part.Transparency = 1
    Part.Size = Vector3.new(a1.Course.LaneWidth * 0.7, 0.2, 70)
    Part.Parent = a1.Folder
    v1.Warning = Part
    v1.Steps = v4
    v1.Y = a1.Course.FloorY
    return v1
end

local function acquire(a1, a2) -- Line: 194 -- upvalues: newSlot (val) -- types: a1: table, a2: number
    local v1 = table.remove(a1.Free) or newSlot(a1)
    v1.Key = a2
    v1.Y = a1.Course.FloorY
    a1.Slots[a2] = v1
    return v1
end

local function release(a1, a2) -- Line: 204 -- upvalues: u30 (val) -- types: a1: table, a2: table
    a1.Slots[a2.Key] = nil
    a2.Key = 0
    if a2.Root == nil then
        a2.Model:PivotTo(u30)
    else
        a2.Root.CFrame = u30
    end
    a2.Warning.Transparency = 1
    a2.WarningShown = false
    if a2.Steps ~= nil and a2.StepsPlaying then
        a2.Steps.Playing = false
        a2.StepsPlaying = false
    end
    table.insert(a1.Free, a2)
end

local function ground(a1, a2, a3) -- Line: 225
    -- upvalues: TrexRunHerd (val), Workspace (val)
    local v1 = math.floor(a2 / 4 + 0.5)
    local v2 = math.floor(a3 / 4 + 0.5)
    local v3 = v1 * 1024 + v2 + 512
    local Y = a1.Ground[v3]
    if Y == nil then
        local v4 = TrexRunHerd.Point(a1.Course, v1 * 4, v2 * 4)
        local v5 = Workspace
        local v6 = v4 + Vector3.new(0, 60, 0)
        local Raycast = a1.Raycast
        local v7 = v5:Raycast(v6, Vector3.new(0, -160, 0), Raycast)
        Y = if v7 == nil then false else v7.Position.Y
        a1.Ground[v3] = Y
    end
    if Y == false then
        return nil
    end
    return Y
end

local function facing(a1, a2, a3) -- Line: 247 -- upvalues: TrexRunHerd (val) -- types: a1: table, a3: number
    local v1 = (TrexRunHerd.Forward(a1.Course)) * a2.Direction
    local v2 = TrexRunHerd.TurnAlpha(a2, a3)
    local v3 = if a2.Id % 2 ~= 0 then -1 else 1
    return (CFrame.lookAt(Vector3.new(0, 0, 0), v1)) * CFrame.Angles(0, 3.141592653589793 * (1 - v2) * v3, 0)
end

local function move(a1, a2, a3) -- Line: 255 -- types: a1: table, a2: table, a3: userdata
    local Root = a2.Root
    if Root == nil then
        a2.Model:PivotTo(a3)
        return
    end
    table.insert(a1.MoveParts, Root)
    table.insert(a1.MoveFrames, a3 * a1.RootOffset)
end

local function place(a1, a2, a3, a4) -- Line: 267
    -- upvalues: ground (val)
    local Wave = a3.Wave
    local Position = a3.Position
    local v1 = ground(a1, a3.Depth, a3.Lateral)
    local v2 = math.min(1, a4 * 12)
    local Moving = a3.Moving
    local Rotation = a3.Rotation
    local Y = a2.Y
    a2.Y = Y + ((v1 or a2.Y) - a2.Y) * v2
    local v3 = CFrame.new((Vector3.new(Position.X, a2.Y + a1.Size.Y * 0.5, Position.Z))) * Rotation
    local Root = a2.Root
    if Root ~= nil then
        table.insert(a1.MoveParts, Root)
        table.insert(a1.MoveFrames, v3 * a1.RootOffset)
    else
        a2.Model:PivotTo(v3)
    end
    local Run = a2.Run
    if Run ~= nil then
        v3 = if not Moving then if not a3.Turning then 0 else 1 else math.clamp(Wave.Speed / 32, 1, 2.4)
        if 0.02 < (math.abs(v3 - a2.RunSpeed)) then
            a2.RunSpeed = v3
            Run:AdjustSpeed(v3)
        end
    end
    local Steps = a2.Steps
    if Steps ~= nil then
        v3 = Moving and a3.Distance <= a1.StepsRange
        if v3 ~= a2.StepsPlaying then
            a2.StepsPlaying = v3
            Steps.Playing = v3
        end
    end
    if not Moving then
        if a2.WarningShown then
            a2.WarningShown = false
            a2.Warning.Transparency = 1
        end
        return
    end
    local LookVector = Rotation.LookVector
    local v4 = (math.sin(a1.Clock * 9 + Wave.Id) + 1) * 0.5
    v2 = (Vector3.new(Position.X, a2.Y + 0.35, Position.Z)) + LookVector * (a1.Size.Z * 0.5 + 35)
    table.insert(a1.MoveParts, a2.Warning)
    table.insert(a1.MoveFrames, (CFrame.lookAt(v2, v2 + LookVector)))
    a2.WarningShown = true
    a2.Warning.Transparency = v4 * 0.45 + 0.25
end

local function inPath(a1, a2, a3, a4) -- Line: 326 -- upvalues: TrexRunHerd (val) -- types: a3: number, a4: number
    for i in a2.Lanes do
        if math.abs(a3 - (TrexRunHerd.TrexLateral(a1, a2, i))) <= a4 then
            return true
        end
    end
    return false
end

local function updateAlpha(a1, a2) -- Line: 341 -- types: a1: table, a2: boolean?
    local v1 = os.clock() - a1.RoarStartedAt
    local v2 = 0
    if v1 < 1.3 then
        v2 = (math.sin(v1 / 1.3 * 3.141592653589793)) * a1.RoarStrength
        a1.Lifted = v2 ~= 0
        a1.Model:PivotTo(a1.Base * (CFrame.Angles(v2 * 0.24434609527920614, 0, 0)))
        return
    end
    if not a2 and not a1.Lifted then
        return
    end
    a1.Lifted = v2 ~= 0
    a1.Model:PivotTo(a1.Base * (CFrame.Angles(v2 * 0.24434609527920614, 0, 0)))
end

function u36.new(a1, a2) -- Line: 361 -- upvalues: Workspace (val) -- types: a2: userdata
    local Trex = a2:FindFirstChild("Trex")
    if Trex ~= nil and Trex:IsA("Model") then
        local Hitbox = Trex:FindFirstChild("Hitbox")
        local Size = if Hitbox == nil then Trex:GetExtentsSize() else if not Hitbox:IsA("BasePart") then Trex:GetExtentsSize() else Hitbox.Size
        local PrimaryPart = Trex.PrimaryPart
        local Steps = a2:FindFirstChild("Steps")
        local Folder = Instance.new("Folder")
        local v1 = RaycastParams.new()
        local v2 = {Workspace.Terrain}
        local World = Workspace:FindFirstChild("World")
        local Build = if World == nil then nil else World:FindFirstChild("Build")
        if Build ~= nil then
            table.insert(v2, Build)
        end
        v1.FilterType = Enum.RaycastFilterType.Include
        v1.FilterDescendantsInstances = v2
        v1.RespectCanCollide = true
        Folder.Name = "TrexRunHerd"
        Folder.Parent = Workspace
        local v3 = {
            Clock = 0,
            Course = a1,
            Visuals = a2,
            Template = Trex,
            Size = Size,
            Folder = Folder,
        }
        v3.Waves = {}
        v3.Slots = {}
        v3.Free = {}
        v3.Exited = {}
        v3.Raycast = v1
        v3.RootOffset = if PrimaryPart == nil then CFrame.identity else PrimaryPart.PivotOffset:Inverse()
        v3.StepsRange = if Steps == nil then 650 else if not Steps:IsA("Sound") then 650 else Steps.RollOffMaxDistance
        v3.KeyStride = a1.Lanes + 1
        v3.Ground = {}
        v3.Records = {}
        v3.Candidates = {}
        v3.Wanted = {}
        v3.MoveParts = {}
        v3.MoveFrames = {}
        return v3
    end
    warn("[TrexRun] Assets.TrexRunVisuals.Trex is missing")
    return nil
end

function u36.Set(a1, a2) -- Line: 418 -- types: a1: table, a2: table
    table.clear(a1.Waves)
    for i, j in a2 do
        if type(j) == "table" and type(j.Id) == "number" then
            a1.Waves[j.Id] = j
        end
    end
end

function u36.Add(a1, a2) -- Line: 428 -- types: a1: table
    if type(a2) == "table" and type(a2.Id) == "number" then
        a1.Waves[a2.Id] = a2
        return
    end
end

function u36.Dust(a1, a2) -- Line: 436 -- upvalues: Fx (val), u31 (val) -- types: a1: vector, a2: number
    local v1 = Fx.Resolve(u31)
    if v1 == nil then
        return
    end
    local u8 = v1:Clone()
    if u8:IsA("BasePart") then
        u8.Anchored = true
        u8.CanCollide = false
        u8.CanQuery = false
        u8.CanTouch = false
        u8.Transparency = 1
        u8.CFrame = CFrame.new(a1)
    end
    Fx.Scale(u8, a2)
    u8.Parent = Fx.Folder()
    Fx.Burst(u8, 0.6)
    task.delay(4, function() -- Line: 457 -- upvalues: u8 (val)
        u8:Destroy()
    end)
end

function u36.RowDust(a1, a2, a3, a4) -- Line: 462
    -- upvalues: TrexRunHerd (val), u36 (val), Fx (val)
    local Course = a1.Course
    local v1 = TrexRunHerd.Point(Course, a3, 0)
    if 975 < (v1 - a4).Magnitude then
        return
    end
    for i in a2.Lanes do
        u36.Dust(TrexRunHerd.Point(Course, a3, TrexRunHerd.TrexLateral(Course, a2, i)), 1.4)
    end
    Fx.Sound({"Sounds", "ScrambleBoss", "Stomp"}, v1, 0.9, 0.7, 500)
end

function u36.Update(a1, a2, a3, a4) -- Line: 480
    -- upvalues: TrexRunHerd (val), u36 (val), facing (val), byDistance (val), release (val), newSlot (val), place (val)
    -- upvalues: Workspace (val), updateAlpha (val)
    local Magnitude, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local Course = a1.Course
    local v10 = TrexRunHerd.Locate(Course, a4)
    local KeyStride = a1.KeyStride
    local Records = a1.Records
    local Candidates = a1.Candidates
    local Wanted = a1.Wanted
    local v11 = 0
    a1.Clock = a1.Clock + a2
    table.clear(Candidates)
    table.clear(Wanted)
    table.clear(a1.MoveParts)
    table.clear(a1.MoveFrames)
    local Waves = a1.Waves
    local v12 = nil
    local v13 = nil
    local v14, v15, v16, v17 = a1, a2, a3, a4
    for i, j in Waves, v12, v13 do
        if not TrexRunHerd.IsExpired(j, Course, v16) then
            v1 = TrexRunHerd.DepthAt(j, v16)
            v2 = math.abs(v1 - v10)
            if not (v2 > 650) then
                v2 = nil
                v3 = TrexRunHerd.IsMoving(j, v16)
                v4 = nil
                v5 = nil
                for k, n in j.Lanes, v4, v5 do
                    v6 = TrexRunHerd.TrexLateral(Course, j, k)
                    v7 = TrexRunHerd.Point(Course, v1, v6)
                    Magnitude = (v7 - v17).Magnitude
                    if not (Magnitude > 650) then
                        if v2 == nil then
                            v2 = facing(v14, j, v16)
                        end
                        v11 = v11 + 1
                        v8 = Records[v11]
                        if v8 == nil then
                            Records[v11] = {
                                Key = 0,
                                Moving = false,
                                Turning = false,
                                Wave = j,
                                Position = v7,
                                Depth = v1,
                                Lateral = v6,
                                Distance = Magnitude,
                                Rotation = CFrame.identity,
                            }
                        end
                        v8.Key = i * KeyStride + n
                        v8.Wave = j
                        v8.Position = v7
                        v8.Depth = v1
                        v8.Lateral = v6
                        v8.Distance = Magnitude
                        v8.Rotation = v2
                        v8.Moving = v3
                        v9 = false
                        if j.TurnFrom ~= nil then
                            v9 = not v3
                        end
                        v8.Turning = v9
                        Candidates[v11] = v8
                    end
                end
            end
        else
            if not v14.Exited[i] then
                v14.Exited[i] = true
                if j.Direction < 0 then
                    u36.RowDust(v14, j, Course.Near, v17)
                end
            end
            v14.Waves[i] = nil
        end
    end
    if v11 > 28 then
        table.sort(Candidates, byDistance)
        for m = v11, 29, -1 do
            Candidates[m] = nil
        end
    end
    for i5, i6 in Candidates do
        Wanted[i6.Key] = i6
    end
    for i7, i8 in v14.Slots do
        if Wanted[i7] == nil then
            release(v14, i8)
        end
    end
    v12 = nil
    v13 = nil
    for i9, i10 in Wanted, v12, v13 do
        v11 = v14.Slots[i9]
        if not v11 then
            v11 = table.remove(v14.Free) or newSlot(v14)
            v11.Key = i9
            v11.Y = v14.Course.FloorY
            v14.Slots[i9] = v11
        end
        place(v14, v11, i10, v15)
    end
    if #v14.MoveParts > 0 then
        Workspace:BulkMoveTo(v14.MoveParts, v14.MoveFrames, Enum.BulkMoveMode.FireCFrameChanged)
    end
    local Alpha = v14.Alpha
    if Alpha ~= nil then
        updateAlpha(Alpha)
    end
end

function u36.Danger(a1, a2, a3, a4) -- Line: 598
    -- upvalues: TrexRunHerd (val), inPath (val)
    local v1
    local Course = a1.Course
    local v2, v3 = TrexRunHerd.Locate(Course, a3)
    local v4 = Course.LaneWidth * 0.5
    local v5 = 0
    for i, j in a1.Waves do
        if TrexRunHerd.IsMoving(j, a2) and inPath(Course, j, v3, v4) then
            v1 = (v2 - TrexRunHerd.DepthAt(j, a2)) * j.Direction
            if v1 > 0 and v1 < a4 then
                v5 = math.max(v5, 1 - v1 / a4)
            end
        end
    end
    return v5
end

function u36.MountAlpha(a1, a2) -- Line: 619
    -- upvalues: prepare (val), loadTrack (val), updateAlpha (val)
    local v1 = a1.Template:Clone()
    prepare(v1)
    v1:ScaleTo((v1:GetScale()) * 2)
    v1.Name = "Alpha"
    v1.Parent = a1.Folder
    local v2 = a2 * CFrame.new(0, (a1.Size * 2).Y * 0.5, 0)
    local v3 = loadTrack(v1, a1.Visuals:FindFirstChild("Idle"))
    if v3 ~= nil then
        v3:Play(0)
    end
    v1:PivotTo(v2)
    local v4 = {
        RoarStartedAt = (-1 / 0),
        RoarStrength = 1,
        Lifted = false,
        Model = v1,
        Base = v2,
        Idle = v3,
    }
    a1.Alpha = v4
    updateAlpha(v4, true)
    return v4
end

function u36.Roar(a1, a2) -- Line: 652 -- upvalues: Fx (val), u36 (val) -- types: a1: table, a2: number
    local Alpha = a1.Alpha
    if Alpha == nil then
        return
    end
    Alpha.RoarStartedAt = os.clock()
    Alpha.RoarStrength = a2
    local v1 = Alpha.Base * CFrame.new(0, a1.Size.Y, -a1.Size.Z * 2 * 0.4)
    local Roar = a1.Visuals:FindFirstChild("Roar")
    if Roar ~= nil and Roar:IsA("Sound") then
        local u28 = Roar:Clone()
        u28.RollOffMaxDistance = 6000
        u28.Volume = u28.Volume * (a2 + 1)
        u28.PlaybackSpeed = 0.75
        u28.Parent = Fx.Holder(v1.Position, "AlphaRoar")
        u28:Play()
        task.delay(6, function() -- Line: 673 -- upvalues: u28 (val)
            if u28.Parent ~= nil then
                u28.Parent:Destroy()
            end
        end)
    end
    Fx.Sound({"Sounds", "MonsterParasite", "Roar"}, v1.Position, a2 * 0.4 + 0.6, 0.6, 6000)
    u36.Dust(Alpha.Base.Position, a2 * 3)
end

function u36.AlphaHead(a1) -- Line: 690 -- types: a1: table
    local Alpha = a1.Alpha
    if Alpha == nil then
        return nil
    end
    return (Alpha.Base * CFrame.new(0, a1.Size.Y * 0.9, -a1.Size.Z * 2 * 0.38)).Position
end

function u36:Destroy() -- Line: 700 -- types: self: table
    self.Folder:Destroy()
    table.clear(self.Waves)
    table.clear(self.Slots)
    table.clear(self.Free)
    table.clear(self.Ground)
    table.clear(self.Records)
    table.clear(self.Candidates)
    table.clear(self.Wanted)
    table.clear(self.MoveParts)
    table.clear(self.MoveFrames)
    self.Alpha = nil
end

return table.freeze(u36)