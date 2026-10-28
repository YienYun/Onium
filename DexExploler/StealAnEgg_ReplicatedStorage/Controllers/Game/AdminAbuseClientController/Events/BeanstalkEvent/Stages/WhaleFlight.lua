-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Stages.WhaleFlight
-- Decompile time: 39.08 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local BeanstalkEventFlags = require(ReplicatedStorage.Shared.Flags.BeanstalkEventFlags)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Juice = require(script.Parent.Parent.Parent.ScrambleBoss.Juice)
local RailRide = require(script.Parent.Parent.RailRide)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local RockFall = require(script.Parent.Parent.RockFall)
local SpeedLines = require(script.Parent.Parent.SpeedLines)
require(ReplicatedStorage.Packages.Trove)
local UISystem = require(script.Parent.Parent.UISystem)
local WhaleHearts = require(script.Parent.Parent.WhaleHearts)
local LocalPlayer = Players.LocalPlayer
local BeanstalkEventAssets = ReplicatedStorage.Assets.BeanstalkEventAssets
local BeanstalkEvent_2 = ReplicatedStorage.Assets.Sounds.BeanstalkEvent
local MoonWhale = BeanstalkEventAssets.Stage3.MoonWhale
local Stage = BeanstalkEvent.Stage
local u104 = Color3.fromRGB(255, 60, 80)
local u106 = Random.new()

local function stage() -- Line: 145 -- upvalues: LocalPlayer (val), BeanstalkEvent (val)
    local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return nil
end

local function waitUntilOver(a1, a2) -- Line: 150 -- upvalues: BeanstalkEvent (val) -- types: a1: userdata, a2: userdata
    while not BeanstalkEvent.IsOverFloor(a2, a1.Position, 60) do
        task.wait(0.2)
    end
end

local function nestApproach(a1, a2) -- Line: 156 -- types: a1: userdata, a2: vector
    local v1 = a1.Size * 0.5
    local v2 = a1.CFrame:PointToObjectSpace(a2)
    local v3 = a1.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v2.X, -v1.X, v1.X), v1.Y, (math.clamp(v2.Z, -v1.Z, v1.Z)))))
    v2 = (a2 - v3) * Vector3.new(1, 0, 1)
    return v3 + (if not (0.1 < v2.Magnitude) then Vector3.new(1, 0, 0) else v2.Unit) * 60 + Vector3.new(0, 14, 0)
end

local function buildRoute(a1, a2, a3, a4, a5) -- Line: 171
    -- upvalues: 
    local v1, v2
    local v3 = (a2 - a1) * Vector3.new(1, 0, 1)
    local Unit_2 = if not (0.01 < v3.Magnitude) then Vector3.new(0, 0, 1) else v3.Unit
    local u18 = Vector3.new(a3.X, 0, a3.Z)
    local v4 = (a1 - u18) * Vector3.new(1, 0, 1)
    local u26 = math.max(v4.Magnitude, 120)
    local Unit = if not (0.01 < v4.Magnitude) then -Unit_2 else v4.Unit
    local u38 = Vector3.new(0, 1, 0):Cross(Unit)
    local u44 = a2.Y - a1.Y
    local u48 = 6.283185307179586 * a4

    local function reach(a1) -- Line: 188 -- upvalues: u26 (val), a5 (val) -- types: a1: number
        return u26 * (a5 * math.sin(3.141592653589793 * a1) + 1)
    end

    local function circle(a1) -- Line: 192
        -- upvalues: u48 (val), u18 (val), Unit (val), u38 (val), u26 (val), a5 (val)
        local v1 = u48 * a1
        return u18 + (Unit * math.cos(v1) + u38 * math.sin(v1)) * (u26 * (a5 * math.sin(3.141592653589793 * a1) + 1))
    end

    local v5 = u48 * 1
    local v6 = (a2 - (u18 + (Unit * math.cos(v5) + u38 * math.sin(v5)) * (u26 * (a5 * 1.2246467991473532e-16 + 1)))) * Vector3.new(1, 0, 1)
    local v7 = u48 * 0
    local u91 = v6 - (a1 - (u18 + (Unit * math.cos(v7) + u38 * math.sin(v7)) * (u26 * (a5 * 0 + 1)))) * Vector3.new(1, 0, 1)
    v5 = u48 * 0
    local u109 = (a1 - (u18 + (Unit * math.cos(v5) + u38 * math.sin(v5)) * (u26 * (a5 * 0 + 1)))) * Vector3.new(1, 0, 1)

    local function point(a1_2) -- Line: 201
        -- upvalues: u48 (val), u18 (val), Unit (val), u38 (val), u26 (val), a5 (val), u109 (val), u91 (val), a1 (val)
        -- upvalues: u44 (val)
        local v1 = u48 * a1_2
        return u18 + (Unit * math.cos(v1) + u38 * math.sin(v1)) * (u26 * (a5 * math.sin(3.141592653589793 * a1_2) + 1)) + u109 + u91 * a1_2 + Vector3.new(0, 1, 0) * (a1.Y + u44 * a1_2)
    end

    local function velocity(a1) -- Line: 205
        -- upvalues: u48 (val), Unit (val), u38 (val), u26 (val), a5 (val), u91 (val), u44 (val)
        local v1 = u48 * a1
        return (-Unit * math.sin(v1) + u38 * math.cos(v1)) * (u26 * (a5 * math.sin(3.141592653589793 * a1) + 1) * u48) + (Unit * math.cos(v1) + u38 * math.sin(v1)) * (u26 * a5 * 3.141592653589793 * math.cos(3.141592653589793 * a1)) + u91 + Vector3.new(0, 1, 0) * u44
    end

    local u112 = {0}
    local v8 = u48 * 0
    v7 = u18 + (Unit * math.cos(v8) + u38 * math.sin(v8)) * (u26 * (a5 * 0 + 1)) + u109 + u91 * 0 + Vector3.new(0, 1, 0) * (a1.Y + u44 * 0)
    for i = 1, 480 do
        v1 = i / 480
        v2 = u48 * v1
        v8 = u18 + (Unit * math.cos(v2) + u38 * math.sin(v2)) * (u26 * (a5 * math.sin(3.141592653589793 * v1) + 1)) + u109 + u91 * v1 + Vector3.new(0, 1, 0) * (a1.Y + u44 * v1)
        u112[i + 1] = u112[i] + (v8 - v7).Magnitude
    end
    local u197 = u112[481]

    local function timeAt(a1) -- Line: 222 -- upvalues: u197 (val), u112 (val) -- types: a1: number
        local v1
        local v2 = math.clamp(a1, 0, u197)
        local v3 = 1
        local v4 = 481
        while 1 < v4 - v3 do
            v1 = (v3 + v4) // 2
            if not (u112[v1] <= v2) then
                v4 = v1
            else
                v3 = v1
            end
        end
        v1 = u112[v4] - u112[v3]
        v4 = if not (v1 > 0) then 0 else (v2 - u112[v3]) / v1
        return (v3 - 1 + v4) / 480
    end

    return {
        Length = u197,
        Facing = Unit_2,
        Path = function(a1_2) -- Line: 239
            -- upvalues: timeAt (val), u48 (val), u18 (val), Unit (val), u38 (val), u26 (val), a5 (val), u109 (val)
            -- upvalues: u91 (val), a1 (val), u44 (val), velocity (val)
            local v1 = timeAt(a1_2)
            local v2 = u48 * v1
            local v3 = u18 + (Unit * math.cos(v2) + u38 * math.sin(v2)) * (u26 * (a5 * math.sin(3.141592653589793 * v1) + 1)) + u109 + u91 * v1 + Vector3.new(0, 1, 0) * (a1.Y + u44 * v1)
            return CFrame.lookAt(v3, v3 + velocity(v1).Unit, (Vector3.new(0, 1, 0)))
        end,
        Curve = function(a1_2) -- Line: 245
            -- upvalues: timeAt (val), u48 (val), u18 (val), Unit (val), u38 (val), u26 (val), a5 (val), u109 (val)
            -- upvalues: u91 (val), a1 (val), u44 (val), velocity (val)
            local v1 = timeAt(a1_2 - 6)
            local v2 = u48 * v1
            local v3 = u18 + (Unit * math.cos(v2) + u38 * math.sin(v2)) * (u26 * (a5 * math.sin(3.141592653589793 * v1) + 1)) + u109 + u91 * v1 + Vector3.new(0, 1, 0) * (a1.Y + u44 * v1)
            local LookVector = (CFrame.lookAt(v3, v3 + velocity(v1).Unit, (Vector3.new(0, 1, 0)))).LookVector
            v3 = timeAt(a1_2 + 6)
            local v4 = u48 * v3
            local v5 = u18 + (Unit * math.cos(v4) + u38 * math.sin(v4)) * (u26 * (a5 * math.sin(3.141592653589793 * v3) + 1)) + u109 + u91 * v3 + Vector3.new(0, 1, 0) * (a1.Y + u44 * v3)
            v3 = (CFrame.lookAt(v5, v5 + velocity(v3).Unit, (Vector3.new(0, 1, 0)))).LookVector - LookVector
            local v6 = timeAt(a1_2)
            local v7 = u48 * v6
            v2 = u18 + (Unit * math.cos(v7) + u38 * math.sin(v7)) * (u26 * (a5 * math.sin(3.141592653589793 * v6) + 1)) + u109 + u91 * v6 + Vector3.new(0, 1, 0) * (a1.Y + u44 * v6)
            return v3:Dot((CFrame.lookAt(v2, v2 + velocity(v6).Unit, (Vector3.new(0, 1, 0)))).RightVector) / 12
        end,
    }
end

local function playWhaleAnimation(a1) -- Line: 254 -- types: a1: userdata
    local v1 = (a1:FindFirstChildOfClass("AnimationController"):FindFirstChildOfClass("Animator")):LoadAnimation((a1:FindFirstChildOfClass("Animation")))
    v1.Looped = true
    v1:Play()
end

local function spring(a1, a2, a3, a4, a5) -- Line: 263
    -- upvalues: 
    local v1
    local v2 = math.min(a5, 0.1)
    local v3, v4 = a1, a2
    while v2 > 0 do
        v1 = math.min(v2, 0.008333333333333333)
        v4 = v4 + ((a3 - v3) * (a4 * a4) - v4 * (a4 * 1.8)) * v1
        v3 = v3 + v4 * v1
        v2 = v2 - v1
    end
    return v3, v4
end

local function partsOf(a1) -- Line: 282 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function punchFieldOfView(a1) -- Line: 292 -- upvalues: Workspace (val) -- types: a1: number
    local CurrentCamera = Workspace.CurrentCamera
    CurrentCamera.FieldOfView = math.max(CurrentCamera.FieldOfView - a1, 40)
end

return {
    Run = function(a1, a2, a3, a4) -- Line: 301
        -- upvalues: UISystem (val), BeanstalkEventFlags (val), WhaleHearts (val), waitUntilOver (val)
        -- upvalues: nestApproach (val), buildRoute (val), Workspace (val), MoonWhale (val), TweenService (val)
        -- upvalues: RockFall (val), SpeedLines (val), SoundService (val), BeanstalkEvent_2 (val), RailRide (val)
        -- upvalues: Flash (val), u104 (val), spring (val), Juice (val), partsOf (val), Lighting (val), u106 (val)
        -- upvalues: LocalPlayer (val), BeanstalkEvent (val), Stage (val), Remotes (val)
        local v1, v2
        local Stage3 = a2.Sections.Stage3
        UISystem.SetFlightProgress(0)
        local v3 = BeanstalkEventFlags.FlightHearts:Get()
        WhaleHearts.Show(a1, v3)
        waitUntilOver(a3.Root, Stage3.Floor)
        local u27 = Stage3.FlyingSectionStart.Position + Vector3.new(0, 3, 0)
        local u53 = buildRoute(
            u27,
            nestApproach(a2.Sections.Stage4.Floor, Stage3.FlyingSectionEnd.Position),
            a2.Beanstalk:GetPivot().Position,
            BeanstalkEventFlags.FlightSpiralTurns:Get(),
            BeanstalkEventFlags.FlightSpiralBulge:Get()
        )
        local Length = u53.Length
        local Facing = u53.Facing
        local Path = u53.Path
        local u61 = BeanstalkEventFlags.RideLateralStuds:Get()
        local u66 = BeanstalkEventFlags.FlightRockSpacingStuds:Get()
        local u71 = BeanstalkEventFlags.FlightRockFallStuds:Get()
        local u72 = v3
        local u78 = Length / BeanstalkEventFlags.FlightSeconds:Get()

        local function turnBefore(a1) -- Line: 330 -- upvalues: u53 (val) -- types: a1: number
            for i = a1 - 110, a1, 15 do
                if 0.012 < (math.abs((u53.Curve(i)))) then
                    return true
                end
            end
            return false
        end

        local function attempt(a1) -- Line: 339
            -- upvalues: Workspace (upval), a3 (val), MoonWhale (upval), Stage3 (val), u27 (val), Path (val)
            -- upvalues: Facing (val), TweenService (upval), RockFall (upval), u61 (val), SpeedLines (upval)
            -- upvalues: Length (val), u72 (ref), SoundService (upval), BeanstalkEvent_2 (upval), RailRide (upval)
            -- upvalues: Flash (upval), u104 (upval), WhaleHearts (upval), BeanstalkEventFlags (upval), spring (upval)
            -- upvalues: u53 (val), u71 (val), u78 (val), turnBefore (val), u66 (val), UISystem (upval), a2 (val)
            -- upvalues: Juice (upval), partsOf (upval), Lighting (upval), u106 (upval)
            local G, G_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
            local v15 = a1:Add((Instance.new("Folder")))
            a1:Add(function() -- Line: 341 -- upvalues: Workspace (upval), a3 (upval)
                local CurrentCamera = Workspace.CurrentCamera
                CurrentCamera.FieldOfView = 70
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.CameraSubject = a3.Humanoid
            end)
            v15.Name = "BeanstalkWhaleFlight"
            v15.Parent = Workspace
            local u16 = a1:Clone(MoonWhale)
            local PlayerSitPosition = u16:FindFirstChild("PlayerSitPosition", true)
            local Pivot = u16:GetPivot()
            local u31 = (Pivot.Rotation + PlayerSitPosition.WorldPosition):Inverse() * Pivot

            local function poseWhale(a1) -- Line: 356 -- upvalues: u16 (val), u31 (val) -- types: a1: userdata
                u16:PivotTo(a1 * CFrame.new(0, -2.5, 0) * u31)
            end

            local function seated(a1) -- Line: 360 -- upvalues: PlayerSitPosition (val) -- types: a1: userdata
                return a1.Rotation + PlayerSitPosition.WorldPosition + a1.UpVector * 2.5
            end

            local v16 = Vector3.new(u27.X, Stage3.Floor.Position.Y + Stage3.Floor.Size.Y * 0.5 + 45, u27.Z)
            local v17 = Path(0).LookVector * Vector3.new(1, 0, 1)
            v17 = CFrame.lookAt(v16, v16 + (if not (0.01 < v17.Magnitude) then Facing else v17.Unit))
            u16:PivotTo(v17 * (CFrame.new(0, -2.5, 0)) * u31)
            local Pivot_2 = u16:GetPivot()
            u16:ScaleTo(0.01)
            u16.Parent = v15
            local v18 = (u16:FindFirstChildOfClass("AnimationController"):FindFirstChildOfClass("Animator")):LoadAnimation((u16:FindFirstChildOfClass("Animation")))
            v18.Looped = true
            v18:Play()
            local v19 = os.clock()
            while true do
                v18 = math.min((os.clock() - v19) / 2, 1)
                v1 = (1 - TweenService:GetValue(v18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)) * 2 * 2 * 3.141592653589793
                u16:ScaleTo((math.max(TweenService:GetValue(v18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 0.01)))
                u16:PivotTo((CFrame.new(Pivot_2.Position)) * CFrame.Angles(0, v1, 0) * Pivot_2.Rotation)
                if v18 >= 1 then
                    break
                end
                task.wait()
            end
            a3.Humanoid.PlatformStand = true
            a1:Add(function() -- Line: 400 -- upvalues: a3 (upval)
                a3.Humanoid.PlatformStand = false
            end)
            local CFrame_2 = a3.Root.CFrame
            local v20 = (os.clock())
            while true do
                v18 = math.min((os.clock() - v20) / 1, 1)
                a3.Root.CFrame = CFrame_2:Lerp(v17.Rotation + PlayerSitPosition.WorldPosition + v17.UpVector * 2.5, v18 * v18 * (3 - v18 * 2))
                a3.Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                if v18 >= 1 then
                    break
                end
                task.wait()
            end
            local u219 = a1:Add((Instance.new("Highlight")))
            u219.Name = "HitFlash"
            u219.FillColor = Color3.new(1, 1, 1)
            u219.FillTransparency = 1
            u219.OutlineTransparency = 1
            u219.DepthMode = Enum.HighlightDepthMode.Occluded
            u219.Adornee = u16
            u219.Parent = u16
            for i, j in u16:GetDescendants() do
                if j:IsA("BasePart") then
                    G = j.Color.G
                    if j.Color.R < G then
                        G_2 = j.Color.G
                        if j.Color.B < G_2 then
                            j.LocalTransparencyModifier = 0.6
                        end
                    end
                end
            end
            local u251 = RockFall.new(a1, v15, Path, u61)
            v17 = a1:Extend()
            local u256 = 1
            SpeedLines.Run(v17, function() -- Line: 437 -- upvalues: u256 (ref)
                return (u256 - 0.4) / 1.4
            end)
            local u262 = 0
            local u263 = 0
            local u264 = 0
            local u266 = os.clock()
            local u267 = (-1 / 0)
            local u269 = Length * 0.06
            local u270 = false
            local u273 = Path(0)
            local u274 = false
            local u276 = os.clock()
            local u277 = Vector3.new(0, 0, 0)
            local u278 = Vector3.new(0, 0, 0)
            local u279 = Vector3.new(0, 0, 1)
            local u280 = Vector3.new(0, 0, 0)
            local u281 = Vector3.new(0, 1, 0)
            local u282 = Vector3.new(0, 0, 0)

            local function flinch() -- Line: 455 -- upvalues: u267 (ref)
                local v1 = os.clock() - u267
                if v1 >= 0.7 then
                    return 0
                end
                local v2 = 1 - v1 / 0.7
                return math.sin(v1 / 0.7 * 2.5 * 2 * 3.141592653589793) * 0.4537856055185257 * v2 * v2
            end

            local function swimAway(a1, a2, a3) -- Line: 467
                -- upvalues: u264 (ref), Path (upval), u263 (ref), u262 (ref), u16 (val), u31 (val)
                -- upvalues: TweenService (upval)
                local v1 = math.min(a3 / 1.1, 1)
                local v2 = u264 + a2 * a3
                local v3 = (Path(v2)) + Path(v2).RightVector * u263
                v2 = math.sin(v1 * 3.141592653589793 * 3) * 0.6981317007977318 * (1 - v1)
                u16:PivotTo(v3 * CFrame.Angles(0, 0, u262 + v2) * CFrame.new(0, -2.5, 0) * u31)
                local Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                for i, j in a1 do
                    j.LocalTransparencyModifier = Value
                end
            end

            local function onRockHit(a1) -- Line: 480
                -- upvalues: u267 (ref), u72 (upval), RockFall (upval), u251 (val), SoundService (upval)
                -- upvalues: BeanstalkEvent_2 (upval), RailRide (upval), Workspace (upval), Flash (upval), u104 (upval)
                -- upvalues: u219 (val), WhaleHearts (upval), u270 (ref)
                os.clock()
                u72 = u72 - 1
                RockFall.Shatter(u251, a1)
                SoundService:PlayLocalSound(BeanstalkEvent_2.WhaleRockHit)
                RailRide.Shake(9)
                local CurrentCamera = Workspace.CurrentCamera
                CurrentCamera.FieldOfView = math.max(CurrentCamera.FieldOfView - 12, 40)
                Flash.Play({
                    Attack = 0.02,
                    Decay = 0.4,
                    Tint = u104,
                    Opacity = if not (u72 <= 0) then 0.4 else 0.6,
                })
                u219.FillTransparency = 0
                local v1 = u72
                WhaleHearts.Lose((math.max(v1, 0)))
                if u72 <= 0 then
                    u270 = true
                end
            end

            local Run_2 = RailRide.Run
            local v21 = {
                SteerSpeed = 62,
                KeepCamera = true,
                BlendSeconds = 2.5,
                FieldOfView = 80,
                FieldOfViewPerSpeed = 20,
                Rig = a3,
                Path = Path,
                Length = Length,
                Seconds = BeanstalkEventFlags.FlightSeconds:Get(),
                Lateral = u61,
                BumpSeconds = BeanstalkEventFlags.BumpSlowdownSeconds:Get(),
                Obstacles = {},
                Mount = function(a1) -- Line: 512
                    -- upvalues: u262 (ref), u267 (ref), u16 (val), u31 (val), PlayerSitPosition (val)
                    local v1
                    local Angles = CFrame.Angles
                    local v2 = u262
                    local v3 = os.clock() - u267
                    if not (v3 >= 0.7) then
                        local v4 = 1 - v3 / 0.7
                        v1 = math.sin(v3 / 0.7 * 2.5 * 2 * 3.141592653589793) * 0.4537856055185257 * v4 * v4
                    else
                        v1 = 0
                    end
                    local v5 = a1 * Angles(0, 0, v2 + v1)
                    u16:PivotTo(v5 * CFrame.new(0, -2.5, 0) * u31)
                    return v5.Rotation + PlayerSitPosition.WorldPosition + v5.UpVector * 2.5
                end,
                Camera = function(a1, a2) -- Line: 518
                    -- upvalues: u276 (ref), u274 (ref), Workspace (upval), u277 (ref), u279 (ref), u281 (ref)
                    -- upvalues: u278 (ref), spring (upval), u280 (ref), u282 (ref)
                    local v1 = os.clock()
                    local v2 = v1 - u276
                    u276 = v1
                    if not u274 then
                        u274 = true
                        local CFrame_2 = Workspace.CurrentCamera.CFrame
                        u277 = a2.Position
                        u279 = CFrame_2.LookVector
                        u281 = CFrame_2.UpVector
                    end
                    local v3, v4 = spring(u277, u278, a2.Position, 10, v2)
                    u277 = v3
                    u278 = v4
                    v3, v4 = spring(u279, u280, a1.LookVector, 4.5, v2)
                    u279 = v3
                    u280 = v4
                    v3, v4 = spring(u281, u282, a1.UpVector, 4.5, v2)
                    u281 = v3
                    u282 = v4
                    local Unit = if not (0.01 < u279.Magnitude) then a1.LookVector else u279.Unit
                    local Unit_2 = if not (0.01 < u281.Magnitude) then a1.UpVector else u281.Unit
                    return CFrame.lookAt(u277 - Unit * 118 + Unit_2 * 42, u277 + Unit * 45, Unit_2)
                end,
                SpeedScale = function(a1) -- Line: 542 -- types: a1: number
                    if a1 >= 0.88 then
                        return 1.8
                    end
                    return 1
                end,
                SteerLocked = function(a1) -- Line: 545 -- types: a1: number
                    return a1 >= 0.9
                end,
                Probe = function(a1, a2) -- Line: 548
                    -- upvalues: u266 (ref), Path (upval), u273 (ref), u263 (ref), u264 (ref), u53 (upval), u262 (ref)
                    -- upvalues: u267 (ref), u219 (val), Length (upval), u269 (ref), u71 (upval), u78 (upval)
                    -- upvalues: turnBefore (upval), RockFall (upval), u251 (val), u66 (upval), u270 (ref)
                    -- upvalues: SoundService (upval), BeanstalkEvent_2 (upval), RailRide (upval), onRockHit (val)
                    local v1, v2
                    local v3 = os.clock()
                    local v4 = math.min(v3 - u266, 0.1)
                    u266 = v3
                    local v5 = Path(a1)
                    u273 = v5
                    local v6 = v5.RightVector:Dot(a2.Position - v5.Position)
                    v5 = if not (v4 > 0) then 0 else (v6 - u263) / v4
                    u263 = v6
                    u264 = a1
                    local v7 = math.clamp(-(u53.Curve(a1) * 8 + v5 * 0.0045), -0.5585053606381855, 0.5585053606381855)
                    u262 = u262 + (v7 - u262) * math.min(v4 * 5, 1)
                    v7 = v3 - u267
                    if v7 < 1.1 then
                        v5 = math.floor(v7 * 12) % 2 == 0
                        u219.FillTransparency = if not (v7 < 0.12) then if not v5 then 1 else 0.55 else v7 / 0.12 * 0.4
                    elseif u219.FillTransparency < 1 then
                        u219.FillTransparency = 1
                    end
                    v3 = a1 / Length
                    if v3 >= 0.06 and a1 + 450 <= Length * 0.84 and u269 <= a1 then
                        v1 = a1 + 450
                        v2 = u71 * (v1 - a1) / u78
                        u269 = if not turnBefore(v1) then a1 + RockFall.Wave(u251, v1, v3, u71, v2, u71 / u78, u66) else a1 + 20
                    end
                    local Step = RockFall.Step
                    local v8 = false
                    if v7 >= 1.1 then
                        v8 = not u270
                    end
                    v1, v2 = Step(u251, v4, a1, v6, v8)
                    if v2 then
                        SoundService:PlayLocalSound(BeanstalkEvent_2.WhaleNearMiss)
                        RailRide.Shake(1.6)
                    end
                    if not v1 then
                        return nil
                    end
                    local Position_3 = v1.Position
                    onRockHit(v1)
                    return Position_3
                end,
                Stop = function() -- Line: 617 -- upvalues: u270 (ref)
                    return u270
                end,
                OnStep = function(a1, a2, a3) -- Line: 620
                    -- upvalues: u256 (ref), UISystem (upval), Length (upval)
                    u256 = a3
                    UISystem.SetFlightProgress(a1 / Length)
                end,
            }
            Run_2(a1, v21)
            v17:Clean()
            if not u270 then
                local Position_4, v22, v23
                local CurrentCamera = Workspace.CurrentCamera
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                local Position = CurrentCamera.CFrame.Position
                local v24 = a2.Sections.Stage4.SpawnLocation.Position + Vector3.new(0, 3, 0)
                v21 = (v24 - a3.Root.Position) * Vector3.new(1, 0, 1)
                local Unit_2 = if not (0.1 < v21.Magnitude) then Facing else v21.Unit
                a3.Root.CFrame = CFrame.lookAt(a3.Root.Position, a3.Root.Position + Unit_2)
                Juice.Throw(a3.Root, a3.Humanoid, v24, 1.8)
                v21 = partsOf(u16)
                v2 = u78 * 0.7
                local Position_2 = a3.Root.Position
                v3 = Vector3.new(0, 0, 0)
                local Position_3 = a3.Root.Position
                local v25 = os.clock()
                v5 = v25
                while true do
                    v22 = os.clock()
                    v6 = v22 - v25
                    v7 = v22 - v5
                    v5 = v22
                    swimAway(v21, v2, v6)
                    Position_4 = a3.Root.Position
                    v23 = if not (v7 > 0) then Vector3.new(0, 0, 0) else (Position_4 - Position_3) / v7
                    v8 = (Position_4:Lerp(v24, 0.2)) + v23 * 0.18
                    v9, v10 = spring(Position_2, v3, v8, 10, v7)
                    v3 = v10
                    CurrentCamera.FieldOfView = CurrentCamera.FieldOfView + ((math.clamp(math.deg((math.atan(24 / (math.max((a3.Root.Position - Position).Magnitude, 1)))) * 2), 14, 70)) - CurrentCamera.FieldOfView) * math.min(4 * v7, 1)
                    CurrentCamera.CFrame = CFrame.lookAt(Position, v9)
                    if v6 >= 1.8 then
                        break
                    end
                    task.wait()
                end
                SoundService:PlayLocalSound(BeanstalkEvent_2.SlideHit)
                local FieldOfView_2 = CurrentCamera.FieldOfView
                v22 = os.clock()
                while true do
                    v4 = math.min((os.clock() - v22) / 0.35, 1)
                    v3 = (math.sin(v4 * 3.141592653589793)) * (1 - v4 * 0.5) * 1.6
                    CurrentCamera.FieldOfView = FieldOfView_2 - math.sin(v4 * 3.141592653589793) * 4
                    CurrentCamera.CFrame = CFrame.lookAt(Position - Vector3.new(0, 1, 0) * v3, Position_2 - Vector3.new(0, 1, 0) * v3 * 0.4)
                    if v4 >= 1 then
                        break
                    end
                    task.wait()
                end
                v5 = v24 - Unit_2 * 14 + Vector3.new(0, 7, 0)
                v25 = v24 + Unit_2 * 6
                local Position_6 = CurrentCamera.CFrame.Position
                local FieldOfView_3 = CurrentCamera.FieldOfView
                v22 = os.clock()
                while true do
                    v21 = math.min((os.clock() - v22) / 1.8, 1)
                    v24 = TweenService:GetValue(v21, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    v22 = Position_6:Lerp(v5, v24)
                    v9 = v24 * 3.141592653589793
                    CurrentCamera.CFrame = CFrame.lookAt(v22 + Vector3.new(0, 1, 0) * (math.sin(v9) * 30), (a3.Root.Position:Lerp(v25, v24)))
                    CurrentCamera.FieldOfView = FieldOfView_3 + (70 - FieldOfView_3) * v24
                    if v21 >= 1 then
                        break
                    end
                    task.wait()
                end
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.CameraSubject = a3.Humanoid
                return true
            end
            RockFall.Clear(u251)
            local CurrentCamera_2 = Workspace.CurrentCamera
            CurrentCamera_2.CameraType = Enum.CameraType.Scriptable
            a3.Humanoid.PlatformStand = true
            local CFrame_3 = CurrentCamera_2.CFrame
            local CFrame_4 = a3.Root.CFrame
            local Pivot_3 = u16:GetPivot()
            v2 = os.clock() + 0.14
            while os.clock() < v2 do
                CurrentCamera_2.CFrame = CFrame_3
                a3.Root.CFrame = CFrame_4
                a3.Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                u16:PivotTo(Pivot_3)
                task.wait()
            end
            SoundService:PlayLocalSound(BeanstalkEvent_2.WhaleKnockedOff)
            UISystem.SetPrompt("Knocked off!")
            v2 = a1:Add((Instance.new("ColorCorrectionEffect")))
            v2.Name = "WhaleKnockedOff"
            v2.Parent = Lighting
            TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Saturation = -0.7, Contrast = 0.15}):Play()
            TweenService:Create(CurrentCamera_2, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {FieldOfView = 62}):Play()
            local v26 = if not (u263 >= 0) then -1 else 1
            local v27 = u273.UpVector * 38 + Vector3.new(0, 34, 0) + u273.RightVector * (v26 * 14)
            local Unit_3 = (u273.RightVector + u106:NextUnitVector() * 0.35).Unit
            v3 = u78 * 0.7
            v4 = partsOf(u16)
            local Position_7 = CFrame_3.Position
            v5 = Vector3.new(0, 0, 0)
            local Position_8 = CFrame_4.Position
            v6 = Vector3.new(0, 0, 0)
            v7 = os.clock()
            v8 = false
            while true do
                v9 = os.clock()
                v10 = v9 - v7
                v11 = v9 - v7
                v9 = CFrame_4.Position + v27 * v10 - Vector3.new(0, 1, 0) * (35 * v10 * v10)
                a3.Root.CFrame = (CFrame.new(v9)) * CFrame.fromAxisAngle(Unit_3, 5.585053606381854 * v10) * CFrame_4.Rotation
                a3.Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                a3.Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                swimAway(v4, v3, v10)
                v12 = CFrame_3.Position + (v9 - CFrame_4.Position) * 0.55
                v13, v14 = spring(Position_7, v5, v12, 3, v11)
                Position_7 = v13
                v13, v14 = spring(Position_8, v6, v9, 6, v11)
                CurrentCamera_2.CFrame = CFrame.lookAt(Position_7, v13)
                if not v8 and v10 >= 1.15 then
                    Flash.Play({Attack = 0.35, Decay = 0.9, Opacity = 1, Tint = Color3.new(1, 1, 1)})
                end
                if v10 >= 1.5 then
                    break
                end
                task.wait()
            end
            v2.Saturation = 0
            v2.Contrast = 0
            CurrentCamera_2.FieldOfView = 70
            a3.Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            a3.Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            a3.Root.CFrame = Stage3.SpawnLocation.CFrame + Vector3.new(0, 4, 0)
            a3.Humanoid.PlatformStand = false
            CurrentCamera_2.CameraType = Enum.CameraType.Custom
            CurrentCamera_2.CameraSubject = a3.Humanoid
            UISystem.SetPrompt(nil)
            UISystem.SetFlightProgress(0)
            return false
        end

        while true do
            v2 = a1:Extend()
            if attempt(v2) then
                break
            end
            v2:Clean()
            WhaleHearts.Refill(v3)
        end
        while true do
            v1 = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
            if (if typeof(v1) ~= "number" then nil else v1) ~= Stage.WhaleFlight then
                break
            end
            Remotes.BeanstalkEvent.AskFinishFlight:FireServer()
            task.wait(2)
        end
    end,
}