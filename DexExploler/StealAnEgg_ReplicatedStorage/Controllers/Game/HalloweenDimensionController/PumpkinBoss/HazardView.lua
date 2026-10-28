-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.HazardView
-- Decompile time: 41.03 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ScrambleBossHazards = require(ReplicatedStorage.Shared.Util.ScrambleBossHazards)
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Kit = require(script.Parent.Kit)
local Vfx = require(script.Parent.Vfx)
local MemberAttribute = PumpkinBossState.MemberAttribute
local u46 = {Charge = Vfx.PhaseOne, Shadow = Vfx.PhaseOne}
local u48 = {[Vfx.PhaseOne] = "BruteBombImpact", [Vfx.PhaseTwo] = "KingBarrageImpact"}
local LocalPlayer = Players.LocalPlayer
local u54 = 0

local function now() -- Line: 96 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function segmentRing(a1, a2, a3, a4) -- Line: 100
    -- upvalues: Kit (val)
    local Part, v1
    local v2 = {}
    for i = 1, a2 do
        Part = Kit.Part
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

local function placeRing(a1, a2, a3, a4, a5) -- Line: 119
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

local function setAll(a1, a2) -- Line: 139 -- types: a1: table, a2: number
    for i, j in a1 do
        j.Transparency = a2
    end
end

local function disc(a1, a2, a3, a4, a5) -- Line: 145
    -- upvalues: Kit (val)
    return Kit.Part({
        Name = "Disc",
        Shape = Enum.PartType.Cylinder,
        Color = a4,
        Transparency = a5,
        Size = Vector3.new(0.2, a3 * 2, a3 * 2),
        CFrame = (CFrame.new(a2)) * CFrame.Angles(0, 0, 1.5707963267948966),
        Parent = a1,
    })
end

local function sizeDisc(a1, a2) -- Line: 163 -- types: a1: userdata, a2: number
    a1.Size = Vector3.new(0.2, a2 * 2, a2 * 2)
end

local function triangle(a1, a2, a3, a4, a5) -- Line: 167
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

local function bombTemplate() -- Line: 211 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local HalloweenDimension = Assets and Assets:FindFirstChild("HalloweenDimension")
    local v1 = HalloweenDimension and HalloweenDimension:FindFirstChild("PumpkinBoss")
    local PumpkinCannonball = v1 and v1:FindFirstChild("PumpkinCannonball")
    if PumpkinCannonball and PumpkinCannonball:IsA("Model") then
        return PumpkinCannonball
    end
    return nil
end

local function bombModel(a1, a2) -- Line: 219 -- upvalues: bombTemplate (val) -- types: a1: userdata, a2: vector
    local v1 = bombTemplate()
    if not v1 then
        return nil
    end
    local v2 = v1:Clone()
    v2:ScaleTo((v2:GetScale()) * 1.8)
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = false
        end
    end
    v2:PivotTo((CFrame.new(a2)))
    v2.Parent = a1
    return v2
end

local function fitIndicator(a1, a2, a3) -- Line: 243 -- types: a1: userdata, a2: number, a3: number
    local Position, Y, v1, v2, v3, v4
    local v5 = {}
    local v6 = 0
    local v7 = 0
    for i, j in a1:GetDescendants() do
        if j:IsA("Attachment") then
            table.insert(v5, j)
            v6 = math.max(v6, (math.abs(j.Position.X)))
            v7 = math.max(v7, (math.abs(j.Position.Z)))
        end
    end
    local v8 = if not (v6 > 0) then 1 else a2 / (v6 * 2)
    v6 = if not (v7 > 0) then 1 else a3 / (v7 * 2)
    for k, n in a1:GetDescendants() do
        if n:IsA("Beam") and n.Attachment0 and n.Attachment1 then
            v7 = n.Attachment1.Position - n.Attachment0.Position
            v2 = math.abs(v7.X)
            v1 = if not (math.abs(v7.Y) < v2) then v8 else v6
            n.Width0 = n.Width0 * v1
            n.Width1 = n.Width1 * v1
        end
    end
    for m, i5 in v5 do
        Position = i5.Position
        v3 = Position.X * v8
        Y = Position.Y
        v4 = Position.Z * v6
        i5.Position = Vector3.new(v3, Y, v4)
    end
end

local function laneIndicator(a1, a2, a3, a4) -- Line: 270
    -- upvalues: u46 (val), Vfx (val), fitIndicator (val)
    local v1 = u46[a1.Style or ""]
    local v2 = v1 and Vfx.Template(v1, {"PumpkinCharge", "ChargeIndicator"})
    if v2 == nil then
        return nil
    end
    v1 = Vfx.Place(v2, CFrame.fromMatrix(a3, a4, (Vector3.new(0, 1, 0))))
    fitIndicator(v1, a1.Length or 100, a1.Width or 20)
    v1.Parent = a2
    return v1
end

local function bombCarrier(a1, a2, a3) -- Line: 288
    -- upvalues: Vfx (val)
    local v1 = Vfx.Template(a1, {"PumpkinThrow", "Pumpkin"})
    if v1 == nil then
        return nil
    end
    local v2 = Vfx.Place(v1, CFrame.new(a3), 1.2)
    v2.Parent = a2
    return Vfx.Hold(v2)
end

local function fireSound(a1, a2, a3) -- Line: 300
    -- upvalues: u54 (ref), Kit (val)
    if not (u54 >= 6) and a1.Parent ~= nil then
        local u11 = Kit.Loop("FireLoop", a2, a1)
        if u11 == nil then
            return
        end
        u54 = u54 + 1
        local u14 = false
        u11.Destroying:Once(function() -- Line: 312 -- upvalues: u14 (ref), u54 (upval)
            if not u14 then
                u14 = true
                u54 = u54 - 1
            end
        end)
        task.delay(math.max(a3 - 0.4, 0), function() -- Line: 319 -- upvalues: u11 (val), Kit (upval), u14 (ref), u54 (upval)
            if u11.Parent then
                Kit.FadeOut(u11, 0.8)
            end
            if not u14 then
                u14 = true
                u54 = u54 - 1
            end
        end)
        return
    end
end

local function puddleFire(a1, a2, a3, a4) -- Line: 327
    -- upvalues: ScrambleBossHazards (val), Vfx (val), fireSound (val)
    local u12 = (ScrambleBossHazards.ActiveSeconds(a1)) + math.min(a3, 0)
    local u22 = if not (u12 > 0) then nil else Vfx.Template(Vfx.PhaseOne, {"PumpkinCharge", "ChargeRun"})
    if u22 == nil then
        return
    end
    local u28 = (a1.Radius or 10) * 1.7724538509055159 * 0.85
    local u31 = Vector3.new(1, 0, 0) * u28 / 2
    task.delay(math.max(a3, 0), function() -- Line: 343
        -- upvalues: Vfx (upval), u22 (val), a2 (val), u31 (val), u28 (val), fireSound (upval), a4 (val), u12 (val)
        local Lifetime, new, v1
        local u11 = Vfx.Strip(u22, CFrame.new(a2), 1, {Particles = 1, Density = Vfx.FireDensity * 0.35})
        for i, j in u11.Root:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                Lifetime = j.Lifetime
                new = NumberRange.new
                v1 = math.min(Lifetime.Min, 1)
                j.Lifetime = new(v1, (math.min(Lifetime.Max, 1)))
            end
        end
        u11:Span(a2 - u31, a2 + u31, u28)
        fireSound(a4, a2, u12)
        task.delay(u12, function() -- Line: 359 -- upvalues: u11 (val)
            u11:Stop()
        end)
    end)
end

local u69 = {}
u69.__index = u69

function u69.new(a1, a2) -- Line: 368 -- upvalues: Kit (val), u69 (val), RunService (val) -- types: a2: userdata
    local Folder = Instance.new("Folder")
    Folder.Name = "PumpkinHazards"
    Folder.Parent = Kit.Debris()
    a1:Add(Folder)
    local v1 = {Views = {}, Folder = Folder, Arena = a2}
    local u17 = setmetatable(v1, u69)
    a1:Connect(RunService.RenderStepped, function() -- Line: 380 -- upvalues: u17 (val)
        u17:Step()
    end)
    return u17
end

function u69:Add(a2) -- Line: 387
    -- upvalues: PumpkinBossState (val), Kit (val), Workspace (val), disc (val), segmentRing (val), puddleFire (val)
    -- upvalues: placeRing (val), Vfx (val), bombModel (val), bombCarrier (val), triangle (val), laneIndicator (val)
    -- upvalues: ScrambleBossHazards (val)
    local Attribute = self.Arena:GetAttribute(PumpkinBossState.Attributes.FloorY) or a2.Origin.Y
    local v1 = Attribute + 0.15
    local v2 = v1 + 1
    local Folder = Instance.new("Folder")
    Folder.Name = ("Hazard%*"):format(a2.Id)
    Folder.Parent = self.Folder
    local v3 = Kit.StyleColor(a2.Style)
    local v4 = {Reported = false, Struck = false, Spec = a2, Folder = Folder}
    v4.Parts = {}
    v4.Color = v3
    v4.Floor = v1
    v4.FloorY = v2
    local v5 = Vector3.new(a2.Origin.X, v2, a2.Origin.Z)
    local u45 = Vector3.new(a2.Origin.X, v1, a2.Origin.Z)
    v1 = a2.At - Workspace:GetServerTimeNow()
    if a2.Kind == "Ring" then
        v4.Parts.Warn = disc(Folder, v5, 6, v3, 0.5)
        v4.Parts.Ring = segmentRing(Folder, 44, v3, 1)
    else
        local Unit, Unit_2, v6, v7, v8, v9, v10, v11, v12, v13
        if a2.Kind ~= "Puddle" then
            if a2.Kind == "Strike" or a2.Kind == "Missile" or a2.Kind == "Puddle" then
                v4.Parts.Fill = disc(Folder, v5, 0.5, v3, 0.45)
                v4.Parts.Edge = segmentRing(Folder, 20, v3, 0.2)
                placeRing(v4.Parts.Edge, v5, a2.Radius or 10, 0.6, 0.3)
                if a2.Kind == "Strike" and a2.Style == "Vine" and v1 > 0 then
                    v12 = (a2.Radius or 14) / 14
                    Vfx.Play(Vfx.PhaseTwo, {"Vines", "Emit"}, CFrame.new(u45), v12, v1)
                    task.delay(math.max(v1 - 0.4, 0), function() -- Line: 424 -- upvalues: Folder (val), Kit (upval), u45 (val)
                        if Folder.Parent and Kit.Claim("VineSummon", 4, 0.5) then
                            Kit.Sound("VineSummon", u45)
                        end
                    end)
                end
                if a2.Kind == "Missile" then
                    v13 = if not (a2.Style == "Bomb") then nil else bombModel(Folder, a2.From or u45)
                    if v12 then
                        v6 = Vfx.PhaseOf(self.Arena)
                        if v1 > 0 then
                            v7 = (a2.Radius or 12) / 12 * 1.2
                            Vfx.Play(v6, {"PumpkinThrow", "Explosion"}, CFrame.new(u45), v7, v1)
                        end
                        v4.Carrier = bombCarrier(v6, Folder, a2.From or u45)
                    end
                    v4.Parts.Orb = v13 or Kit.Part({
                        Name = "Orb",
                        Size = Vector3.new(3, 3, 3),
                        Shape = Enum.PartType.Ball,
                        Color = v3,
                        CFrame = CFrame.new(a2.From or u45),
                        Parent = Folder,
                    })
                end
            elseif a2.Kind == "Cone" then
                Unit = Kit.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
                v13 = a2.Radius or 30
                v6 = math.rad((a2.Angle or 60) / 2)
                v7 = math.max(3, (math.ceil((a2.Angle or 60) / 20)))
                v8 = {}
                v9 = v7 - 1
                for i = 0, v9 do
                    v10 = -v6 + i / v7 * v6 * 2
                    v11 = -v6 + (i + 1) / v7 * v6 * 2
                    for j, k in triangle(Folder, v5, v5 + CFrame.Angles(0, v10, 0) * Unit * v13, v5 + CFrame.Angles(0, v11, 0) * Unit * v13, v3) do
                        table.insert(v8, k)
                    end
                end
                v4.Parts.Cone = v8
            elseif a2.Kind ~= "Lane" then
                v4.Parts.Fill = disc(Folder, v5, a2.Radius or 10, v3, 0.5)
            else
                Unit_2 = Kit.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
                v13 = a2.Length or 100
                v6 = v5 + Unit_2 * v13 / 2
                v4.Indicator = if not (v1 > 0) then nil else laneIndicator(a2, Folder, v6, Unit_2)
                v4.Parts.Lane = if a2.Tick ~= nil then nil else if v4.Indicator == nil then Kit.Part({
                    Name = "Lane",
                    Transparency = 0.6,
                    Color = v3,
                    Size = Vector3.new(a2.Width or 20, 0.2, v13),
                    CFrame = CFrame.lookAt(v6, v6 + Unit_2),
                    Parent = Folder,
                }) else nil
            end
        elseif a2.Style == "Fire" then
            puddleFire(a2, u45, v1, Folder)
        elseif a2.Kind == "Strike" or a2.Kind == "Missile" or a2.Kind == "Puddle" then
            v4.Parts.Fill = disc(Folder, v5, 0.5, v3, 0.45)
            v4.Parts.Edge = segmentRing(Folder, 20, v3, 0.2)
            placeRing(v4.Parts.Edge, v5, a2.Radius or 10, 0.6, 0.3)
            if a2.Kind == "Strike" and a2.Style == "Vine" and v1 > 0 then
                v12 = (a2.Radius or 14) / 14
                Vfx.Play(Vfx.PhaseTwo, {"Vines", "Emit"}, CFrame.new(u45), v12, v1)
                task.delay(math.max(v1 - 0.4, 0), function() -- Line: 424 -- upvalues: Folder (val), Kit (upval), u45 (val)
                    if Folder.Parent and Kit.Claim("VineSummon", 4, 0.5) then
                        Kit.Sound("VineSummon", u45)
                    end
                end)
            end
            if a2.Kind == "Missile" then
                v13 = if not (a2.Style == "Bomb") then nil else bombModel(Folder, a2.From or u45)
                if v12 then
                    v6 = Vfx.PhaseOf(self.Arena)
                    if v1 > 0 then
                        v7 = (a2.Radius or 12) / 12 * 1.2
                        Vfx.Play(v6, {"PumpkinThrow", "Explosion"}, CFrame.new(u45), v7, v1)
                    end
                    v4.Carrier = bombCarrier(v6, Folder, a2.From or u45)
                end
                v4.Parts.Orb = v13 or Kit.Part({
                    Name = "Orb",
                    Size = Vector3.new(3, 3, 3),
                    Shape = Enum.PartType.Ball,
                    Color = v3,
                    CFrame = CFrame.new(a2.From or u45),
                    Parent = Folder,
                })
            end
        elseif a2.Kind == "Cone" then
            Unit = Kit.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
            v13 = a2.Radius or 30
            v6 = math.rad((a2.Angle or 60) / 2)
            v7 = math.max(3, (math.ceil((a2.Angle or 60) / 20)))
            v8 = {}
            v9 = v7 - 1
            for n = 0, v9 do
                v10 = -v6 + n / v7 * v6 * 2
                v11 = -v6 + (n + 1) / v7 * v6 * 2
                for m, i5 in triangle(Folder, v5, v5 + CFrame.Angles(0, v10, 0) * Unit * v13, v5 + CFrame.Angles(0, v11, 0) * Unit * v13, v3) do
                    table.insert(v8, i5)
                end
            end
            v4.Parts.Cone = v8
        elseif a2.Kind ~= "Lane" then
            v4.Parts.Fill = disc(Folder, v5, a2.Radius or 10, v3, 0.5)
        else
            Unit_2 = Kit.Flat(a2.Direction or Vector3.new(0, 0, 1)).Unit
            v13 = a2.Length or 100
            v6 = v5 + Unit_2 * v13 / 2
            v4.Indicator = if not (v1 > 0) then nil else laneIndicator(a2, Folder, v6, Unit_2)
            v4.Parts.Lane = if a2.Tick ~= nil then nil else if v4.Indicator == nil then Kit.Part({
                Name = "Lane",
                Transparency = 0.6,
                Color = v3,
                Size = Vector3.new(a2.Width or 20, 0.2, v13),
                CFrame = CFrame.lookAt(v6, v6 + Unit_2),
                Parent = Folder,
            }) else nil
        end
    end
    self.Views[a2.Id] = v4
    task.delay(a2.Warn + ScrambleBossHazards.ActiveSeconds(a2) + 1.2, function() -- Line: 499 -- upvalues: self (val), a2 (val), Folder (val)
        self.Views[a2.Id] = nil
        Folder:Destroy()
    end)
end

function u69:Step() -- Line: 505
    -- upvalues: Workspace (val), LocalPlayer (val), MemberAttribute (val), ScrambleBossHazards (val), placeRing (val)
    -- upvalues: Kit (val), u48 (val), Vfx (val), Remotes (val)
    local Carrier, Fill, Fill_2, Fill_3, Lane, Orb, Spec, Warn_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local v13 = false
    if Humanoid ~= nil then
        v13 = Humanoid.FloorMaterial == Enum.Material.Air
    end
    local v14 = LocalPlayer:GetAttribute(MemberAttribute) == true
    local v15 = nil
    local v16 = nil
    for i, j in self.Views, v15, v16 do
        Spec = j.Spec
        v2 = ServerTimeNow - Spec.At
        v3 = math.clamp(1 + v2 / math.max(Spec.Warn, 0.01), 0, 1)
        v4 = Vector3.new(Spec.Origin.X, j.Floor, Spec.Origin.Z)
        v5 = ScrambleBossHazards.ActiveSeconds(Spec)
        v6 = false
        if v2 >= 0 then
            v6 = v2 <= v5
        end
        v5 = math.sin(ServerTimeNow * 18) * 0.5 + 0.5
        if Spec.Kind ~= "Ring" then
            if Spec.Kind == "Strike" then
                if v2 < 0 then
                    Fill_3 = j.Parts.Fill
                    v8 = math.max((Spec.Radius or 10) * v3, 0.5)
                    Fill_3.Size = Vector3.new(0.2, v8 * 2, v8 * 2)
                    j.Parts.Fill.Transparency = 0.55 - v3 * 0.25
                    Orb = j.Parts.Orb
                    if Orb then
                        v8 = Spec.From or v4
                        if not (Kit.Flat(v8 - v4).Magnitude < 1) then
                            v10 = math.max((v8 - v4).Magnitude * 0.35, 25)
                            v9 = (v8:Lerp(v4, v3)) + Vector3.new(0, math.sin(v3 * 3.141592653589793) * v10, 0)
                        else
                            v9 = v8:Lerp(v4, v3 * v3)
                        end
                        v8 = v3 * 5
                        Orb:PivotTo((CFrame.new(v9)) * (CFrame.Angles(v8, v8 * 0.6, 0)))
                        Carrier = j.Carrier
                        if Carrier then
                            v11 = v9 - (j.CarrierAt or v9)
                            Carrier:Move(if not (0.001 < v11.Magnitude) then (CFrame.new(v9)) * Carrier.Root.CFrame.Rotation else CFrame.lookAt(v9, v9 + v11))
                            j.CarrierAt = v9
                        end
                    end
                elseif not j.Struck then
                    j.Struck = true
                    j.Parts.Fill.Transparency = 1
                    for k, n in j.Parts.Edge do
                        n.Transparency = 1
                    end
                    if j.Parts.Orb then
                        j.Parts.Orb:Destroy()
                        j.Parts.Orb = nil
                    end
                    if j.Carrier then
                        j.Carrier:Stop()
                        j.Carrier = nil
                    end
                    if Spec.Style ~= "Bomb" then
                        Kit.Burst(v4, Spec.Radius or 10, j.Color, 0.35)
                    end
                    v7 = if Spec.Style ~= "Bomb" then if Spec.Style == nil then nil else if Spec.Style ~= "Vine" then "Strike" else nil else u48[Vfx.PhaseOf(v1.Arena)]
                    if v7 and Kit.Claim(v7, 3, 0.25) then
                        Kit.Sound(v7, v4, 1, 0.95 + math.random() * 0.1)
                    end
                end
            elseif Spec.Kind ~= "Missile" then
                if Spec.Kind ~= "Puddle" then
                    if Spec.Kind == "Cone" then
                        v8 = nil
                        v9 = nil
                        for m, i5 in j.Parts.Cone, v8, v9 do
                            v12 = if not (v2 < 0) then math.min(1, 0.62 + v2 * 4) else v5 * 0.2 + 0.62
                            i5.Transparency = v12
                        end
                    elseif Spec.Kind == "Lane" then
                        Lane = j.Parts.Lane
                        if j.Indicator and v2 >= 0 then
                            j.Indicator:Destroy()
                            j.Indicator = nil
                        end
                        if Lane ~= nil then
                            Lane.Transparency = if not (v2 < 0) then if not v6 then 1 else 0.4 else 0.6
                        end
                    end
                elseif not j.Parts.Fill then
                    if Spec.Kind == "Cone" then
                        v8 = nil
                        v9 = nil
                        for i6, i7 in j.Parts.Cone, v8, v9 do
                            v12 = if not (v2 < 0) then math.min(1, 0.62 + v2 * 4) else v5 * 0.2 + 0.62
                            i7.Transparency = v12
                        end
                    elseif Spec.Kind == "Lane" then
                        Lane = j.Parts.Lane
                        if j.Indicator and v2 >= 0 then
                            j.Indicator:Destroy()
                            j.Indicator = nil
                        end
                        if Lane ~= nil then
                            Lane.Transparency = if not (v2 < 0) then if not v6 then 1 else 0.4 else 0.6
                        end
                    end
                elseif v2 < 0 then
                    Fill = j.Parts.Fill
                    v8 = math.max((Spec.Radius or 10) * v3, 0.5)
                    Fill.Size = Vector3.new(0.2, v8 * 2, v8 * 2)
                    j.Parts.Fill.Transparency = 0.7 - v3 * 0.2
                elseif not v6 then
                    j.Parts.Fill.Transparency = 1
                    for i8, i9 in j.Parts.Edge do
                        i9.Transparency = 1
                    end
                else
                    Fill_2 = j.Parts.Fill
                    v8 = Spec.Radius or 10
                    Fill_2.Size = Vector3.new(0.2, v8 * 2, v8 * 2)
                    j.Parts.Fill.Transparency = v5 * 0.15 + 0.35
                end
            elseif v2 < 0 then
                Fill_3 = j.Parts.Fill
                v8 = math.max((Spec.Radius or 10) * v3, 0.5)
                Fill_3.Size = Vector3.new(0.2, v8 * 2, v8 * 2)
                j.Parts.Fill.Transparency = 0.55 - v3 * 0.25
                Orb = j.Parts.Orb
                if Orb then
                    v8 = Spec.From or v4
                    if not (Kit.Flat(v8 - v4).Magnitude < 1) then
                        v10 = math.max((v8 - v4).Magnitude * 0.35, 25)
                        v9 = (v8:Lerp(v4, v3)) + Vector3.new(0, math.sin(v3 * 3.141592653589793) * v10, 0)
                    else
                        v9 = v8:Lerp(v4, v3 * v3)
                    end
                    v8 = v3 * 5
                    Orb:PivotTo((CFrame.new(v9)) * (CFrame.Angles(v8, v8 * 0.6, 0)))
                    Carrier = j.Carrier
                    if Carrier then
                        v11 = v9 - (j.CarrierAt or v9)
                        Carrier:Move(if not (0.001 < v11.Magnitude) then (CFrame.new(v9)) * Carrier.Root.CFrame.Rotation else CFrame.lookAt(v9, v9 + v11))
                        j.CarrierAt = v9
                    end
                end
            elseif not j.Struck then
                j.Struck = true
                j.Parts.Fill.Transparency = 1
                for i10, i11 in j.Parts.Edge do
                    i11.Transparency = 1
                end
                if j.Parts.Orb then
                    j.Parts.Orb:Destroy()
                    j.Parts.Orb = nil
                end
                if j.Carrier then
                    j.Carrier:Stop()
                    j.Carrier = nil
                end
                if Spec.Style ~= "Bomb" then
                    Kit.Burst(v4, Spec.Radius or 10, j.Color, 0.35)
                end
                v7 = if Spec.Style ~= "Bomb" then if Spec.Style == nil then nil else if Spec.Style ~= "Vine" then "Strike" else nil else u48[Vfx.PhaseOf(v1.Arena)]
                if v7 and Kit.Claim(v7, 3, 0.25) then
                    Kit.Sound(v7, v4, 1, 0.95 + math.random() * 0.1)
                end
            end
        elseif not (v2 < 0) then
            j.Parts.Warn.Transparency = 1
            placeRing(j.Parts.Ring, v4, ScrambleBossHazards.RingRadius(Spec, v2), Spec.Width or 2, 2.4)
            v8 = if not v6 then 1 else 0.05
            for i12, i13 in j.Parts.Ring do
                i13.Transparency = v8
            end
        else
            j.Parts.Warn.Transparency = v5 * 0.4 + 0.3
            Warn_2 = j.Parts.Warn
            v8 = v3 * 10 + 6
            Warn_2.Size = Vector3.new(0.2, v8 * 2, v8 * 2)
        end
        if v6 and v14 then
            if not j.Reported then
                if HumanoidRootPart ~= nil and Humanoid ~= nil and 0 < Humanoid.Health then
                    if not v13 then
                        if ScrambleBossHazards.Contains(Spec, v2, HumanoidRootPart.Position, v13, 0) then
                            j.Reported = true
                            j.NextReport = ServerTimeNow + (Spec.Tick or 0)
                            Remotes.PumpkinBoss.HazardHit:FireServer(i)
                            if 0 < Spec.Damage then
                                Kit.Shake(3, 16, 0.5)
                            end
                        end
                    elseif Spec.Jumpable ~= true
                        and ScrambleBossHazards.Contains(Spec, v2, HumanoidRootPart.Position, v13, 0) then
                        j.Reported = true
                        j.NextReport = ServerTimeNow + (Spec.Tick or 0)
                        Remotes.PumpkinBoss.HazardHit:FireServer(i)
                        if 0 < Spec.Damage then
                            Kit.Shake(3, 16, 0.5)
                        end
                    end
                end
            elseif Spec.Tick ~= nil
                and (j.NextReport or 0) <= ServerTimeNow
                and HumanoidRootPart ~= nil
                and Humanoid ~= nil
                and 0 < Humanoid.Health then
                if not v13 then
                    if ScrambleBossHazards.Contains(Spec, v2, HumanoidRootPart.Position, v13, 0) then
                        j.Reported = true
                        j.NextReport = ServerTimeNow + (Spec.Tick or 0)
                        Remotes.PumpkinBoss.HazardHit:FireServer(i)
                        if 0 < Spec.Damage then
                            Kit.Shake(3, 16, 0.5)
                        end
                    end
                elseif Spec.Jumpable ~= true
                    and ScrambleBossHazards.Contains(Spec, v2, HumanoidRootPart.Position, v13, 0) then
                    j.Reported = true
                    j.NextReport = ServerTimeNow + (Spec.Tick or 0)
                    Remotes.PumpkinBoss.HazardHit:FireServer(i)
                    if 0 < Spec.Damage then
                        Kit.Shake(3, 16, 0.5)
                    end
                end
            end
        end
    end
end

return u69