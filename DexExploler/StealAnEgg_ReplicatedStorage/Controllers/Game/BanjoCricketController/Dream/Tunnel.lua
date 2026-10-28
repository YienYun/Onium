-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Dream.Tunnel
-- Decompile time: 11.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Shapes = require(script.Parent.Shapes)
require(ReplicatedStorage.Packages.Trove)
local u19 = {"rbxassetid://243331916", "rbxassetid://6337277439"}
local u27 = Color3.fromRGB(255, 230, 250)
local u28 = {}

local function wall(a1, a2) -- Line: 72 -- upvalues: Shapes (val), u19 (val) -- types: a1: userdata, a2: number
    local v1 = Shapes.Part(("Wall%*"):format(a2), (Vector3.new(4.814869403839111, 0.30000001192092896, 158)))
    v1.CFrame = a1 * CFrame.Angles(0, 0, (a2 - 0.5) / 14 * 3.141592653589793 * 2) * CFrame.new(0, 10, -71)
    local Texture = Instance.new("Texture")
    Texture.Texture = u19[a2 % #u19 + 1]
    Texture.Face = Enum.NormalId.Bottom
    Texture.StudsPerTileU = 6
    Texture.StudsPerTileV = 6
    Texture.Transparency = 0.2
    Texture.Parent = v1
    return v1, Texture
end

local function dreamer(a1, a2, a3) -- Line: 94 -- types: a1: userdata, a2: CFrame, a3: number
    local v1 = a1:Clone()
    v1:ScaleTo(0.42)
    local Pivot = v1:GetPivot()
    local v2 = {}
    local v3 = {}
    local v4, v5 = a3, a2
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = false
            if j.Name == "Cap" then
                j.Material = Enum.Material.Neon
                j.Color = v5
            elseif j.Name == "Spots" then
                j.Material = Enum.Material.Neon
            end
            table.insert(v2, j)
            table.insert(v3, (Pivot:ToObjectSpace(j.CFrame)))
        end
    end
    return {Model = v1, Parts = v2, Offsets = v3, Phase = v4}
end

local function stream(a1, a2) -- Line: 121 -- upvalues: Shapes (val) -- types: a1: userdata, a2: string
    local v1 = Shapes.Part(a2, (Vector3.new(17, 17, 0.5)))
    v1.Transparency = 1
    v1.CFrame = a1 * CFrame.new(0, 0, -144)
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = a2
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Disc
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    ParticleEmitter.ShapePartial = 0.45
    ParticleEmitter.EmissionDirection = Enum.NormalId.Back
    ParticleEmitter.Parent = v1
    return v1, ParticleEmitter
end

local function streaks(a1) -- Line: 137 -- types: a1: userdata
    a1.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    a1.Rate = 90
    a1.Speed = NumberRange.new(120, 170)
    a1.Lifetime = NumberRange.new(1, 1.25)
    a1.Orientation = Enum.ParticleOrientation.VelocityParallel
    a1.Squash = NumberSequence.new(2)
    a1.Size = NumberSequence.new(0.35)
    a1.Transparency = NumberSequence.new(0.1)
    a1.LightEmission = 1
    a1.Brightness = 2.5
    a1.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 200)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(80, 220, 255)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 240, 90)),
        (ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))),
    })
end

local function notes(a1, a2) -- Line: 156 -- types: a1: userdata, a2: table
    local v1
    local v2 = {}
    local v3 = nil
    local v4 = nil
    local v5 = a2
    for i, j in a2, v3, v4 do
        v1 = if not (#v5 > 1) then 0 else (i - 1) / (#v5 - 1)
        table.insert(v2, (ColorSequenceKeypoint.new(v1, j)))
    end
    if #v2 == 1 then
        table.insert(v2, (ColorSequenceKeypoint.new(1, v2[1].Value)))
    end
    v6.Rate = 9
    v6.Speed = NumberRange.new(45, 70)
    v6.Lifetime = NumberRange.new(2.4, 3)
    v6.Size = NumberSequence.new(1.6, 2.6)
    v6.Transparency = NumberSequence.new(0)
    v6.LightEmission = 0.6
    v6.Brightness = 2
    v6.Rotation = NumberRange.new(-30, 30)
    v6.RotSpeed = NumberRange.new(-60, 60)
    v6.Color = ColorSequence.new(v2)
end

function u28.Step(a1, a2, a3, a4) -- Line: 182
    -- upvalues: Shapes (val), Workspace (val)
    local Paint, v1, v2, v3, v4, v5, v6, v7
    local Origin = a1.Origin
    local Frames = a1.Frames
    for i, j in a1.Walls do
        v1 = (i - 1) / 14 + a2 * 0.15
        j.Color = Color3.fromHSV(v1 % 1, 0.85, 0.6)
        a1.Tiles[i].OffsetStudsV = a3
    end
    Frames[1] = Origin * CFrame.new(0, 0, -(math.lerp(146, 5, a4))) * CFrame.Angles(0, 1.5707963267948966, 0)
    local Rings = a1.Rings
    local v8 = nil
    local v9 = nil
    local v10, v11, v12 = a1, a2, a3
    for k, n in Rings, v8, v9 do
        v7 = (k * 15 - v12) % 150
        if v10.RingDistances[k] + 15 < v7 then
            Paint = Shapes.Paint
            v4 = v11 * 0.37 % 1
            Paint(n, v4, 0.5)
        end
        v10.RingDistances[k] = v7
        v3 = v11 * 1.4
        v2 = v3 * (if k % 2 ~= 0 then -1 else 1)
        v3 = k + 1
        Frames[v3] = Origin * CFrame.new(0, 0, -v7 - 1) * CFrame.Angles(0, 0, v2)
    end
    local v13 = #v10.Rings + 1
    v9 = nil
    local v14 = nil
    for m, i5 in v10.Dreamers, v9, v14 do
        v3 = (i5.Phase * 150 - v12 * 0.55) % 150
        v4 = v11 * 0.8 + i5.Phase * 3.141592653589793 * 2
        v5 = Vector3.new(1.7000000476837158, 1.100000023841858, 0.6000000238418579) * (v11 + i5.Phase * 4)
        v6 = Origin * CFrame.new(math.cos(v4) * 5.6, math.sin(v4) * 5.6, -v3 - 2) * CFrame.Angles(v5.X, v5.Y, v5.Z)
        for i6, i7 in i5.Offsets do
            Frames[v13 + i6] = v6 * i7
        end
        v13 = v13 + #i5.Offsets
    end
    Workspace:BulkMoveTo(v10.Moving, Frames, Enum.BulkMoveMode.FireCFrameChanged)
end

function u28.Build(a1, a2, a3) -- Line: 236
    -- upvalues: wall (val), Shapes (val), u27 (val), dreamer (val), stream (val), streaks (val), u19 (val), notes (val)
    -- upvalues: u28 (val)
    local v1, v2, v3, v4, v5, v6
    local Origin = a3.Origin
    local v7 = {}
    local v8 = {}
    local v9 = {}
    for i = 1, 14 do
        v1, v2 = wall(Origin, i)
        table.insert(v8, v1)
        table.insert(v9, v2)
        table.insert(v7, v1)
    end
    local v10 = Shapes.Part("EndLight", (Vector3.new(0.30000001192092896, 22, 22)))
    v10.Shape = Enum.PartType.Cylinder
    v10.Color = u27
    table.insert(v7, v10)
    local v11 = {}
    local v12 = {}
    for j = 1, 10 do
        v4 = Shapes.Circle(("Ring%*"):format(j), 8.7)
        Shapes.SetWidth(v4, 0.9)
        Shapes.Paint(v4, j / 10, 0.5)
        table.insert(v11, v4)
        table.insert(v12, 0)
        table.insert(v7, v4.Hub)
    end
    v1 = {}
    local Mushroom = a3.Mushroom
    if Mushroom then
        local v13
        for k, n in a3.Palette do
            v13 = dreamer(Mushroom, n, (k - 1) / #a3.Palette)
            table.insert(v1, v13)
            table.insert(v7, v13.Model)
        end
    end
    v3, v4 = stream(Origin, "Streaks")
    streaks(v4)
    table.insert(v7, v3)
    for m, i5 in u19 do
        v5, v6 = stream(Origin, (("Notes%*"):format(m)))
        notes(v6, a3.Palette)
        v6.Texture = i5
        table.insert(v7, v5)
    end
    for i6, i7 in v7 do
        a1:Add(i7)
        i7.Parent = a2
    end
    v4 = {v10}
    for i8, i9 in v11 do
        table.insert(v4, i9.Hub)
    end
    local v14 = nil
    local v15 = nil
    for i10, i11 in v1, v14, v15 do
        for i12, i13 in i11.Parts do
            table.insert(v4, i13)
        end
    end
    v3 = {
        Origin = Origin,
        Walls = v8,
        Tiles = v9,
        Rings = v11,
        RingDistances = v12,
        Light = v10,
        Dreamers = v1,
        Moving = v4,
        Frames = table.create(#v4),
    }
    u28.Step(v3, 0, 0, 0)
    return v3
end

return table.freeze(u28)