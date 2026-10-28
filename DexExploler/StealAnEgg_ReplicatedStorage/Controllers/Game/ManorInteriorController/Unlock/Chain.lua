-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Unlock.Chain
-- Decompile time: 23.22 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Sfx = require(script.Parent.Sfx)
require(ReplicatedStorage.Packages.Trove)
local u38 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u43 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u44 = nil
local u45 = {}

local function template() -- Line: 104 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local ManorInterior = Assets and Assets:FindFirstChild("ManorInterior")
    local v1 = ManorInterior and ManorInterior:FindFirstChild("ChainLinks")
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function lockParts(a1) -- Line: 111 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function quietClone(a1, a2) -- Line: 121 -- types: a1: userdata, a2: userdata
    local Archivable = a1.Archivable
    a1.Archivable = true
    local v1 = a1:Clone()
    a1.Archivable = Archivable
    for i, j in v1:GetChildren() do
        if not j:IsA("SurfaceAppearance") and not j:IsA("Decal") then
            j:Destroy()
        end
    end
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.Transparency = 0
    v1.Parent = a2
    return v1
end

local function emitters(a1, a2) -- Line: 140 -- types: a1: userdata, a2: vector
    local Part = Instance.new("Part")
    Part.Name = "Sparks"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a2)
    Part.Parent = a1
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local v1 = Instance.new("ParticleEmitter")
    v1.Name = "Spark"
    v1.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    v1.Rate = 0
    v1.LightEmission = 1
    v1.LightInfluence = 0
    v1.Color = ColorSequence.new(Color3.fromRGB(255, 236, 170), Color3.fromRGB(255, 120, 40))
    v1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), (NumberSequenceKeypoint.new(1, 0))})
    v1.Lifetime = NumberRange.new(0.25, 0.5)
    v1.Speed = NumberRange.new(14, 26)
    v1.SpreadAngle = Vector2.new(180, 180)
    v1.Drag = 4
    v1.Acceleration = Vector3.new(0, -30, 0)
    v1.Parent = Attachment
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Dust"
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    ParticleEmitter.Rate = 0
    ParticleEmitter.LightInfluence = 0.6
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(150, 135, 150), Color3.fromRGB(95, 85, 100))
    ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), (NumberSequenceKeypoint.new(1, 1))})
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), (NumberSequenceKeypoint.new(1, 6))})
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1.1)
    ParticleEmitter.Speed = NumberRange.new(6, 12)
    ParticleEmitter.SpreadAngle = Vector2.new(70, 70)
    ParticleEmitter.Drag = 3
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.RotSpeed = NumberRange.new(-60, 60)
    ParticleEmitter.Parent = Attachment
    return Attachment, v1, ParticleEmitter
end

local function middle(a1) -- Line: 194 -- types: a1: userdata
    local Attribute = a1:GetAttribute("Center")
    if typeof(Attribute) == "Vector3" then
        return a1.CFrame:PointToWorldSpace(Attribute)
    end
    return a1.Position
end

local function launch(a1, a2, a3, a4, a5) -- Line: 202
    -- upvalues: 
    local Attribute = a2:GetAttribute("Center")
    local Position = if typeof(Attribute) ~= "Vector3" then a2.Position else a2.CFrame:PointToWorldSpace(Attribute)
    local Size = a2.Size
    table.insert(a1.Movers, {
        Resting = false,
        Plowed = false,
        Part = a2,
        Center = Position,
        Rel = (CFrame.new(Position)):ToObjectSpace(a2.CFrame),
        Turned = CFrame.identity,
        Velocity = a3,
        Turn = a4,
        Half = math.min(Size.X, Size.Y, Size.Z) / 2 * 0.8,
        Radius = math.max(Size.X, Size.Y, Size.Z) * 0.3,
        Loud = a5,
    })
end

local function move(a1, a2, a3) -- Line: 220 -- upvalues: Sfx (val) -- types: a1: table, a2: table, a3: number
    if not a2.Resting and a2.Part.Parent ~= nil then
        local v1 = a2.Velocity - Vector3.new(0, 1, 0) * (a3 * 196)
        local v2 = a2.Center + v1 * a3
        local v3 = a1.Ground + a2.Half
        if v2.Y <= v3 then
            v2 = Vector3.new(v2.X, v3, v2.Z)
            if not (v1.Y < -6) then
                v1 = Vector3.new(0, 0, 0)
                a2.Turn = Vector3.new(0, 0, 0)
                a2.Resting = true
            else
                if a2.Loud then
                    Sfx.At("PadlockClunk", v2, math.clamp(-v1.Y / 40, 0.2, 0.7), 0.9)
                end
                v1 = Vector3.new(v1.X * 0.55, -v1.Y * 0.3, v1.Z * 0.55)
                a2.Turn = a2.Turn * 0.5
            end
        end
        a2.Velocity = v1
        a2.Center = v2
        local Turn = a2.Turn
        if 0.001 < Turn.Magnitude then
            a2.Turned = (CFrame.fromAxisAngle(Turn.Unit, Turn.Magnitude * a3)) * a2.Turned
        end
        a2.Part.CFrame = (CFrame.new(v2)) * a2.Turned * a2.Rel
        return
    end
end

local function release(a1, a2, a3, a4) -- Line: 250
    -- upvalues: launch (val)
    local Position
    if a2.Released then
        return
    end
    a2.Released = true
    local Part = a2.Part
    local Random = a1.Random
    local Attribute = Part:GetAttribute("Center")
    local v1 = (if typeof(Attribute) ~= "Vector3" then Part.Position else Part.CFrame:PointToWorldSpace(Attribute)) - a1.Center
    v1 = Vector3.new(v1.X, v1.Y * 0.6, v1.Z)
    local Unit = if not (0.1 < v1.Magnitude) then Vector3.new(0, 1, 0) else v1.Unit
    if a4 then
        launch(a1, Part, a3, Vector3.new(0, 0, 0), false)
        return
    end
    local Unit_2 = Vector3.new(0, 1, 0):Cross(a3).Unit
    local v2 = if not (0 <= ((Position - a1.Center):Dot(Unit_2))) then -1 else 1
    launch(
        a1,
        Part,
        a3 * Random:NextNumber(0, 0.5) + Unit_2 * (v2 * Random:NextNumber(13, 20)) + Unit * Random:NextNumber(1, 2.5) + Vector3.new(0, 1, 0) * Random:NextNumber(-4, 1),
        (a3:Cross(Unit)) * Random:NextNumber(2, 5) + Vector3.new(Random:NextNumber(-2, 2), Random:NextNumber(-2, 2), (Random:NextNumber(-2, 2))),
        false
    )
    a1.Sparks.WorldPosition = Position
    a1.Emitter:Emit(4)
end

local function place(a1) -- Line: 286 -- types: a1: table
    a1.Part.CFrame = (CFrame.new(a1.Center)) * a1.Turned * a1.Rel
end

local function groundBelow(a1, a2, a3) -- Line: 290
    -- upvalues: Players (val), Workspace (val)
    local v1 = {a1}
    local Parent = a1.Parent
    if Parent ~= nil then
        table.insert(v1, Parent)
    end
    for i, j in Players:GetPlayers() do
        if j.Character ~= nil then
            table.insert(v1, j.Character)
        end
    end
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.FilterDescendantsInstances = v1
    v2.IgnoreWater = true
    v1 = Workspace:Raycast(a2, Vector3.new(-0, -60, -0), v2)
    if v1 ~= nil and not (1 <= v1.Instance.Transparency) and not (v1.Position.Y < a3) then
        return v1.Position.Y
    end
    return a3
end

local function drop(a1, a2, a3, a4) -- Line: 312
    -- upvalues: launch (val), release (val), Sfx (val)
    local Random = a1.Random
    local Padlock = a1.Padlock
    local Shackle = a1.Shackle
    local v1 = Padlock or Shackle
    if v1 ~= nil then
        if not a3 then
            local Unit = Vector3.new(0, 1, 0):Cross(a2).Unit
            local v2 = if not ((Random:NextNumber()) < 0.5) then 1 else -1
            if a4 ~= nil and a4:Dot(Unit) ~= 0 then
                v2 = if not (0 < (a4:Dot(Unit))) then -1 else 1
            end
            launch(
                a1,
                v1,
                a2 * Random:NextNumber(0.3, 0.8) + Unit * (v2 * Random:NextNumber(18, 23)) + Vector3.new(0, 1, 0) * Random:NextNumber(3, 5),
                Vector3.new(Random:NextNumber(-3, 3), Random:NextNumber(-2, 2), (Random:NextNumber(-3, 3))),
                true
            )
        else
            launch(a1, v1, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), false)
        end
        if Padlock ~= nil and Shackle ~= nil then
            table.insert(a1.Riders, {
                Part = Shackle,
                Base = Padlock,
                Rel = Padlock.CFrame:ToObjectSpace(Shackle.CFrame),
            })
        end
    end
    local u113 = #a1.Pieces
    local Distance = if not (u113 > 0) then 1 else a1.Pieces[u113].Distance
    local u119 = 0
    local v3 = nil
    local v4 = nil
    for i, j in a1.Pieces, v3, v4 do
        a1.Trove:Add((task.delay(if not a3 then j.Distance / math.max(Distance, 1) * 0.18 else 0, function() -- Line: 353
            -- upvalues: release (upval), a1 (val), j (val), a2 (val), a3 (val), u119 (ref), i (val), Sfx (upval)
            -- upvalues: u113 (val)
            release(a1, j, a2, a3)
            if not a3 and u119 < 12 and i % 2 == 1 then
                u119 = u119 + 1
                local At = Sfx.At
                local Part = j.Part
                local Attribute = Part:GetAttribute("Center")
                At(
                    "LinkClink",
                    if typeof(Attribute) ~= "Vector3" then Part.Position else Part.CFrame:PointToWorldSpace(Attribute),
                    0.5,
                    i / math.max(u113, 1) * 0.6 + 1
                )
            end
        end)))
    end
end

function u45.Hide(a1, a2) -- Line: 367 -- upvalues: lockParts (val) -- types: a1: userdata, a2: boolean
    local Attribute, Transparency, v1
    for i, j in lockParts(a1) do
        if not a2 then
            Attribute = j:GetAttribute("ManorHidden")
            v1 = if type(Attribute) ~= "number" then 0 else Attribute
            j.Transparency = v1
            j:SetAttribute("ManorHidden", nil)
            j.CanCollide = true
            j.CanQuery = true
            j.CanTouch = true
        else
            if j:GetAttribute("ManorHidden") == nil then
                Transparency = j.Transparency
                j:SetAttribute("ManorHidden", Transparency)
            end
            j.Transparency = 1
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
        end
    end
end

function u45.Prepare(a1, a2) -- Line: 388
    -- upvalues: u45 (val), lockParts (val), ReplicatedStorage (val), quietClone (val), emitters (val), Workspace (val)
    -- upvalues: groundBelow (val), RunService (val), move (val)
    u45.Sweep()
    local v1 = a1:Add((Instance.new("Folder")))
    v1.Name = "ManorChainBurst"
    local v2 = a2:FindFirstChild("Cube.003", true)
    local v3 = a2:FindFirstChild("Cube.004", true)
    local Position = if v2 == nil then a2:GetBoundingBox().Position else if not v2:IsA("BasePart") then a2:GetBoundingBox().Position else v2.Position
    local v4 = {}
    local u346 = {}
    for i, j in lockParts(a2) do
        u346[j] = j.CFrame
        if string.sub(j.Name, 1, 8) == "Cylinder" then
            table.insert(v4, j)
        end
    end
    local v5 = {}
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local ManorInterior = Assets and Assets:FindFirstChild("ManorInterior")
    local v6 = ManorInterior and ManorInterior:FindFirstChild("ChainLinks")
    local v7 = if v6 == nil then nil else if not v6:IsA("Model") then nil else v6
    if v7 ~= nil then
        local Attribute, Attribute_2, Magnitude, v8
        v6 = v7:Clone()
        v6:PivotTo((a2:GetPivot()))
        for k, n in v6:GetChildren() do
            if n:IsA("BasePart") then
                n.Anchored = true
                n.CanCollide = false
                n.CanQuery = false
                n.CanTouch = false
                n.Transparency = 1
                Attribute = n:GetAttribute("Distance")
                v8 = {Released = false, Part = n}
                if type(Attribute) ~= "number" then
                    Attribute_2 = n:GetAttribute("Center")
                    Magnitude = ((if typeof(Attribute_2) ~= "Vector3" then n.Position else n.CFrame:PointToWorldSpace(Attribute_2)) - Position).Magnitude
                else
                    Magnitude = Attribute
                end
                v8.Distance = Magnitude
                table.insert(v5, v8)
                n.Parent = v1
            end
        end
        v6:Destroy()
    end
    table.sort(v5, function(a1, a2) -- Line: 430 -- types: a1: table, a2: table
        return a1.Distance < a2.Distance
    end)
    v7 = if v2 == nil then nil else if not v2:IsA("BasePart") then nil else quietClone(v2, v1)
    v6 = if v3 == nil then nil else if not v3:IsA("BasePart") then nil else quietClone(v3, v1)
    if v7 ~= nil then
        v7.Transparency = 1
    end
    if v6 ~= nil then
        v6.Transparency = 1
    end
    local v9, v10, v11 = emitters(v1, Position)
    v1.Parent = Workspace
    local u248 = {
        Snapped = false,
        Trove = a1,
        Lock = a2,
        Folder = v1,
        Pieces = v5,
        Padlock = v7,
        Shackle = v6,
    }
    u248.PadlockSource = if v2 == nil then nil else if not v2:IsA("BasePart") then nil else v2
    u248.ShackleSource = if v3 == nil then nil else if not v3:IsA("BasePart") then nil else v3
    u248.Chains = v4
    u248.Rest = u346
    u248.Sparks = v9
    u248.Emitter = v10
    u248.Dust = v11
    u248.Random = Random.new()
    u248.Center = Position
    u248.Ground = groundBelow(a2, Position, a2:GetBoundingBox().Position.Y - a2:GetExtentsSize().Y / 2)
    u248.Movers = {}
    u248.Riders = {}
    a1:Connect(RunService.Heartbeat, function(a1) -- Line: 476 -- upvalues: u248 (val), move (upval), Workspace (upval) -- types: a1: number
        for i, j in u248.Movers do
            move(u248, j, a1)
        end
        for k, n in u248.Riders do
            if n.Part.Parent ~= nil then
                n.Part.CFrame = n.Base.CFrame * n.Rel
            end
        end
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            local v1
            for m, i5 in u248.Movers do
                v1 = (i5.Part.Position - CurrentCamera.CFrame.Position).Magnitude - i5.Part.Size.Magnitude * 0.35
                i5.Part.LocalTransparencyModifier = math.clamp((6 - v1) / 2.5, 0, 1)
            end
        end
    end)
    a1:Add(function() -- Line: 496 -- upvalues: u346 (val)
        for i, j in u346 do
            if i.Parent ~= nil then
                i.CFrame = j
            end
        end
    end)
    return u248
end

function u45.Rattle(a1, a2, a3) -- Line: 506 -- types: a1: table, a2: number, a3: number
    local v1, v2
    if a1.Snapped then
        return
    end
    for i, j in a1.Chains do
        v1 = a1.Rest[j]
        if v1 ~= nil then
            v2 = math.sin(a3 * 70 + i * 1.7) * 0.15 * a2
            j.CFrame = v1 * CFrame.new(v2, v2 * 0.5, 0)
        end
    end
end

function u45.Nudge(a1, a2, a3) -- Line: 519 -- types: a1: table, a2: userdata?, a3: vector
    if a2 == nil then
        return
    end
    local v1 = a1.Rest[a2]
    if v1 ~= nil then
        a2.CFrame = v1 + a3
    end
end

function u45.Settle(a1) -- Line: 529 -- types: a1: table
    for i, j in a1.Rest do
        if i.Parent ~= nil then
            i.CFrame = j
        end
    end
end

function u45.Snap(a1, a2, a3, a4, a5) -- Line: 537
    -- upvalues: u45 (val), quietClone (val), TweenService (val), u38 (val), drop (val), Sfx (val)
    if a1.Snapped then
        return
    end
    a1.Snapped = true
    if a1.Padlock ~= nil and a1.PadlockSource ~= nil then
        a1.Padlock.CFrame = a1.PadlockSource.CFrame
    end
    if a1.Shackle ~= nil and a1.ShackleSource ~= nil then
        a1.Shackle.CFrame = a1.ShackleSource.CFrame
    end
    u45.Settle(a1)
    for i, j in a1.Pieces do
        j.Part.Transparency = 0
    end
    if a1.Padlock ~= nil then
        a1.Padlock.Transparency = 0
    end
    if a1.Shackle ~= nil then
        a1.Shackle.Transparency = 0
    end
    u45.Hide(a1.Lock, true)
    if #a1.Pieces == 0 then
        for k, n in a1.Chains do
            TweenService:Create(quietClone(n, a1.Folder), u38, {Transparency = 1}):Play()
        end
    end
    a1.Sparks.WorldPosition = a1.Center
    if not a3 then
        a1.Emitter:Emit(24)
    end
    a1.Dust:Emit(10)
    local Random = a1.Random
    a1.Trove:Add((task.delay(a4, function() -- Line: 571 -- upvalues: drop (upval), a1 (val), a2 (val), a3 (val), a5 (val)
        drop(a1, a2, a3, a5)
    end)))
    for m = 1, 2 do
        a1.Trove:Add((task.delay(a4 + 0.45 + m * 0.28, function() -- Line: 575 -- upvalues: a1 (val), Sfx (upval), m (val)
            local Padlock = a1.Padlock
            local Position = if Padlock == nil then a1.Center else Padlock.Position
            Sfx.At("PadlockClunk", Position, 0.7 / m, m * 0.08 + 0.9)
        end)))
    end
    for i5 = 1, 6 do
        a1.Trove:Add((task.delay(a4 + 0.3 + i5 * 0.11 + Random:NextNumber(0, 0.06), function() -- Line: 582 -- upvalues: a1 (val), Random (val), Sfx (upval)
            local Position
            local v1 = a1.Pieces[Random:NextInteger(1, (math.max(#a1.Pieces, 1)))]
            if v1 == nil then
                Position = a1.Center
            else
                local Part = v1.Part
                local Attribute = Part:GetAttribute("Center")
                Position = if typeof(Attribute) ~= "Vector3" then Part.Position else Part.CFrame:PointToWorldSpace(Attribute)
            end
            Sfx.At("LinkClink", Position, 0.35, Random:NextNumber(0.7, 0.95))
        end)))
    end
end

function u45.Plow(a1, a2, a3) -- Line: 591 -- upvalues: Sfx (val) -- types: a1: table, a2: table, a3: vector
    local Along, Radius, v1, v2, v3, v4, v5, v6
    if not a1.Snapped then
        return
    end
    local Movers = a1.Movers
    local v7 = nil
    local v8 = nil
    local v9, v10 = a2, a3
    for i, j in Movers, v7, v8 do
        if j.Part.Parent ~= nil then
            v6 = nil
            v1 = nil
            for k, n in v9, v6, v1 do
                Along = n.Along
                v3 = Vector3.new(0, 1, 0):Cross(Along)
                if (v3:Dot(v10)) < 0 then
                    v3 = -v3
                end
                v4 = j.Center - n.Hinge
                v4 = Vector3.new(v4.X, 0, v4.Z)
                v5 = v4:Dot(Along)
                v2 = v4:Dot(v3)
                Radius = j.Radius
                if not (v5 < 0)
                    and not (n.Reach + Radius * 0.5 < v5)
                    and not (Radius <= v2)
                    and not (v2 <= -1.5)
                    and not ((v4:Dot(v10)) < -1.5) then
                    j.Center = j.Center + v3 * (Radius - v2)
                    j.Part.CFrame = (CFrame.new(j.Center)) * j.Turned * j.Rel
                    if j.Loud and not j.Plowed then
                        Sfx.At("PadlockClunk", j.Center, 0.3, 0.65)
                    end
                    j.Plowed = true
                end
            end
        end
    end
end

function u45.Tidy(a1, a2, a3, a4) -- Line: 626
    -- upvalues: TweenService (val), u43 (val)
    local Part_2
    local v1 = {}
    for i, j in a1.Movers do
        Part_2 = j.Part
        if Part_2.Parent ~= nil
            and not (1 <= Part_2.Transparency)
            and (math.abs(((j.Center - a2):Dot(a3)))) < a4 + j.Radius then
            j.Resting = true
            v1[Part_2] = true
            TweenService:Create(Part_2, u43, {
                Transparency = 1,
                CFrame = Part_2.CFrame - Vector3.new(0, 1.600000023841858, 0),
            }):Play()
        end
    end
    for k, n in a1.Riders do
        if v1[n.Base] and n.Part.Parent ~= nil then
            TweenService:Create(n.Part, u43, {Transparency = 1}):Play()
        end
    end
    return next(v1) ~= nil
end

function u45.Keep(a1) -- Line: 650 -- upvalues: u44 (ref), u45 (val) -- types: a1: table
    u44 = a1
    a1.Trove:Add((task.delay(1, function() -- Line: 652 -- upvalues: u44 (upval), a1 (val), u45 (upval)
        if u44 == a1 then
            u45.Sweep()
        end
    end)))
end

function u45.Sweep() -- Line: 659 -- upvalues: u44 (ref), TweenService (val), u38 (val)
    local v1
    local u44_2 = u44
    u44 = nil
    if u44_2 == nil then
        return
    end
    for i, j in u44_2.Folder:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            v1 = {Transparency = 1}
            if j.Anchored then
                v1.CFrame = j.CFrame - Vector3.new(0, 1.600000023841858, 0)
            end
            TweenService:Create(j, u38, v1):Play()
        end
    end
    task.delay(u38.Time, function() -- Line: 675 -- upvalues: u44_2 (val)
        u44_2.Trove:Destroy()
    end)
end

function u45.Clear() -- Line: 680 -- upvalues: u44 (ref)
    local v1 = u44
    u44 = nil
    if v1 ~= nil then
        v1.Trove:Destroy()
    end
end

return (table.freeze(u45))