-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Dream
-- Decompile time: 29.09 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Score = require(script.Score)
local Shapes = require(script.Shapes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tunnel = require(script.Tunnel)
local Vortex = require(script.Vortex)
local u55 = Enum.RenderPriority.Camera.Value + 1
local u60 = CFrame.new(6200, 30000, 16900)
local u65 = Color3.new(1, 1, 1)
local u66 = {
    Brightness = 0,
    Contrast = 0,
    Saturation = 0,
    Bloom = 0,
    Blur = 0,
    Tint = u65,
}
local u67 = {
    Brightness = 0.04,
    Contrast = 0.2,
    Saturation = 0.75,
    Bloom = 1.4,
    Blur = 0,
}
u67.Tint = Color3.fromRGB(255, 200, 245)
local u73 = {
    Brightness = 0.5,
    Contrast = 0.05,
    Saturation = 0.4,
    Bloom = 3,
    Blur = 14,
}
u73.Tint = Color3.fromRGB(255, 232, 250)
local u79 = {
    Brightness = 0.03,
    Contrast = 0.22,
    Saturation = 0.6,
    Bloom = 1.2,
    Blur = 1,
    Tint = u65,
}
local u80 = {
    Brightness = 0.85,
    Contrast = -0.1,
    Saturation = 0.3,
    Bloom = 3.5,
    Blur = 22,
}
u80.Tint = Color3.fromRGB(255, 240, 252)
local u86 = {
    Brightness = 0.12,
    Contrast = 0.15,
    Saturation = 0.7,
    Bloom = 1,
    Blur = 0,
}
u86.Tint = Color3.fromRGB(255, 215, 245)
local u92 = {
    Brightness = 0.7,
    Contrast = -0.4,
    Saturation = 0.25,
    Bloom = 1.5,
    Blur = 40,
}
u92.Tint = Color3.fromRGB(255, 225, 248)
local u98 = {
    Brightness = 0.2,
    Contrast = 0,
    Saturation = 0.35,
    Bloom = 0.8,
    Blur = 6,
}
u98.Tint = Color3.fromRGB(255, 232, 250)
local LocalPlayer = Players.LocalPlayer
local u105 = nil
local v1 = {}

local function ease(a1, a2, a3) -- Line: 232 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), a2, a3)
end

local function mix(a1, a2, a3, a4) -- Line: 240 -- types: a1: table, a2: table, a3: table, a4: number
    local v1 = math.clamp(a4, 0, 1)
    a1.Brightness = math.lerp(a2.Brightness, a3.Brightness, v1)
    a1.Contrast = math.lerp(a2.Contrast, a3.Contrast, v1)
    a1.Saturation = math.lerp(a2.Saturation, a3.Saturation, v1)
    a1.Tint = a2.Tint:Lerp(a3.Tint, v1)
    a1.Bloom = math.lerp(a2.Bloom, a3.Bloom, v1)
    a1.Blur = math.lerp(a2.Blur, a3.Blur, v1)
end

local function dreamTint(a1) -- Line: 251 -- types: a1: number
    return Color3.fromHSV(a1 * 0.12 % 1, 0.22, 1)
end

local function grade(a1, a2) -- Line: 255 -- types: a2: userdata
    local v1 = a1:Add((Instance.new("ColorCorrectionEffect")))
    v1.Name = "BanjoDream"
    v1.Parent = a2
    local v2 = a1:Add((Instance.new("BloomEffect")))
    v2.Name = "BanjoDream"
    v2.Intensity = 0
    v2.Size = 40
    v2.Threshold = 0.9
    v2.Parent = a2
    local v3 = a1:Add((Instance.new("BlurEffect")))
    v3.Name = "BanjoDream"
    v3.Size = 0
    v3.Parent = a2
    return {Color = v1, Bloom = v2, Blur = v3}
end

local function applyLook(a1, a2) -- Line: 272 -- types: a1: table, a2: number
    local Look = a1.Look
    local Grade = a1.Grade
    Grade.Color.Brightness = Look.Brightness + a2 * 0.04
    Grade.Color.Contrast = Look.Contrast
    Grade.Color.Saturation = Look.Saturation
    Grade.Color.TintColor = Look.Tint
    Grade.Bloom.Intensity = Look.Bloom + a2 * 0.3
    Grade.Blur.Size = Look.Blur
end

local function burst(a1, a2) -- Line: 283
    -- upvalues: Workspace (val), BanjoCricket (val), Shapes (val)
    local v1
    local v2 = a1:Add((Instance.new("Attachment")))
    v2.Name = "BanjoDream"
    v2.Parent = Workspace.Terrain
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Spores"
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.Rate = 0
    ParticleEmitter.Speed = NumberRange.new(16, 30)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Lifetime = NumberRange.new(0.8, 1.4)
    ParticleEmitter.Drag = 3
    ParticleEmitter.Size = NumberSequence.new(0.7, 0)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Brightness = 2
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.RotSpeed = NumberRange.new(-200, 200)
    ParticleEmitter.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 220)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(90, 200, 255)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 230, 90)),
        (ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 255, 140))),
    })
    ParticleEmitter.Parent = v2
    local ParticleEmitter_2 = Instance.new("ParticleEmitter")
    ParticleEmitter_2.Name = "Notes"
    ParticleEmitter_2.Texture = "rbxassetid://243331916"
    ParticleEmitter_2.Rate = 0
    ParticleEmitter_2.Speed = NumberRange.new(7, 13)
    ParticleEmitter_2.SpreadAngle = Vector2.new(70, 70)
    ParticleEmitter_2.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter_2.Lifetime = NumberRange.new(1.2, 1.8)
    ParticleEmitter_2.Drag = 1.5
    ParticleEmitter_2.Acceleration = Vector3.new(0, 2, 0)
    ParticleEmitter_2.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.9),
        NumberSequenceKeypoint.new(0.2, 1.4),
        (NumberSequenceKeypoint.new(1, 1.1)),
    })
    ParticleEmitter_2.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.7, 0.1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter_2.LightEmission = 0.5
    ParticleEmitter_2.Rotation = NumberRange.new(-20, 20)
    local v3 = {}
    for i, j in BanjoCricket.Mushrooms do
        v1 = (i - 1) / math.max(#BanjoCricket.Mushrooms - 1, 1)
        table.insert(v3, (ColorSequenceKeypoint.new(v1, j.Color)))
    end
    ParticleEmitter_2.Color = ColorSequence.new(v3)
    ParticleEmitter_2.Parent = v2
    v3 = Shapes.Circle("Shockwave", 0.1)
    Shapes.Paint(v3, 0.8, 1)
    a1:Add(v3.Hub)
    v3.Hub.Parent = a2
    return {Anchor = v2, Spores = ParticleEmitter, Notes = ParticleEmitter_2, Wave = v3}
end

local function headingOf(a1, a2) -- Line: 343 -- types: a1: userdata, a2: userdata
    local AssemblyLinearVelocity = a1.AssemblyLinearVelocity
    local v1 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z)
    if 2 < v1.Magnitude then
        return v1.Unit
    end
    local LookVector = a2.CFrame.LookVector
    local v2 = Vector3.new(LookVector.X, 0, LookVector.Z)
    if 0.01 < v2.Magnitude then
        return v2.Unit
    end
    return (Vector3.new(-0, -0, -1))
end

local function floorBelow(a1, a2) -- Line: 359 -- upvalues: Workspace (val) -- types: a1: userdata, a2: table
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = a2
    v1.RespectCanCollide = true
    local v2 = Workspace:Raycast(a1.Position, Vector3.new(0, -160, 0), v1)
    if v2 then
        return v2.Position.Y
    end
    return a1.Position.Y - 50
end

local function mushroomTemplate() -- Line: 372 -- upvalues: ReplicatedStorage (val)
    local Dream = ReplicatedStorage.Assets.VFX.BanjoCricket:FindFirstChild("Dream")
    local Mushroom = Dream and Dream:FindFirstChild("Mushroom")
    if Mushroom and Mushroom:IsA("Model") then
        return Mushroom
    end
    return nil
end

local function restoreCamera(a1) -- Line: 379 -- types: a1: table
    if not a1.OwnsCamera then
        return
    end
    local Camera = a1.Camera
    Camera.FieldOfView = a1.FieldOfView
    local HandBack = a1.HandBack
    if HandBack then
        Camera.CFrame = HandBack
    end
    Camera.CameraType = Enum.CameraType.Custom
end

local function report(a1) -- Line: 392
    warn((("BanjoDream stopped: %*"):format((debug.traceback((tostring(a1)))))))
end

local function finish(a1) -- Line: 396 -- upvalues: u105 (ref) -- types: a1: table
    if u105 == a1 then
        u105 = nil
    end
    a1.Trove:Destroy()
end

local function landingFrame(a1, a2) -- Line: 405 -- types: a1: table, a2: number
    local v1 = a1.Root.Position + a1.SubjectOffset
    return CFrame.lookAt(v1 - a1.Landing * a2, v1)
end

local function reachOf(a1, a2) -- Line: 410 -- upvalues: Workspace (val) -- types: a1: table, a2: table
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = a2
    v1.RespectCanCollide = true
    local v2 = a1.Root.Position + a1.SubjectOffset
    local v3 = Workspace:Raycast(v2, -a1.Landing * a1.Zoom, v1)
    if v3 == nil then
        return a1.Zoom
    end
    return (math.max((v3.Position - v2).Magnitude - 0.6, 0.5))
end

local function pulseOf(a1, a2) -- Line: 425 -- types: a1: table, a2: number
    if a1.Calm then
        return 0
    end
    return (math.exp(-(a2 - a1.LubAt) * 9))
end

local function heartbeat(a1, a2) -- Line: 433 -- upvalues: Score (val) -- types: a1: table, a2: number
    if a1.Born then
        return
    end
    local DubAt = a1.DubAt
    if DubAt and DubAt <= a2 then
        a1.DubAt = nil
        Score.Thump(a1.Score, false)
    end
    if a2 < a1.NextBeat then
        return
    end
    Score.Thump(a1.Score, true)
    a1.LubAt = a2
    a1.DubAt = a2 + 0.16
    a1.NextBeat = a2 + (if a1.Phase ~= "Intro" then if a1.Phase ~= "Ride" then 0.36 else 0.4 else math.lerp(0.62, 0.4, a2 / a1.CutAt))
end

local function intro(a1, a2, a3) -- Line: 455
    -- upvalues: TweenService (val), Vortex (val), mix (val), u66 (val), u92 (val), u67 (val), u73 (val)
    local v1
    local CutAt = a1.CutAt
    local v2 = math.clamp(a2 / CutAt, 0, 1)
    local v3 = (a2 - CutAt * 0.6) / (CutAt * 0.4)
    local Quad = Enum.EasingStyle.Quad
    local In = Enum.EasingDirection.In
    local v4 = TweenService:GetValue(math.clamp(v3, 0, 1), Quad, In)
    local v5 = a2 / 0.35
    local Sine = Enum.EasingStyle.Sine
    local Out = Enum.EasingDirection.Out
    v3 = TweenService:GetValue(math.clamp(v5, 0, 1), Sine, Out)
    local Position = a1.Root.Position
    if not a1.Swallowed then
        v1 = math.min(a3 * 6, 1)
        local Center = a1.Center
        a1.Center = Vector3.new(math.lerp(Center.X, Position.X, v1), Center.Y, (math.lerp(Center.Z, Position.Z, v1)))
        a1.Swallowed = Position.Y < a1.Center.Y + 1
    end
    Vortex.Step(a1.Vortex, a1.Center, if not a1.Calm then a2 else a2 * 0.35, v3, if not a1.Calm then v4 else 0)
    a1.Glow.FillTransparency = math.lerp(1, 0.35, v2)
    a1.Glow.OutlineTransparency = math.lerp(1, 0.2, v2)
    a1.Glow.FillColor = Color3.fromHSV(a2 * 0.8 % 1, 0.6, 1)
    v1 = v2 / 0.8
    local Sine_2 = Enum.EasingStyle.Sine
    local In_2 = Enum.EasingDirection.In
    v5 = TweenService:GetValue(math.clamp(v1, 0, 1), Sine_2, In_2)
    mix(a1.Look, u66, if not a1.Calm then u67 else u92, v5)
    if not a1.Calm then
        mix(a1.Look, a1.Look, u73, v4)
    end
    if a1.OwnsCamera and not a1.Calm then
        local Camera = a1.Camera
        local CFrame_2 = Camera.CFrame
        v2 = a1.Center - Vector3.new(0, 6, 0) - CFrame_2.Position
        local LookVector = CFrame_2.LookVector
        if 0.01 < v2.Magnitude then
            LookVector = LookVector:Lerp(v2.Unit, 1 - (math.exp(a3 * -8))).Unit
        end
        local Heading = a1.Heading
        local v6 = 1 - (math.clamp(-LookVector.Y, 0, 1))
        v2 = Heading:Lerp(Vector3.new(0, 1, 0), v6)
        a1.Roll = a1.Roll + v4 * 7.3303828583761845 * v4 * a3
        local v7 = math.sin(a2 * 6) * 0.12217304763960307 * math.min(a2 / 0.4, 1)
        Camera.CFrame = (CFrame.lookAt(CFrame_2.Position, CFrame_2.Position + LookVector, v2)) * CFrame.Angles(0, 0, v7 + a1.Roll)
        Camera.FieldOfView = math.lerp(a1.FieldOfView + (math.sin(3.141592653589793 * (math.clamp(a2 / (CutAt * 0.6), 0, 1)))) * 16, 7, v4)
        return
    end
end

local function ride(a1, a2, a3, a4, a5) -- Line: 521
    -- upvalues: TweenService (val), Tunnel (val), mix (val), u92 (val), u98 (val), u73 (val), u79 (val)
    local v1 = a2 / 0.35
    local Quart = Enum.EasingStyle.Quart
    local Out = Enum.EasingDirection.Out
    local v2 = TweenService:GetValue(math.clamp(v1, 0, 1), Quart, Out)
    a1.Travel = a1.Travel + (if not a1.Calm then math.lerp(38, 95, v2) else 10) * a3
    Tunnel.Step(a1.Tunnel, if not a1.Calm then a4 else a4 * 0.35, a1.Travel, 0)
    if not a1.Calm then
        mix(a1.Look, u73, u79, v2)
        a1.Look.Tint = a1.Look.Tint:Lerp(Color3.fromHSV(v1 * 0.12 % 1, 0.22, 1), v2)
    else
        mix(a1.Look, u92, u98, v2)
    end
    if not a1.OwnsCamera then
        return
    end
    local Camera = a1.Camera
    if a1.Calm then
        Camera.CFrame = a1.Tunnel.Origin
        return
    end
    a1.Roll = a1.Roll + math.lerp(7.3303828583761845, 0.9599310885968813, v2) * a3
    Camera.CFrame = a1.Tunnel.Origin * CFrame.Angles(0, 0, a1.Roll)
    Camera.FieldOfView = (math.lerp(7, 100, v2)) + a5 * 4
end

local function birth(a1) -- Line: 559 -- upvalues: Score (val), reachOf (val) -- types: a1: table
    a1.Born = true
    a1.TunnelTrove:Destroy()
    Score.Birth(a1.Score)
    local Root = a1.Root
    local LookVector = Root.CFrame.LookVector
    local v1 = Vector3.new(LookVector.X, 0, LookVector.Z)
    local Unit = if not (0.01 < v1.Magnitude) then a1.Heading else v1.Unit
    a1.Landing = Unit * 0.9781476007338057 + Vector3.new(-0, -0.2079116851091385, -0)
    local Parent = Root.Parent
    local v2 = {a1.Burst.Wave.Hub}
    if Parent then
        table.insert(v2, Parent)
    end
    a1.Reach = reachOf(a1, v2)
    local Burst = a1.Burst
    Burst.Anchor.WorldPosition = Root.Position
    Burst.Spores:Emit(60)
    Burst.Notes:Emit(10)
end

local function handBack(a1) -- Line: 581 -- upvalues: Score (val), finish (val) -- types: a1: table
    local Reach = a1.Reach
    local v1 = a1.Root.Position + a1.SubjectOffset
    a1.HandBack = CFrame.lookAt(v1 - a1.Landing * Reach, v1)
    a1.Scenery:Destroy()
    Score.Release(a1.Score)
    a1.Trove:Add((task.delay(2.6, finish, a1)))
end

local function outro(a1, a2, a3, a4) -- Line: 588
    -- upvalues: TweenService (val), Tunnel (val), mix (val), u98 (val), u92 (val), u79 (val), u80 (val), birth (val)
    -- upvalues: handBack (val), u66 (val), ease (val), u86 (val), Shapes (val)
    local v1, v2
    local Camera = a1.Camera
    if a2 < 0.5 then
        v2 = a2 / 0.5
        local Quad = Enum.EasingStyle.Quad
        local In = Enum.EasingDirection.In
        v1 = TweenService:GetValue(math.clamp(v2, 0, 1), Quad, In)
        a1.Travel = a1.Travel + (if not a1.Calm then math.lerp(95, 210, v1) else 10) * a3
        Tunnel.Step(a1.Tunnel, if not a1.Calm then a4 else a4 * 0.35, a1.Travel, if not a1.Calm then v1 else 0)
        if not a1.Calm then
            mix(a1.Look, u79, u80, v1)
            a1.Look.Tint = (Color3.fromHSV(v2 * 0.12 % 1, 0.22, 1)):Lerp(u80.Tint, v1)
        else
            mix(a1.Look, u98, u92, v1)
        end
        if a1.OwnsCamera and not a1.Calm then
            a1.Roll = a1.Roll + (v1 * 3 + 1) * 0.9599310885968813 * a3
            Camera.CFrame = a1.Tunnel.Origin * CFrame.Angles(0, 0, a1.Roll)
            Camera.FieldOfView = math.lerp(100, 118, v1)
            return
        end
        return
    end
    if not a1.Born then
        birth(a1)
    end
    v1 = (a2 - 0.5) / 1.7
    if v1 >= 1 then
        handBack(a1)
        return
    end
    if a1.Calm then
        mix(a1.Look, u92, u66, ease(v1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
    elseif not (v1 < 0.4) then
        mix(a1.Look, u86, u66, ease((v1 - 0.4) / 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
    else
        mix(a1.Look, u80, u86, ease(v1 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
    end
    a1.Glow.FillTransparency = math.lerp(0.25, 1, (math.min(v1 / 0.6, 1)))
    a1.Glow.OutlineTransparency = math.lerp(0, 1, (math.min(v1 / 0.6, 1)))
    a1.Glow.FillColor = Color3.fromHSV(a4 * 0.8 % 1, 0.6, 1)
    local Wave = a1.Burst.Wave
    local v3 = v1 * 1.7 / 0.8
    local Quad_2 = Enum.EasingStyle.Quad
    local Out = Enum.EasingDirection.Out
    local v4 = TweenService:GetValue(math.clamp(v3, 0, 1), Quad_2, Out)
    Shapes.Resize(Wave, (math.lerp(1, 24, v4)))
    Shapes.SetWidth(Wave, (1 - v4) * 1.6)
    Wave.Hub.CFrame = (CFrame.new(a1.Root.Position - Vector3.new(0, 1, 0) * a1.Stance)) * CFrame.Angles(-1.5707963267948966, 0, 0)
    if not a1.OwnsCamera then
        return
    end
    if a1.Calm then
        local Reach = a1.Reach
        v4 = a1.Root.Position + a1.SubjectOffset
        Camera.CFrame = CFrame.lookAt(v4 - a1.Landing * Reach, v4)
        return
    end
    local Back = Enum.EasingStyle.Back
    local Out_2 = Enum.EasingDirection.Out
    v2 = TweenService:GetValue(math.clamp(v1, 0, 1), Back, Out_2)
    local Quint = Enum.EasingStyle.Quint
    local Out_3 = Enum.EasingDirection.Out
    local v5 = math.lerp(2.5, a1.Reach, (TweenService:GetValue(math.clamp(v1, 0, 1), Quint, Out_3)))
    v1 = a1.Root.Position + a1.SubjectOffset
    Camera.CFrame = (CFrame.lookAt(v1 - a1.Landing * v5, v1)) * CFrame.Angles(0, 0, (1 - v2) * 0.4886921905584123)
    Camera.FieldOfView = math.lerp(112, a1.FieldOfView, v2)
end

local function canWake(a1, a2, a3) -- Line: 679 -- types: a1: table, a2: number, a3: number
    if a2 - a1.PhaseAt < 0.7 then
        return false
    end
    if a3 >= 6 then
        return true
    end
    local RevealedAt = a1.RevealedAt
    if RevealedAt == nil then
        return false
    end
    return a1.Moved or 2.5 <= a2 - RevealedAt
end

local function step(a1, a2) -- Line: 693
    -- upvalues: Score (val), heartbeat (val), intro (val), ride (val), outro (val)
    local Moved, RevealedAt
    local v1 = os.clock()
    local v2 = v1 - a1.StartedAt
    local Position = a1.Root.Position
    if a1.Phase ~= "Intro" and 12 < (Position - a1.LastRoot).Magnitude then
        a1.Moved = true
    end
    a1.LastRoot = Position
    if a1.Phase ~= "Intro" then
        if a1.Phase == "Ride" then
            if v1 - a1.PhaseAt < 0.7 then
                Moved = false
            elseif not (v2 >= 6) then
                RevealedAt = a1.RevealedAt
                Moved = if RevealedAt ~= nil then a1.Moved or 2.5 <= v1 - RevealedAt else false
            else
                Moved = true
            end
            if Moved then
                a1.Phase = "Outro"
                a1.PhaseAt = v1
                Score.Wake(a1.Score)
            end
        end
    elseif a1.CutAt <= v2 then
        a1.Phase = "Ride"
        a1.PhaseAt = v1
        a1.VortexTrove:Destroy()
        Score.Plunge(a1.Score)
        if a1.OwnsCamera then
            a1.Camera.CameraType = Enum.CameraType.Scriptable
        end
    elseif a1.Phase == "Ride" then
        if v1 - a1.PhaseAt < 0.7 then
            Moved = false
        elseif not (v2 >= 6) then
            RevealedAt = a1.RevealedAt
            Moved = if RevealedAt ~= nil then a1.Moved or 2.5 <= v1 - RevealedAt else false
        else
            Moved = true
        end
        if Moved then
            a1.Phase = "Outro"
            a1.PhaseAt = v1
            Score.Wake(a1.Score)
        end
    end
    heartbeat(a1, v2)
    local v3 = if not a1.Calm then math.exp(-(v2 - a1.LubAt) * 9) else 0
    local v4 = v1 - a1.PhaseAt
    local Moment = a1.Moment
    Moment.Phase = a1.Phase
    Moment.Time = v4
    Moment.Length = if a1.Phase ~= "Intro" then 0.5 else a1.CutAt
    Score.Step(a1.Score, Moment)
    if a1.Phase == "Intro" then
        intro(a1, v4, a2)
    elseif a1.Phase ~= "Ride" then
        outro(a1, v4, a2, v2)
    else
        ride(a1, v4, a2, v2, v3)
    end
    if a1.HandBack == nil then
        local Look = a1.Look
        local Grade = a1.Grade
        Grade.Color.Brightness = Look.Brightness + v3 * 0.04
        Grade.Color.Contrast = Look.Contrast
        Grade.Color.Saturation = Look.Saturation
        Grade.Color.TintColor = Look.Tint
        Grade.Bloom.Intensity = Look.Bloom + v3 * 0.3
        Grade.Blur.Size = Look.Blur
    end
end

local function build(a1, a2, a3) -- Line: 737
    -- upvalues: Workspace (val), BanjoCricket (val), u65 (val), GuiService (val), u66 (val), grade (val), Vortex (val)
    -- upvalues: Tunnel (val), u60 (val), ReplicatedStorage (val), Score (val), burst (val)
    local Unit
    local CurrentCamera = Workspace.CurrentCamera
    local Humanoid = a2:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = a2:FindFirstChild("HumanoidRootPart")
    assert(CurrentCamera, "no camera to dream through")
    assert(Humanoid, "the dreamer has no humanoid")
    assert(HumanoidRootPart and HumanoidRootPart:IsA("BasePart"), "the dreamer has no root part")
    local v1 = os.clock()
    local v2 = a1:Extend()
    local v3 = v2:Add((Instance.new("Folder")))
    v3.Name = "BanjoDream"
    v3.Parent = CurrentCamera
    local v4 = v2:Extend()
    local v5 = v2:Extend()
    local v6 = {}
    local v7 = nil
    for i, j in BanjoCricket.Mushrooms, nil, v7 do
        table.insert(v6, j.Color)
    end
    local v8 = CurrentCamera.Focus.Position - HumanoidRootPart.Position
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
    local v9 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z)
    if not (2 < v9.Magnitude) then
        local LookVector = CurrentCamera.CFrame.LookVector
        v7 = Vector3.new(LookVector.X, 0, LookVector.Z)
        Unit = if not (0.01 < v7.Magnitude) then Vector3.new(-0, -0, -1) else v7.Unit
    else
        Unit = v9.Unit
    end
    local v10 = RaycastParams.new()
    v10.FilterType = Enum.RaycastFilterType.Exclude
    v10.FilterDescendantsInstances = {a2, v3}
    v10.RespectCanCollide = true
    local v11 = Workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -160, 0), v10)
    local Y = if not v11 then HumanoidRootPart.Position.Y - 50 else v11.Position.Y
    v9 = math.clamp(a3 * 0.5, 0.8, 1.3)
    v10 = v2:Add((Instance.new("Highlight")))
    v10.Name = "BanjoDream"
    v10.DepthMode = Enum.HighlightDepthMode.Occluded
    v10.FillTransparency = 1
    v10.OutlineTransparency = 1
    v10.OutlineColor = u65
    v10.Adornee = a2
    v10.Parent = v3
    local u137 = {
        Trove = a1,
        Scenery = v2,
        VortexTrove = v4,
        TunnelTrove = v5,
        Camera = CurrentCamera,
        Root = HumanoidRootPart,
        Calm = GuiService.ReducedMotionEnabled,
    }
    u137.OwnsCamera = CurrentCamera.CameraType == Enum.CameraType.Custom
    u137.StartedAt = v1
    u137.CutAt = v9
    u137.Phase = "Intro"
    u137.PhaseAt = v1
    u137.Moment = {Phase = "Intro", Time = 0, Length = v9}
    u137.LastRoot = HumanoidRootPart.Position
    u137.Moved = false
    u137.FieldOfView = CurrentCamera.FieldOfView
    u137.Zoom = math.max((CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude, 0.5)
    u137.SubjectOffset = if not (v8.Magnitude < 4) then Vector3.new(0, 1.5, 0) else v8
    u137.Heading = Unit
    u137.Center = Vector3.new(HumanoidRootPart.Position.X, Y + 6, HumanoidRootPart.Position.Z)
    u137.Swallowed = false
    u137.Roll = 0
    u137.Travel = 0
    u137.NextBeat = 0.3
    u137.LubAt = (-1 / 0)
    u137.Stance = if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2 else 3
    u137.Born = false
    u137.Landing = Unit
    u137.Reach = 0
    u137.Look = table.clone(u66)
    u137.Grade = grade(v2, CurrentCamera)
    u137.Glow = v10
    u137.Vortex = Vortex.Build(v4, v3, v6)
    local Build = Tunnel.Build
    local v12 = {Origin = u60, Palette = v6}
    local Dream = ReplicatedStorage.Assets.VFX.BanjoCricket:FindFirstChild("Dream")
    local Mushroom = Dream and Dream:FindFirstChild("Mushroom")
    v12.Mushroom = if not Mushroom then nil else if not Mushroom:IsA("Model") then nil else Mushroom
    u137.Tunnel = Build(v5, v3, v12)
    u137.Score = Score.Build(a1)
    u137.Burst = burst(v2, v3)
    v2:Add(function() -- Line: 825 -- upvalues: u137 (val)
        local v1 = u137
        if not v1.OwnsCamera then
            return
        end
        local Camera = v1.Camera
        Camera.FieldOfView = v1.FieldOfView
        local HandBack = v1.HandBack
        if HandBack then
            Camera.CFrame = HandBack
        end
        Camera.CameraType = Enum.CameraType.Custom
    end)
    return u137
end

local function begin(a1) -- Line: 831
    -- upvalues: u105 (ref), Workspace (val), LocalPlayer (val), Trove (val), build (val), Score (val), u55 (val)
    -- upvalues: step (val), report (val)
    local v1 = u105
    if v1 then
        if u105 == v1 then
            u105 = nil
        end
        v1.Trove:Destroy()
    end
    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if CurrentCamera ~= nil
        and Character ~= nil
        and Humanoid ~= nil
        and not (Humanoid.Health <= 0)
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart") then
        local v2 = Trove.new()
        local success, err = pcall(build, v2, Character, a1)
        if not success then
            warn((("BanjoDream could not start: %*"):format(err)))
            v2:Destroy()
            return
        end
        u105 = err
        v2:Connect(Humanoid.Died, function() -- Line: 859 -- upvalues: err (val), u105 (upval)
            local v1 = err
            if u105 == v1 then
                u105 = nil
            end
            v1.Trove:Destroy()
        end)
        v2:Connect(LocalPlayer.CharacterAdded, function() -- Line: 862 -- upvalues: err (val), u105 (upval)
            local v1 = err
            if u105 == v1 then
                u105 = nil
            end
            v1.Trove:Destroy()
        end)
        Score.Fall(err.Score, err.CutAt)
        err.Scenery:BindToRenderStep("BanjoDream", u55, function(a1) -- Line: 869 -- upvalues: step (upval), report (upval), err (val), u105 (upval) -- types: a1: number
            local success = xpcall(step, report, err, a1)
            if not success then
                local v1 = err
                if u105 == v1 then
                    u105 = nil
                end
                v1.Trove:Destroy()
            end
        end)
        return
    end
end

local function reveal() -- Line: 877 -- upvalues: u105 (ref)
    local v1 = u105
    if v1 and v1.RevealedAt == nil then
        v1.RevealedAt = os.clock()
    end
end

function v1.Start() -- Line: 884 -- upvalues: Score (val), Remotes (val), BanjoCricket (val), begin (val), u105 (ref)
    Score.Warm()
    Remotes.EnchantedTree.Transition.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 887 -- upvalues: BanjoCricket (upval), begin (upval), u105 (upval)
        if a3 ~= BanjoCricket.DreamTransition then
            return
        end
        if a1 == "Cover" then
            begin(if typeof(a4) ~= "number" then 1.6 else a4)
            return
        end
        if a1 == "Reveal" then
            local v1 = u105
            if v1 and v1.RevealedAt == nil then
                v1.RevealedAt = os.clock()
            end
        end
    end)
end

return (table.freeze(v1))