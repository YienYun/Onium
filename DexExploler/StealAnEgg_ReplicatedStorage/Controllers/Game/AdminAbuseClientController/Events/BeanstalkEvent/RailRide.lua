-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.RailRide
-- Decompile time: 11.25 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Data.BeanstalkEvent)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
require(ReplicatedStorage.Packages.Trove)
local u27 = CameraShaker.new()

local function buildObstacles(a1) -- Line: 83 -- types: a1: table
    local BoundingBox, BoundingBox_2
    local v1 = {}
    for i, j in a1 do
        BoundingBox, BoundingBox_2 = j:GetBoundingBox()
        table.insert(v1, {
            Hit = false,
            Model = j,
            Box = BoundingBox,
            HalfSize = BoundingBox_2 * 0.5 + Vector3.new(1.5, 1.5, 1.5),
        })
    end
    return v1
end

local function touches(a1, a2) -- Line: 97 -- types: a1: table, a2: vector
    local v1 = a1.Box:PointToObjectSpace(a2)
    local HalfSize = a1.HalfSize
    local v2 = false
    if (math.abs(v1.X)) <= HalfSize.X then
        v2 = false
        if (math.abs(v1.Y)) <= HalfSize.Y then
            v2 = (math.abs(v1.Z)) <= HalfSize.Z
        end
    end
    return v2
end

local u30 = {}

function u30.Shake(a1) -- Line: 109 -- upvalues: u27 (val) -- types: a1: number
    u27:ShakeOnce(a1, 12, 0, 0.6)
end

function u30.Run(a1, a2) -- Line: 114
    -- upvalues: Workspace (val), buildObstacles (val), CameraShakerDriver (val), u27 (val), u30 (val)
    local v1 = a1:Extend()
    local Rig = a2.Rig
    local CurrentCamera = Workspace.CurrentCamera
    local u10 = buildObstacles(a2.Obstacles)
    local u11 = false
    Rig.Humanoid.PlatformStand = true
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    local FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.FieldOfView = a2.FieldOfView or FieldOfView
    CameraShakerDriver.Start(u27, Enum.RenderPriority.Camera.Value + 2)
    v1:Add(function() -- Line: 126
        -- upvalues: u11 (ref), Rig (val), CameraShakerDriver (upval), u27 (upval), a2 (val), CurrentCamera (val)
        -- upvalues: FieldOfView (val)
        u11 = true
        Rig.Humanoid.PlatformStand = false
        Rig.Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        Rig.Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        CameraShakerDriver.Stop(u27)
        if a2.KeepCamera then
            return
        end
        CurrentCamera.FieldOfView = FieldOfView
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.CameraSubject = Rig.Humanoid
    end)
    local CFrame = Rig.Root.CFrame
    local u32 = os.clock()
    local u35 = a2.Length / a2.Seconds
    local u37 = a2.StartDistance or 0
    local u39 = a2.BlendSeconds or 1
    local u40 = 0
    local u41 = (-1 / 0)
    local u43 = a2.SteerSpeed or 30
    local LaneSpacing = a2.LaneSpacing
    local u52 = if not LaneSpacing then 0 else math.max(math.floor(a2.Lateral / LaneSpacing), 0)
    local u53 = 0
    local u54 = false

    local function bump(a1, a2_2, a3) -- Line: 156
        -- upvalues: u41 (ref), u40 (ref), a2 (val), u30 (upval)
        os.clock()
        math.clamp(u40 + (if not (0 <= (a1.RightVector:Dot(a2_2.Position - a3))) then -1 else 1) * 6, -a2.Lateral, a2.Lateral)
        u30.Shake(4)
    end

    v1:BindToRenderStep("BeanstalkRailRide", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 170
        -- upvalues: u37 (ref), a2 (val), u35 (val), u41 (ref), u53 (ref), u40 (ref), LaneSpacing (val)
        -- upvalues: CurrentCamera (val), Rig (val), u54 (ref), u52 (val), u43 (val), u32 (val), u39 (val), CFrame (val)
        -- upvalues: u10 (val), u30 (upval), u11 (ref)
        local HalfSize, Position_2, Position_3, v1, v2, v3, v4
        local v5 = u37 / a2.Length
        local v6 = u35 * (if not a2.SpeedScale then 1 else a2.SpeedScale(v5))
        local v7 = os.clock() - u41
        if v7 < a2.BumpSeconds then
            v2 = a2.BumpSpeedScale or 0.2
            v6 = v6 * (v2 + (1 - v2) * v7 / a2.BumpSeconds)
        end
        u37 = math.min(u37 + v6 * a1, a2.Length)
        v7 = a2.Path(u37)
        if not a2.SteerLocked then
            if not LaneSpacing then
                v2 = CurrentCamera.CFrame.RightVector * Vector3.new(1, 0, 1)
                v3 = if not (0.01 < v2.Magnitude) then 0 else Rig.Humanoid.MoveDirection:Dot(v2.Unit)
                u40 = math.clamp(u40 + v3 * u43 * a1, -a2.Lateral, a2.Lateral)
            else
                v2 = CurrentCamera.CFrame.RightVector * Vector3.new(1, 0, 1)
                v3 = if not (0.01 < v2.Magnitude) then 0 else Rig.Humanoid.MoveDirection:Dot(v2.Unit)
                if u54 then
                    if u54 and (math.abs(v3)) <= 0.25 then
                        u54 = false
                    end
                elseif 0.5 <= (math.abs(v3)) then
                    u54 = true
                    u53 = math.clamp(u53 + (if not (v3 > 0) then -1 else 1), -u52, u52)
                elseif u54 and (math.abs(v3)) <= 0.25 then
                    u54 = false
                end
                u40 = u40 + (u53 * LaneSpacing - u40) * math.min(a1 * 14, 1)
            end
        elseif a2.SteerLocked(v5) then
            u53 = 0
            u40 = u40 - u40 * math.min(a1 * 3, 1)
        elseif not LaneSpacing then
            v2 = CurrentCamera.CFrame.RightVector * Vector3.new(1, 0, 1)
            v3 = if not (0.01 < v2.Magnitude) then 0 else Rig.Humanoid.MoveDirection:Dot(v2.Unit)
            u40 = math.clamp(u40 + v3 * u43 * a1, -a2.Lateral, a2.Lateral)
        else
            v2 = CurrentCamera.CFrame.RightVector * Vector3.new(1, 0, 1)
            v3 = if not (0.01 < v2.Magnitude) then 0 else Rig.Humanoid.MoveDirection:Dot(v2.Unit)
            if u54 then
                if u54 and (math.abs(v3)) <= 0.25 then
                    u54 = false
                end
            elseif 0.5 <= (math.abs(v3)) then
                u54 = true
                u53 = math.clamp(u53 + (if not (v3 > 0) then -1 else 1), -u52, u52)
            elseif u54 and (math.abs(v3)) <= 0.25 then
                u54 = false
            end
            u40 = u40 + (u53 * LaneSpacing - u40) * math.min(a1 * 14, 1)
        end
        v5 = v7 + v7.RightVector * u40
        if a2.Lift then
            v5 = v5 + Vector3.new(0, 1, 0) * a2.Lift(u40)
        end
        v2 = (os.clock() - u32) / u39
        if v2 < 1 then
            v5 = CFrame:Lerp(v5, v2 * v2 * (3 - 2 * v2))
        end
        Rig.Root.CFrame = if not a2.Mount then v5 else a2.Mount(v5)
        Rig.Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        Rig.Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        CurrentCamera.CFrame = a2.Camera(v7, v5)
        v2 = v6 / u35
        local FieldOfView = a2.FieldOfView
        if FieldOfView ~= nil then
            v4 = CurrentCamera
            v4.FieldOfView = v4.FieldOfView + ((math.clamp(FieldOfView + (v2 - 1) * (a2.FieldOfViewPerSpeed or 0), 40, 110)) - CurrentCamera.FieldOfView) * math.min(a1 * 6, 1)
        end
        v4 = nil
        local v8 = nil
        for i, j in u10, v4, v8 do
            if not j.Hit then
                Position_2 = v5.Position
                v6 = j.Box:PointToObjectSpace(Position_2)
                HalfSize = j.HalfSize
                v1 = false
                if (math.abs(v6.X)) <= HalfSize.X then
                    v1 = false
                    if (math.abs(v6.Y)) <= HalfSize.Y then
                        v1 = (math.abs(v6.Z)) <= HalfSize.Z
                    end
                end
                if v1 then
                    j.Hit = true
                    if not (os.clock() - u41 < (a2.HitCooldownSeconds or 0)) then
                        if not a2.CanHit or a2.CanHit() then
                            Position_3 = j.Box.Position
                            os.clock()
                            u40 = math.clamp(
                                u40 + (if not (0 <= (v7.RightVector:Dot(v5.Position - Position_3))) then -1 else 1) * 6,
                                -a2.Lateral,
                                a2.Lateral
                            )
                            u30.Shake(4)
                            if a2.OnHit then
                                a2.OnHit(j.Model)
                            end
                        end
                    end
                end
            end
        end
        local Probe = a2.Probe
        if Probe then
            v4 = Probe(u37, v5)
            if v4 then
                os.clock()
                math.clamp(u40 + (if not (0 <= (v7.RightVector:Dot(v5.Position - v4))) then -1 else 1) * 6, -a2.Lateral, a2.Lateral)
                u30.Shake(4)
            end
        end
        if a2.OnStep then
            a2.OnStep(u37, v5, v2)
        end
        if a2.Length <= u37 or a2.Stop ~= nil and a2.Stop() then
            u11 = true
        end
    end)
    while not u11 do
        task.wait()
    end
    v1:Clean()
end

return u30