-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Depths
-- Decompile time: 55.79 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Kit = require(script.Parent.Kit)
require(ReplicatedStorage.Packages.Trove)
local u57 = table.freeze({
    Vector2.new(4, 1.6),
    Vector2.new(10.5, 2.4),
    Vector2.new(15.5, 1.2),
    Vector2.new(22, 2),
    Vector2.new(27.5, 1.4),
    Vector2.new(34, 2.6),
    Vector2.new(41, 1.6),
    Vector2.new(46.5, 2.2),
    (Vector2.new(52, 1.4)),
})
local u65 = table.freeze({74, 80, 86, 92})
local u72 = table.freeze({70, 31, -8, -47})
local u77 = Color3.fromRGB(3, 20, 22)
local u82 = Color3.fromRGB(3, 14, 12)
local u87 = Color3.fromRGB(255, 140, 50)
local u92 = Color3.fromRGB(14, 52, 66)
local u97 = Color3.fromRGB(46, 96, 52)
local u102 = Color3.fromRGB(60, 43, 30)
local u107 = Color3.fromRGB(53, 38, 27)
local u112 = Color3.fromRGB(28, 21, 15)
local u117 = Color3.fromRGB(38, 50, 40)
local u122 = Color3.fromRGB(5, 16, 11)
local u127 = Color3.fromRGB(24, 44, 50)
local u132 = Color3.fromRGB(10, 24, 28)
local u137 = Color3.fromRGB(18, 30, 40)
local u142 = Color3.fromRGB(6, 14, 18)
local u147 = Color3.fromRGB(20, 36, 38)
local u152 = Color3.fromRGB(58, 40, 28)
local u157 = Color3.fromRGB(26, 74, 52)
local u162 = Color3.fromRGB(16, 46, 36)
local u167 = Color3.fromRGB(46, 38, 32)
local u172 = Color3.fromRGB(30, 44, 42)
local u177 = Color3.fromRGB(20, 27, 21)
local u182 = Color3.fromRGB(56, 58, 38)
local u187 = Color3.fromRGB(30, 31, 20)
local u192 = Color3.fromRGB(104, 104, 76)
local u197 = Color3.fromRGB(52, 124, 86)
local u202 = Color3.fromRGB(150, 240, 200)
local u207 = Color3.fromRGB(70, 84, 86)
local u212 = Color3.fromRGB(255, 130, 40)
local u217 = Color3.fromRGB(232, 122, 48)
local u222 = Color3.fromRGB(8, 16, 18)
local u233 = (CFrame.Angles(0.9, 0, 0)) * CFrame.Angles(0, -1.5707963267948966, 0)
local u238 = Color3.fromRGB(150, 235, 230)
local u243 = Color3.fromRGB(120, 235, 215)
local u248 = Color3.fromRGB(16, 46, 78)
local u253 = Color3.fromRGB(10, 84, 82)
local u258 = Color3.fromRGB(8, 44, 40)
local u284 = table.freeze({
    {
        Radius = 21,
        Speed = 60,
        Murk = 0.1,
        Dim = 0.92,
        Props = {"Barrel", "Crate", "Barrel"},
    },
    {
        Radius = 29,
        Speed = 40,
        Murk = 0.3,
        Dim = 0.86,
        Props = {"Kiosk", "Grave", "Lantern", "Pumpkin"},
    },
    {
        Radius = 40,
        Speed = 28,
        Murk = 0.5,
        Dim = 0.82,
        Props = {"Canopy", "Grave", "Crate", "Pumpkin"},
    },
    {
        Radius = 51,
        Speed = 18,
        Murk = 0.68,
        Dim = 0.8,
        Props = {"Lantern", "Kiosk", "Frame", "Grave"},
    },
})
local u302 = table.freeze({
    Warm = Color3.fromRGB(150, 82, 34),
    Window = Color3.fromRGB(170, 66, 20),
    Pumpkin = Color3.fromRGB(190, 70, 18),
})
local u303 = {Floor = -80, PipeRadius = 8.5, PipeLength = 100}

local function funnelSlope() -- Line: 247
    return 0.5098332286596837
end

local function funnelY(a1) -- Line: 251 -- types: a1: number
    return math.clamp((a1 - 13 - 0.5) / 46.5, 0, 1) * 26 + -79
end

local function onFunnel(a1, a2, a3, a4) -- Line: 256 -- types: a1: userdata, a2: number, a3: number, a4: number
    return a1 * CFrame.Angles(0, a2, 0) * CFrame.new(0, math.clamp((a3 - 13 - 0.5) / 46.5, 0, 1) * 26 + -79 + a4, -a3) * CFrame.Angles(0.5098332286596837, 0, 0)
end

local function wall(a1, a2, a3, a4) -- Line: 263
    -- upvalues: Kit (val), u258 (val), u248 (val), u253 (val), u82 (val), u77 (val)
    local Frame_2, v1
    local v2 = Kit.Part({
        Name = "Wall",
        Size = Vector3.new(40.16007614135742, 182, 2),
        Color = u258,
        Material = Enum.Material.SmoothPlastic,
    })
    v2.CFrame = a2 * CFrame.Angles(0, a3, 0) * CFrame.new(0, 9, -61)
    local SurfaceGui = Instance.new("SurfaceGui")
    SurfaceGui.Name = "Water"
    SurfaceGui.Face = Enum.NormalId.Back
    SurfaceGui.LightInfluence = 0
    SurfaceGui.Brightness = 1
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    SurfaceGui.PixelsPerStud = 3
    SurfaceGui.ClipsDescendants = true
    SurfaceGui.Parent = v2
    local Frame = Instance.new("Frame")
    Frame.Name = "Fill"
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame.Parent = SurfaceGui
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = 90
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, u248),
        ColorSequenceKeypoint.new(0.45, u253),
        ColorSequenceKeypoint.new(0.8, u258),
        (ColorSequenceKeypoint.new(1, u82)),
    })
    UIGradient.Parent = Frame
    local v3 = 89
    while v3 > -76.5 do
        v1 = (100 - v3) / 182
        Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Band"
        Frame_2.BorderSizePixel = 0
        Frame_2.BackgroundColor3 = u77
        Frame_2.BackgroundTransparency = 0.5 - v1 * 0.3
        Frame_2.Size = UDim2.fromScale(1, 0.013846153846153847)
        Frame_2.Position = UDim2.fromScale(0, v1)
        Frame_2.Parent = SurfaceGui
        v1 = Instance.new("UIGradient")
        v1.Rotation = 90
        v1.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.4, 0),
            (NumberSequenceKeypoint.new(1, 1)),
        })
        v1.Parent = Frame_2
        v3 = v3 - 11
    end
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Caustic"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://18177147504"
    ImageLabel.ImageColor3 = Color3.fromRGB(140, 240, 222)
    ImageLabel.ImageTransparency = 0.5
    ImageLabel.ScaleType = Enum.ScaleType.Tile
    ImageLabel.TileSize = UDim2.fromScale(0.5, 0.08241758241758242)
    ImageLabel.Size = UDim2.fromScale(1, 2)
    ImageLabel.Position = UDim2.fromScale(0, -1)
    ImageLabel.Parent = SurfaceGui
    table.insert(a4, ImageLabel)
    v2.Parent = a1
end

local function floor(a1, a2, a3) -- Line: 335
    -- upvalues: Kit (val), u177 (val)
    local ImageLabel, SurfaceGui, v1
    for i, j in {
        {Size = Vector3.new(126, 2, 50), Offset = Vector3.new(0, 0, 38)},
        {Size = Vector3.new(126, 2, 50), Offset = Vector3.new(0, 0, -38)},
        {Size = Vector3.new(50, 2, 26), Offset = Vector3.new(38, 0, 0)},
        {Size = Vector3.new(50, 2, 26), Offset = Vector3.new(-38, 0, 0)},
    } do
        v1 = Kit.Part({
            Name = ("Floor%*"):format(i),
            Size = j.Size,
            Color = u177,
            Material = Enum.Material.Mud,
        })
        v1.CFrame = a2 * CFrame.new(j.Offset + Vector3.new(0, -81, 0))
        SurfaceGui = Instance.new("SurfaceGui")
        SurfaceGui.Name = "Bed"
        SurfaceGui.Face = Enum.NormalId.Top
        SurfaceGui.LightInfluence = 0
        SurfaceGui.Brightness = 1
        SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
        SurfaceGui.PixelsPerStud = 2
        SurfaceGui.ClipsDescendants = true
        SurfaceGui.Parent = v1
        ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Caustic"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://18177147504"
        ImageLabel.ImageColor3 = Color3.fromRGB(90, 200, 170)
        ImageLabel.ImageTransparency = 0.8
        ImageLabel.ScaleType = Enum.ScaleType.Tile
        ImageLabel.TileSize = UDim2.fromScale(0.25, 0.25)
        ImageLabel.Size = UDim2.fromScale(1, 2)
        ImageLabel.Position = UDim2.fromScale(0, -1)
        ImageLabel.Parent = SurfaceGui
        table.insert(a3, ImageLabel)
        v1.Parent = a1
    end
end

local function ring(a1, a2, a3, a4, a5, a6, a7) -- Line: 377
    -- upvalues: Kit (val), u117 (val)
    local v1, v2
    local v3 = a5 - a4
    local v4 = math.sqrt(v3 * v3 + a6 * a6)
    local v5 = math.atan2(a6, v3)
    v3 = a5 * 2 * 0.13165249758739583 * 1.08
    for i = 1, 24 do
        v1 = (i - 1) / 24 * 3.141592653589793 * 2
        v2 = Kit.Part({
            Name = a3,
            Size = Vector3.new(v3, 0.8, v4 + 0.5),
            Color = u117,
            Material = Enum.Material.Slate,
        })
        v2.CFrame = a2 * CFrame.Angles(0, v1, 0) * CFrame.new(0, a7 - a6 / 2, -(a4 + a5) / 2) * CFrame.Angles(v5, 0, 0)
        v2.Parent = a1
    end
end

local function funnel(a1, a2) -- Line: 406
    -- upvalues: Kit (val), u182 (val), u57 (val), u187 (val)
    local Frame, UIGradient, v1, v2
    for i = 1, 24 do
        v1 = (i - 1) / 24 * 3.141592653589793 * 2
        v2 = Kit.Part({
            Name = "Funnel",
            Size = Vector3.new(17.062164306640625, 1, 53.775230407714844),
            Color = u182,
            Material = Enum.Material.Mud,
        })
        v2.CFrame = a2 * CFrame.Angles(0, v1, 0) * CFrame.new(0, -66.5, -36.75) * CFrame.Angles(0.5098332286596837, 0, 0)
        v1 = Instance.new("SurfaceGui")
        v1.Name = "Silt"
        v1.Face = Enum.NormalId.Top
        v1.LightInfluence = 1
        v1.Brightness = 1
        v1.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
        v1.PixelsPerStud = 2
        v1.ClipsDescendants = true
        v1.Parent = v2
        for j, k in u57 do
            Frame = Instance.new("Frame")
            Frame.Name = "Ridge"
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = u187
            Frame.BackgroundTransparency = 0
            Frame.Size = UDim2.fromScale(k.Y / 53.77522876534647, 1)
            Frame.Position = UDim2.fromScale((k.X - k.Y / 2) / 53.77522876534647, 0)
            Frame.Parent = v1
            UIGradient = Instance.new("UIGradient")
            UIGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.35, 0.35),
                NumberSequenceKeypoint.new(0.6, 0.45),
                (NumberSequenceKeypoint.new(1, 1)),
            })
            UIGradient.Parent = Frame
        end
        v2.Parent = v3
    end
end

local function siltSlide(a1, a2, a3) -- Line: 455
    -- upvalues: Kit (val), u192 (val)
    local v1 = Kit.Part({
        Name = "SiltSlide",
        Size = Vector3.new(106, 1, 106),
        Transparency = 1,
        Shape = Enum.PartType.Ball,
    })
    v1.CFrame = a2 * CFrame.new(0, -56, 0)
    v1.Parent = a1
    local Emitter = Kit.Emitter
    local v2 = {
        Name = "Silt",
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        Acceleration = Vector3.new(0, -5, 0),
        LightEmission = 0,
        LightInfluence = 1,
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward,
        Rate = if not a3 then 36 else 18,
        Lifetime = NumberRange.new(2.2, 3),
        Speed = NumberRange.new(12, 17),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.5), (NumberSequenceKeypoint.new(1, 6))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.2, 0.6),
            NumberSequenceKeypoint.new(0.8, 0.7),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-60, 60),
        Color = ColorSequence.new(u192),
    }
    Emitter(v2).Parent = v1
end

local function collar(a1, a2) -- Line: 493 -- upvalues: ring (val) -- types: a1: userdata, a2: userdata
    ring(a1, a2, "Collar", 8.5, 13.5, 3.5, -79.6)
end

local function ribs(a1, a2) -- Line: 499
    -- upvalues: Kit (val), u197 (val), u112 (val)
    local v1, v2, v3, v4
    local v5, v6 = a1, a2
    for i = 1, 11 do
        v3 = -80 - i * 9 + 3.6
        for j = 1, 16 do
            v4 = (j - 1) / 16 * 3.141592653589793 * 2
            v1 = i % 2 == 0
            v2 = Kit.Part({
                Name = "Rib",
                Size = Vector3.new(3.386284112930298, 1.100000023841858, 0.8999999761581421),
                Color = if not v1 then u112 else u197,
                Material = if not v1 then Enum.Material.CorrodedMetal else Enum.Material.Neon,
            })
            v2.CFrame = v6 * CFrame.new(0, v3, 0) * CFrame.Angles(0, v4, 0) * CFrame.new(0, 0, -8.05)
            v2.Parent = v5
        end
    end
end

local function pipe(a1, a2, a3) -- Line: 522
    -- upvalues: Kit (val), u102 (val), u107 (val), ribs (val), ring (val), u97 (val), u65 (val), u122 (val), u202 (val)
    local Attachment, Attachment_2, v1, v2, v3, v4
    for i = 1, 16 do
        v2 = (i - 1) / 16 * 3.141592653589793 * 2
        v3 = Kit.Part({
            Name = "Tube",
            Size = Vector3.new(3.936077833175659, 100, 1.2000000476837158),
            Color = if i % 2 ~= 0 then u107 else u102,
            Material = Enum.Material.CorrodedMetal,
        })
        v3.CFrame = a2 * CFrame.new(0, -130, 0) * CFrame.Angles(0, v2, 0) * CFrame.new(0, 0, -9.1)
        v3.Parent = a1
    end
    ribs(a1, a2)
    ring(a1, a2, "Collar", 8.5, 13.5, 3.5, -79.6)
    local v5 = {}
    local v6 = Kit.Part({Name = "Slime", Size = Vector3.new(1, 1, 1), Transparency = 1})
    v6.CFrame = a2
    v6.Parent = a1
    for j = 1, 4 do
        v4 = j * 3.141592653589793 / 2 + 0.4
        Attachment = Instance.new("Attachment")
        Attachment.Position = Vector3.new(math.cos(v4) * 8.3, -81, (math.sin(v4)) * 8.3)
        Attachment.Parent = v6
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Position = Vector3.new(math.cos(v4 + 0.3) * 8.3, -180, (math.sin(v4 + 0.3)) * 8.3)
        Attachment_2.Parent = v6
        v4 = Kit.Beam({
            Name = "Streak",
            Width0 = 1.1,
            Width1 = 0.7,
            LightEmission = 0.3,
            FaceCamera = true,
            Attachment0 = Attachment,
            Attachment1 = Attachment_2,
            Color = ColorSequence.new(Color3.fromRGB(110, 190, 80), Color3.fromRGB(70, 150, 66)),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.75),
                NumberSequenceKeypoint.new(0.5, 0.45),
                (NumberSequenceKeypoint.new(1, 0.7)),
            }),
        })
        v4.Parent = v6
        table.insert(v5, v4)
    end
    v6 = Kit.Part({
        Name = "Light",
        Size = Vector3.new(1, 18, 18),
        Transparency = 0.35,
        Shape = Enum.PartType.Cylinder,
        Color = u97,
        Material = Enum.Material.Neon,
    })
    v6.CFrame = a2 * CFrame.new(0, -180, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    v6.Parent = a1
    local PointLight = Instance.new("PointLight")
    PointLight.Color = Kit.CaveGreen
    PointLight.Range = 60
    PointLight.Brightness = 0.6
    PointLight.Shadows = false
    PointLight.Parent = v6
    v2 = Kit.Part({
        Name = "Mouth",
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        Transparency = 1,
    })
    v2.CFrame = a2 * CFrame.new(0, -86, 0)
    v2.Parent = a1
    local PointLight_2 = Instance.new("PointLight")
    PointLight_2.Color = Kit.CaveGreen
    PointLight_2.Range = 26
    PointLight_2.Brightness = 0.4
    PointLight_2.Shadows = false
    PointLight_2.Parent = v2
    v2 = {}
    for k, n in u65 do
        v1 = Kit.Part({
            Name = "Fog",
            Size = Vector3.new(0.20000000298023224, 17.600000381469727, 17.600000381469727),
            Transparency = 1,
            Shape = Enum.PartType.Cylinder,
            Color = u122,
            Material = Enum.Material.SmoothPlastic,
        })
        v1.CFrame = a2 * CFrame.new(0, -80 - n, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
        v1.Parent = a1
        table.insert(v2, v1)
    end
    v4 = Kit.Part({
        Name = "Exit",
        Size = Vector3.new(0.4000000059604645, 17.399999618530273, 17.399999618530273),
        Transparency = 1,
        Shape = Enum.PartType.Cylinder,
        Color = u202,
        Material = Enum.Material.Neon,
    })
    v4.CFrame = a2 * CFrame.new(0, -156, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    v4.Parent = a1
    local PointLight_3 = Instance.new("PointLight")
    PointLight_3.Color = u202
    PointLight_3.Range = 40
    PointLight_3.Brightness = 0
    PointLight_3.Shadows = false
    PointLight_3.Parent = v4
    return PointLight, v6, PointLight_2, v2, v5, v4, PointLight_3
end

local function wedge(a1) -- Line: 648 -- types: a1: table
    local WedgePart = Instance.new("WedgePart")
    WedgePart.Anchored = true
    WedgePart.CanCollide = false
    WedgePart.CanQuery = false
    WedgePart.CanTouch = false
    WedgePart.CastShadow = false
    for i, j in a1 do
        WedgePart[i] = j
    end
    return WedgePart
end

local function onWall(a1, a2, a3, a4) -- Line: 661 -- types: a1: userdata, a2: number, a3: number, a4: number
    return a1 * CFrame.Angles(0, a2, 0) * CFrame.new(0, a3, -(60 - a4))
end

local function facade(a1, a2, a3, a4, a5) -- Line: 665
    -- upvalues: Kit (val), u127 (val), u132 (val), u137 (val), u212 (val), u217 (val), u142 (val), u222 (val)
    local Part_3, v1, v2, v3, v4
    local v5 = Kit.Part({
        Name = "Facade",
        Size = a3,
        Color = u127:Lerp(u132, (a4:NextNumber(0, 0.6))),
        Material = if not ((a4:NextNumber()) < 0.5) then Enum.Material.Cobblestone else Enum.Material.WoodPlanks,
    })
    v5.CFrame = a2
    v5.Parent = a1
    v5 = a4:NextNumber(3, 6)
    local v6 = {
        Name = "Roof",
        Size = Vector3.new(a3.X + 2, v5, a3.Z + 2.4),
        Color = u137,
        Material = Enum.Material.Slate,
    }
    local v7 = Instance.new("WedgePart")
    v7.Anchored = true
    v7.CanCollide = false
    v7.CanQuery = false
    v7.CanTouch = false
    v7.CastShadow = false
    for i, j in v6 do
        v7[i] = j
    end
    v7.CFrame = a2 * CFrame.new(0, a3.Y / 2 + v5 / 2, 0.4) * CFrame.Angles(0, 3.141592653589793, a4:NextNumber(-0.12, 0.12))
    v7.Parent = a1
    v7 = Kit.Part({
        Name = "Trim",
        Size = Vector3.new(a3.X + 0.8, 0.8, 0.6),
        Color = u137,
        Material = Enum.Material.Wood,
    })
    v7.CFrame = a2 * CFrame.new(0, -a3.Y / 2 + a3.Y * 0.45, a3.Z / 2 + 0.2)
    v7.Parent = a1
    v7 = math.max(math.floor(a3.X / 4), 1)
    v5 = math.max(math.floor(a3.Y / 7), 1)
    v6 = 0
    local v8, v9, v10, v11, v12 = a1, a2, a3, a4, a5
    for k = 1, v5 do
        for n = 1, v7 do
            if v12 <= v6 then
                return
            end
            v1 = v11:NextNumber()
            if not (v1 < 0.25) then
                v6 = v6 + 1
                v2 = (v11:NextNumber()) < 0.4 and (v11:NextNumber()) < 0.3
                Part_3 = Kit.Part
                v4 = {
                    Name = "Window",
                    Size = Vector3.new(1.399999976158142, 2, 0.30000001192092896),
                    Color = if not v2 then if not v1 then u142 else u217 else u212,
                    Material = if not v1 then Enum.Material.SmoothPlastic else Enum.Material.Neon,
                    Transparency = if not v1 then 0 else v11:NextNumber(0.35, 0.6),
                }
                v3 = Part_3(v4)
                v3.CFrame = v9 * CFrame.new(-v10.X / 2 + (n - 0.5) * v10.X / v7, -v10.Y / 2 + (k - 0.5) * v10.Y / v5 + 1, v10.Z / 2 + 0.1)
                v3.Parent = v8
                if v1 then
                    v2 = Kit.Part({
                        Name = "Mullion",
                        Size = Vector3.new(0.2199999988079071, 2.0999999046325684, 0.20000000298023224),
                        Color = u222,
                        Material = Enum.Material.Wood,
                    })
                    v2.CFrame = v3.CFrame * CFrame.new(0, 0, 0.2)
                    v2.Parent = v8
                    v4 = v2:Clone()
                    v4.Size = Vector3.new(1.5, 0.2199999988079071, 0.20000000298023224)
                    v4.Parent = v8
                end
            end
        end
    end
end

local function ledge(a1, a2, a3, a4, a5, a6) -- Line: 740
    -- upvalues: Kit (val), u147 (val), u132 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9, v10, v11, v12, v13, v14 = a4, a3, a2, a1, a5, a6
    for i = 1, 14 do
        v8 = v9:NextNumber()
        if not (v8 < 0.3) then
            v8 = (i - 1) / 14 * 3.141592653589793 * 2 + v9:NextNumber(-0.05, 0.05)
            v1 = v9:NextNumber(1.8, 2.8)
            v2 = v10 + v9:NextNumber(-2.5, 2.5)
            v3 = v9:NextNumber(1.2, 2.6)
            v4 = Kit.Part({
                Name = "Ledge",
                Size = Vector3.new(26.702512074757728 * v9:NextNumber(0.55, 1), v3, v1),
                Color = u147:Lerp(u132, (v9:NextNumber())),
                Material = Enum.Material.Slate,
            })
            v5 = v1 / 2
            v4.CFrame = v11 * CFrame.Angles(0, v8, 0) * CFrame.new(0, v2, -(60 - v5)) * CFrame.Angles(v9:NextNumber(-0.12, 0.12), 0, v9:NextNumber(-0.18, 0.18))
            v4.Parent = v12
            v6 = v2 - 1
            v7 = v1 - 0.3
            table.insert(v13, (v11 * CFrame.Angles(0, v8, 0) * (CFrame.new(0, v6, -(60 - v7)))).Position)
            if v1 > 2.2 then
                v6 = v2 + v3 / 2
                v7 = v1 * 0.8
                table.insert(v14, v11 * CFrame.Angles(0, v8, 0) * (CFrame.new(0, v6, -(60 - v7))))
            end
        end
    end
end

local function vent(a1, a2, a3, a4, a5) -- Line: 773
    -- upvalues: Kit (val), u152 (val), u122 (val), u112 (val)
    local v1 = a5:NextNumber(7, 13)
    local v2 = a5:NextNumber(1.4, 2.4)
    local v3 = v1 / 2 - 1
    local v4 = a2 * CFrame.Angles(0, a3, 0) * CFrame.new(0, a4, -(60 - v3)) * CFrame.Angles(0, 1.5707963267948966, 0)
    local v5 = Kit.Part({
        Name = "Vent",
        Shape = Enum.PartType.Cylinder,
        Size = Vector3.new(v1, v2 * 2, v2 * 2),
        Color = u152,
        Material = Enum.Material.CorrodedMetal,
    })
    v5.CFrame = v4
    v5.Parent = a1
    v3 = Kit.Part({
        Name = "VentMouth",
        Shape = Enum.PartType.Cylinder,
        Size = Vector3.new(0.3, v2 * 1.6, v2 * 1.6),
        Color = u122,
        Material = Enum.Material.SmoothPlastic,
    })
    v3.CFrame = v4 * CFrame.new(-v1 / 2 - 0.1, 0, 0)
    v3.Parent = a1
    v3 = Kit.Part({
        Name = "VentRim",
        Shape = Enum.PartType.Cylinder,
        Size = Vector3.new(0.8, v2 * 2.5, v2 * 2.5),
        Color = u112,
        Material = Enum.Material.CorrodedMetal,
    })
    v3.CFrame = v4 * CFrame.new(-v1 / 2 + 0.3, 0, 0)
    v3.Parent = a1
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(-v1 / 2 - 0.4, 0, 0)
    Attachment.Parent = v5
    local Emitter = Kit.Emitter
    local v6 = {
        Name = "Seep",
        Texture = "rbxassetid://11800775280",
        Rate = 6,
        Acceleration = Vector3.new(0, 14, 0),
        LightEmission = 0.4,
        LightInfluence = 0,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        FlipbookFramerate = NumberRange.new(20, 30),
        Lifetime = NumberRange.new(1.4, 2.2),
        Speed = NumberRange.new(4, 9),
        SpreadAngle = Vector2.new(20, 20),
        EmissionDirection = Enum.NormalId.Left,
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), (NumberSequenceKeypoint.new(1, 1.4))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.3),
            NumberSequenceKeypoint.new(0.8, 0.5),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
        Color = ColorSequence.new(Color3.fromRGB(190, 245, 235)),
    }
    Emitter(v6).Parent = Attachment
end

local function weed(a1, a2, a3, a4) -- Line: 835
    -- upvalues: Kit (val), u157 (val), u162 (val)
    local v1 = a2:PointToObjectSpace(a3)
    local Unit = (Vector3.new(-v1.X, 0, -v1.Z)).Unit
    local Attachment = Instance.new("Attachment")
    Attachment.Position = v1
    Attachment.Parent = a1
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = v1 + Vector3.new(0, -a4:NextNumber(10, 24), 0) + Unit * a4:NextNumber(0.5, 2.5)
    Attachment_2.Parent = a1
    local v2 = (a4:NextNumber(2, 5)) * (if not ((a4:NextNumber()) < 0.5) then 1 else -1)
    local Beam = Kit.Beam
    local v3 = {
        Name = "Weed",
        LightEmission = 0,
        Width1 = 0.15,
        Segments = 8,
        FaceCamera = true,
        Attachment0 = Attachment,
        Attachment1 = Attachment_2,
        Color = ColorSequence.new(u157, u162),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.05),
            NumberSequenceKeypoint.new(0.8, 0.2),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
        Width0 = a4:NextNumber(0.9, 1.6),
        CurveSize0 = v2,
        CurveSize1 = -v2 * 0.6,
    }
    Beam(v3).Parent = a1
end

local function shaftWalls(a1, a2, a3, a4) -- Line: 868
    -- upvalues: facade (val), u72 (val), ledge (val), vent (val), Kit (val), weed (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = if not a4 then 10 else 5
    for i = 1, if not a4 then 16 else 8 do
        v9 = (i - 1) / v8 * 3.141592653589793 * 2 + a3:NextNumber(-0.1, 0.1)
        v1 = Vector3.new(a3:NextNumber(9, 15), a3:NextNumber(16, 34), (a3:NextNumber(4, 7)))
        v3 = (i - 1) % 2 * 71 + -78 + a3:NextNumber(0, 71 - v1.Y * 0.5)
        v2 = CFrame.Angles(a3:NextNumber(-0.06, 0.06), 0, a3:NextNumber(-0.1, 0.1))
        v4 = facade
        v6 = v3 + v1.Y / 2
        v7 = v1.Z / 2 + 0.5
        v4(a1, a2 * CFrame.Angles(0, v9, 0) * CFrame.new(0, v6, -(60 - v7)) * v2, v1, a3, v10)
    end
    v10 = {}
    v8 = {}
    for j, k in u72 do
        ledge(a1, a2, k, a3, v10, v8)
    end
    for n = 1, 7 do
        vent(a1, a2, (n - 0.5) / 7 * 3.141592653589793 * 2 + a3:NextNumber(-0.2, 0.2), a3:NextNumber(-60, 80), a3)
    end
    local v11 = Kit.Part({Name = "Weeds", Size = Vector3.new(1, 1, 1), Transparency = 1})
    v11.CFrame = a2
    v11.Parent = a1
    v4 = #v10
    for m = 1, (math.min(if not a4 then 18 else 9, v4)) do
        v5 = #v10
        v2 = a3:NextInteger(m, v5)
        v3 = v10[v2]
        v4 = v10[m]
        v10[m] = v3
        v10[v2] = v4
        weed(v11, a2, v10[m], a3)
    end
    return v8
end

local function struts(a1, a2, a3) -- Line: 911
    -- upvalues: Kit (val), u167 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = 88
    local v10, v11, v12 = a3, a2, a1
    while v9 >= -66 do
        v3 = v10:NextNumber(15, 20)
        v4 = 2 * (v3 + 0.9) * 0.2679491924311227 * 1.02
        v5 = v11 * CFrame.new(0, v9, 0) * CFrame.Angles(v10:NextNumber(-0.2, 0.2), 0, v10:NextNumber(-0.2, 0.2))
        v6 = v10:NextNumber(0, 6.283185307179586)
        v7 = v10:NextInteger(2, 4)
        v8 = v10:NextInteger(1, 12)
        for i = 1, 12 do
            if not ((i - v8) % 12 < v7) then
                v1 = v6 + (i - 1) / 12 * 3.141592653589793 * 2
                v2 = Kit.Part({
                    Name = "Girder",
                    Size = Vector3.new(v4, 1.3, 1.8),
                    Color = u167,
                    Material = Enum.Material.CorrodedMetal,
                })
                v2.CFrame = v5 * CFrame.Angles(0, v1, 0) * CFrame.new(0, 0, -v3) * CFrame.Angles(0, 0, v10:NextNumber(-0.05, 0.05))
                v2.Parent = v12
            end
        end
        v9 = v9 - 40 * v10:NextNumber(0.85, 1.15)
    end
end

local function floorDressing(a1, a2, a3) -- Line: 943
    -- upvalues: onFunnel (val), facade (val), Kit (val), u112 (val), u238 (val)
    local v1, v2
    local v3 = a3:NextNumber(0, 6.283185307179586)
    for i = 1, 3 do
        v1 = v3 + (i - 1) / 3 * 3.141592653589793 * 2 + a3:NextNumber(-0.4, 0.4)
        v2 = Vector3.new(a3:NextNumber(10, 14), a3:NextNumber(8, 11), (a3:NextNumber(8, 10)))
        facade(
            a1,
            (onFunnel(a2, v1, a3:NextNumber(36, 44), v2.Y * 0.15)) * CFrame.Angles(a3:NextNumber(-0.2, 0.05), 0, a3:NextNumber(-0.3, 0.3)),
            v2,
            a3,
            2
        )
    end
    local v4 = (onFunnel(a2, a3:NextNumber(0, 6.283185307179586), 32, 1)) * CFrame.Angles(0, 0, 0.13962634015954636)
    for j = -3, 3 do
        v3 = Kit.Part({
            Name = "Grate",
            Size = Vector3.new(0.5, 0.5, 9),
            Color = u112,
            Material = Enum.Material.CorrodedMetal,
        })
        v3.CFrame = v4 * CFrame.new(j * 1.3, 0, 0)
        v3.Parent = a1
    end
    for k = -1, 1, 2 do
        v2 = Kit.Part({
            Name = "Grate",
            Size = Vector3.new(9.399999618530273, 0.699999988079071, 0.699999988079071),
            Color = u112,
            Material = Enum.Material.CorrodedMetal,
        })
        v2.CFrame = v4 * CFrame.new(0, 0, k * 4.3)
        v2.Parent = a1
    end
    v4 = Kit.Part({
        Name = "Spot",
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        Transparency = 1,
    })
    v4.CFrame = a2 * CFrame.new(0, -34, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
    v4.Parent = a1
    local SpotLight = Instance.new("SpotLight")
    SpotLight.Face = Enum.NormalId.Front
    SpotLight.Color = u238
    SpotLight.Angle = 40
    SpotLight.Range = 60
    SpotLight.Brightness = 0.9
    SpotLight.Shadows = false
    SpotLight.Parent = v4
end

local function twister(a1, a2, a3) -- Line: 994 -- upvalues: Kit (val) -- types: a1: userdata, a2: table, a3: boolean
    local Attachment_2, Attachment_3, Beam_2, DeepTeal, v1, v2, v3
    local v4 = {}
    local v5 = {
        Texture = "rbxassetid://18925205019",
        Width = 7,
        Angle = 0,
        Rate = 2.4,
        Color = Kit.Teal,
    }
    local v6 = {
        Texture = "rbxassetid://12251459424",
        Width = 6,
        Angle = 2.0943951023931953,
        Rate = 2.4,
        Color = Color3.fromRGB(120, 230, 214),
    }
    local v7 = {
        Texture = "rbxassetid://18925205019",
        Width = 5,
        Angle = 4.1887902047863905,
        Rate = 2.4,
        Color = Kit.DeepTeal,
    }
    v4[1] = v5
    v4[2] = v6
    v4[3] = v7
    v6 = if not a3 then 5 else 3
    for i = 1, v6 do
        v1 = {
            Width = 12,
            Rate = 1.7,
            TopRadius = 22,
            BottomRadius = 9.5,
            Curve = 46,
            Speed = 3.2,
            Fade = 0.62,
            Texture = if i % 2 ~= 0 then "rbxassetid://18925205019" else "rbxassetid://12251459424",
            Angle = (i - 1) / v5 * 3.141592653589793 * 2 + 0.3,
        }
        DeepTeal = if i % 2 ~= 0 then Kit.DeepTeal else Color3.fromRGB(90, 200, 196)
        v1.Color = DeepTeal
        table.insert(v4, v1)
    end
    for j, k in v4 do
        v5 = k.Fade or 0.45
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Parent = v8
        Attachment_3 = Instance.new("Attachment")
        Attachment_3.Parent = v8
        Beam_2 = Kit.Beam
        v2 = {
            Name = "Twist",
            TextureLength = 18,
            LightEmission = 1,
            Segments = 24,
            FaceCamera = true,
            Attachment0 = Attachment_2,
            Attachment1 = Attachment_3,
            Texture = k.Texture,
            TextureMode = Enum.TextureMode.Wrap,
            TextureSpeed = k.Speed or 1.5,
            Color = ColorSequence.new(k.Color),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.25, v5),
                NumberSequenceKeypoint.new(0.8, v5 - 0.05),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Width0 = k.Width,
            Width1 = k.Width * 0.45,
            CurveSize0 = k.Curve or 22,
            CurveSize1 = -(k.Curve or 22),
        }
        Beam_2(v2).Parent = v8
        v3 = {
            Top = Attachment_2,
            Bottom = Attachment_3,
            Angle = k.Angle,
            Rate = k.Rate,
            TopRadius = k.TopRadius or 10,
            BottomRadius = k.BottomRadius or 3,
        }
        table.insert(v9, v3)
    end
    v4 = Instance.new("Attachment")
    v4.Position = Vector3.new(0, 100, 0)
    v4.Parent = v8
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(0, -80, 0)
    Attachment.Parent = v8
    local Beam = Kit.Beam
    local v10 = {
        Name = "Core",
        Texture = "rbxassetid://15939596990",
        TextureLength = 30,
        TextureSpeed = 2,
        LightEmission = 1,
        Width0 = 9,
        Width1 = 4,
        FaceCamera = true,
        Attachment0 = v4,
        Attachment1 = Attachment,
        Color = ColorSequence.new(Color3.fromRGB(150, 245, 225)),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.7),
            (NumberSequenceKeypoint.new(1, 0.85)),
        }),
    }
    Beam(v10).Parent = v8
end

local function paint(a1, a2, a3) -- Line: 1093
    -- upvalues: u302 (val), u92 (val)
    local Attribute, new, v1, v2, v3
    local v4 = {}
    local v5, v6 = a2, a3
    for i, j in a1:GetDescendants() do
        if j:IsA("SurfaceAppearance") or j:IsA("Decal") or j:IsA("Texture") then
            j:Destroy()
        elseif j:IsA("BasePart") and j.Transparency < 0.95 then
            Attribute = j:GetAttribute("DrainGlow")
            if j:IsA("MeshPart") then
                j.TextureID = ""
            end
            if type(Attribute) ~= "string" or u302[Attribute] == nil then
                if j.Material == Enum.Material.Neon
                    or j.Material == Enum.Material.Plastic
                    or j.Material == Enum.Material.Glacier then
                    j.Material = Enum.Material.SmoothPlastic
                end
                v1 = j.Color:Lerp(u92, v5)
                new = Color3.new
                v2 = v1.R * v6
                v3 = v1.G * v6
                j.Color = new(v2, v3, v1.B * v6)
                j.Transparency = 0
            else
                j.Material = Enum.Material.Neon
                j.Color = u302[Attribute]
                j.Transparency = 0.45
                table.insert(v4, j)
            end
        end
    end
    return v4
end

local function grave(a1) -- Line: 1125 -- upvalues: Kit (val), u207 (val), u172 (val), u132 (val) -- types: a1: userdata
    local Model = Instance.new("Model")
    Model.Name = "Grave"
    local v1 = a1:NextNumber(2.8, 3.6)
    local v2 = a1:NextNumber(3.6, 4.8)
    local v3 = Kit.Part({
        Name = "Stone",
        Size = Vector3.new(v1, v2, 0.9),
        Color = u207,
        Material = Enum.Material.Slate,
    })
    v3.CFrame = CFrame.new(0, v2 / 2, 0)
    v3.Parent = Model
    v3 = Kit.Part({
        Name = "Crown",
        Shape = Enum.PartType.Cylinder,
        Size = Vector3.new(0.9, v1, v1),
        Color = u207,
        Material = Enum.Material.Slate,
    })
    v3.CFrame = (CFrame.new(0, v2, 0)) * CFrame.Angles(0, 1.5707963267948966, 0)
    v3.Parent = Model
    v3 = Kit.Part({
        Name = "Plinth",
        Size = Vector3.new(v1 + 1, 0.8, 1.8),
        Color = u172,
        Material = Enum.Material.Slate,
    })
    v3.CFrame = CFrame.new(0, 0.2, 0)
    v3.Parent = Model
    v3 = Kit.Part({
        Name = "Cross",
        Size = Vector3.new(0.4000000059604645, 1.600000023841858, 0.20000000298023224),
        Color = u132,
        Material = Enum.Material.SmoothPlastic,
    })
    v3.CFrame = CFrame.new(0, v2 * 0.55, 0.5)
    v3.Parent = Model
    v1 = v3:Clone()
    v1.Size = Vector3.new(1.100000023841858, 0.4000000059604645, 0.20000000298023224)
    v1.CFrame = CFrame.new(0, v2 * 0.6, 0.5)
    v1.Parent = Model
    Model.WorldPivot = CFrame.new(0, v2 / 2, 0)
    return Model
end

local function ledgeProps(a1, a2, a3, a4, a5) -- Line: 1171
    -- upvalues: onFunnel (val), Kit (val), paint (val), u87 (val)
    local Props = a3 and a3:FindFirstChild("Props")
    local Pumpkin = Props and Props:FindFirstChild("Pumpkin")
    if Pumpkin ~= nil and Pumpkin:IsA("Model") then
        local BoundingBox, BoundingBox_2, PointLight, Position, v1, v2, v3, v4, v5
        local v6 = a4:NextNumber(0, 6.283185307179586)
        table.insert(a5, 1, (onFunnel(a2, v6 + 0, 48, 0.2)))
        table.insert(a5, 2, (onFunnel(a2, v6 + 2.0943951023931953, 48, 0.2)))
        table.insert(a5, 3, (onFunnel(a2, v6 + 4.1887902047863905, 48, 0.2)))
        for i = 1, (math.min(8, #a5)) do
            if not (i <= 3) then
                v4 = #v7
                v1 = v8:NextInteger(i, v4)
                v2 = v7[v1]
                v3 = v7[i]
                v7[i] = v2
                v7[v1] = v3
            end
            v1 = v7[i]
            v2 = Pumpkin:Clone()
            Kit.Quiet(v2)
            v2:ScaleTo((v2:GetScale()) * (if not v6 then v8:NextNumber(0.7, 1) else v8:NextNumber(0.9, 1.1)))
            v3 = paint(v2, 0.05, 1)
            if v6 and v3[1] ~= nil then
                PointLight = Instance.new("PointLight")
                PointLight.Color = u87
                PointLight.Range = 12
                PointLight.Brightness = 1.4
                PointLight.Shadows = false
                PointLight.Parent = v3[1]
            end
            if not v6 then
                Position = v1.Position
                v5 = Vector3.new(0, (v9:PointToObjectSpace(Position)).Y, 0)
                v2:PivotTo((CFrame.lookAt(Position, v9 * v5)) * CFrame.Angles(0, v8:NextNumber(-0.4, 0.4), 0) * CFrame.Angles(0.6, 0, 0) * (CFrame.Angles(0, -1.5707963267948966, 0)))
            else
                v2:PivotTo(v1 * (CFrame.Angles(0, 1.5707963267948966 + v8:NextNumber(-0.5, 0.5), 0)))
            end
            BoundingBox, BoundingBox_2 = v2:GetBoundingBox()
            v6 = v1.Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y / 2)
            v2:PivotTo((v2:GetPivot()) + (Vector3.new(0, v6, 0)))
            v2.Parent = v10
        end
        return
    end
end

local function drifters(a1, a2, a3, a4, a5, a6) -- Line: 1229
    -- upvalues: u284 (val), grave (val), Kit (val), paint (val), u233 (val)
    local BoundingBox, BoundingBox_2, Props, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local Props_2 = a3 and a3:FindFirstChild("Props")
    if Props_2 == nil then
        return
    end
    local v10 = nil
    local v11 = nil
    for i, j in u284, v10, v11 do
        Props = j.Props
        v2 = if not a6 then #Props else math.max(#Props - 1, 2)
        for k = 1, v2 do
            v3 = if Props[k] ~= "Grave" then Props_2:FindFirstChild(Props[k]) else grave(v8)
            if v3 ~= nil and v3:IsA("Model") then
                Kit.Quiet(if Props[k] ~= "Grave" then v3:Clone() else v3)
                if Props[k] ~= "Kiosk" then
                    v4:ScaleTo((v4:GetScale()) * (v8:NextNumber(0.85, if i ~= 1 then 1.3 else 1.1)))
                end
                v3 = Props[k] == "Pumpkin"
                v5 = math.clamp(j.Murk + v8:NextNumber(-0.08, 0.08), 0, 0.9)
                v6 = paint(v4, if not v3 then v5 else math.min(v5, 0.12), j.Dim)
                v4.Parent = v1
                v5 = {}
                for n, m in v4:GetDescendants() do
                    if m:IsA("BasePart") and m.Transparency < 0.95 then
                        table.insert(v5, m)
                    end
                end
                v7 = 66 / v2
                BoundingBox, BoundingBox_2 = v4:GetBoundingBox()
                table.insert(v9, {
                    Faded = 0,
                    Model = v4,
                    Pivot = v4:GetPivot(),
                    Radius = j.Radius,
                    Angle = (k - 1) / v2 * 3.141592653589793 * 2 + i * 0.9 + v8:NextNumber(-0.3, 0.3),
                    Height = (k - 1) * v7 + -54 + v8:NextNumber(0, v7 * 0.6),
                    Speed = j.Speed,
                    Spin = v8:NextNumber(-0.25, 0.25),
                    Tilt = v8:NextNumber(-0.35, 0.35),
                    Glows = v6,
                    Parts = v5,
                    Face = if not v3 then CFrame.identity else u233,
                    Center = v4:GetPivot():ToObjectSpace(BoundingBox),
                    Reach = BoundingBox_2.Magnitude / 2,
                })
            end
        end
    end
end

local function lines(a1, a2, a3) -- Line: 1293
    -- upvalues: Kit (val), u243 (val)
    local Attachment, Attachment_2, v1
    local v2 = {}
    for i = 1, if not a3 then 30 else 16 do
        Attachment = Instance.new("Attachment")
        Attachment.Parent = a1
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Parent = a1
        v1 = Kit.Beam({
            Name = "Line",
            Texture = "rbxassetid://15939596990",
            TextureLength = 1,
            TextureSpeed = 0,
            LightEmission = 0.6,
            Segments = 1,
            FaceCamera = true,
            Attachment0 = Attachment,
            Attachment1 = Attachment_2,
            TextureMode = Enum.TextureMode.Stretch,
            Color = ColorSequence.new(u243),
            Transparency = NumberSequence.new(1),
            Width0 = a2:NextNumber(0.5, 0.8),
            Width1 = a2:NextNumber(0.5, 0.8),
        })
        v1.Parent = a1
        table.insert(v2, {
            Beam = v1,
            Top = Attachment,
            Bottom = Attachment_2,
            Angle = a2:NextNumber(0, 6.283185307179586),
            Radius = a2:NextNumber(13, 48),
            Offset = a2:NextNumber(0, 150),
            Length = a2:NextNumber(2.5, 5),
            Speed = a2:NextNumber(40, 90),
        })
    end
    return v2
end

local function lineFade(a1) -- Line: 1332 -- types: a1: number
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 1 - (math.clamp(a1, 0, 1)) * 0.4),
        (NumberSequenceKeypoint.new(1, 1)),
    })
end

local function stepLines(a1, a2) -- Line: 1341 -- upvalues: lineFade (val) -- types: a1: table, a2: number
    local v1, v2, v3
    local LineAlpha = a1.LineAlpha
    local v4 = math.abs(LineAlpha - a1.LineShown)
    if v4 > 0.04 then
        a1.LineShown = LineAlpha
        v4 = lineFade(LineAlpha)
        for i, j in a1.Lines do
            j.Beam.Transparency = v4
        end
    elseif LineAlpha == 0 and a1.LineShown ~= 0 then
        a1.LineShown = LineAlpha
        v4 = lineFade(LineAlpha)
        for k, n in a1.Lines do
            n.Beam.Transparency = v4
        end
    end
    if LineAlpha <= 0 then
        return
    end
    v4 = a1.LineY - 110
    local v5 = LineAlpha * 0.9 + 0.6
    for m, i5 in a1.Lines do
        v3 = v4 + (i5.Offset + a2 * i5.Speed - v4) % 150
        v1 = (math.cos(i5.Angle)) * i5.Radius
        v2 = (math.sin(i5.Angle)) * i5.Radius
        i5.Bottom.Position = Vector3.new(v1, v3, v2)
        i5.Top.Position = Vector3.new(v1, v3 + i5.Length * v5, v2)
    end
end

local function breathEmitter() -- Line: 1364 -- upvalues: Kit (val)
    return Kit.Emitter({
        Name = "Breath",
        Texture = "rbxassetid://11800775280",
        LightEmission = 0.6,
        LightInfluence = 0,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        FlipbookFramerate = NumberRange.new(20, 30),
        Shape = Enum.ParticleEmitterShape.Box,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
        EmissionDirection = Enum.NormalId.Top,
        Lifetime = NumberRange.new(0.5, 0.9),
        Speed = NumberRange.new(30, 55),
        SpreadAngle = Vector2.new(25, 25),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), (NumberSequenceKeypoint.new(1, 0.45))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.15),
            NumberSequenceKeypoint.new(0.8, 0.3),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
        Color = ColorSequence.new(Color3.fromRGB(215, 255, 248)),
    })
end

local function placeDrifter(a1, a2, a3) -- Line: 1392 -- types: a1: table, a2: table, a3: number
    local Origin = a1.Origin
    local v1 = a2.Angle + a3 * 0.12
    v1 = CFrame.lookAt(Vector3.new((math.cos(v1)) * a2.Radius, a2.Height, (math.sin(v1)) * a2.Radius), (Vector3.new(0, a2.Height, 0)))
    local v2 = CFrame.Angles(a2.Tilt, a3 * a2.Spin, a2.Tilt * 0.6)
    a2.Model:PivotTo(Origin * v1 * a2.Face * v2)
end

local function fadeNearLens(a1, a2) -- Line: 1405 -- types: a1: table, a2: vector
    local v1
    if (if not ((((a1.Model:GetPivot()) * a1.Center).Position - a2).Magnitude - a1.Reach < 8) then 0 else 1) == a1.Faded then
        return
    end
    a1.Faded = v1
    for i, j in a1.Parts do
        j.LocalTransparencyModifier = v1
    end
end

function u303.Build(a1, a2, a3, a4) -- Line: 1422
    -- upvalues: wall (val), floor (val), funnel (val), siltSlide (val), Kit (val), u248 (val), pipe (val)
    -- upvalues: shaftWalls (val), struts (val), floorDressing (val), twister (val), breathEmitter (val), lines (val)
    -- upvalues: drifters (val), ledgeProps (val), u303 (val)
    local v1 = a1:Add((Instance.new("Model")))
    v1.Name = "SewerDrainDepths"
    local Assets = script.Parent:FindFirstChild("Assets")
    local v2 = {}
    for i = 1, 10 do
        wall(v1, a3, (i - 1) / 10 * 3.141592653589793 * 2, v2)
    end
    floor(v1, a3, v2)
    funnel(v1, a3)
    siltSlide(v1, a3, a4)
    local v3 = Kit.Part({
        Name = "Sky",
        Size = Vector3.new(128, 2, 128),
        Color = u248,
        Material = Enum.Material.Neon,
    })
    v3.CFrame = a3 * CFrame.new(0, 101, 0)
    v3.Parent = v1
    v3 = Random.new()
    local v4, v5, v6, v7, v8, v9, v10 = pipe(v1, a3, v3)
    local v11 = shaftWalls(v1, a3, v3, a4)
    struts(v1, a3, v3)
    floorDressing(v1, a3, v3)
    local v12 = Kit.Part({Name = "Hub", Size = Vector3.new(1, 1, 1), Transparency = 1})
    v12.CFrame = a3
    v12.Parent = v1
    local v13 = {}
    twister(v12, v13, a4)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "Bubbles"
    Attachment.Position = Vector3.new(0, -78, 0)
    Attachment.Orientation = Vector3.new(0, 0, 0)
    Attachment.Parent = v12
    local v14 = Kit.Emitter({
        Name = "Bubbles",
        Texture = "rbxassetid://11800775280",
        LightEmission = 0.6,
        LightInfluence = 0,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        FlipbookFramerate = NumberRange.new(20, 30),
        Rate = if not a4 then 22 else 10,
        Lifetime = NumberRange.new(2.4, 3.2),
        Speed = NumberRange.new(26, 38),
        SpreadAngle = Vector2.new(28, 28),
        EmissionDirection = Enum.NormalId.Top,
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), (NumberSequenceKeypoint.new(1, 0.9))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(0.8, 0.35),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
        Color = ColorSequence.new(Color3.fromRGB(200, 255, 245)),
    })
    v14.Parent = Attachment
    local v15 = Kit.Part({Name = "Breath", Size = Vector3.new(2, 2, 2), Transparency = 1})
    v15.CFrame = a3
    v15.Parent = v1
    local v16 = breathEmitter()
    v16.Parent = v15
    local v17 = Kit.Part({Name = "Motes", Size = Vector3.new(36, 26, 36), Transparency = 1})
    v17.CFrame = a3
    v17.Parent = v1
    local v18 = Kit.Emitter({
        Name = "Motes",
        Texture = "rbxassetid://15939596990",
        LightEmission = 1,
        LightInfluence = 0,
        Shape = Enum.ParticleEmitterShape.Box,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
        EmissionDirection = Enum.NormalId.Top,
        Orientation = Enum.ParticleOrientation.VelocityParallel,
        Lifetime = NumberRange.new(0.3, 0.55),
        Speed = NumberRange.new(80, 120),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), (NumberSequenceKeypoint.new(1, 0.15))}),
        Squash = NumberSequence.new(-2.5),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.2, 0.35),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
        Color = ColorSequence.new(Color3.fromRGB(180, 245, 235)),
    })
    v18.Parent = v17
    local v19 = lines(v12, v3, a4)
    local v20 = {}
    drifters(v1, a3, Assets, v3, v20, a4)
    ledgeProps(v1, a3, Assets, v3, v11)
    v1.Parent = a2
    v11 = {
        LineAlpha = 0,
        LineShown = -1,
        LineY = 0,
        Low = -54,
        High = 12,
        Squeeze = 1,
        Spin = 0,
        Travel = 0,
        Floor = -80,
        PipeBottom = -180,
        PipeRadius = 8.5,
        Model = v1,
        Origin = a3,
        Hub = v12,
        Strands = v13,
        Drifters = v20,
        Caustics = v2,
        Bubbles = v14,
        Glow = v4,
        EndCap = v5,
        Exit = v9,
        ExitLight = v10,
        Fog = v7,
        Slime = v8,
        Lines = v19,
        Mouth = v6,
        Breath = v16,
        BreathPart = v15,
        Motes = v18,
        MotesPart = v17,
        Quality = a4,
        Random = v3,
    }
    u303.Step(v11, 0, 0, 0)
    return v11
end

function u303.Step(a1, a2, a3, a4) -- Line: 1556
    -- upvalues: Workspace (val), stepLines (val), placeDrifter (val)
    local BottomRadius, Low, Random, v1, v2, v3, v4, v5, v6, v7
    local CurrentCamera = Workspace.CurrentCamera
    local Position = if not CurrentCamera then a1.Origin.Position else CurrentCamera.CFrame.Position
    a1.Travel = a1.Travel + a3 * a4
    a1.Spin = a1.Spin + a3 * a4
    for i, j in a1.Strands do
        v7 = j.Angle + a2 * j.Rate + a1.Spin * j.Rate * 0.5
        v2 = j.TopRadius * a1.Squeeze
        BottomRadius = j.BottomRadius
        j.Top.Position = Vector3.new(math.cos(v7) * v2, 100, (math.sin(v7)) * v2)
        j.Bottom.Position = Vector3.new(math.cos(v7 + 3.141592653589793) * BottomRadius, -80, (math.sin(v7 + 3.141592653589793)) * BottomRadius)
    end
    stepLines(a1, a2)
    local v8 = a1.Travel / 140 % 1
    for k, n in a1.Caustics do
        n.Position = UDim2.fromScale(0, v8 + -1)
    end
    local Drifters = a1.Drifters
    local v9 = nil
    local v10 = nil
    local v11, v12, v13 = a3, a4, a1
    for m, i5 in Drifters, v9, v10 do
        i5.Height = i5.Height + i5.Speed * v11 * v12
        if v13.High < i5.Height then
            i5.Height = v13.Low - v13.Random:NextNumber(0, 6)
            i5.Angle = i5.Angle + v13.Random:NextNumber(1.2, 2.4)
        elseif i5.Height < v13.Low - 12 then
            Low = v13.Low
            Random = v13.Random
            v5 = v13.High - v13.Low
            i5.Height = Low + Random:NextNumber(0, v5)
        end
        placeDrifter(v13, i5, v1)
        v8 = if not ((((i5.Model:GetPivot()) * i5.Center).Position - Position).Magnitude - i5.Reach < 8) then 0 else 1
        if v8 ~= i5.Faded then
            i5.Faded = v8
            for i6, i7 in i5.Parts do
                i7.LocalTransparencyModifier = v8
            end
        end
        v3 = nil
        v4 = nil
        for i8, i9 in i5.Glows, v3, v4 do
            v6 = if not (math.noise(v1 * 7, i5.Angle * 3) * 0.5 + 0.5 < 0.18) then 0.05 else 0.75
            i9.Transparency = v6
        end
    end
end

function u303.Light(a1, a2) -- Line: 1594 -- types: a1: table, a2: number
    a1.Glow.Brightness = a2
    a1.Mouth.Brightness = a2 * 0.3
end

function u303.Follow(a1, a2) -- Line: 1599 -- types: a1: table, a2: number
    a1.Low = math.max(a2 - 100, -54)
    a1.High = a2 + 40
end

function u303.Rush(a1, a2, a3) -- Line: 1604 -- types: a1: table, a2: number, a3: vector
    local v1 = math.clamp(a2, 0, 1)
    local v2 = if not a1.Quality then 1 else 0.5
    a1.LineAlpha = v1
    a1.LineY = a1.Origin:PointToObjectSpace(a3).Y
    a1.Breath.Rate = v2 * 30 * v1
    a1.BreathPart.CFrame = CFrame.new(a3)
    a1.Motes.Rate = v2 * 70 * v1
    a1.MotesPart.CFrame = CFrame.new(a3 + Vector3.new(0, 4, 0))
end

function u303.Tighten(a1, a2) -- Line: 1615 -- types: a1: table, a2: number
    a1.Squeeze = a2
end

function u303.Fog(a1, a2) -- Line: 1619 -- types: a1: table, a2: number
    local v1
    local v2 = math.clamp(a2, 0, 1)
    for i, j in a1.Fog do
        j.Transparency = 1 - v2 * 0.5800000000000001
    end
    a1.EndCap.Transparency = math.lerp(0.35, 1, v2)
    local v3 = nil
    local v4 = nil
    for k, n in a1.Slime, v3, v4 do
        v1 = v2 < 0.5
        n.Enabled = v1
    end
end

function u303.Exit(a1, a2) -- Line: 1630 -- types: a1: table, a2: number
    local v1 = math.clamp(a2, 0, 1)
    a1.Exit.Transparency = math.lerp(1, 0.08, v1)
    a1.ExitLight.Brightness = v1 * 3
    for i, j in a1.Fog do
        j.Transparency = math.max(j.Transparency, v1)
    end
end

return table.freeze(u303)