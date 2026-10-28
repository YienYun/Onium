-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Kit
-- Decompile time: 10.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Packages.Trove)
local v1 = Color3.new(1, 1, 1)
local u36 = table.freeze({0, 0.3141592653589793, 0.5934119456780721})
local u44 = table.freeze({0, 0.6981317007977318, -0.6981317007977318, 1.4835298641951802, -1.4835298641951802})
local u45 = {Name = "SewerDrain"}
u45.Teal = Color3.fromRGB(52, 191, 112)
u45.DeepTeal = Color3.fromRGB(34, 111, 100)
u45.Foam = Color3.fromRGB(230, 255, 250)
u45.Rust = Color3.fromRGB(122, 72, 44)
u45.CaveGreen = Color3.fromRGB(119, 180, 123)
u45.Moon = Color3.fromRGB(170, 215, 255)
u45.Looks = table.freeze({
    Clear = table.freeze({
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        Bloom = 0,
        Blur = 0,
        Tint = v1,
    }),
    MoonTeal = table.freeze({
        Brightness = 0.02,
        Contrast = 0.08,
        Saturation = 0.25,
        Bloom = 1.2,
        Blur = 0,
        Tint = Color3.fromRGB(200, 255, 240),
    }),
    Flash = table.freeze({
        Brightness = 0.6,
        Contrast = 0,
        Saturation = 0.2,
        Bloom = 2.2,
        Blur = 18,
        Tint = Color3.fromRGB(220, 255, 245),
    }),
    Drowned = table.freeze({
        Brightness = 0.02,
        Contrast = 0.1,
        Saturation = -0.1,
        Bloom = 0.9,
        Blur = 0,
        Tint = Color3.fromRGB(170, 230, 255),
    }),
    Deep = table.freeze({
        Brightness = -0.1,
        Contrast = 0.18,
        Saturation = -0.05,
        Bloom = 1.1,
        Blur = 0,
        Tint = Color3.fromRGB(130, 170, 240),
    }),
    Pipe = table.freeze({
        Brightness = -0.05,
        Contrast = 0.12,
        Saturation = 0.05,
        Bloom = 0.7,
        Blur = 0,
        Tint = Color3.fromRGB(255, 225, 190),
    }),
    Throat = table.freeze({
        Brightness = -0.06,
        Contrast = 0.2,
        Saturation = 0.12,
        Bloom = 0.9,
        Blur = 0,
        Tint = Color3.fromRGB(180, 230, 200),
    }),
    Gullet = table.freeze({
        Brightness = 0.04,
        Contrast = 0.16,
        Saturation = 0.25,
        Bloom = 1.4,
        Blur = 4,
        Tint = Color3.fromRGB(185, 255, 200),
    }),
    Under = table.freeze({
        Brightness = -0.05,
        Contrast = 0.12,
        Saturation = -0.05,
        Bloom = 0.5,
        Blur = 5,
        Tint = Color3.fromRGB(130, 210, 215),
    }),
    Swallow = table.freeze({
        Brightness = -0.34,
        Contrast = 0.24,
        Saturation = 0.05,
        Bloom = 0.4,
        Blur = 3,
        Tint = Color3.fromRGB(110, 170, 125),
    }),
    GreenGlow = table.freeze({
        Brightness = 0.3,
        Contrast = -0.05,
        Saturation = 0.1,
        Bloom = 1.6,
        Blur = 10,
        Tint = Color3.fromRGB(210, 255, 215),
    }),
    Afterglow = table.freeze({
        Brightness = 0.06,
        Contrast = 0.05,
        Saturation = 0.15,
        Bloom = 1.2,
        Blur = 10,
        Tint = Color3.fromRGB(215, 255, 235),
    }),
    Haze = table.freeze({
        Brightness = 0.08,
        Contrast = -0.05,
        Saturation = -0.1,
        Bloom = 0.6,
        Blur = 6,
        Tint = Color3.fromRGB(190, 240, 235),
    }),
})

function u45.Ease(a1, a2, a3) -- Line: 168 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), a2, a3)
end

function u45.Smooth(a1) -- Line: 172 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

function u45.Span(a1, a2, a3) -- Line: 177 -- types: a1: number, a2: number, a3: number
    if not (a3 <= a2) then
        return (math.clamp((a1 - a2) / (a3 - a2), 0, 1))
    end
    if a3 <= a1 then
        return 1
    end
    return 0
end

function u45.Flat(a1) -- Line: 184 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

function u45.FlatUnit(a1, a2) -- Line: 188 -- types: a1: vector, a2: vector
    local v1 = Vector3.new(a1.X, 0, a1.Z)
    if 0.01 < v1.Magnitude then
        return v1.Unit
    end
    return a2
end

function u45.LowQuality() -- Line: 193 -- upvalues: UserGameSettings (val)
    local success, err = pcall(function() -- Line: 194 -- upvalues: UserGameSettings (upval)
        return UserGameSettings.SavedQualityLevel.Value
    end)
    local v1 = success
    if v1 then
        v1 = false
        if err >= 1 then
            v1 = err <= 3
        end
    end
    return v1
end

function u45.Mix(a1, a2, a3, a4) -- Line: 200 -- types: a1: table, a2: table, a3: table, a4: number
    local v1 = math.clamp(a4, 0, 1)
    a1.Brightness = math.lerp(a2.Brightness, a3.Brightness, v1)
    a1.Contrast = math.lerp(a2.Contrast, a3.Contrast, v1)
    a1.Saturation = math.lerp(a2.Saturation, a3.Saturation, v1)
    a1.Tint = a2.Tint:Lerp(a3.Tint, v1)
    a1.Bloom = math.lerp(a2.Bloom, a3.Bloom, v1)
    a1.Blur = math.lerp(a2.Blur, a3.Blur, v1)
end

function u45.Grade(a1, a2) -- Line: 210 -- upvalues: u45 (val) -- types: a2: userdata
    local v1 = a1:Add((Instance.new("ColorCorrectionEffect")))
    v1.Name = "SewerDrain"
    v1.Parent = a2
    local v2 = a1:Add((Instance.new("BloomEffect")))
    v2.Name = "SewerDrain"
    v2.Intensity = 0
    v2.Size = 40
    v2.Threshold = 0.9
    v2.Parent = a2
    local v3 = a1:Add((Instance.new("BlurEffect")))
    v3.Name = "SewerDrain"
    v3.Size = 0
    v3.Parent = a2
    local v4 = a1:Add((Instance.new("DepthOfFieldEffect")))
    v4.Name = "SewerDrain"
    v4.Enabled = false
    v4.FarIntensity = 0.25
    v4.NearIntensity = 0
    v4.InFocusRadius = 10
    v4.FocusDistance = 20
    v4.Parent = a2
    return {
        Color = v1,
        Bloom = v2,
        Blur = v3,
        Depth = v4,
        Look = table.clone(u45.Looks.Clear),
    }
end

function u45.Apply(a1, a2) -- Line: 241 -- types: a1: table, a2: number
    local Look = a1.Look
    a1.Color.Brightness = Look.Brightness + a2 * 0.03
    a1.Color.Contrast = Look.Contrast
    a1.Color.Saturation = Look.Saturation
    a1.Color.TintColor = Look.Tint
    a1.Bloom.Intensity = Look.Bloom + a2 * 0.2
    a1.Blur.Size = Look.Blur
end

function u45.Part(a1) -- Line: 251 -- types: a1: table?
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    if a1 then
        for i, j in a1 do
            Part[i] = j
        end
    end
    return Part
end

function u45.Quiet(a1) -- Line: 268 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = false
        elseif j:IsA("LuaSourceContainer") or j:IsA("Sound") then
            j:Destroy()
        end
    end
end

function u45.Emitter(a1) -- Line: 282 -- types: a1: table
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Rate = 0
    ParticleEmitter.LockedToPart = false
    for i, j in a1 do
        ParticleEmitter[i] = j
    end
    return ParticleEmitter
end

function u45.Beam(a1) -- Line: 292 -- types: a1: table
    local Beam = Instance.new("Beam")
    Beam.LightInfluence = 0
    Beam.Segments = 10
    for i, j in a1 do
        Beam[i] = j
    end
    return Beam
end

function u45.Clamp(a1, a2, a3, a4) -- Line: 302
    -- upvalues: Workspace (val)
    local Instance, v1, v2
    local v3 = a2 - a1
    if v3.Magnitude < 0.05 then
        return a2
    end
    local v4 = table.clone(a3)
    local v5 = RaycastParams.new()
    v5.FilterType = Enum.RaycastFilterType.Exclude
    v5.RespectCanCollide = false
    local v6, v7 = a4, a1
    for i = 1, 6 do
        v5.FilterDescendantsInstances = v4
        v1 = if not v6 then Workspace:Raycast(v7, v3, v5) else Workspace:Spherecast(v7, 0.9, v3, v5)
        if v1 == nil then
            return a2
        end
        Instance = v1.Instance
        if Instance:IsA("BasePart") and 0.9 <= Instance.Transparency then
            table.insert(v4, Instance)
            continue
        end
        v2 = if not v6 then math.max((v1.Position - v7).Magnitude - 0.8, 0.5) else math.max(v1.Distance - 0.4, 0.5)
        return v7 + v3.Unit * v2
    end
    return a2
end

function u45.Clearance(a1, a2, a3) -- Line: 332 -- upvalues: u45 (val) -- types: a1: vector, a2: vector, a3: table
    return (u45.Clamp(a1, a2, a3) - a1).Magnitude
end

function u45.Orbit(a1, a2, a3, a4, a5) -- Line: 336
    -- upvalues: u45 (val), u36 (val), u44 (val)
    local Magnitude, v1, v2, v3
    local v4 = u45.FlatUnit(a2, (Vector3.new(0, 0, 1)))
    local v5 = a1
    local v6 = -1
    local v7 = nil
    local v8 = nil
    for i, j in u36, v7, v8 do
        for k, n in u44 do
            v1 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), n) * v4
            v2 = math.max(v9 - j, 0.13962634015954636)
            v3 = v10 + v1 * v11 * math.cos(v2) + Vector3.new(0, 1, 0) * v11 * math.sin(v2)
            v2 = u45.Clamp(v10, v3, v12)
            Magnitude = (v2 - v10).Magnitude
            if v11 * 0.85 <= Magnitude then
                return v2
            end
            if v6 < Magnitude then
                v5 = v2
            end
        end
    end
    return v5
end

function u45.Swing(a1, a2, a3, a4, a5) -- Line: 367
    -- upvalues: u45 (val)
    local v1 = a2 - a1
    local v2 = a3 - a1
    local v3 = math.atan2(v1.X, v1.Z)
    local v4 = v3 + ((math.atan2(v2.X, v2.Z) - v3 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * a4
    local Magnitude = (Vector3.new(v1.X, 0, v1.Z)).Magnitude
    local Magnitude_2 = (Vector3.new(v2.X, 0, v2.Z)).Magnitude
    v3 = math.lerp(math.atan2(v1.Y, (math.max(Magnitude, 0.01))), math.atan2(v2.Y, (math.max(Magnitude_2, 0.01))), a4)
    return u45.Clamp(
        a1,
        a1 + (Vector3.new((math.sin(v4)) * math.cos(v3), math.sin(v3), (math.cos(v4)) * (math.cos(v3)))) * (math.max(math.lerp(v1.Magnitude, v2.Magnitude, a4), 5)),
        a5,
        true
    )
end

function u45.Projected(a1, a2) -- Line: 394 -- types: a1: userdata, a2: vector
    local v1, v2 = a1:WorldToViewportPoint(a2)
    local ViewportSize = a1.ViewportSize
    if not (ViewportSize.X < 1) and not (ViewportSize.Y < 1) then
        return (Vector2.new(v1.X / ViewportSize.X, v1.Y / ViewportSize.Y)), v2 and 0 < v1.Z
    end
    return (Vector2.new(0.5, 0.5)), false
end

return table.freeze(u45)