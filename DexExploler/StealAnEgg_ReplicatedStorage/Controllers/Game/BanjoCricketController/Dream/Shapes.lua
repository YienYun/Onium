-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Dream.Shapes
-- Decompile time: 2.45 ms

local u0 = {}

function u0.Part(a1, a2) -- Line: 23 -- types: a1: string, a2: vector
    local Part = Instance.new("Part")
    Part.Name = a1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Size = a2
    return Part
end

function u0.Resize(a1, a2) -- Line: 40 -- types: a1: table, a2: number
    local v1, v2, v3
    for i, j in a1.Corners do
        v1 = (i - 1) * 3.141592653589793 / 2
        v2 = Vector3.new(math.cos(v1), math.sin(v1), 0)
        v3 = Vector3.new(-math.sin(v1), math.cos(v1), 0)
        j.CFrame = CFrame.fromMatrix(v2 * a2, v3, v2)
    end
    local v4 = a2 * 0.5522847498307933
    for k, n in a1.Beams do
        n.CurveSize0 = v4
        n.CurveSize1 = v4
    end
end

function u0.Circle(a1, a2) -- Line: 55 -- upvalues: u0 (val) -- types: a1: string, a2: number
    local Attachment, Beam
    local v1 = u0.Part(a1, (Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)))
    v1.Transparency = 1
    local v2 = {}
    for i = 1, 4 do
        Attachment = Instance.new("Attachment")
        Attachment.Name = ("Corner%*"):format(i)
        Attachment.Parent = v1
        table.insert(v2, Attachment)
    end
    local v3 = {}
    for j, k in v2 do
        Beam = Instance.new("Beam")
        Beam.Attachment0 = k
        Beam.Attachment1 = v2[j % 4 + 1]
        Beam.FaceCamera = true
        Beam.Segments = 12
        Beam.Width0 = 0
        Beam.Width1 = 0
        Beam.LightEmission = 1
        Beam.LightInfluence = 0
        Beam.Brightness = 2
        Beam.Parent = v1
        table.insert(v3, Beam)
    end
    local v4 = {Hub = v1, Corners = v2, Beams = v3}
    u0.Resize(v4, a2)
    return v4
end

function u0.Paint(a1, a2, a3) -- Line: 87 -- types: a1: table, a2: number, a3: number
    local new, v1, v2, v3
    for i, j in a1.Beams do
        v2 = a2 + (i - 1) / 4 * a3
        v3 = a2 + i / 4 * a3
        new = ColorSequence.new
        v1 = Color3.fromHSV(v2 % 1, 1, 1)
        j.Color = new(v1, Color3.fromHSV(v3 % 1, 1, 1))
    end
end

function u0.SetWidth(a1, a2) -- Line: 98 -- types: a1: table, a2: number
    for i, j in a1.Beams do
        j.Width0 = a2
        j.Width1 = a2
    end
end

return table.freeze(u0)