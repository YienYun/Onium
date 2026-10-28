-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Fx
-- Decompile time: 12.11 ms

local Debris = game:GetService("Debris")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Shake = require(ReplicatedStorage.Client.Shake)
local u54 = Color3.fromRGB(120, 255, 175)
local u55 = {}
local u56 = 0
local u57 = {
    Ghost = u54,
    Sparkle = "rbxasset://textures/particles/sparkles_main.dds",
    Smoke = "rbxasset://textures/particles/smoke_main.dds",
}

function u57.ReducedMotion() -- Line: 37 -- upvalues: GuiService (val)
    return GuiService.ReducedMotionEnabled
end

function u57.Tween(a1, a2, a3, a4, a5) -- Line: 41
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a2, a4 or Enum.EasingStyle.Quad, a5 or Enum.EasingDirection.Out), a3)
    v1:Play()
    return v1
end

function u57.Ease(a1, a2, a3) -- Line: 61 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), a2 or Enum.EasingStyle.Quad, a3 or Enum.EasingDirection.Out)
end

local function resolve(a1) -- Line: 69 -- upvalues: u55 (val)
    if type(a1) ~= "string" then
        return a1
    end
    if string.sub(a1, 1, 12) ~= "rbxasset://s" and string.sub(a1, 1, 13) ~= "rbxassetid://" then
        return a1
    end
    local v1 = u55[a1]
    if v1 == nil then
        v1 = Instance.new("Sound")
        v1.SoundId = a1
        u55[a1] = v1
    end
    return v1
end

function u57.Play(a1, a2) -- Line: 88 -- upvalues: u55 (val), Audio (val), SoundService (val) -- types: a2: table?
    local v1
    local v2 = a1
    if type(v2) ~= "string" then
        v1 = v2
    elseif string.sub(v2, 1, 12) == "rbxasset://s" or string.sub(v2, 1, 13) == "rbxassetid://" then
        local v3 = u55[v2]
        if v3 == nil then
            v3 = Instance.new("Sound")
            v3.SoundId = v2
            u55[v2] = v3
        end
        v1 = v3
    else
        v1 = v2
    end
    v2 = table.clone(a2 or {})
    if v2.SoundGroup == nil then
        v2.SoundGroup = "SFX"
    end
    return Audio.Play(v1, SoundService, v2)
end

function u57.PlayAt(a1, a2, a3) -- Line: 97 -- upvalues: u55 (val), Audio (val) -- types: a3: table?
    local v1
    local v2 = a1
    if type(v2) ~= "string" then
        v1 = v2
    elseif string.sub(v2, 1, 12) == "rbxasset://s" or string.sub(v2, 1, 13) == "rbxassetid://" then
        local v3 = u55[v2]
        if v3 == nil then
            v3 = Instance.new("Sound")
            v3.SoundId = v2
            u55[v2] = v3
        end
        v1 = v3
    else
        v1 = v2
    end
    v2 = table.clone(a3 or {})
    if v2.SoundGroup == nil then
        v2.SoundGroup = "SFX"
    end
    if v2.MaxDistance == nil then
        v2.MaxDistance = 200
    end
    return Audio.Play(v1, a2, v2)
end

local function cineShake(a1, a2) -- Line: 109
    -- upvalues: u56 (ref), RunService (val), Workspace (val)
    u56 = u56 + 1
    local u4 = u56
    local u7 = math.random() * 1000
    local u9 = os.clock()
    local identity = CFrame.identity
    local u11 = nil
    RunService:UnbindFromRenderStep("GhostDogCineShake")
    RunService:BindToRenderStep("GhostDogCineShake", Enum.RenderPriority.Camera.Value + 2, function() -- Line: 117
        -- upvalues: Workspace (upval), u9 (val), u11 (ref), identity (ref), u4 (val), u56 (upval), a2 (val)
        -- upvalues: RunService (upval), a1 (val), u7 (val)
        local CurrentCamera = Workspace.CurrentCamera
        local v1 = os.clock() - u9
        local CFrame_2 = CurrentCamera.CFrame
        if u11 and CFrame_2:FuzzyEq(u11, 0.0001) then
            CFrame_2 = CFrame_2 * identity:Inverse()
        end
        if u4 == u56 and not (a2 <= v1) then
            local v2 = a1 * 0.5 * (1 - v1 / a2) ^ 2
            local v3 = v1 * 18 + u7
            identity = (CFrame.new(math.noise(v3, 1.3) * v2, math.noise(v3, 7.1) * v2, 0)) * CFrame.Angles(math.noise(v3, 2.9) * v2 * 0.06, math.noise(v3, 5.3) * v2 * 0.06, math.noise(v3, 4.7) * v2 * 0.06 * 1.6)
            u11 = CFrame_2 * identity
            CurrentCamera.CFrame = u11
            return
        end
        if u4 == u56 then
            CurrentCamera.CFrame = CFrame_2
            RunService:UnbindFromRenderStep("GhostDogCineShake")
        end
    end)
end

function u57.Shake(a1, a2) -- Line: 147
    -- upvalues: u57 (val), Workspace (val), cineShake (val), Shake (val)
    if u57.ReducedMotion() then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        cineShake(a1, a2 or 0.35)
        return
    end
    Shake.Play({Shape = "Fade", Magnitude = a1, Seconds = a2 or 0.35})
end

function u57.Flash(a1, a2, a3, a4) -- Line: 159
    -- upvalues: Flash (val)
    Flash.Play({Attack = a3 or 0.03, Decay = a4 or 0.35, Tint = a1, Opacity = a2})
end

function u57.Burst(a1, a2, a3, a4, a5, a6) -- Line: 168
    -- upvalues: Workspace (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(a1)
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = a6 or "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.Color = ColorSequence.new(a2)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Rate = 0
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.9)
    ParticleEmitter.Speed = NumberRange.new(a4 * 0.5, a4)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Drag = 4
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a5), (NumberSequenceKeypoint.new(1, 0))})
    ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), (NumberSequenceKeypoint.new(1, 1))})
    ParticleEmitter.Parent = Part
    Part.Parent = Workspace
    ParticleEmitter:Emit(a3)
    Debris:AddItem(Part, 1.5)
end

function u57.Ring(a1, a2, a3, a4, a5) -- Line: 207
    -- upvalues: Workspace (val), u57 (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Shape = Enum.PartType.Cylinder
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = a2
    Part.Transparency = 0.2
    Part.Size = Vector3.new(0.15, a3, a3)
    Part.CFrame = a1 * CFrame.Angles(0, 0, 1.5707963267948966)
    Part.Parent = Workspace
    u57.Tween(Part, a5, {Transparency = 1, Size = Vector3.new(0.15, a4, a4)})
    Debris:AddItem(Part, a5 + 0.1)
end

local function emitter(a1, a2) -- Line: 229 -- types: a1: userdata, a2: table
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Rate = 0
    ParticleEmitter.LightEmission = 0.3
    ParticleEmitter.LockedToPart = false
    for i, j in a2 do
        ParticleEmitter[i] = j
    end
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

function u57.Splash(a1, a2) -- Line: 241 -- upvalues: Workspace (val), Debris (val) -- types: a1: vector, a2: number
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(a1)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local v1 = Color3.fromRGB(165, 255, 225)
    local v2 = {
        Texture = "rbxassetid://14431663347",
        Brightness = 2,
        ZOffset = 0.5,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
        Color = ColorSequence.new(v1),
        Size = NumberSequence.new(a2 * 5.5, a2 * 7),
        Lifetime = NumberRange.new(0.45, 0.6),
        Speed = NumberRange.new(0, 0),
        Rotation = NumberRange.new(-12, 12),
    }
    local v3 = Instance.new("ParticleEmitter")
    v3.Rate = 0
    v3.LightEmission = 0.3
    v3.LockedToPart = false
    for i, j in v2 do
        v3[i] = j
    end
    v3.Parent = Attachment
    local v4 = {
        Texture = "rbxassetid://85239189459475",
        Brightness = 2.5,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Orientation = Enum.ParticleOrientation.VelocityParallel,
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(v1),
        Size = NumberSequence.new(a2 * 2.4, a2 * 1.2),
        Lifetime = NumberRange.new(0.5, 0.9),
        Speed = NumberRange.new(a2 * 16, a2 * 30),
        SpreadAngle = Vector2.new(28, 28),
        Acceleration = Vector3.new(0, a2 * -70, 0),
    }
    v2 = Instance.new("ParticleEmitter")
    v2.Rate = 0
    v2.LightEmission = 0.3
    v2.LockedToPart = false
    for k, n in v4 do
        v2[k] = n
    end
    v2.Parent = Attachment
    local v5 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        Drag = 1,
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(Color3.fromRGB(220, 255, 245)),
        Size = NumberSequence.new(a2 * 0.5, 0),
        Lifetime = NumberRange.new(0.6, 1.1),
        Speed = NumberRange.new(a2 * 14, a2 * 26),
        SpreadAngle = Vector2.new(55, 55),
        Acceleration = Vector3.new(0, a2 * -60, 0),
    }
    v4 = Instance.new("ParticleEmitter")
    v4.Rate = 0
    v4.LightEmission = 0.3
    v4.LockedToPart = false
    for m, i5 in v5 do
        v4[m] = i5
    end
    v4.Parent = Attachment
    local v6 = {
        Texture = "rbxassetid://90951481407921",
        LightEmission = 0.8,
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(v1),
        Size = NumberSequence.new(a2 * 2, a2 * 18),
        Transparency = NumberSequence.new(0.1, 1),
        Lifetime = NumberRange.new(0.7, 0.9),
        Speed = NumberRange.new(0.01, 0.01),
        Rotation = NumberRange.new(0, 360),
    }
    local u195 = Instance.new("ParticleEmitter")
    u195.Rate = 0
    u195.LightEmission = 0.3
    u195.LockedToPart = false
    for i6, i7 in v6 do
        u195[i6] = i7
    end
    u195.Parent = Attachment
    v6 = {
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        Color = ColorSequence.new(Color3.fromRGB(200, 255, 240)),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), (NumberSequenceKeypoint.new(1, 1))}),
        Size = NumberSequence.new(a2 * 3, a2 * 8),
        Lifetime = NumberRange.new(0.8, 1.2),
        Speed = NumberRange.new(2, 5),
        SpreadAngle = Vector2.new(70, 70),
        EmissionDirection = Enum.NormalId.Top,
        Rotation = NumberRange.new(0, 360),
    }
    v1 = Instance.new("ParticleEmitter")
    v1.Rate = 0
    v1.LightEmission = 0.3
    v1.LockedToPart = false
    for i8, i9 in v6 do
        v1[i8] = i9
    end
    v1.Parent = Attachment
    Part.Parent = Workspace
    v3:Emit((math.max(1, (math.floor(a2 * 2)))))
    v2:Emit((math.floor(a2 * 8)) + 2)
    v4:Emit((math.floor(a2 * 22)) + 4)
    u195:Emit(1)
    v1:Emit((math.floor(a2 * 4)) + 1)
    task.delay(0.18, function() -- Line: 324 -- upvalues: Part (val), u195 (val)
        if Part.Parent then
            u195:Emit(1)
        end
    end)
    task.delay(0.36, function() -- Line: 329 -- upvalues: Part (val), u195 (val)
        if Part.Parent then
            u195:Emit(1)
        end
    end)
    Debris:AddItem(Part, 2.5)
end

function u57.Ripple(a1, a2) -- Line: 337 -- upvalues: Workspace (val), Debris (val) -- types: a1: vector, a2: number
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(a1)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local v1 = {
        Texture = "rbxassetid://90951481407921",
        LightEmission = 0.8,
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(Color3.fromRGB(165, 255, 225)),
        Size = NumberSequence.new(a2 * 1.5, a2 * 12),
        Transparency = NumberSequence.new(0.15, 1),
        Lifetime = NumberRange.new(0.6, 0.8),
        Speed = NumberRange.new(0.01, 0.01),
        Rotation = NumberRange.new(0, 360),
    }
    local v2 = Instance.new("ParticleEmitter")
    v2.Rate = 0
    v2.LightEmission = 0.3
    v2.LockedToPart = false
    for i, j in v1 do
        v2[i] = j
    end
    v2.Parent = Attachment
    local v3 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        Acceleration = Vector3.new(0, -40, 0),
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(Color3.fromRGB(220, 255, 245)),
        Size = NumberSequence.new(a2 * 0.35, 0),
        Lifetime = NumberRange.new(0.4, 0.7),
        Speed = NumberRange.new(a2 * 6, a2 * 12),
        SpreadAngle = Vector2.new(40, 40),
    }
    v1 = Instance.new("ParticleEmitter")
    v1.Rate = 0
    v1.LightEmission = 0.3
    v1.LockedToPart = false
    for k, n in v3 do
        v1[k] = n
    end
    v1.Parent = Attachment
    Part.Parent = Workspace
    v2:Emit(1)
    v1:Emit((math.floor(a2 * 8)) + 2)
    Debris:AddItem(Part, 1.5)
end

function u57.RippleEmitter(a1, a2, a3) -- Line: 377
    -- upvalues: u54 (val)
    local v1 = {
        Texture = "rbxassetid://90951481407921",
        LightEmission = 1,
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Color = ColorSequence.new(u54),
        Size = NumberSequence.new(a3 * 1.5, a3 * 11),
        Transparency = NumberSequence.new(0.2, 1),
        Lifetime = NumberRange.new(1.1, 1.3),
        Speed = NumberRange.new(0.01, 0.01),
        Rotation = NumberRange.new(0, 360),
        Rate = a2,
    }
    local v2 = Instance.new("ParticleEmitter")
    v2.Rate = 0
    v2.LightEmission = 0.3
    v2.LockedToPart = false
    for i, j in v1 do
        v2[i] = j
    end
    v2.Parent = a1
    return v2
end

function u57.Punch(a1, a2, a3) -- Line: 393 -- upvalues: u57 (val) -- types: a1: userdata, a2: number, a3: number
    a1.Scale = a2
    u57.Tween(a1, a3, {Scale = 1}, Enum.EasingStyle.Back)
end

return (table.freeze(u57))