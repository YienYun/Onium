-- Script path: ReplicatedStorage.Controllers.Game.TrainGhostVisuals.SuckFX
-- Decompile time: 21.13 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local u42 = Color3.new(1, 1, 1)
local u47 = Color3.fromRGB(70, 255, 90)
local u52 = Color3.fromRGB(20, 210, 60)
local u57 = Color3.fromRGB(170, 255, 60)
local u58 = {}
local u59 = {}
u59.__index = u59

local function asset(...) -- Line: 87 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    for i, j in {...} do
        Assets = if not Assets then nil else Assets:FindFirstChild(j)
    end
    if Assets and Assets:IsA("Sound") then
        return Assets
    end
    return nil
end

local function ease(a1, a2, a3, a4) -- Line: 95 -- types: a1: number, a2: number, a3: number, a4: number
    return a1 + (a2 - a1) * (1 - math.exp(-a3 * a4))
end

local function fade(a1, a2) -- Line: 99 -- types: a1: table, a2: number
    local v1
    local v2 = {}
    for i, j in a1 do
        v1 = (i - 1) / (#a1 - 1)
        table.insert(v2, (NumberSequenceKeypoint.new(v1, 1 - (1 - j) * a2)))
    end
    return NumberSequence.new(v2)
end

local function newBeam(a1, a2, a3) -- Line: 108 -- types: a1: userdata, a2: string, a3: string
    local Beam = Instance.new("Beam")
    Beam.Name = a2
    Beam.Attachment0 = a1
    Beam.Texture = a3
    Beam.TextureMode = Enum.TextureMode.Wrap
    Beam.FaceCamera = true
    Beam.LightEmission = 0.35
    Beam.LightInfluence = 0
    Beam.Segments = 24
    Beam.Enabled = false
    Beam.Parent = a1
    return Beam
end

local function newEmitter(a1, a2, a3) -- Line: 123 -- types: a1: userdata, a2: string, a3: string
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = a2
    ParticleEmitter.Texture = a3
    ParticleEmitter.LightEmission = 0.5
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Rate = 0
    ParticleEmitter.Enabled = false
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

local function catchEmitters() -- Line: 135 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v1 = Assets and Assets:FindFirstChild("VFX")
    local Butterflies = v1 and v1:FindFirstChild("Butterflies")
    v1 = Butterflies and Butterflies:FindFirstChild("Catch")
    local v2 = {}
    if v1 == nil then
        return v2
    end
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            table.insert(v2, j)
        end
    end
    return v2
end

local function mouthFor(a1) -- Line: 152
    -- upvalues: u58 (val), Trove (val), u47 (val), u57 (val), u42 (val), u52 (val), Audio (val)
    local v1 = u58[a1]
    if v1 and v1.Attachment.Parent ~= nil then
        return v1
    end
    if v1 then
        v1.Trove:Destroy()
        u58[a1] = nil
    end
    local Parent = a1.Parent
    if Parent ~= nil and Parent:IsA("BasePart") then
        local v2 = Trove.new()
        local v3 = v2:Add((Instance.new("Attachment")))
        v3.Name = "GhostSuctionMouth"
        v3.CFrame = a1.CFrame
        v3.Parent = Parent
        v1 = Instance.new("PointLight")
        v1.Name = "SuctionGlow"
        v1.Color = u47
        v1.Brightness = 0
        v1.Range = 10
        v1.Shadows = false
        v1.Parent = v3
        local ParticleEmitter = Instance.new("ParticleEmitter")
        ParticleEmitter.Name = "SuctionVortex"
        ParticleEmitter.Texture = "rbxassetid://109600784699514"
        ParticleEmitter.LightEmission = 0.5
        ParticleEmitter.LightInfluence = 0
        ParticleEmitter.Rate = 0
        ParticleEmitter.Enabled = false
        ParticleEmitter.Parent = v3
        ParticleEmitter.Color = ColorSequence.new(u47, u57)
        ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.8), (NumberSequenceKeypoint.new(1, 0.15))})
        ParticleEmitter.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.25, 0.25),
            (NumberSequenceKeypoint.new(1, 0.5)),
        })
        ParticleEmitter.Lifetime = NumberRange.new(0.3, 0.38)
        ParticleEmitter.Speed = NumberRange.new(0)
        ParticleEmitter.Rotation = NumberRange.new(0, 360)
        ParticleEmitter.RotSpeed = NumberRange.new(-420, -260)
        ParticleEmitter.LockedToPart = true
        local ParticleEmitter_2 = Instance.new("ParticleEmitter")
        ParticleEmitter_2.Name = "SuctionSparks"
        ParticleEmitter_2.Texture = "rbxassetid://6749866161"
        ParticleEmitter_2.LightEmission = 0.5
        ParticleEmitter_2.LightInfluence = 0
        ParticleEmitter_2.Rate = 0
        ParticleEmitter_2.Enabled = false
        ParticleEmitter_2.Parent = v3
        ParticleEmitter_2.Color = ColorSequence.new(u47:Lerp(u42, 0.35), u52)
        ParticleEmitter_2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), (NumberSequenceKeypoint.new(1, 0))})
        ParticleEmitter_2.Lifetime = NumberRange.new(0.15, 0.25)
        ParticleEmitter_2.Speed = NumberRange.new(0.5, 2)
        ParticleEmitter_2.SpreadAngle = Vector2.new(180, 180)
        ParticleEmitter_2.LockedToPart = true
        local v4 = {
            Intensity = 0,
            Progress = 0,
            Angle = 0,
            Fed = false,
            Nozzle = a1,
            Attachment = v3,
            Light = v1,
            Vortex = ParticleEmitter,
            Inflow = ParticleEmitter_2,
            Born = os.clock(),
            Trove = v2,
        }
        local v5 = Audio.Play(114059897952698, v3, {Volume = 0.5, MaxDistance = 60})
        if not v5 then
            v4.Born = v4.Born - 2.2
        else
            v4.Startup = v2:Add(v5)
        end
        v5 = Audio.Play(100665426632741, v3, {Looped = true, Volume = 0, MaxDistance = 60})
        if v5 then
            v4.Hum = v2:Add(v5)
        end
        u58[a1] = v4
        return v4
    end
    return nil
end

local function feed(a1, a2) -- Line: 243 -- upvalues: mouthFor (val) -- types: a1: userdata, a2: number
    local v1 = mouthFor(a1)
    if v1 == nil then
        return nil
    end
    v1.Fed = true
    v1.Progress = a2
    return v1.Attachment
end

function u59.Step(a1) -- Line: 253 -- upvalues: u58 (val), u47 (val), u42 (val) -- types: a1: number
    local Hum, Intensity, Intensity_2, Progress, Progress_2, Startup, v1, v2, v3, v4, v5
    local v6 = os.clock()
    local v7 = nil
    local v8 = nil
    for i, j in u58, v7, v8 do
        if j.Attachment.Parent == nil then
            j.Trove:Destroy()
            u58[i] = nil
        elseif i.Parent ~= nil then
            Intensity = j.Intensity
            v5 = if not j.Fed then 0 else 1
            v1 = if not j.Fed then 8 else 14
            v2 = v5 - Intensity
            v4 = -v1 * v9
            j.Intensity = Intensity + v2 * (1 - math.exp(v4))
            if not j.Fed then
                Progress = j.Progress
                v1 = 0 - Progress
                v3 = v9 * -6
                j.Progress = Progress + v1 * (1 - math.exp(v3))
            end
            Intensity_2 = j.Intensity
            Progress_2 = j.Progress
            j.Angle = (j.Angle + v9 * (Progress_2 * 14 + 5)) % 6.283185307179586
            j.Attachment.CFrame = i.CFrame * CFrame.Angles(0, 0, j.Angle)
            j.Light.Brightness = (Progress_2 * 3.5 + 2.5 + math.sin(v6 * 22) * 0.6) * Intensity_2
            j.Light.Range = Progress_2 * 8 + 8
            j.Light.Color = u47:Lerp(u42, Progress_2 * 0.5)
            j.Vortex.Enabled = Intensity_2 > 0.05
            j.Vortex.Rate = (Progress_2 * 10 + 7) * Intensity_2
            j.Inflow.Enabled = Intensity_2 > 0.05
            j.Inflow.Rate = (Progress_2 * 40 + 20) * Intensity_2
            Startup = j.Startup
            if Startup and Startup.Parent ~= nil then
                Startup.Volume = math.min(Intensity_2 * 4, 1) * 0.5
            end
            Hum = j.Hum
            if Hum then
                v1 = math.clamp((v6 - j.Born - 1.4) / 0.8, 0, 1)
                Hum.Volume = (Progress_2 * 0.13 + 0.42) * Intensity_2 * v1
                Hum.PlaybackSpeed = Progress_2 * 0.15 + 0.95
            end
            if j.Fed or not (Intensity_2 < 0.01) then
                j.Fed = false
            else
                j.Trove:Destroy()
                u58[i] = nil
            end
        else
            j.Trove:Destroy()
            u58[i] = nil
        end
    end
end

function u59.new(a1) -- Line: 296
    -- upvalues: Trove (val), Workspace (val), u52 (val), u47 (val), u57 (val), u42 (val), u59 (val)
    local v1, v2
    local u3 = Trove.new()
    u3:Connect(a1.Destroying, function() -- Line: 298 -- upvalues: u3 (val)
        u3:Destroy()
    end)
    local v3 = u3:Add((Instance.new("Attachment")))
    v3.Name = "GhostSuctionPoint"
    v3.WorldCFrame = a1:GetPivot()
    v3.Parent = Workspace.Terrain
    local Beam = Instance.new("Beam")
    Beam.Name = "SuctionVortex"
    Beam.Attachment0 = v3
    Beam.Texture = "rbxassetid://18925205019"
    Beam.TextureMode = Enum.TextureMode.Wrap
    Beam.FaceCamera = true
    Beam.LightEmission = 0.35
    Beam.LightInfluence = 0
    Beam.Segments = 24
    Beam.Enabled = false
    Beam.Parent = v3
    Beam.TextureLength = 4
    Beam.TextureSpeed = 2.6
    Beam.Brightness = 3
    Beam.LightEmission = 0.35
    Beam.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, u52),
        ColorSequenceKeypoint.new(0.5, u47),
        (ColorSequenceKeypoint.new(1, u57)),
    })
    local Beam_2 = Instance.new("Beam")
    Beam_2.Name = "SuctionCore"
    Beam_2.Attachment0 = v3
    Beam_2.Texture = "rbxassetid://15939596990"
    Beam_2.TextureMode = Enum.TextureMode.Wrap
    Beam_2.FaceCamera = true
    Beam_2.LightEmission = 0.35
    Beam_2.LightInfluence = 0
    Beam_2.Segments = 24
    Beam_2.Enabled = false
    Beam_2.Parent = v3
    Beam_2.TextureLength = 2
    Beam_2.TextureSpeed = 5
    Beam_2.Brightness = 6
    Beam_2.ZOffset = 0.1
    Beam_2.Color = ColorSequence.new(Color3.fromRGB(40, 150, 50), Color3.fromRGB(15, 120, 30))
    local v4 = {}
    for i = 1, 2 do
        v1 = "SuctionRibbon" .. i
        v2 = Instance.new("Beam")
        v2.Name = v1
        v2.Attachment0 = v3
        v2.Texture = "rbxassetid://14261159751"
        v2.TextureMode = Enum.TextureMode.Wrap
        v2.FaceCamera = true
        v2.LightEmission = 0.35
        v2.LightInfluence = 0
        v2.Segments = 24
        v2.Enabled = false
        v2.Parent = v3
        v2.TextureLength = 3
        v2.TextureSpeed = i + 3.5
        v2.Brightness = 4
        v2.ZOffset = 0.05
        v2.Color = ColorSequence.new(u47, u57)
        table.insert(v4, v2)
    end
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "SuctionMotes"
    ParticleEmitter.Texture = "rbxassetid://6749866161"
    ParticleEmitter.LightEmission = 0.5
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Rate = 0
    ParticleEmitter.Enabled = false
    ParticleEmitter.Parent = v3
    ParticleEmitter.Color = ColorSequence.new(u47:Lerp(u42, 0.35), u47)
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.65), (NumberSequenceKeypoint.new(1, 0.1))})
    ParticleEmitter.Transparency = NumberSequence.new(0.1, 0.4)
    ParticleEmitter.Lifetime = NumberRange.new(0.32)
    ParticleEmitter.SpreadAngle = Vector2.new(14, 14)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Front
    local ParticleEmitter_2 = Instance.new("ParticleEmitter")
    ParticleEmitter_2.Name = "SuctionSouls"
    ParticleEmitter_2.Texture = "rbxassetid://15580440964"
    ParticleEmitter_2.LightEmission = 0.5
    ParticleEmitter_2.LightInfluence = 0
    ParticleEmitter_2.Rate = 0
    ParticleEmitter_2.Enabled = false
    ParticleEmitter_2.Parent = v3
    ParticleEmitter_2.Color = ColorSequence.new(u52, u47)
    ParticleEmitter_2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.1), (NumberSequenceKeypoint.new(1, 0.15))})
    ParticleEmitter_2.Transparency = NumberSequence.new(0, 0.3)
    ParticleEmitter_2.Lifetime = NumberRange.new(0.32)
    ParticleEmitter_2.Rotation = NumberRange.new(0, 360)
    ParticleEmitter_2.RotSpeed = NumberRange.new(-300, 300)
    ParticleEmitter_2.SpreadAngle = Vector2.new(22, 22)
    ParticleEmitter_2.EmissionDirection = Enum.NormalId.Front
    local ParticleEmitter_3 = Instance.new("ParticleEmitter")
    ParticleEmitter_3.Name = "SuctionWisps"
    ParticleEmitter_3.Texture = "rbxassetid://84182473776460"
    ParticleEmitter_3.LightEmission = 0.5
    ParticleEmitter_3.LightInfluence = 0
    ParticleEmitter_3.Rate = 0
    ParticleEmitter_3.Enabled = false
    ParticleEmitter_3.Parent = v3
    ParticleEmitter_3.Color = ColorSequence.new(u47, u52)
    ParticleEmitter_3.LightEmission = 0.6
    ParticleEmitter_3.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.4), (NumberSequenceKeypoint.new(1, 0.2))})
    ParticleEmitter_3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), (NumberSequenceKeypoint.new(1, 1))})
    ParticleEmitter_3.Lifetime = NumberRange.new(0.4, 0.55)
    ParticleEmitter_3.Rotation = NumberRange.new(0, 360)
    ParticleEmitter_3.RotSpeed = NumberRange.new(-120, 120)
    ParticleEmitter_3.SpreadAngle = Vector2.new(55, 55)
    ParticleEmitter_3.EmissionDirection = Enum.NormalId.Front
    return (setmetatable({
        Intensity = 0,
        Spin = 0,
        SpinRate = 0,
        Clock = 0,
        Model = a1,
        Trove = u3,
        Point = v3,
        Vortex = Beam,
        Core = Beam_2,
        Ribbons = v4,
        Motes = ParticleEmitter,
        Souls = ParticleEmitter_2,
        Wisps = ParticleEmitter_3,
    }, u59))
end

function u59.Scale(a1, a2) -- Line: 398 -- types: a2: number
    local v1 = math.sin(a1.Clock * (a2 * 22 + 10)) * 0.05 * a1.Intensity
    return (1 - a2 * 0.82) * (1 + v1)
end

function u59.Pose(a1, a2, a3, a4, a5) -- Line: 403 -- types: a2: userdata, a3: userdata?, a4: number, a5: number
    a1.Clock = a1.Clock + a5
    local v1 = if not a3 then 0 else a4 ^ 1.3 * 24 + 2
    local SpinRate = a1.SpinRate
    a1.SpinRate = SpinRate + (v1 - SpinRate) * (1 - math.exp(-(if not a3 then 4 else 6) * a5))
    a1.Spin = (a1.Spin + a1.SpinRate * a5) % 6.283185307179586
    if a3 == nil and a1.SpinRate < 1.5 then
        local Spin = a1.Spin
        a1.Spin = Spin + ((if not (3.141592653589793 < a1.Spin) then 0 else 6.283185307179586) - Spin) * (1 - math.exp(a5 * -8))
    end
    if a3 then
        a1.Pull = a3.WorldPosition
    elseif a4 < 0.001 then
        a1.Pull = nil
    end
    local Position = a2.Position
    local Pull = a1.Pull
    if Pull then
        Position = Position:Lerp(Pull, a4 * 0.8)
    end
    local v2 = 0
    if a3 then
        local v3 = (a4 * 0.22 + 0.04) * a1.Intensity
        local v4 = a1.Clock * 11
        Position = Position + Vector3.new(math.noise(v4, 1.3), math.noise(v4, 2.7), (math.noise(v4, 4.1))) * v3
        v2 = (math.sin(a1.Clock * 15)) * (a4 * 0.1 + 0.07)
    end
    return (CFrame.new(Position)) * a2.Rotation * CFrame.Angles(0, a1.Spin, v2)
end

function u59.Update(a1, a2, a3, a4) -- Line: 437
    -- upvalues: mouthFor (val), fade (val), u47 (val), u42 (val), u52 (val)
    local Attachment, v1
    if not a2 then
        Attachment = nil
    else
        v1 = mouthFor(a2)
        if v1 ~= nil then
            v1.Fed = true
            v1.Progress = a3
            Attachment = v1.Attachment
        else
            Attachment = nil
        end
    end
    if Attachment then
        a1.Mouth = Attachment
    end
    v1 = Attachment ~= nil
    local Intensity = a1.Intensity
    a1.Intensity = Intensity + ((if not v1 then 0 else 1) - Intensity) * (1 - math.exp(-(if not v1 then 9 else 14) * a4))
    local Intensity_2 = a1.Intensity
    local Mouth = a1.Mouth
    local v2 = {a1.Vortex, a1.Core, a1.Ribbons[1], a1.Ribbons[2]}
    local v3 = {a1.Motes, a1.Souls, a1.Wisps}
    if not (Intensity_2 < 0.01) and Mouth ~= nil and Mouth.Parent ~= nil then
        local v4, v5
        local Clock = a1.Clock
        local Position = a1.Model:GetPivot().Position
        local WorldPosition = Mouth.WorldPosition
        local Magnitude = (WorldPosition - Position).Magnitude
        a1.Point.WorldCFrame = (CFrame.lookAt(Position, WorldPosition)) * CFrame.Angles(0, 0, Clock * 6)
        local v6 = math.sin(Clock * (a3 * 16 + 12)) * 0.15 + 1
        local v7 = 1 - a3
        for i, j in v2 do
            j.Attachment1 = Mouth
            j.Enabled = true
        end
        a1.Vortex.Width0 = (v7 * 2.8 + 0.9) * v6
        a1.Vortex.Width1 = a3 * 0.4 + 0.8
        a1.Vortex.CurveSize0 = math.sin(Clock * 7) * 0.5
        a1.Vortex.CurveSize1 = math.cos(Clock * 5) * 0.3
        a1.Vortex.Transparency = fade({0.2, 0.05, 0}, Intensity_2)
        a1.Core.Width0 = (v7 * 1.1 + 0.35) * v6
        a1.Core.Width1 = a3 * 0.2 + 0.3
        a1.Core.Transparency = fade({0.35, 0.1, 0}, Intensity_2)
        v6 = (math.min(Magnitude * 0.35, 3)) * (1 - a3 * 0.5)
        local Ribbons = a1.Ribbons
        local v8 = nil
        local v9 = nil
        local v10, v11 = a1, a3
        for k, n in Ribbons, v8, v9 do
            v2 = if k ~= 1 then -1 else 1
            n.Width0 = v7 * 0.5 + 0.15
            n.Width1 = 0.12
            v4 = v2 * v6
            v5 = Clock * 9 + k
            n.CurveSize0 = v4 * math.sin(v5)
            v4 = -v2 * v6 * 0.45
            v5 = Clock * 9 + k
            n.CurveSize1 = v4 * math.cos(v5)
            n.Transparency = fade({0.6, 0.15, 0.3}, Intensity_2)
        end
        v6 = math.clamp(Magnitude / 0.32, 4, 80)
        v10.Motes.Speed = NumberRange.new(v6 * 0.85, v6)
        v10.Motes.Rate = (v11 * 60 + 45) * Intensity_2
        v10.Souls.Speed = NumberRange.new(v6 * 0.8, v6)
        v10.Souls.Rate = (v11 * 14 + 8) * Intensity_2
        v10.Wisps.Speed = NumberRange.new(v6 * 0.35, v6 * 0.6)
        v10.Wisps.Rate = (v11 * 18 + 10) * Intensity_2
        for m, i5 in v3 do
            i5.Enabled = v1
        end
        local Highlight = v10.Highlight
        if Highlight == nil then
            v6 = v10.Trove:Add((Instance.new("Highlight")))
            v6.Name = "GhostSuctionGlow"
            v6.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            v6.Adornee = v10.Model
            v6.Parent = v10.Model
            v10.Highlight = v6
            Highlight = v6
        end
        v7 = Highlight
        local v12 = math.sin(Clock * (v11 * 16 + 7)) * 0.5 + 0.5
        v7.FillColor = u47:Lerp(u42, (math.min(v11 * 0.6 + v12 * 0.25, 1)))
        v7.OutlineColor = u42:Lerp(u52, v12 * 0.6)
        v7.FillTransparency = 1 - math.clamp(v12 * 0.3 + 0.12 + v11 * 0.18, 0, 0.6) * Intensity_2
        v7.OutlineTransparency = 1 - (v12 * 0.45 + 0.55) * Intensity_2
        return
    end
    for i6, i7 in v2 do
        i7.Enabled = false
    end
    for i8, i9 in v3 do
        i9.Enabled = false
    end
    local Highlight_3 = a1.Highlight
    if Highlight_3 then
        a1.Highlight = nil
        a1.Trove:Remove(Highlight_3)
    end
    if not v1 then
        a1.Mouth = nil
    end
end

function u59:Destroy() -- Line: 525
    self.Highlight = nil
    self.Mouth = nil
    self.Trove:Destroy()
end

function u59.Captured(a1, a2) -- Line: 531
    -- upvalues: u42 (val), u47 (val), TweenService (val), Audio (val)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "GhostCaptureFlash"
    Highlight.FillColor = u42
    Highlight.FillTransparency = 0
    Highlight.OutlineColor = u47
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Adornee = a1
    Highlight.Parent = a1
    TweenService:Create(Highlight, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {FillTransparency = 0.5, FillColor = u47}):Play()
    Audio.Play(
        83010339546205,
        if not a2 then a1:GetPivot() else if a2.Parent == nil then a1:GetPivot() else a2,
        {Volume = 0.65, MaxDistance = 60}
    )
end

function u59.CaptureSpin(a1) -- Line: 551 -- types: a1: number
    return a1 * 6.283185307179586 * 3
end

function u59.Burst(a1, a2) -- Line: 555
    -- upvalues: VFX (val), catchEmitters (val), u42 (val), u47 (val), Workspace (val), TweenService (val), asset (val)
    -- upvalues: Audio (val), Flash (val), Shake (val)
    local WorldPosition = a1.WorldPosition
    VFX.EmitAt(WorldPosition, catchEmitters(), function(a1) -- Line: 557 -- upvalues: u42 (upval), u47 (upval) -- types: a1: userdata
        if a1:GetAttribute("TierTint") == true then
            a1.Color = ColorSequence.new(u42, u47)
        end
    end)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "GhostCaptureBurst"
    Attachment.WorldPosition = WorldPosition
    Attachment.Parent = Workspace.Terrain
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u47
    PointLight.Brightness = 9
    PointLight.Range = 18
    PointLight.Shadows = false
    PointLight.Parent = Attachment
    TweenService:Create(PointLight, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Brightness = 0, Range = 6}):Play()
    VFX.Discard(Attachment, 0.4)
    local v1 = if not a2 then asset("ShootingStar", "Sounds", "BuddyPop") else nil
    if v1 then
        Audio.Play(v1, WorldPosition, {Volume = 0.85, MaxDistance = 60, PlaybackSpeed = {1, 1.15}})
    end
    v1 = if not a2 then asset("HalloweenDimension", "Sounds", "PumpkinCatch") else nil
    if v1 then
        Audio.Play(v1, WorldPosition, {Volume = 0.5, MaxDistance = 60, PlaybackSpeed = {0.95, 1.05}})
    end
    Flash.Play({Attack = 0.02, Decay = 0.28, Opacity = 0.18, Tint = u47})
    Shake.Play({Seconds = 0.22, Magnitude = 0.3, Shape = "Fade"})
end

return u59