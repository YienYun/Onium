-- Script path: ReplicatedStorage.Controllers.Game.KrakenController
-- Decompile time: 108.84 ms

local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local HapticService = game:GetService("HapticService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local KrakenRig = require(ReplicatedStorage.Shared.Modules.KrakenRig)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u64 = {3, 5, 8}
local u68 = {2, 3, 4.5}
local Timing = KrakenRig.Timing
local Raise = KrakenRig.Raise
local u76 = Timing.Windup + Timing.Hold
local u78 = u76 + Timing.Strike
local u80 = u78 + Timing.Settle
local u82 = u80 + Timing.Down
local u84 = u82 + Timing.Recover
local u89 = Color3.fromRGB(255, 45, 45)
local u90 = {5, 16}
local DrillaWarn = ReplicatedStorage.Assets.MountRace.PowerUps.Sounds.DrillaWarn
local v1 = Color3.fromRGB(214, 240, 255)
local u108 = Color3.fromRGB(245, 252, 255)
local v2 = Color3.fromRGB(196, 186, 168)
local u114 = {}
local v3 = {
    Name = "Column",
    Texture = "rbxasset://textures/particles/smoke_main.dds",
    Count = 34,
    Spread = 11,
    Acceleration = -150,
    Drag = 0.9,
    Flat = false,
    Light = 0.15,
    Delay = 0,
    Lifetime = NumberRange.new(1.1, 1.6),
    Speed = NumberRange.new(120, 210),
    Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 22),
        NumberSequenceKeypoint.new(0.4, 46),
        (NumberSequenceKeypoint.new(1, 64)),
    }),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.55, 0.35),
        (NumberSequenceKeypoint.new(1, 1)),
    }),
    Color = u108,
}
local v4 = {
    Name = "Droplets",
    Texture = "rbxasset://textures/particles/explosion01_core_main.dds",
    Count = 70,
    Spread = 42,
    Acceleration = -196,
    Drag = 0.2,
    Flat = false,
    Light = 0.3,
    Delay = 0,
    Lifetime = NumberRange.new(1.4, 2.1),
    Speed = NumberRange.new(80, 175),
    Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 5), (NumberSequenceKeypoint.new(1, 2.5))}),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.8, 0.2),
        (NumberSequenceKeypoint.new(1, 1)),
    }),
    Color = v1,
}
local v5 = {
    Name = "Ring",
    Texture = "rbxasset://textures/particles/explosion01_shockwave_main.dds",
    Count = 1,
    Spread = 0,
    Acceleration = 0,
    Drag = 0,
    Flat = true,
    Light = 0.4,
    Delay = 0,
    Lifetime = NumberRange.new(1.2, 1.2),
    Speed = NumberRange.new(0.01, 0.01),
    Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 30),
        NumberSequenceKeypoint.new(0.35, 170),
        (NumberSequenceKeypoint.new(1, 260)),
    }),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.4),
        (NumberSequenceKeypoint.new(1, 1)),
    }),
    Color = u108,
}
local v6 = {
    Name = "Echo",
    Texture = "rbxasset://textures/particles/explosion01_shockwave_main.dds",
    Count = 1,
    Spread = 0,
    Acceleration = 0,
    Drag = 0,
    Flat = true,
    Light = 0.2,
    Delay = 0.28,
    Lifetime = NumberRange.new(1.5, 1.5),
    Speed = NumberRange.new(0.01, 0.01),
    Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 20), (NumberSequenceKeypoint.new(1, 190))}),
    Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), (NumberSequenceKeypoint.new(1, 1))}),
    Color = v1,
}
local v7 = {
    Name = "Mist",
    Texture = "rbxasset://textures/particles/smoke_main.dds",
    Count = 16,
    Spread = 80,
    Acceleration = 4,
    Drag = 1.4,
    Flat = false,
    Light = 0,
    Delay = 0.05,
    Lifetime = NumberRange.new(2, 3),
    Speed = NumberRange.new(25, 60),
    Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 50), (NumberSequenceKeypoint.new(1, 130))}),
    Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.45), (NumberSequenceKeypoint.new(1, 1))}),
    Color = u108,
}
u114[1] = v3
u114[2] = v4
u114[3] = v5
u114[4] = v6
u114[5] = v7
local u290 = {}
v3 = {
    Name = "Burst",
    Texture = "rbxasset://textures/particles/smoke_main.dds",
    Count = 26,
    Spread = 70,
    Acceleration = -20,
    Drag = 1.6,
    Flat = false,
    Light = 0,
    Delay = 0,
    Lifetime = NumberRange.new(1.2, 1.9),
    Speed = NumberRange.new(50, 110),
    Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 30), (NumberSequenceKeypoint.new(1, 90))}),
    Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))}),
    Color = v2,
}
v4 = {
    Name = "Ring",
    Texture = "rbxasset://textures/particles/explosion01_shockwave_main.dds",
    Count = 1,
    Spread = 0,
    Acceleration = 0,
    Drag = 0,
    Flat = true,
    Light = 0,
    Delay = 0,
    Lifetime = NumberRange.new(0.9, 0.9),
    Speed = NumberRange.new(0.01, 0.01),
    Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 30), (NumberSequenceKeypoint.new(1, 220))}),
    Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 1))}),
    Color = v2,
}
u290[1] = v3
u290[2] = v4
local u355 = Random.new()

local function easeInOut(a1) -- Line: 306 -- types: a1: number
    return -(math.cos(3.141592653589793 * (math.clamp(a1, 0, 1))) - 1) / 2
end

local function easeIn(a1) -- Line: 310 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * v1
end

local function springOut(a1) -- Line: 315 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1) - 1
    return v1 * 2.4 * v1 * v1 + 1 + v1 * 1.4 * v1
end

local function smoothstep(a1, a2, a3) -- Line: 320 -- types: a1: number, a2: number, a3: number
    local v1 = math.clamp((a3 - a1) / (a2 - a1), 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function flatten(a1) -- Line: 325 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

local function findTrackParts(a1, a2) -- Line: 329 -- upvalues: MountRace (val) -- types: a1: userdata, a2: boolean
    if a2 then
        while true do
            if a1:GetAttribute(MountRace.TrackAttributes.Phase) ~= nil
                or a1:FindFirstChild(MountRace.HeatsFolder) ~= nil then
                break
            end
            task.wait(0.25)
        end
    end
    local Map = a1:WaitForChild("Map", 30)
    return if Map == nil then nil else Map:WaitForChild("Creatures", 30), a1:WaitForChild("Track", 30)
end

local function listenerPosition() -- Line: 344 -- upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.CFrame.Position
    end
    return nil
end

local function rumblePad(a1) -- Line: 349 -- upvalues: UserInputService (val), HapticService (val) -- types: a1: number
    if UserInputService:GetLastInputType().Name:find("Gamepad") == nil then
        return
    end
    local Gamepad1 = Enum.UserInputType.Gamepad1
    if not HapticService:IsVibrationSupported(Gamepad1)
        or not HapticService:IsMotorSupported(Gamepad1, Enum.VibrationMotor.Large) then
        return
    end
    HapticService:SetMotor(Gamepad1, Enum.VibrationMotor.Large, a1)
    task.delay(0.35, function() -- Line: 362 -- upvalues: HapticService (upval), Gamepad1 (val)
        HapticService:SetMotor(Gamepad1, Enum.VibrationMotor.Large, 0)
    end)
end

local function emitBurst(a1, a2, a3, a4) -- Line: 367
    -- upvalues: Workspace (val)
    local v1
    local v2 = a1:Add((Instance.new("Attachment")))
    v2.WorldCFrame = CFrame.new(a2)
    v2.Parent = Workspace.Terrain
    local v3 = nil
    local v4 = nil
    for i, j in a3, v3, v4 do
        local ParticleEmitter = Instance.new("ParticleEmitter")
        ParticleEmitter.Name = j.Name
        ParticleEmitter.Texture = j.Texture
        ParticleEmitter.Enabled = false
        ParticleEmitter.Rate = 0
        ParticleEmitter.Lifetime = j.Lifetime
        ParticleEmitter.Speed = j.Speed
        ParticleEmitter.SpreadAngle = Vector2.new(j.Spread, j.Spread)
        ParticleEmitter.Size = j.Size
        ParticleEmitter.Transparency = j.Transparency
        ParticleEmitter.Color = ColorSequence.new(j.Color)
        ParticleEmitter.Acceleration = Vector3.new(0, j.Acceleration, 0)
        ParticleEmitter.Drag = j.Drag
        ParticleEmitter.LightEmission = j.Light
        ParticleEmitter.EmissionDirection = Enum.NormalId.Top
        ParticleEmitter.Rotation = NumberRange.new(0, 360)
        v1 = if not j.Flat then NumberRange.new(-40, 40) else NumberRange.new(-20, 20)
        ParticleEmitter.RotSpeed = v1
        ParticleEmitter.Orientation = if not j.Flat then Enum.ParticleOrientation.FacingCamera else Enum.ParticleOrientation.VelocityPerpendicular
        ParticleEmitter.LockedToPart = j.Flat
        ParticleEmitter.TimeScale = v5
        ParticleEmitter.Parent = v2
        if not (0 < j.Delay) then
            ParticleEmitter:Emit(j.Count)
        else
            task.delay(j.Delay / v5, function() -- Line: 397 -- upvalues: ParticleEmitter (val), j (val)
                if ParticleEmitter.Parent then
                    ParticleEmitter:Emit(j.Count)
                end
            end)
        end
    end
end

local function markDisc(a1, a2, a3, a4) -- Line: 408
    -- upvalues: u89 (val), Workspace (val)
    local v1 = a1:Add((Instance.new("Part")))
    v1.Name = a4
    v1.Shape = Enum.PartType.Cylinder
    v1.Size = Vector3.new(0.2, a3, a3)
    v1.CFrame = (CFrame.new(a2 + Vector3.new(0, 0.15000000596046448, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    v1.Material = Enum.Material.Neon
    v1.Color = u89
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    v1.Transparency = 1
    v1.Parent = Workspace.CurrentCamera
    return v1
end

local v8 = {}

local function bindTrack(a1, a2) -- Line: 429
    -- upvalues: findTrackParts (val), Trove (val), CameraShaker (val), CameraShakerDriver (val), KrakenRig (val)
    -- upvalues: u108 (val), u355 (val), Workspace (val), GuiService (val), Timing (val), rumblePad (val)
    -- upvalues: emitBurst (val), u114 (val), u290 (val), Audio (val), u76 (val), u78 (val), markDisc (val)
    -- upvalues: DrillaWarn (val), u90 (val), Raise (val), u80 (val), u82 (val), u84 (val), u64 (val), u68 (val)
    -- upvalues: Remotes (val), RunService (val)
    task.spawn(function() -- Line: 430
        -- upvalues: findTrackParts (upval), a1 (val), a2 (val), Trove (upval), CameraShaker (upval)
        -- upvalues: CameraShakerDriver (upval), KrakenRig (upval), u108 (upval), u355 (upval), Workspace (upval)
        -- upvalues: GuiService (upval), Timing (upval), rumblePad (upval), emitBurst (upval), u114 (upval)
        -- upvalues: u290 (upval), Audio (upval), u76 (upval), u78 (upval), markDisc (upval), DrillaWarn (upval)
        -- upvalues: u90 (upval), Raise (upval), u80 (upval), u82 (upval), u84 (upval), u64 (upval), u68 (upval)
        -- upvalues: Remotes (upval), RunService (upval)
        local u205, u204 = findTrackParts(a1, a2)
        if u205 ~= nil and u204 ~= nil then
            local Arm, Attribute, Attribute_2, Decode, Part1, poseOf, v1, v2, v3, v4, v5, v6
            local v7 = Trove.new()
            local u209 = CameraShaker.new()
            CameraShakerDriver.Start(u209, Enum.RenderPriority.Last.Value)
            v7:Add(function() -- Line: 439 -- upvalues: CameraShakerDriver (upval), u209 (val)
                CameraShakerDriver.Stop(u209)
            end)
            local u196 = {}
            local u210 = nil
            for i, j in u205:GetChildren() do
                if j:IsA("Model") then
                    v1 = KrakenRig.Head(j)
                    if not v1 then
                        function poseOf() -- Line: 461 -- upvalues: KrakenRig (upval), j (val)
                            return KrakenRig.Decode(j:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0}
                        end

                        Arm = KrakenRig.Arm
                        v5 = {u205}
                        Decode = KrakenRig.Decode
                        Attribute = KrakenRig.Attribute
                        v6 = Decode(j:GetAttribute(Attribute)) or {0, 0, 0}
                        v2 = Arm(j, u204, v5, v6)
                        if v2 ~= nil then
                            v3 = v2.Segments[#v2.Segments]
                            v4 = v7:Add((Instance.new("Attachment")))
                            v4.Name = "KrakenTip"
                            v4.WorldPosition = v2.Tip
                            v4.Parent = v3
                            v5 = v7:Add((Instance.new("Attachment")))
                            v5.Name = "KrakenTipTail"
                            v5.WorldPosition = v2.Tip + (v3.Position - v2.Tip).Unit * 22
                            v5.Parent = v3
                            v6 = v7:Add((Instance.new("Trail")))
                            v6.Attachment0 = v4
                            v6.Attachment1 = v5
                            v6.Lifetime = 0.22
                            v6.MinLength = 0.5
                            v6.FaceCamera = true
                            v6.LightEmission = 0.35
                            v6.Color = ColorSequence.new(u108)
                            v6.Transparency = NumberSequence.new({
                                NumberSequenceKeypoint.new(0, 0.35),
                                (NumberSequenceKeypoint.new(1, 1)),
                            })
                            v6.Enabled = false
                            v6.Parent = v3
                            local u188 = {Rig = v2, Sway = v2.Heading}
                            u188.Phase = u355:NextNumber(0, 6.283185307179586)
                            u188.Tip = v4
                            u188.Trail = v6
                            u196[j] = u188
                            Attribute_2 = KrakenRig.Attribute
                            v7:Connect(j:GetAttributeChangedSignal(Attribute_2), function() -- Line: 503 -- upvalues: KrakenRig (upval), j (val), u204 (val), u205 (val), u188 (val)
                                local v1 = KrakenRig.Arm(j, u204, {u205}, KrakenRig.Decode(j:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0})
                                if v1 ~= nil then
                                    u188.Rig = v1
                                end
                            end)
                        end
                    else
                        Part1 = v1.Motor.Part1
                        u210 = {
                            Tilt = Vector3.new(0, 0, 0),
                            TiltSpeed = Vector3.new(0, 0, 0),
                            Joint = v1,
                            Center = Part1.Position,
                        }
                    end
                end
            end
            if next(u196) == nil and u210 == nil then
                v7:Destroy()
                return
            end
            local Center = if not u210 then next(u196):GetPivot().Position else u210.Center
            local u54 = 0
            local u55 = 1
            local u56 = true

            local function gainAt(a1) -- Line: 520 -- upvalues: Workspace (upval) -- types: a1: vector
                local Position
                local CurrentCamera = Workspace.CurrentCamera
                if (if not CurrentCamera then nil else CurrentCamera.CFrame.Position) == nil then
                    return 0
                end
                local v1 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                return 1 - v1 * v1 * (3 - v1 * 2)
            end

            local function shakeFor(a1, a2, a3) -- Line: 528
                -- upvalues: GuiService (upval), Workspace (upval), u209 (val), Timing (upval), rumblePad (upval)
                local v1
                if GuiService.ReducedMotionEnabled then
                    return
                end
                local CurrentCamera = Workspace.CurrentCamera
                local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                if Position ~= nil then
                    local v2 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                    v1 = 1 - v2 * v2 * (3 - v2 * 2)
                else
                    v1 = 0
                end
                if v1 <= 0.02 then
                    return
                end
                if a2 then
                    u209:ShakeOnce(v1 * 0.8, 3, Timing.Windup * 0.8, 0.4)
                    return
                end
                u209:ShakeOnce(
                    v1 * 6.5,
                    9,
                    0,
                    0.9,
                    Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                    (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                )
                u209:ShakeOnce(v1 * 2.6, 2.5, 0.05, 1.8)
                if a3 and v1 >= 0.5 then
                    rumblePad((math.clamp(v1, 0, 1)))
                end
            end

            local function land(a1) -- Line: 555
                -- upvalues: Trove (upval), emitBurst (upval), u114 (upval), u290 (upval), u55 (ref), Audio (upval)
                -- upvalues: GuiService (upval), Workspace (upval), u209 (val), rumblePad (upval), u210 (ref)
                local Rig = a1.Rig
                local u4 = Trove.new()
                emitBurst(u4, Rig.Impact, if not Rig.Wet then u290 else u114, u55)
                task.delay(4.5 / u55, function() -- Line: 559 -- upvalues: u4 (val)
                    u4:Destroy()
                end)
                Audio.Play(
                    if not Rig.Wet then 9114036511 else 9119476512,
                    Rig.Impact,
                    {MaxDistance = 2400, Volume = {1.1, 1.3}, PlaybackSpeed = {0.82, 0.92}}
                )
                Audio.Play(9114036511, Rig.Impact, {MaxDistance = 2400, Volume = {0.7, 0.85}, PlaybackSpeed = {0.7, 0.8}})
                local Impact_4 = Rig.Impact
                local v1 = #Rig.Crossings > 0
                if not GuiService.ReducedMotionEnabled then
                    local v2
                    local CurrentCamera = Workspace.CurrentCamera
                    local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                    if Position ~= nil then
                        local v3 = math.clamp(((Position - Impact_4).Magnitude - 150) / 800, 0, 1)
                        v2 = 1 - v3 * v3 * (3 - v3 * 2)
                    else
                        v2 = 0
                    end
                    if not (v2 <= 0.02) then
                        u209:ShakeOnce(
                            v2 * 6.5,
                            9,
                            0,
                            0.9,
                            Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                            (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                        )
                        u209:ShakeOnce(v2 * 2.6, 2.5, 0.05, 1.8)
                        if v1 and v2 >= 0.5 then
                            rumblePad((math.clamp(v2, 0, 1)))
                        end
                    end
                end
                if u210 then
                    v1 = Rig.Impact - u210.Center
                    local v4 = Vector3.new(v1.X, 0, v1.Z)
                    if 1 < v4.Magnitude then
                        v1 = u210
                        v1.TiltSpeed = v1.TiltSpeed + v4.Unit * 0.18
                    end
                end
            end

            local function endSwing(a1) -- Line: 581 -- types: a1: table
                local Swing = a1.Swing
                if Swing then
                    Swing.Trove:Destroy()
                end
                a1.Swing = nil
                a1.Trail.Enabled = false
            end

            local function beginSwing(a1, a2) -- Line: 590
                -- upvalues: Trove (upval), u54 (ref), u76 (upval), u78 (upval), markDisc (upval), Workspace (upval)
                -- upvalues: Audio (upval), DrillaWarn (upval), GuiService (upval), u209 (val), Timing (upval)
                local v1, v2, v3
                local Swing = a1.Swing
                if Swing then
                    Swing.Trove:Destroy()
                end
                a1.Swing = nil
                a1.Trail.Enabled = false
                local v4 = Trove.new()
                local v5 = {
                    Started = u54 - a2,
                    Trove = v4,
                    Marks = {},
                    Fills = {},
                    Whooshed = u76 <= a2,
                    Landed = u78 <= a2,
                }
                a1.Swing = v5
                if u78 <= a2 then
                    return
                end
                for i, j in a1.Rig.Crossings do
                    v3 = Vector3.new(j.Point.X, j.Surface, j.Point.Z)
                    v1 = j.Radius * 2.5
                    table.insert(v5.Marks, (markDisc(v4, v3, v1, "KrakenMark")))
                    table.insert(v5.Fills, (markDisc(v4, v3 + Vector3.new(0, 0.05000000074505806, 0), v1, "KrakenFill")))
                end
                local v6 = #v5.Marks
                if v6 > 0 then
                    local Impact = a1.Rig.Impact
                    local CurrentCamera = Workspace.CurrentCamera
                    local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                    if Position ~= nil then
                        v2 = math.clamp(((Position - Impact).Magnitude - 150) / 800, 0, 1)
                        v6 = 1 - v2 * v2 * (3 - v2 * 2)
                    else
                        v6 = 0
                    end
                    if v6 > 0 then
                        local CurrentCamera_2 = Workspace.CurrentCamera
                        local Position_2 = if not CurrentCamera_2 then nil else CurrentCamera_2.CFrame.Position
                        if Position_2 and (Position_2 - a1.Rig.Impact).Magnitude <= 700 then
                            Audio.Play(DrillaWarn, a1.Rig.Impact, {MaxDistance = 700})
                        end
                    end
                end
                local Impact_2 = a1.Rig.Impact
                if GuiService.ReducedMotionEnabled then
                    return
                end
                local CurrentCamera_3 = Workspace.CurrentCamera
                local Position_3 = if not CurrentCamera_3 then nil else CurrentCamera_3.CFrame.Position
                if Position_3 ~= nil then
                    v2 = math.clamp(((Position_3 - Impact_2).Magnitude - 150) / 800, 0, 1)
                    v5 = 1 - v2 * v2 * (3 - v2 * 2)
                else
                    v5 = 0
                end
                if v5 <= 0.02 then
                    return
                end
                u209:ShakeOnce(v5 * 0.8, 3, Timing.Windup * 0.8, 0.4)
            end

            local function paintMarks(a1, a2) -- Line: 623
                -- upvalues: u78 (upval), u90 (upval)
                local v1
                if #a1.Marks == 0 then
                    return
                end
                if u78 + 0.15 <= a2 then
                    for k, n in a1.Marks do
                        n:Destroy()
                    end
                    for m, i5 in a1.Fills do
                        i5:Destroy()
                    end
                    table.clear(a1.Marks)
                    table.clear(a1.Fills)
                    return
                end
                local v2 = math.clamp(a2 / u78, 0, 1)
                local v3 = math.lerp(u90[1], u90[2], v2)
                local v4 = if not (u78 < a2) then 0 else (a2 - u78) / 0.15
                local v5 = (math.lerp(0.72, 0.45, v2)) + math.sin(a2 * v3) * 0.12
                for i, j in a1.Marks do
                    v1 = math.clamp(v5, 0, 1)
                    j.Transparency = math.lerp(v1, 1, v4)
                    v3 = a1.Fills[i]
                    v1 = math.max(j.Size.Y * v2, 0.2)
                    v3.Size = Vector3.new(0.2, v1, v1)
                    v3.Transparency = math.lerp(0.35, 1, v4)
                end
            end

            local function swingAngles(a1, a2) -- Line: 652
                -- upvalues: Raise (upval), KrakenRig (upval), Timing (upval), u76 (upval), u78 (upval), u80 (upval)
                -- upvalues: u82 (upval)
                local v1, v2, v3, v4, v5, v6, v7, v8
                local Rig = a1.Rig
                local v9 = table.create(#Rig.Joints, 0)
                local v10 = #Rig.Joints
                local v11 = a2
                for i = 1, v10 do
                    v7 = Raise
                    v2 = #Raise
                    v6 = v7[math.min(i, v2)]
                    v7 = KrakenRig.StrikeAngle(Rig, i)
                    if v11 < Timing.Windup then
                        v8 = v6 * (-(math.cos(3.141592653589793 * (math.clamp(v11 / Timing.Windup, 0, 1))) - 1) / 2)
                    elseif v11 < u76 then
                        v1 = (v11 - Timing.Windup) / Timing.Hold
                        v8 = v6 * (1 + 0.06000000000000005 * v1) + math.sin(v11 * 46 + i) * 0.7 * v1
                    elseif v11 < u78 + (i - 1) * 0.04 then
                        v1 = (v11 - u76 - (i - 1) * 0.04) / Timing.Strike
                        v3 = v6 * 1.06
                        v5 = math.clamp(v1, 0, 1)
                        v8 = math.lerp(v3, v7, v5 * v5 * v5)
                    elseif v11 < u80 then
                        v1 = math.clamp((v11 - u78) / Timing.Settle, 0, 1)
                        v8 = if i ~= 1 then v7 + math.sin(v1 * 3.141592653589793 * 2) * 7 * (1 - v1) else v7 - math.sin(v1 * 3.141592653589793) * 3
                    elseif not (v11 < u82) then
                        v4 = math.clamp((v11 - u82) / Timing.Recover, 0, 1) - 1
                        v8 = v7 * (1 - (v4 * 2.4 * v4 * v4 + 1 + v4 * 1.4 * v4))
                    else
                        v8 = v7
                    end
                    v9[i] = v8
                end
                return v9
            end

            local function poseArm(a1) -- Line: 685
                -- upvalues: u54 (ref), u84 (upval), swingAngles (val), Timing (upval), paintMarks (val), u76 (upval)
                -- upvalues: Audio (upval), u78 (upval), land (val), u64 (upval), u68 (upval), KrakenRig (upval)
                local v1, v2, v3, v4, v5
                local Rig = a1.Rig
                local Swing = a1.Swing
                local v6 = 1
                local v7 = nil
                if Swing then
                    local v8 = u54 - Swing.Started
                    if not (u84 <= v8) then
                        v7 = swingAngles(a1, v8)
                        v6 = math.lerp(1, 0.2, (math.clamp(math.min(v8 / Timing.Windup, (u84 - v8) / Timing.Recover, 1), 0, 1)))
                        paintMarks(Swing, v8)
                        if not Swing.Whooshed and u76 <= v8 then
                            Swing.Whooshed = true
                            a1.Trail.Enabled = true
                            Audio.Play(9113077334, a1.Tip, {MaxDistance = 2400, Volume = 0.9, PlaybackSpeed = {0.75, 0.85}})
                        end
                        if not Swing.Landed and u78 <= v8 then
                            Swing.Landed = true
                            land(a1)
                        end
                        if a1.Trail.Enabled and u78 + 0.2 <= v8 then
                            a1.Trail.Enabled = false
                        end
                    else
                        local Swing_2 = a1.Swing
                        if Swing_2 then
                            Swing_2.Trove:Destroy()
                        end
                        a1.Swing = nil
                        a1.Trail.Enabled = false
                    end
                end
                local v9 = nil
                local v10 = nil
                for i, j in Rig.Joints, v9, v10 do
                    v5 = u54 * 3.141592653589793 * 2 / 5.6 + a1.Phase - i * 0.75
                    v1 = u54 * 3.141592653589793 * 2 / 7.3 + a1.Phase * 1.7 - i * 0.75
                    v3 = u64
                    v4 = #u64
                    v2 = v3[math.min(i, v4)] * math.sin(v5) * v6
                    v3 = u68
                    v4 = #u68
                    v5 = v3[math.min(i, v4)] * math.sin(v1) * v6
                    if v7 then
                        v2 = v2 + v7[i]
                    end
                    v1 = (CFrame.fromAxisAngle(Rig.Curl, (math.rad(v2)))) * CFrame.fromAxisAngle(a1.Sway, (math.rad(v5)))
                    KrakenRig.Drive(j, KrakenRig.About(j.Pivot, v1))
                end
            end

            local function poseHead(a1) -- Line: 734
                -- upvalues: u210 (ref), u54 (ref), KrakenRig (upval)
                local v1 = u210
                if v1 == nil then
                    return
                end
                v1.TiltSpeed = v1.TiltSpeed + (-v1.Tilt * 18 - v1.TiltSpeed * 4.5) * a1
                v1.Tilt = v1.Tilt + v1.TiltSpeed * a1
                local v2 = u54 * 3.141592653589793 * 2
                local v3 = CFrame.Angles(
                    math.rad((math.sin(v2 / 8.32)) * 1.1),
                    math.rad((math.sin(v2 / 13.440000000000001 + 1)) * 1.6),
                    (math.rad((math.sin(v2 / 10.88 + 2)) * 1.1))
                )
                local identity = CFrame.identity
                if 0.0001 < v1.Tilt.Magnitude then
                    local fromAxisAngle = CFrame.fromAxisAngle
                    local Unit = v1.Tilt.Unit
                    identity = fromAxisAngle(Vector3.new(0, 1, 0):Cross(Unit), v1.Tilt.Magnitude)
                end
                KrakenRig.Drive(v1.Joint, (CFrame.new(0, math.sin(v2 / 6.4) * 3.5, 0)) * KrakenRig.About(v1.Joint.Pivot, identity * v3))
            end

            local function rest() -- Line: 761 -- upvalues: u196 (val), u210 (ref)
                local Swing
                local v1 = nil
                local v2 = nil
                for i, j in u196, v1, v2 do
                    Swing = j.Swing
                    if Swing then
                        Swing.Trove:Destroy()
                    end
                    j.Swing = nil
                    j.Trail.Enabled = false
                    for k, n in j.Rig.Joints do
                        n.Motor.Transform = CFrame.identity
                    end
                end
                if u210 then
                    u210.Joint.Motor.Transform = CFrame.identity
                end
            end

            local function nearby() -- Line: 773 -- upvalues: Workspace (upval), Center (val)
                local CurrentCamera = Workspace.CurrentCamera
                local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                local v1 = false
                if Position ~= nil then
                    v1 = (Position - Center).Magnitude <= 2800
                end
                return v1
            end

            v7:Connect(Remotes.MountRace.PowerUpMoment.OnClientEvent, function(a1, a2, a3) -- Line: 780
                -- upvalues: u196 (val), Workspace (upval), Center (val), u84 (upval), beginSwing (val)
                if a1 == "Kraken" and typeof(a2) == "Instance" and type(a3) == "number" then
                    local v1 = u196[a2]
                    if v1 ~= nil then
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        local v2 = false
                        if Position ~= nil then
                            v2 = (Position - Center).Magnitude <= 2800
                        end
                        if v2 then
                            v2 = math.max(0, (Workspace:GetServerTimeNow()) - a3)
                            if v2 < u84 then
                                beginSwing(v1, v2)
                            end
                            return
                        end
                    end
                    return
                end
            end)
            v7:Connect(RunService.PreSimulation, function(a1) -- Line: 799
                -- upvalues: Workspace (upval), Center (val), u56 (ref), rest (val), u205 (val), u55 (ref), u54 (ref)
                -- upvalues: u196 (val), poseArm (val), poseHead (val)
                local CurrentCamera = Workspace.CurrentCamera
                local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                local v1 = false
                if Position ~= nil then
                    v1 = (Position - Center).Magnitude <= 2800
                end
                if not v1 then
                    if not u56 then
                        u56 = true
                        rest()
                    end
                    return
                end
                u56 = false
                local Attribute = u205:GetAttribute("KrakenSpeed")
                u55 = if type(Attribute) ~= "number" then 1 else if not (Attribute > 0) then 1 else Attribute
                local v2 = a1 * u55
                u54 = u54 + v2
                for i, j in u196 do
                    poseArm(j)
                end
                poseHead((math.min(v2, 0.05)))
            end)
            v7:AttachToInstance(u205)
            return
        end
    end)
end

function v8.Start() -- Line: 822
    -- upvalues: Workspace (val), findTrackParts (val), Trove (val), CameraShaker (val), CameraShakerDriver (val)
    -- upvalues: KrakenRig (val), u108 (val), u355 (val), GuiService (val), Timing (val), rumblePad (val)
    -- upvalues: emitBurst (val), u114 (val), u290 (val), Audio (val), u76 (val), u78 (val), markDisc (val)
    -- upvalues: DrillaWarn (val), u90 (val), Raise (val), u80 (val), u82 (val), u84 (val), u64 (val), u68 (val)
    -- upvalues: Remotes (val), RunService (val), CollectionService (val), MountRace (val)
    local spawn
    local u0 = {}

    local function onTrack(a1, a2) -- Line: 824
        -- upvalues: u0 (val), Workspace (upval), findTrackParts (upval), Trove (upval), CameraShaker (upval)
        -- upvalues: CameraShakerDriver (upval), KrakenRig (upval), u108 (upval), u355 (upval), GuiService (upval)
        -- upvalues: Timing (upval), rumblePad (upval), emitBurst (upval), u114 (upval), u290 (upval), Audio (upval)
        -- upvalues: u76 (upval), u78 (upval), markDisc (upval), DrillaWarn (upval), u90 (upval), Raise (upval)
        -- upvalues: u80 (upval), u82 (upval), u84 (upval), u64 (upval), u68 (upval), Remotes (upval)
        -- upvalues: RunService (upval)
        if u0[a1] == nil and a1:IsDescendantOf(Workspace) then
            u0[a1] = true
            task.spawn(function() -- Line: 430
                -- upvalues: findTrackParts (upval), a1 (val), a2 (val), Trove (upval), CameraShaker (upval)
                -- upvalues: CameraShakerDriver (upval), KrakenRig (upval), u108 (upval), u355 (upval)
                -- upvalues: Workspace (upval), GuiService (upval), Timing (upval), rumblePad (upval), emitBurst (upval)
                -- upvalues: u114 (upval), u290 (upval), Audio (upval), u76 (upval), u78 (upval), markDisc (upval)
                -- upvalues: DrillaWarn (upval), u90 (upval), Raise (upval), u80 (upval), u82 (upval), u84 (upval)
                -- upvalues: u64 (upval), u68 (upval), Remotes (upval), RunService (upval)
                local u205, u204 = findTrackParts(a1, a2)
                if u205 ~= nil and u204 ~= nil then
                    local Arm, Attribute, Attribute_2, Decode, Part1, poseOf, v1, v2, v3, v4, v5, v6
                    local v7 = Trove.new()
                    local u209 = CameraShaker.new()
                    CameraShakerDriver.Start(u209, Enum.RenderPriority.Last.Value)
                    v7:Add(function() -- Line: 439 -- upvalues: CameraShakerDriver (upval), u209 (val)
                        CameraShakerDriver.Stop(u209)
                    end)
                    local u196 = {}
                    local u210 = nil
                    for i, j in u205:GetChildren() do
                        if j:IsA("Model") then
                            v1 = KrakenRig.Head(j)
                            if not v1 then
                                function poseOf() -- Line: 461 -- upvalues: KrakenRig (upval), j (val)
                                    return KrakenRig.Decode(j:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0}
                                end

                                Arm = KrakenRig.Arm
                                v5 = {u205}
                                Decode = KrakenRig.Decode
                                Attribute = KrakenRig.Attribute
                                v6 = Decode(j:GetAttribute(Attribute)) or {0, 0, 0}
                                v2 = Arm(j, u204, v5, v6)
                                if v2 ~= nil then
                                    v3 = v2.Segments[#v2.Segments]
                                    v4 = v7:Add((Instance.new("Attachment")))
                                    v4.Name = "KrakenTip"
                                    v4.WorldPosition = v2.Tip
                                    v4.Parent = v3
                                    v5 = v7:Add((Instance.new("Attachment")))
                                    v5.Name = "KrakenTipTail"
                                    v5.WorldPosition = v2.Tip + (v3.Position - v2.Tip).Unit * 22
                                    v5.Parent = v3
                                    v6 = v7:Add((Instance.new("Trail")))
                                    v6.Attachment0 = v4
                                    v6.Attachment1 = v5
                                    v6.Lifetime = 0.22
                                    v6.MinLength = 0.5
                                    v6.FaceCamera = true
                                    v6.LightEmission = 0.35
                                    v6.Color = ColorSequence.new(u108)
                                    v6.Transparency = NumberSequence.new({
                                        NumberSequenceKeypoint.new(0, 0.35),
                                        (NumberSequenceKeypoint.new(1, 1)),
                                    })
                                    v6.Enabled = false
                                    v6.Parent = v3
                                    local u188 = {Rig = v2, Sway = v2.Heading}
                                    u188.Phase = u355:NextNumber(0, 6.283185307179586)
                                    u188.Tip = v4
                                    u188.Trail = v6
                                    u196[j] = u188
                                    Attribute_2 = KrakenRig.Attribute
                                    v7:Connect(j:GetAttributeChangedSignal(Attribute_2), function() -- Line: 503 -- upvalues: KrakenRig (upval), j (val), u204 (val), u205 (val), u188 (val)
                                        local v1 = KrakenRig.Arm(j, u204, {u205}, KrakenRig.Decode(j:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0})
                                        if v1 ~= nil then
                                            u188.Rig = v1
                                        end
                                    end)
                                end
                            else
                                Part1 = v1.Motor.Part1
                                u210 = {
                                    Tilt = Vector3.new(0, 0, 0),
                                    TiltSpeed = Vector3.new(0, 0, 0),
                                    Joint = v1,
                                    Center = Part1.Position,
                                }
                            end
                        end
                    end
                    if next(u196) == nil and u210 == nil then
                        v7:Destroy()
                        return
                    end
                    local Center = if not u210 then next(u196):GetPivot().Position else u210.Center
                    local u54 = 0
                    local u55 = 1
                    local u56 = true

                    local function gainAt(a1) -- Line: 520 -- upvalues: Workspace (upval) -- types: a1: vector
                        local Position
                        local CurrentCamera = Workspace.CurrentCamera
                        if (if not CurrentCamera then nil else CurrentCamera.CFrame.Position) == nil then
                            return 0
                        end
                        local v1 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                        return 1 - v1 * v1 * (3 - v1 * 2)
                    end

                    local function shakeFor(a1, a2, a3) -- Line: 528
                        -- upvalues: GuiService (upval), Workspace (upval), u209 (val), Timing (upval)
                        -- upvalues: rumblePad (upval)
                        local v1
                        if GuiService.ReducedMotionEnabled then
                            return
                        end
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        if Position ~= nil then
                            local v2 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                            v1 = 1 - v2 * v2 * (3 - v2 * 2)
                        else
                            v1 = 0
                        end
                        if v1 <= 0.02 then
                            return
                        end
                        if a2 then
                            u209:ShakeOnce(v1 * 0.8, 3, Timing.Windup * 0.8, 0.4)
                            return
                        end
                        u209:ShakeOnce(
                            v1 * 6.5,
                            9,
                            0,
                            0.9,
                            Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                            (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                        )
                        u209:ShakeOnce(v1 * 2.6, 2.5, 0.05, 1.8)
                        if a3 and v1 >= 0.5 then
                            rumblePad((math.clamp(v1, 0, 1)))
                        end
                    end

                    local function land(a1) -- Line: 555
                        -- upvalues: Trove (upval), emitBurst (upval), u114 (upval), u290 (upval), u55 (ref)
                        -- upvalues: Audio (upval), GuiService (upval), Workspace (upval), u209 (val), rumblePad (upval)
                        -- upvalues: u210 (ref)
                        local Rig = a1.Rig
                        local u4 = Trove.new()
                        emitBurst(u4, Rig.Impact, if not Rig.Wet then u290 else u114, u55)
                        task.delay(4.5 / u55, function() -- Line: 559 -- upvalues: u4 (val)
                            u4:Destroy()
                        end)
                        Audio.Play(
                            if not Rig.Wet then 9114036511 else 9119476512,
                            Rig.Impact,
                            {MaxDistance = 2400, Volume = {1.1, 1.3}, PlaybackSpeed = {0.82, 0.92}}
                        )
                        Audio.Play(9114036511, Rig.Impact, {MaxDistance = 2400, Volume = {0.7, 0.85}, PlaybackSpeed = {0.7, 0.8}})
                        local Impact_4 = Rig.Impact
                        local v1 = #Rig.Crossings > 0
                        if not GuiService.ReducedMotionEnabled then
                            local v2
                            local CurrentCamera = Workspace.CurrentCamera
                            local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                            if Position ~= nil then
                                local v3 = math.clamp(((Position - Impact_4).Magnitude - 150) / 800, 0, 1)
                                v2 = 1 - v3 * v3 * (3 - v3 * 2)
                            else
                                v2 = 0
                            end
                            if not (v2 <= 0.02) then
                                u209:ShakeOnce(
                                    v2 * 6.5,
                                    9,
                                    0,
                                    0.9,
                                    Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                                    (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                                )
                                u209:ShakeOnce(v2 * 2.6, 2.5, 0.05, 1.8)
                                if v1 and v2 >= 0.5 then
                                    rumblePad((math.clamp(v2, 0, 1)))
                                end
                            end
                        end
                        if u210 then
                            v1 = Rig.Impact - u210.Center
                            local v4 = Vector3.new(v1.X, 0, v1.Z)
                            if 1 < v4.Magnitude then
                                v1 = u210
                                v1.TiltSpeed = v1.TiltSpeed + v4.Unit * 0.18
                            end
                        end
                    end

                    local function endSwing(a1) -- Line: 581 -- types: a1: table
                        local Swing = a1.Swing
                        if Swing then
                            Swing.Trove:Destroy()
                        end
                        a1.Swing = nil
                        a1.Trail.Enabled = false
                    end

                    local function beginSwing(a1, a2) -- Line: 590
                        -- upvalues: Trove (upval), u54 (ref), u76 (upval), u78 (upval), markDisc (upval)
                        -- upvalues: Workspace (upval), Audio (upval), DrillaWarn (upval), GuiService (upval)
                        -- upvalues: u209 (val), Timing (upval)
                        local v1, v2, v3
                        local Swing = a1.Swing
                        if Swing then
                            Swing.Trove:Destroy()
                        end
                        a1.Swing = nil
                        a1.Trail.Enabled = false
                        local v4 = Trove.new()
                        local v5 = {
                            Started = u54 - a2,
                            Trove = v4,
                            Marks = {},
                            Fills = {},
                            Whooshed = u76 <= a2,
                            Landed = u78 <= a2,
                        }
                        a1.Swing = v5
                        if u78 <= a2 then
                            return
                        end
                        for i, j in a1.Rig.Crossings do
                            v3 = Vector3.new(j.Point.X, j.Surface, j.Point.Z)
                            v1 = j.Radius * 2.5
                            table.insert(v5.Marks, (markDisc(v4, v3, v1, "KrakenMark")))
                            table.insert(v5.Fills, (markDisc(v4, v3 + Vector3.new(0, 0.05000000074505806, 0), v1, "KrakenFill")))
                        end
                        local v6 = #v5.Marks
                        if v6 > 0 then
                            local Impact = a1.Rig.Impact
                            local CurrentCamera = Workspace.CurrentCamera
                            local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                            if Position ~= nil then
                                v2 = math.clamp(((Position - Impact).Magnitude - 150) / 800, 0, 1)
                                v6 = 1 - v2 * v2 * (3 - v2 * 2)
                            else
                                v6 = 0
                            end
                            if v6 > 0 then
                                local CurrentCamera_2 = Workspace.CurrentCamera
                                local Position_2 = if not CurrentCamera_2 then nil else CurrentCamera_2.CFrame.Position
                                if Position_2 and (Position_2 - a1.Rig.Impact).Magnitude <= 700 then
                                    Audio.Play(DrillaWarn, a1.Rig.Impact, {MaxDistance = 700})
                                end
                            end
                        end
                        local Impact_2 = a1.Rig.Impact
                        if GuiService.ReducedMotionEnabled then
                            return
                        end
                        local CurrentCamera_3 = Workspace.CurrentCamera
                        local Position_3 = if not CurrentCamera_3 then nil else CurrentCamera_3.CFrame.Position
                        if Position_3 ~= nil then
                            v2 = math.clamp(((Position_3 - Impact_2).Magnitude - 150) / 800, 0, 1)
                            v5 = 1 - v2 * v2 * (3 - v2 * 2)
                        else
                            v5 = 0
                        end
                        if v5 <= 0.02 then
                            return
                        end
                        u209:ShakeOnce(v5 * 0.8, 3, Timing.Windup * 0.8, 0.4)
                    end

                    local function paintMarks(a1, a2) -- Line: 623
                        -- upvalues: u78 (upval), u90 (upval)
                        local v1
                        if #a1.Marks == 0 then
                            return
                        end
                        if u78 + 0.15 <= a2 then
                            for k, n in a1.Marks do
                                n:Destroy()
                            end
                            for m, i5 in a1.Fills do
                                i5:Destroy()
                            end
                            table.clear(a1.Marks)
                            table.clear(a1.Fills)
                            return
                        end
                        local v2 = math.clamp(a2 / u78, 0, 1)
                        local v3 = math.lerp(u90[1], u90[2], v2)
                        local v4 = if not (u78 < a2) then 0 else (a2 - u78) / 0.15
                        local v5 = (math.lerp(0.72, 0.45, v2)) + math.sin(a2 * v3) * 0.12
                        for i, j in a1.Marks do
                            v1 = math.clamp(v5, 0, 1)
                            j.Transparency = math.lerp(v1, 1, v4)
                            v3 = a1.Fills[i]
                            v1 = math.max(j.Size.Y * v2, 0.2)
                            v3.Size = Vector3.new(0.2, v1, v1)
                            v3.Transparency = math.lerp(0.35, 1, v4)
                        end
                    end

                    local function swingAngles(a1, a2) -- Line: 652
                        -- upvalues: Raise (upval), KrakenRig (upval), Timing (upval), u76 (upval), u78 (upval)
                        -- upvalues: u80 (upval), u82 (upval)
                        local v1, v2, v3, v4, v5, v6, v7, v8
                        local Rig = a1.Rig
                        local v9 = table.create(#Rig.Joints, 0)
                        local v10 = #Rig.Joints
                        local v11 = a2
                        for i = 1, v10 do
                            v7 = Raise
                            v2 = #Raise
                            v6 = v7[math.min(i, v2)]
                            v7 = KrakenRig.StrikeAngle(Rig, i)
                            if v11 < Timing.Windup then
                                v8 = v6 * (-(math.cos(3.141592653589793 * (math.clamp(v11 / Timing.Windup, 0, 1))) - 1) / 2)
                            elseif v11 < u76 then
                                v1 = (v11 - Timing.Windup) / Timing.Hold
                                v8 = v6 * (1 + 0.06000000000000005 * v1) + math.sin(v11 * 46 + i) * 0.7 * v1
                            elseif v11 < u78 + (i - 1) * 0.04 then
                                v1 = (v11 - u76 - (i - 1) * 0.04) / Timing.Strike
                                v3 = v6 * 1.06
                                v5 = math.clamp(v1, 0, 1)
                                v8 = math.lerp(v3, v7, v5 * v5 * v5)
                            elseif v11 < u80 then
                                v1 = math.clamp((v11 - u78) / Timing.Settle, 0, 1)
                                v8 = if i ~= 1 then v7 + math.sin(v1 * 3.141592653589793 * 2) * 7 * (1 - v1) else v7 - math.sin(v1 * 3.141592653589793) * 3
                            elseif not (v11 < u82) then
                                v4 = math.clamp((v11 - u82) / Timing.Recover, 0, 1) - 1
                                v8 = v7 * (1 - (v4 * 2.4 * v4 * v4 + 1 + v4 * 1.4 * v4))
                            else
                                v8 = v7
                            end
                            v9[i] = v8
                        end
                        return v9
                    end

                    local function poseArm(a1) -- Line: 685
                        -- upvalues: u54 (ref), u84 (upval), swingAngles (val), Timing (upval), paintMarks (val)
                        -- upvalues: u76 (upval), Audio (upval), u78 (upval), land (val), u64 (upval), u68 (upval)
                        -- upvalues: KrakenRig (upval)
                        local v1, v2, v3, v4, v5
                        local Rig = a1.Rig
                        local Swing = a1.Swing
                        local v6 = 1
                        local v7 = nil
                        if Swing then
                            local v8 = u54 - Swing.Started
                            if not (u84 <= v8) then
                                v7 = swingAngles(a1, v8)
                                v6 = math.lerp(1, 0.2, (math.clamp(math.min(v8 / Timing.Windup, (u84 - v8) / Timing.Recover, 1), 0, 1)))
                                paintMarks(Swing, v8)
                                if not Swing.Whooshed and u76 <= v8 then
                                    Swing.Whooshed = true
                                    a1.Trail.Enabled = true
                                    Audio.Play(9113077334, a1.Tip, {MaxDistance = 2400, Volume = 0.9, PlaybackSpeed = {0.75, 0.85}})
                                end
                                if not Swing.Landed and u78 <= v8 then
                                    Swing.Landed = true
                                    land(a1)
                                end
                                if a1.Trail.Enabled and u78 + 0.2 <= v8 then
                                    a1.Trail.Enabled = false
                                end
                            else
                                local Swing_2 = a1.Swing
                                if Swing_2 then
                                    Swing_2.Trove:Destroy()
                                end
                                a1.Swing = nil
                                a1.Trail.Enabled = false
                            end
                        end
                        local v9 = nil
                        local v10 = nil
                        for i, j in Rig.Joints, v9, v10 do
                            v5 = u54 * 3.141592653589793 * 2 / 5.6 + a1.Phase - i * 0.75
                            v1 = u54 * 3.141592653589793 * 2 / 7.3 + a1.Phase * 1.7 - i * 0.75
                            v3 = u64
                            v4 = #u64
                            v2 = v3[math.min(i, v4)] * math.sin(v5) * v6
                            v3 = u68
                            v4 = #u68
                            v5 = v3[math.min(i, v4)] * math.sin(v1) * v6
                            if v7 then
                                v2 = v2 + v7[i]
                            end
                            v1 = (CFrame.fromAxisAngle(Rig.Curl, (math.rad(v2)))) * CFrame.fromAxisAngle(a1.Sway, (math.rad(v5)))
                            KrakenRig.Drive(j, KrakenRig.About(j.Pivot, v1))
                        end
                    end

                    local function poseHead(a1) -- Line: 734
                        -- upvalues: u210 (ref), u54 (ref), KrakenRig (upval)
                        local v1 = u210
                        if v1 == nil then
                            return
                        end
                        v1.TiltSpeed = v1.TiltSpeed + (-v1.Tilt * 18 - v1.TiltSpeed * 4.5) * a1
                        v1.Tilt = v1.Tilt + v1.TiltSpeed * a1
                        local v2 = u54 * 3.141592653589793 * 2
                        local v3 = CFrame.Angles(
                            math.rad((math.sin(v2 / 8.32)) * 1.1),
                            math.rad((math.sin(v2 / 13.440000000000001 + 1)) * 1.6),
                            (math.rad((math.sin(v2 / 10.88 + 2)) * 1.1))
                        )
                        local identity = CFrame.identity
                        if 0.0001 < v1.Tilt.Magnitude then
                            local fromAxisAngle = CFrame.fromAxisAngle
                            local Unit = v1.Tilt.Unit
                            identity = fromAxisAngle(Vector3.new(0, 1, 0):Cross(Unit), v1.Tilt.Magnitude)
                        end
                        KrakenRig.Drive(
                            v1.Joint,
                            (CFrame.new(0, math.sin(v2 / 6.4) * 3.5, 0)) * KrakenRig.About(v1.Joint.Pivot, identity * v3)
                        )
                    end

                    local function rest() -- Line: 761 -- upvalues: u196 (val), u210 (ref)
                        local Swing
                        local v1 = nil
                        local v2 = nil
                        for i, j in u196, v1, v2 do
                            Swing = j.Swing
                            if Swing then
                                Swing.Trove:Destroy()
                            end
                            j.Swing = nil
                            j.Trail.Enabled = false
                            for k, n in j.Rig.Joints do
                                n.Motor.Transform = CFrame.identity
                            end
                        end
                        if u210 then
                            u210.Joint.Motor.Transform = CFrame.identity
                        end
                    end

                    local function nearby() -- Line: 773 -- upvalues: Workspace (upval), Center (val)
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        local v1 = false
                        if Position ~= nil then
                            v1 = (Position - Center).Magnitude <= 2800
                        end
                        return v1
                    end

                    v7:Connect(Remotes.MountRace.PowerUpMoment.OnClientEvent, function(a1, a2, a3) -- Line: 780
                        -- upvalues: u196 (val), Workspace (upval), Center (val), u84 (upval), beginSwing (val)
                        if a1 == "Kraken" and typeof(a2) == "Instance" and type(a3) == "number" then
                            local v1 = u196[a2]
                            if v1 ~= nil then
                                local CurrentCamera = Workspace.CurrentCamera
                                local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                                local v2 = false
                                if Position ~= nil then
                                    v2 = (Position - Center).Magnitude <= 2800
                                end
                                if v2 then
                                    v2 = math.max(0, (Workspace:GetServerTimeNow()) - a3)
                                    if v2 < u84 then
                                        beginSwing(v1, v2)
                                    end
                                    return
                                end
                            end
                            return
                        end
                    end)
                    v7:Connect(RunService.PreSimulation, function(a1) -- Line: 799
                        -- upvalues: Workspace (upval), Center (val), u56 (ref), rest (val), u205 (val), u55 (ref)
                        -- upvalues: u54 (ref), u196 (val), poseArm (val), poseHead (val)
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        local v1 = false
                        if Position ~= nil then
                            v1 = (Position - Center).Magnitude <= 2800
                        end
                        if not v1 then
                            if not u56 then
                                u56 = true
                                rest()
                            end
                            return
                        end
                        u56 = false
                        local Attribute = u205:GetAttribute("KrakenSpeed")
                        u55 = if type(Attribute) ~= "number" then 1 else if not (Attribute > 0) then 1 else Attribute
                        local v2 = a1 * u55
                        u54 = u54 + v2
                        for i, j in u196 do
                            poseArm(j)
                        end
                        poseHead((math.min(v2, 0.05)))
                    end)
                    v7:AttachToInstance(u205)
                    return
                end
            end)
        end
    end

    ;(CollectionService:GetInstanceAddedSignal(MountRace.TrackTag)):Connect(function(a1) -- Line: 830
        -- upvalues: u0 (val), Workspace (upval), findTrackParts (upval), Trove (upval), CameraShaker (upval)
        -- upvalues: CameraShakerDriver (upval), KrakenRig (upval), u108 (upval), u355 (upval), GuiService (upval)
        -- upvalues: Timing (upval), rumblePad (upval), emitBurst (upval), u114 (upval), u290 (upval), Audio (upval)
        -- upvalues: u76 (upval), u78 (upval), markDisc (upval), DrillaWarn (upval), u90 (upval), Raise (upval)
        -- upvalues: u80 (upval), u82 (upval), u84 (upval), u64 (upval), u68 (upval), Remotes (upval)
        -- upvalues: RunService (upval)
        if u0[a1] == nil and a1:IsDescendantOf(Workspace) then
            u0[a1] = true
            local spawn = task.spawn
            local u10 = true
            spawn(function() -- Line: 430
                -- upvalues: findTrackParts (upval), a1 (val), u10 (val), Trove (upval), CameraShaker (upval)
                -- upvalues: CameraShakerDriver (upval), KrakenRig (upval), u108 (upval), u355 (upval)
                -- upvalues: Workspace (upval), GuiService (upval), Timing (upval), rumblePad (upval), emitBurst (upval)
                -- upvalues: u114 (upval), u290 (upval), Audio (upval), u76 (upval), u78 (upval), markDisc (upval)
                -- upvalues: DrillaWarn (upval), u90 (upval), Raise (upval), u80 (upval), u82 (upval), u84 (upval)
                -- upvalues: u64 (upval), u68 (upval), Remotes (upval), RunService (upval)
                local u205, u204 = findTrackParts(a1, u10)
                if u205 ~= nil and u204 ~= nil then
                    local Arm, Attribute, Attribute_2, Decode, Part1, poseOf, v1, v2, v3, v4, v5, v6
                    local v7 = Trove.new()
                    local u209 = CameraShaker.new()
                    CameraShakerDriver.Start(u209, Enum.RenderPriority.Last.Value)
                    v7:Add(function() -- Line: 439 -- upvalues: CameraShakerDriver (upval), u209 (val)
                        CameraShakerDriver.Stop(u209)
                    end)
                    local u196 = {}
                    local u210 = nil
                    for i, j in u205:GetChildren() do
                        if j:IsA("Model") then
                            v1 = KrakenRig.Head(j)
                            if not v1 then
                                function poseOf() -- Line: 461 -- upvalues: KrakenRig (upval), j (val)
                                    return KrakenRig.Decode(j:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0}
                                end

                                Arm = KrakenRig.Arm
                                v5 = {u205}
                                Decode = KrakenRig.Decode
                                Attribute = KrakenRig.Attribute
                                v6 = Decode(j:GetAttribute(Attribute)) or {0, 0, 0}
                                v2 = Arm(j, u204, v5, v6)
                                if v2 ~= nil then
                                    v3 = v2.Segments[#v2.Segments]
                                    v4 = v7:Add((Instance.new("Attachment")))
                                    v4.Name = "KrakenTip"
                                    v4.WorldPosition = v2.Tip
                                    v4.Parent = v3
                                    v5 = v7:Add((Instance.new("Attachment")))
                                    v5.Name = "KrakenTipTail"
                                    v5.WorldPosition = v2.Tip + (v3.Position - v2.Tip).Unit * 22
                                    v5.Parent = v3
                                    v6 = v7:Add((Instance.new("Trail")))
                                    v6.Attachment0 = v4
                                    v6.Attachment1 = v5
                                    v6.Lifetime = 0.22
                                    v6.MinLength = 0.5
                                    v6.FaceCamera = true
                                    v6.LightEmission = 0.35
                                    v6.Color = ColorSequence.new(u108)
                                    v6.Transparency = NumberSequence.new({
                                        NumberSequenceKeypoint.new(0, 0.35),
                                        (NumberSequenceKeypoint.new(1, 1)),
                                    })
                                    v6.Enabled = false
                                    v6.Parent = v3
                                    local u188 = {Rig = v2, Sway = v2.Heading}
                                    u188.Phase = u355:NextNumber(0, 6.283185307179586)
                                    u188.Tip = v4
                                    u188.Trail = v6
                                    u196[j] = u188
                                    Attribute_2 = KrakenRig.Attribute
                                    v7:Connect(j:GetAttributeChangedSignal(Attribute_2), function() -- Line: 503 -- upvalues: KrakenRig (upval), j (val), u204 (val), u205 (val), u188 (val)
                                        local v1 = KrakenRig.Arm(j, u204, {u205}, KrakenRig.Decode(j:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0})
                                        if v1 ~= nil then
                                            u188.Rig = v1
                                        end
                                    end)
                                end
                            else
                                Part1 = v1.Motor.Part1
                                u210 = {
                                    Tilt = Vector3.new(0, 0, 0),
                                    TiltSpeed = Vector3.new(0, 0, 0),
                                    Joint = v1,
                                    Center = Part1.Position,
                                }
                            end
                        end
                    end
                    if next(u196) == nil and u210 == nil then
                        v7:Destroy()
                        return
                    end
                    local Center = if not u210 then next(u196):GetPivot().Position else u210.Center
                    local u54 = 0
                    local u55 = 1
                    local u56 = true

                    local function gainAt(a1) -- Line: 520 -- upvalues: Workspace (upval) -- types: a1: vector
                        local Position
                        local CurrentCamera = Workspace.CurrentCamera
                        if (if not CurrentCamera then nil else CurrentCamera.CFrame.Position) == nil then
                            return 0
                        end
                        local v1 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                        return 1 - v1 * v1 * (3 - v1 * 2)
                    end

                    local function shakeFor(a1, a2, a3) -- Line: 528
                        -- upvalues: GuiService (upval), Workspace (upval), u209 (val), Timing (upval)
                        -- upvalues: rumblePad (upval)
                        local v1
                        if GuiService.ReducedMotionEnabled then
                            return
                        end
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        if Position ~= nil then
                            local v2 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                            v1 = 1 - v2 * v2 * (3 - v2 * 2)
                        else
                            v1 = 0
                        end
                        if v1 <= 0.02 then
                            return
                        end
                        if a2 then
                            u209:ShakeOnce(v1 * 0.8, 3, Timing.Windup * 0.8, 0.4)
                            return
                        end
                        u209:ShakeOnce(
                            v1 * 6.5,
                            9,
                            0,
                            0.9,
                            Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                            (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                        )
                        u209:ShakeOnce(v1 * 2.6, 2.5, 0.05, 1.8)
                        if a3 and v1 >= 0.5 then
                            rumblePad((math.clamp(v1, 0, 1)))
                        end
                    end

                    local function land(a1) -- Line: 555
                        -- upvalues: Trove (upval), emitBurst (upval), u114 (upval), u290 (upval), u55 (ref)
                        -- upvalues: Audio (upval), GuiService (upval), Workspace (upval), u209 (val), rumblePad (upval)
                        -- upvalues: u210 (ref)
                        local Rig = a1.Rig
                        local u4 = Trove.new()
                        emitBurst(u4, Rig.Impact, if not Rig.Wet then u290 else u114, u55)
                        task.delay(4.5 / u55, function() -- Line: 559 -- upvalues: u4 (val)
                            u4:Destroy()
                        end)
                        Audio.Play(
                            if not Rig.Wet then 9114036511 else 9119476512,
                            Rig.Impact,
                            {MaxDistance = 2400, Volume = {1.1, 1.3}, PlaybackSpeed = {0.82, 0.92}}
                        )
                        Audio.Play(9114036511, Rig.Impact, {MaxDistance = 2400, Volume = {0.7, 0.85}, PlaybackSpeed = {0.7, 0.8}})
                        local Impact_4 = Rig.Impact
                        local v1 = #Rig.Crossings > 0
                        if not GuiService.ReducedMotionEnabled then
                            local v2
                            local CurrentCamera = Workspace.CurrentCamera
                            local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                            if Position ~= nil then
                                local v3 = math.clamp(((Position - Impact_4).Magnitude - 150) / 800, 0, 1)
                                v2 = 1 - v3 * v3 * (3 - v3 * 2)
                            else
                                v2 = 0
                            end
                            if not (v2 <= 0.02) then
                                u209:ShakeOnce(
                                    v2 * 6.5,
                                    9,
                                    0,
                                    0.9,
                                    Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                                    (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                                )
                                u209:ShakeOnce(v2 * 2.6, 2.5, 0.05, 1.8)
                                if v1 and v2 >= 0.5 then
                                    rumblePad((math.clamp(v2, 0, 1)))
                                end
                            end
                        end
                        if u210 then
                            v1 = Rig.Impact - u210.Center
                            local v4 = Vector3.new(v1.X, 0, v1.Z)
                            if 1 < v4.Magnitude then
                                v1 = u210
                                v1.TiltSpeed = v1.TiltSpeed + v4.Unit * 0.18
                            end
                        end
                    end

                    local function endSwing(a1) -- Line: 581 -- types: a1: table
                        local Swing = a1.Swing
                        if Swing then
                            Swing.Trove:Destroy()
                        end
                        a1.Swing = nil
                        a1.Trail.Enabled = false
                    end

                    local function beginSwing(a1, a2) -- Line: 590
                        -- upvalues: Trove (upval), u54 (ref), u76 (upval), u78 (upval), markDisc (upval)
                        -- upvalues: Workspace (upval), Audio (upval), DrillaWarn (upval), GuiService (upval)
                        -- upvalues: u209 (val), Timing (upval)
                        local v1, v2, v3
                        local Swing = a1.Swing
                        if Swing then
                            Swing.Trove:Destroy()
                        end
                        a1.Swing = nil
                        a1.Trail.Enabled = false
                        local v4 = Trove.new()
                        local v5 = {
                            Started = u54 - a2,
                            Trove = v4,
                            Marks = {},
                            Fills = {},
                            Whooshed = u76 <= a2,
                            Landed = u78 <= a2,
                        }
                        a1.Swing = v5
                        if u78 <= a2 then
                            return
                        end
                        for i, j in a1.Rig.Crossings do
                            v3 = Vector3.new(j.Point.X, j.Surface, j.Point.Z)
                            v1 = j.Radius * 2.5
                            table.insert(v5.Marks, (markDisc(v4, v3, v1, "KrakenMark")))
                            table.insert(v5.Fills, (markDisc(v4, v3 + Vector3.new(0, 0.05000000074505806, 0), v1, "KrakenFill")))
                        end
                        local v6 = #v5.Marks
                        if v6 > 0 then
                            local Impact = a1.Rig.Impact
                            local CurrentCamera = Workspace.CurrentCamera
                            local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                            if Position ~= nil then
                                v2 = math.clamp(((Position - Impact).Magnitude - 150) / 800, 0, 1)
                                v6 = 1 - v2 * v2 * (3 - v2 * 2)
                            else
                                v6 = 0
                            end
                            if v6 > 0 then
                                local CurrentCamera_2 = Workspace.CurrentCamera
                                local Position_2 = if not CurrentCamera_2 then nil else CurrentCamera_2.CFrame.Position
                                if Position_2 and (Position_2 - a1.Rig.Impact).Magnitude <= 700 then
                                    Audio.Play(DrillaWarn, a1.Rig.Impact, {MaxDistance = 700})
                                end
                            end
                        end
                        local Impact_2 = a1.Rig.Impact
                        if GuiService.ReducedMotionEnabled then
                            return
                        end
                        local CurrentCamera_3 = Workspace.CurrentCamera
                        local Position_3 = if not CurrentCamera_3 then nil else CurrentCamera_3.CFrame.Position
                        if Position_3 ~= nil then
                            v2 = math.clamp(((Position_3 - Impact_2).Magnitude - 150) / 800, 0, 1)
                            v5 = 1 - v2 * v2 * (3 - v2 * 2)
                        else
                            v5 = 0
                        end
                        if v5 <= 0.02 then
                            return
                        end
                        u209:ShakeOnce(v5 * 0.8, 3, Timing.Windup * 0.8, 0.4)
                    end

                    local function paintMarks(a1, a2) -- Line: 623
                        -- upvalues: u78 (upval), u90 (upval)
                        local v1
                        if #a1.Marks == 0 then
                            return
                        end
                        if u78 + 0.15 <= a2 then
                            for k, n in a1.Marks do
                                n:Destroy()
                            end
                            for m, i5 in a1.Fills do
                                i5:Destroy()
                            end
                            table.clear(a1.Marks)
                            table.clear(a1.Fills)
                            return
                        end
                        local v2 = math.clamp(a2 / u78, 0, 1)
                        local v3 = math.lerp(u90[1], u90[2], v2)
                        local v4 = if not (u78 < a2) then 0 else (a2 - u78) / 0.15
                        local v5 = (math.lerp(0.72, 0.45, v2)) + math.sin(a2 * v3) * 0.12
                        for i, j in a1.Marks do
                            v1 = math.clamp(v5, 0, 1)
                            j.Transparency = math.lerp(v1, 1, v4)
                            v3 = a1.Fills[i]
                            v1 = math.max(j.Size.Y * v2, 0.2)
                            v3.Size = Vector3.new(0.2, v1, v1)
                            v3.Transparency = math.lerp(0.35, 1, v4)
                        end
                    end

                    local function swingAngles(a1, a2) -- Line: 652
                        -- upvalues: Raise (upval), KrakenRig (upval), Timing (upval), u76 (upval), u78 (upval)
                        -- upvalues: u80 (upval), u82 (upval)
                        local v1, v2, v3, v4, v5, v6, v7, v8
                        local Rig = a1.Rig
                        local v9 = table.create(#Rig.Joints, 0)
                        local v10 = #Rig.Joints
                        local v11 = a2
                        for i = 1, v10 do
                            v7 = Raise
                            v2 = #Raise
                            v6 = v7[math.min(i, v2)]
                            v7 = KrakenRig.StrikeAngle(Rig, i)
                            if v11 < Timing.Windup then
                                v8 = v6 * (-(math.cos(3.141592653589793 * (math.clamp(v11 / Timing.Windup, 0, 1))) - 1) / 2)
                            elseif v11 < u76 then
                                v1 = (v11 - Timing.Windup) / Timing.Hold
                                v8 = v6 * (1 + 0.06000000000000005 * v1) + math.sin(v11 * 46 + i) * 0.7 * v1
                            elseif v11 < u78 + (i - 1) * 0.04 then
                                v1 = (v11 - u76 - (i - 1) * 0.04) / Timing.Strike
                                v3 = v6 * 1.06
                                v5 = math.clamp(v1, 0, 1)
                                v8 = math.lerp(v3, v7, v5 * v5 * v5)
                            elseif v11 < u80 then
                                v1 = math.clamp((v11 - u78) / Timing.Settle, 0, 1)
                                v8 = if i ~= 1 then v7 + math.sin(v1 * 3.141592653589793 * 2) * 7 * (1 - v1) else v7 - math.sin(v1 * 3.141592653589793) * 3
                            elseif not (v11 < u82) then
                                v4 = math.clamp((v11 - u82) / Timing.Recover, 0, 1) - 1
                                v8 = v7 * (1 - (v4 * 2.4 * v4 * v4 + 1 + v4 * 1.4 * v4))
                            else
                                v8 = v7
                            end
                            v9[i] = v8
                        end
                        return v9
                    end

                    local function poseArm(a1) -- Line: 685
                        -- upvalues: u54 (ref), u84 (upval), swingAngles (val), Timing (upval), paintMarks (val)
                        -- upvalues: u76 (upval), Audio (upval), u78 (upval), land (val), u64 (upval), u68 (upval)
                        -- upvalues: KrakenRig (upval)
                        local v1, v2, v3, v4, v5
                        local Rig = a1.Rig
                        local Swing = a1.Swing
                        local v6 = 1
                        local v7 = nil
                        if Swing then
                            local v8 = u54 - Swing.Started
                            if not (u84 <= v8) then
                                v7 = swingAngles(a1, v8)
                                v6 = math.lerp(1, 0.2, (math.clamp(math.min(v8 / Timing.Windup, (u84 - v8) / Timing.Recover, 1), 0, 1)))
                                paintMarks(Swing, v8)
                                if not Swing.Whooshed and u76 <= v8 then
                                    Swing.Whooshed = true
                                    a1.Trail.Enabled = true
                                    Audio.Play(9113077334, a1.Tip, {MaxDistance = 2400, Volume = 0.9, PlaybackSpeed = {0.75, 0.85}})
                                end
                                if not Swing.Landed and u78 <= v8 then
                                    Swing.Landed = true
                                    land(a1)
                                end
                                if a1.Trail.Enabled and u78 + 0.2 <= v8 then
                                    a1.Trail.Enabled = false
                                end
                            else
                                local Swing_2 = a1.Swing
                                if Swing_2 then
                                    Swing_2.Trove:Destroy()
                                end
                                a1.Swing = nil
                                a1.Trail.Enabled = false
                            end
                        end
                        local v9 = nil
                        local v10 = nil
                        for i, j in Rig.Joints, v9, v10 do
                            v5 = u54 * 3.141592653589793 * 2 / 5.6 + a1.Phase - i * 0.75
                            v1 = u54 * 3.141592653589793 * 2 / 7.3 + a1.Phase * 1.7 - i * 0.75
                            v3 = u64
                            v4 = #u64
                            v2 = v3[math.min(i, v4)] * math.sin(v5) * v6
                            v3 = u68
                            v4 = #u68
                            v5 = v3[math.min(i, v4)] * math.sin(v1) * v6
                            if v7 then
                                v2 = v2 + v7[i]
                            end
                            v1 = (CFrame.fromAxisAngle(Rig.Curl, (math.rad(v2)))) * CFrame.fromAxisAngle(a1.Sway, (math.rad(v5)))
                            KrakenRig.Drive(j, KrakenRig.About(j.Pivot, v1))
                        end
                    end

                    local function poseHead(a1) -- Line: 734
                        -- upvalues: u210 (ref), u54 (ref), KrakenRig (upval)
                        local v1 = u210
                        if v1 == nil then
                            return
                        end
                        v1.TiltSpeed = v1.TiltSpeed + (-v1.Tilt * 18 - v1.TiltSpeed * 4.5) * a1
                        v1.Tilt = v1.Tilt + v1.TiltSpeed * a1
                        local v2 = u54 * 3.141592653589793 * 2
                        local v3 = CFrame.Angles(
                            math.rad((math.sin(v2 / 8.32)) * 1.1),
                            math.rad((math.sin(v2 / 13.440000000000001 + 1)) * 1.6),
                            (math.rad((math.sin(v2 / 10.88 + 2)) * 1.1))
                        )
                        local identity = CFrame.identity
                        if 0.0001 < v1.Tilt.Magnitude then
                            local fromAxisAngle = CFrame.fromAxisAngle
                            local Unit = v1.Tilt.Unit
                            identity = fromAxisAngle(Vector3.new(0, 1, 0):Cross(Unit), v1.Tilt.Magnitude)
                        end
                        KrakenRig.Drive(
                            v1.Joint,
                            (CFrame.new(0, math.sin(v2 / 6.4) * 3.5, 0)) * KrakenRig.About(v1.Joint.Pivot, identity * v3)
                        )
                    end

                    local function rest() -- Line: 761 -- upvalues: u196 (val), u210 (ref)
                        local Swing
                        local v1 = nil
                        local v2 = nil
                        for i, j in u196, v1, v2 do
                            Swing = j.Swing
                            if Swing then
                                Swing.Trove:Destroy()
                            end
                            j.Swing = nil
                            j.Trail.Enabled = false
                            for k, n in j.Rig.Joints do
                                n.Motor.Transform = CFrame.identity
                            end
                        end
                        if u210 then
                            u210.Joint.Motor.Transform = CFrame.identity
                        end
                    end

                    local function nearby() -- Line: 773 -- upvalues: Workspace (upval), Center (val)
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        local v1 = false
                        if Position ~= nil then
                            v1 = (Position - Center).Magnitude <= 2800
                        end
                        return v1
                    end

                    v7:Connect(Remotes.MountRace.PowerUpMoment.OnClientEvent, function(a1, a2, a3) -- Line: 780
                        -- upvalues: u196 (val), Workspace (upval), Center (val), u84 (upval), beginSwing (val)
                        if a1 == "Kraken" and typeof(a2) == "Instance" and type(a3) == "number" then
                            local v1 = u196[a2]
                            if v1 ~= nil then
                                local CurrentCamera = Workspace.CurrentCamera
                                local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                                local v2 = false
                                if Position ~= nil then
                                    v2 = (Position - Center).Magnitude <= 2800
                                end
                                if v2 then
                                    v2 = math.max(0, (Workspace:GetServerTimeNow()) - a3)
                                    if v2 < u84 then
                                        beginSwing(v1, v2)
                                    end
                                    return
                                end
                            end
                            return
                        end
                    end)
                    v7:Connect(RunService.PreSimulation, function(a1) -- Line: 799
                        -- upvalues: Workspace (upval), Center (val), u56 (ref), rest (val), u205 (val), u55 (ref)
                        -- upvalues: u54 (ref), u196 (val), poseArm (val), poseHead (val)
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        local v1 = false
                        if Position ~= nil then
                            v1 = (Position - Center).Magnitude <= 2800
                        end
                        if not v1 then
                            if not u56 then
                                u56 = true
                                rest()
                            end
                            return
                        end
                        u56 = false
                        local Attribute = u205:GetAttribute("KrakenSpeed")
                        u55 = if type(Attribute) ~= "number" then 1 else if not (Attribute > 0) then 1 else Attribute
                        local v2 = a1 * u55
                        u54 = u54 + v2
                        for i, j in u196 do
                            poseArm(j)
                        end
                        poseHead((math.min(v2, 0.05)))
                    end)
                    v7:AttachToInstance(u205)
                    return
                end
            end)
        end
    end)
    for i, j in CollectionService:GetTagged(MountRace.TrackTag) do
        if u0[j] == nil and j:IsDescendantOf(Workspace) then
            u0[j] = true
            spawn = task.spawn
            local u35 = false
            spawn(function() -- Line: 430
                -- upvalues: findTrackParts (upval), j (val), u35 (val), Trove (upval), CameraShaker (upval)
                -- upvalues: CameraShakerDriver (upval), KrakenRig (upval), u108 (upval), u355 (upval)
                -- upvalues: Workspace (upval), GuiService (upval), Timing (upval), rumblePad (upval), emitBurst (upval)
                -- upvalues: u114 (upval), u290 (upval), Audio (upval), u76 (upval), u78 (upval), markDisc (upval)
                -- upvalues: DrillaWarn (upval), u90 (upval), Raise (upval), u80 (upval), u82 (upval), u84 (upval)
                -- upvalues: u64 (upval), u68 (upval), Remotes (upval), RunService (upval)
                local u205, u204 = findTrackParts(j, u35)
                if u205 ~= nil and u204 ~= nil then
                    local Arm, Attribute, Attribute_2, Decode, Part1, poseOf, v1, v2, v3, v4, v5, v6
                    local v7 = Trove.new()
                    local u209 = CameraShaker.new()
                    CameraShakerDriver.Start(u209, Enum.RenderPriority.Last.Value)
                    v7:Add(function() -- Line: 439 -- upvalues: CameraShakerDriver (upval), u209 (val)
                        CameraShakerDriver.Stop(u209)
                    end)
                    local u196 = {}
                    local u210 = nil
                    for i, j2 in u205:GetChildren() do
                        if j2:IsA("Model") then
                            v1 = KrakenRig.Head(j2)
                            if not v1 then
                                function poseOf() -- Line: 461 -- upvalues: KrakenRig (upval), j2 (val)
                                    return KrakenRig.Decode(j2:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0}
                                end

                                Arm = KrakenRig.Arm
                                v5 = {u205}
                                Decode = KrakenRig.Decode
                                Attribute = KrakenRig.Attribute
                                v6 = Decode(j2:GetAttribute(Attribute)) or {0, 0, 0}
                                v2 = Arm(j2, u204, v5, v6)
                                if v2 ~= nil then
                                    v3 = v2.Segments[#v2.Segments]
                                    v4 = v7:Add((Instance.new("Attachment")))
                                    v4.Name = "KrakenTip"
                                    v4.WorldPosition = v2.Tip
                                    v4.Parent = v3
                                    v5 = v7:Add((Instance.new("Attachment")))
                                    v5.Name = "KrakenTipTail"
                                    v5.WorldPosition = v2.Tip + (v3.Position - v2.Tip).Unit * 22
                                    v5.Parent = v3
                                    v6 = v7:Add((Instance.new("Trail")))
                                    v6.Attachment0 = v4
                                    v6.Attachment1 = v5
                                    v6.Lifetime = 0.22
                                    v6.MinLength = 0.5
                                    v6.FaceCamera = true
                                    v6.LightEmission = 0.35
                                    v6.Color = ColorSequence.new(u108)
                                    v6.Transparency = NumberSequence.new({
                                        NumberSequenceKeypoint.new(0, 0.35),
                                        (NumberSequenceKeypoint.new(1, 1)),
                                    })
                                    v6.Enabled = false
                                    v6.Parent = v3
                                    local u188 = {Rig = v2, Sway = v2.Heading}
                                    u188.Phase = u355:NextNumber(0, 6.283185307179586)
                                    u188.Tip = v4
                                    u188.Trail = v6
                                    u196[j2] = u188
                                    Attribute_2 = KrakenRig.Attribute
                                    v7:Connect(j2:GetAttributeChangedSignal(Attribute_2), function() -- Line: 503 -- upvalues: KrakenRig (upval), j2 (val), u204 (val), u205 (val), u188 (val)
                                        local v1 = KrakenRig.Arm(j2, u204, {u205}, KrakenRig.Decode(j2:GetAttribute(KrakenRig.Attribute)) or {0, 0, 0})
                                        if v1 ~= nil then
                                            u188.Rig = v1
                                        end
                                    end)
                                end
                            else
                                Part1 = v1.Motor.Part1
                                u210 = {
                                    Tilt = Vector3.new(0, 0, 0),
                                    TiltSpeed = Vector3.new(0, 0, 0),
                                    Joint = v1,
                                    Center = Part1.Position,
                                }
                            end
                        end
                    end
                    if next(u196) == nil and u210 == nil then
                        v7:Destroy()
                        return
                    end
                    local Center = if not u210 then next(u196):GetPivot().Position else u210.Center
                    local u54 = 0
                    local u55 = 1
                    local u56 = true

                    local function gainAt(a1) -- Line: 520 -- upvalues: Workspace (upval) -- types: a1: vector
                        local Position
                        local CurrentCamera = Workspace.CurrentCamera
                        if (if not CurrentCamera then nil else CurrentCamera.CFrame.Position) == nil then
                            return 0
                        end
                        local v1 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                        return 1 - v1 * v1 * (3 - v1 * 2)
                    end

                    local function shakeFor(a1, a2, a3) -- Line: 528
                        -- upvalues: GuiService (upval), Workspace (upval), u209 (val), Timing (upval)
                        -- upvalues: rumblePad (upval)
                        local v1
                        if GuiService.ReducedMotionEnabled then
                            return
                        end
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        if Position ~= nil then
                            local v2 = math.clamp(((Position - a1).Magnitude - 150) / 800, 0, 1)
                            v1 = 1 - v2 * v2 * (3 - v2 * 2)
                        else
                            v1 = 0
                        end
                        if v1 <= 0.02 then
                            return
                        end
                        if a2 then
                            u209:ShakeOnce(v1 * 0.8, 3, Timing.Windup * 0.8, 0.4)
                            return
                        end
                        u209:ShakeOnce(
                            v1 * 6.5,
                            9,
                            0,
                            0.9,
                            Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                            (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                        )
                        u209:ShakeOnce(v1 * 2.6, 2.5, 0.05, 1.8)
                        if a3 and v1 >= 0.5 then
                            rumblePad((math.clamp(v1, 0, 1)))
                        end
                    end

                    local function land(a1) -- Line: 555
                        -- upvalues: Trove (upval), emitBurst (upval), u114 (upval), u290 (upval), u55 (ref)
                        -- upvalues: Audio (upval), GuiService (upval), Workspace (upval), u209 (val), rumblePad (upval)
                        -- upvalues: u210 (ref)
                        local Rig = a1.Rig
                        local u4 = Trove.new()
                        emitBurst(u4, Rig.Impact, if not Rig.Wet then u290 else u114, u55)
                        task.delay(4.5 / u55, function() -- Line: 559 -- upvalues: u4 (val)
                            u4:Destroy()
                        end)
                        Audio.Play(
                            if not Rig.Wet then 9114036511 else 9119476512,
                            Rig.Impact,
                            {MaxDistance = 2400, Volume = {1.1, 1.3}, PlaybackSpeed = {0.82, 0.92}}
                        )
                        Audio.Play(9114036511, Rig.Impact, {MaxDistance = 2400, Volume = {0.7, 0.85}, PlaybackSpeed = {0.7, 0.8}})
                        local Impact_4 = Rig.Impact
                        local v1 = #Rig.Crossings > 0
                        if not GuiService.ReducedMotionEnabled then
                            local v2
                            local CurrentCamera = Workspace.CurrentCamera
                            local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                            if Position ~= nil then
                                local v3 = math.clamp(((Position - Impact_4).Magnitude - 150) / 800, 0, 1)
                                v2 = 1 - v3 * v3 * (3 - v3 * 2)
                            else
                                v2 = 0
                            end
                            if not (v2 <= 0.02) then
                                u209:ShakeOnce(
                                    v2 * 6.5,
                                    9,
                                    0,
                                    0.9,
                                    Vector3.new(0.3499999940395355, 0.5, 0.3499999940395355),
                                    (Vector3.new(1, 0.550000011920929, 0.44999998807907104))
                                )
                                u209:ShakeOnce(v2 * 2.6, 2.5, 0.05, 1.8)
                                if v1 and v2 >= 0.5 then
                                    rumblePad((math.clamp(v2, 0, 1)))
                                end
                            end
                        end
                        if u210 then
                            v1 = Rig.Impact - u210.Center
                            local v4 = Vector3.new(v1.X, 0, v1.Z)
                            if 1 < v4.Magnitude then
                                v1 = u210
                                v1.TiltSpeed = v1.TiltSpeed + v4.Unit * 0.18
                            end
                        end
                    end

                    local function endSwing(a1) -- Line: 581 -- types: a1: table
                        local Swing = a1.Swing
                        if Swing then
                            Swing.Trove:Destroy()
                        end
                        a1.Swing = nil
                        a1.Trail.Enabled = false
                    end

                    local function beginSwing(a1, a2) -- Line: 590
                        -- upvalues: Trove (upval), u54 (ref), u76 (upval), u78 (upval), markDisc (upval)
                        -- upvalues: Workspace (upval), Audio (upval), DrillaWarn (upval), GuiService (upval)
                        -- upvalues: u209 (val), Timing (upval)
                        local v1, v2, v3
                        local Swing = a1.Swing
                        if Swing then
                            Swing.Trove:Destroy()
                        end
                        a1.Swing = nil
                        a1.Trail.Enabled = false
                        local v4 = Trove.new()
                        local v5 = {
                            Started = u54 - a2,
                            Trove = v4,
                            Marks = {},
                            Fills = {},
                            Whooshed = u76 <= a2,
                            Landed = u78 <= a2,
                        }
                        a1.Swing = v5
                        if u78 <= a2 then
                            return
                        end
                        for i, j in a1.Rig.Crossings do
                            v3 = Vector3.new(j.Point.X, j.Surface, j.Point.Z)
                            v1 = j.Radius * 2.5
                            table.insert(v5.Marks, (markDisc(v4, v3, v1, "KrakenMark")))
                            table.insert(v5.Fills, (markDisc(v4, v3 + Vector3.new(0, 0.05000000074505806, 0), v1, "KrakenFill")))
                        end
                        local v6 = #v5.Marks
                        if v6 > 0 then
                            local Impact = a1.Rig.Impact
                            local CurrentCamera = Workspace.CurrentCamera
                            local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                            if Position ~= nil then
                                v2 = math.clamp(((Position - Impact).Magnitude - 150) / 800, 0, 1)
                                v6 = 1 - v2 * v2 * (3 - v2 * 2)
                            else
                                v6 = 0
                            end
                            if v6 > 0 then
                                local CurrentCamera_2 = Workspace.CurrentCamera
                                local Position_2 = if not CurrentCamera_2 then nil else CurrentCamera_2.CFrame.Position
                                if Position_2 and (Position_2 - a1.Rig.Impact).Magnitude <= 700 then
                                    Audio.Play(DrillaWarn, a1.Rig.Impact, {MaxDistance = 700})
                                end
                            end
                        end
                        local Impact_2 = a1.Rig.Impact
                        if GuiService.ReducedMotionEnabled then
                            return
                        end
                        local CurrentCamera_3 = Workspace.CurrentCamera
                        local Position_3 = if not CurrentCamera_3 then nil else CurrentCamera_3.CFrame.Position
                        if Position_3 ~= nil then
                            v2 = math.clamp(((Position_3 - Impact_2).Magnitude - 150) / 800, 0, 1)
                            v5 = 1 - v2 * v2 * (3 - v2 * 2)
                        else
                            v5 = 0
                        end
                        if v5 <= 0.02 then
                            return
                        end
                        u209:ShakeOnce(v5 * 0.8, 3, Timing.Windup * 0.8, 0.4)
                    end

                    local function paintMarks(a1, a2) -- Line: 623
                        -- upvalues: u78 (upval), u90 (upval)
                        local v1
                        if #a1.Marks == 0 then
                            return
                        end
                        if u78 + 0.15 <= a2 then
                            for k, n in a1.Marks do
                                n:Destroy()
                            end
                            for m, i5 in a1.Fills do
                                i5:Destroy()
                            end
                            table.clear(a1.Marks)
                            table.clear(a1.Fills)
                            return
                        end
                        local v2 = math.clamp(a2 / u78, 0, 1)
                        local v3 = math.lerp(u90[1], u90[2], v2)
                        local v4 = if not (u78 < a2) then 0 else (a2 - u78) / 0.15
                        local v5 = (math.lerp(0.72, 0.45, v2)) + math.sin(a2 * v3) * 0.12
                        for i, j in a1.Marks do
                            v1 = math.clamp(v5, 0, 1)
                            j.Transparency = math.lerp(v1, 1, v4)
                            v3 = a1.Fills[i]
                            v1 = math.max(j.Size.Y * v2, 0.2)
                            v3.Size = Vector3.new(0.2, v1, v1)
                            v3.Transparency = math.lerp(0.35, 1, v4)
                        end
                    end

                    local function swingAngles(a1, a2) -- Line: 652
                        -- upvalues: Raise (upval), KrakenRig (upval), Timing (upval), u76 (upval), u78 (upval)
                        -- upvalues: u80 (upval), u82 (upval)
                        local v1, v2, v3, v4, v5, v6, v7, v8
                        local Rig = a1.Rig
                        local v9 = table.create(#Rig.Joints, 0)
                        local v10 = #Rig.Joints
                        local v11 = a2
                        for i = 1, v10 do
                            v7 = Raise
                            v2 = #Raise
                            v6 = v7[math.min(i, v2)]
                            v7 = KrakenRig.StrikeAngle(Rig, i)
                            if v11 < Timing.Windup then
                                v8 = v6 * (-(math.cos(3.141592653589793 * (math.clamp(v11 / Timing.Windup, 0, 1))) - 1) / 2)
                            elseif v11 < u76 then
                                v1 = (v11 - Timing.Windup) / Timing.Hold
                                v8 = v6 * (1 + 0.06000000000000005 * v1) + math.sin(v11 * 46 + i) * 0.7 * v1
                            elseif v11 < u78 + (i - 1) * 0.04 then
                                v1 = (v11 - u76 - (i - 1) * 0.04) / Timing.Strike
                                v3 = v6 * 1.06
                                v5 = math.clamp(v1, 0, 1)
                                v8 = math.lerp(v3, v7, v5 * v5 * v5)
                            elseif v11 < u80 then
                                v1 = math.clamp((v11 - u78) / Timing.Settle, 0, 1)
                                v8 = if i ~= 1 then v7 + math.sin(v1 * 3.141592653589793 * 2) * 7 * (1 - v1) else v7 - math.sin(v1 * 3.141592653589793) * 3
                            elseif not (v11 < u82) then
                                v4 = math.clamp((v11 - u82) / Timing.Recover, 0, 1) - 1
                                v8 = v7 * (1 - (v4 * 2.4 * v4 * v4 + 1 + v4 * 1.4 * v4))
                            else
                                v8 = v7
                            end
                            v9[i] = v8
                        end
                        return v9
                    end

                    local function poseArm(a1) -- Line: 685
                        -- upvalues: u54 (ref), u84 (upval), swingAngles (val), Timing (upval), paintMarks (val)
                        -- upvalues: u76 (upval), Audio (upval), u78 (upval), land (val), u64 (upval), u68 (upval)
                        -- upvalues: KrakenRig (upval)
                        local v1, v2, v3, v4, v5
                        local Rig = a1.Rig
                        local Swing = a1.Swing
                        local v6 = 1
                        local v7 = nil
                        if Swing then
                            local v8 = u54 - Swing.Started
                            if not (u84 <= v8) then
                                v7 = swingAngles(a1, v8)
                                v6 = math.lerp(1, 0.2, (math.clamp(math.min(v8 / Timing.Windup, (u84 - v8) / Timing.Recover, 1), 0, 1)))
                                paintMarks(Swing, v8)
                                if not Swing.Whooshed and u76 <= v8 then
                                    Swing.Whooshed = true
                                    a1.Trail.Enabled = true
                                    Audio.Play(9113077334, a1.Tip, {MaxDistance = 2400, Volume = 0.9, PlaybackSpeed = {0.75, 0.85}})
                                end
                                if not Swing.Landed and u78 <= v8 then
                                    Swing.Landed = true
                                    land(a1)
                                end
                                if a1.Trail.Enabled and u78 + 0.2 <= v8 then
                                    a1.Trail.Enabled = false
                                end
                            else
                                local Swing_2 = a1.Swing
                                if Swing_2 then
                                    Swing_2.Trove:Destroy()
                                end
                                a1.Swing = nil
                                a1.Trail.Enabled = false
                            end
                        end
                        local v9 = nil
                        local v10 = nil
                        for i, j in Rig.Joints, v9, v10 do
                            v5 = u54 * 3.141592653589793 * 2 / 5.6 + a1.Phase - i * 0.75
                            v1 = u54 * 3.141592653589793 * 2 / 7.3 + a1.Phase * 1.7 - i * 0.75
                            v3 = u64
                            v4 = #u64
                            v2 = v3[math.min(i, v4)] * math.sin(v5) * v6
                            v3 = u68
                            v4 = #u68
                            v5 = v3[math.min(i, v4)] * math.sin(v1) * v6
                            if v7 then
                                v2 = v2 + v7[i]
                            end
                            v1 = (CFrame.fromAxisAngle(Rig.Curl, (math.rad(v2)))) * CFrame.fromAxisAngle(a1.Sway, (math.rad(v5)))
                            KrakenRig.Drive(j, KrakenRig.About(j.Pivot, v1))
                        end
                    end

                    local function poseHead(a1) -- Line: 734
                        -- upvalues: u210 (ref), u54 (ref), KrakenRig (upval)
                        local v1 = u210
                        if v1 == nil then
                            return
                        end
                        v1.TiltSpeed = v1.TiltSpeed + (-v1.Tilt * 18 - v1.TiltSpeed * 4.5) * a1
                        v1.Tilt = v1.Tilt + v1.TiltSpeed * a1
                        local v2 = u54 * 3.141592653589793 * 2
                        local v3 = CFrame.Angles(
                            math.rad((math.sin(v2 / 8.32)) * 1.1),
                            math.rad((math.sin(v2 / 13.440000000000001 + 1)) * 1.6),
                            (math.rad((math.sin(v2 / 10.88 + 2)) * 1.1))
                        )
                        local identity = CFrame.identity
                        if 0.0001 < v1.Tilt.Magnitude then
                            local fromAxisAngle = CFrame.fromAxisAngle
                            local Unit = v1.Tilt.Unit
                            identity = fromAxisAngle(Vector3.new(0, 1, 0):Cross(Unit), v1.Tilt.Magnitude)
                        end
                        KrakenRig.Drive(
                            v1.Joint,
                            (CFrame.new(0, math.sin(v2 / 6.4) * 3.5, 0)) * KrakenRig.About(v1.Joint.Pivot, identity * v3)
                        )
                    end

                    local function rest() -- Line: 761 -- upvalues: u196 (val), u210 (ref)
                        local Swing
                        local v1 = nil
                        local v2 = nil
                        for i, j in u196, v1, v2 do
                            Swing = j.Swing
                            if Swing then
                                Swing.Trove:Destroy()
                            end
                            j.Swing = nil
                            j.Trail.Enabled = false
                            for k, n in j.Rig.Joints do
                                n.Motor.Transform = CFrame.identity
                            end
                        end
                        if u210 then
                            u210.Joint.Motor.Transform = CFrame.identity
                        end
                    end

                    local function nearby() -- Line: 773 -- upvalues: Workspace (upval), Center (val)
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        local v1 = false
                        if Position ~= nil then
                            v1 = (Position - Center).Magnitude <= 2800
                        end
                        return v1
                    end

                    v7:Connect(Remotes.MountRace.PowerUpMoment.OnClientEvent, function(a1, a2, a3) -- Line: 780
                        -- upvalues: u196 (val), Workspace (upval), Center (val), u84 (upval), beginSwing (val)
                        if a1 == "Kraken" and typeof(a2) == "Instance" and type(a3) == "number" then
                            local v1 = u196[a2]
                            if v1 ~= nil then
                                local CurrentCamera = Workspace.CurrentCamera
                                local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                                local v2 = false
                                if Position ~= nil then
                                    v2 = (Position - Center).Magnitude <= 2800
                                end
                                if v2 then
                                    v2 = math.max(0, (Workspace:GetServerTimeNow()) - a3)
                                    if v2 < u84 then
                                        beginSwing(v1, v2)
                                    end
                                    return
                                end
                            end
                            return
                        end
                    end)
                    v7:Connect(RunService.PreSimulation, function(a1) -- Line: 799
                        -- upvalues: Workspace (upval), Center (val), u56 (ref), rest (val), u205 (val), u55 (ref)
                        -- upvalues: u54 (ref), u196 (val), poseArm (val), poseHead (val)
                        local CurrentCamera = Workspace.CurrentCamera
                        local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
                        local v1 = false
                        if Position ~= nil then
                            v1 = (Position - Center).Magnitude <= 2800
                        end
                        if not v1 then
                            if not u56 then
                                u56 = true
                                rest()
                            end
                            return
                        end
                        u56 = false
                        local Attribute = u205:GetAttribute("KrakenSpeed")
                        u55 = if type(Attribute) ~= "number" then 1 else if not (Attribute > 0) then 1 else Attribute
                        local v2 = a1 * u55
                        u54 = u54 + v2
                        for i, j in u196 do
                            poseArm(j)
                        end
                        poseHead((math.min(v2, 0.05)))
                    end)
                    v7:AttachToInstance(u205)
                    return
                end
            end)
        end
    end
end

return v8