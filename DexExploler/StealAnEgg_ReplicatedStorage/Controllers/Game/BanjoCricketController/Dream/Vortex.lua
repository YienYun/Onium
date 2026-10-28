-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Dream.Vortex
-- Decompile time: 7.37 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Shapes = require(script.Parent.Shapes)
require(ReplicatedStorage.Packages.Trove)
local u28 = Color3.fromRGB(255, 236, 252)
local v1 = {}

local function rainbow() -- Line: 62
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 220)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(90, 200, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 255, 120)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 230, 90)),
        (ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))),
    })
end

local function fadeOut(a1) -- Line: 72 -- types: a1: number
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, a1),
        NumberSequenceKeypoint.new(0.7, a1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
end

local function arm(a1, a2, a3) -- Line: 82 -- types: a1: userdata, a2: number, a3: CFrame
    local v1 = (a2 - 1) / 7 * 3.141592653589793 * 2
    local v2 = Vector3.new(math.cos(v1), math.sin(v1), 0)
    local v3 = Vector3.new(-math.sin(v1), math.cos(v1), 0)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = ("Rim%*"):format(a2)
    Attachment.CFrame = CFrame.fromMatrix(v2 * 36 * 0.9, v3, v2)
    Attachment.Parent = a1
    v3 = v1 + 1.9
    v2 = Vector3.new(math.cos(v3), math.sin(v3), 0)
    v1 = Vector3.new(-math.sin(v3), math.cos(v3), 0)
    v3 = Instance.new("Attachment")
    v3.Name = ("Eye%*"):format(a2)
    v3.CFrame = CFrame.fromMatrix(v2 * 1.2, -v2, v1)
    v3.Parent = a1
    v2 = Instance.new("Beam")
    v2.Attachment0 = Attachment
    v2.Attachment1 = v3
    v2.CurveSize0 = 19.8
    v2.CurveSize1 = 10.799999999999999
    v2.FaceCamera = true
    v2.Segments = 16
    v2.Width0 = 3.2
    v2.Width1 = 0.35
    v2.LightEmission = 1
    v2.LightInfluence = 0
    v2.Brightness = 1.6
    v2.Color = ColorSequence.new(a3, Color3.new(1, 1, 1))
    v2.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.5, 0.2),
        (NumberSequenceKeypoint.new(1, 0)),
    })
    v2.Enabled = false
    v2.Parent = a1
    return v2
end

local function sparkles(a1) -- Line: 120 -- upvalues: fadeOut (val), rainbow (val) -- types: a1: userdata
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Sparkles"
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Cylinder
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
    ParticleEmitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
    ParticleEmitter.Rate = 0
    ParticleEmitter.Speed = NumberRange.new(30, 46)
    ParticleEmitter.Lifetime = NumberRange.new(0.75, 1.05)
    ParticleEmitter.LockedToPart = true
    ParticleEmitter.Size = NumberSequence.new(1, 0.15)
    ParticleEmitter.Transparency = fadeOut(0)
    ParticleEmitter.Color = rainbow()
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Brightness = 2
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.RotSpeed = NumberRange.new(-180, 180)
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

local function flare(a1) -- Line: 144 -- upvalues: u28 (val) -- types: a1: userdata
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Flare"
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.Rate = 0
    ParticleEmitter.Speed = NumberRange.new(0)
    ParticleEmitter.Lifetime = NumberRange.new(0.35, 0.5)
    ParticleEmitter.LockedToPart = true
    ParticleEmitter.Size = NumberSequence.new(5.3999999999999995, 9)
    ParticleEmitter.Transparency = NumberSequence.new(0.3, 1)
    ParticleEmitter.Color = ColorSequence.new(u28)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Brightness = 3
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.RotSpeed = NumberRange.new(-240, 240)
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

function v1.Build(a1, a2, a3) -- Line: 163
    -- upvalues: Shapes (val), u28 (val), arm (val), sparkles (val), flare (val)
    local v1, v2
    local v3 = a1:Add((Shapes.Part("WhirlpoolFloor", (Vector3.new(0, 0, 0)))))
    v3.Shape = Enum.PartType.Cylinder
    local v4 = a1:Add((Shapes.Part("WhirlpoolEye", (Vector3.new(0, 0, 0)))))
    v4.Shape = Enum.PartType.Ball
    v4.Color = u28
    local v5 = {}
    for i = 1, 6 do
        v2 = Shapes.Circle(("WhirlpoolRing%*"):format(i), 0.1)
        a1:Add(v2.Hub)
        Shapes.Paint(v2, (i - 1) / 6, 0.45)
        table.insert(v5, v2)
    end
    local v6 = a1:Add((Shapes.Part("WhirlpoolArms", (Vector3.new(1, 1, 1)))))
    v6.Transparency = 1
    local v7 = {}
    for j = 1, 7 do
        v1 = a3[(j - 1) % #a3 + 1]
        table.insert(v7, (arm(v6, j, v1)))
    end
    local v8 = a1:Add((Shapes.Part("WhirlpoolPull", (Vector3.new(68.4000015258789, 3, 68.4000015258789)))))
    v8.Transparency = 1
    v2 = {v3, v4, v6, v8}
    for k, n in v5 do
        table.insert(v2, n.Hub)
    end
    for m, i5 in v2 do
        i5.Parent = a2
    end
    return {
        Floor = v3,
        Eye = v4,
        Rings = v5,
        Arms = v6,
        ArmBeams = v7,
        Pull = v8,
        Sparkles = sparkles(v8),
        Flare = flare(v4),
        Moving = v2,
        Frames = table.create(#v2),
    }
end

function v1.Step(a1, a2, a3, a4, a5) -- Line: 214
    -- upvalues: TweenService (val), Shapes (val), Workspace (val)
    local Resize, v1, v2, v3, v4
    local v5 = (CFrame.new(a2)) * CFrame.Angles(-1.5707963267948966, 0, 0)
    local Frames = a1.Frames
    local v6 = math.clamp(a4, 0, 1) * 72
    a1.Floor.Size = Vector3.new(0.6, v6, v6)
    a1.Floor.Color = Color3.fromHSV(math.sin(a3 * 1.3) * 0.06 + 0.8, 0.9, 0.42)
    Frames[1] = (CFrame.new(a2)) * CFrame.Angles(0, 0, 1.5707963267948966)
    v6 = (math.sin(a3 * 14)) * 0.08 + 1
    local v7 = math.lerp(a4 * 4.5, 7, a5) * v6
    a1.Eye.Size = Vector3.new(1, 1, 1) * math.max(v7, 0.05)
    Frames[2] = (CFrame.new(a2 + Vector3.new(0, 1, 0)))
    Frames[3] = v5 * CFrame.new(0, 0, 0.5) * CFrame.Angles(0, 0, a3 * -2.6)
    Frames[4] = (CFrame.new(a2 + Vector3.new(0, 1, 0))) * CFrame.Angles(0, a3 * 0.9, 0)
    local Rings = a1.Rings
    local v8 = nil
    local v9 = nil
    local v10, v11 = a4, a3
    for i, j in Rings, v8, v9 do
        v7 = (i - 1) / 5
        v6 = TweenService:GetValue(math.clamp(v10 * 1.5 - (i - 1) * 0.12, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        v1 = math.sin(v11 * 5 + i) * 0.06 + 1
        v2 = math.lerp(5, 33.120000000000005, v7)
        Resize = Shapes.Resize
        v4 = v2 * v6 * v1
        Resize(j, (math.max(v4, 0.05)))
        Shapes.SetWidth(j, math.clamp(v6, 0, 1) * 1.2)
        v3 = v11 * 1.6
        v2 = v3 * (if i % 2 ~= 0 then -1 else 1)
        v3 = i + 4
        Frames[v3] = v5 * CFrame.new(0, 0, 0.4) * CFrame.Angles(0, 0, v2)
    end
    v5 = v10 >= 0.25
    for k, n in v12.ArmBeams do
        n.Enabled = v5
    end
    v12.Sparkles.Rate = v10 * 150
    v12.Flare.Rate = v10 * 24
    Workspace:BulkMoveTo(v12.Moving, Frames, Enum.BulkMoveMode.FireCFrameChanged)
end

return table.freeze(v1)