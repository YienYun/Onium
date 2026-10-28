-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Bridge
-- Decompile time: 43.25 ms

local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local BanjoCricketFlags = require(ReplicatedStorage.Shared.Flags.BanjoCricketFlags)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Quart = Enum.EasingStyle.Quart
local BanjoCricket_2 = ReplicatedStorage.Assets.VFX.BanjoCricket
local Notes = BanjoCricket_2.Notes
assert(Notes:IsA("Attachment"), "Assets.VFX.BanjoCricket.Notes must be an Attachment")
local NoteFlyer = BanjoCricket_2.NoteFlyer
assert(
    NoteFlyer:FindFirstChild("Head") and NoteFlyer:FindFirstChild("Tail"),
    "Assets.VFX.BanjoCricket.NoteFlyer needs a Head and a Tail attachment"
)
local Block = BanjoCricket_2.Block
assert(Block:IsA("BasePart"), "Assets.VFX.BanjoCricket.Block must be a BasePart")
local Spark = BanjoCricket_2.Spark
assert(
    Spark:IsA("Attachment") and Spark:FindFirstChildOfClass("ParticleEmitter") and Spark:FindFirstChildOfClass("PointLight"),
    "Assets.VFX.BanjoCricket.Spark must be an Attachment with a ParticleEmitter and a PointLight"
)
local u107 = {}
for i, j in Notes:GetChildren() do
    if j:IsA("ParticleEmitter") then
        table.insert(u107, j.Texture)
    end
end
local Trail = NoteFlyer:FindFirstChildWhichIsA("Trail", true)
local Lifetime = if not Trail then 0 else Trail.Lifetime
local u130 = {}
local u131 = {}
local u132 = false
local LocalPlayer = Players.LocalPlayer
local u136 = nil
local u137 = {}
local u141 = Trove.new()
local u142 = false
local u144 = Random.new()
local u145 = nil
local v1 = {}

local function pieceOf(a1) -- Line: 203 -- types: a1: userdata
    return {Part = a1, Transparency = a1.Transparency, CanCollide = a1.CanCollide}
end

local function strandOf(a1, a2) -- Line: 211 -- types: a1: userdata, a2: vector
    local v1 = {
        FarIsZero = false,
        Beam = a1,
        Enabled = a1.Enabled,
        Width0 = a1.Width0,
        Width1 = a1.Width1,
        Brightness = a1.Brightness,
    }
    local Attachment0 = a1.Attachment0
    local Attachment1 = a1.Attachment1
    if Attachment0 and Attachment1 then
        local v2
        local Magnitude = (Attachment0.WorldPosition - a2).Magnitude
        v1.Near = if not ((Attachment1.WorldPosition - a2).Magnitude < Magnitude) then Attachment0 else Attachment1
        v1.Far = if not v2 then Attachment1 else Attachment0
        v1.FarIsZero = v2
    end
    return v1
end

local function setFar(a1, a2) -- Line: 231 -- types: a1: table, a2: userdata
    if a1.FarIsZero then
        a1.Beam.Attachment0 = a2
        return
    end
    a1.Beam.Attachment1 = a2
end

local function setNotes(a1, a2) -- Line: 239 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetChildren() do
        if j:IsA("ParticleEmitter") then
            j.Enabled = a2
        end
    end
end

local function scaled(a1, a2) -- Line: 247 -- types: a1: userdata, a2: number
    local v1 = {}
    for i, j in a1.Keypoints do
        table.insert(v1, (NumberSequenceKeypoint.new(j.Time, j.Value * a2, j.Envelope * a2)))
    end
    return NumberSequence.new(v1)
end

local function lock(a1) -- Line: 262 -- types: a1: table
    a1.Barrier.Part.CanCollide = true
    for i, j in a1.Pieces do
        j.Part.Transparency = 1
        j.Part.CanCollide = false
    end
    for k, n in a1.Strands do
        n.Beam.Enabled = false
    end
end

local function restore(a1) -- Line: 273 -- types: a1: table
    local Far
    a1.Barrier.Part.CanCollide = a1.Barrier.CanCollide
    for i, j in a1.Pieces do
        j.Part.Transparency = j.Transparency
        j.Part.CanCollide = j.CanCollide
    end
    local v1 = nil
    local v2 = nil
    for k, n in a1.Strands, v1, v2 do
        Far = n.Far
        if Far then
            if not n.FarIsZero then
                n.Beam.Attachment1 = Far
            else
                n.Beam.Attachment0 = Far
            end
        end
        n.Beam.Width0 = n.Width0
        n.Beam.Width1 = n.Width1
        n.Beam.Brightness = n.Brightness
        n.Beam.Enabled = n.Enabled
    end
end

local function sparkOf(a1, a2) -- Line: 291 -- upvalues: Spark (val), Workspace (val) -- types: a2: vector
    local v1 = a1:Clone(Spark)
    v1.Position = a2
    v1.Parent = Workspace.Terrain
    return {
        Attachment = v1,
        Sparkles = v1:FindFirstChildOfClass("ParticleEmitter"),
        Glow = v1:FindFirstChildOfClass("PointLight"),
    }
end

local function lanesOf(a1, a2, a3) -- Line: 302 -- types: a1: table, a2: userdata, a3: userdata
    local Far, Near
    local v1 = {}
    local v2 = {}
    for i, j in a1 do
        Near = j.Near
        Far = j.Far
        if Near and Far and not v2[Far] then
            v2[Far] = true
            table.insert(v1, {Near = Near.WorldPosition, Far = Far.WorldPosition})
        end
    end
    if #v1 == 0 then
        table.insert(v1, {Near = a2.Position, Far = a3.Position})
    end
    return v1
end

local function floorAt(a1, a2) -- Line: 318
    -- upvalues: LocalPlayer (val), Workspace (val)
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    local v2 = {a1}
    if LocalPlayer.Character then
        table.insert(v2, LocalPlayer.Character)
    end
    v1.FilterDescendantsInstances = v2
    v1.RespectCanCollide = true
    v2 = Workspace:Raycast(a2 + Vector3.new(0, 20, 0), Vector3.new(-0, -40, -0), v1)
    if v2 then
        return v2.Position.Y
    end
    return (-1 / 0)
end

local function unbind(a1) -- Line: 335 -- upvalues: u130 (val) -- types: a1: userdata
    local v1 = u130[a1]
    if v1 then
        u130[a1] = nil
        v1.Trove:Destroy()
    end
end

local function bind(a1) -- Line: 343
    -- upvalues: u130 (val), Workspace (val), strandOf (val), Trove (val), lanesOf (val), floorAt (val), Notes (val)
    -- upvalues: scaled (val), setNotes (val), sparkOf (val), lock (val), restore (val)
    if not u130[a1] then
        local v1 = Workspace
        if a1:IsDescendantOf(v1) then
            local Start = a1:FindFirstChild("Start")
            local Barrier = a1:FindFirstChild("Barrier")
            if Start ~= nil and Start:IsA("BasePart") and Barrier ~= nil and Barrier:IsA("BasePart") then
                local Position_2, Unit, v2
                v1 = {}
                local v3 = {}
                for i, j in a1:GetDescendants() do
                    if j ~= Start and j ~= Barrier then
                        if j:IsA("BasePart") then
                            table.insert(v1, {
                                Part = j,
                                Transparency = j.Transparency,
                                CanCollide = j.CanCollide,
                            })
                        elseif j:IsA("Beam") then
                            v2 = strandOf
                            Position_2 = Start.Position
                            v2 = v2(j, Position_2)
                            table.insert(v3, v2)
                        end
                    end
                end
                local v4 = Trove.new()
                local v5 = lanesOf(v3, Start, Barrier)
                local v6 = Vector3.new(0, 0, 0)
                local v7 = Vector3.new(0, 0, 0)
                local v8 = (-1 / 0)
                for k, n in v5 do
                    v6 = v6 + n.Near / #v5
                    v7 = v7 + n.Far / #v5
                    v8 = math.max(v8, n.Near.Y, n.Far.Y)
                end
                local v9 = Vector3.new(v7.X - v6.X, 0, v7.Z - v6.Z)
                v2 = (if not (0.001 < v9.Magnitude) then Vector3.new(1, 0, 0) else v9.Unit):Cross((Vector3.new(0, 1, 0)))
                local v10 = 0
                for m, i5 in v5 do
                    v10 = math.max(v10, (math.abs(((i5.Near - v6):Dot(v2)))) * 2)
                end
                local v11 = math.max(v8, (floorAt(a1, Start.Position)))
                local v12 = v4:Clone(Notes)
                v12.Name = "BanjoBridgeConfetti"
                for i6, i7 in v12:GetChildren() do
                    if i7:IsA("ParticleEmitter") then
                        i7.Size = scaled(i7.Size, 3)
                    end
                end
                setNotes(v12, false)
                v12.Position = v6
                v12.Parent = Workspace.Terrain
                local u130_2 = {Phase = "Sealed", NextNoteAt = 0, Start = Start}
                u130_2.Barrier = {
                    Part = Barrier,
                    Transparency = Barrier.Transparency,
                    CanCollide = Barrier.CanCollide,
                }
                u130_2.Pieces = v1
                u130_2.Strands = v3
                u130_2.Trove = v4
                u130_2.Lanes = v5
                u130_2.Near = v6
                u130_2.Far = v7
                u130_2.DeckTop = v8
                u130_2.Width = math.max(8, v10 + 5)
                u130_2.Direction = Unit
                u130_2.Side = v2
                u130_2.Length = v9.Magnitude
                u130_2.Anchor = sparkOf(v4, (Vector3.new(v6.X, v11 + 3, v6.Z)))
                u130_2.Burst = sparkOf(v4, v6)
                u130_2.Confetti = v12
                u130_2.Blocks = {}
                u130[a1] = u130_2
                lock(u130_2)
                v4:Add(function() -- Line: 419 -- upvalues: restore (upval), u130_2 (val)
                    restore(u130_2)
                end)
                v4:Connect(a1.Destroying, function() -- Line: 422 -- upvalues: a1 (val), u130 (upval)
                    local v1 = a1
                    local v2 = u130[v1]
                    if v2 then
                        u130[v1] = nil
                        v2.Trove:Destroy()
                    end
                end)
                return
            end
            return
        end
    end
end

local function makePassable(a1) -- Line: 427 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
        end
    end
end

local function swing(a1) -- Line: 435 -- upvalues: makePassable (val), TweenService (val) -- types: a1: table
    makePassable(a1.Model)
    local CFrameValue = Instance.new("CFrameValue")
    CFrameValue.Value = a1.Closed
    CFrameValue.Changed:Connect(function(a1_2) -- Line: 439 -- upvalues: a1 (val) -- types: a1_2: userdata
        if a1.Model.Parent ~= nil then
            a1.Model:PivotTo(a1_2)
        end
    end)
    local v1 = TweenService:Create(CFrameValue, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Value = a1.Opened})
    v1.Completed:Once(function() -- Line: 449 -- upvalues: CFrameValue (val)
        CFrameValue:Destroy()
    end)
    v1:Play()
end

local function bindGate(a1) -- Line: 455
    -- upvalues: u131 (val), Workspace (val), BanjoCricket (val), u132 (ref), makePassable (val)
    if not u131[a1] and a1:IsA("Model") and a1:IsDescendantOf(Workspace) then
        local Pivot = a1:GetPivot()
        local Attribute = a1:GetAttribute(BanjoCricket.Attributes.DoorOpenAngle)
        local v1 = {
            Model = a1,
            Closed = Pivot,
            Opened = Pivot * CFrame.Angles(0, math.rad(if typeof(Attribute) ~= "number" then 100 else Attribute), 0),
        }
        u131[a1] = v1
        if u132 then
            a1:PivotTo(v1.Opened)
            makePassable(a1)
        end
        return
    end
end

local function openGates() -- Line: 474 -- upvalues: u132 (ref), u131 (val), swing (val)
    if u132 then
        return
    end
    u132 = true
    for i, j in u131 do
        swing(j)
    end
end

local function pluck(a1, a2, a3) -- Line: 484
    -- upvalues: BanjoCricket (val), Audio (val)
    local v1 = #BanjoCricket.Mushrooms
    local v2 = BanjoCricket.Mushrooms[a1 % v1 + 1]
    Audio.Play(v2.Sound, a2, {MaxDistance = 90, PlaybackSpeed = v2.Speed * 2 ^ (a1 // v1), Volume = a3})
end

local function noteColor(a1) -- Line: 494 -- upvalues: BanjoCricket (val) -- types: a1: number
    return BanjoCricket.Mushrooms[a1 % #BanjoCricket.Mushrooms + 1].Color
end

local function fadeLight(a1, a2, a3) -- Line: 499
    -- upvalues: TweenService (val)
    a1.Brightness = a2
    TweenService:Create(a1, TweenInfo.new(a3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0}):Play()
end

local function burst(a1, a2, a3, a4) -- Line: 508 -- types: a1: table, a2: vector, a3: number, a4: number
    local Burst = a1.Burst
    Burst.Attachment.WorldPosition = a2
    Burst.Sparkles:Emit(a3)
    if a4 > 0 then
        a1.Confetti.WorldPosition = a2
        for i, j in a1.Confetti:GetChildren() do
            if j:IsA("ParticleEmitter") then
                j:Emit(a4)
            end
        end
    end
end

local function bezier(a1, a2) -- Line: 522 -- types: a1: table, a2: number
    local v1 = 1 - a2
    return a1[1] * (v1 * v1 * v1) + a1[2] * (v1 * 3 * v1 * a2) + a1[3] * (v1 * 3 * a2 * a2) + a1[4] * (a2 * a2 * a2)
end

local function arc(a1, a2) -- Line: 530 -- upvalues: u144 (val) -- types: a1: vector, a2: vector
    local v1 = a2 - a1
    local Magnitude = v1.Magnitude
    local v2 = math.max(3, Magnitude * 0.35)
    local v3 = Vector3.new(v1.X, 0, v1.Z)
    local v4 = if not (0.001 < v3.Magnitude) then Vector3.new(1, 0, 0) else v3.Unit:Cross((Vector3.new(0, 1, 0)))
    v3 = Magnitude * 0.3
    local v5 = {}
    local v6 = a1 + v1 * 0.25 + Vector3.new(0, 1, 0) * v2 * u144:NextNumber(0.8, 1.3) + v4 * u144:NextNumber(-v3, v3)
    local v7 = a2 - v1 * 0.15 + Vector3.new(0, 1, 0) * v2 * u144:NextNumber(0.4, 0.9) + v4 * u144:NextNumber(-v3, v3) * 0.5
    v5[1] = a1
    v5[2] = v6
    v5[3] = v7
    v5[4] = a2
    return v5
end

local function moveFlyer(a1, a2) -- Line: 551 -- types: a1: table, a2: vector
    a1.Head.WorldPosition = a2 + Vector3.new(0, 0.25, 0)
    a1.Tail.WorldPosition = a2 - Vector3.new(0, 0.25, 0)
end

local function stepFlyer(a1, a2) -- Line: 556 -- upvalues: TweenService (val) -- types: a1: table, a2: number
    local v1 = math.clamp((a2 - a1.StartedAt) / a1.Seconds, 0, 1)
    local Points = a1.Points
    local v2 = 1 - v1
    local v3 = Points[1] * (v2 * v2 * v2) + Points[2] * (v2 * 3 * v2 * v1) + Points[3] * (v2 * 3 * v1 * v1) + Points[4] * (v1 * v1 * v1)
    a1.Head.WorldPosition = v3 + Vector3.new(0, 0.25, 0)
    a1.Tail.WorldPosition = v3 - Vector3.new(0, 0.25, 0)
    local Value = TweenService:GetValue(math.min(1, v1 / 0.2), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local v4 = math.min(1, (1 - v1) / 0.25)
    v2 = 2.2 * Value * (v4 * 0.7 + 0.3)
    a1.Gui.Size = UDim2.fromScale(v2, v2)
    a1.Image.Rotation = a1.Tilt + math.sin(a2 * a1.Wobble) * 25
    return v1 >= 1
end

local function retire(a1) -- Line: 571 -- types: a1: table
    if not a1.Dead then
        a1.Owner:Remove(a1.Trove)
    end
end

local function land(a1) -- Line: 577 -- upvalues: Lifetime (val), retire (val) -- types: a1: table
    a1.Gui.Enabled = false
    a1.Landed()
    task.delay(Lifetime, retire, a1)
end

local function stopCharge(a1) -- Line: 583 -- upvalues: fadeLight (val) -- types: a1: table
    if a1.StartedAt == nil then
        return
    end
    a1.StartedAt = nil
    a1.Anchor.Sparkles.Rate = 0
    fadeLight(a1.Anchor.Glow, a1.Anchor.Glow.Brightness, 0.4)
end

local function launch(a1, a2, a3, a4, a5, a6) -- Line: 592
    -- upvalues: NoteFlyer (val), BanjoCricket (val), u107 (val), arc (val), u144 (val), Workspace (val), u137 (val)
    local v1 = a1.Trove:Extend()
    local v2 = v1:Clone(NoteFlyer)
    local Head = v2:FindFirstChild("Head")
    local Tail = v2:FindFirstChild("Tail")
    v2 = Head:FindFirstChildWhichIsA("BillboardGui", true)
    local ImageLabel = v2:FindFirstChildWhichIsA("ImageLabel", true)
    local Trail = Head:FindFirstChildWhichIsA("Trail", true)
    local Color = BanjoCricket.Mushrooms[a5 % #BanjoCricket.Mushrooms + 1].Color
    v1:Add(Head)
    v1:Add(Tail)
    if #u107 > 0 then
        ImageLabel.Image = u107[a5 % #u107 + 1]
    end
    ImageLabel.ImageColor3 = Color
    if Trail then
        Trail.Color = ColorSequence.new(Color)
    end
    v2.Size = UDim2.fromScale(0, 0)
    local u76 = {
        Dead = false,
        Head = Head,
        Tail = Tail,
        Gui = v2,
        Image = ImageLabel,
        Trove = v1,
        Owner = a1.Trove,
    }
    u76.Points = arc(a2, a3)
    u76.StartedAt = os.clock()
    u76.Seconds = a4
    u76.Tilt = u144:NextNumber(-15, 15)
    u76.Wobble = u144:NextNumber(8, 14)
    u76.Landed = a6
    v1:Add(function() -- Line: 633 -- upvalues: u76 (val)
        u76.Dead = true
    end)
    Head.Position = a2 + Vector3.new(0, 0.25, 0)
    Tail.Position = a2 - Vector3.new(0, 0.25, 0)
    Head.Parent = Workspace.Terrain
    Tail.Parent = Workspace.Terrain
    table.insert(u137, u76)
end

local function chargeStep(a1, a2) -- Line: 643
    -- upvalues: u136 (ref), BanjoCricketFlags (val), BanjoCricket (val), launch (val), u144 (val), pluck (val)
    local StartedAt = a1.StartedAt
    local v1 = u136
    if a1.Phase == "Sealed" and StartedAt ~= nil and v1 ~= nil and v1.Parent ~= nil then
        local v2 = math.clamp((a2 - StartedAt) / BanjoCricketFlags.BridgePlaySeconds:Get(), 0, 1)
        local Anchor = a1.Anchor
        Anchor.Glow.Brightness = v2 * 3
        Anchor.Glow.Range = (v2 * 0.6 + 0.4) * 16
        Anchor.Sparkles.Rate = v2 * 35
        if a1.NextNoteAt <= a2 then
            a1.NextNoteAt = a2 + 0.16 + v2 * -0.11
            local u36 = math.floor(v2 * (#BanjoCricket.Mushrooms - 0.001))
            local WorldPosition = Anchor.Attachment.WorldPosition
            launch(a1, v1.WorldPosition, WorldPosition, u144:NextNumber(0.45, 0.7), u36, function() -- Line: 664 -- upvalues: Anchor (val), pluck (upval), u36 (val), WorldPosition (val)
                Anchor.Sparkles:Emit(3)
                pluck(u36, WorldPosition, 0.14)
            end)
        end
        return true
    end
    return false
end

local function eased(a1) -- Line: 673 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
end

local function endShot() -- Line: 681 -- upvalues: u145 (ref), Workspace (val)
    local v1 = u145
    if v1 == nil then
        return
    end
    u145 = nil
    local CurrentCamera = Workspace.CurrentCamera
    CurrentCamera.FieldOfView = v1.Fov
    CurrentCamera.CFrame = v1.From
    CurrentCamera.CameraType = v1.FromType
end

local function shotAlive() -- Line: 693 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local v1 = false
    if Humanoid ~= nil then
        v1 = 0 < Humanoid.Health
    end
    return v1
end

local function stepShot(a1) -- Line: 699
    -- upvalues: u145 (ref), LocalPlayer (val), Workspace (val), eased (val)
    local v1
    local v2 = u145
    if v2 == nil then
        return false
    end
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local v3 = false
    if Humanoid ~= nil then
        v3 = 0 < Humanoid.Health
    end
    if not v3 then
        v3 = u145
        if v3 ~= nil then
            u145 = nil
            local CurrentCamera = Workspace.CurrentCamera
            CurrentCamera.FieldOfView = v3.Fov
            CurrentCamera.CFrame = v3.From
            CurrentCamera.CameraType = v3.FromType
        end
        return false
    end
    local CurrentCamera_2 = Workspace.CurrentCamera
    local v4 = a1 - v2.StartedAt
    local EndsAt = v2.EndsAt
    if EndsAt ~= nil and not (a1 < EndsAt) then
        local v5 = (a1 - EndsAt) / 0.9
        if not (v5 >= 1) then
            v1 = v2.Held:Lerp(v2.From, (eased(v5)))
            v2.Kick = v2.Kick * math.exp(-9 * (a1 - v2.SteppedAt))
            v2.SteppedAt = a1
            CurrentCamera_2.CameraType = Enum.CameraType.Scriptable
            CurrentCamera_2.CFrame = v1
            CurrentCamera_2.FieldOfView = v2.Fov + v2.Kick
            return true
        end
        local v6 = u145
        if v6 ~= nil then
            u145 = nil
            local CurrentCamera_3 = Workspace.CurrentCamera
            CurrentCamera_3.FieldOfView = v6.Fov
            CurrentCamera_3.CFrame = v6.From
            CurrentCamera_3.CameraType = v6.FromType
        end
        return false
    end
    v2.Held = if not (v4 < 1) then v2.Open:Lerp(v2.Close, (eased((v4 - 1) / v2.DollySeconds))) else v2.From:Lerp(v2.Open, (eased(v4 / 1)))
    v2.Kick = v2.Kick * math.exp(-9 * (a1 - v2.SteppedAt))
    v2.SteppedAt = a1
    CurrentCamera_2.CameraType = Enum.CameraType.Scriptable
    CurrentCamera_2.CFrame = v1
    CurrentCamera_2.FieldOfView = v2.Fov + v2.Kick
    return true
end

local function kick(a1) -- Line: 736 -- upvalues: u145 (ref) -- types: a1: number
    local v1 = u145
    if v1 then
        v1.Kick = v1.Kick + a1
    end
end

local function step() -- Line: 743
    -- upvalues: u137 (val), stepFlyer (val), Lifetime (val), retire (val), u130 (val), chargeStep (val), stepShot (val)
    -- upvalues: u142 (ref), u141 (val)
    local v1
    local v2 = os.clock()
    for i = #u137, 1, -1 do
        v1 = u137[i]
        if v1.Dead then
            table.remove(u137, i)
        elseif stepFlyer(v1, v2) then
            table.remove(u137, i)
            v1.Gui.Enabled = false
            v1.Landed()
            task.delay(Lifetime, retire, v1)
        end
    end
    local v3 = false
    for j, k in u130 do
        if chargeStep(k, v2) then
            v3 = true
        end
    end
    local v4 = stepShot(v2)
    if #u137 == 0 and not v3 and not v4 then
        u142 = false
        u141:Clean()
    end
end

local function startStepping() -- Line: 767 -- upvalues: u142 (ref), u141 (val), RunService (val), step (val)
    if u142 then
        return
    end
    u142 = true
    u141:Connect(RunService.PreRender, step)
end

local function origin(a1) -- Line: 775 -- upvalues: u136 (ref) -- types: a1: table
    local v1 = u136
    if v1 and v1.Parent then
        return v1.WorldPosition
    end
    return a1.Start.Position
end

local function deckPoint(a1, a2) -- Line: 783 -- types: a1: table, a2: number
    local v1 = a1.Near:Lerp(a1.Far, a2)
    return (Vector3.new(v1.X, a1.DeckTop, v1.Z))
end

local function film(a1, a2) -- Line: 788
    -- upvalues: u145 (ref), GuiService (val), Workspace (val), u142 (ref), u141 (val), RunService (val), step (val)
    if not u145 and not GuiService.ReducedMotionEnabled then
        local CurrentCamera = Workspace.CurrentCamera
        local v1 = a1.Near:Lerp(a1.Far, 0)
        local v2 = Vector3.new(v1.X, a1.DeckTop, v1.Z)
        v1 = (CurrentCamera.CFrame.Position - v2):Dot(a1.Side)
        local Side_2 = a1.Side
        local v3 = Side_2 * (if not (v1 >= 0) then -1 else 1)
        local Length = a1.Length
        local Direction = a1.Direction
        local v4 = v2 - Direction * 16 + Vector3.new(0, 12, 0) + v3 * 8
        local v5 = v2 + Direction * Length * 0.3 + Vector3.new(0, 16, 0) + v3 * 22
        v3 = os.clock()
        u145 = {
            Kick = 0,
            Crossing = a1,
            From = CurrentCamera.CFrame,
            FromType = CurrentCamera.CameraType,
            Fov = CurrentCamera.FieldOfView,
            Open = CFrame.lookAt(v4, v2 + Direction * Length * 0.45),
            Close = CFrame.lookAt(v5, v2 + Direction * Length * 0.62),
            StartedAt = v3,
            DollySeconds = a2,
            Held = CurrentCamera.CFrame,
            SteppedAt = v3,
        }
        a1.Trove:Add(function() -- Line: 817 -- upvalues: u145 (upval), a1 (val), Workspace (upval)
            local v1 = u145
            if v1 and v1.Crossing == a1 then
                local v2 = u145
                if v2 == nil then
                    return
                end
                u145 = nil
                local CurrentCamera = Workspace.CurrentCamera
                CurrentCamera.FieldOfView = v2.Fov
                CurrentCamera.CFrame = v2.From
                CurrentCamera.CameraType = v2.FromType
            end
        end)
        if u142 then
            return
        end
        u142 = true
        u141:Connect(RunService.PreRender, step)
        return
    end
end

local function celebrate(a1) -- Line: 826
    -- upvalues: TweenService (val), BanjoCricket (val), pluck (val), burst (val), fadeLight (val), u145 (ref)
    local Beam, v1
    local v2 = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    for i, j in a1.Strands do
        Beam = j.Beam
        Beam.Width0 = j.Width0 * 1.7
        Beam.Width1 = j.Width1 * 1.7
        Beam.Brightness = j.Brightness * 2.5
        TweenService:Create(Beam, v2, {Width0 = j.Width0, Width1 = j.Width1, Brightness = j.Brightness}):Play()
    end
    v2 = #BanjoCricket.Mushrooms
    local v3 = a1.Near:Lerp(a1.Far, 0.5)
    pluck(0, v3, 0.45)
    local v4 = v2 - 1
    for k = 0, v4 do
        a1.Trove:Add((task.delay(k * 0.035, pluck, v2 + k, v3, 0.45)))
    end
    for n = 0, 5 do
        v1 = a1.Near:Lerp(a1.Far, (n + 0.5) / 6)
        burst(a1, Vector3.new(v1.X, a1.DeckTop, v1.Z), 20, 4)
    end
    a1.Burst.Attachment.WorldPosition = v3
    fadeLight(a1.Burst.Glow, 8, 0.9)
    v3 = u145
    if v3 then
        v3.Kick = v3.Kick + 5
    end
    v4 = u145
    if v4 and v4.Crossing == a1 then
        v4.EndsAt = os.clock() + 0.8
    end
end

local function sweep(a1) -- Line: 860 -- upvalues: TweenService (val) -- types: a1: table
    local Size, v1, v2, v3, v4, v5
    for i, j in a1.Blocks do
        Size = j.Size
        v4 = TweenService
        v1 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, (i - 1) * 0.035)
        v2 = {Transparency = 0, Color = Color3.new(1, 1, 1)}
        v4 = v4:Create(j, v1, v2)
        v5 = TweenService
        v2 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        v3 = {
            Transparency = 1,
            Size = Size * Vector3.new(1.100000023841858, 0.30000001192092896, 1.100000023841858),
        }
        local u48 = v5:Create(j, v2, v3)
        v4.Completed:Once(function() -- Line: 880 -- upvalues: j (val), u48 (val)
            if j.Parent then
                u48:Play()
            end
        end)
        u48.Completed:Once(function() -- Line: 885 -- upvalues: j (val)
            j:Destroy()
        end)
        v4:Play()
    end
    table.clear(a1.Blocks)
end

local function settle(a1) -- Line: 893
    -- upvalues: u132 (ref), u131 (val), swing (val), sweep (val), TweenService (val), celebrate (val)
    local Far
    a1.Phase = "Open"
    if not u132 then
        u132 = true
        for i, j in u131 do
            swing(j)
        end
    end
    for k, n in a1.Strands do
        Far = n.Far
        if Far then
            if not n.FarIsZero then
                n.Beam.Attachment1 = Far
            else
                n.Beam.Attachment0 = Far
            end
        end
    end
    a1.Barrier.Part.CanCollide = a1.Barrier.CanCollide
    sweep(a1)
    local v1 = TweenInfo.new(0.35, Enum.EasingStyle.Quad)
    for m, i5 in a1.Pieces do
        i5.Part.CanCollide = i5.CanCollide
        a1.Trove:Add((TweenService:Create(i5.Part, v1, {Transparency = i5.Transparency}))):Play()
    end
    celebrate(a1)
end

local function makeTip(a1, a2) -- Line: 916
    -- upvalues: Notes (val), scaled (val), setNotes (val), Workspace (val)
    local v1 = a1.Trove:Add((Notes:Clone()))
    v1.Name = "BanjoBridgeTip"
    for i, j in v1:GetChildren() do
        if j:IsA("ParticleEmitter") then
            j.Size = scaled(j.Size, 3)
        end
    end
    setNotes(v1, true)
    v1.Parent = Workspace.Terrain
    v1.WorldPosition = a2
    return v1
end

local function sprout(a1, a2) -- Line: 930
    -- upvalues: makeTip (val), TweenService (val), Quart (val)
    local Beam, Far, Near, v1, v2
    local v3 = {}
    local v4 = {}
    local Strands = a1.Strands
    local v5 = nil
    local v6 = nil
    local v7, v8 = a1, a2
    for i, j in Strands, v5, v6 do
        Near = j.Near
        Far = j.Far
        if Near and Far then
            v1 = v4[Far]
            if v1 == nil then
                v2 = makeTip(v7, Near.WorldPosition)
                v4[Far] = v2
                table.insert(v3, {
                    Attachment = v2,
                    Lane = {Near = Near.WorldPosition, Far = Far.WorldPosition},
                })
                v1 = v2
            end
            if not j.FarIsZero then
                j.Beam.Attachment1 = v1
            else
                j.Beam.Attachment0 = v1
            end
        end
        Beam = j.Beam
        Beam.Width0 = j.Width0 * 0.12
        Beam.Width1 = j.Width1 * 0.12
        Beam.Enabled = j.Enabled
        v7.Trove:Add((TweenService:Create(Beam, TweenInfo.new(v8, Quart, Enum.EasingDirection.Out), {Width0 = j.Width0, Width1 = j.Width1}))):Play()
    end
    return v3
end

local function advance(a1, a2, a3) -- Line: 965
    -- upvalues: TweenService (val)
    local v1 = TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    for i, j in a2 do
        a1.Trove:Add((TweenService:Create(j.Attachment, v1, {WorldPosition = j.Lane.Near:Lerp(j.Lane.Far, a3)}))):Play()
    end
end

local function slam(a1, a2) -- Line: 976
    -- upvalues: Block (val), Workspace (val), TweenService (val), BanjoCricket (val), burst (val), fadeLight (val)
    -- upvalues: pluck (val), u145 (ref)
    local v1 = a1.Length / 12
    local v2 = a1.Near:Lerp(a1.Far, (a2 + 0.5) / 12)
    local v3 = Vector3.new(v2.X, a1.DeckTop, v2.Z) - Vector3.new(0, 0.25, 0)
    local v4 = Vector3.new(a1.Width, 0.5, v1 * 0.86)
    local u30 = a1.Trove:Clone(Block)
    u30.CFrame = CFrame.lookAt(v3, v3 + a1.Direction)
    u30.Size = v4 * Vector3.new(1.350000023841858, 2.700000047683716, 1.350000023841858)
    u30.Transparency = 0
    u30.Parent = Workspace
    table.insert(a1.Blocks, u30)
    local u66 = TweenService:Create(u30, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.06), {
        Transparency = 0.55,
        Color = BanjoCricket.Mushrooms[a2 % #BanjoCricket.Mushrooms + 1].Color,
    })
    v2 = TweenService:Create(u30, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = v4})
    v2.Completed:Once(function() -- Line: 1004 -- upvalues: u30 (val), u66 (val)
        if u30.Parent then
            u66:Play()
        end
    end)
    v2:Play()
    v2 = v3 + Vector3.new(0, 0.5, 0)
    burst(a1, v2, 14, 2)
    a1.Burst.Attachment.WorldPosition = v2
    fadeLight(a1.Burst.Glow, 4, 0.3)
    pluck(a2, v3, 0.5)
    v2 = u145
    if v2 then
        v2.Kick = v2.Kick + 1.6
    end
end

local function open(a1) -- Line: 1018
    -- upvalues: fadeLight (val), film (val), sprout (val), launch (val), u136 (ref), slam (val), advance (val)
    -- upvalues: u142 (ref), u141 (val), RunService (val), step (val), settle (val), setNotes (val)
    local v1, v2
    if a1.StartedAt ~= nil then
        a1.StartedAt = nil
        a1.Anchor.Sparkles.Rate = 0
        fadeLight(a1.Anchor.Glow, a1.Anchor.Glow.Brightness, 0.4)
    end
    a1.Phase = "Forming"
    local Anchor = a1.Anchor
    Anchor.Sparkles:Emit(20)
    fadeLight(Anchor.Glow, 8, 0.9)
    film(a1, 4.11)
    local u34 = sprout(a1, 4.96)
    for i = 0, 11 do
        v1 = i * 0.36 + 1
        v2 = a1.Near:Lerp(a1.Far, (i + 0.5) / 12)
        local u59 = Vector3.new(v2.X, a1.DeckTop, v2.Z) + Vector3.new(0, 0.4000000059604645, 0)
        a1.Trove:Add((task.delay(v1 - 0.55, function() -- Line: 1031
            -- upvalues: launch (upval), a1 (val), u136 (upval), u59 (val), i (val), slam (upval), advance (upval)
            -- upvalues: u34 (val), u142 (upval), u141 (upval), RunService (upval), step (upval)
            local v1 = launch
            local v2 = a1
            local v3 = u136
            local WorldPosition = if not v3 then v2.Start.Position else if not v3.Parent then v2.Start.Position else v3.WorldPosition
            v1(a1, WorldPosition, u59, 0.55, i, function() -- Line: 1032 -- upvalues: slam (upval), a1 (upval), i (upval), advance (upval), u34 (upval)
                slam(a1, i)
                advance(a1, u34, (i + 1) / 12)
            end)
            if u142 then
                return
            end
            u142 = true
            v2 = step
            u141:Connect(RunService.PreRender, v2)
        end)))
    end
    a1.Trove:Add((task.delay(5.11, function() -- Line: 1040 -- upvalues: settle (upval), a1 (val), u34 (val), setNotes (upval)
        settle(a1)
        for i, j in u34 do
            setNotes(j.Attachment, false)
        end
    end)))
    a1.Trove:Add((task.delay(6.3100000000000005, function() -- Line: 1046 -- upvalues: u34 (val)
        for i, j in u34 do
            j.Attachment:Destroy()
        end
    end)))
end

local function banjoNotes(a1) -- Line: 1053 -- upvalues: Notes (val), setNotes (val) -- types: a1: userdata
    local BasePart = a1:FindFirstChildWhichIsA("BasePart")
    if BasePart == nil then
        return nil
    end
    local BanjoBridgeNotes = BasePart:FindFirstChild("BanjoBridgeNotes")
    if BanjoBridgeNotes and BanjoBridgeNotes:IsA("Attachment") then
        return BanjoBridgeNotes
    end
    local v1 = Notes:Clone()
    v1.Name = "BanjoBridgeNotes"
    setNotes(v1, false)
    v1.Parent = BasePart
    return v1
end

local function play(a1) -- Line: 1069 -- upvalues: u136 (ref), setNotes (val) -- types: a1: userdata?
    local v1 = u136
    if v1 ~= a1 then
        if v1 then
            setNotes(v1, false)
        end
        u136 = a1
        if a1 then
            setNotes(a1, true)
        end
    end
end

local function update() -- Line: 1082
    -- upvalues: LocalPlayer (val), BanjoCricketFlags (val), BanjoCricket (val), u130 (val), fadeLight (val), u136 (ref)
    -- upvalues: setNotes (val), u142 (ref), u141 (val), RunService (val), step (val), open (val), banjoNotes (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local Tool = Character and Character:FindFirstChildOfClass("Tool")
    if BanjoCricketFlags.Enabled:Get()
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart")
        and Humanoid ~= nil
        and not (Humanoid.Health <= 0)
        and Tool ~= nil
        and (Tool:GetAttribute("GearName")) == BanjoCricket.GearId then
        local Magnitude, StartedAt, v1
        local v2 = os.clock()
        local v3 = false
        local v4 = nil
        local v5 = nil
        for i, j in u130, v4, v5 do
            if j.Phase == "Forming" then
                v3 = true
            elseif j.Phase ~= "Open" then
                Magnitude = (HumanoidRootPart.Position - j.Start.Position).Magnitude
                if not (BanjoCricketFlags.BridgeReach:Get() < Magnitude) then
                    v3 = true
                    StartedAt = j.StartedAt
                    if StartedAt == nil then
                        j.StartedAt = v2
                        j.NextNoteAt = v2
                        StartedAt = v2
                        if not u142 then
                            u142 = true
                            u141:Connect(RunService.PreRender, step)
                        end
                    end
                    v1 = v2 - StartedAt
                    if BanjoCricketFlags.BridgePlaySeconds:Get() <= v1 then
                        open(j)
                    end
                elseif j.StartedAt ~= nil then
                    j.StartedAt = nil
                    j.Anchor.Sparkles.Rate = 0
                    fadeLight(j.Anchor.Glow, j.Anchor.Glow.Brightness, 0.4)
                end
            end
        end
        Tool:SetAttribute("BanjoBridgePlaying", v3)
        local v6 = if not v3 then nil else banjoNotes(Tool)
        v2 = u136
        if v2 ~= v6 then
            if v2 then
                setNotes(v2, false)
            end
            u136 = v6
            if v6 then
                setNotes(v6, true)
            end
        end
        return
    end
    for k, n in u130 do
        if n.StartedAt ~= nil then
            n.StartedAt = nil
            n.Anchor.Sparkles.Rate = 0
            fadeLight(n.Anchor.Glow, n.Anchor.Glow.Brightness, 0.4)
        end
    end
    if Tool and (Tool:GetAttribute("GearName")) == BanjoCricket.GearId then
        Tool:SetAttribute("BanjoBridgePlaying", false)
    end
    local v7 = u136
    if v7 ~= nil then
        if v7 then
            setNotes(v7, false)
        end
        u136 = nil
    end
end

function v1.Start() -- Line: 1138
    -- upvalues: BanjoCricket (val), CollectionService (val), bind (val), unbind (val), bindGate (val), u131 (val)
    -- upvalues: Timer (val), update (val)
    local Bridge = BanjoCricket.Tags.Bridge
    ;(CollectionService:GetInstanceAddedSignal(Bridge)):Connect(bind)
    ;(CollectionService:GetInstanceRemovedSignal(Bridge)):Connect(unbind)
    for i, j in CollectionService:GetTagged(Bridge) do
        bind(j)
    end
    local Gate = BanjoCricket.Tags.Gate
    ;(CollectionService:GetInstanceAddedSignal(Gate)):Connect(bindGate)
    ;(CollectionService:GetInstanceRemovedSignal(Gate)):Connect(function(a1) -- Line: 1147 -- upvalues: u131 (upval)
        u131[a1] = nil
    end)
    for k, n in CollectionService:GetTagged(Gate) do
        bindGate(n)
    end
    Timer.Simple(0.3, update)
end

return (table.freeze(v1))