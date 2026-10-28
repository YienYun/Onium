-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Drain
-- Decompile time: 68.58 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Depths = require(script.Parent.Depths)
local Double = require(script.Parent.Double)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Hands = require(script.Parent.Hands)
local Kit = require(script.Parent.Kit)
local Overlay = require(script.Parent.Overlay)
local Score = require(script.Parent.Score)
local SewerCave = require(ReplicatedStorage.Shared.Util.SewerCave)
local Splash = require(script.Parent.Splash)
local Stage = require(script.Parent.Stage)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u76 = CFrame.new(6200, 30000, 20900)
local u81 = Color3.fromRGB(215, 250, 245)
local u86 = Color3.fromRGB(70, 176, 138)
local u91 = Color3.fromRGB(8, 52, 46)
local u96 = Color3.fromRGB(170, 255, 236)
local u102 = table.freeze({["1"] = 90, ["2"] = 70, ["3"] = 55})
local u108 = table.freeze({["1"] = 360, ["2"] = 300, ["3"] = 240})
local u114 = table.freeze({["1"] = -6, ["2"] = -3, ["3"] = 0})
local Looks = Kit.Looks
local u116 = false
local u117 = nil
local v1 = {}

local function eyeOf(a1) -- Line: 125
    local Whirlpool = a1.Context.Whirlpool
    if Whirlpool ~= nil and Whirlpool.Parent ~= nil then
        return Whirlpool:GetBoundingBox().Position, Whirlpool
    end
    return a1.Root.Position - Vector3.new(0, 4, 0), nil
end

local function surfaceBelow(a1, a2, a3) -- Line: 134 -- upvalues: Workspace (val) -- types: a2: vector, a3: number
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = {a1.Character, a1.Folder}
    v1.RespectCanCollide = false
    local v2 = Workspace:Raycast(Vector3.new(a2.X, a3, a2.Z), Vector3.new(0, -80, 0), v1)
    if v2 then
        return v2.Position.Y
    end
    return a2.Y
end

local function cloneRings(a1, a2, a3) -- Line: 143 -- types: a2: userdata?, a3: vector
    local Archivable, v1, v2
    local v3 = {}
    if a2 == nil then
        return v3
    end
    local v4 = CFrame.new(a3)
    local v5 = {"1", "2", "3"}
    local v6 = nil
    local v7 = nil
    local v8, v9 = a2, a1
    for i, j in v5, v6, v7 do
        v1 = v8:FindFirstChild(j)
        if v1 ~= nil then
            for k, n in v1:GetDescendants() do
                if n:IsA("BasePart") then
                    Archivable = n.Archivable
                    n.Archivable = true
                    v2 = n:Clone()
                    n.Archivable = Archivable
                    for m, i5 in v2:GetChildren() do
                        if i5:IsA("LuaSourceContainer") then
                            i5:Destroy()
                        end
                    end
                    v2.Anchored = true
                    v2.CanCollide = false
                    v2.CanQuery = false
                    v2.CanTouch = false
                    v2.Parent = v9.Folder
                    v9.Scenery:Add(v2)
                    n.LocalTransparencyModifier = 1
                    v9.Scenery:Add(function() -- Line: 174 -- upvalues: n (val)
                        n.LocalTransparencyModifier = 0
                    end)
                    table.insert(v3, {
                        Angle = 0,
                        Part = v2,
                        Original = n,
                        Offset = v4:ToObjectSpace(n.CFrame),
                        Folder = j,
                    })
                end
            end
        end
    end
    return v3
end

local function stepRings(a1, a2, a3, a4) -- Line: 189
    -- upvalues: u102 (val), u108 (val), u114 (val)
    local Angle, v1, v2, v3
    local State = a1.State
    for i, j in State.Rings do
        v3 = u102[j.Folder] or 60
        v1 = u108[j.Folder] or 240
        Angle = j.Angle
        v2 = math.lerp(v3, v1, a3)
        j.Angle = Angle + math.rad(v2) * a2
        v1 = (u114[j.Folder] or 0) * a4
        j.Part.CFrame = (CFrame.new(State.Eye + Vector3.new(0, v1, 0))) * CFrame.Angles(0, j.Angle, 0) * j.Offset
        j.Original.LocalTransparencyModifier = 1
    end
end

local function dropRings(a1) -- Line: 205
    local State = a1.State
    for i, j in State.Rings do
        j.Part:Destroy()
        j.Original.LocalTransparencyModifier = 0
    end
    State.Rings = {}
end

local function footTrail(a1) -- Line: 214 -- upvalues: Kit (val)
    local Attachment, Attachment_2, Trail, v1
    local v2 = {}
    local Double = a1.Double
    if Double == nil then
        return v2
    end
    for i, j in {"LeftFoot", "RightFoot", "Left Leg", "Right Leg"} do
        v1 = Double.Model:FindFirstChild(j)
        if v1 ~= nil and v1:IsA("BasePart") then
            Attachment = Instance.new("Attachment")
            Attachment.Position = Vector3.new(-0.5, -v1.Size.Y / 2, 0)
            Attachment.Parent = v1
            Attachment_2 = Instance.new("Attachment")
            Attachment_2.Position = Vector3.new(0.5, -v1.Size.Y / 2, 0)
            Attachment_2.Parent = v1
            Trail = Instance.new("Trail")
            Trail.Attachment0 = Attachment
            Trail.Attachment1 = Attachment_2
            Trail.Lifetime = 0.35
            Trail.MinLength = 0.05
            Trail.FaceCamera = true
            Trail.LightEmission = 0.4
            Trail.Color = ColorSequence.new(Kit.Foam)
            Trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), (NumberSequenceKeypoint.new(1, 1))})
            Trail.WidthScale = NumberSequence.new(1, 0)
            Trail.Parent = v1
            table.insert(v2, Trail)
        end
    end
    return v2
end

local function limb(a1, a2) -- Line: 250 -- types: a2: table
    local v1
    local Double = a1.Double
    if Double == nil then
        return nil
    end
    for i, j in a2 do
        v1 = Double.Model:FindFirstChild(j)
        if v1 ~= nil and v1:IsA("BasePart") then
            return v1
        end
    end
    return nil
end

local function gripFrame(a1, a2, a3) -- Line: 264 -- types: a1: vector, a2: vector, a3: vector
    local v1 = a1 - a2
    if v1.Magnitude < 0.01 then
        v1 = Vector3.new(0, 1, 0)
    end
    local Unit = v1.Unit
    local v2 = a3 - a1
    v2 = v2 - Unit * v2:Dot(Unit)
    if v2.Magnitude < 0.01 then
        v2 = if not ((math.abs(Unit.Y)) < 0.9) then Vector3.new(1, 0, 0) else Vector3.new(0, 1, 0)
    end
    return CFrame.lookAt(a1, a1 + v2.Unit, Unit)
end

local function setLook(a1, a2, a3, a4) -- Line: 278 -- upvalues: Kit (val) -- types: a4: number
    Kit.Mix(a1.Grade.Look, a2, a3, a4)
end

local function cameraIgnore(a1) -- Line: 282
    local v1 = {a1.Character, a1.Folder}
    local Whirlpool = a1.Context.Whirlpool
    if Whirlpool then
        table.insert(v1, Whirlpool)
    end
    return v1
end

local function heartbeat(a1, a2, a3) -- Line: 291 -- upvalues: Score (val) -- types: a2: number, a3: number
    local State = a1.State
    if State.NextBeat <= a2 then
        State.NextBeat = a2 + a3
        State.LubAt = a2
        Score.Play(a1.Score, "Thump", 0.3, 0.55)
        Score.Play(a1.Score, "Blub", 0.22, a1.Score.Random:NextNumber(0.95, 1.2))
        a1.Trove:Add((task.delay(0.16, function() -- Line: 298 -- upvalues: Score (upval), a1 (val)
            Score.Play(a1.Score, "Thump", 0.17, 0.64)
        end)))
    end
    return (math.exp(-(a2 - State.LubAt) * 9))
end

local function caveTargets(a1) -- Line: 305 -- upvalues: Stage (val)
    local v1, v2
    local Position = a1.Context.Surface.Position
    local v3 = Stage.CaveFlange()
    if v3 == nil then
        v1 = Position + Vector3.new(0, 30, 0)
        v2 = Vector3.new(-0, -1, -0)
    else
        local v4
        local v5, v6 = Stage.Axis(v3)
        v1 = v3.Position + (if not (0 < v5.Y) then v5 else -v5) * (v6 / 2)
        v2 = v4
    end
    return v1, Position, v2
end

local function ballistic(a1, a2, a3, a4) -- Line: 322 -- types: a1: vector, a2: vector, a3: number, a4: number
    local v1 = Vector3.new(a2.X - a1.X, 0, a2.Z - a1.Z)
    local v2 = (a2.Y - a1.Y + a3 * 70 * a3) / a3
    local v3 = math.clamp(a4, 0, a3)
    return a1 + v1 * (v3 / a3) + Vector3.new(0, v2 * v3 - v3 * 70 * v3, 0)
end

local function funnel(a1, a2, a3) -- Line: 333
    -- upvalues: Kit (val), Double (val), Score (val), Splash (val), stepRings (val), Looks (val), Overlay (val)
    -- upvalues: limb (val), Hands (val), gripFrame (val)
    local StreakClock, v1, v2, v3, v4, v5, v6, v7, v8
    local State = a1.State
    local Double_2 = a1.Double
    local Eye = State.Eye
    local v9 = Kit.Span(a2, 0.2, 1.7)
    local v10 = State.Angle0 + 15.707963267948966 * (Kit.Ease(v9, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
    local v11 = math.lerp(State.Radius0, 4, (Kit.Ease(v9, Enum.EasingStyle.Sine, Enum.EasingDirection.In)))
    local v12 = Kit.Span(a2, 1.7, 1.82)
    local v13 = Kit.Ease(Kit.Span(a2, 1.9, 2.06), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local v14 = State.Feet0 - 5 * Kit.Smooth(v9) - 8 * v13
    local v15 = Eye + Vector3.new(math.cos(v10) * v11, 0, -(math.sin(v10)) * v11)
    v15 = Vector3.new(v15.X, v14, v15.Z)
    v14 = Kit.FlatUnit(Eye - v15, (Vector3.new(0, 0, 1)))
    v11 = Vector3.new(-math.sin(v10), 0, -(math.cos(v10)))
    local v16 = (math.rad((math.lerp(20, 70, v9)))) * (1 - v12 * 0.85)
    if a2 < 0.2 then
        v16 = a2 * 0.3490658503988659 / 0.2
    end
    local Unit = (Vector3.new(0, 1, 0) * math.cos(v16) + v14 * math.sin(v16)).Unit
    local Unit_2 = (v11 - Unit * v11:Dot(Unit)).Unit
    if v12 > 0 then
        Unit_2 = Unit_2:Lerp(v14, v12).Unit
    end
    if a2 < 0.2 then
        Unit_2 = State.Look0:Lerp(Unit_2, (Kit.Smooth(a2 / 0.2))).Unit
    end
    v11 = v15 + Unit * (if not Double_2 then 3 else Double_2.Stance)
    if Double_2 ~= nil then
        v4 = Double.Blend(Double.Poses.Rest, Double.Poses.Trip, (math.clamp(a2 / 0.2, 0, 1)))
        if a2 >= 0.2 then
            v4 = Double.Blend(Double.Poses.Trip, Double.Poses.Surf, (math.clamp((a2 - 0.2) / 0.3, 0, 1)))
        end
        if a2 >= 1.2999999999999998 then
            v4 = Double.Blend(Double.Poses.Surf, Double.Poses.Flail, Kit.Span(a2, 1.2999999999999998, 1.7))
        end
        v3 = nil
        if a2 >= 1.2999999999999998 and a2 < 1.7 then
            v5 = math.sin(a2 * 38) * 22
            v3 = {
                LShoulder = Vector3.new(v5, 0, 0),
                RShoulder = Vector3.new(-v5, 0, 0),
            }
        end
        if v12 > 0 then
            v4 = Double.Blend(Double.Poses.Flail, Double.Poses.Teeter, v12)
            v5 = math.sin(a2 * 40) * 40
            v3 = {
                LShoulder = Vector3.new(v5, 0, 0),
                RShoulder = Vector3.new(-v5, 0, 0),
            }
            Unit_2 = (CFrame.fromAxisAngle(Unit, math.sin(a2 * 60) * 0.10471975511965978 * (1 - v12)) * Unit_2).Unit
        end
        if a2 >= 1.82 then
            v4 = Double.Blend(Double.Poses.Teeter, Double.Poses.Grabbed, (math.clamp((a2 - 1.82) / 0.1, 0, 1)))
            v3 = nil
        end
        Double.Pose(Double_2, v4, v3)
        Double.Place(Double_2, CFrame.lookAt(v11, v11 + Unit_2, Unit))
    end
    State.DoublePos = v11
    local v17 = math.floor((v10 - State.Angle0) / 6.283185307179586)
    if State.Laps < v17 and a2 < 1.7 then
        State.Laps = v17
        Score.Play(a1.Score, "Swoosh", 0.55, (math.lerp(0.8, 1.6, v9)))
        Splash.Small(a1.Splash, v15)
    end
    stepRings(a1, a3, math.max((Kit.Smooth(v9)) * (1 - 0.2 * v12), 0), Kit.Smooth(v9))
    Score.Level(a1.Score, "Pour", 0.5 * v9, 0.6 + 0.2 * v9)
    State.EyeLight.Brightness = 4 * Kit.Smooth(v9) + 6 * Kit.Span(a2, 1.82, 2.06)
    State.EyeLight.Range = 18 + 22 * Kit.Span(a2, 1.82, 2.06)
    if a2 < 1.7 then
        Kit.Mix(a1.Grade.Look, Looks.Clear, Looks.MoonTeal, (Kit.Smooth(a2 / 0.5)))
    elseif a2 >= 1.98 then
        Kit.Mix(a1.Grade.Look, Looks.MoonTeal, Looks.Under, (Kit.Span(a2, 1.98, 2.06)))
        Overlay.Vignette(a1.Overlay, 0.6 * Kit.Span(a2, 1.98, 2.06))
        if not State.Dunked then
            State.Dunked = true
            Splash.Small(a1.Splash, v11)
        end
    end
    local Crew = State.Crew
    if not (a2 >= 1.82) or Crew == nil then
        v1 = a1
    else
        v16 = Kit.Ease((a2 - 1.82) / 0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        v15 = limb(a1, {"LeftFoot", "Left Leg"})
        v3 = limb(a1, {"RightFoot", "Right Leg"})
        v4 = limb(a1, {"UpperTorso", "Torso"})
        local Position = Double_2 and Double_2.Root.Position or v11
        v6 = {
            v15 and v15.Position or Position,
            v3 and v3.Position or Position,
            v4 and v4.Position + v4.CFrame.LookVector * -0.9 + v4.CFrame.RightVector * -0.6 or Position,
            v4 and v4.Position + v4.CFrame.LookVector * -0.9 + v4.CFrame.RightVector * 0.6 or Position,
        }
        local Hands_2 = Crew.Hands
        v8 = nil
        local v18 = nil
        v2, v1, v7 = a2, a1, a3
        for i, j in Hands_2, v8, v18 do
            v4 = v6[i]
            v3 = (i - 1) * 3.141592653589793 / 2 + 0.6
            v15 = Eye + Vector3.new(math.cos(v3) * 3, -9, (math.sin(v3)) * 3)
            v3 = v15:Lerp(v4, v16)
            if not j.Visible then
                Hands.Visible(j, true)
                Hands.Puff(j, 6)
            end
            if v2 >= 1.9000000000000001 and j.Shown ~= "Grab" then
                Hands.Show(j, "Grab")
            end
            Hands.Place(j, gripFrame(v3, v15, Position))
        end
        Crew.LightPart.CFrame = CFrame.new(Position)
        Crew.Light.Brightness = 3
        if not State.Grabbed and v2 >= 1.9000000000000001 then
            State.Grabbed = true
            Score.Play(v1.Score, "Pad", 0.55)
            Score.Play(v1.Score, "Giggle", 0.35, 0.9)
            if Double_2 then
                Double_2.Glow.FillTransparency = 0.7
                Double_2.Glow.OutlineTransparency = 0.3
            end
            if not v1.Calm and v1.OwnsCamera then
                State.ShakeUntil = v2 + 0.15
            end
        end
    end
    if not v1.OwnsCamera then
        return
    end
    local Camera = v1.Camera
    local v19 = v11:Lerp(Eye, 0.3)
    v3 = Vector3.new(v19.X, math.max(v19.Y + 1, State.Feet0 + 2.5), v19.Z)
    local StartCamera = State.StartCamera
    local Back = State.Back
    v5 = (v10 - State.Angle0) * 0.3
    v10 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v5) * Back
    v5 = math.lerp(22, 16, v9)
    v4 = math.lerp(0.8726646259971648, 1.2217304763960306, (Kit.Smooth(v12)))
    v6 = {v1.Character, v1.Folder}
    local Whirlpool = v1.Context.Whirlpool
    if Whirlpool then
        table.insert(v6, Whirlpool)
    end
    local v20 = Kit.Orbit(v3, v10, v4, v5, v6)
    v4 = (State.CraneAt or v20):Lerp(v20, 1 - (math.exp(v7 * -9)))
    State.CraneAt = v4
    v5 = StartCamera.Position:Lerp(v4, (Kit.Smooth(v2 / 0.55)))
    v20 = (StartCamera.Position + StartCamera.LookVector * 12):Lerp(v3, (Kit.Smooth(v2 / 0.35)))
    if v2 >= 1.7 then
        v20 = v20:Lerp(Eye, (Kit.Smooth(v12)) * 0.5)
    end
    if v2 >= 1.9 then
        v20 = v20:Lerp(v11, v13)
    end
    v4 = Kit.Clamp(v3, v5, v6)
    v6 = CFrame.lookAt(v4, v20)
    local ShakeUntil = State.ShakeUntil
    if ShakeUntil ~= nil and v2 < ShakeUntil then
        v5 = 0.25 * (ShakeUntil - v2) / 0.15
        v6 = v6 + Vector3.new(v1.Score.Random:NextNumber(-v5, v5), v1.Score.Random:NextNumber(-v5, v5), (v1.Score.Random:NextNumber(-v5, v5)))
    end
    Camera.CFrame = v6
    v20 = math.lerp(math.lerp(v1.FieldOfView, 84, (Kit.Smooth(v9))), 76, (Kit.Smooth(v12)))
    if v2 >= 1.9 then
        v20 = math.lerp(76, 56, v13)
    end
    Camera.FieldOfView = v20
    local Depth = v1.Grade.Depth
    v8 = false
    if v2 > 0.3 then
        v8 = v2 < 1.7
    end
    Depth.Enabled = v8
    Depth.FocusDistance = (v4 - v11).Magnitude
    v20 = Kit.Span(v2, 1.1, 1.7)
    State.StreakClock = if not (v2 >= 1.7) then v2 else State.StreakClock
    Overlay.Streaks(v1.Overlay, Kit.Projected(Camera, Eye), if not (v2 < 1.82) then 0 else v20, StreakClock)
end

local function dragDepth(a1) -- Line: 533 -- types: a1: number
    local v1
    if a1 <= 0.8 then
        v1 = a1 / 0.8
        return 80 - v1 * 100 * v1, v1 * 200 / 0.8
    end
    v1 = math.exp(-(a1 - 0.8) * 6.944444444444445)
    return -20 - (1 - v1) * 36, v1 * 250
end

local function followY(a1, a2, a3, a4) -- Line: 542 -- types: a1: table, a2: number, a3: number, a4: number
    local v1 = a1.CamY or a2
    local v2 = v1 + (a2 - v1) * (1 - math.exp(-a3 * a4))
    a1.CamY = v2
    return v2
end

local function facingYaw(a1) -- Line: 549 -- types: a1: number
    return (math.atan2(-math.cos(a1), -(math.sin(a1))))
end

local function enterDepths(a1) -- Line: 553
    -- upvalues: Stage (val), dropRings (val), Overlay (val), Flash (val), u81 (val), Score (val), Looks (val)
    -- upvalues: Depths (val), Kit (val), u96 (val), u91 (val), u86 (val), Hands (val)
    local State = a1.State
    local Depths_2 = State.Depths
    Stage.Phase(a1, "Plunge")
    dropRings(a1)
    for i, j in State.Trails or {} do
        j.Enabled = false
        j:Clear()
    end
    Overlay.Streaks(a1.Overlay, Vector2.new(0.5, 0.5), 0, 0)
    a1.Grade.Depth.Enabled = false
    local v1 = {Attack = 0.02, Decay = 0.18, Opacity = 0.55, Tint = u81}
    Flash.Play(v1)
    Stage.Scriptable(a1)
    Stage.Arrive(a1)
    Score.Under(a1.Score, true, 0.05)
    Score.Stop(a1.Score, "Pour")
    Score.Play(a1.Score, "ScoopShort", 0.6, 0.55)
    Score.Loop(a1.Score, "Drone", 0.45)
    Score.Loop(a1.Score, "Bubbles", 0.22)
    State.NextBeat = 0.15
    State.LubAt = -10
    State.Chase = a1.Score.Random:NextNumber(0, 6.283185307179586)
    State.Roll = 0
    State.Giggled = false
    State.DragY = 80
    State.DragV = 0
    State.CamY = 86.5
    State.DeepLook = table.clone(Looks.Drowned)
    Depths.Follow(Depths_2, 80)
    Depths.Tighten(Depths_2, 1)
    Depths.Rush(Depths_2, 0, Depths_2.Origin * Vector3.new(0, 80, 0))
    Depths_2.Breath:Emit(40)
    Depths_2.Motes:Emit(40)
    Depths.Fog(Depths_2, 1)
    Depths_2.Model.Parent = a1.Folder
    local Double = a1.Double
    if Double then
        Double.Glow.FillTransparency = 1
        Double.Glow.OutlineTransparency = 1
        local v2 = a1.Trove:Add((Instance.new("PointLight")))
        v2.Name = Kit.Name
        v2.Color = u96
        v2.Range = 12
        v2.Brightness = 2.6
        v2.Shadows = false
        v2.Parent = Double.Root
        State.Rim = v2
    end
    local Crew = State.Crew
    if Crew ~= nil then
        Crew.Outline.OutlineColor = u91
        Crew.Outline.OutlineTransparency = 0.7
        Crew.Light.Brightness = 0.5
        v1 = nil
        local v3 = nil
        for k, n in Crew.Hands, v1, v3 do
            for m, i5 in n.Pieces do
                if i5.Part.Material == Enum.Material.Neon then
                    i5.Part.Color = u86
                    i5.Part.Material = Enum.Material.SmoothPlastic
                end
            end
        end
        for i6, i7 in Crew.Hands do
            if not (i6 > 2) then
                Hands.Show(i7, "Wave")
                i7.Wisps.Rate = 8
            else
                Hands.Visible(i7, false)
            end
        end
    end
end

local function placePlunge(a1, a2, a3, a4, a5) -- Line: 625
    -- upvalues: Double (val), limb (val), Hands (val), gripFrame (val)
    local v1, v2
    local State = a1.State
    local Origin = State.Depths.Origin
    local v3 = a5 * 2.5
    local v4 = Origin * CFrame.new(math.sin(a2 * 2.1) * v3, a3, math.cos(a2 * 1.7) * v3)
    local Double_2 = a1.Double
    local v5 = CFrame.Angles(math.sin(a2 * 5) * 0.17453292519943295 * a5, 0, (math.sin(a2 * 3.7)) * 0.17453292519943295 * 0.8 * a5)
    v5 = v4 * CFrame.Angles(0, a4, 0) * CFrame.Angles(0.8726646259971648, 0, 0) * v5
    if Double_2 then
        v3 = math.sin(a2 * 15) * 34
        v1 = math.sin(a2 * 11) * 30
        v2 = math.sin(a2 * 8) * 22
        Double.Pose(Double_2, Double.Poses.Grabbed, {
            LShoulder = Vector3.new(v1, 0, v2),
            RShoulder = Vector3.new(-v1, 0, -v2),
            LElbow = Vector3.new(math.max(v1, 0), 0, 0),
            RElbow = Vector3.new(math.max(-v1, 0), 0, 0),
            LHip = Vector3.new(v3, 0, 0),
            RHip = Vector3.new(-v3, 0, 0),
            LKnee = Vector3.new(-math.max(v3, 0), 0, 0),
            RKnee = Vector3.new(-math.max(-v3, 0), 0, 0),
        })
        Double.Place(Double_2, v5)
    end
    local Crew = State.Crew
    if Crew ~= nil then
        local v6 = limb(a1, {"LeftFoot", "Left Leg"})
        v1 = limb(a1, {"RightFoot", "Right Leg"})
        local v7 = {"LeftLowerLeg", "Left Leg"}
        v2 = limb(a1, v7)
        local v8 = limb(a1, {"RightLowerLeg", "Right Leg"})
        local Position = v4.Position
        local v9 = Position - Vector3.new(0, 6, 0)
        local v10 = {
            v6 and v6.Position or Position,
            v1 and v1.Position or Position,
            v2 and v2.Position or Position,
            v8 and v8.Position or Position,
        }
        local Hands_2 = Crew.Hands
        local v11 = nil
        local v12 = nil
        local v13, v14 = a4, a1
        for i, j in Hands_2, v11, v12 do
            if j.Shown == "Wave" and j.Visible then
                v7 = v13 + (if i ~= 1 then -1 else 1) * 1.1 + 3.141592653589793
                v8 = v9 + Vector3.new(math.cos(v7) * 4.5, 0, (math.sin(v7)) * 4.5)
                Hands.Place(j, gripFrame(v10[i], v8, v14.Camera.CFrame.Position))
            end
        end
        Crew.LightPart.CFrame = v4
    end
    State.DoublePos = v4.Position
end

local function plunge(a1, a2, a3) -- Line: 680
    -- upvalues: Kit (val), heartbeat (val), Depths (val), Stage (val), placePlunge (val), Looks (val), Overlay (val)
    -- upvalues: Score (val)
    local v1, v2, v3
    local State = a1.State
    local Depths_2 = State.Depths
    local Origin = Depths_2.Origin
    local v4 = Kit.Ease(a2 / 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v5 = math.lerp(0.6, 0.42, (math.clamp(a2 / 2, 0, 1)))
    local v6 = if not a1.Calm then heartbeat(a1, a2, v5) else 0
    if not (a2 <= 0.8) then
        v2 = math.exp(-(a2 - 0.8) * 6.944444444444445)
        v3 = -20 - (1 - v2) * 36
        v1 = v2 * 250
    else
        v5 = a2 / 0.8
        v3 = 80 - v5 * 100 * v5
        v1 = v5 * 200 / 0.8
    end
    v3 = v3 - v6 * 1.6
    v2 = math.clamp((80 - v3) / 136, 0, 1)
    local v7 = Kit.Smooth(a2 / 0.6)
    Depths.Follow(Depths_2, v3)
    Depths.Step(Depths_2, Stage.Elapsed(a1), a3, (math.lerp(1, 2.2, v7)))
    Depths.Light(Depths_2, (math.lerp(0.5, 1.6, v2)))
    Depths.Tighten(Depths_2, (math.lerp(1, 0.55, (Kit.Smooth((Kit.Span(a2, 0.7, 1.2)))))))
    Depths.Rush(Depths_2, v4, Origin * Vector3.new(0, v3, 0))
    State.DragY = v3
    State.DragV = v1
    State.Chase = State.Chase + a3 * 0.9599310885968813 * (0.5 + 0.5 * v4)
    local Chase = State.Chase
    placePlunge(a1, a2, v3, math.atan2(-math.cos(Chase), -(math.sin(Chase))), 1)
    local DeepLook = State.DeepLook
    Kit.Mix(DeepLook, Looks.Drowned, Looks.Deep, v2)
    Kit.Mix(a1.Grade.Look, Looks.Under, DeepLook, v4)
    Kit.Apply(a1.Grade, v6)
    local Blur = a1.Grade.Blur
    Blur.Size = Blur.Size + (v6 * 4 + 2 * v7)
    State.Pulse = v6
    Overlay.Caustic(a1.Overlay, v4 * (1 - v2 * 0.6), a2)
    Overlay.Vignette(a1.Overlay, (math.max(0.5 * v4, 0.6 * (1 - v4))) + v2 * 0.25)
    if not State.Giggled and a2 > 0.55 then
        State.Giggled = true
        Score.Play(a1.Score, "Giggle", 0.4, 1.05)
    end
    if not a1.OwnsCamera then
        return
    end
    v2 = Kit.Smooth(a2 / 1.2)
    local v8 = math.lerp(11, 9.5, v2)
    local v9 = (math.lerp(6.5, 5, v2)) + v6 * 2.2
    State.ChaseRadius = v8
    State.ChaseHeight = v9
    local v10 = v3 + v9
    local v11 = State.CamY or v10
    local v12 = v11 + (v10 - v11) * (1 - math.exp(a3 * -14))
    State.CamY = v12
    v2 = math.min(v12, v3 + v9 + 2.5)
    State.CamY = v2
    v9 = Origin * Vector3.new(math.cos(Chase) * v8, v2, (math.sin(Chase)) * v8)
    v2 = Origin * Vector3.new(0, v3 - 7, 0)
    v1 = 0.22 * v7
    v7 = Vector3.new(math.noise(a2 * 7, 0.3) * v1, math.noise(a2 * 7, 1.7) * v1, (math.noise(a2 * 7, 3.1)) * v1)
    State.Roll = math.clamp(State.Roll + a3 * 0.3490658503988659 * v4, -0.5235987755982988, 0.5235987755982988)
    v1 = math.sin(a2 * 0.9) * 0.08726646259971647 + State.Roll * 0.6
    a1.Camera.CFrame = (CFrame.lookAt(v9 + v7, v2)) * CFrame.Angles(0, 0, v1)
    v9 = (math.lerp(56, math.lerp(70, 84, (Kit.Smooth(a2 / 0.6))), v4)) + v6 * 3
    a1.Camera.FieldOfView = v9
    State.PlungeFov = v9
end

local function gulp(a1, a2, a3) -- Line: 744
    -- upvalues: Depths (val), Stage (val), placePlunge (val), Hands (val), Looks (val), Kit (val), Overlay (val)
    -- upvalues: Score (val)
    local v1, v2
    local State = a1.State
    local Depths_2 = State.Depths
    local Origin = Depths_2.Origin
    local v3 = math.clamp(a2 / 0.6, 0, 1)
    local GulpFrom = State.GulpFrom
    local GulpSpeed = State.GulpSpeed
    local GulpAccel = State.GulpAccel
    local v4 = math.min(a2, 0.6)
    local v5 = GulpFrom - GulpSpeed * v4 - GulpAccel * v4 * v4
    Depths.Follow(Depths_2, v5)
    Depths.Step(Depths_2, Stage.Elapsed(a1), a3, 2.6)
    Depths.Light(Depths_2, (math.lerp(1.6, 0.8, v3)))
    Depths.Tighten(Depths_2, 0.45)
    Depths.Rush(Depths_2, 1, Origin * Vector3.new(0, v5, 0))
    State.Chase = State.Chase + a3 * 1.5358897417550101
    local Chase = State.Chase
    placePlunge(a1, a2, v5, math.atan2(-math.cos(Chase), -(math.sin(Chase))), 1 - v3)
    local Crew = State.Crew
    if Crew ~= nil and not State.LetGo and State.EnteredAt ~= nil then
        State.LetGo = true
        Crew.Light.Brightness = 0
        v1 = nil
        v2 = nil
        for i, j in Crew.Hands, v1, v2 do
            j.Wisps.Rate = 0
            if j.Visible then
                Hands.Puff(j, 4)
            end
            Hands.Visible(j, false)
        end
    end
    local DeepLook = State.DeepLook
    if not (v3 < 0.35) then
        Kit.Mix(a1.Grade.Look, Looks.Throat, Looks.Gullet, (Kit.Smooth((v3 - 0.35) / 0.65)))
    else
        Kit.Mix(a1.Grade.Look, DeepLook, Looks.Throat, v3 / 0.35)
    end
    Depths.Exit(Depths_2, Kit.Smooth(Kit.Span(v3, 0.25, 1)))
    local Rim = State.Rim
    if Rim ~= nil then
        Rim.Brightness = (v3 * 0.6 + 1) * 2.6
    end
    Kit.Apply(a1.Grade, 0)
    local EnteredAt = State.EnteredAt
    if EnteredAt ~= nil then
        local Blur = a1.Grade.Blur
        Blur.Size = Blur.Size + math.exp(-(a2 - EnteredAt) * 14) * 12
    end
    Overlay.Caustic(a1.Overlay, (1 - v3) * 0.4, a2)
    Overlay.Vignette(a1.Overlay, v3 * 0.2 + 0.75)
    if not State.Hushed and a2 >= 0.44999999999999996 then
        State.Hushed = true
        Score.StopAll(a1.Score)
    end
    local v6 = Kit.Smooth(v3 / 0.55)
    local v7 = math.lerp(State.ChaseRadius or 9.5, 2.5, v6)
    v1 = v5 + math.lerp(State.ChaseHeight or 5, 4.4, v6)
    v2 = State.CamY or v1
    v6 = v2 + (v1 - v2) * (1 - math.exp(a3 * -22))
    State.CamY = v6
    if EnteredAt == nil and v6 < Depths_2.Floor + 1 then
        State.EnteredAt = a2
        EnteredAt = a2
        Score.Play(a1.Score, "Clank", 0.6)
        if not a1.Calm and a1.OwnsCamera then
            State.GulpShake = a2 + 0.15
        end
    end
    if not a1.OwnsCamera then
        return
    end
    v4 = CFrame.lookAt(Origin * Vector3.new(math.cos(Chase) * v7, v6, (math.sin(Chase)) * v7), Origin * Vector3.new(0, v5 - 20, 0))
    local GulpShake = State.GulpShake
    if GulpShake ~= nil and a2 < GulpShake then
        v5 = 0.35 * (GulpShake - a2) / 0.15
        v4 = v4 + Vector3.new(a1.Score.Random:NextNumber(-v5, v5), a1.Score.Random:NextNumber(-v5, v5), (a1.Score.Random:NextNumber(-v5, v5)))
    end
    a1.Camera.CFrame = v4 * CFrame.Angles(0, 0, State.Roll * 0.6)
    local v8 = if EnteredAt == nil then 0 else math.exp(-(a2 - EnteredAt) * 10) * 6
    a1.Camera.FieldOfView = math.lerp(State.PlungeFov or 84, 100, (Kit.Ease(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.In))) + v8
end

local function startGulp(a1) -- Line: 831
    local State = a1.State
    local Depths = State.Depths
    local DragY = State.DragY
    local DragV = State.DragV
    local v1 = math.max(DragY - (Depths.Floor - 78), 10)
    State.GulpFrom = DragY
    State.GulpSpeed = DragV
    State.GulpAccel = math.max((v1 - DragV * 0.6) / 0.36, DragV * -0.6 / 1.2)
    State.EnteredAt = nil
end

local function enterCave(a1) -- Line: 846 -- upvalues: Stage (val), Kit (val), Overlay (val), Score (val), Splash (val)
    local v1, v2, v3, v4, v5
    local State = a1.State
    Stage.Phase(a1, "Cough")
    for i, j in State.Trails or {} do
        j:Clear()
        j.Enabled = true
    end
    State.Depths.Model.Parent = nil
    local Crew = State.Crew
    if Crew ~= nil then
        Crew.Model.Parent = nil
    end
    local Position = a1.Context.Surface.Position
    local v6 = Stage.CaveFlange()
    if v6 == nil then
        v3 = Position + Vector3.new(0, 30, 0)
        v4 = Vector3.new(-0, -1, -0)
    else
        v5, v1 = Stage.Axis(v6)
        v3 = v6.Position + (if not (0 < v5.Y) then v5 else -v5) * (v1 / 2)
        v4 = v2
    end
    local v7 = v3
    local v8 = Position
    local v9 = v4
    State.Mouth = v7
    State.SplashAt = v8
    State.Aim = v9
    local Position_2 = a1.Root.Position
    v3 = (v7 + v8 + Position_2) / 3
    v4 = Kit.FlatUnit(Position_2 - v7, (Vector3.new(1, 0, 0)))
    v5 = Vector3.new(v4.Z, 0, -v4.X)
    v4 = {a1.Character, a1.Folder}
    v1 = v3 + v5 * 36 + Vector3.new(0, -4, 0)
    v2 = v3 - v5 * 36 + Vector3.new(0, -4, 0)
    local v10 = Kit.Clearance(v3, v1, v4)
    State.BirthCamera = Kit.Clamp(v3, if not (Kit.Clearance(v3, v2, v4) <= v10) then v2 else v1, v4)
    State.BirthAim = v7 * 0.3 + v8 * 0.4 + Position_2 * 0.3 + Vector3.new(0, 3, 0)
    Overlay.Caustic(a1.Overlay, 0, 0)
    Overlay.Vignette(a1.Overlay, 0)
    Overlay.Streaks(a1.Overlay, Vector2.new(0.5, 0.5), 0, 0)
    Score.Under(a1.Score, false, 0.05)
    Score.Echo(a1.Score, true)
    Score.Play(a1.Score, "Whoosh", 0.6, 1.1)
    Score.Play(a1.Score, "Pop", 0.75, 0.85)
    Splash.Crown(a1.Splash, CFrame.lookAt(v7, v7 + v9))
    local Double = a1.Double
    if Double then
        Double.Glow.FillTransparency = 0.88
        Double.Glow.OutlineTransparency = 0.2
    end
    local Rim = State.Rim
    if Rim ~= nil then
        Rim.Enabled = false
    end
end

local function cough(a1, a2, a3) -- Line: 896
    -- upvalues: Kit (val), Double (val), Splash (val), Looks (val)
    local State = a1.State
    local Mouth = State.Mouth
    local SplashAt = State.SplashAt
    local Double_2 = a1.Double
    local v1 = Vector3.new(SplashAt.X - Mouth.X, 0, SplashAt.Z - Mouth.Z)
    local v2 = (SplashAt.Y - Mouth.Y + 21.175) / 0.55
    local v3 = math.clamp(a2, 0, 0.55)
    local v4 = Mouth + v1 * (v3 / 0.55) + Vector3.new(0, v2 * v3 - v3 * 70 * v3, 0)
    if Double_2 then
        v1 = Kit.Smooth(a2 / 0.55)
        Double_2.Glow.FillTransparency = math.lerp(0.88, 1, v1)
        Double_2.Glow.OutlineTransparency = math.lerp(0.2, 1, v1)
        Double.Pose(Double_2, Double.Poses.Cannonball)
        v1 = CFrame.Angles(-a2 * 9.42477796076938, 0, 0)
        Double.Place(Double_2, CFrame.lookAt(v4, v4 + (Kit.FlatUnit(SplashAt - Mouth, (Vector3.new(0, 0, 1))))) * v1)
    end
    local v5 = Kit.Ease(a2 / 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if a2 > 0.35 then
        v5 = math.max(1 - (a2 - 0.35) / 0.2, 0)
    end
    Splash.Jet(a1.Splash, Mouth, Mouth + (SplashAt - Mouth).Unit * 14, v5)
    if not (a2 < 0.3) then
        Kit.Mix(a1.Grade.Look, Looks.Afterglow, Looks.Clear, (Kit.Smooth((a2 - 0.3) / 1.2)))
    else
        Kit.Mix(a1.Grade.Look, Looks.GreenGlow, Looks.Afterglow, a2 / 0.3)
    end
    Kit.Apply(a1.Grade, 0)
    if not a1.OwnsCamera then
        return
    end
    local BirthCamera = State.BirthCamera
    local BirthAim = State.BirthAim
    local v6 = Kit.Smooth(a2 / 0.55)
    v1 = BirthAim:Lerp(v4, 0.2 * v6)
    v4 = BirthCamera:Lerp(BirthAim, 0.06 * v6)
    v5 = 0.10471975511965978 * (1 - Kit.Smooth(a2 / 0.3))
    a1.Camera.CFrame = (CFrame.lookAt(v4, v1)) * CFrame.Angles(0, 0, v5)
    a1.Camera.FieldOfView = 74
    State.Push = v4
    State.AimAt = v1
end

local function impact(a1) -- Line: 937 -- upvalues: Stage (val), Splash (val), Score (val), Overlay (val), Double (val)
    local State = a1.State
    Stage.Phase(a1, "Splash")
    local SplashAt = State.SplashAt
    Splash.Jet(a1.Splash, SplashAt, SplashAt, 0)
    Splash.Big(a1.Splash, SplashAt)
    Score.Play(a1.Score, "Crash", 0.7)
    Score.Play(a1.Score, "Boom", 0.4)
    Score.Play(a1.Score, "ScoopLong", 0.5, 0.9)
    Overlay.Drops(a1.Overlay, a1.Scenery, if not a1.Low then 5 else 3)
    local Double_2 = a1.Double
    if Double_2 then
        Double.Visible(Double_2, false)
    end
end

local function toss(a1, a2, a3) -- Line: 953
    -- upvalues: Double (val), Splash (val), Kit (val), Looks (val), Stage (val)
    local State = a1.State
    local SplashAt = State.SplashAt
    local Double_2 = a1.Double
    local CFrame_2 = a1.Root.CFrame
    local Stance = if not Double_2 then 3 else Double_2.Stance
    local Position = CFrame_2.Position
    local v1 = SplashAt - Vector3.new(0, 1, 0)
    local v2 = a2 - 0.12
    local v3 = math.clamp(v2 / 0.55, 0, 1)
    if Double_2 and v2 >= 0 then
        if not State.Surfaced then
            State.Surfaced = true
            Double.Visible(Double_2, true)
            Splash.Small(a1.Splash, SplashAt)
        end
        local v4 = (math.max(Position.Y - v1.Y, 0)) + 8
        local v5 = (v1:Lerp(Position, v3)) + Vector3.new(0, v4 * 4 * v3 * (1 - v3), 0)
        v4 = Kit.FlatUnit(CFrame_2.LookVector, (Vector3.new(0, 0, 1)))
        local v6 = CFrame.Angles(6.283185307179586 * Kit.Ease(v3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 0, 0)
        Double.Pose(Double_2, (Double.Blend(Double.Poses.Cannonball, Double.Poses.Squash, Kit.Span(v3, 0.6, 1))))
        local v7 = Vector3.new(0, Stance * (1 - v3), 0)
        Double.Place(Double_2, CFrame.lookAt(v5 + v7, v5 + v7 + v4) * v6)
    end
    Kit.Mix(a1.Grade.Look, Looks.Afterglow, Looks.Clear, (Kit.Smooth(((Stage.Elapsed(a1)) - State.CaveAt - 0.3) / 1.2)))
    Kit.Apply(a1.Grade, 0)
    if not a1.OwnsCamera then
        return
    end
    local BirthCamera = State.BirthCamera
    local Position_2 = if not Double_2 then SplashAt else if not (v2 >= 0) then SplashAt else Double_2.Root.Position
    v2 = State.Push or BirthCamera
    v3 = State.AimAt or Position_2
    local v8 = Kit.Smooth((math.clamp(a2 / 0.67, 0, 1)))
    local v9 = v3:Lerp(Position_2:Lerp(Position, 0.5), 0.45 * v8)
    v3 = Kit.Clamp(Position, v2:Lerp(Position, 0.4 * v8), {a1.Character, a1.Folder})
    a1.Camera.CFrame = CFrame.lookAt(v3, v9)
end

local function land(a1) -- Line: 1003 -- upvalues: Stage (val), Splash (val), Score (val), u116 (ref), Overlay (val)
    local State = a1.State
    Stage.Phase(a1, "Settle")
    Stage.Swap(a1)
    Splash.Land(a1.Splash, a1.Root.Position - Vector3.new(0, 2.5, 0))
    Score.Play(a1.Score, "ScoopShort", 0.45, 1.2)
    Score.Play(a1.Score, "Gasp", 0.6)
    a1.Trove:Add((task.delay(0.6, function() -- Line: 1011 -- upvalues: Score (upval), a1 (val)
        Score.Play(a1.Score, "Drip", 0.5)
    end)))
    local Head = a1.Character:FindFirstChild("Head")
    if Head ~= nil and Head:IsA("BasePart") then
        Splash.Drips(a1.ScoreTrove, Head, 2.5)
    end
    State.SettleFrom = a1.Camera.CFrame
    State.SettleFov = a1.Camera.FieldOfView
    State.SettleTo = Stage.Landing(a1, a1.Zoom)
    if not u116 then
        u116 = true
        a1.Trove:Add((task.delay(0.2, function() -- Line: 1023 -- upvalues: a1 (val), Overlay (upval), Score (upval)
            if a1.Done then
                return
            end
            Overlay.Card(a1.Overlay, a1.ScoreTrove, "SECRET FISHING AREA", 1)
            Score.Play(a1.Score, "Shimmer", 0.5)
        end)))
    end
end

local function settle(a1, a2) -- Line: 1033 -- upvalues: Looks (val), Kit (val), Stage (val) -- types: a2: number
    local State = a1.State
    local v1 = math.clamp(a2 / 0.9, 0, 1)
    Kit.Mix(a1.Grade.Look, Looks.Afterglow, Looks.Clear, (Kit.Smooth(((Stage.Elapsed(a1)) - State.CaveAt - 0.3) / 1.2)))
    Kit.Apply(a1.Grade, 0)
    State.SettleTo = Stage.Landing(a1, a1.Zoom)
    if v1 >= 1 then
        Stage.HandBack(a1, State.SettleTo)
        return
    end
    if not a1.OwnsCamera then
        return
    end
    local SettleFrom = State.SettleFrom
    local SettleTo = State.SettleTo
    local v2 = Kit.Ease(v1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    a1.Camera.CFrame = Stage.SwingFrame(a1, SettleFrom, SettleTo, (math.clamp(v2, 0, 1.05)))
    a1.Camera.FieldOfView = math.lerp(State.SettleFov or 70, a1.FieldOfView, (Kit.Smooth(v1)))
end

local function calm(a1, a2, a3) -- Line: 1058
    -- upvalues: Kit (val), Double (val), Hands (val), gripFrame (val), stepRings (val), Overlay (val), Looks (val)
    -- upvalues: Stage (val), dropRings (val), Score (val), Splash (val), u116 (ref)
    local v1, v2
    local State = a1.State
    local Eye = State.Eye
    local Double_2 = a1.Double
    local Camera = a1.Camera
    if a1.Phase == "Calm" then
        local v3, v4, v5
        v2 = Kit.Smooth(a2 / 1.1)
        local v6 = a2 * 1.3962634015954636
        if Double_2 then
            local DoubleStart = State.DoubleStart
            local v7 = (CFrame.new(DoubleStart.Position - Vector3.new(0, 5 * v2, 0))) * DoubleStart.Rotation * CFrame.Angles(0, v6, 0)
            Double.Pose(Double_2, Double.Blend(Double.Poses.Rest, Double.Poses.Grabbed, v2))
            Double.Place(Double_2, v7)
        end
        local Crew = State.Crew
        if Crew == nil or not (a2 > 0.3) then
            v3, v5, v4 = a1, a3, a2
        else
            local Place, v8, v9, v10, v11, v12
            v2 = Kit.Smooth((a2 - 0.3) / 0.6)
            local Position_2 = Double_2 and Double_2.Root.Position or Eye
            local Hands_2 = Crew.Hands
            local v13 = nil
            local v14 = nil
            v3, v5, v4 = a1, a3, a2
            for i, j in Hands_2, v13, v14 do
                if not j.Visible then
                    Hands.Visible(j, true)
                    Hands.Show(j, "Reach")
                end
                v8 = (i - 1) * 3.141592653589793 / 2 + 0.6
                v9 = Position_2 + Vector3.new(math.cos(v8) * 3, -8, (math.sin(v8)) * 3)
                v10 = Position_2 + Vector3.new(math.cos(v8) * 1.2, -1.5, (math.sin(v8)) * 1.2)
                Place = Hands.Place
                v11 = gripFrame
                v12 = v9:Lerp(v10, v2)
                Place(j, v11(v12, v9, Position_2))
            end
        end
        stepRings(v3, v5, 0.15, 0)
        Overlay.Waterline(v3.Overlay, Kit.Smooth((v4 - 0.4) / 0.8))
        Overlay.Iris(v3.Overlay, Kit.Projected(Camera, Eye), 1 - Kit.Smooth((v4 - 1.2) / 0.6))
        Kit.Mix(v3.Grade.Look, Looks.Clear, Looks.Haze, (Kit.Smooth(v4 / 1)))
        Kit.Apply(v3.Grade, 0)
        if v3.OwnsCamera then
            Camera.FieldOfView = v3.FieldOfView - 6 * Kit.Smooth(v4)
        end
        if v4 >= 1.8 then
            Stage.Phase(v3, "CalmHold")
            dropRings(v3)
            Stage.Scriptable(v3)
            Stage.Arrive(v3)
            if Double_2 then
                Double.Visible(Double_2, false)
            end
            if Crew ~= nil then
                Crew.Model.Parent = nil
            end
            Score.Loop(v3.Score, "Drone", 0.25)
        end
        return
    end
    if a1.Phase ~= "CalmHold" then
        local v15 = math.clamp(a2 / 1, 0, 1)
        if a1.OwnsCamera then
            v2 = Stage.Landing(a1, a1.Zoom)
            Camera.CFrame = v2
            Camera.FieldOfView = a1.FieldOfView
            State.Landing = v2
        end
        Overlay.Iris(a1.Overlay, Kit.Projected(Camera, a1.Root.Position), Kit.Smooth(v15))
        Overlay.Waterline(a1.Overlay, 1 - Kit.Smooth(v15 * 1.4))
        Kit.Mix(a1.Grade.Look, Looks.Haze, Looks.Clear, (Kit.Smooth(v15)))
        Kit.Apply(a1.Grade, 0)
        if v15 >= 1 then
            if State.Failed then
                Stage.Finish(a1, false)
                return
            end
            Stage.HandBack(a1, State.Landing or Stage.Landing(a1, a1.Zoom))
        end
        return
    end
    Overlay.Iris(a1.Overlay, Vector2.new(0.5, 0.5), 0)
    if a1.ArriveState == "Failed" then
        Stage.Phase(a1, "CalmBack")
        State.Failed = true
        return
    end
    if not State.Dripped and a2 > 0.4 then
        State.Dripped = true
        Score.Play(a1.Score, "Drip", 0.5)
    end
    if not (a2 >= 0.6) then
        if 8 < (Stage.Elapsed(a1)) then
            Stage.Phase(a1, "CalmBack")
            Stage.Swap(a1)
            Score.Stop(a1.Score, "Drone")
            if a1.ArriveState == "Arrived" then
                Overlay.Drops(a1.Overlay, a1.Scenery, 3)
                v1 = a1.Character:FindFirstChild("Head")
                if v1 ~= nil and v1:IsA("BasePart") then
                    Splash.Drips(a1.ScoreTrove, v1, 2.5)
                end
                Score.Play(a1.Score, "Gasp", 0.5)
                if not u116 then
                    u116 = true
                    Overlay.Card(a1.Overlay, a1.ScoreTrove, "SECRET FISHING AREA", 1)
                    Score.Play(a1.Score, "Shimmer", 0.5)
                end
            end
        end
    elseif Stage.Settled(a1) or 8 < (Stage.Elapsed(a1)) then
        Stage.Phase(a1, "CalmBack")
        Stage.Swap(a1)
        Score.Stop(a1.Score, "Drone")
        if a1.ArriveState == "Arrived" then
            Overlay.Drops(a1.Overlay, a1.Scenery, 3)
            v1 = a1.Character:FindFirstChild("Head")
            if v1 ~= nil and v1:IsA("BasePart") then
                Splash.Drips(a1.ScoreTrove, v1, 2.5)
            end
            Score.Play(a1.Score, "Gasp", 0.5)
            if not u116 then
                u116 = true
                Overlay.Card(a1.Overlay, a1.ScoreTrove, "SECRET FISHING AREA", 1)
                Score.Play(a1.Score, "Shimmer", 0.5)
            end
        end
    end
end

local function step(a1, a2) -- Line: 1166
    -- upvalues: Stage (val), calm (val), funnel (val), Kit (val), enterDepths (val), plunge (val), SewerCave (val)
    -- upvalues: Score (val), Overlay (val), Double (val), gulp (val), enterCave (val), cough (val), impact (val)
    -- upvalues: toss (val), land (val), settle (val)
    local State = a1.State
    local v1 = Stage.Since(a1)
    if a1.Calm then
        calm(a1, v1, a2)
        return
    end
    if a1.Phase == "Funnel" then
        if a1.ArriveState ~= "Idle" then
            return
        end
        funnel(a1, v1, a2)
        Kit.Apply(a1.Grade, 0)
        if v1 >= 2.06 then
            enterDepths(a1)
            plunge(a1, 0, a2)
        end
        return
    end
    if a1.Phase ~= "Plunge" then
        if a1.Phase == "Gulp" then
            gulp(a1, v1, a2)
            if v1 >= 0.6 then
                State.CaveAt = Stage.Elapsed(a1)
                enterCave(a1)
                cough(a1, 0, a2)
            end
            return
        end
        if a1.Phase == "Cough" then
            cough(a1, v1, a2)
            if v1 >= 0.55 then
                impact(a1)
                toss(a1, 0, a2)
            end
            return
        end
        if a1.Phase == "Splash" then
            toss(a1, v1, a2)
            if v1 >= 0.67 then
                land(a1)
                settle(a1, 0)
            end
            return
        end
        if a1.Phase == "Settle" then
            settle(a1, v1)
        end
        return
    end
    if a1.ArriveState == "Failed" then
        Stage.Bail(a1)
        return
    end
    plunge(a1, v1, a2)
    local v2 = false
    if v1 >= 0.8 then
        v2 = Stage.Settled(a1)
        if v2 then
            v2 = false
            if SewerCave.Marker(SewerCave.Markers.Spawn) ~= nil then
                v2 = Stage.CaveFlange() ~= nil
            end
        end
    end
    if v2 then
        local State_2 = a1.State
        local Depths = State_2.Depths
        local DragY = State_2.DragY
        local DragV = State_2.DragV
        local v3 = math.max(DragY - (Depths.Floor - 78), 10)
        State_2.GulpFrom = DragY
        State_2.GulpSpeed = DragV
        State_2.GulpAccel = math.max((v3 - DragV * 0.6) / 0.36, DragV * -0.6 / 1.2)
        State_2.EnteredAt = nil
        Stage.Phase(a1, "Gulp")
        Score.Loop(a1.Score, "Hole", 0.5, 0.7)
        return
    end
    if 8.06 < (Stage.Elapsed(a1)) then
        State.GaveUp = true
        Stage.Phase(a1, "CalmHold")
        a1.Calm = true
        Overlay.Iris(a1.Overlay, Vector2.new(0.5, 0.5), 0)
        Overlay.Streaks(a1.Overlay, Vector2.new(0.5, 0.5), 0, 0)
        Score.StopAll(a1.Score)
        Score.Under(a1.Score, false, 0.2)
        State.Depths.Model.Parent = nil
        local Crew = State.Crew
        if Crew ~= nil then
            Crew.Model.Parent = nil
        end
        if a1.Double then
            Double.Visible(a1.Double, false)
        end
    end
end

local function finishPrepare(a1, a2) -- Line: 1249
    -- upvalues: footTrail (val), Kit (val), Hands (val), u117 (ref), Depths (val), u76 (val)
    local State = a1.State
    local Double = a1.Double
    if Double then
        State.DoubleStart = Double.Root.CFrame
        State.Trails = footTrail(a1)
    end
    local v1 = Kit.Part({
        Name = "Eye",
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        Transparency = 1,
    })
    v1.CFrame = CFrame.new(a2 + Vector3.new(0, 4, 0))
    v1.Parent = a1.Folder
    local PointLight = Instance.new("PointLight")
    PointLight.Color = Kit.Teal
    PointLight.Range = 18
    PointLight.Brightness = 0
    PointLight.Shadows = false
    PointLight.Parent = v1
    State.EyeLight = PointLight
    State.Crew = Hands.Build(a1.Scenery, a1.Folder, 4, 6)
    if not a1.Calm then
        local v2 = u117
        u117 = nil
        if v2 ~= nil and v2.Depths.Model.Parent ~= nil then
            a1.Scenery:Add(v2.Trove)
            State.Depths = v2.Depths
            return
        end
        if v2 ~= nil then
            v2.Trove:Destroy()
        end
        State.Depths = Depths.Build(a1.Scenery, a1.Folder, u76, a1.Low)
    end
end

local function prepare(a1) -- Line: 1282
    -- upvalues: cloneRings (val), Kit (val), surfaceBelow (val), finishPrepare (val)
    local Position, v1
    local State = a1.State
    local Whirlpool = a1.Context.Whirlpool
    if Whirlpool == nil or Whirlpool.Parent == nil then
        Position = a1.Root.Position - Vector3.new(0, 4, 0)
        v1 = nil
    else
        Position = Whirlpool:GetBoundingBox().Position
        v1 = Whirlpool
    end
    State.Eye = Position
    State.Rings = cloneRings(a1, v1, Position)
    local Root = a1.Root
    local Double = a1.Double
    local v2 = Kit.Flat(Root.Position - Position)
    State.Laps = 0
    if v1 ~= nil and 40 < v2.Magnitude then
        local v3 = Kit.FlatUnit(v2, (Vector3.new(1, 0, 0)))
        local v4 = Position + v3 * 14
        State.FarStart = true
        State.Radius0 = 14
        State.Angle0 = math.atan2(-v3.Z, v3.X)
        State.Look0 = -v3
        State.Feet0 = surfaceBelow(a1, v4, Position.Y + 30)
        State.StartCamera = CFrame.lookAt((Vector3.new(v4.X, State.Feet0, v4.Z)) + v3 * 15 + Vector3.new(0, 8, 0), Position)
        State.Back = v3
        return finishPrepare(a1, Position)
    end
    State.Radius0 = math.clamp(v2.Magnitude, 4.5, 26)
    State.Look0 = Kit.FlatUnit(Root.CFrame.LookVector, (Vector3.new(0, 0, 1)))
    State.Angle0 = math.atan2(-v2.Z, v2.X)
    local Y = Root.Position.Y
    State.Feet0 = Y - (if not Double then 3 else Double.Stance)
    State.StartCamera = a1.Camera.CFrame
    State.Back = Kit.FlatUnit(a1.Camera.CFrame.Position - Root.Position, -Root.CFrame.LookVector)
    finishPrepare(a1, Position)
end

function v1.Run(a1) -- Line: 1319
    -- upvalues: Stage (val), prepare (val), Flash (val), Score (val), Splash (val), step (val)
    local v1 = Stage.Begin("Enter", a1)
    if v1 == nil or not Stage.Prepare(v1, prepare) then
        return Stage.Fallback(a1)
    end
    Stage.Phase(v1, if not v1.Calm then "Funnel" else "Calm")
    if not v1.Calm then
        Stage.Scriptable(v1)
    end
    if v1.State.FarStart and v1.OwnsCamera then
        Stage.Scriptable(v1)
        v1.Camera.CFrame = v1.State.StartCamera
        Flash.Play({Attack = 0.01, Decay = 0.3, Opacity = 1, Tint = Color3.fromRGB(215, 255, 245)})
    end
    Score.Duck(v1.Score, true, 0.3)
    Score.Play(v1.Score, "Splash", 0.6, 0.8)
    Score.Play(v1.Score, "Gulp", 0.55)
    if not v1.Calm then
        Score.Rise(v1.Score, 1.85, 0.32)
        Score.Loop(v1.Score, "Pour", 0, 0.6)
        Splash.Small(v1.Splash, v1.Root.Position - Vector3.new(0, 2.5, 0))
    end
    Stage.Bind(v1, step)
    return Stage.Wait(v1)
end

function v1.Warm() -- Line: 1349 -- upvalues: Score (val)
    Score.Warm()
end

function v1.Prewarm() -- Line: 1353
    -- upvalues: u117 (ref), Stage (val), Workspace (val), Trove (val), Depths (val), u76 (val), Kit (val)
    if u117 == nil and Stage.Active() == nil then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera == nil then
            return
        end
        local v1 = Trove.new()
        local v2 = v1:Add((Instance.new("Folder")))
        v2.Name = "SewerDrainWarm"
        v2.Parent = CurrentCamera
        local success, err = pcall(Depths.Build, v1, v2, u76, (Kit.LowQuality()))
        if not success then
            v1:Destroy()
            return
        end
        u117 = {Trove = v1, Depths = err}
        return
    end
end

function v1.Release() -- Line: 1373 -- upvalues: u117 (ref)
    local v1 = u117
    u117 = nil
    if v1 ~= nil then
        v1.Trove:Destroy()
    end
end

function v1.Visited() -- Line: 1381 -- upvalues: u116 (ref), LocalPlayer (val), SewerCave (val)
    return u116 or LocalPlayer:GetAttribute(SewerCave.Attributes.Inside) == true
end

return (table.freeze(v1))