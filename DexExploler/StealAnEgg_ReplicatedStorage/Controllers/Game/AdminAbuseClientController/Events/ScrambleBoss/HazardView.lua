-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.HazardView
-- Decompile time: 56.67 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ScrambleBossHazards = require(ReplicatedStorage.Shared.Util.ScrambleBossHazards)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u34 = require(script.Parent.Kit)
local Vfx = require(script.Parent.Vfx)
local u44 = Color3.fromRGB(255, 40, 40)
local u49 = Color3.fromRGB(110, 255, 70)
local u50 = {Missile = 2.2, Puddle = 3}
local u51 = {
    Floor = true,
    Mech = true,
    LeaveTeleport = true,
    BossSpawn = true,
    PlayerSpawn = true,
    Center = true,
    HubBlocker = true,
}
local LocalPlayer = Players.LocalPlayer

local function now() -- Line: 88 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function segmentRing(a1, a2, a3, a4) -- Line: 92
    -- upvalues: u34 (val)
    local Part, v1
    local v2 = {}
    for i = 1, a2 do
        Part = u34.Part
        v1 = {
            Name = "Segment",
            Size = Vector3.new(1, 1, 1),
            Color = a3,
            Transparency = a4,
            Parent = a1,
        }
        v2[i] = (Part(v1))
    end
    return v2
end

local function placeRing(a1, a2, a3, a4, a5) -- Line: 112
    -- upvalues: 
    local v1, v2, v3
    local v4 = #a1
    local v5 = 6.283185307179586 * math.max(a3, 0.5) / v4 * 1.08
    for i, j in a1 do
        v1 = i / v4 * 3.141592653589793 * 2
        v2 = Vector3.new(math.cos(v1), 0, (math.sin(v1))) * a3
        j.Size = Vector3.new(a4, a5, v5)
        v3 = CFrame.lookAt(a2 + v2, a2 + v2 + Vector3.new(-math.sin(v1), 0, (math.cos(v1))))
        j.CFrame = v3 * CFrame.new(0, a5 / 2, 0)
    end
end

local function disc(a1, a2, a3, a4, a5) -- Line: 132
    -- upvalues: u34 (val)
    return u34.Part({
        Name = "Disc",
        Shape = Enum.PartType.Cylinder,
        Color = a4,
        Transparency = a5,
        Size = Vector3.new(0.2, a3 * 2, a3 * 2),
        CFrame = (CFrame.new(a2)) * CFrame.Angles(0, 0, 1.5707963267948966),
        Parent = a1,
    })
end

local function triangle(a1, a2, a3, a4, a5) -- Line: 150
    -- upvalues: 
    local WedgePart, v1, v2, v3
    local v4 = a3 - a2
    local v5 = a4 - a2
    local v6 = a4 - a3
    local v7 = v4:Dot(v4)
    local v8 = v5:Dot(v5)
    local v9 = v6:Dot(v6)
    if not (v8 < v7) then
        if not (v9 < v8) or not (v7 < v8) then
            v1, v3 = a2, a4
        else
            v2 = a3
            a3 = a2
            v1 = v2
            v3 = a4
        end
    elseif v9 < v7 then
        v1 = a4
        v3 = a2
    elseif not (v9 < v8) or not (v7 < v8) then
        v1, v3 = a2, a4
    else
        v2 = a3
        a3 = a2
        v1 = v2
        v3 = a4
    end
    v4 = a3 - v1
    v5 = v3 - v1
    v6 = v3 - a3
    local Unit = v5:Cross(v4).Unit
    local Unit_2 = v6:Cross(Unit).Unit
    local Unit_3 = v6.Unit
    v6 = math.abs((v4:Dot(Unit_2)))
    v2 = {}
    for i = 1, 2 do
        WedgePart = Instance.new("WedgePart")
        WedgePart.Anchored = true
        WedgePart.CanCollide = false
        WedgePart.CanQuery = false
        WedgePart.CanTouch = false
        WedgePart.CastShadow = false
        WedgePart.Material = Enum.Material.Neon
        WedgePart.Color = a5
        WedgePart.Transparency = 0.6
        if i ~= 1 then
            WedgePart.Size = Vector3.new(0.2, v6, (math.abs((v5:Dot(Unit_3)))))
            WedgePart.CFrame = CFrame.fromMatrix((v1 + v3) / 2, -Unit, Unit_2, -Unit_3)
        else
            WedgePart.Size = Vector3.new(0.2, v6, (math.abs((v4:Dot(Unit_3)))))
            WedgePart.CFrame = CFrame.fromMatrix((v1 + a3) / 2, Unit, Unit_2, Unit_3)
        end
        WedgePart.Parent = a1
        table.insert(v2, WedgePart)
    end
    return v2
end

local u58 = {}
u58.__index = u58

function u58.new(a1, a2) -- Line: 199 -- upvalues: u34 (val), u58 (val), RunService (val) -- types: a2: userdata
    local Folder = Instance.new("Folder")
    Folder.Name = "ScrambleHazards"
    Folder.Parent = u34.Debris()
    a1:Add(Folder)
    local v1 = {
        Views = {},
        Folder = Folder,
        Arena = a2,
        Handles = {},
        SoundAt = {},
    }
    local u19 = setmetatable(v1, u58)
    a1:Connect(RunService.RenderStepped, function() -- Line: 213 -- upvalues: u19 (val)
        u19:Step()
    end)
    a1:Add(function() -- Line: 216 -- upvalues: u19 (val)
        for i in u19.Handles do
            i:Stop()
        end
        table.clear(u19.Handles)
    end)
    return u19
end

function u58:Hold(a2, a3, a4, a5) -- Line: 226
    -- upvalues: Vfx (val)
    local v1 = Vfx.Hold(a2, a3, a4, nil, a5)
    if v1 then
        self.Handles[v1] = true
    end
    return v1
end

function u58:SoundOnce(a2, a3, a4, a5) -- Line: 241 -- upvalues: u34 (val) -- types: a2: string, a4: number?, a5: number
    local v1 = os.clock()
    if v1 - (self.SoundAt[a2] or (-1 / 0)) < a5 then
        return
    end
    self.SoundAt[a2] = v1
    u34.Sound(a2, a3, a4)
end

function u58:Release(a2) -- Line: 257
    if a2 and self.Handles[a2] then
        self.Handles[a2] = nil
        a2:Stop()
    end
end

function u58:BeamCore(a2, a3) -- Line: 264 -- types: a2: userdata, a3: string
    if self.CoreMech ~= a2 then
        self.CoreMech = a2
        self.Cores = {}
    end
    local v1 = self.Cores[a3]
    if v1 and v1.Capsule:IsDescendantOf(a2) then
        return v1
    end
    v1 = nil
    local v2 = nil
    for i, j in a2:GetDescendants() do
        if j:IsA("Bone") then
            if j.Name == "Capsule3." .. a3 then
                v1 = j
            elseif j.Name == "SideArmPivot5." .. a3 then
                v2 = j
            end
        end
    end
    if v1 ~= nil and v2 ~= nil then
        local v3 = {Capsule = v1, Base = v2}
        self.Cores[a3] = v3
        return v3
    end
    return nil
end

function u58:Muzzle(a2) -- Line: 296
    local Mech = self.Arena:FindFirstChild("Mech")
    local v1 = a2.Side or "R"
    local v2 = Mech and self:BeamCore(Mech, v1)
    if v2 then
        local TransformedWorldCFrame = v2.Capsule.TransformedWorldCFrame
        return TransformedWorldCFrame.Position + TransformedWorldCFrame.YVector * (TransformedWorldCFrame.Position - v2.Base.TransformedWorldCFrame.Position).Magnitude
    end
    v2 = Mech and Mech:FindFirstChild("Claw" .. v1)
    v1 = v2 and v2:FindFirstChild("Muzzle")
    if v1 and v1:IsA("Attachment") then
        return v1.WorldPosition
    end
    return a2.From
end

function u58:BeamHeading(a2, a3, a4) -- Line: 316
    -- upvalues: ScrambleBossHazards (val), u34 (val)
    local v1 = ScrambleBossHazards.BeamHeading(a2, a3)
    local Mech = self.Arena:FindFirstChild("Mech")
    local PrimaryPart = Mech and Mech:IsA("Model") and Mech.PrimaryPart
    if PrimaryPart ~= nil and a4 ~= nil then
        local v2 = u34.Flat(a4 - PrimaryPart.Position)
        if not (v2.Magnitude < 4) and not ((v2.Unit:Dot(v1)) < 0.8660254037844387) then
            return v2.Unit
        end
        return v1
    end
    return v1
end

local function stretchLane(a1, a2, a3) -- Line: 337 -- types: a1: userdata, a2: number, a3: number
    local Position_2, Y, v1, v2
    local v3, v4 = a3, a2
    for i, j in a1:GetDescendants() do
        if not j:IsA("Attachment") then
            if j:IsA("Beam") then
                j.Width0 = j.Width0 * v3
                j.Width1 = j.Width1 * v3
            end
        elseif 1 < (math.abs(j.Position.Z)) then
            Position_2 = j.Position
            v1 = Position_2.X * v3
            Y = Position_2.Y
            v2 = (math.sign(Position_2.Z)) * v4 / 2
            j.Position = Vector3.new(v1, Y, v2)
        elseif j:IsA("Beam") then
            j.Width0 = j.Width0 * v3
            j.Width1 = j.Width1 * v3
        end
    end
end

local function sweepEnds(a1) -- Line: 350 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("Attachment") and j.Position.Z < -1 then
            table.insert(v1, j)
        end
    end
    return v1
end

local function taperFromHand(a1) -- Line: 361 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("Beam") then
            j.Width0 = math.min(j.Width0, j.Width1) * 0.2
        end
    end
end

local function stretchSweep(a1, a2) -- Line: 369 -- types: a1: table, a2: number
    local X, Y, v1
    for i, j in a1 do
        X = j.Position.X
        Y = j.Position.Y
        v1 = -a2
        j.Position = Vector3.new(X, Y, v1)
    end
end

local function aimedSpec(a1) -- Line: 375 -- types: a1: table
    if a1.Spec.Kind == "Beam" and a1.Heading ~= nil then
        local v1 = table.clone(a1.Spec)
        v1.Direction = a1.Heading
        v1.Angle = 0
        return v1
    end
    return a1.Spec
end

local function coverParams(a1) -- Line: 387 -- upvalues: u51 (val) -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetChildren() do
        if not u51[j.Name] and j:FindFirstChildOfClass("Humanoid") == nil then
            table.insert(v1, j)
        end
    end
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Include
    v2.FilterDescendantsInstances = v1
    v2.RespectCanCollide = true
    return v2
end

local function beamReach(a1, a2, a3) -- Line: 403
    -- upvalues: Workspace (val)
    local v1 = a1.Spec.Length or 150
    if a1.CoverParams == nil then
        return v1
    end
    local v2 = Workspace:Raycast(Vector3.new(a2.X, a1.FloorY + 2.5, a2.Z), a3 * v1, a1.CoverParams)
    if v2 then
        return v2.Distance
    end
    return v1
end

local function beamTouches(a1, a2) -- Line: 415
    -- upvalues: u34 (val), ScrambleBossHazards (val)
    local Muzzle = a1.Muzzle
    local Tip = a1.Tip
    if a1.Spec.Kind == "Beam" and Muzzle ~= nil and Tip ~= nil then
        local v1 = u34.Flat(Tip - Muzzle)
        local Magnitude = v1.Magnitude
        if Magnitude < 0.001 then
            return false
        end
        local v2 = (u34.Flat(a2 - Muzzle)):Dot(v1 / Magnitude)
        local v3 = false
        if -ScrambleBossHazards.BodyRadius <= v2 then
            v3 = v2 <= Magnitude + ScrambleBossHazards.BodyRadius
        end
        return v3
    end
    return true
end

local function covered(a1, a2) -- Line: 432 -- upvalues: Workspace (val) -- types: a1: table, a2: vector
    if a1.CoverParams == nil then
        return false
    end
    local v1 = a1.FloorY + 2.5
    local Muzzle = a1.Muzzle or a1.Spec.Origin
    local v2 = Vector3.new(Muzzle.X, v1, Muzzle.Z)
    return Workspace:Raycast(v2, (Vector3.new(a2.X, v1, a2.Z)) - v2, a1.CoverParams) ~= nil
end

function u58:Add(a2) -- Line: 445
    -- upvalues: segmentRing (val), u44 (val), disc (val), u49 (val), coverParams (val), placeRing (val), u34 (val)
    -- upvalues: Vfx (val), ScrambleBossHazards (val), triangle (val), u50 (val), stretchLane (val)
    local Attribute = self.Arena:GetAttribute("FloorY") or a2.Origin.Y
    local v1 = Attribute + 0.15
    local Folder = Instance.new("Folder")
    Folder.Name = ("Hazard%*"):format(a2.Id)
    Folder.Parent = self.Folder
    local u408 = {Reported = false, Struck = false, Spec = a2, Folder = Folder}
    u408.Parts = {}
    u408.FloorY = v1
    local v2 = Vector3.new(a2.Origin.X, v1, a2.Origin.Z)
    if a2.Kind == "Ring" then
        u408.Parts.Telegraph = segmentRing(Folder, 24, u44, 0.35)
        u408.Parts.Warn = disc(Folder, v2, 6, u44, 0.5)
        u408.Parts.Ring = segmentRing(Folder, 44, u49, 0.05)
        for i10, i11 in u408.Parts.Ring do
            i11.Transparency = 1
        end
    elseif a2.Kind ~= "Beam" then
        if a2.Kind == "Strike" then
            u408.Parts.Fill = disc(Folder, v2, 0.5, u44, 0.45)
            u408.Parts.Edge = segmentRing(Folder, 20, u44, 0.2)
            placeRing(u408.Parts.Edge, v2, a2.Radius or 10, 0.6, 0.3)
        else
            local Points, Unit_2, Unit_3, v3, v4, v5, v6, v7, v8, v9, v10, v11
            if a2.Kind ~= "Cone" then
                if a2.Kind == "Cone" then
                    Unit_2 = u34.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
                    v9 = a2.Radius or 30
                    v10 = math.rad((a2.Angle or 60) / 2)
                    v11 = math.max(5, (math.ceil((a2.Angle or 60) / 20)))
                    v3 = {}
                    v4 = v11 - 1
                    for k = 0, v4 do
                        v6 = -v10 + k / v11 * v10 * 2
                        v7 = -v10 + (k + 1) / v11 * v10 * 2
                        for n, m in triangle(Folder, v2, v2 + CFrame.Angles(0, v6, 0) * Unit_2 * v9, v2 + CFrame.Angles(0, v7, 0) * Unit_2 * v9, u44) do
                            table.insert(v3, m)
                        end
                    end
                    u408.Parts.Cone = v3
                elseif a2.Kind == "Missile" or a2.Kind == "Puddle" then
                    u408.Parts.Fill = disc(Folder, v2, 0.5, u44, 0.45)
                    u408.Parts.Edge = segmentRing(Folder, 20, u44, 0.2)
                    placeRing(u408.Parts.Edge, v2, a2.Radius or 10, 0.6, 0.3)
                    u408.Parts.Orb = self:Hold("ToxicOrb", CFrame.new(a2.From or v2), u50[a2.Kind])
                    self:SoundOnce(if a2.Kind ~= "Missile" then "ToxicOrbs" else "RapidMissileFire", a2.From or v2, 1, 0.5)
                elseif a2.Kind == "Grab" then
                    u408.Parts.Fill = disc(Folder, v2, a2.Radius or 14, u44, 0.6)
                    u408.Parts.Edge = segmentRing(Folder, 24, u44, 0.1)
                    placeRing(u408.Parts.Edge, v2, a2.Radius or 14, 1, 0.5)
                    u408.Parts.Closer = segmentRing(Folder, 24, u44, 0.3)
                elseif a2.Kind == "Lane" then
                    Unit_3 = u34.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
                    v9 = a2.Length or 100
                    v10 = v2 + Unit_3 * v9 / 2
                    v11 = self:Hold("SpiderLane", (CFrame.lookAt(v10, v10 + Unit_3)))
                    if v11 then
                        stretchLane(v11.Root, v9, (a2.Width or 40) / 32)
                        u408.Parts.Indicator = v11
                    end
                elseif a2.Kind == "Pillars" then
                    v8 = {}
                    v9 = {}
                    Points = a2.Points or {}
                    v11 = nil
                    v3 = nil
                    for i, j in Points, v11, v3 do
                        v5 = Vector3.new(j.X, u408.FloorY, j.Z)
                        table.insert(v8, (disc(Folder, v5, a2.Radius or 10, u44, 0.5)))
                        v6 = self:Hold("LaserPillar", (Vfx.Frame("LaserPillar", v5)))
                        if v6 then
                            v5 = v6.Root:FindFirstChild("Beam")
                            if v5 then
                                Vfx.Toggle(v5, false)
                            end
                            table.insert(v9, {Handle = v6, Beam = v5})
                        end
                    end
                    u408.Parts.Fills = v8
                    u408.Parts.Pillars = v9
                elseif a2.Kind == "Sweep" then
                    u408.Parts.Edge = segmentRing(Folder, 32, u44, 0.25)
                    placeRing(u408.Parts.Edge, v2, a2.Radius or 40, 1.2, 0.4)
                    u408.Parts.Fill = disc(Folder, v2, a2.Radius or 40, u44, 0.8)
                end
            elseif a2.Style == "Bite" then
                local Unit = u34.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
                v8 = Vfx.CrocScale(self.Arena)
                local CrocBite = Vfx.Template("CrocBite")
                local Attribute_2 = CrocBite and CrocBite:GetAttribute("RootOffset")
                v9 = self:Hold(
                    "CrocBite",
                    (CFrame.lookAt(v2, v2 + Unit)) * (CFrame.new(if typeof(Attribute_2) ~= "Vector3" then Vector3.new(0, 0, 0) else Attribute_2 * v8)),
                    v8,
                    true
                )
                if v9 then
                    Vfx.Pulse(v9.Root, a2.Warn + ScrambleBossHazards.ActiveSeconds(a2) + 0.2)
                    u408.Parts.Indicator = v9
                end
            elseif a2.Kind == "Cone" then
                Unit_2 = u34.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
                v9 = a2.Radius or 30
                v10 = math.rad((a2.Angle or 60) / 2)
                v11 = math.max(5, (math.ceil((a2.Angle or 60) / 20)))
                v3 = {}
                v4 = v11 - 1
                for i7 = 0, v4 do
                    v6 = -v10 + i7 / v11 * v10 * 2
                    v7 = -v10 + (i7 + 1) / v11 * v10 * 2
                    for i8, i9 in triangle(Folder, v2, v2 + CFrame.Angles(0, v6, 0) * Unit_2 * v9, v2 + CFrame.Angles(0, v7, 0) * Unit_2 * v9, u44) do
                        table.insert(v3, i9)
                    end
                end
                u408.Parts.Cone = v3
            elseif a2.Kind == "Missile" or a2.Kind == "Puddle" then
                u408.Parts.Fill = disc(Folder, v2, 0.5, u44, 0.45)
                u408.Parts.Edge = segmentRing(Folder, 20, u44, 0.2)
                placeRing(u408.Parts.Edge, v2, a2.Radius or 10, 0.6, 0.3)
                u408.Parts.Orb = self:Hold("ToxicOrb", CFrame.new(a2.From or v2), u50[a2.Kind])
                self:SoundOnce(if a2.Kind ~= "Missile" then "ToxicOrbs" else "RapidMissileFire", a2.From or v2, 1, 0.5)
            elseif a2.Kind == "Grab" then
                u408.Parts.Fill = disc(Folder, v2, a2.Radius or 14, u44, 0.6)
                u408.Parts.Edge = segmentRing(Folder, 24, u44, 0.1)
                placeRing(u408.Parts.Edge, v2, a2.Radius or 14, 1, 0.5)
                u408.Parts.Closer = segmentRing(Folder, 24, u44, 0.3)
            elseif a2.Kind == "Lane" then
                Unit_3 = u34.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
                v9 = a2.Length or 100
                v10 = v2 + Unit_3 * v9 / 2
                v11 = self:Hold("SpiderLane", (CFrame.lookAt(v10, v10 + Unit_3)))
                if v11 then
                    stretchLane(v11.Root, v9, (a2.Width or 40) / 32)
                    u408.Parts.Indicator = v11
                end
            elseif a2.Kind == "Pillars" then
                v8 = {}
                v9 = {}
                Points = a2.Points or {}
                v11 = nil
                v3 = nil
                for i5, i6 in Points, v11, v3 do
                    v5 = Vector3.new(i6.X, u408.FloorY, i6.Z)
                    table.insert(v8, (disc(Folder, v5, a2.Radius or 10, u44, 0.5)))
                    v6 = self:Hold("LaserPillar", (Vfx.Frame("LaserPillar", v5)))
                    if v6 then
                        v5 = v6.Root:FindFirstChild("Beam")
                        if v5 then
                            Vfx.Toggle(v5, false)
                        end
                        table.insert(v9, {Handle = v6, Beam = v5})
                    end
                end
                u408.Parts.Fills = v8
                u408.Parts.Pillars = v9
            elseif a2.Kind == "Sweep" then
                u408.Parts.Edge = segmentRing(Folder, 32, u44, 0.25)
                placeRing(u408.Parts.Edge, v2, a2.Radius or 40, 1.2, 0.4)
                u408.Parts.Fill = disc(Folder, v2, a2.Radius or 40, u44, 0.8)
            end
        end
    elseif a2.Cover then
        u408.CoverParams = coverParams(self.Arena)
    end
    self.Views[a2.Id] = u408
    task.delay(a2.Warn + ScrambleBossHazards.ActiveSeconds(a2) + 1.2, function() -- Line: 553 -- upvalues: self (val), a2 (val), u408 (val), Folder (val)
        self.Views[a2.Id] = nil
        for i, j in u408.Parts do
            if type(j) == "table" and j.Stop then
                self:Release(j)
            end
        end
        for k, n in u408.Parts.Pillars or {} do
            self:Release(n.Handle)
        end
        Folder:Destroy()
    end)
end

function u58:CheckBallContact(a2) -- Line: 567
    -- upvalues: LocalPlayer (val), ScrambleBossHazards (val), u34 (val), Remotes (val)
    local Arena = self.Arena
    if Arena:GetAttribute("Phase") == "Ball"
        and (Arena:GetAttribute("BallTarget")) == LocalPlayer.UserId
        and not Arena:GetAttribute("BallStunned") then
        local Ball = Arena:FindFirstChild("Ball")
        local PrimaryPart = Ball and Ball.PrimaryPart
        if PrimaryPart ~= nil and not (os.clock() - (self.LastContact or 0) < 0.3) then
            local v1 = PrimaryPart.Size.Y / 2 + ScrambleBossHazards.BodyRadius
            if u34.Flat(a2.Position - PrimaryPart.Position).Magnitude <= v1 then
                self.LastContact = os.clock()
                Remotes.ScrambleBoss.HazardHit:FireServer(-1)
            end
            return
        end
        return
    end
end

function u58:Step() -- Line: 590
    -- upvalues: Workspace (val), LocalPlayer (val), ScrambleBossHazards (val), placeRing (val), Vfx (val)
    -- upvalues: taperFromHand (val), sweepEnds (val), u34 (val), beamTouches (val), Remotes (val)
    local Contains, Distance, Muzzle, Orb, Position_3, Spec, Spec_2, X_4, Y, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local v17 = false
    if Humanoid ~= nil then
        v17 = Humanoid.FloorMaterial == Enum.Material.Air
    end
    if LocalPlayer:GetAttribute("InScrambleArena") == true
        and HumanoidRootPart
        and Humanoid
        and 0 < Humanoid.Health then
        self:CheckBallContact(HumanoidRootPart)
    end
    local v18 = nil
    local v19 = nil
    for i, j in self.Views, v18, v19 do
        Spec = j.Spec
        v2 = ServerTimeNow - Spec.At
        v3 = math.clamp(1 + v2 / math.max(Spec.Warn, 0.01), 0, 1)
        v4 = Vector3.new(Spec.Origin.X, j.FloorY, Spec.Origin.Z)
        v5 = ScrambleBossHazards.ActiveSeconds(Spec)
        v6 = false
        if v2 >= 0 then
            v6 = v2 <= v5
        end
        v7 = math.sin(ServerTimeNow * 18) * 0.5 + 0.5
        if Spec.Kind ~= "Ring" then
            if Spec.Kind == "Beam" then
                v8 = v1:Muzzle(Spec)
                v9 = v1:BeamHeading(Spec, v2, v8)
                j.Heading = v9
                v10 = v8 or v4 + v9 * 10 + Vector3.new(0, 1.5, 0)
                v11 = Vector3.new(v10.X, j.FloorY + 1.5, v10.Z)
                v13 = j.Spec.Length or 150
                if j.CoverParams ~= nil then
                    v14 = Workspace:Raycast(Vector3.new(v10.X, j.FloorY + 2.5, v10.Z), v9 * v13, j.CoverParams)
                    Distance = if not v14 then v13 else v14.Distance
                else
                    Distance = v13
                end
                v8 = v11 + v9 * Distance
                j.Muzzle = v10
                j.Tip = v8
                v11 = v8 - v10
                if v6 and j.Parts.Sweep == nil and not j.Struck then
                    j.Struck = true
                    v8 = v1:Hold("LaserSweep", (Vfx.Frame("LaserSweep", v10, v11)))
                    if v8 then
                        taperFromHand(v8.Root)
                        j.Parts.SweepEnds = sweepEnds(v8.Root)
                        j.Parts.Sweep = v8
                    end
                    u34.Sound("LaserBeam", v10, 1.2)
                    u34.ShakeFrom(v10, 3, 200)
                end
                if j.Parts.Sweep then
                    j.Parts.Sweep:Move((Vfx.Frame("LaserSweep", v10, v11)))
                    for i26, i27 in j.Parts.SweepEnds do
                        X_4 = i27.Position.X
                        Y = i27.Position.Y
                        v15 = -v11.Magnitude
                        i27.Position = Vector3.new(X_4, Y, v15)
                    end
                end
                if v6 and v16 and HumanoidRootPart and (j.NextRumble or 0) <= ServerTimeNow then
                    j.NextRumble = ServerTimeNow + 0.16
                    v11 = u34.Flat(HumanoidRootPart.Position - v4)
                    u34.Shake((math.clamp(
                        1 - (if not (0 < v11:Dot(v9)) then v11.Magnitude else math.abs((v11:Dot((v9:Cross((Vector3.new(0, 1, 0)))))))) / 45,
                        0,
                        1
                    )) * 2.4 + 0.7, 18, 0.3)
                end
                if v5 < v2 and not j.Ended then
                    j.Ended = true
                    v1:Release(j.Parts.Sweep)
                end
            elseif Spec.Kind ~= "Strike" then
                if Spec.Kind == "Missile" then
                    Orb = j.Parts.Orb
                    if v2 < 0 then
                        v9 = math.max((Spec.Radius or 10) * v3, 0.5)
                        j.Parts.Fill.Size = Vector3.new(0.2, v9 * 2, v9 * 2)
                        j.Parts.Fill.Transparency = 0.55 - v3 * 0.25
                        v9 = Spec.From or v4
                        v10 = math.max((v9 - v4).Magnitude * 0.35, 25)
                        if Orb then
                            Orb:Move((CFrame.new((v9:Lerp(v4, v3)) + (Vector3.new(0, math.sin(v3 * 3.141592653589793) * v10, 0)))))
                        end
                    elseif not j.Struck then
                        j.Struck = true
                        v1:Release(Orb)
                        j.Parts.Fill.Transparency = 1
                        for k, n in j.Parts.Edge do
                            n.Transparency = 1
                        end
                        v9 = Spec.Radius or 10
                        Vfx.Burst("ToxicSplat", CFrame.new(v4), v9 / 6.5)
                        if Spec.Kind ~= "Missile" then
                            v1:SoundOnce("ToxicPuddles", v4, 1, 0.35)
                            j.Parts.Pool = v1:Hold("ToxicPuddle", CFrame.new(v4), v9 / 6)
                        else
                            u34.Sound("Strike", v4, 0.5, 1.1 + math.random() * 0.2)
                            u34.ShakeFrom(v4, 2, 90)
                        end
                    end
                    if Spec.Kind == "Puddle" and j.Parts.Pool and v5 - 2 <= v2 then
                        v1:Release(j.Parts.Pool)
                        j.Parts.Pool = nil
                    end
                elseif Spec.Kind == "Puddle" then
                    Orb = j.Parts.Orb
                    if v2 < 0 then
                        v9 = math.max((Spec.Radius or 10) * v3, 0.5)
                        j.Parts.Fill.Size = Vector3.new(0.2, v9 * 2, v9 * 2)
                        j.Parts.Fill.Transparency = 0.55 - v3 * 0.25
                        v9 = Spec.From or v4
                        v10 = math.max((v9 - v4).Magnitude * 0.35, 25)
                        if Orb then
                            Orb:Move((CFrame.new((v9:Lerp(v4, v3)) + (Vector3.new(0, math.sin(v3 * 3.141592653589793) * v10, 0)))))
                        end
                    elseif not j.Struck then
                        j.Struck = true
                        v1:Release(Orb)
                        j.Parts.Fill.Transparency = 1
                        for i22, i23 in j.Parts.Edge do
                            i23.Transparency = 1
                        end
                        v9 = Spec.Radius or 10
                        Vfx.Burst("ToxicSplat", CFrame.new(v4), v9 / 6.5)
                        if Spec.Kind ~= "Missile" then
                            v1:SoundOnce("ToxicPuddles", v4, 1, 0.35)
                            j.Parts.Pool = v1:Hold("ToxicPuddle", CFrame.new(v4), v9 / 6)
                        else
                            u34.Sound("Strike", v4, 0.5, 1.1 + math.random() * 0.2)
                            u34.ShakeFrom(v4, 2, 90)
                        end
                    end
                    if Spec.Kind == "Puddle" and j.Parts.Pool and v5 - 2 <= v2 then
                        v1:Release(j.Parts.Pool)
                        j.Parts.Pool = nil
                    end
                elseif Spec.Kind == "Grab" then
                    j.Parts.Fill.Transparency = if not (v2 < 0) then 1 else v7 * 0.3 + 0.35
                    v9 = nil
                    v10 = nil
                    for i18, i19 in j.Parts.Edge, v9, v10 do
                        v12 = if not (v2 < 0) then 1 else 0.05
                        i19.Transparency = v12
                    end
                    v8 = (Spec.Radius or 14) * ((1 - v3) * 1.6 + 1)
                    placeRing(j.Parts.Closer, v4, v8, 0.8, 0.4)
                    v10 = nil
                    v11 = nil
                    for i20, i21 in j.Parts.Closer, v10, v11 do
                        v13 = if not (v2 < 0) then 1 else 0.25
                        i21.Transparency = v13
                    end
                elseif Spec.Kind ~= "Lane" then
                    if Spec.Kind == "Pillars" then
                        v9 = nil
                        v10 = nil
                        for i12, i13 in j.Parts.Fills, v9, v10 do
                            v12 = if not (v2 < 0) then 1 else 0.6 - v3 * 0.3 + v7 * 0.1
                            i13.Transparency = v12
                        end
                        if v2 >= 0 and not j.Struck then
                            j.Struck = true
                            for i14, i15 in j.Parts.Pillars do
                                if i15.Beam then
                                    Vfx.Toggle(i15.Beam, true)
                                end
                            end
                            u34.Sound("VerticalLasers", nil, 1)
                            u34.Shake(2, 20, 0.6)
                        end
                        if v5 < v2 and not j.Ended then
                            j.Ended = true
                            for i16, i17 in j.Parts.Pillars do
                                v1:Release(i17.Handle)
                            end
                        end
                    elseif Spec.Kind ~= "Cone" then
                        if Spec.Kind == "Cone" then
                            v9 = nil
                            v10 = nil
                            for i6, i7 in j.Parts.Cone, v9, v10 do
                                v12 = if not (v2 < 0) then math.min(1, 0.62 + v2 * 4) else v7 * 0.2 + 0.62
                                i7.Transparency = v12
                            end
                        elseif Spec.Kind == "Sweep" then
                            j.Parts.Fill.Transparency = if not (v2 < 0) then 1 else 0.85 - v3 * 0.25
                            v9 = nil
                            v10 = nil
                            for m, i5 in j.Parts.Edge, v9, v10 do
                                v12 = if not (v2 < 0) then 1 else v7 * 0.4 + 0.1
                                i5.Transparency = v12
                            end
                        end
                    elseif Spec.Style ~= "Bite" then
                        if Spec.Kind == "Cone" then
                            v9 = nil
                            v10 = nil
                            for i10, i11 in j.Parts.Cone, v9, v10 do
                                v12 = if not (v2 < 0) then math.min(1, 0.62 + v2 * 4) else v7 * 0.2 + 0.62
                                i11.Transparency = v12
                            end
                        elseif Spec.Kind == "Sweep" then
                            j.Parts.Fill.Transparency = if not (v2 < 0) then 1 else 0.85 - v3 * 0.25
                            v9 = nil
                            v10 = nil
                            for i8, i9 in j.Parts.Edge, v9, v10 do
                                v12 = if not (v2 < 0) then 1 else v7 * 0.4 + 0.1
                                i9.Transparency = v12
                            end
                        end
                    elseif v5 < v2 and j.Parts.Indicator then
                        v1:Release(j.Parts.Indicator)
                        j.Parts.Indicator = nil
                    end
                elseif v5 < v2 and j.Parts.Indicator then
                    v1:Release(j.Parts.Indicator)
                    j.Parts.Indicator = nil
                end
            elseif v2 < 0 then
                v8 = math.max((Spec.Radius or 10) * v3, 0.5)
                j.Parts.Fill.Size = Vector3.new(0.2, v8 * 2, v8 * 2)
                j.Parts.Fill.Transparency = 0.55 - v3 * 0.25
            elseif not j.Struck then
                j.Struck = true
                j.Parts.Fill.Transparency = 1
                for i24, i25 in j.Parts.Edge do
                    i25.Transparency = 1
                end
                u34.Sound("Strike", v4, 0.6, 0.9 + math.random() * 0.2)
            end
        elseif not (v2 < 0) then
            for i28, i29 in j.Parts.Telegraph do
                i29.Transparency = 1
            end
            j.Parts.Warn.Transparency = 1
            v8 = ScrambleBossHazards.RingRadius(Spec, v2)
            v9 = if not v6 then 1 else 0.05
            placeRing(j.Parts.Ring, v4, v8, Spec.Width or 2, 2.4)
            for i30, i31 in j.Parts.Ring do
                i31.Transparency = v9
            end
        else
            placeRing(j.Parts.Telegraph, v4, v3 * 10 + 6, 0.8, 0.3)
            for i32, i33 in j.Parts.Telegraph do
                i33.Transparency = v7 * 0.4 + 0.2
            end
        end
        if v6 and v16 then
            if not j.Reported then
                if HumanoidRootPart ~= nil and Humanoid ~= nil and 0 < Humanoid.Health then
                    Contains = ScrambleBossHazards.Contains
                    if j.Spec.Kind ~= "Beam" then
                        Spec_2 = j.Spec
                    elseif j.Heading ~= nil then
                        v7 = table.clone(j.Spec)
                        v7.Direction = j.Heading
                        v7.Angle = 0
                        Spec_2 = v7
                    else
                        Spec_2 = j.Spec
                    end
                    if Contains(Spec_2, v2, HumanoidRootPart.Position, v17, 0)
                        and beamTouches(j, HumanoidRootPart.Position) then
                        Position_3 = HumanoidRootPart.Position
                        if j.CoverParams ~= nil then
                            v5 = j.FloorY + 2.5
                            Muzzle = j.Muzzle or j.Spec.Origin
                            v3 = Vector3.new(Muzzle.X, v5, Muzzle.Z)
                            v8 = Workspace:Raycast(v3, (Vector3.new(Position_3.X, v5, Position_3.Z)) - v3, j.CoverParams) ~= nil
                        else
                            v8 = false
                        end
                        if not v8 then
                            j.Reported = true
                            j.NextReport = ServerTimeNow + (Spec.Tick or 0)
                            Remotes.ScrambleBoss.HazardHit:FireServer(i)
                            u34.Shake(3, 16, 0.5)
                        end
                    end
                end
            elseif Spec.Tick ~= nil
                and (j.NextReport or 0) <= ServerTimeNow
                and HumanoidRootPart ~= nil
                and Humanoid ~= nil
                and 0 < Humanoid.Health then
                Contains = ScrambleBossHazards.Contains
                if j.Spec.Kind ~= "Beam" then
                    Spec_2 = j.Spec
                elseif j.Heading ~= nil then
                    v7 = table.clone(j.Spec)
                    v7.Direction = j.Heading
                    v7.Angle = 0
                    Spec_2 = v7
                else
                    Spec_2 = j.Spec
                end
                if Contains(Spec_2, v2, HumanoidRootPart.Position, v17, 0)
                    and beamTouches(j, HumanoidRootPart.Position) then
                    Position_3 = HumanoidRootPart.Position
                    if j.CoverParams ~= nil then
                        v5 = j.FloorY + 2.5
                        Muzzle = j.Muzzle or j.Spec.Origin
                        v3 = Vector3.new(Muzzle.X, v5, Muzzle.Z)
                        v8 = Workspace:Raycast(v3, (Vector3.new(Position_3.X, v5, Position_3.Z)) - v3, j.CoverParams) ~= nil
                    else
                        v8 = false
                    end
                    if not v8 then
                        j.Reported = true
                        j.NextReport = ServerTimeNow + (Spec.Tick or 0)
                        Remotes.ScrambleBoss.HazardHit:FireServer(i)
                        u34.Shake(3, 16, 0.5)
                    end
                end
            end
        end
    end
end

return u58