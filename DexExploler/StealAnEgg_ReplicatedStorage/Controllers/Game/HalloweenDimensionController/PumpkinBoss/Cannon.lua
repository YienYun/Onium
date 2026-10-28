-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Cannon
-- Decompile time: 32.00 ms

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local PumpkinBossFlags = require(ReplicatedStorage.Shared.Flags.PumpkinBossFlags)
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ShrinePadZone = require(ReplicatedStorage.Shared.Util.ShrinePadZone)
local Kit = require(script.Parent.Kit)
local Vfx = require(script.Parent.Vfx)
local Phases = PumpkinBossState.Phases
local Attributes = PumpkinBossState.Attributes
local CannonAttributes = PumpkinBossState.CannonAttributes
local TrapAttributes = PumpkinBossState.TrapAttributes
local u67 = Color3.fromRGB(255, 120, 20)
local CannonAim = PumpkinBossState.CannonAim
local LocalPlayer = Players.LocalPlayer

local function ballTemplate() -- Line: 96 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local HalloweenDimension = Assets and Assets:FindFirstChild("HalloweenDimension")
    local v1 = HalloweenDimension and HalloweenDimension:FindFirstChild("PumpkinBoss")
    local PumpkinCannonball = v1 and v1:FindFirstChild("PumpkinCannonball")
    if PumpkinCannonball and PumpkinCannonball:IsA("Model") then
        return PumpkinCannonball
    end
    return nil
end

local function muzzleFlash(a1, a2) -- Line: 105 -- upvalues: Vfx (val) -- types: a1: vector, a2: vector
    local v1 = Vfx.Template(Vfx.PhaseTwo, {"Cannon", "CannonFire"})
    if v1 ~= nil and not (a2.Magnitude < 0.001) then
        local ShotVFX = v1:FindFirstChild("ShotVFX")
        local Position = if not ShotVFX then Vector3.new(0, 0, 0) else if not ShotVFX:IsA("Attachment") then Vector3.new(0, 0, 0) else ShotVFX.Position
        Vfx.Emit(Vfx.Place(v1, (CFrame.lookAt(a1, a1 + a2)) * CFrame.new(-Position)))
        return
    end
end

local function launchPoint(a1) -- Line: 115 -- types: a1: userdata
    local LaunchPoint = a1:FindFirstChild("LaunchPoint", true) or a1:FindFirstChild("Muzzle", true)
    if LaunchPoint and LaunchPoint:IsA("Attachment") then
        return LaunchPoint
    end
    return nil
end

local function rootPart() -- Line: 121 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function alive() -- Line: 127 -- upvalues: LocalPlayer (val), TrapAttributes (val)
    local Character = LocalPlayer.Character
    if Character ~= nil and Character:GetAttribute(TrapAttributes.Trapped) ~= true then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local v1 = false
        if Humanoid ~= nil then
            v1 = 0 < Humanoid.Health
        end
        return v1
    end
    return false
end

local function flat(a1) -- Line: 136 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

local function yawOf(a1) -- Line: 140 -- types: a1: vector
    return (math.atan2(-a1.X, -a1.Z))
end

local function barrelFrame(a1, a2, a3) -- Line: 144 -- types: a1: table, a2: userdata, a3: number
    local v1 = a2:PointToWorldSpace(a1.Hinge)
    return (CFrame.new(v1)) * CFrame.fromAxisAngle(a2.RightVector, a3) * CFrame.new(-v1) * a2 * a1.BarrelLocal
end

local function newAim(a1) -- Line: 154 -- upvalues: CannonAttributes (val), CannonAim (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute(CannonAttributes.Base)
    local Attribute_2 = a1:GetAttribute(CannonAttributes.Hinge)
    local Attribute_3 = a1:GetAttribute(CannonAttributes.Barrel)
    local Barrel_2 = a1:FindFirstChild("Barrel")
    if typeof(Attribute) == "CFrame"
        and typeof(Attribute_2) == "Vector3"
        and typeof(Attribute_3) == "CFrame"
        and Barrel_2 ~= nil
        and Barrel_2:IsA("Model") then
        local OperatorZone = a1:FindFirstChild("OperatorZone")
        local RootHitbox = a1:FindFirstChild("RootHitbox")
        local v1 = if not OperatorZone then nil else if not OperatorZone:IsA("BasePart") then nil else OperatorZone
        local v2 = if not RootHitbox then nil else if not RootHitbox:IsA("BasePart") then nil else RootHitbox
        local v3 = a1:FindFirstChild("OperatorPad")
        local v4 = if not v3 then nil else if not v3:IsA("Model") then nil else v3
        local LookVector = (Attribute * Attribute_3).LookVector
        local LookVector_2 = Barrel_2:GetPivot().LookVector
        return {
            Occupied = false,
            Kick = 0,
            Jolt = 0,
            JoltDirection = Vector3.new(1, 0, 0),
            Model = a1,
            Barrel = Barrel_2,
            Zone = v1,
            ZoneFrame = if not v1 then CFrame.identity else v1.CFrame,
            Hitbox = v2,
            HitboxFrame = if not v2 then CFrame.identity else v2.CFrame,
            Pad = v4,
            PadFrame = if not v4 then CFrame.identity else v4:GetPivot(),
            Rest = Attribute,
            Base = Attribute,
            Hinge = Attribute_2,
            BarrelLocal = Attribute_3,
            Pitch = math.clamp(
                (math.atan2(LookVector_2.Y, (Vector3.new(LookVector_2.X, 0, LookVector_2.Z)).Magnitude)) - math.atan2(LookVector.Y, (Vector3.new(LookVector.X, 0, LookVector.Z)).Magnitude),
                0,
                CannonAim.MaxPitch
            ),
        }
    end
    return nil
end

local function restoreFixed(a1) -- Line: 203 -- types: a1: table
    local Zone = a1.Zone
    local Hitbox = a1.Hitbox
    local Pad = a1.Pad
    if Zone then
        Zone.CFrame = a1.ZoneFrame
    end
    if Hitbox then
        Hitbox.CFrame = a1.HitboxFrame
    end
    if Pad then
        Pad:PivotTo(a1.PadFrame)
    end
end

local function occupied(a1) -- Line: 216 -- upvalues: Players (val), ShrinePadZone (val) -- types: a1: userdata
    local Character, HumanoidRootPart
    for i, j in Players:GetPlayers() do
        Character = j.Character
        HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart
            and HumanoidRootPart:IsA("BasePart")
            and ShrinePadZone.ContainsPoint(v1, HumanoidRootPart.Position) then
            return true
        end
    end
    return false
end

local u81 = {}
u81.__index = u81

function u81.new(a1, a2) -- Line: 230
    -- upvalues: ballTemplate (val), u81 (val), Kit (val), UserInputService (val), RunService (val)
    local v1 = {
        Bound = false,
        NextShotId = 0,
        LastFire = 0,
        NextScan = 0,
        FacingAutoRotate = true,
        Trove = a1,
        Arena = a2,
        Predicted = {},
        Flights = {},
        Folder = Instance.new("Folder"),
        Ball = ballTemplate(),
        MoveParts = {},
        MoveFrames = {},
        Aims = {},
    }
    local u15 = setmetatable(v1, u81)
    u15.Folder.Name = "PumpkinCannonballs"
    u15.Folder.Parent = Kit.Debris()
    a1:Add(u15.Folder)
    a1:Connect(UserInputService.InputBegan, function(a1, a2) -- Line: 256 -- upvalues: u15 (val) -- types: a1: userdata, a2: boolean
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton1
            or a1.UserInputType == Enum.UserInputType.Touch
            or a1.KeyCode == Enum.KeyCode.ButtonR2 then
            u15:Fire()
        end
    end)
    a1:Connect(RunService.RenderStepped, function(a1) -- Line: 269 -- upvalues: u15 (val) -- types: a1: number
        u15:Step(a1)
    end)
    a1:Add(function() -- Line: 272 -- upvalues: u15 (val)
        u15:SetBound(false)
        u15:Face(nil)
        u15:ResetAims()
    end)
    return u15
end

function u81:Usable() -- Line: 282
    -- upvalues: Attributes (val), Phases (val), LocalPlayer (val), PumpkinBossState (val), TrapAttributes (val)
    -- upvalues: CannonAttributes (val), ShrinePadZone (val)
    local Attribute = self.Arena:GetAttribute(Attributes.Phase)
    if Attribute ~= Phases.Shield and Attribute ~= Phases.Stunned then
        return nil
    end
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local v1 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    local v2 = self.Arena:FindFirstChild(PumpkinBossState.CannonFolder)
    if v1 ~= nil and v2 ~= nil then
        local v3
        local Character_2 = LocalPlayer.Character
        if Character_2 == nil then
            v3 = false
        elseif Character_2:GetAttribute(TrapAttributes.Trapped) ~= true then
            local Humanoid = Character_2:FindFirstChildOfClass("Humanoid")
            v3 = false
            if Humanoid ~= nil then
                v3 = 0 < Humanoid.Health
            end
        else
            v3 = false
        end
        if v3 then
            local Attribute_2, OperatorZone_2, OwnerUserId
            v3 = nil
            local v4 = nil
            for i, j in v2:GetChildren() do
                OwnerUserId = CannonAttributes.OwnerUserId
                Attribute_2 = j:GetAttribute(OwnerUserId)
                if Attribute_2 == LocalPlayer.UserId then
                    v3 = j
                elseif Attribute_2 == 0 and v4 == nil then
                    OperatorZone_2 = j:FindFirstChild("OperatorZone")
                    if OperatorZone_2
                        and OperatorZone_2:IsA("BasePart")
                        and ShrinePadZone.ContainsPoint(OperatorZone_2, v1.Position) then
                        v4 = j
                    end
                end
            end
            v2 = v3 or v4
            if v2 ~= nil and v2:GetAttribute(CannonAttributes.Ready) == true then
                local OperatorZone = v2:FindFirstChild("OperatorZone")
                if OperatorZone ~= nil
                    and OperatorZone:IsA("BasePart")
                    and ShrinePadZone.ContainsPoint(OperatorZone, v1.Position) then
                    return v2
                end
                return nil
            end
            return nil
        end
    end
    return nil
end

function u81:SetBound(a2) -- Line: 328 -- upvalues: ContextActionService (val) -- types: a2: boolean
    if self.Bound == a2 then
        return
    end
    self.Bound = a2
    if not a2 then
        ContextActionService:UnbindAction("PumpkinCannonFire")
        return
    end
    local v1 = ContextActionService
    local Value = Enum.ContextActionPriority.High.Value
    v1:BindActionAtPriority("PumpkinCannonFire", function(a1, a2) -- Line: 335 -- upvalues: self (val)
        if a2 == Enum.UserInputState.Begin then
            self:Fire()
        end
        return Enum.ContextActionResult.Pass
    end, true, Value)
    ContextActionService:SetTitle("PumpkinCannonFire", "FIRE")
end

function u81:KingAim() -- Line: 347
    local Hitbox
    for i, j in self.Arena:GetChildren() do
        if j.Name == "King" and j:IsA("Model") then
            Hitbox = j:FindFirstChild("Hitbox")
            if Hitbox and Hitbox:IsA("BasePart") then
                return Hitbox.Position
            end
        end
    end
    return nil
end

function u81:Fire() -- Line: 359
    -- upvalues: PumpkinBossFlags (val), Remotes (val), Kit (val), PumpkinBossState (val), LocalPlayer (val)
    -- upvalues: Workspace (val)
    local Active = self.Active
    if Active == nil then
        return
    end
    local v1 = os.clock()
    if v1 - self.LastFire < PumpkinBossFlags.CannonFireCooldown:Get() then
        return
    end
    self.LastFire = v1
    self.NextShotId = self.NextShotId + 1
    local NextShotId = self.NextShotId
    Remotes.PumpkinBoss.CannonFire:FireServer(NextShotId)
    Kit.Sound("CannonFire", nil, 0.8, 1.3)
    Kit.Shake(4, 12, 0.35)
    self:Kick(Active)
    local LaunchPoint = Active:FindFirstChild("LaunchPoint", true) or Active:FindFirstChild("Muzzle", true)
    local v2 = if not LaunchPoint then nil else if not LaunchPoint:IsA("Attachment") then nil else LaunchPoint
    local v3 = self:KingAim()
    if v2 and v3 then
        local WorldPosition = v2.WorldPosition
        local Predicted = self.Predicted
        local v4 = PumpkinBossState.ShotKey(LocalPlayer.UserId, NextShotId)
        Predicted[v4] = v1 + 5
        self:Launch(WorldPosition, v3, PumpkinBossState.ShotFlight(WorldPosition, v3), (Workspace:GetServerTimeNow()))
    end
end

function u81:Launch(a2, a3, a4, a5) -- Line: 393
    -- upvalues: Kit (val), u67 (val), PumpkinBossState (val), muzzleFlash (val)
    local v1, v2
    local v3 = {}
    local v4 = {}
    local Ball = self.Ball
    if not Ball then
        v2 = Kit.Part({
            Name = "Cannonball",
            Size = Vector3.new(3, 3, 3),
            Shape = Enum.PartType.Ball,
            Material = Enum.Material.SmoothPlastic,
            Color = u67,
            CFrame = CFrame.new(a2),
        })
        v2.Parent = self.Folder
        v1 = v2
        table.insert(v3, v2)
        table.insert(v4, CFrame.identity)
    else
        v2 = Ball:Clone()
        local Pivot = v2:GetPivot()
        for i, j in v2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
                table.insert(v3, j)
                table.insert(v4, (Pivot:ToObjectSpace(j.CFrame)))
            end
        end
        v2:PivotTo((CFrame.new(a2)))
        v2.Parent = self.Folder
        v1 = v2
    end
    local v5 = PumpkinBossState.LaunchVelocity(a2, a3, a4)
    muzzleFlash(a2, v5)
    Kit.Poof(a2, 0.7)
    table.insert(self.Flights, {
        Root = v1,
        Parts = v3,
        Offsets = v4,
        Last = a2,
        Origin = a2,
        Velocity = v5,
        Target = a3,
        StartedAt = a5,
        Seconds = a4,
    })
end

function u81.OnShot(a1, a2) -- Line: 452
    -- upvalues: PumpkinBossState (val), LocalPlayer (val), Workspace (val), Kit (val), CannonAttributes (val)
    local v1 = PumpkinBossState.ShotKey(a2.UserId, a2.ShotId)
    if a2.UserId == LocalPlayer.UserId and a1.Predicted[v1] then
        a1.Predicted[v1] = nil
        return
    end
    if typeof(a2.Origin) == "Vector3" and typeof(a2.Target) == "Vector3" then
        a1:Launch(a2.Origin, a2.Target, a2.Flight or 1, a2.StartAt or Workspace:GetServerTimeNow())
        Kit.Sound("CannonFire", a2.Origin, 0.6, 1.3)
        Kit.ShakeFrom(a2.Origin, 2, 90)
    end
    v1 = a1.Arena:FindFirstChild(PumpkinBossState.CannonFolder)
    if v1 and type(a2.CannonId) == "number" then
        local CannonId_2
        for i, j in v1:GetChildren() do
            if j:IsA("Model") then
                CannonId_2 = CannonAttributes.CannonId
                if (j:GetAttribute(CannonId_2)) == a2.CannonId then
                    a1:Kick(j)
                    return
                end
            end
        end
    end
end

function u81:Kick(a2) -- Line: 481 -- upvalues: newAim (val) -- types: a2: userdata
    local Aims = self.Aims
    local v1 = Aims[a2]
    if v1 == nil then
        v1 = newAim(a2)
        if v1 == nil then
            return
        end
        Aims[a2] = v1
    end
    v1.Kick = 1
end

function u81.Jolt(a1, a2, a3) -- Line: 494
    -- upvalues: newAim (val), LocalPlayer (val), Workspace (val)
    local LookVector
    local Aims = a1.Aims
    local v1 = Aims[a2]
    if v1 == nil then
        v1 = newAim(a2)
        if v1 == nil then
            return
        end
        Aims[a2] = v1
    end
    local Position = a3 or v1.Base.Position
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local v2 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    local CurrentCamera = Workspace.CurrentCamera
    local v3 = Vector3.new(
        (if not v2 then if not CurrentCamera then Vector3.new(1, 0, 0) else CurrentCamera.CFrame.LookVector else if not ((v2.Position - Position).Magnitude <= 24) then if not CurrentCamera then Vector3.new(1, 0, 0) else CurrentCamera.CFrame.LookVector else Position - v2.Position).X,
        0,
        LookVector.Z
    )
    v1.JoltDirection = if not (0.001 < v3.Magnitude) then Vector3.new(1, 0, 0) else v3.Unit
    v1.Jolt = 1
end

local function unjolt(a1) -- Line: 517 -- types: a1: table
    local Jolted = a1.Jolted
    if Jolted == nil then
        return
    end
    a1.Jolted = nil
    a1.Model:PivotTo((Jolted:Inverse()) * (a1.Model:GetPivot()))
    local Zone = a1.Zone
    local Hitbox = a1.Hitbox
    local Pad = a1.Pad
    if Zone then
        Zone.CFrame = a1.ZoneFrame
    end
    if Hitbox then
        Hitbox.CFrame = a1.HitboxFrame
    end
    if Pad then
        Pad:PivotTo(a1.PadFrame)
    end
end

local function jolt(a1, a2) -- Line: 528 -- types: a1: table, a2: number
    if a1.Jolt <= 0 then
        return
    end
    a1.Jolt = math.max(a1.Jolt - a2 / 0.25, 0)
    local Jolt = a1.Jolt
    local v1 = math.sin((1 - Jolt) * 3.141592653589793 * 2.5) * Jolt * Jolt
    if not (Jolt <= 0) then
        local v2 = math.abs(v1)
        if not (v2 < 0.0001) then
            local Position = a1.Base.Position
            local JoltDirection = a1.JoltDirection
            v2 = Vector3.new(0, 1, 0):Cross(JoltDirection)
            local identity = if not (0.001 < v2.Magnitude) then CFrame.identity else CFrame.fromAxisAngle(v2.Unit, v1 * 0.04363323129985824)
            v2 = CFrame.new(Position + a1.JoltDirection * 0.35 * v1) * identity * CFrame.new(-Position)
            a1.Model:PivotTo(v2 * (a1.Model:GetPivot()))
            a1.Jolted = v2
            local Zone = a1.Zone
            local Hitbox = a1.Hitbox
            local Pad = a1.Pad
            if Zone then
                Zone.CFrame = a1.ZoneFrame
            end
            if Hitbox then
                Hitbox.CFrame = a1.HitboxFrame
            end
            if Pad then
                Pad:PivotTo(a1.PadFrame)
            end
            return
        end
    end
end

local function kick(a1, a2) -- Line: 553 -- upvalues: barrelFrame (val) -- types: a1: table, a2: number
    local v1
    if a1.Kick <= 0 then
        return
    end
    a1.Kick = math.max(a1.Kick - a2 / 0.4, 0)
    local v2 = 1 - a1.Kick
    a1.Barrel:PivotTo((barrelFrame(a1, a1.Base, a1.Pitch + (if not (v2 < 0.12) then (1 - (v2 - 0.12) / 0.88) ^ 2 else v2 / 0.12) * 0.17453292519943295)) * (CFrame.new(0, 0, v1 * 1.8)))
end

function u81:Scan() -- Line: 570
    -- upvalues: PumpkinBossState (val), Attributes (val), Phases (val), newAim (val), CannonAttributes (val)
    -- upvalues: occupied (val)
    local Ready, Zone, v1
    local Aims = self.Aims
    local v2 = nil
    for i in Aims, v2 do
        if i.Parent == nil then
            Aims[i] = nil
        end
    end
    local v3 = self.Arena:FindFirstChild(PumpkinBossState.CannonFolder)
    if v3 == nil then
        return
    end
    local Attribute = self.Arena:GetAttribute(Attributes.Phase)
    local v4 = true
    if Attribute ~= Phases.Shield then
        v4 = Attribute == Phases.Stunned
    end
    for j, k in v3:GetChildren() do
        if k:IsA("Model") then
            v2 = Aims[k]
            if v2 ~= nil then
                Zone = v2.Zone
                v1 = v4
                if v1 then
                    v1 = false
                    if Zone ~= nil then
                        v1 = false
                        Ready = CannonAttributes.Ready
                        if k:GetAttribute(Ready) == true then
                            v1 = occupied(Zone)
                        end
                    end
                end
                v2.Occupied = v1
            else
                v2 = newAim(k)
                if v2 ~= nil then
                    Aims[k] = v2
                    Zone = v2.Zone
                    v1 = v4
                    if v1 then
                        v1 = false
                        if Zone ~= nil then
                            v1 = false
                            Ready = CannonAttributes.Ready
                            if k:GetAttribute(Ready) == true then
                                v1 = occupied(Zone)
                            end
                        end
                    end
                    v2.Occupied = v1
                end
            end
        end
    end
end

local function turn(a1, a2, a3) -- Line: 606
    -- upvalues: CannonAim (val), barrelFrame (val)
    local Base = a1.Base
    local Position = Base.Position
    local v1 = a2 - Position
    local v2 = Vector3.new(v1.X, 0, v1.Z)
    if v2.Magnitude <= CannonAim.MinDistance then
        return
    end
    local LookVector = Base.LookVector
    v1 = math.atan2(-LookVector.X, -LookVector.Z)
    local v3 = (math.atan2(-v2.X, -v2.Z) - v1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
    v2 = CannonAim.TurnRate * a3
    local v4 = v1 + math.clamp(v3, -v2, v2)
    v3 = (CFrame.new(Position)) * CFrame.Angles(0, v4, 0)
    v2 = a2 - v3:PointToWorldSpace(a1.Hinge)
    local v5 = math.clamp(math.atan2(v2.Y, (Vector3.new(v2.X, 0, v2.Z)).Magnitude), 0, CannonAim.MaxPitch)
    v2 = CannonAim.PitchRate * a3
    local v6 = a1.Pitch + math.clamp(v5 - a1.Pitch, -v2, v2)
    if not (0.0001 < (math.abs(v4 - v1))) and (math.abs(v6 - a1.Pitch)) <= 0.0001 then
        return
    end
    if v2 then
        a1.Model:PivotTo(v3 * Base:Inverse() * (a1.Model:GetPivot()))
        a1.Base = v3
        local Zone = a1.Zone
        local Hitbox = a1.Hitbox
        local Pad = a1.Pad
        if Zone then
            Zone.CFrame = a1.ZoneFrame
        end
        if Hitbox then
            Hitbox.CFrame = a1.HitboxFrame
        end
        if Pad then
            Pad:PivotTo(a1.PadFrame)
        end
    end
    a1.Pitch = v6
    a1.Barrel:PivotTo((barrelFrame(a1, a1.Base, v6)))
end

function u81:ResetAims() -- Line: 640 -- upvalues: barrelFrame (val)
    local Barrel, Base, Hitbox, Hitbox_2, Jolted, Pad, Pad_2, Pitch, Zone, Zone_2, v1
    local v2 = nil
    local v3 = nil
    for i, j in self.Aims, v2, v3 do
        j.Jolt = 0
        if i.Parent then
            Jolted = j.Jolted
            if Jolted ~= nil then
                j.Jolted = nil
                j.Model:PivotTo((Jolted:Inverse()) * (j.Model:GetPivot()))
                Zone = j.Zone
                Hitbox = j.Hitbox
                Pad = j.Pad
                if Zone then
                    Zone.CFrame = j.ZoneFrame
                end
                if Hitbox then
                    Hitbox.CFrame = j.HitboxFrame
                end
                if Pad then
                    Pad:PivotTo(j.PadFrame)
                end
            end
        end
        if i.Parent and 0 < j.Kick then
            j.Kick = 0
            Barrel = j.Barrel
            v1 = barrelFrame
            Base = j.Base
            Pitch = j.Pitch
            v1 = v1(j, Base, Pitch)
            Barrel:PivotTo(v1)
        end
        if i.Parent and j.Base ~= j.Rest then
            v1 = j.Rest * j.Base:Inverse() * (i:GetPivot())
            i:PivotTo(v1)
            Zone_2 = j.Zone
            Hitbox_2 = j.Hitbox
            Pad_2 = j.Pad
            if Zone_2 then
                Zone_2.CFrame = j.ZoneFrame
            end
            if Hitbox_2 then
                Hitbox_2.CFrame = j.HitboxFrame
            end
            if Pad_2 then
                Pad_2:PivotTo(j.PadFrame)
            end
        end
    end
    table.clear(self.Aims)
end

function u81:Face(a2) -- Line: 659 -- upvalues: LocalPlayer (val) -- types: a2: vector?
    local Character = LocalPlayer.Character
    local Humanoid = if not a2 then nil else if not Character then nil else Character:FindFirstChildOfClass("Humanoid")
    local Facing = self.Facing
    if Facing and Facing ~= Humanoid then
        if Facing.Parent then
            Facing.AutoRotate = self.FacingAutoRotate
        end
        self.Facing = nil
    end
    if Humanoid ~= nil and a2 ~= nil then
        local v1
        if self.Facing == nil then
            self.FacingAutoRotate = Humanoid.AutoRotate
            Humanoid.AutoRotate = false
            self.Facing = Humanoid
        end
        local Character_2 = LocalPlayer.Character
        local HumanoidRootPart = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
        if (if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
            return
        end
        local v2 = a2 - v1.Position
        local v3 = Vector3.new(v2.X, 0, v2.Z)
        if v3.Magnitude < 0.001 then
            return
        end
        local v4 = math.atan2(-v3.X, -v3.Z)
        local LookVector = v1.CFrame.LookVector
        if 0.017453292519943295 < (math.abs((v4 - (math.atan2(-LookVector.X, -LookVector.Z)) + 3.141592653589793) % 6.283185307179586 - 3.141592653589793)) then
            v1.CFrame = CFrame.lookAt(v1.Position, v1.Position + v3.Unit)
        end
        return
    end
end

function u81:Step(a2) -- Line: 695
    -- upvalues: turn (val), kick (val), jolt (val), Workspace (val), PumpkinBossState (val)
    local Hitbox, Jolted, Pad, Zone, v1, v2, v3, v4, v5
    self.Active = self:Usable()
    self:SetBound(self.Active ~= nil)
    local v6 = os.clock()
    if self.NextScan <= v6 then
        self.NextScan = v6 + 0.2
        self:Scan()
    end
    local v7 = nil
    local v8 = false
    local Aims = self.Aims
    local v9 = nil
    local v10 = nil
    local v11, v12 = self, a2
    for i, j in Aims, v9, v10 do
        Jolted = j.Jolted
        if Jolted ~= nil then
            j.Jolted = nil
            j.Model:PivotTo((Jolted:Inverse()) * (j.Model:GetPivot()))
            Zone = j.Zone
            Hitbox = j.Hitbox
            Pad = j.Pad
            if Zone then
                Zone.CFrame = j.ZoneFrame
            end
            if Hitbox then
                Hitbox.CFrame = j.HitboxFrame
            end
            if Pad then
                Pad:PivotTo(j.PadFrame)
            end
        end
        if j.Occupied then
            if not v8 then
                v7 = v11:KingAim()
                v8 = true
            end
            if v7 then
                turn(j, v7, v12)
            end
        end
        kick(j, v12)
        jolt(j, v12)
    end
    if not v11.Active then
        v11:Face(nil)
    else
        v11:Face(if not v8 then v11:KingAim() else v7)
    end
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local MoveParts = v11.MoveParts
    local MoveFrames = v11.MoveFrames
    v9 = 0
    for k = #v11.Flights, 1, -1 do
        v1 = v11.Flights[k]
        v2 = ServerTimeNow - v1.StartedAt
        if not (v1.Seconds <= v2) then
            v3 = PumpkinBossState.Arc(v1.Origin, v1.Velocity, (math.max(v2, 0)))
            v4 = v3 - v1.Last
            v5 = if not (0.001 < v4.Magnitude) then CFrame.new(v3) else CFrame.lookAt(v3, v3 + v4)
            v1.Last = v3
            for n, m in v1.Parts do
                v9 = v9 + 1
                MoveParts[v9] = m
                MoveFrames[v9] = v5 * v1.Offsets[n]
            end
        else
            v1.Root:Destroy()
            table.remove(v11.Flights, k)
        end
    end
    if v9 > 0 then
        Workspace:BulkMoveTo(MoveParts, MoveFrames, Enum.BulkMoveMode.FireCFrameChanged)
    end
    table.clear(MoveParts)
    table.clear(MoveFrames)
    for i5, i6 in v11.Predicted do
        if i6 < v6 then
            v11.Predicted[i5] = nil
        end
    end
end

return u81