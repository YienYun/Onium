-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.PowerUpSystem
-- Decompile time: 46.93 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Shake = require(ReplicatedStorage.Client.Shake)
local FallenPowerUp = require(ReplicatedStorage.Data.FallenPowerUp)
local LightVsDarknessEventFlags = require(ReplicatedStorage.Shared.Flags.LightVsDarknessEventFlags)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LightVsDarknessSounds = ReplicatedStorage.Assets.Sounds:WaitForChild("LightVsDarknessSounds")
local u65 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local u68 = Trove.new()
local u69 = nil
local u70 = {}
local u71 = {}
local u72 = {}
local u73 = nil
local u74 = 0
local u75 = nil
local u76 = 0

local function serverNow() -- Line: 83 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function keypoint(a1, a2) -- Line: 87 -- types: a1: number, a2: number
    return NumberSequenceKeypoint.new(a1, a2)
end

local function itemsFolder() -- Line: 91 -- upvalues: u73 (ref), Workspace (val), u68 (val)
    local v1 = u73
    if v1 ~= nil then
        return v1
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "LightVsDarknessPowerUps"
    Folder.Parent = Workspace
    u68:Add(Folder)
    u68:Add(function() -- Line: 100 -- upvalues: u73 (upval)
        u73 = nil
    end)
    u73 = Folder
    return Folder
end

local function stripModel(a1) -- Line: 107 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
        end
    end
end

local function vfxEnabled() -- Line: 118 -- upvalues: LightVsDarknessEventFlags (val)
    return LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get()
end

local function punchEnabled() -- Line: 122 -- upvalues: LightVsDarknessEventFlags (val)
    return LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get() and LightVsDarknessEventFlags.PowerUpDropPunchEnabled:Get()
end

local function soundsEnabled() -- Line: 126 -- upvalues: LightVsDarknessEventFlags (val)
    return LightVsDarknessEventFlags.PowerUpDropSoundsEnabled:Get()
end

local function cometScale() -- Line: 130 -- upvalues: LightVsDarknessEventFlags (val)
    return LightVsDarknessEventFlags.PowerUpCometScale:Get()
end

local function headPixels(a1) -- Line: 134
    -- upvalues: Workspace (val), FallenPowerUp (val), LightVsDarknessEventFlags (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return FallenPowerUp.HeadPixelMin
    end
    return (math.clamp(
        FallenPowerUp.HeadPixelRef * LightVsDarknessEventFlags.PowerUpCometScale:Get() / (math.max((CurrentCamera.CFrame.Position - a1).Magnitude, 1)),
        FallenPowerUp.HeadPixelMin,
        FallenPowerUp.HeadPixelMax
    ))
end

local function skyTargetY(a1) -- Line: 147 -- upvalues: u75 (ref), LightVsDarknessEventFlags (val)
    local v1 = u75
    if v1 ~= nil and LightVsDarknessEventFlags.PowerUpSkyLiftEnabled:Get() then
        return v1
    end
    return a1.Y
end

local function fxAnchor(a1) -- Line: 155 -- types: a1: vector
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a1)
    return Part
end

local function playPickupSound() -- Line: 167 -- upvalues: LightVsDarknessSounds (val)
    local CollectChargedRing = LightVsDarknessSounds:FindFirstChild("CollectChargedRing")
    if CollectChargedRing ~= nil and CollectChargedRing:IsA("Sound") then
        local u11 = CollectChargedRing:Clone()
        u11.Parent = CollectChargedRing.Parent
        u11.PlayOnRemove = true
        u11.PlaybackSpeed = 1.15
        task.defer(function() -- Line: 176 -- upvalues: u11 (val)
            u11:Destroy()
        end)
        return
    end
end

local function playRiser() -- Line: 181 -- upvalues: FallenPowerUp (val), SoundService (val)
    local Sound = Instance.new("Sound")
    Sound.SoundId = FallenPowerUp.RiserSoundId
    Sound.Volume = FallenPowerUp.RiserVolume
    Sound.PlayOnRemove = true
    Sound.Parent = SoundService
    task.defer(function() -- Line: 187 -- upvalues: Sound (val)
        Sound:Destroy()
    end)
end

local function playLandSound(a1) -- Line: 192 -- upvalues: FallenPowerUp (val), itemsFolder (val) -- types: a1: vector
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a1)
    local Sound = Instance.new("Sound")
    Sound.SoundId = FallenPowerUp.ImpactSoundId
    Sound.Volume = FallenPowerUp.ImpactVolume
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.RollOffMaxDistance = FallenPowerUp.ImpactRangeStuds
    Sound.PlayOnRemove = true
    Sound.Parent = Part
    Part.Parent = itemsFolder()
    task.defer(function() -- Line: 202 -- upvalues: Part (val)
        Part:Destroy()
    end)
end

local function groundRing(a1, a2, a3) -- Line: 207
    -- upvalues: FallenPowerUp (val)
    local v1 = a1 + Vector3.new(0, FallenPowerUp.MarkerLiftStuds, 0)
    local v2 = Instance.new("Part")
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.Transparency = 1
    v2.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v2.CFrame = CFrame.new(v1)
    v2.Size = Vector3.new(a2, FallenPowerUp.MarkerThickStuds, a2)
    local Decal = Instance.new("Decal")
    Decal.Name = "Ring"
    Decal.Face = Enum.NormalId.Top
    Decal.Texture = FallenPowerUp.MarkerTexture
    Decal.Color3 = a3
    Decal.Parent = v2
    return v2, Decal
end

local function playShockwave(a1, a2) -- Line: 221
    -- upvalues: FallenPowerUp (val), itemsFolder (val), TweenService (val), u65 (val)
    local v1 = a1 + Vector3.new(0, FallenPowerUp.MarkerLiftStuds, 0)
    local v2 = Instance.new("Part")
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.Transparency = 1
    v2.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v2.CFrame = CFrame.new(v1)
    v2.Size = Vector3.new(8, FallenPowerUp.MarkerThickStuds, 8)
    local Decal = Instance.new("Decal")
    Decal.Name = "Ring"
    Decal.Face = Enum.NormalId.Top
    Decal.Texture = FallenPowerUp.MarkerTexture
    Decal.Color3 = a2
    Decal.Parent = v2
    local u35 = v2
    local PointLight = Instance.new("PointLight")
    PointLight.Color = a2
    PointLight.Brightness = FallenPowerUp.LandFlashBrightness
    PointLight.Range = FallenPowerUp.LandFlashRangeStuds
    PointLight.Parent = u35
    u35.Parent = itemsFolder()
    v1 = TweenInfo.new(FallenPowerUp.ShockwaveSeconds, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local ShockwaveStuds = FallenPowerUp.ShockwaveStuds
    TweenService:Create(u35, v1, {
        Size = Vector3.new(ShockwaveStuds, FallenPowerUp.MarkerThickStuds, ShockwaveStuds),
    }):Play()
    TweenService:Create(Decal, v1, {Transparency = 1}):Play()
    TweenService:Create(PointLight, u65, {Brightness = 0}):Play()
    task.delay(FallenPowerUp.ShockwaveSeconds + 0.2, function() -- Line: 242 -- upvalues: u35 (val)
        u35:Destroy()
    end)
end

local function playImpact(a1, a2) -- Line: 247
    -- upvalues: ReplicatedStorage (val), Workspace (val)
    local Attribute_2
    local BigHitGroundAttach = ReplicatedStorage.Assets.Particles:FindFirstChild("BigHitGroundAttach")
    if BigHitGroundAttach == nil then
        return
    end
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a1)
    Part.Parent = Workspace
    local v1 = BigHitGroundAttach:Clone()
    v1.Parent = Part
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            j.Color = ColorSequence.new(a2)
            Attribute_2 = j:GetAttribute("EmitCount")
            j:Emit(Attribute_2 or 18)
        end
    end
    if v1:IsA("ParticleEmitter") then
        v1.Color = ColorSequence.new(a2)
        v1:Emit((v1:GetAttribute("EmitCount")) or 18)
    end
    task.delay(3, function() -- Line: 266 -- upvalues: Part (val)
        Part:Destroy()
    end)
end

local function playSpawnBurst(a1, a2, a3) -- Line: 271
    -- upvalues: FallenPowerUp (val), keypoint (val), itemsFolder (val), TweenService (val), u65 (val)
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a1)
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = FallenPowerUp.BurstShockTexture
    ParticleEmitter.Color = ColorSequence.new(a2)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Lifetime = NumberRange.new(0.45, 0.6)
    ParticleEmitter.Rate = 0
    ParticleEmitter.Speed = NumberRange.new(0)
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    local new = NumberSequence.new
    local v1 = {}
    local v2 = a3 * 2
    local v3 = NumberSequenceKeypoint.new(0, v2)
    local v4 = a3 * 11
    v2 = NumberSequenceKeypoint.new(0.4, v4)
    v1[1] = v3
    v1[2] = v2
    v1[3] = keypoint(1, a3 * 15)
    ParticleEmitter.Size = new(v1)
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.7, 0.5),
        (keypoint(1, 1)),
    })
    ParticleEmitter.Parent = Part
    local ParticleEmitter_2 = Instance.new("ParticleEmitter")
    ParticleEmitter_2.Texture = FallenPowerUp.BurstGlowTexture
    ParticleEmitter_2.Color = ColorSequence.new(Color3.new(1, 1, 1), a2)
    ParticleEmitter_2.LightEmission = 1
    ParticleEmitter_2.LightInfluence = 0
    ParticleEmitter_2.Lifetime = NumberRange.new(0.35)
    ParticleEmitter_2.Rate = 0
    ParticleEmitter_2.Speed = NumberRange.new(0)
    ParticleEmitter_2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a3 * 10), (keypoint(1, 0))})
    ParticleEmitter_2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), (keypoint(1, 1))})
    ParticleEmitter_2.Parent = Part
    local ParticleEmitter_3 = Instance.new("ParticleEmitter")
    ParticleEmitter_3.Texture = FallenPowerUp.BurstGlowTexture
    ParticleEmitter_3.Color = ColorSequence.new(a2)
    ParticleEmitter_3.LightEmission = 1
    ParticleEmitter_3.LightInfluence = 0
    ParticleEmitter_3.Lifetime = NumberRange.new(0.5, 0.8)
    ParticleEmitter_3.Rate = 0
    ParticleEmitter_3.Speed = NumberRange.new(a3 * 16, a3 * 26)
    ParticleEmitter_3.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter_3.Drag = 5
    ParticleEmitter_3.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a3 * 0.8), (keypoint(1, 0))})
    ParticleEmitter_3.Parent = Part
    local PointLight = Instance.new("PointLight")
    PointLight.Color = a2
    PointLight.Brightness = 6
    PointLight.Range = a3 * 30
    PointLight.Parent = Part
    Part.Parent = itemsFolder()
    ParticleEmitter:Emit(2)
    ParticleEmitter_2:Emit(1)
    ParticleEmitter_3:Emit((math.floor(a3 * 24)))
    TweenService:Create(PointLight, u65, {Brightness = 0}):Play()
    task.delay(2, function() -- Line: 323 -- upvalues: Part (val)
        Part:Destroy()
    end)
end

local function destroyFx(a1) -- Line: 328 -- types: a1: table
    local Fx = a1.Fx
    if Fx ~= nil then
        a1.Fx = nil
        Fx:Destroy()
    end
    local Mark = a1.Mark
    if Mark ~= nil then
        a1.Mark = nil
        a1.Ring = nil
        Mark:Destroy()
    end
    local Head = a1.Head
    if Head ~= nil then
        a1.Head = nil
        Head:Destroy()
    end
end

local function buildHead(a1, a2) -- Line: 347 -- upvalues: FallenPowerUp (val) -- types: a1: table, a2: userdata
    local BasePart = a1.Model:FindFirstChildWhichIsA("BasePart")
    if BasePart == nil then
        return
    end
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "CometHead"
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 0
    BillboardGui.Adornee = BasePart
    BillboardGui.Size = UDim2.fromOffset(FallenPowerUp.HeadPixelMin, FallenPowerUp.HeadPixelMin)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = FallenPowerUp.HeadGlowTexture
    ImageLabel.ImageColor3 = a2
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.Parent = BillboardGui
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Image = FallenPowerUp.HeadGlowTexture
    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_2.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel_2.Size = UDim2.fromScale(FallenPowerUp.HeadCoreScale, FallenPowerUp.HeadCoreScale)
    ImageLabel_2.Parent = BillboardGui
    BillboardGui.Parent = BasePart
    a1.Head = BillboardGui
end

local function buildMark(a1, a2, a3) -- Line: 384
    -- upvalues: FallenPowerUp (val), itemsFolder (val)
    local MarkerStartStuds = FallenPowerUp.MarkerStartStuds
    local v1 = a2 + Vector3.new(0, FallenPowerUp.MarkerLiftStuds, 0)
    local v2 = Instance.new("Part")
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.Transparency = 1
    v2.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v2.CFrame = CFrame.new(v1)
    v2.Size = Vector3.new(MarkerStartStuds, FallenPowerUp.MarkerThickStuds, MarkerStartStuds)
    local Decal = Instance.new("Decal")
    Decal.Name = "Ring"
    Decal.Face = Enum.NormalId.Top
    Decal.Texture = FallenPowerUp.MarkerTexture
    Decal.Color3 = a3
    Decal.Parent = v2
    local v3 = v2
    v3.Parent = itemsFolder()
    a1.Mark = v3
    a1.Ring = Decal
end

local function buildTail(a1, a2, a3, a4, a5) -- Line: 392
    -- upvalues: FallenPowerUp (val), keypoint (val), itemsFolder (val)
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a2)
    Part.CFrame = CFrame.lookAt(a2, a3)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = Vector3.new(0, 0, a5)
    Attachment_2.Parent = Part
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_2
    Beam.Texture = FallenPowerUp.TailTexture
    Beam.TextureMode = Enum.TextureMode.Stretch
    Beam.TextureLength = 1
    Beam.TextureSpeed = 0.6
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.Width0 = FallenPowerUp.TailWidthStuds
    Beam.Width1 = FallenPowerUp.TailTipWidthStuds
    Beam.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.25, a4),
        (ColorSequenceKeypoint.new(1, a4)),
    })
    Beam.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.05),
        NumberSequenceKeypoint.new(0.6, 0.45),
        (keypoint(1, 1)),
    })
    Beam.Parent = Part
    local v1 = Beam:Clone()
    v1.Width0 = FallenPowerUp.TailWidthStuds * FallenPowerUp.PlumeWidthScale
    v1.Width1 = FallenPowerUp.TailTipWidthStuds * FallenPowerUp.PlumeWidthScale
    v1.TextureSpeed = 0.25
    v1.Color = ColorSequence.new(a4)
    local new_3 = NumberSequence.new
    local v2 = {}
    local PlumeTransparency = FallenPowerUp.PlumeTransparency
    local v3 = NumberSequenceKeypoint.new(0, PlumeTransparency)
    local v4 = NumberSequenceKeypoint.new(0.7, 0.9)
    v2[1] = v3
    v2[2] = v4
    v2[3] = keypoint(1, 1)
    v1.Transparency = new_3(v2)
    v1.Parent = Part
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = FallenPowerUp.BurstGlowTexture
    ParticleEmitter.Color = ColorSequence.new(a4)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Lifetime = NumberRange.new(0.35, 0.55)
    ParticleEmitter.Rate = FallenPowerUp.TailSparkRate
    ParticleEmitter.Speed = NumberRange.new(2, 6)
    ParticleEmitter.SpreadAngle = Vector2.new(35, 35)
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, FallenPowerUp.TailSparkStuds), keypoint(1, 0)})
    ParticleEmitter.Parent = Attachment
    Part.Parent = itemsFolder()
    a1.Fx = Part
end

local function buildBeacon(a1, a2, a3) -- Line: 453
    -- upvalues: FallenPowerUp (val), keypoint (val), itemsFolder (val)
    local Fx = a1.Fx
    if Fx ~= nil then
        a1.Fx = nil
        Fx:Destroy()
    end
    local Mark = a1.Mark
    if Mark ~= nil then
        a1.Mark = nil
        a1.Ring = nil
        Mark:Destroy()
    end
    local Head = a1.Head
    if Head ~= nil then
        a1.Head = nil
        Head:Destroy()
    end
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a2)
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(0, FallenPowerUp.BeaconBaseStuds, 0)
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = Vector3.new(0, FallenPowerUp.BeaconHeightStuds, 0)
    Attachment_2.Parent = Part
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_2
    Beam.Texture = FallenPowerUp.BeaconTexture
    Beam.TextureMode = Enum.TextureMode.Stretch
    Beam.TextureLength = 1
    Beam.TextureSpeed = 0.35
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.Width0 = FallenPowerUp.BeaconWidthStuds
    Beam.Width1 = 1.2
    Beam.Color = ColorSequence.new(a3)
    Beam.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.25),
        NumberSequenceKeypoint.new(0.75, 0.55),
        (keypoint(1, 1)),
    })
    Beam.Parent = Part
    Part.Parent = itemsFolder()
    a1.Fx = Part
end

local function playLandShake(a1) -- Line: 484
    -- upvalues: LightVsDarknessEventFlags (val), Player (val), LocalPlayer (val), FallenPowerUp (val), Shake (val)
    if not LightVsDarknessEventFlags.PowerUpLandShakeEnabled:Get() then
        return
    end
    local v1 = LightVsDarknessEventFlags.PowerUpLandShakeRadiusStuds:Get()
    local v2 = Player.FindPrimaryPart(LocalPlayer)
    v2 = (math.clamp(1 - (if v2 == nil then (1 / 0) else (v2.Position - a1).Magnitude) / math.max(v1, 1), 0, 1)) ^ FallenPowerUp.LandShakeFalloff
    Shake.Play({
        Shape = "Pulse",
        Seconds = FallenPowerUp.GlobalBumpSeconds + (FallenPowerUp.LandShakeSeconds - FallenPowerUp.GlobalBumpSeconds) * v2,
        Magnitude = FallenPowerUp.GlobalBumpIntensity + (FallenPowerUp.LandShakeIntensity - FallenPowerUp.GlobalBumpIntensity) * v2,
    })
end

local function buildItem(a1) -- Line: 499
    -- upvalues: FallenPowerUp (val), stripModel (val), TweenService (val), Workspace (val)
    -- upvalues: LightVsDarknessEventFlags (val), itemsFolder (val), u70 (val), buildTail (val), buildHead (val)
    local v1 = FallenPowerUp.KindById(a1.Kind)
    local v2 = FallenPowerUp.ModelFor(a1.Kind)
    if v1 ~= nil and v2 ~= nil then
        local v3, v4, v5
        local v6 = Vector3.new(a1.SX, a1.SY, a1.SZ)
        local v7 = v2:Clone()
        stripModel(v7)
        v7.Name = ("PowerUp%*"):format(a1.Id)
        v7:PivotTo((CFrame.new(v6)))
        v2 = Instance.new("Highlight")
        v2.FillColor = v1.Color
        v2.OutlineColor = v1.Color
        v2.FillTransparency = FallenPowerUp.HighlightFillTransparency
        v2.OutlineTransparency = FallenPowerUp.HighlightOutlineTransparency
        v2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        v2.Adornee = v7
        v2.Parent = v7
        TweenService:Create(v2, FallenPowerUp.HighlightPulse, {FillTransparency = FallenPowerUp.HighlightPulseFill}):Play()
        v2 = v7:FindFirstChildWhichIsA("BasePart")
        if v2 ~= nil then
            local PointLight = Instance.new("PointLight")
            PointLight.Color = v1.Color
            PointLight.Brightness = FallenPowerUp.LightBrightness
            PointLight.Range = FallenPowerUp.LightRangeStuds
            PointLight.Parent = v2
        end
        v2 = (v7:GetScale()) * FallenPowerUp.WorldScale
        local BoundingBox, BoundingBox_2 = v7:GetBoundingBox()
        local v8 = math.max(v7:GetPivot().Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y * 0.5), 0) * FallenPowerUp.WorldScale + FallenPowerUp.BobStuds + FallenPowerUp.HoverStuds
        if not ((Workspace:GetServerTimeNow()) < a1.LandAt) then
            v3 = v2
        else
            v5 = LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get() and LightVsDarknessEventFlags.PowerUpDropPunchEnabled:Get()
            v3 = if not v5 then v2 else v2 * FallenPowerUp.FlightScale * LightVsDarknessEventFlags.PowerUpCometScale:Get()
        end
        v7:ScaleTo(v3)
        v7.Parent = itemsFolder()
        v5 = {
            AskedAt = 0,
            Landed = false,
            ShrinkAt = 0,
            Item = a1,
            Model = v7,
            Scale = v2,
            Start = v6,
            BaseY = a1.Y,
            Flight = v3,
            Rest = v8,
        }
        u70[a1.Id] = v5
        if v4 and LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get() then
            v8 = Vector3.new(a1.X, a1.Y, a1.Z)
            buildTail(v5, v6, v8, v1.Color, (math.clamp(
                FallenPowerUp.TailLengthStuds * ((v6 - v8).Magnitude / (math.max(a1.FallSeconds or 1, 0.1))) / FallenPowerUp.TailSpeedRef,
                FallenPowerUp.TailLengthStuds,
                FallenPowerUp.TailMaxLengthStuds
            )))
            local v9 = LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get() and LightVsDarknessEventFlags.PowerUpDropPunchEnabled:Get()
            if v9 then
                buildHead(v5, v1.Color)
                local Color = v1.Color
                local MarkerStartStuds = FallenPowerUp.MarkerStartStuds
                local v10 = v8 + Vector3.new(0, FallenPowerUp.MarkerLiftStuds, 0)
                v3 = Instance.new("Part")
                v3.Anchored = true
                v3.CanCollide = false
                v3.CanQuery = false
                v3.CanTouch = false
                v3.Transparency = 1
                v3.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
                v3.CFrame = CFrame.new(v10)
                v3.Size = Vector3.new(MarkerStartStuds, FallenPowerUp.MarkerThickStuds, MarkerStartStuds)
                v7 = Instance.new("Decal")
                v7.Name = "Ring"
                v7.Face = Enum.NormalId.Top
                v7.Texture = FallenPowerUp.MarkerTexture
                v7.Color3 = Color
                v7.Parent = v3
                local v11 = v3
                v11.Parent = itemsFolder()
                v5.Mark = v11
                v5.Ring = v7
            end
        end
        return
    end
end

local function destroyRendered(a1) -- Line: 582 -- upvalues: u70 (val) -- types: a1: number
    local v1 = u70[a1]
    if v1 == nil then
        return
    end
    u70[a1] = nil
    local Fx = v1.Fx
    if Fx ~= nil then
        v1.Fx = nil
        Fx:Destroy()
    end
    local Mark = v1.Mark
    if Mark ~= nil then
        v1.Mark = nil
        v1.Ring = nil
        Mark:Destroy()
    end
    local Head = v1.Head
    if Head ~= nil then
        v1.Head = nil
        Head:Destroy()
    end
    v1.Model:Destroy()
end

local function fadeRendered(a1) -- Line: 592 -- upvalues: u70 (val), TweenService (val), u65 (val) -- types: a1: number
    local v1 = u70[a1]
    if v1 == nil then
        return
    end
    u70[a1] = nil
    local Fx = v1.Fx
    if Fx ~= nil then
        v1.Fx = nil
        Fx:Destroy()
    end
    local Mark = v1.Mark
    if Mark ~= nil then
        v1.Mark = nil
        v1.Ring = nil
        Mark:Destroy()
    end
    local Head = v1.Head
    if Head ~= nil then
        v1.Head = nil
        Head:Destroy()
    end
    local Model = v1.Model
    for i, j in Model:GetDescendants() do
        if j:IsA("BasePart") then
            TweenService:Create(j, u65, {Transparency = 1}):Play()
        elseif j:IsA("Highlight") then
            TweenService:Create(j, u65, {FillTransparency = 1, OutlineTransparency = 1}):Play()
        elseif j:IsA("PointLight") then
            TweenService:Create(j, u65, {Brightness = 0}):Play()
        end
    end
    task.delay(0.3, function() -- Line: 612 -- upvalues: Model (val)
        Model:Destroy()
    end)
end

local function clearItems() -- Line: 617 -- upvalues: u69 (ref), u70 (val)
    local Fx, Head, Mark, v1
    u69 = nil
    local v2 = nil
    local v3 = nil
    for i in u70, v2, v3 do
        v1 = u70[i]
        if v1 ~= nil then
            u70[i] = nil
            Fx = v1.Fx
            if Fx ~= nil then
                v1.Fx = nil
                Fx:Destroy()
            end
            Mark = v1.Mark
            if Mark ~= nil then
                v1.Mark = nil
                v1.Ring = nil
                Mark:Destroy()
            end
            Head = v1.Head
            if Head ~= nil then
                v1.Head = nil
                Head:Destroy()
            end
            v1.Model:Destroy()
        end
    end
    table.clear(u70)
end

local function adoptBatch(a1, a2) -- Line: 625
    -- upvalues: u69 (ref), u70 (val), Workspace (val), buildItem (val), LightVsDarknessEventFlags (val)
    -- upvalues: playSpawnBurst (val), FallenPowerUp (val), SoundService (val)
    local Fx, Head, Mark, v1
    u69 = nil
    local v2 = nil
    local v3 = nil
    local v4, v5 = a1, a2
    for i in u70, v2, v3 do
        v1 = u70[i]
        if v1 ~= nil then
            u70[i] = nil
            Fx = v1.Fx
            if Fx ~= nil then
                v1.Fx = nil
                Fx:Destroy()
            end
            Mark = v1.Mark
            if Mark ~= nil then
                v1.Mark = nil
                v1.Ring = nil
                Mark:Destroy()
            end
            Head = v1.Head
            if Head ~= nil then
                v1.Head = nil
                Head:Destroy()
            end
            v1.Model:Destroy()
        end
    end
    table.clear(u70)
    u69 = v4
    local ServerTimeNow = Workspace:GetServerTimeNow()
    v2 = nil
    for j, k in v5 do
        buildItem(k)
        if v2 == nil and ServerTimeNow < k.LandAt then
            v2 = Vector3.new(k.SX, k.SY, k.SZ)
        end
    end
    if v2 ~= nil and LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get() then
        playSpawnBurst(v2, Color3.fromRGB(255, 240, 200), FallenPowerUp.BurstOriginScale)
    end
    if v2 ~= nil and LightVsDarknessEventFlags.PowerUpDropSoundsEnabled:Get() then
        local u57 = Instance.new("Sound")
        u57.SoundId = FallenPowerUp.RiserSoundId
        u57.Volume = FallenPowerUp.RiserVolume
        u57.PlayOnRemove = true
        u57.Parent = SoundService
        task.defer(function() -- Line: 187 -- upvalues: u57 (val)
            u57:Destroy()
        end)
    end
end

local function onDropped(a1, a2) -- Line: 644 -- upvalues: adoptBatch (val) -- types: a1: number, a2: table
    adoptBatch(a1, a2)
end

local function onCleared(a1) -- Line: 648 -- upvalues: u69 (ref), u70 (val), fadeRendered (val) -- types: a1: number
    if a1 ~= u69 then
        return
    end
    u69 = nil
    for i in u70 do
        fadeRendered(i)
    end
    table.clear(u70)
end

local function onCollected(a1, a2, a3) -- Line: 659
    -- upvalues: u69 (ref), u70 (val), FallenPowerUp (val), playImpact (val), u71 (val), LocalPlayer (val)
    -- upvalues: playPickupSound (val)
    if a1 ~= u69 then
        return
    end
    local v1 = u70[a2]
    if v1 == nil then
        return
    end
    u70[a2] = nil
    local Fx = v1.Fx
    if Fx ~= nil then
        v1.Fx = nil
        Fx:Destroy()
    end
    local Mark = v1.Mark
    if Mark ~= nil then
        v1.Mark = nil
        v1.Ring = nil
        Mark:Destroy()
    end
    local Head = v1.Head
    if Head ~= nil then
        v1.Head = nil
        Head:Destroy()
    end
    local v2 = FallenPowerUp.KindById(v1.Item.Kind)
    if v2 ~= nil then
        playImpact(v1.Model:GetPivot().Position, v2.Color)
    end
    u71[v1.Model] = {
        Model = v1.Model,
        From = v1.Model:GetPivot().Position,
        StartedAt = os.clock(),
        Scale = v1.Model:GetScale(),
        TargetUserId = a3,
    }
    if a3 == LocalPlayer.UserId then
        playPickupSound()
    end
end

local function onSky(a1) -- Line: 685 -- upvalues: u75 (ref)
    u75 = if type(a1) ~= "number" then nil else a1
end

local function stepAbsorbs(a1) -- Line: 689
    -- upvalues: u71 (val), FallenPowerUp (val), Players (val), Player (val)
    local PlayerByUserId, Position, v1, v2, v3
    local v4 = nil
    local v5 = nil
    for i, j in u71, v4, v5 do
        if i.Parent ~= nil then
            v2 = (a1 - j.StartedAt) / FallenPowerUp.AbsorbSeconds
            if not (v2 >= 1) then
                PlayerByUserId = Players:GetPlayerByUserId(j.TargetUserId)
                v3 = if PlayerByUserId == nil then nil else Player.FindRootPart(PlayerByUserId)
                Position = if v3 == nil then j.From else if not v3:IsA("BasePart") then j.From else v3.Position
                v3 = v2 * v2
                v1 = CFrame.new((j.From:Lerp(Position, v3)))
                i:PivotTo(v1)
                v1 = math.max(j.Scale * (1 - 0.92 * v2), 0.05)
                i:ScaleTo(v1)
            else
                u71[i] = nil
                i:Destroy()
            end
        else
            u71[i] = nil
        end
    end
end

local function stepItems(a1, a2) -- Line: 710
    -- upvalues: Workspace (val), Player (val), LocalPlayer (val), u69 (ref), FallenPowerUp (val), u70 (val), u75 (ref)
    -- upvalues: LightVsDarknessEventFlags (val), playImpact (val), playShockwave (val), buildBeacon (val)
    -- upvalues: playLandSound (val), playLandShake (val), Remotes (val)
    local CurrentCamera, FallSeconds, Fx, Fx_2, Fx_3, Head, HeadPixelMin, Head_2, Item, LandAt, Mark, Mark_2, Ring, Y, v1, v2, v3, v4, v5, v6, v7
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v8 = Player.FindPrimaryPart(LocalPlayer)
    local v9 = u69
    local v10 = 1 - math.exp(-FallenPowerUp.SkyLiftResponse * a2)
    local v11 = nil
    local v12 = nil
    local v13 = a1
    for i, j in u70, v11, v12 do
        Item = j.Item
        LandAt = Item.LandAt
        v3 = u75
        Y = if v3 == nil then Item.Y else if not LightVsDarknessEventFlags.PowerUpSkyLiftEnabled:Get() then Item.Y else v3
        if not (ServerTimeNow < LandAt) then
            if not j.Landed then
                j.Landed = true
                j.ShrinkAt = v13
                j.BaseY = Y
                v1 = Vector3.new(Item.X, Y, Item.Z)
                Fx_2 = j.Fx
                if Fx_2 ~= nil then
                    j.Fx = nil
                    Fx_2:Destroy()
                end
                Mark_2 = j.Mark
                if Mark_2 ~= nil then
                    j.Mark = nil
                    j.Ring = nil
                    Mark_2:Destroy()
                end
                Head_2 = j.Head
                if Head_2 ~= nil then
                    j.Head = nil
                    Head_2:Destroy()
                end
                v3 = FallenPowerUp.KindById(Item.Kind)
                if v3 ~= nil then
                    playImpact(v1, v3.Color)
                    v4 = LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get() and LightVsDarknessEventFlags.PowerUpDropPunchEnabled:Get()
                    if v4 then
                        playShockwave(v1, v3.Color)
                    end
                    if LightVsDarknessEventFlags.PowerUpDropVfxEnabled:Get() then
                        buildBeacon(j, v1, v3.Color)
                    end
                end
                if LightVsDarknessEventFlags.PowerUpDropSoundsEnabled:Get() then
                    playLandSound(v1)
                end
                playLandShake(v1)
            end
            v3 = v13 - j.ShrinkAt
            if not (v3 < FallenPowerUp.LandScaleSeconds) then
                if (j.Model:GetScale()) ~= j.Scale then
                    j.Model:ScaleTo(j.Scale)
                end
            elseif j.Flight ~= j.Scale then
                v4 = v3 / FallenPowerUp.LandScaleSeconds
                j.Model:ScaleTo(j.Flight + (j.Scale - j.Flight) * v4)
            elseif (j.Model:GetScale()) ~= j.Scale then
                j.Model:ScaleTo(j.Scale)
            end
            j.BaseY = j.BaseY + (Y - j.BaseY) * v10
            v3 = Vector3.new(Item.X, j.BaseY, Item.Z)
            v2 = (math.sin(v13 * FallenPowerUp.BobSpeed + i)) * FallenPowerUp.BobStuds
            j.Model:PivotTo((CFrame.new(v3 + Vector3.new(0, j.Rest + v2, 0))) * (CFrame.Angles(0, v13 * FallenPowerUp.SpinSpeed, 0)))
            Fx_3 = j.Fx
            if Fx_3 ~= nil then
                Fx_3.CFrame = CFrame.new(v3)
            end
            if v9 ~= nil
                and v8 ~= nil
                and FallenPowerUp.PickupRetrySeconds < v13 - j.AskedAt
                and (v8.Position - v3).Magnitude <= FallenPowerUp.PickupRadiusStuds then
                j.AskedAt = v13
                Remotes.LightVsDarkness.AskCollectPowerUp:FireServer(v9, i)
            end
        else
            j.BaseY = Y
            FallSeconds = Item.FallSeconds or LightVsDarknessEventFlags.PowerUpFallSeconds:Get()
            v4 = math.clamp(1 - (LandAt - ServerTimeNow) / FallSeconds, 0, 1)
            v3 = Vector3.new(Item.X, Y, Item.Z)
            v5 = j.Start:Lerp(v3, v4 ^ FallenPowerUp.FallEase)
            j.Model:PivotTo((CFrame.new(v5)) * (CFrame.Angles(0, v13 * FallenPowerUp.SpinSpeed, 0)))
            Fx = j.Fx
            if Fx ~= nil and 0.5 < (v3 - v5).Magnitude then
                Fx.CFrame = CFrame.lookAt(v5, v3)
            end
            Head = j.Head
            if Head ~= nil then
                CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera ~= nil then
                    v7 = math.max((CurrentCamera.CFrame.Position - v5).Magnitude, 1)
                    HeadPixelMin = math.clamp(
                        FallenPowerUp.HeadPixelRef * LightVsDarknessEventFlags.PowerUpCometScale:Get() / v7,
                        FallenPowerUp.HeadPixelMin,
                        FallenPowerUp.HeadPixelMax
                    )
                else
                    HeadPixelMin = FallenPowerUp.HeadPixelMin
                end
                Head.Size = UDim2.fromOffset(HeadPixelMin, HeadPixelMin)
            end
            Mark = j.Mark
            Ring = j.Ring
            if Mark ~= nil then
                v6 = FallenPowerUp.MarkerStartStuds + (FallenPowerUp.MarkerEndStuds - FallenPowerUp.MarkerStartStuds) * v4
                Mark.Size = Vector3.new(v6, FallenPowerUp.MarkerThickStuds, v6)
                Mark.CFrame = CFrame.new(Item.X, Y + FallenPowerUp.MarkerLiftStuds, Item.Z)
            end
            if Ring ~= nil then
                Ring.Transparency = 0.5 - math.abs((math.sin(v13 * FallenPowerUp.MarkerPulseSpeed))) * 0.35
            end
        end
    end
end

local function activeKinds(a1, a2) -- Line: 809 -- upvalues: FallenPowerUp (val) -- types: a1: userdata, a2: number
    local v1 = {}
    for i, j in FallenPowerUp.KindList do
        if a2 < FallenPowerUp.ActiveUntil(a1, j) then
            table.insert(v1, j)
        end
    end
    return v1
end

local function destroyAuraKind(a1) -- Line: 819 -- types: a1: table
    if a1.Clone ~= nil then
        a1.Clone:Destroy()
    end
    a1.Attachment:Destroy()
end

local function destroyAura(a1) -- Line: 826 -- upvalues: u72 (val) -- types: a1: userdata
    local v1 = u72[a1]
    if v1 == nil then
        return
    end
    u72[a1] = nil
    local v2 = nil
    local v3 = nil
    for i, j in v1.ByKind, v2, v3 do
        if j.Clone ~= nil then
            j.Clone:Destroy()
        end
        j.Attachment:Destroy()
    end
end

local function buildAuraKind(a1, a2) -- Line: 837
    -- upvalues: FallenPowerUp (val), stripModel (val), itemsFolder (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = ("PowerUpAura%*"):format(a1.Id)
    Attachment.Parent = a2
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Color = ColorSequence.new(a1.Color)
    ParticleEmitter.LightEmission = 0.65
    ParticleEmitter.Lifetime = NumberRange.new(0.55, 0.9)
    ParticleEmitter.Rate = 16
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.RotSpeed = NumberRange.new(-40, 40)
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), (NumberSequenceKeypoint.new(1, 0))})
    ParticleEmitter.Speed = NumberRange.new(1.5, 3)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), (NumberSequenceKeypoint.new(1, 1))})
    ParticleEmitter.Parent = Attachment
    local v1 = nil
    local v2 = FallenPowerUp.ModelFor(a1.Id)
    if v2 ~= nil then
        local v3 = v2:Clone()
        stripModel(v3)
        v3.Name = ("PowerUpHalo%*"):format(a1.Id)
        v3:ScaleTo((v3:GetScale()) * FallenPowerUp.HeadCloneScale)
        v3.Parent = itemsFolder()
        v1 = v3
    end
    return {Clone = v1, Emitter = ParticleEmitter, Attachment = Attachment}
end

local function syncAuras(a1) -- Line: 879
    -- upvalues: Players (val), Player (val), activeKinds (val), u72 (val), FallenPowerUp (val), buildAuraKind (val)
    local Character, v1, v2, v3, v4, v5, v6, v7, v8
    for i, j in Players:GetPlayers() do
        Character = j.Character
        v6 = Player.FindRootPart(j)
        v7 = if Character == nil then {} else if v6 == nil then {} else if not v6:IsA("BasePart") then {} else activeKinds(j, a1)
        v8 = u72[j]
        if #v7 ~= 0 then
            if v8 ~= nil then
                if v8.Character ~= Character then
                    v1 = u72[j]
                    if v1 ~= nil then
                        u72[j] = nil
                        v3 = nil
                        v4 = nil
                        for k, n in v1.ByKind, v3, v4 do
                            if n.Clone ~= nil then
                                n.Clone:Destroy()
                            end
                            n.Attachment:Destroy()
                        end
                    end
                    v8 = nil
                elseif v8.Root.Parent == nil then
                    v1 = u72[j]
                    if v1 ~= nil then
                        u72[j] = nil
                        v3 = nil
                        v4 = nil
                        for m, i5 in v1.ByKind, v3, v4 do
                            if i5.Clone ~= nil then
                                i5.Clone:Destroy()
                            end
                            i5.Attachment:Destroy()
                        end
                    end
                    v8 = nil
                end
            end
            if v8 == nil then
                u72[j] = {Character = Character, Root = v6, ByKind = {}}
            end
            v6 = {}
            for i6, i7 in v7 do
                v6[i7] = true
                if v8.ByKind[i7] == nil then
                    v5 = FallenPowerUp.KindById(i7)
                    if v5 ~= nil then
                        v8.ByKind[i7] = (buildAuraKind(v5, v8.Root))
                    end
                end
            end
            v2 = nil
            v3 = nil
            for i8, i9 in v8.ByKind, v2, v3 do
                if not v6[i8] then
                    v8.ByKind[i8] = nil
                    if i9.Clone ~= nil then
                        i9.Clone:Destroy()
                    end
                    i9.Attachment:Destroy()
                end
            end
        elseif v8 ~= nil then
            v1 = u72[j]
            if v1 ~= nil then
                u72[j] = nil
                v3 = nil
                v4 = nil
                for i10, i11 in v1.ByKind, v3, v4 do
                    if i11.Clone ~= nil then
                        i11.Clone:Destroy()
                    end
                    i11.Attachment:Destroy()
                end
            end
        end
    end
    local v9 = nil
    local v10 = nil
    for i12 in u72, v9, v10 do
        if i12.Parent == nil then
            v5 = u72[i12]
            if v5 ~= nil then
                u72[i12] = nil
                v7 = nil
                v8 = nil
                for i13, i14 in v5.ByKind, v7, v8 do
                    if i14.Clone ~= nil then
                        i14.Clone:Destroy()
                    end
                    i14.Attachment:Destroy()
                end
            end
        end
    end
end

local function stepAuras(a1) -- Line: 929 -- upvalues: u72 (val), FallenPowerUp (val) -- types: a1: number
    local Clone, Root, v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in u72, v5, v6 do
        Root = j.Root
        if Root.Parent ~= nil then
            v3 = {}
            for k, n in j.ByKind do
                table.insert(v3, {Kind = k, AuraKind = n})
            end
            table.sort(v3, function(a1, a2) -- Line: 939 -- upvalues: FallenPowerUp (upval)
                local v1 = FallenPowerUp.KindById(a1.Kind)
                local v2 = FallenPowerUp.KindById(a2.Kind)
                return (if not v1 then 0 else v1.Order) < (if not v2 then 0 else v2.Order)
            end)
            v4 = #v3
            for m, i5 in v3 do
                Clone = i5.AuraKind.Clone
                if Clone ~= nil and Clone.Parent ~= nil then
                    v1 = (m - (v4 + 1) / 2) * FallenPowerUp.HeadCloneGapStuds
                    v2 = (math.sin(v7 * FallenPowerUp.BobSpeed + m)) * FallenPowerUp.HeadCloneBobStuds
                    Clone:PivotTo((CFrame.new(Root.Position + Vector3.new(0, FallenPowerUp.HeadCloneHoverStuds + v2, 0) + Root.CFrame.RightVector * v1)) * (CFrame.Angles(0, v7 * FallenPowerUp.HeadCloneSpinSpeed, 0)))
                end
            end
        end
    end
end

local function step() -- Line: 963
    -- upvalues: u76 (ref), Workspace (val), stepItems (val), stepAbsorbs (val), stepAuras (val), u74 (ref)
    -- upvalues: syncAuras (val)
    local v1 = os.clock()
    local v2 = math.clamp(v1 - u76, 0, 0.25)
    u76 = v1
    local ServerTimeNow = Workspace:GetServerTimeNow()
    stepItems(v1, v2)
    stepAbsorbs(v1)
    stepAuras(v1)
    if 0.2 <= v1 - u74 then
        u74 = v1
        syncAuras(ServerTimeNow)
    end
end

local function start() -- Line: 977
    -- upvalues: u68 (val), u74 (ref), u75 (ref), u76 (ref), Remotes (val), onDropped (val), onCleared (val)
    -- upvalues: onCollected (val), onSky (val), RunService (val), step (val), u69 (ref), u70 (val), u71 (val)
    -- upvalues: u72 (val), adoptBatch (val)
    u68:Clean()
    u74 = 0
    u75 = nil
    os.clock()
    u68:Connect(Remotes.LightVsDarkness.PowerUpsDropped.OnClientEvent, onDropped)
    u68:Connect(Remotes.LightVsDarkness.PowerUpsCleared.OnClientEvent, onCleared)
    u68:Connect(Remotes.LightVsDarkness.PowerUpCollected.OnClientEvent, onCollected)
    u68:Connect(Remotes.LightVsDarkness.PowerUpsSky.OnClientEvent, onSky)
    u68:Connect(RunService.Heartbeat, step)
    u68:Add(function() -- Line: 987 -- upvalues: u69 (upval), u70 (upval), u75 (upval), u71 (upval), u72 (upval)
        local Fx, Head, Mark, v1, v2, v3
        u69 = nil
        local v4 = nil
        local v5 = nil
        for i in u70, v4, v5 do
            v1 = u70[i]
            if v1 ~= nil then
                u70[i] = nil
                Fx = v1.Fx
                if Fx ~= nil then
                    v1.Fx = nil
                    Fx:Destroy()
                end
                Mark = v1.Mark
                if Mark ~= nil then
                    v1.Mark = nil
                    v1.Ring = nil
                    Mark:Destroy()
                end
                Head = v1.Head
                if Head ~= nil then
                    v1.Head = nil
                    Head:Destroy()
                end
                v1.Model:Destroy()
            end
        end
        table.clear(u70)
        u75 = nil
        for j in u71 do
            j:Destroy()
        end
        table.clear(u71)
        v4 = nil
        v5 = nil
        for k in u72, v4, v5 do
            v1 = u72[k]
            if v1 ~= nil then
                u72[k] = nil
                v2 = nil
                v3 = nil
                for n, m in v1.ByKind, v2, v3 do
                    if m.Clone ~= nil then
                        m.Clone:Destroy()
                    end
                    m.Attachment:Destroy()
                end
            end
        end
    end)
    u68:Add((task.spawn(function() -- Line: 999 -- upvalues: Remotes (upval), u75 (upval), u69 (upval), adoptBatch (upval)
        local v1, v2, v3 = Remotes.LightVsDarkness.FetchPowerUps:InvokeServer()
        u75 = if type(v3) ~= "number" then nil else v3
        if type(v1) == "number" and type(v2) == "table" and u69 == nil then
            adoptBatch(v1, v2)
        end
    end)))
end

local function stop() -- Line: 1008 -- upvalues: u68 (val)
    u68:Clean()
end

return function(a1) -- Line: 1014 -- upvalues: start (val), stop (val)
    return {Start = start, Stop = stop}
end