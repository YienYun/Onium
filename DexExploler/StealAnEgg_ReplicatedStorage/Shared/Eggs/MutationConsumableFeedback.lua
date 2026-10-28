-- Script path: ReplicatedStorage.Shared.Eggs.MutationConsumableFeedback
-- Decompile time: 57.15 ms

local Debris = game:GetService("Debris")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BossMastery = require(ReplicatedStorage.Data.BossMastery)
local Shake = require(ReplicatedStorage.Client.Shake)
local EggActionMovement = require(script.Parent.EggActionMovement)
local Log = require(ReplicatedStorage.Packages.Log)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local PlayVFX = require(ReplicatedStorage.UserGenerated.VFX.PlayVFX)
local VisibleBounds = require(ReplicatedStorage.Shared.Utils.VisibleBounds)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local Preload = require(ReplicatedStorage.Shared.Utils.Preload)
local u85 = {
    Scrambled = "DrScrambleMutationVFX",
    Nitro = "NitroMutationVFX",
    Spectral = "SpectralMutationVFX",
    [BossMastery.MutationId] = "FractureVFX",
}
local u95 = Color3.fromRGB(170, 30, 30)
local u100 = Color3.fromRGB(255, 214, 110)
local u105 = Color3.fromRGB(255, 196, 80)
local u110 = Color3.fromRGB(150, 150, 150)
local u115 = Color3.new(1, 1, 1)
local u120 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local u122 = Log.new()
local u127 = Workspace:FindFirstChild("Transient") or Workspace
local u129 = Random.new()
local u130 = nil
local v1 = {}
if RunService:IsClient() then
    task.spawn(Preload.WarmSounds, 128148316301690, 87821961053710, 92093418106897)
end

local function easeInOutSine(a1) -- Line: 232 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
end

local function getMutationTint(a1) -- Line: 240
    -- upvalues: Mutations (val), BossMastery (val), u95 (val)
    local v1 = Mutations.Get(a1 or BossMastery.MutationId)
    if v1 ~= nil then
        return v1.Tint
    end
    return u95
end

local function getMutationVfxName(a1) -- Line: 245 -- upvalues: BossMastery (val), u85 (val) -- types: a1: string?
    return u85[a1 or BossMastery.MutationId] or u85[BossMastery.MutationId]
end

local function liveModel(a1) -- Line: 251 -- upvalues: Workspace (val) -- types: a1: table
    local v1 = a1.GetModel()
    if v1 ~= nil and v1:IsDescendantOf(Workspace) then
        return v1
    end
    return nil
end

local function syncHighlight(a1) -- Line: 259 -- upvalues: Workspace (val) -- types: a1: table
    local v1 = a1.GetModel()
    local v2 = if v1 == nil then nil else if v1:IsDescendantOf(Workspace) then v1 else nil
    if a1.Highlight.Adornee ~= v2 then
        a1.Highlight.Adornee = v2
    end
end

local function setScreenGlow(a1, a2, a3) -- Line: 266 -- types: a1: table, a2: number, a3: UDim2?
    local v1 = 1 - math.clamp(a2, 0, 1)
    for i, j in a1.ScreenEdges do
        j.BackgroundTransparency = v1
        if a3 ~= nil then
            j.BackgroundColor3 = a3
        end
    end
end

local function fadeOutScreenGlow(a1, a2) -- Line: 276
    -- upvalues: TweenService (val), u120 (val), Debris (val)
    local v1
    local v2 = nil
    for i, j in a2 do
        v1 = TweenService:Create(j, u120, {BackgroundTransparency = 1})
        v1:Play()
        v2 = v1
    end
    if v2 ~= nil then
        v2.Completed:Once(function() -- Line: 286 -- upvalues: a1 (val)
            a1:Destroy()
        end)
    end
    Debris:AddItem(a1, 1.6)
end

local function createScreenEdge(a1, a2, a3, a4, a5, a6) -- Line: 293
    -- upvalues: 
    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = a3
    Frame.BackgroundColor3 = a2
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.Position = a4
    Frame.Size = a5
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = a6
    UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), (NumberSequenceKeypoint.new(1, 1))})
    UIGradient.Parent = Frame
    Frame.Parent = a1
    return Frame
end

local function createScreenGlow(a1) -- Line: 321 -- upvalues: Players (val), createScreenEdge (val) -- types: a1: UDim2
    local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    assert(PlayerGui ~= nil, "Local player is missing PlayerGui")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MutationConsumableGlow"
    ScreenGui.DisplayOrder = 5
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui
    return ScreenGui, {
        createScreenEdge(ScreenGui, a1, Vector2.new(0.5, 0), UDim2.fromScale(0.5, 0), UDim2.fromScale(1, 0.22), 90),
        createScreenEdge(ScreenGui, a1, Vector2.new(0.5, 1), UDim2.fromScale(0.5, 1), UDim2.fromScale(1, 0.22), 270),
        createScreenEdge(ScreenGui, a1, Vector2.new(0, 0.5), UDim2.fromScale(0, 0.5), UDim2.fromScale(0.22, 1), 0),
        (createScreenEdge(ScreenGui, a1, Vector2.new(1, 0.5), UDim2.fromScale(1, 0.5), UDim2.fromScale(0.22, 1), 180)),
    }
end

local function offsetModel(a1, a2) -- Line: 371
    -- upvalues: Workspace (val), EggActionMovement (val)
    if not a1.Motion then
        return
    end
    local v1 = a1.GetModel()
    local v2 = if v1 == nil then nil else if v1:IsDescendantOf(Workspace) then v1 else nil
    if v2 ~= nil and v2.PrimaryPart ~= nil then
        a1.Moved = true
        EggActionMovement.SetPivot(v2, a1.Pivot * a2)
        return
    end
end

local function restoreModel(a1) -- Line: 383 -- upvalues: Workspace (val), EggActionMovement (val) -- types: a1: table
    if not a1.Moved then
        return
    end
    a1.Moved = false
    local v1 = a1.GetModel()
    local v2 = if v1 == nil then nil else if v1:IsDescendantOf(Workspace) then v1 else nil
    if v2 ~= nil and v2.PrimaryPart ~= nil then
        EggActionMovement.SetPivot(v2, a1.Pivot)
        return
    end
end

local function moveHost(a1, a2) -- Line: 395 -- types: a1: table, a2: number
    local v1 = if not a1.Motion then 0 else a2
    a1.Host.CFrame = CFrame.new(a1.Pivot.Position + a1.CenterOffset + Vector3.new(0, 1, 0) * v1)
end

local function groundCFrame(a1) -- Line: 402 -- types: a1: table
    local v1 = a1.Pivot.Position + a1.CenterOffset
    return CFrame.new((Vector3.new(v1.X, a1.Pivot.Position.Y, v1.Z)))
end

local function measureModel(a1, a2) -- Line: 407 -- upvalues: VisibleBounds (val) -- types: a1: Vector2, a2: userdata?
    local Position = a1.Position + Vector3.new(0, 1, 0)
    local v1 = Vector3.new(2, 2, 2)
    if a2 ~= nil then
        local v2, v3 = VisibleBounds(a2)
        if 0 < v3.Magnitude then
            Position = v2.Position
            v1 = v3
        end
    end
    return Position - a1.Position, v1
end

local function createHost(a1, a2) -- Line: 420 -- upvalues: u127 (val) -- types: a1: Vector2, a2: vector
    local Part = Instance.new("Part")
    Part.Name = "MutationConsumableFeedback"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = a2 * 0.8
    Part.CFrame = a1
    Part.Parent = u127
    return Part
end

local function createEmitter(a1, a2) -- Line: 435 -- types: a1: userdata, a2: table
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = a2.Name
    ParticleEmitter.Texture = a2.Texture
    ParticleEmitter.Color = a2.Color
    ParticleEmitter.Size = a2.Size
    ParticleEmitter.Transparency = a2.Transparency
    ParticleEmitter.Lifetime = a2.Lifetime
    ParticleEmitter.Speed = a2.Speed
    ParticleEmitter.Acceleration = a2.Acceleration or Vector3.new(0, 0, 0)
    ParticleEmitter.Drag = a2.Drag or 0
    ParticleEmitter.LightEmission = a2.LightEmission or 0
    ParticleEmitter.LightInfluence = a2.LightInfluence or 0
    local RotSpeed = a2.RotSpeed or NumberRange.new(0)
    ParticleEmitter.RotSpeed = RotSpeed
    local Rotation = a2.Rotation or NumberRange.new(0)
    ParticleEmitter.Rotation = Rotation
    ParticleEmitter.Rate = a2.Rate or 0
    local SpreadAngle = a2.SpreadAngle or Vector2.new(180, 180)
    ParticleEmitter.SpreadAngle = SpreadAngle
    local Orientation = a2.Orientation or Enum.ParticleOrientation.FacingCamera
    ParticleEmitter.Orientation = Orientation
    local Squash = a2.Squash or NumberSequence.new(0)
    ParticleEmitter.Squash = Squash
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Sphere
    ParticleEmitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    ParticleEmitter.Enabled = false
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

local function openScene(a1, a2, a3, a4) -- Line: 466
    -- upvalues: u130 (ref), VisibleBounds (val), u127 (val), createScreenGlow (val), Trove (val), GuiService (val)
    -- upvalues: Debris (val), fadeOutScreenGlow (val), Workspace (val), EggActionMovement (val)
    local v1 = u130
    if v1 ~= nil then
        u130 = nil
        v1.Trove:Destroy()
    end
    v1 = a2()
    local Position = a1.Position + Vector3.new(0, 1, 0)
    local v2 = Vector3.new(2, 2, 2)
    if v1 ~= nil then
        local v3, v4 = VisibleBounds(v1)
        if 0 < v4.Magnitude then
            Position = v3.Position
            v2 = v4
        end
    end
    local v5 = Position - a1.Position
    local v6 = v2
    v2 = CFrame.new(a1.Position + v5)
    local u39 = Instance.new("Part")
    u39.Name = "MutationConsumableFeedback"
    u39.Anchored = true
    u39.CanCollide = false
    u39.CanQuery = false
    u39.CanTouch = false
    u39.CastShadow = false
    u39.Transparency = 1
    u39.Size = v6 * 0.8
    u39.CFrame = v2
    u39.Parent = u127
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "Center"
    Attachment.Parent = u39
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Name = "Base"
    Attachment_2.Position = Vector3.new(0, -u39.Size.Y * 0.5 / 0.8, 0)
    Attachment_2.Parent = u39
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "Glow"
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.FillColor = a3
    Highlight.OutlineColor = a4
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.Adornee = v1
    Highlight.Parent = u39
    local u80, u81 = createScreenGlow(a3)
    v1 = Trove.new()
    local u86 = {Moved = false, GetModel = a2, Pivot = a1}
    u86.Radius = math.max(v6.X, v6.Y, v6.Z) * 0.5
    u86.CenterOffset = v5
    u86.Host = u39
    u86.Center = Attachment
    u86.Base = Attachment_2
    u86.Highlight = Highlight
    u86.ScreenEdges = u81
    u86.Trove = v1
    u86.Motion = not GuiService.ReducedMotionEnabled
    v1:Add(Highlight)
    v1:Add(function() -- Line: 519
        -- upvalues: u39 (val), Debris (upval), fadeOutScreenGlow (upval), u80 (val), u81 (val), u86 (val)
        -- upvalues: Workspace (upval), EggActionMovement (upval)
        for i, j in u39:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                j.Enabled = false
            end
        end
        Debris:AddItem(u39, 3)
        fadeOutScreenGlow(u80, u81)
        local v1 = u86
        if not v1.Moved then
            return
        end
        v1.Moved = false
        local v2 = v1.GetModel()
        local v3 = if v2 == nil then nil else if v2:IsDescendantOf(Workspace) then v2 else nil
        if v3 ~= nil then
            if v3.PrimaryPart == nil then
                return
            end
            EggActionMovement.SetPivot(v3, v1.Pivot)
        end
    end)
    u130 = u86
    return u86
end

local function runScene(a1, a2, a3) -- Line: 534
    -- upvalues: RunService (val), Workspace (val), u130 (ref)
    local u3 = 0
    local u4 = nil
    u4 = RunService.PreRender:Connect(function(a1_2) -- Line: 541
        -- upvalues: u3 (ref), a2 (val), a1 (val), Workspace (upval), a3 (val), u4 (ref), u130 (upval)
        u3 = math.min(u3 + a1_2, a2)
        local v1 = a1
        local v2 = v1.GetModel()
        local v3 = if v2 == nil then nil else if v2:IsDescendantOf(Workspace) then v2 else nil
        if v1.Highlight.Adornee ~= v3 then
            v1.Highlight.Adornee = v3
        end
        a3(u3)
        if u3 < a2 then
            return
        end
        u4:Disconnect()
        if u130 ~= a1 then
            return
        end
        u130 = nil
        a1.Trove:Destroy()
    end)
    a1.Trove:Add(u4)
end

local function playSound(a1, a2, a3) -- Line: 559 -- upvalues: Audio (val) -- types: a1: table
    local v1 = a3 or {}
    v1.MaxDistance = v1.MaxDistance or 70
    Audio.Play(a2, a1.Host.CFrame, v1)
end

local function findNamedSound(a1) -- Line: 569 -- upvalues: ReplicatedStorage (val), u122 (val) -- types: a1: string
    local Sounds = ReplicatedStorage.Assets:FindFirstChild("Sounds")
    local v1 = if not Sounds then nil else Sounds:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Sound") then
        return v1
    end
    ;(u122:AtWarning()):Log((("Missing ReplicatedStorage.Assets.Sounds.%*; sound skipped"):format(a1)))
    return nil
end

local function findParticles(a1) -- Line: 582 -- upvalues: ReplicatedStorage (val), u122 (val) -- types: a1: string
    local v1
    local Particles = ReplicatedStorage.Assets:FindFirstChild("Particles")
    if (if not Particles then nil else Particles:FindFirstChild(a1)) == nil then
        (u122:AtWarning()):Log((("Missing ReplicatedStorage.Assets.Particles.%*; VFX skipped"):format(a1)))
    end
    return v1
end

local function emitImpactVfx(a1) -- Line: 594
    -- upvalues: ReplicatedStorage (val), u122 (val), u127 (val), Debris (val), TryCall (val), PlayVFX (val)
    local v1
    local Particles = ReplicatedStorage.Assets:FindFirstChild("Particles")
    if (if not Particles then nil else Particles:FindFirstChild("BigHitGroundAttach")) == nil then
        u122:AtWarning():Log("Missing ReplicatedStorage.Assets.Particles.BigHitGroundAttach; VFX skipped")
    end
    if v1 == nil then
        return
    end
    local v2 = a1.Pivot.Position + a1.CenterOffset
    local v3 = CFrame.new((Vector3.new(v2.X, a1.Pivot.Position.Y, v2.Z)))
    local Part = Instance.new("Part")
    Part.Name = "MutationConsumableFeedback"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.08000000566244125, 0.08000000566244125, 0.08000000566244125)
    Part.CFrame = v3
    Part.Parent = u127
    Debris:AddItem(Part, 10)
    local v4 = v1:Clone()
    if not TryCall(PlayVFX, Part, v3, v4) then
        v4:Destroy()
    end
end

local function scaleSequence(a1, a2) -- Line: 609 -- types: a1: userdata, a2: number
    local Time, new, v1
    local v2 = table.create(#a1.Keypoints)
    for i, j in a1.Keypoints do
        new = NumberSequenceKeypoint.new
        Time = j.Time
        v1 = j.Value * a2
        v2[i] = (new(Time, v1, j.Envelope * a2))
    end
    return NumberSequence.new(v2)
end

local function mutationVfxScale(a1, a2) -- Line: 624 -- types: a1: number, a2: userdata
    local Attribute = a2:GetAttribute("SourceRadius")
    return (math.clamp(a1 / (if type(Attribute) ~= "number" then 10.7 else if not (Attribute > 0) then 10.7 else Attribute), 0.12, 1))
end

local function cloneScaledEmitter(a1, a2) -- Line: 638
    -- upvalues: scaleSequence (val)
    local v1 = a1:Clone()
    v1.Enabled = false
    v1.Size = scaleSequence(a1.Size, a2)
    v1.Speed = NumberRange.new(a1.Speed.Min * a2, a1.Speed.Max * a2)
    return v1
end

local function emitMutationVfx(a1, a2) -- Line: 650
    -- upvalues: ReplicatedStorage (val), u122 (val), u127 (val), Debris (val), scaleSequence (val)
    local v1, v2
    local Particles = ReplicatedStorage.Assets:FindFirstChild("Particles")
    if (if not Particles then nil else Particles:FindFirstChild(a2)) == nil then
        (u122:AtWarning()):Log((("Missing ReplicatedStorage.Assets.Particles.%*; VFX skipped"):format(a2)))
    end
    if v2 == nil then
        return
    end
    local CFrame = a1.Host.CFrame
    local v3 = Vector3.new(1, 1, 1) * a1.Radius * 2
    local v4 = Instance.new("Part")
    v4.Name = "MutationConsumableFeedback"
    v4.Anchored = true
    v4.CanCollide = false
    v4.CanQuery = false
    v4.CanTouch = false
    v4.CastShadow = false
    v4.Transparency = 1
    v4.Size = v3 * 0.8
    v4.CFrame = CFrame
    v4.Parent = u127
    Debris:AddItem(v4, 6)
    local Radius = a1.Radius
    local Attribute = v2:GetAttribute("SourceRadius")
    local v5 = math.clamp(Radius / (if type(Attribute) ~= "number" then 10.7 else if not (Attribute > 0) then 10.7 else Attribute), 0.12, 1)
    for i, j in v2:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v1 = j:Clone()
            v1.Enabled = false
            v1.Size = scaleSequence(j.Size, v5)
            v1.Speed = NumberRange.new(j.Speed.Min * v5, j.Speed.Max * v5)
            v1.Parent = v4
            v1:Emit((math.max(1, (math.round(j.Rate * 0.55)))))
        end
    end
end

local function shakeOffset(a1, a2, a3) -- Line: 674 -- upvalues: u129 (val) -- types: a1: table, a2: number, a3: number
    local v1 = math.min(a1.Radius * 0.08, 0.3) * a3
    local v2 = a3 * 0.12217304763960307
    return (CFrame.new(u129:NextNumber(-1, 1) * v1, a2 + u129:NextNumber(-1, 1) * v1, u129:NextNumber(-1, 1) * v1)) * CFrame.Angles(u129:NextNumber(-1, 1) * v2, 0, u129:NextNumber(-1, 1) * v2)
end

local function createSuccessEmitters(a1, a2, a3) -- Line: 695
    -- upvalues: createEmitter (val), u115 (val), u100 (val)
    local Radius = a1.Radius
    return {
        Twinkle = createEmitter(a1.Host, {
            Name = "Twinkle",
            Texture = "rbxassetid://78284231250884",
            LightEmission = 1,
            Rate = 18,
            Color = ColorSequence.new(u115, u100),
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.5, 0.4),
                (NumberSequenceKeypoint.new(1, 0)),
            }),
            Transparency = NumberSequence.new(0),
            Lifetime = NumberRange.new(0.35, 0.6),
            Speed = NumberRange.new(0),
        }),
        Flare = createEmitter(a1.Center, {
            Name = "Flare",
            Texture = "rbxassetid://85665154415342",
            LightEmission = 1,
            Color = ColorSequence.new(u115, u100),
            Size = NumberSequence.new(math.min(Radius * 3, 10), (math.min(Radius * 5, 10))),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.2),
                NumberSequenceKeypoint.new(0.4, 0.45),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Lifetime = NumberRange.new(0.6),
            Speed = NumberRange.new(0),
            RotSpeed = NumberRange.new(40),
            Rotation = NumberRange.new(-180, 180),
        }),
        Ring = createEmitter(a1.Base, {
            Name = "Ring",
            Texture = "rbxassetid://109600784699514",
            LightEmission = 1,
            Color = ColorSequence.new(u100, a3),
            Size = NumberSequence.new(0, (math.min(Radius * 6, 10))),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))}),
            Lifetime = NumberRange.new(0.6),
            Speed = NumberRange.new(0.5),
            SpreadAngle = Vector2.zero,
            Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        }),
        Sparks = createEmitter(a1.Host, {
            Name = "Sparks",
            Texture = "rbxassetid://78284231250884",
            Drag = 5,
            LightEmission = 1,
            Color = ColorSequence.new(u100, a2),
            Size = NumberSequence.new(0.5, 0),
            Transparency = NumberSequence.new(0, 1),
            Lifetime = NumberRange.new(0.7, 1.2),
            Speed = NumberRange.new(Radius * 8, Radius * 14),
            SpreadAngle = Vector2.new(25, 25),
        }),
        Streaks = createEmitter(a1.Host, {
            Name = "Streaks",
            Texture = "rbxassetid://78284231250884",
            Drag = 8,
            LightEmission = 1,
            Color = ColorSequence.new(u115, u100),
            Size = NumberSequence.new(0.35, 0),
            Transparency = NumberSequence.new(0, 1),
            Lifetime = NumberRange.new(0.35, 0.5),
            Speed = NumberRange.new(Radius * 18, Radius * 26),
            SpreadAngle = Vector2.new(10, 10),
            Orientation = Enum.ParticleOrientation.VelocityParallel,
            Squash = NumberSequence.new(-1.5),
        }),
        Embers = createEmitter(a1.Host, {
            Name = "Embers",
            Texture = "rbxassetid://128641440631741",
            Acceleration = Vector3.new(0, 3.5, 0),
            Drag = 1.5,
            LightEmission = 1,
            Rate = 20,
            Color = ColorSequence.new(u100, a2),
            Size = NumberSequence.new(0.25, 0),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.1, 0),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Lifetime = NumberRange.new(1.8, 2.6),
            Speed = NumberRange.new(1, 2.5),
        }),
    }
end

local function afterglowHost(a1) -- Line: 800 -- types: a1: userdata
    local Hitbox = a1:FindFirstChild("Hitbox")
    if Hitbox ~= nil and Hitbox:IsA("BasePart") then
        return Hitbox
    end
    return nil
end

local function removeAfterglow(a1) -- Line: 805 -- types: a1: userdata
    for i, j in a1:GetChildren() do
        if j:IsA("ParticleEmitter") and string.find(j.Name, "Afterglow_", 1, true) == 1 then
            j:Destroy()
        end
    end
    a1:SetAttribute("AfterglowMutationId", nil)
end

local function holdAfterglowLift(a1, a2) -- Line: 821 -- types: a1: userdata, a2: table
    local v1, v2
    local u69 = {}
    local v3 = nil
    local v4 = nil
    for i, j in a2, v3, v4 do
        v2 = j.ZOffset < 0
        u69[j] = v2
    end

    local function lift() -- Line: 829 -- upvalues: a1 (val), a2 (val), u69 (val)
        local v1
        local v2 = math.min(a1.Size.Y * 0.2, 2)
        local v3 = nil
        local v4 = nil
        for i, j in a2, v3, v4 do
            v1 = if not u69[j] then v2 else -v2
            j.ZOffset = v1
        end
    end

    v3 = math.min(a1.Size.Y * 0.2, 2)
    local v5 = nil
    local v6 = nil
    for k, n in a2, v5, v6 do
        v1 = if not u69[n] then v3 else -v3
        n.ZOffset = v1
    end
    local u42 = (a1:GetPropertyChangedSignal("Size")):Connect(lift)
    for m, i5 in a2 do
        i5.Destroying:Once(function() -- Line: 841 -- upvalues: u42 (val)
            u42:Disconnect()
        end)
    end
end

function v1.AttachAfterglow(a1, a2, a3) -- Line: 849
    -- upvalues: Mutations (val), u85 (val), removeAfterglow (val), ReplicatedStorage (val), u122 (val)
    -- upvalues: scaleSequence (val), holdAfterglowLift (val)
    local v1, v2, v3
    local Hitbox = a1:FindFirstChild("Hitbox")
    if (if Hitbox == nil then nil else if not Hitbox:IsA("BasePart") then nil else Hitbox) == nil then
        return
    end
    local v4 = nil
    for i, j in Mutations.Sanitize(a2, a3) do
        if u85[j] ~= nil then
            v4 = j
            break
        end
    end
    if v2:GetAttribute("AfterglowMutationId") == v4 then
        return
    end
    removeAfterglow(v2)
    if v4 == nil then
        return
    end
    v2:SetAttribute("AfterglowMutationId", v4)
    local v5 = u85[v4]
    local Particles = ReplicatedStorage.Assets:FindFirstChild("Particles")
    if (if not Particles then nil else Particles:FindFirstChild(v5)) == nil then
        (u122:AtWarning()):Log((("Missing ReplicatedStorage.Assets.Particles.%*; VFX skipped"):format(v5)))
    end
    if v3 == nil then
        return
    end
    v4 = {}
    v5 = 0
    for k, n in v3:GetDescendants() do
        if n:IsA("ParticleEmitter") then
            table.insert(v4, n)
            v5 = v5 + n.Rate
        end
    end
    if v5 <= 0 then
        return
    end
    local Attribute = v3:GetAttribute("SourceRadius")
    local v6 = math.clamp(
        math.max(v2.Size.X, v2.Size.Y, v2.Size.Z) * 0.5 / (if type(Attribute) ~= "number" then 10.7 else if not (Attribute > 0) then 10.7 else Attribute),
        0.12,
        1
    )
    v3 = 40 / v5
    v5 = {}
    for m, i5 in v4 do
        v1 = i5:Clone()
        v1.Enabled = false
        v1.Size = scaleSequence(i5.Size, v6)
        v1.Speed = NumberRange.new(i5.Speed.Min * v6, i5.Speed.Max * v6)
        v1.Name = "Afterglow_" .. i5.Name
        v1.Acceleration = i5.Acceleration * v6
        v1.Rate = i5.Rate * v3
        v1.Shape = Enum.ParticleEmitterShape.Sphere
        v1.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
        v1.LockedToPart = true
        v1.Parent = v2
        table.insert(v5, v1)
    end
    holdAfterglowLift(v2, v5)
    for i6, i7 in v5 do
        i7.Enabled = true
    end
end

function v1.ClearAfterglow(a1) -- Line: 917 -- upvalues: removeAfterglow (val) -- types: a1: userdata
    local Hitbox = a1:FindFirstChild("Hitbox")
    local v1 = if Hitbox == nil then nil else if not Hitbox:IsA("BasePart") then nil else Hitbox
    if v1 ~= nil then
        removeAfterglow(v1)
    end
end

function v1.PlaySuccess(a1) -- Line: 924
    -- upvalues: Mutations (val), BossMastery (val), u95 (val), u115 (val), openScene (val), u100 (val)
    -- upvalues: createSuccessEmitters (val), emitMutationVfx (val), u85 (val), Audio (val), TweenService (val)
    -- upvalues: Workspace (val), EggActionMovement (val), shakeOffset (val), findNamedSound (val), u130 (ref)
    -- upvalues: emitImpactVfx (val), Shake (val), easeInOutSine (val), RunService (val)
    local Tint
    assert(type(a1) == "table", "PlaySuccess expects a params table")
    assert(typeof(a1.Pivot) == "CFrame", "PlaySuccess expects the egg's base pivot")
    assert(type(a1.GetModel) == "function", "PlaySuccess expects a model getter")
    local v1 = true
    if a1.OnReveal ~= nil then
        v1 = type(a1.OnReveal) == "function"
    end
    assert(v1, "PlaySuccess reveal callback must be a function")
    v1 = true
    if a1.OnFinished ~= nil then
        v1 = type(a1.OnFinished) == "function"
    end
    assert(v1, "PlaySuccess finished callback must be a function")
    local Pivot_2 = a1.Pivot
    local OnReveal = a1.OnReveal
    local OnFinished = a1.OnFinished
    local v2 = Mutations.Get(a1.MutationId or BossMastery.MutationId)
    local u74 = (if v2 == nil then u95 else v2.Tint):Lerp(u115, 0.35)
    local u84 = openScene(Pivot_2, a1.GetModel, u74, u100)
    if OnFinished ~= nil then
        u84.Trove:Add(function() -- Line: 950 -- upvalues: OnFinished (val)
            task.spawn(OnFinished)
        end)
    end
    local u100_2 = createSuccessEmitters(u84, Tint, u74)
    local u106 = math.min(u84.Radius * 0.25, 0.8)

    local function spinOffset(a1) -- Line: 974 -- upvalues: u84 (val) -- types: a1: number
        local v1
        if not u84.Motion then
            return CFrame.identity
        end
        if a1 <= 0 then
            v1 = 0
        elseif a1 < 5.25 then
            v1 = 49.480084294039244 * (a1 / 5.25) ^ 4
        elseif not (a1 >= 5.95) then
            local v2 = (a1 - 5.25) / 0.7
            v1 = 49.480084294039244 + 13.351768777756618 * v2 * (2 - v2)
        else
            v1 = 62.83185307179586
        end
        return CFrame.Angles(0, v1, 0)
    end

    local u108 = false

    local function performFracture() -- Line: 995
        -- upvalues: u108 (ref), emitMutationVfx (upval), u84 (val), a1 (val), BossMastery (upval), u85 (upval)
        if u108 then
            return
        end
        u108 = true
        local v1 = emitMutationVfx
        local MutationId = a1.MutationId or BossMastery.MutationId
        v1(u84, u85[MutationId] or u85[BossMastery.MutationId])
    end

    local v3 = {TimePosition = 0.1200000000000001} or {}
    v3.MaxDistance = v3.MaxDistance or 70
    Audio.Play(128148316301690, u84.Host.CFrame, v3)
    u100_2.Twinkle.Enabled = true
    local u128 = false
    local u129 = false
    local u130_2 = false

    local function u131(a1_2) -- Line: 1011
        -- upvalues: u84 (val), u74 (val), u100 (upval), TweenService (upval), spinOffset (val), Workspace (upval)
        -- upvalues: EggActionMovement (upval), u130_2 (ref), u100_2 (val), shakeOffset (upval), u129 (ref), u108 (ref)
        -- upvalues: emitMutationVfx (upval), a1 (val), BossMastery (upval), u85 (upval), u128 (ref)
        -- upvalues: findNamedSound (upval), Audio (upval), u130 (upval), emitImpactVfx (upval), Shake (upval)
        -- upvalues: OnReveal (val), easeInOutSine (upval), u106 (val)
        local v1, v2, v3, v4, v5, v6, v7, v8
        local Highlight = u84.Highlight
        if not (a1_2 < 6.11) then
            if not u128 then
                u128 = true
                if not u108 then
                    u108 = true
                    v1 = emitMutationVfx
                    local MutationId_3 = a1.MutationId or BossMastery.MutationId
                    v3 = u85[MutationId_3] or u85[BossMastery.MutationId]
                    v1(u84, v3)
                end
                v1 = u84
                v2 = if not v1.Motion then 0 else 0
                v1.Host.CFrame = CFrame.new(v1.Pivot.Position + v1.CenterOffset + Vector3.new(0, 1, 0) * v2)
                local MechaHatch = findNamedSound("MechaHatch")
                if MechaHatch ~= nil then
                    v2 = u84
                    v3 = {}
                    v3.MaxDistance = v3.MaxDistance or 70
                    Audio.Play(MechaHatch, v2.Host.CFrame, v3)
                end
                task.delay(0.18, function() -- Line: 1100 -- upvalues: u130 (upval), u84 (upval), Audio (upval)
                    if u130 == u84 then
                        local v1 = u84
                        local v2 = {}
                        v2.MaxDistance = v2.MaxDistance or 70
                        Audio.Play(87821961053710, v1.Host.CFrame, v2)
                    end
                end)
                emitImpactVfx(u84)
                if u84.Motion then
                    Shake.Play({Seconds = 0.45, Magnitude = 1})
                end
                u100_2.Twinkle.Rate = 8
                u100_2.Flare:Emit(1)
                u100_2.Ring:Emit(1)
                u100_2.Sparks:Emit(36)
                u100_2.Streaks:Emit(16)
                u100_2.Embers.Rate = 22
                u100_2.Embers:Emit(18)
                u100_2.Embers.Enabled = true
                if OnReveal ~= nil then
                    task.spawn(OnReveal)
                end
            end
            v1 = a1_2 - 6.11
            v2 = math.clamp(v1 / 1.2, 0, 1)
            Highlight.FillTransparency = math.lerp(0.1, 1, (TweenService:GetValue(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
            v2 = math.clamp(v1 / 1.6, 0, 1)
            Highlight.OutlineTransparency = math.lerp(0.05, 1, (easeInOutSine(v2)))
            local Value_4 = TweenService:GetValue(math.clamp(v1 / 0.12, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v9 = math.clamp(v1 / 3, 0, 1)
            v3 = 1 - TweenService:GetValue(v9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v4 = u84
            v5 = math.lerp(0.4, 1, Value_4) * v3
            v6 = u100:Lerp(u74, v9)
            v7 = 1 - math.clamp(v5, 0, 1)
            for i, j in v4.ScreenEdges do
                j.BackgroundTransparency = v7
                if v6 ~= nil then
                    j.BackgroundColor3 = v6
                end
            end
            if v1 >= 1.2 then
                u100_2.Embers.Enabled = false
            end
            if v1 >= 1.6 then
                u100_2.Twinkle.Enabled = false
            end
            if v1 < 0.36 then
                v3 = v1 / 0.36
                v2 = (1 - v3) * (1 - v3)
                v4 = u84
                v5 = CFrame.new(0, u106 * math.abs((math.sin(6.283185307179586 * v3))) * v2, 0)
                if not v4.Motion then
                    return
                end
                v2 = v4.GetModel()
                v3 = if v2 == nil then nil else if v2:IsDescendantOf(Workspace) then v2 else nil
                if v3 == nil or v3.PrimaryPart == nil then
                    return
                end
                v4.Moved = true
                EggActionMovement.SetPivot(v3, v4.Pivot * v5)
                return
            end
            v4 = u84
            if not v4.Moved then
                return
            end
            v4.Moved = false
            v6 = v4.GetModel()
            v5 = if v6 == nil then nil else if v6:IsDescendantOf(Workspace) then v6 else nil
            if v5 ~= nil then
                if v5.PrimaryPart == nil then
                    return
                end
                EggActionMovement.SetPivot(v5, v4.Pivot)
            end
            return
        end
        v1 = math.min(a1_2 / 5.95, 1)
        v2 = v1 * v1
        v4 = math.sin(a1_2 * (v1 * 46 + 14)) * 0.2 + 0.8
        Highlight.FillTransparency = 1 - v2 * 0.55 * v4
        Highlight.OutlineTransparency = 1 - v2 * v4
        v5 = u84
        v6 = v2 * 0.4 * v4
        v7 = u74:Lerp(u100, v1)
        v3 = 1 - math.clamp(v6, 0, 1)
        local v10 = nil
        local v11 = nil
        for k, n in v5.ScreenEdges, v10, v11 do
            n.BackgroundTransparency = v3
            if v7 ~= nil then
                n.BackgroundColor3 = v7
            end
        end
        if a1_2 < 0.9 then
            v6 = a1_2 / 0.9
            v4 = TweenService:GetValue(v6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) * 3
            v5 = u84
            v2 = if not v5.Motion then 0 else v4
            v5.Host.CFrame = CFrame.new(v5.Pivot.Position + v5.CenterOffset + Vector3.new(0, 1, 0) * v2)
            v5 = u84
            v6 = (CFrame.new(0, v4, 0)) * spinOffset(a1_2)
            if not v5.Motion then
                return
            end
            v7 = v5.GetModel()
            v1 = if v7 == nil then nil else if v7:IsDescendantOf(Workspace) then v7 else nil
            if v1 == nil or v1.PrimaryPart == nil then
                return
            end
            v5.Moved = true
            EggActionMovement.SetPivot(v1, v5.Pivot * v6)
            return
        end
        if a1_2 < 5.25 then
            v5 = (a1_2 - 0.9) / 4.35
            if not u130_2 and v5 >= 0.45 then
                u130_2 = true
                u100_2.Embers.Rate = 10
                u100_2.Embers.Enabled = true
            end
            local Value = TweenService:GetValue(math.min(v5 / 1, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            v7 = u84
            v5 = if not v7.Motion then 0 else 3
            v7.Host.CFrame = CFrame.new(v7.Pivot.Position + v7.CenterOffset + Vector3.new(0, 1, 0) * v5)
            v7 = u84
            v8 = (shakeOffset(u84, 3, Value)) * spinOffset(a1_2)
            if not v7.Motion then
                return
            end
            v11 = v7.GetModel()
            v10 = if v11 == nil then nil else if v11:IsDescendantOf(Workspace) then v11 else nil
            if v10 == nil or v10.PrimaryPart == nil then
                return
            end
            v7.Moved = true
            EggActionMovement.SetPivot(v10, v7.Pivot * v8)
            return
        end
        if not (a1_2 < 5.95) then
            if not u108 then
                u108 = true
                v5 = emitMutationVfx
                local MutationId_2 = a1.MutationId or BossMastery.MutationId
                v7 = u85[MutationId_2] or u85[BossMastery.MutationId]
                v5(u84, v7)
            end
            v6 = math.lerp(4.25, 0, (TweenService:GetValue((a1_2 - 5.95) / 0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.In)))
            v7 = u84
            v5 = if not v7.Motion then 0 else v6
            v7.Host.CFrame = CFrame.new(v7.Pivot.Position + v7.CenterOffset + Vector3.new(0, 1, 0) * v5)
            v7 = u84
            v8 = (CFrame.new(0, v6, 0)) * spinOffset(a1_2)
            if not v7.Motion then
                return
            end
            v11 = v7.GetModel()
            v10 = if v11 == nil then nil else if v11:IsDescendantOf(Workspace) then v11 else nil
            if v10 ~= nil then
                if v10.PrimaryPart == nil then
                    return
                end
                v7.Moved = true
                EggActionMovement.SetPivot(v10, v7.Pivot * v8)
            end
            return
        end
        if not u129 then
            u129 = true
            if not u108 then
                u108 = true
                v5 = emitMutationVfx
                local MutationId = a1.MutationId or BossMastery.MutationId
                v7 = u85[MutationId] or u85[BossMastery.MutationId]
                v5(u84, v7)
            end
            u100_2.Twinkle.Rate = 40
            u100_2.Embers.Enabled = false
            u100_2.Flare:Emit(1)
            u100_2.Sparks:Emit(18)
        end
        v5 = (a1_2 - 5.25) / 0.7
        v6 = 3 + 1.25 * TweenService:GetValue(v5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        v7 = (1 - v5) * 0.35
        v8 = u84
        v5 = if not v8.Motion then 0 else v6
        v8.Host.CFrame = CFrame.new(v8.Pivot.Position + v8.CenterOffset + Vector3.new(0, 1, 0) * v5)
        v8 = u84
        v10 = (shakeOffset(u84, v6, v7)) * spinOffset(a1_2)
        if not v8.Motion then
            return
        end
        local v12 = v8.GetModel()
        v11 = if v12 == nil then nil else if v12:IsDescendantOf(Workspace) then v12 else nil
        if v11 == nil or v11.PrimaryPart == nil then
            return
        end
        v8.Moved = true
        EggActionMovement.SetPivot(v11, v8.Pivot * v10)
    end

    local u141 = 0
    local u142 = nil
    local PreRender = RunService.PreRender
    local u145 = 7.91
    u142 = PreRender:Connect(function(a1) -- Line: 541
        -- upvalues: u141 (ref), u145 (val), u84 (val), Workspace (upval), u131 (val), u142 (ref), u130 (upval)
        u141 = math.min(u141 + a1, u145)
        local v1 = u84
        local v2 = v1.GetModel()
        local v3 = if v2 == nil then nil else if v2:IsDescendantOf(Workspace) then v2 else nil
        if v1.Highlight.Adornee ~= v3 then
            v1.Highlight.Adornee = v3
        end
        u131(u141)
        if u141 < u145 then
            return
        end
        u142:Disconnect()
        if u130 ~= u84 then
            return
        end
        u130 = nil
        u84.Trove:Destroy()
    end)
    u84.Trove:Add(u142)
end

function v1.PlayFailure(a1) -- Line: 1182
    -- upvalues: Mutations (val), BossMastery (val), u95 (val), u115 (val), openScene (val), u100 (val)
    -- upvalues: createSuccessEmitters (val), createEmitter (val), u105 (val), u110 (val), Audio (val)
    -- upvalues: TweenService (val), Workspace (val), EggActionMovement (val), shakeOffset (val), findNamedSound (val)
    -- upvalues: Shake (val), RunService (val), u130 (ref)
    local Tint
    assert(type(a1) == "table", "PlayFailure expects a params table")
    assert(typeof(a1.Pivot) == "CFrame", "PlayFailure expects the egg's base pivot")
    assert(type(a1.GetModel) == "function", "PlayFailure expects a model getter")
    local v1 = true
    if a1.OnVerdict ~= nil then
        v1 = type(a1.OnVerdict) == "function"
    end
    assert(v1, "PlayFailure verdict callback must be a function")
    v1 = true
    if a1.OnFinished ~= nil then
        v1 = type(a1.OnFinished) == "function"
    end
    assert(v1, "PlayFailure finished callback must be a function")
    local OnVerdict = a1.OnVerdict
    local OnFinished = a1.OnFinished
    local v2 = Mutations.Get(a1.MutationId or BossMastery.MutationId)
    local u73 = (if v2 == nil then u95 else v2.Tint):Lerp(u115, 0.35)
    local u81 = openScene(a1.Pivot, a1.GetModel, u73, u100)
    local Radius = u81.Radius
    if OnFinished ~= nil then
        u81.Trove:Add(function() -- Line: 1208 -- upvalues: OnFinished (val)
            task.spawn(OnFinished)
        end)
    end
    local u97 = createSuccessEmitters(u81, Tint, u73)
    local u127 = createEmitter(u81.Host, {
        Name = "FailSparks",
        Texture = "rbxassetid://78284231250884",
        Acceleration = Vector3.new(0, -25, 0),
        Drag = 2,
        LightEmission = 1,
        Color = ColorSequence.new(u105, u110),
        Size = NumberSequence.new(0.3, 0),
        Transparency = NumberSequence.new(0, 1),
        Lifetime = NumberRange.new(0.4, 0.8),
        Speed = NumberRange.new(Radius * 3, Radius * 5),
        SpreadAngle = Vector2.new(40, 40),
    })
    local u179 = createEmitter(u81.Host, {
        Name = "Smoke",
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        Acceleration = Vector3.new(0, 1.2000000476837158, 0),
        Drag = 1,
        LightInfluence = 1,
        Rate = 10,
        Color = ColorSequence.new(u110, u110:Lerp(Color3.new(0, 0, 0), 0.3)),
        Size = NumberSequence.new(Radius * 0.5, Radius * 1.1),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.15, 0.55),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
        Lifetime = NumberRange.new(1.4, 2.2),
        Speed = NumberRange.new(1, 2),
        RotSpeed = NumberRange.new(-20, 20),
        Rotation = NumberRange.new(-180, 180),
    })
    local u212 = createEmitter(u81.Base, {
        Name = "Dust",
        Texture = "rbxassetid://109600784699514",
        LightInfluence = 1,
        Color = ColorSequence.new(u110),
        Size = NumberSequence.new(0, (math.min(Radius * 5, 10))),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), (NumberSequenceKeypoint.new(1, 1))}),
        Lifetime = NumberRange.new(0.55),
        Speed = NumberRange.new(0.4),
        SpreadAngle = Vector2.zero,
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
    })
    local u216 = math.min(Radius * 0.12, 0.45)
    local u224 = Audio.Play(128148316301690, u81.Host.CFrame, {MaxDistance = 70, TimePosition = 0.1200000000000001})
    u97.Twinkle.Enabled = true
    local u227 = 0
    local u228 = 0
    local u229 = 0
    local u230 = false
    local u231 = false
    local u232 = false
    local u233 = 0
    local u234 = 0

    local function u235(a1) -- Line: 1299
        -- upvalues: u227 (ref), u81 (val), u73 (val), u100 (upval), u229 (ref), u228 (ref), TweenService (upval)
        -- upvalues: Workspace (upval), EggActionMovement (upval), u230 (ref), u97 (val), shakeOffset (upval)
        -- upvalues: u231 (ref), u224 (val), Audio (upval), u127 (val), u179 (val), OnVerdict (val), u110 (upval)
        -- upvalues: u232 (ref), u233 (ref), u234 (ref), findNamedSound (upval), Shake (upval), u212 (val), u216 (val)
        local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
        local v14 = a1 - u227
        u227 = a1
        local Highlight = u81.Highlight
        if a1 < 3.45 then
            v7 = math.clamp((a1 - 2.9) / 0.55, 0, 1)
            v8 = v7 * (math.sin(a1 * 53) * 0.5 + 0.5)
            v9 = math.min(a1 / 5.95, 1)
            v10 = v9 * v9
            v12 = (math.sin(a1 * (v9 * 46 + 14)) * 0.2 + 0.8) * (1 - v8 * 0.65)
            Highlight.FillTransparency = 1 - v10 * 0.55 * v12
            Highlight.OutlineTransparency = 1 - v10 * v12
            v13 = u81
            v1 = v10 * 0.4 * v12
            v2 = u73:Lerp(u100, v9)
            v11 = 1 - math.clamp(v1, 0, 1)
            for m, i5 in v13.ScreenEdges do
                i5.BackgroundTransparency = v11
                if v2 ~= nil then
                    i5.BackgroundColor3 = v2
                end
            end
            u229 = 37.69911184307752 * (a1 / 5.25) ^ 3
            if not (a1 < 2.9) then
                u229 = u229 * (1 - v8 * 0.65)
                u228 = u228 + u229 * v14
            else
                u228 = 49.480084294039244 * (a1 / 5.25) ^ 4
            end
            if a1 < 0.9 then
                v1 = a1 / 0.9
                v12 = TweenService:GetValue(v1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) * 3
                v13 = u81
                v10 = if not v13.Motion then 0 else v12
                v13.Host.CFrame = CFrame.new(v13.Pivot.Position + v13.CenterOffset + Vector3.new(0, 1, 0) * v10)
                v13 = u81
                v1 = (CFrame.new(0, v12, 0)) * CFrame.Angles(0, u228, 0)
                if not v13.Motion then
                    return
                end
                v8 = v13.GetModel()
                v9 = if v8 == nil then nil else if v8:IsDescendantOf(Workspace) then v8 else nil
                if v9 == nil or v9.PrimaryPart == nil then
                    return
                end
                v13.Moved = true
                EggActionMovement.SetPivot(v9, v13.Pivot * v1)
                return
            end
            v13 = (a1 - 0.9) / 4.35
            if not u230 and v13 >= 0.45 then
                u230 = true
                u97.Embers.Rate = 10
                u97.Embers.Enabled = true
            end
            v1 = (TweenService:GetValue(math.min(v13 / 1, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In)) * (v7 * 0.3500000000000001 + 1)
            v13 = 3 + 0.85 * TweenService:GetValue(v7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            v2 = u81
            v3 = if not v2.Motion then 0 else v13
            v2.Host.CFrame = CFrame.new(v2.Pivot.Position + v2.CenterOffset + Vector3.new(0, 1, 0) * v3)
            v2 = u81
            v3 = (shakeOffset(u81, v13, v1)) * CFrame.Angles(0, u228, 0)
            if not v2.Motion then
                return
            end
            v5 = v2.GetModel()
            v4 = if v5 == nil then nil else if v5:IsDescendantOf(Workspace) then v5 else nil
            if v4 ~= nil then
                if v4.PrimaryPart == nil then
                    return
                end
                v2.Moved = true
                EggActionMovement.SetPivot(v4, v2.Pivot * v3)
            end
            return
        end
        if not u231 then
            u231 = true
            if u224 ~= nil then
                u224:Stop()
            end
            v7 = u81
            v8 = {}
            v8.MaxDistance = v8.MaxDistance or 70
            Audio.Play(92093418106897, v7.Host.CFrame, v8)
            u97.Twinkle.Enabled = false
            u97.Embers.Enabled = false
            u127:Emit(9)
            u179.Enabled = true
            if OnVerdict ~= nil then
                task.spawn(OnVerdict)
            end
        end
        v7 = a1 - 3.45
        v8 = math.clamp(v7 / 0.22, 0, 1)
        v9 = 1 - math.clamp(v7 / 2.2, 0, 1)
        v7 = math.sin(a1 * 24) * 0.3 + 0.7
        v10 = math.lerp(0.18491278864486976, v7 * 0.5, v8) * v9 * v9
        v11 = math.lerp(0.3362050702633995, v7 * 0.7, v8) * v9 * v9
        Highlight.FillTransparency = 1 - v10
        Highlight.OutlineTransparency = 1 - v11
        Highlight.FillColor = u73:Lerp(u110, v8)
        Highlight.OutlineColor = u100:Lerp(u110, v8)
        if not (a1 < 3.8000000000000003) then
            v12 = u81
            v13 = math.clamp(1 - (a1 - 3.8000000000000003) / 0.35, 0, 1) * 0.3
            v1 = u110
            v10 = 1 - math.clamp(v13, 0, 1)
            for i, j in v12.ScreenEdges do
                j.BackgroundTransparency = v10
                if v1 ~= nil then
                    j.BackgroundColor3 = v1
                end
            end
        else
            v12 = u81
            v13 = (1 - v8) * 0.1344820281053598
            local FillColor = Highlight.FillColor
            v11 = 1 - math.clamp(v13, 0, 1)
            for k, n in v12.ScreenEdges do
                n.BackgroundTransparency = v11
                if FillColor ~= nil then
                    n.BackgroundColor3 = FillColor
                end
            end
        end
        if u179.Enabled and a1 >= 4.800000000000001 then
            u179.Enabled = false
        end
        if a1 < 3.8000000000000003 then
            u229 = u229 * math.max(1 - v14 * 6, 0)
            u228 = u228 + u229 * v14
            v9 = 3.85
            if a1 >= 3.5700000000000003 then
                v8 = (a1 - 3.5700000000000003) / 0.23
                v9 = (1 - v8 * v8) * 3.85
            end
            v12 = u81
            v7 = if not v12.Motion then 0 else v9
            v12.Host.CFrame = CFrame.new(v12.Pivot.Position + v12.CenterOffset + Vector3.new(0, 1, 0) * v7)
            v12 = u81
            v13 = (CFrame.new(0, v9, 0)) * CFrame.Angles(0, u228, 0)
            if not v12.Motion then
                return
            end
            v1 = v12.GetModel()
            local v15 = if v1 == nil then nil else if v1:IsDescendantOf(Workspace) then v1 else nil
            if v15 ~= nil then
                if v15.PrimaryPart == nil then
                    return
                end
                v12.Moved = true
                EggActionMovement.SetPivot(v15, v12.Pivot * v13)
            end
            return
        end
        if not u232 then
            u232 = true
            v12 = u81
            v14 = if not v12.Motion then 0 else 0
            v12.Host.CFrame = CFrame.new(v12.Pivot.Position + v12.CenterOffset + Vector3.new(0, 1, 0) * v14)
            u233 = u228
            u234 = math.ceil(u233 / 6.283185307179586) * 6.283185307179586
            local ImpactBoom = findNamedSound("ImpactBoom")
            if ImpactBoom ~= nil then
                v2 = {Volume = 0.7} or {}
                v2.MaxDistance = v2.MaxDistance or 70
                Audio.Play(ImpactBoom, u81.Host.CFrame, v2)
            end
            if u81.Motion then
                Shake.Play({Seconds = 0.28, Magnitude = 0.5})
            end
            u212:Emit(1)
            u179:Emit(9)
            u127:Emit(6)
        end
        v12 = a1 - 3.8000000000000003
        v1 = math.clamp(v12 / 1, 0, 1)
        v13 = TweenService:GetValue(v1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        v1 = math.lerp(u233, u234, v13)
        if v12 < 0.42 then
            v13 = v12 / 0.42
            v2 = (1 - v13) * (1 - v13)
            v3 = math.sin(6.283185307179586 * v13)
            v4 = u81
            v5 = (CFrame.new(0, u216 * math.abs(v3) * v2, 0)) * CFrame.Angles(0, v1, 0) * CFrame.Angles(0, 0, v3 * 0.08726646259971647 * v2)
            if not v4.Motion then
                return
            end
            v6 = v4.GetModel()
            v13 = if v6 == nil then nil else if v6:IsDescendantOf(Workspace) then v6 else nil
            if v13 == nil or v13.PrimaryPart == nil then
                return
            end
            v4.Moved = true
            EggActionMovement.SetPivot(v13, v4.Pivot * v5)
            return
        end
        if not (v12 < 1.6199999999999999) then
            v2 = u81
            if not v2.Moved then
                return
            end
            v2.Moved = false
            v4 = v2.GetModel()
            v3 = if v4 == nil then nil else if v4:IsDescendantOf(Workspace) then v4 else nil
            if v3 ~= nil then
                if v3.PrimaryPart == nil then
                    return
                end
                EggActionMovement.SetPivot(v3, v2.Pivot)
            end
            return
        end
        v3 = math.sin((v12 - 0.42) / 1.2 * 3.141592653589793) * 0.06981317007977318
        v4 = u81
        v5 = (CFrame.Angles(0, v1, 0)) * CFrame.Angles(v3, 0, 0)
        if not v4.Motion then
            return
        end
        v6 = v4.GetModel()
        v2 = if v6 == nil then nil else if v6:IsDescendantOf(Workspace) then v6 else nil
        if v2 == nil or v2.PrimaryPart == nil then
            return
        end
        v4.Moved = true
        EggActionMovement.SetPivot(v2, v4.Pivot * v5)
    end

    local u239 = 0
    local u240 = nil
    local PreRender = RunService.PreRender
    local u243 = 5.65
    u240 = PreRender:Connect(function(a1) -- Line: 541
        -- upvalues: u239 (ref), u243 (val), u81 (val), Workspace (upval), u235 (val), u240 (ref), u130 (upval)
        u239 = math.min(u239 + a1, u243)
        local v1 = u81
        local v2 = v1.GetModel()
        local v3 = if v2 == nil then nil else if v2:IsDescendantOf(Workspace) then v2 else nil
        if v1.Highlight.Adornee ~= v3 then
            v1.Highlight.Adornee = v3
        end
        u235(u239)
        if u239 < u243 then
            return
        end
        u240:Disconnect()
        if u130 ~= u81 then
            return
        end
        u130 = nil
        u81.Trove:Destroy()
    end)
    u81.Trove:Add(u240)
end

return (table.freeze(v1))