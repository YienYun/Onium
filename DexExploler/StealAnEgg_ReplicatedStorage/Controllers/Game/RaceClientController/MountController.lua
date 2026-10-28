-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.MountController
-- Decompile time: 35.01 ms

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local RaceTrackPath = require(ReplicatedStorage.Shared.Modules.RaceTrackPath)
local Signal = require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u53 = {-0.8, 0, 0.8}
local PlayerModule = (LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("PlayerModule")
local Controls = require(PlayerModule):GetControls()

local function flatten(a1, a2) -- Line: 89 -- types: a1: vector, a2: vector
    local v1 = a1 - a2 * a1:Dot(a2)
    if 0.001 < v1.Magnitude then
        return v1.Unit
    end
    return nil
end

local function approach(a1, a2, a3) -- Line: 94 -- types: a1: number, a2: number, a3: number
    if a1 < a2 then
        return (math.min(a1 + a3, a2))
    end
    return (math.max(a1 - a3, a2))
end

local function lerp(a1, a2, a3) -- Line: 101 -- types: a1: number, a2: number, a3: number
    return a1 + (a2 - a1) * a3
end

local u75 = {}
u75.__index = u75

function u75.new(a1, a2, a3) -- Line: 159
    -- upvalues: RaceTrackPath (val), UserInputService (val), MountRace (val), Signal (val), u75 (val)
    -- upvalues: MountRaceFlags (val), ContextActionService (val), RunService (val)
    local v1
    local Root = a2.Root
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Include
    v2.FilterDescendantsInstances = {a3.Track, a3.Map}
    v2.RespectCanCollide = true
    local v3 = RaycastParams.new()
    v3.FilterType = Enum.RaycastFilterType.Exclude
    v3.FilterDescendantsInstances = {a2.Character}
    v3.RespectCanCollide = true
    v3.CollisionGroup = a2.Mount.Hitbox.CollisionGroup
    local v4 = a1:Add((Instance.new("Attachment")))
    v4.Name = "MountDrive"
    v4.Parent = Root
    local v5 = a1:Add((Instance.new("LinearVelocity")))
    v5.Attachment0 = v4
    v5.RelativeTo = Enum.ActuatorRelativeTo.World
    v5.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
    v5.ForceLimitMode = Enum.ForceLimitMode.Magnitude
    v5.MaxForce = Root.AssemblyMass * 600
    v5.PlaneVelocity = Vector2.zero
    v5.Parent = Root
    local v6 = a1:Add((Instance.new("AlignOrientation")))
    v6.Mode = Enum.OrientationAlignmentMode.OneAttachment
    v6.Attachment0 = v4
    v6.Responsiveness = 35
    v6.MaxTorque = (1 / 0)
    v6.MaxAngularVelocity = (1 / 0)
    v6.CFrame = Root.CFrame.Rotation
    v6.Parent = Root
    local v7 = a1:Add((Instance.new("VectorForce")))
    v7.Attachment0 = v4
    v7.RelativeTo = Enum.ActuatorRelativeTo.World
    v7.ApplyAtCenterOfMass = true
    v7.Force = Vector3.new(0, 0, 0)
    v7.Parent = Root
    local v8 = {
        Rig = a2,
        Path = RaceTrackPath.new(a3.AttachmentTrack),
        Params = v2,
        Drive = v5,
        Align = v6,
        Push = v7,
        Speed = 0,
        Heading = Root.CFrame.LookVector,
        TravelDirection = Root.CFrame.LookVector,
        Up = Vector3.new(0, 1, 0),
        Grounded = false,
        AirSeconds = 0,
        Launched = false,
        Handbrake = false,
        Touch = (UserInputService:GetLastInputType()) == Enum.UserInputType.Touch,
        AssistProgress = 0,
        Holds = {},
        BoostScale = 1,
        BoostUntil = 0,
        SpeedScales = {},
        StickMinRatio = nil,
        IgnoreGroundUntil = 0,
        LastJumpAt = 0,
        LastWallAt = 0,
        Commanded = Vector3.new(0, 0, 0),
        LastPlanarSpeed = 0,
        LastNormalSpeed = 0,
        GhostUntil = 0,
        GhostParams = v3,
        PopLimit = MountRace.NumberAttribute(a2.Mount, "GroundPopLimit", -1),
        BuriedSeconds = 0,
        StalledSeconds = 0,
        LastUnstickAt = 0,
        UnstickGhostUntil = 0,
        HitboxCollides = a2.Mount.Hitbox.CanCollide,
        WallHit = a1:Add((Signal.new())),
        Landed = a1:Add((Signal.new())),
        Boosted = a1:Add((Signal.new())),
        Override = nil,
        JumpTrack = nil,
    }
    local u136 = setmetatable(v8, u75)
    a2.Humanoid.PlatformStand = true
    a1:Add(function() -- Line: 245 -- upvalues: a2 (val), Root (val)
        a2.Humanoid.PlatformStand = false
        Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end)
    a1:Add(function() -- Line: 250 -- upvalues: u136 (val)
        u136:EndUnstickGhost()
    end)
    local Animator = a2.Humanoid:FindFirstChildOfClass("Animator")
    local v9 = ("%* needs an Animator"):format((a2.Character:GetFullName()))
    assert(Animator ~= nil, v9)
    if not MountRaceFlags.RiderAnimationsEnabled:Get() then
        v3 = a2.Character:FindFirstChild("Animate")
        v2 = if v3 == nil then nil else v3:FindFirstChild("sit")
        local v10 = ("%* needs Animate.sit"):format((a2.Character:GetFullName()))
        assert((if v2 == nil then nil else v2:FindFirstChildOfClass("Animation")) ~= nil, v10)
        v1 = v3
    else
        v1 = a1:Add((Instance.new("Animation")))
        v1.AnimationId = MountRace.RiderAnimations.Ride
        v6 = a1:Add((Instance.new("Animation")))
        v6.AnimationId = MountRace.RiderAnimations.Jump
        local u199 = Animator:LoadAnimation(v6)
        u199.Priority = Enum.AnimationPriority.Action2
        u199.Looped = false
        u136.JumpTrack = u199
        a1:Connect(u136.Landed, function() -- Line: 267 -- upvalues: u199 (val)
            u199:Stop(0.15)
        end)
        a1:Add(function() -- Line: 270 -- upvalues: u199 (val)
            u199:Stop()
        end)
    end
    local u258 = Animator:LoadAnimation(v1)
    u258.Priority = Enum.AnimationPriority.Action
    u258.Looped = true
    u258:Play()
    a1:Add(function() -- Line: 284 -- upvalues: u258 (val)
        u258:Stop()
    end)
    v9 = ContextActionService
    local Value = Enum.ContextActionPriority.High.Value
    local LeftShift = Enum.KeyCode.LeftShift
    local RightShift = Enum.KeyCode.RightShift
    local ButtonB = Enum.KeyCode.ButtonB
    v9:BindActionAtPriority("MountRaceHandbrake", function(a1, a2) -- Line: 291 -- upvalues: u136 (val)
        u136.Handbrake = a2 == Enum.UserInputState.Begin
        return Enum.ContextActionResult.Sink
    end, false, Value, LeftShift, RightShift, ButtonB)
    a1:Add(function() -- Line: 301 -- upvalues: ContextActionService (upval)
        ContextActionService:UnbindAction("MountRaceHandbrake")
    end)
    a1:Connect(UserInputService.LastInputTypeChanged, function(a1) -- Line: 305 -- upvalues: u136 (val)
        u136.Touch = a1 == Enum.UserInputType.Touch
    end)
    a1:Connect(UserInputService.JumpRequest, function() -- Line: 308 -- upvalues: u136 (val)
        u136:Jump()
    end)
    a1:Connect(RunService.PreSimulation, function(a1) -- Line: 311 -- upvalues: u136 (val) -- types: a1: number
        u136:Step(a1)
    end)
    return u136
end

function u75.SetHold(a1, a2, a3) -- Line: 317 -- types: a2: string, a3: boolean
    local v1 = if not a3 then nil else true
    a1.Holds[a2] = v1
end

function u75:IsHeld() -- Line: 321
    return next(self.Holds) ~= nil
end

function u75.ApplyBoost(a1, a2, a3) -- Line: 325 -- upvalues: MountRaceFlags (val) -- types: a2: number, a3: number
    a1.BoostScale = a2
    a1.BoostUntil = os.clock() + a3
    a1.Speed = math.max(a1.Speed, (MountRaceFlags.TopSpeed:Get()) * a2)
    a1.Boosted:Fire(a2)
end

function u75.SetSpeedScale(a1, a2, a3) -- Line: 333 -- types: a2: string, a3: number?
    a1.SpeedScales[a2] = a3
end

function u75.SetStickMode(a1, a2) -- Line: 338 -- types: a2: number?
    a1.StickMinRatio = a2
end

function u75.Launch(a1, a2) -- Line: 342 -- types: a2: vector
    a1.Rig.Root.AssemblyLinearVelocity = a2
    a1.IgnoreGroundUntil = os.clock() + 0.3
    a1.Grounded = false
    a1.Launched = true
end

function u75.Place(a1, a2) -- Line: 350 -- types: a2: userdata
    local Root = a1.Rig.Root
    Root.CFrame = a2
    Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    a1.Align.CFrame = a2.Rotation
    a1.Speed = 0
    a1.Heading = a2.LookVector
    a1.TravelDirection = a2.LookVector
    a1.Up = a2.UpVector
    a1.AirSeconds = 0
    a1.Launched = false
    a1.StickMinRatio = nil
    a1.BoostUntil = 0
    a1.Commanded = Vector3.new(0, 0, 0)
    a1.GhostUntil = 0
    a1.BuriedSeconds = 0
    a1.StalledSeconds = 0
    a1:EndUnstickGhost()
    local JumpTrack = a1.JumpTrack
    if JumpTrack ~= nil then
        JumpTrack:Stop(0)
    end
end

function u75.SpeedRatio(a1) -- Line: 375 -- upvalues: MountRaceFlags (val)
    return (math.abs(a1.Speed)) / MountRaceFlags.TopSpeed:Get()
end

function u75:TopSpeedScale() -- Line: 379
    local BoostScale = if not (os.clock() < self.BoostUntil) then 1 else self.BoostScale
    for i, j in self.SpeedScales do
        BoostScale = BoostScale * j
    end
    return BoostScale
end

function u75:Jump() -- Line: 387 -- upvalues: MountRaceFlags (val)
    local v1 = os.clock()
    if self.Override == nil and not self:IsHeld() and self.Grounded and not (v1 - self.LastJumpAt < 0.35) then
        self.LastJumpAt = v1
        self.IgnoreGroundUntil = v1 + 0.15
        self.Grounded = false
        local Root = self.Rig.Root
        Root.AssemblyLinearVelocity = Root.AssemblyLinearVelocity + self.Up * MountRaceFlags.JumpPower:Get()
        self:PlayJumpAnimation()
        return
    end
end

function u75:PlayJumpAnimation() -- Line: 401
    local JumpTrack = self.JumpTrack
    if JumpTrack ~= nil then
        JumpTrack:Play(0.15)
    end
end

function u75:ProbeGround() -- Line: 408 -- upvalues: MountRaceFlags (val), u53 (val), Workspace (val)
    local CFrame, Z, v1
    local Hitbox = self.Rig.Mount.Hitbox
    local Up = self.Up
    local v2 = Hitbox.Size.Y / 2 + 3
    local v3 = math.cos((math.rad((MountRaceFlags.MaxGroundAngle:Get()))))
    local v4 = Vector3.new(0, 0, 0)
    local v5 = 0
    for i, j in u53 do
        CFrame = Hitbox.CFrame
        Z = Hitbox.Size.Z
        v1 = Workspace:Raycast(CFrame:PointToWorldSpace((Vector3.new(0, 0, j * Z / 2))), -Up * v2, self.Params)
        if v1 ~= nil and v3 <= v1.Normal:Dot(Up) then
            v4 = v4 + v1.Normal
            v5 = v5 + 1
        end
    end
    if v5 == 0 then
        return false, Up
    end
    return true, v4.Unit
end

function u75:ProbeLoopEdge(a2) -- Line: 429 -- upvalues: Workspace (val) -- types: a2: vector
    local Hitbox = self.Rig.Mount.Hitbox
    local Up = self.Up
    local v1 = a2:Cross(Up)
    local v2 = Hitbox.Size.Y / 2 + 3
    local v3 = Hitbox.Size.X / 2 + 1
    local v4 = Workspace:Raycast(Hitbox.Position - v1 * v3, -Up * v2, self.Params) ~= nil
    local v5 = Workspace:Raycast(Hitbox.Position + v1 * v3, -Up * v2, self.Params) ~= nil
    if v4 and not v5 then
        return -1
    end
    if v5 and not v4 then
        return 1
    end
    return 0
end

function u75:RoadBelow() -- Line: 445 -- upvalues: Workspace (val)
    local Hitbox = self.Rig.Mount.Hitbox
    return Workspace:Raycast(Hitbox.Position, -self.Up * (Hitbox.Size.Y / 2 + 12), self.Params) ~= nil
end

function u75:AssistYaw(a2, a3, a4) -- Line: 451
    -- upvalues: MountRaceFlags (val)
    local v1 = MountRaceFlags.TouchSteerAssistDegrees:Get()
    if v1 <= 0 then
        return 0
    end
    local Path = self.Path
    local Position = self.Rig.Root.Position
    local v2, v3 = Path:Project(Position, self.AssistProgress, 80, 80)
    if v3 > 60 then
        v2 = Path:Project(Position, 0, Path.Length, Path.Length)
    end
    self.AssistProgress = v2
    local v4 = Path:FrameAt(v2 + 45).Position - Position
    local v5 = v4 - a3 * v4:Dot(a3)
    local Unit = if not (0.001 < v5.Magnitude) then nil else v5.Unit
    if Unit ~= nil and not ((a2:Dot(Unit)) < 0.5) then
        v2 = math.atan2((a2:Cross(Unit)):Dot(a3), (a2:Dot(Unit)))
        v3 = math.rad(v1) * a4
        return (math.clamp(v2, -v3, v3))
    end
    return 0
end

function u75:CheckWall(a2, a3) -- Line: 473
    -- upvalues: Workspace (val), MountRaceFlags (val)
    if (math.abs(self.Speed)) < 1 then
        return
    end
    local Hitbox = self.Rig.Mount.Hitbox
    local Up = self.Up
    local v1 = self.TravelDirection * (if not (0 <= self.Speed) then -1 else 1)
    local v2 = Workspace:Blockcast(
        Hitbox.CFrame + Up * 1,
        Hitbox.Size * Vector3.new(0.8999999761581421, 0.6000000238418579, 0.8999999761581421),
        v1 * (math.abs(self.Speed) * a3 + 2),
        self.Params
    )
    if v2 ~= nil then
        local v3 = v2.Normal:Dot(Up)
        local v4 = math.rad((MountRaceFlags.MaxGroundAngle:Get()))
        if not (math.cos(v4) <= v3) then
            local Unit_2, v5
            local v6 = -v1:Dot(v2.Normal)
            if v6 <= 0 then
                return
            end
            v3 = math.abs(self.Speed) * v6
            v4 = v1 - v2.Normal * v1:Dot(v2.Normal)
            local v7 = v4 - Up * v4:Dot(Up)
            local Unit = if not (0.001 < v7.Magnitude) then nil else v7.Unit
            if Unit == nil then
                self.Speed = -v5 * 12
                Unit_2 = Unit
                if not Unit_2 then
                    v4 = v2.Normal:Cross(Up)
                    v7 = v4 - Up * v4:Dot(Up)
                    Unit_2 = if not (0.001 < v7.Magnitude) then nil else v7.Unit
                end
                v4 = if Unit_2 == nil then a2 else a2:Lerp(Unit_2 * v5, 0.6)
                if 0.001 < v4.Magnitude then
                    self.Heading = v4.Unit
                end
            elseif not (v6 > 0.75) then
                self.Speed = self.Speed * ((MountRaceFlags.WallSpeedKeep:Get() - 1) * v6 + 1)
                self.TravelDirection = Unit * v5
                self.Heading = a2:Lerp(Unit * v5, 0.6).Unit
            else
                self.Speed = -v5 * 12
                Unit_2 = Unit
                if not Unit_2 then
                    v4 = v2.Normal:Cross(Up)
                    v7 = v4 - Up * v4:Dot(Up)
                    Unit_2 = if not (0.001 < v7.Magnitude) then nil else v7.Unit
                end
                v4 = if Unit_2 == nil then a2 else a2:Lerp(Unit_2 * v5, 0.6)
                if 0.001 < v4.Magnitude then
                    self.Heading = v4.Unit
                end
            end
            local v8 = os.clock()
            if MountRaceFlags.WallJoltMinSpeed:Get() <= v3 and 0.25 <= v8 - self.LastWallAt then
                self.LastWallAt = v8
                self.WallHit:Fire(v3)
            end
            return
        end
    end
end

function u75:SmoothGhostContact(a2, a3) -- Line: 519
    -- upvalues: MountRaceFlags (val), Workspace (val)
    if MountRaceFlags.GhostContactSmoothing:Get() and not self.Launched and not (a3 - self.LastWallAt < 0.25) then
        local Commanded = self.Commanded
        local Magnitude = Commanded.Magnitude
        if Magnitude < 30 then
            return
        end
        local Root = self.Rig.Root
        local Up = self.Up
        local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
        local v1 = AssemblyLinearVelocity:Dot(Up)
        local v2 = Commanded / Magnitude
        local v3 = (AssemblyLinearVelocity - Up * v1):Dot(v2)
        if not (Magnitude * 0.75 <= v3) and not (self.LastPlanarSpeed * 0.75 <= v3) then
            local Hitbox = self.Rig.Mount.Hitbox
            local v4 = Workspace:Blockcast(
                Hitbox.CFrame + Up * 1,
                Hitbox.Size * Vector3.new(0.8999999761581421, 0.6000000238418579, 0.8999999761581421),
                v2 * (Magnitude * a2 + 2),
                self.GhostParams
            )
            if v4 ~= nil and (v4.Normal:Dot(Up)) < math.cos((math.rad((MountRaceFlags.MaxGroundAngle:Get())))) then
                return
            end
            Root.AssemblyLinearVelocity = Commanded + Up * math.min(v1, self.LastNormalSpeed)
            self.GhostUntil = a3 + 0.4
            return
        end
        return
    end
end

function u75:ClampGroundPop(a2, a3) -- Line: 552 -- types: a2: vector, a3: number
    local Root = self.Rig.Root
    local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
    local v1 = AssemblyLinearVelocity:Dot(a2)
    if a3 < v1 then
        Root.AssemblyLinearVelocity = AssemblyLinearVelocity - a2 * (v1 - a3)
    end
end

function u75:ProbeBury() -- Line: 561 -- upvalues: MountRaceFlags (val), u53 (val), Workspace (val)
    local Z, v1, v2, v3, v4
    local Hitbox = self.Rig.Mount.Hitbox
    local CFrame = Hitbox.CFrame
    local UpVector = CFrame.UpVector
    local Size = Hitbox.Size
    local v5 = Size.Y + 2
    local v6 = math.cos((math.rad((MountRaceFlags.MaxGroundAngle:Get()))))
    local v7 = nil
    local v8 = nil
    local v9 = nil
    for i, j in u53, v8, v9 do
        v4 = -Size.Y / 2
        Z = Size.Z
        v1 = CFrame:PointToWorldSpace((Vector3.new(0, v4, j * Z / 2)))
        v2 = Workspace:Raycast(v1 + UpVector * v5, -UpVector * (v5 + 3), self.Params)
        if v2 ~= nil and v6 <= v2.Normal:Dot(UpVector) then
            v3 = (v2.Position - v1):Dot(UpVector)
            if v7 == nil or v7 < v3 then
                v7 = v3
            end
        end
    end
    return v7
end

function u75:WallAhead(a2) -- Line: 582 -- upvalues: Workspace (val), MountRaceFlags (val) -- types: a2: number
    local Hitbox = self.Rig.Mount.Hitbox
    local UpVector = Hitbox.CFrame.UpVector
    local v1 = if not (0 <= self.Speed) then -1 else 1
    local v2 = Workspace:Blockcast(
        Hitbox.CFrame + UpVector * 1,
        Hitbox.Size * Vector3.new(0.8999999761581421, 0.6000000238418579, 0.8999999761581421),
        self.TravelDirection * v1 * (math.abs(self.Speed) * a2 + 2),
        self.GhostParams
    )
    local v3 = false
    if v2 ~= nil then
        v3 = (v2.Normal:Dot(UpVector)) < math.cos((math.rad((MountRaceFlags.MaxGroundAngle:Get()))))
    end
    return v3
end

function u75:EndUnstickGhost() -- Line: 595
    self.UnstickGhostUntil = 0
    self.Rig.Mount.Hitbox.CanCollide = self.HitboxCollides
end

function u75:Unstick(a2, a3, a4) -- Line: 600
    -- upvalues: MountRaceFlags (val), RunService (val)
    local Root = self.Rig.Root
    local Hitbox = self.Rig.Mount.Hitbox
    local v1 = a2 + MountRaceFlags.UnstickLift:Get()
    Root.CFrame = Root.CFrame + Hitbox.CFrame.UpVector * v1
    Root.AssemblyLinearVelocity = self.TravelDirection * self.Speed
    Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    self.LastUnstickAt = a3
    self.BuriedSeconds = 0
    self.StalledSeconds = 0
    local v2 = MountRaceFlags.UnstickGhostSeconds:Get()
    if v2 > 0 and not self:WallAhead(v2) then
        Hitbox.CanCollide = false
        self.UnstickGhostUntil = a3 + v2
    end
    if RunService:IsStudio() then
        print((("[MountRace] unstuck (%*): lifted %* studs"):format(a4, (string.format("%.2f", v1)))))
    end
end

function u75:UpdateUnstick(a2, a3, a4, a5, a6) -- Line: 620
    -- upvalues: MountRaceFlags (val)
    if 0 < self.UnstickGhostUntil and self.UnstickGhostUntil <= a3 then
        self:EndUnstickGhost()
    end
    if not a5 and MountRaceFlags.UnstickEnabled:Get() then
        local v1 = a3 - self.LastUnstickAt
        if not (v1 < MountRaceFlags.UnstickCooldownSeconds:Get()) then
            v1 = self:ProbeBury()
            if v1 == nil or not (MountRaceFlags.UnstickBuryStuds:Get() < v1) then
                self.BuriedSeconds = 0
            else
                self.BuriedSeconds = self.BuriedSeconds + a2
            end
            local AssemblyLinearVelocity = self.Rig.Root.AssemblyLinearVelocity
            local v2 = (AssemblyLinearVelocity - self.Up * (AssemblyLinearVelocity:Dot(self.Up))):Dot(self.TravelDirection)
            if not a6
                or self.Launched
                or not (a4 > 0.05)
                or not (10 < self.Speed)
                or not (v2 < MountRaceFlags.UnstickStallSpeed:Get()) then
                self.StalledSeconds = 0
            else
                self.StalledSeconds = self.StalledSeconds + a2
            end
            if v1 == nil then
                return
            end
            local BuriedSeconds = self.BuriedSeconds
            if MountRaceFlags.UnstickSeconds:Get() < BuriedSeconds then
                self:Unstick(v1, a3, "buried")
                return
            end
            local StalledSeconds = self.StalledSeconds
            if MountRaceFlags.UnstickStallSeconds:Get() < StalledSeconds and not self:WallAhead(0) then
                self:Unstick(math.max(v1, 0), a3, "stalled")
            end
            return
        end
    end
    self.BuriedSeconds = 0
    self.StalledSeconds = 0
end

function u75:Step(a2) -- Line: 668
    -- upvalues: MountRaceFlags (val), Controls (val), Workspace (val)
    local v1, v2, v3, v4, v5
    local Override = self.Override
    if Override ~= nil then
        self.Commanded = Vector3.new(0, 0, 0)
        Override(self, a2)
        return
    end
    local Root = self.Rig.Root
    local v6 = os.clock()
    local v7 = self:IsHeld()
    local v8 = MountRaceFlags.TopSpeed:Get()
    if not v7 then
        if self.Grounded or v6 < self.GhostUntil then
            self:SmoothGhostContact(a2, v6)
        end
    end
    local v9 = false
    local Up = self.Up
    if self.IgnoreGroundUntil <= v6 then
        v4, v5 = self:ProbeGround()
        v9 = v4
        Up = v5
    end
    local Grounded = self.Grounded
    self.Grounded = v9
    self.AirSeconds = if not v9 then self.AirSeconds + a2 else 0
    if self.StickMinRatio ~= nil and not v9 then
        if 0.3 < self.AirSeconds or not self:RoadBelow() then
            self.StickMinRatio = nil
        end
    end
    v5 = self.StickMinRatio ~= nil
    self.Up = self.Up:Lerp(
        if not v9 then if not v5 then Vector3.new(0, 1, 0) else self.Up else Up,
        (math.min(1, (if v9 then 14 else if not v5 then 2 else 14) * a2))
    ).Unit
    local Up_4 = self.Up
    local PopLimit = self.PopLimit
    if PopLimit >= 0 and v9 and not v7 and not v5 and not self.Launched and 0.6 <= v6 - self.LastJumpAt then
        self:ClampGroundPop(Up, PopLimit)
    end
    local Heading = self.Heading
    local v10 = Heading - Up_4 * Heading:Dot(Up_4)
    local Unit = if not (0.001 < v10.Magnitude) then nil else v10.Unit
    if not Unit then
        local LookVector = Root.CFrame.LookVector
        v1 = LookVector - Up_4 * LookVector:Dot(Up_4)
        Unit = (if not (0.001 < v1.Magnitude) then nil else v1.Unit) or self.TravelDirection
    end
    if v7 then
        local LookVector_2 = Root.CFrame.LookVector
        v2 = LookVector_2 - Up_4 * LookVector_2:Dot(Up_4)
        Unit = (if not (0.001 < v2.Magnitude) then nil else v2.Unit) or Unit
        self.TravelDirection = Unit
    end
    if v9 and not Grounded then
        local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
        v1 = AssemblyLinearVelocity - Up_4 * AssemblyLinearVelocity:Dot(Up_4)
        if 1 < v1.Magnitude and self.GhostUntil <= v6 then
            self.Speed = v1:Dot(Unit)
            local Unit_3 = v1.Unit
            self.TravelDirection = Unit_3 * (if not (0 <= self.Speed) then -1 else 1)
        end
        self.Launched = false
        self.Landed:Fire()
    end
    local v11 = -(if not v7 then Controls:GetMoveVector() else Vector3.new(0, 0, 0)).Z
    local X = v4.X
    if self.Touch and not v7 then
        X = math.clamp(X * MountRaceFlags.TouchSteerGain:Get(), -1, 1)
        if MountRaceFlags.TouchAutoThrottle:Get() and v11 > -0.5 then
            v11 = 1
        end
    end
    v4 = if not v5 then 0 else if not v9 then 0 else if v7 then 0 else self:ProbeLoopEdge(Unit)
    if v4 ~= 0 and X * v4 < 0 then
        X = 0
    end
    v2 = math.clamp(math.abs(self.Speed) / v8, 0, 1)
    local v12 = (math.max(math.clamp(math.abs(self.Speed) / 10, 0, 1), 0.35)) * ((MountRaceFlags.HighSpeedSteerScale:Get() - 1) * v2 + 1)
    if self.Handbrake then
        v12 = v12 * MountRaceFlags.HandbrakeSteerScale:Get()
    end
    if not v9 then
        v12 = v12 * 0.3
    end
    if v5 then
        v12 = v12 * 0.35
    end
    v2 = if not (self.Speed < -1) then 1 else if not (v11 < -0.05) then 1 else -1
    local v13 = -X * math.rad((MountRaceFlags.SteerDegreesPerSecond:Get())) * v12 * v2 * a2 - v4 * 1.2217304763960306 * a2
    if self.Touch and v9 and not v5 and not v7 and (math.abs(X)) < 0.05 and 10 < self.Speed then
        v13 = v13 + self:AssistYaw(Unit, Up_4, a2)
    end
    local Heading_2 = (CFrame.fromAxisAngle(Up_4, v13)):VectorToWorldSpace(Unit)
    self.Heading = Heading_2
    if v7 then
        self.Speed = 0
    elseif v9 then
        v13 = v8 * self:TopSpeedScale()
        v12 = v8 / MountRaceFlags.AccelSeconds:Get()
        if v13 < self.Speed then
            self.Speed = math.max(v13, self.Speed - v12 * a2)
        elseif v11 > 0.05 then
            self.Speed = math.min(v13, self.Speed + v12 * v11 * a2)
        elseif not (v11 < -0.05) then
            local Speed_7 = self.Speed
            v3 = v8 / MountRaceFlags.CoastSeconds:Get() * a2
            self.Speed = if not (Speed_7 < 0) then math.max(Speed_7 - v3, 0) else math.min(Speed_7 + v3, 0)
        elseif not (0 < self.Speed) then
            self.Speed = math.max(-MountRaceFlags.ReverseSpeed:Get(), self.Speed + v12 * v11 * a2)
        else
            self.Speed = math.max(0, self.Speed + v8 / (MountRaceFlags.BrakeSeconds:Get()) * v11 * a2)
        end
        if self.Handbrake then
            self.Speed = self.Speed - self.Speed * MountRaceFlags.HandbrakeSpeedBleed:Get() * a2
        end
        local StickMinRatio = self.StickMinRatio
        if StickMinRatio ~= nil then
            self.Speed = math.max(self.Speed, v8 * StickMinRatio)
        end
    end
    v2 = 12 * (if not self.Handbrake then 1 else MountRaceFlags.HandbrakeGrip:Get())
    local TravelDirection = self.TravelDirection
    v8 = TravelDirection - Up_4 * TravelDirection:Dot(Up_4)
    v3 = ((if not (0.001 < v8.Magnitude) then nil else v8.Unit) or Heading_2):Lerp(Heading_2, (math.min(1, v2 * a2)))
    local v14 = v3 - Up_4 * v3:Dot(Up_4)
    self.TravelDirection = (if not (0.001 < v14.Magnitude) then nil else v14.Unit) or Heading_2
    self:UpdateUnstick(a2, v6, v11, v7 or v5 or v6 < self.IgnoreGroundUntil, v9 or self.AirSeconds < 0.3)
    v2 = v6 < self.UnstickGhostUntil
    if v9 and not v7 then
        self:CheckWall(Heading_2, a2)
        Heading_2 = self.Heading
    end
    v1 = Heading_2:Cross(Up_4)
    self.Drive.Enabled = v9 or v7 or v2 or v6 < self.GhostUntil
    self.Drive.PrimaryTangentAxis = Heading_2
    self.Drive.SecondaryTangentAxis = v1
    v11 = self.TravelDirection * self.Speed + v1 * v4 * 18
    self.Drive.PlaneVelocity = Vector2.new(v11:Dot(Heading_2), v11:Dot(v1))
    local AssemblyMass = Root.AssemblyMass
    local Gravity = Workspace.Gravity
    if v5 then
        self.Push.Force = Vector3.new(0, 1, 0) * AssemblyMass * Gravity - Up_4 * AssemblyMass * Gravity * 1.6
    elseif v2 then
        self.Push.Force = Vector3.new(0, 1, 0) * AssemblyMass * Gravity
    elseif not v9 then
        self.Push.Force = Vector3.new(0, 0, 0)
    else
        self.Push.Force = -Up_4 * AssemblyMass * Gravity * 0.4
    end
    self.Align.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), Heading_2, Up_4)
    self.Commanded = if not self.Drive.Enabled then Vector3.new(0, 0, 0) else if v7 then Vector3.new(0, 0, 0) else v11
    local AssemblyLinearVelocity_2 = Root.AssemblyLinearVelocity
    self.LastNormalSpeed = AssemblyLinearVelocity_2:Dot(Up_4)
    self.LastPlanarSpeed = (AssemblyLinearVelocity_2 - Up_4 * self.LastNormalSpeed).Magnitude
end

return u75