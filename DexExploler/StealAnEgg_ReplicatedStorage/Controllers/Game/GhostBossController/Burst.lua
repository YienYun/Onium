-- Script path: ReplicatedStorage.Controllers.Game.GhostBossController.Burst
-- Decompile time: 14.75 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local GhostBoss = require(ReplicatedStorage.Shared.Util.GhostBoss)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local u57 = Color3.fromRGB(80, 255, 210)
local u62 = Color3.fromRGB(70, 255, 120)
local u67 = Color3.fromRGB(200, 255, 240)
local u72 = Color3.new(1, 1, 1)
local Quint = Enum.EasingStyle.Quint
local u74 = {SurfaceAppearance = true, SpecialMesh = true, Decal = true, Texture = true}
local u76 = Random.new()
local v1 = {RuptureSeconds = 0.36}

local function sound(...) -- Line: 68 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    for i, j in {...} do
        Assets = if not Assets then nil else Assets:FindFirstChild(j)
    end
    if Assets and Assets:IsA("Sound") then
        return Assets
    end
    return nil
end

local function ghostSound(a1) -- Line: 76 -- upvalues: ReplicatedStorage (val), GhostBoss (val) -- types: a1: string
    local v1 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local Sounds = v1 and v1:FindFirstChild("Sounds")
    v1 = Sounds and Sounds:FindFirstChild(a1)
    if v1 and v1:IsA("Sound") then
        return v1
    end
    return nil
end

local function play(a1, a2, a3, a4) -- Line: 83
    -- upvalues: Audio (val)
    if a1 then
        Audio.Play(a1, a2, {MaxDistance = 320, Volume = a3, PlaybackSpeed = a4})
    end
end

local function templates(...) -- Line: 89 -- upvalues: ReplicatedStorage (val), GhostBoss (val)
    local v1 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local VFX = v1 and v1:FindFirstChild("VFX")
    for i, j in {...} do
        VFX = if not VFX then nil else VFX:FindFirstChild(j)
    end
    v1 = {}
    if VFX == nil then
        return v1
    end
    for k, n in VFX:GetDescendants() do
        if n:IsA("ParticleEmitter") then
            table.insert(v1, n)
        end
    end
    return v1
end

local function debrisFolder() -- Line: 107 -- upvalues: Workspace (val)
    return Workspace:FindFirstChild("Transient") or Workspace
end

local function shell(a1, a2, a3) -- Line: 111 -- types: a1: string, a3: CFrame
    local Part = Instance.new("Part")
    Part.Name = a1
    Part.Shape = a2
    Part.Material = Enum.Material.Neon
    Part.Color = a3
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Locked = true
    return Part
end

local function expand(a1, a2, a3, a4, a5) -- Line: 126
    -- upvalues: Workspace (val), TweenService (val), VFX (val)
    a1.Transparency = a4
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    a1.Parent = Transient
    TweenService:Create(a1, TweenInfo.new(a3, a5, Enum.EasingDirection.Out), {Transparency = 1, Size = a2}):Play()
    VFX.Discard(a1, a3 + 0.1)
end

local function ring(a1, a2, a3, a4, a5) -- Line: 142
    -- upvalues: u57 (val), Quint (val), TweenService (val), Workspace (val), VFX (val)
    local Decal
    local Block = Enum.PartType.Block
    local v1 = u57
    local v2 = Instance.new("Part")
    v2.Name = "GhostBossShockwave"
    v2.Shape = Block
    v2.Material = Enum.Material.Neon
    v2.Color = v1
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Locked = true
    v2.Size = Vector3.new(a2, 0.05, a2)
    v2.CFrame = CFrame.new(a1) * a5
    v2.Transparency = 1
    local v3 = TweenInfo.new(a4, Quint, Enum.EasingDirection.Out)
    for i, j in {Enum.NormalId.Top, Enum.NormalId.Bottom} do
        Decal = Instance.new("Decal")
        Decal.Texture = "rbxassetid://109600784699514"
        Decal.Color3 = u57
        Decal.Face = j
        Decal.Transparency = 0
        Decal.Parent = v2
        TweenService:Create(Decal, v3, {Transparency = 1}):Play()
    end
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    v2.Parent = Transient
    TweenService:Create(v2, v3, {Size = Vector3.new(a3, 0.05, a3)}):Play()
    VFX.Discard(v2, a4 + 0.1)
end

local function light(a1, a2, a3, a4, a5) -- Line: 162
    -- upvalues: Workspace (val), u57 (val), TweenService (val), VFX (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "GhostBossFlashLight"
    Attachment.WorldPosition = a1
    Attachment.Parent = Workspace.Terrain
    local PointLight = Instance.new("PointLight")
    PointLight.Color = a5 or u57
    PointLight.Brightness = a2
    PointLight.Range = a3
    PointLight.Shadows = false
    PointLight.Parent = Attachment
    TweenService:Create(PointLight, TweenInfo.new(a4, Enum.EasingStyle.Quad), {Brightness = 0, Range = a3 * 0.3}):Play()
    VFX.Discard(Attachment, a4 + 0.1)
end

local function nearness(a1) -- Line: 186 -- upvalues: Workspace (val) -- types: a1: vector
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return 0
    end
    return (math.clamp(1 - (CurrentCamera.CFrame.Position - a1).Magnitude / 220, 0, 1))
end

local function shardOf(a1) -- Line: 195 -- upvalues: u74 (val) -- types: a1: userdata
    local Archivable = a1.Archivable
    a1.Archivable = true
    local v1 = a1:Clone()
    a1.Archivable = Archivable
    if v1 == nil then
        return nil
    end
    for i, j in v1:GetChildren() do
        if not u74[j.ClassName] then
            j:Destroy()
        end
    end
    v1.Name = "GhostBossShard"
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    v1.Massless = true
    v1.LocalTransparencyModifier = 0
    return v1
end

local function flatDirection(a1) -- Line: 219 -- upvalues: u76 (val) -- types: a1: vector
    local v1 = Vector3.new(a1.X, 0, a1.Z)
    if 0.1 < v1.Magnitude then
        return v1.Unit
    end
    v1 = u76:NextNumber(0, 6.283185307179586)
    return (Vector3.new(math.cos(v1), 0, (math.sin(v1))))
end

function v1.Rupture(a1) -- Line: 232
    -- upvalues: Workspace (val), VFX (val), templates (val), u67 (val), TweenService (val), ReplicatedStorage (val)
    -- upvalues: GhostBoss (val), Audio (val), sound (val), GuiService (val), Shake (val)
    local Part = Instance.new("Part")
    Part.Name = "GhostBossRuptureGather"
    Part.Shape = Enum.PartType.Ball
    Part.Size = Vector3.new(18, 18, 18)
    Part.CFrame = CFrame.new(a1)
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Locked = true
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    Part.Parent = Transient
    VFX.EmitAt(Part, templates("Death", "Rupture", "Gather"))
    VFX.Discard(Part, 0.96)
    VFX.EmitAt(a1, templates("Death", "Rupture", "Core"))
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "GhostBossRuptureLight"
    Attachment.WorldPosition = a1
    Attachment.Parent = Workspace.Terrain
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u67
    PointLight.Brightness = 0
    PointLight.Range = 24
    PointLight.Shadows = false
    PointLight.Parent = Attachment
    TweenService:Create(PointLight, TweenInfo.new(0.36, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Brightness = 12, Range = 44}):Play()
    VFX.Discard(Attachment, 0.41)
    local v1 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local v2 = v1 and v1:FindFirstChild("Sounds")
    v1 = v2 and v2:FindFirstChild("Hurt1")
    local v3 = if not v1 then nil else if not v1:IsA("Sound") then nil else v1
    if v3 then
        Audio.Play(v3, a1, {Volume = 1, PlaybackSpeed = 0.85, MaxDistance = 320})
    end
    v3 = sound("Sounds", "LightVsDarknessSounds", "CollectChargedRing")
    if v3 then
        Audio.Play(v3, a1, {Volume = 0.5, PlaybackSpeed = 0.6, MaxDistance = 320})
    end
    if not GuiService.ReducedMotionEnabled then
        Shake.Play({
            Seconds = 0.36,
            Magnitude = 0.45,
            Shape = "Pulse",
            Range = {Near = 30, Far = 160, Center = a1},
        })
    end
end

function v1.Shatter(a1, a2, a3) -- Line: 280
    -- upvalues: Trove (val), u72 (val), u57 (val), shardOf (val), u76 (val), Workspace (val), RunService (val)
    -- upvalues: TweenService (val), u62 (val)
    local Unit, v1, v2, v3, v4, v5
    local u146 = Trove.new()
    local v6 = u146:Add((Instance.new("Model")))
    v6.Name = "GhostBossShards"
    local Highlight = Instance.new("Highlight")
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.FillColor = u72
    Highlight.FillTransparency = 0
    Highlight.OutlineColor = u57
    Highlight.OutlineTransparency = 0
    Highlight.Parent = v6
    local u123 = {}
    for i, j in a1:GetDescendants() do
        if #u123 >= 12 then
            break
        end
        if j:IsA("BasePart") and not (1 <= j.Transparency) then
            v1 = shardOf(j)
            if v1 ~= nil then
                v2 = j.Position - a2
                v3 = Vector3.new(0, 1, 0) * u76:NextNumber(0, 0.6)
                v4 = {
                    Part = v1,
                    Offset = v2,
                    Rotation = j.CFrame.Rotation,
                    Size = j.Size,
                    Transparency = v1.Transparency,
                }
                v5 = Vector3.new(v2.X, 0, v2.Z)
                if not (0.1 < v5.Magnitude) then
                    v5 = u76:NextNumber(0, 6.283185307179586)
                    Unit = Vector3.new(math.cos(v5), 0, (math.sin(v5)))
                else
                    Unit = v5.Unit
                end
                v4.Travel = (Unit + v3).Unit * u76:NextNumber(7, 15) * a3
                v4.Axis = u76:NextUnitVector()
                v4.Spin = (u76:NextNumber(3, 7)) * (if not ((u76:NextNumber()) < 0.5) then 1 else -1)
                table.insert(u123, v4)
                v1.Parent = v6
            end
        end
    end
    if #u123 == 0 then
        u146:Destroy()
        return
    end
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    v6.Parent = Transient
    local u161 = (os.clock())
    u146:Connect(RunService.RenderStepped, function() -- Line: 328
        -- upvalues: u161 (val), u146 (val), TweenService (upval), Highlight (val), u72 (upval), u62 (upval), u123 (val)
        -- upvalues: a2 (val), a3 (val)
        local v1
        local v2 = (os.clock() - u161) / 0.62
        if v2 >= 1 then
            u146:Destroy()
            return
        end
        local Value = TweenService:GetValue(v2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local v3 = 1 - TweenService:GetValue(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        Highlight.FillColor = u72:Lerp(u62, (math.min(v2 * 2, 1)))
        Highlight.FillTransparency = v2 * 0.6
        Highlight.OutlineTransparency = v2
        for i, j in u123 do
            v1 = a2 + j.Offset * (1 + 0.3 * Value) + j.Travel * Value + Vector3.new(0, 3, 0) * a3 * Value
            j.Part.Size = j.Size * math.max(v3, 0.01)
            j.Part.Transparency = j.Transparency + (1 - j.Transparency) * v2 ^ 3
            j.Part.CFrame = (CFrame.new(v1)) * CFrame.fromAxisAngle(j.Axis, j.Spin * Value) * j.Rotation
        end
    end)
    task.delay(1.12, function() -- Line: 352 -- upvalues: u146 (val)
        u146:Destroy()
    end)
end

function v1.Explode(a1, a2) -- Line: 357
    -- upvalues: u67 (val), expand (val), Quint (val), u62 (val), ring (val), light (val), VFX (val), templates (val)
    -- upvalues: sound (val), Audio (val), ReplicatedStorage (val), GhostBoss (val), Workspace (val), Flash (val)
    -- upvalues: u57 (val), GuiService (val), Shake (val)
    local Ball = Enum.PartType.Ball
    local v1 = u67
    local v2 = Instance.new("Part")
    v2.Name = "GhostBossCore"
    v2.Shape = Ball
    v2.Material = Enum.Material.Neon
    v2.Color = v1
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Locked = true
    v2.Size = Vector3.new(2, 2, 2)
    v2.CFrame = CFrame.new(a1)
    expand(v2, Vector3.new(30, 30, 30), 0.5, 0, Quint)
    local Ball_2 = Enum.PartType.Ball
    v1 = u62
    v2 = Instance.new("Part")
    v2.Name = "GhostBossAura"
    v2.Shape = Ball_2
    v2.Material = Enum.Material.Neon
    v2.Color = v1
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Locked = true
    v2.Size = Vector3.new(4, 4, 4)
    v2.CFrame = CFrame.new(a1)
    expand(v2, Vector3.new(52, 52, 52), 0.9, 0.35, Enum.EasingStyle.Cubic)
    ring(a1, 4, 84, 0.8, CFrame.identity)
    ring(a1, 3, 58, 0.65, CFrame.Angles(1.2217304763960306, 0, 0.3490658503988659))
    ring(a1, 3, 50, 0.6, CFrame.Angles(-1.0471975511965976, 0, -0.6108652381980153))
    light(a1, 16, 70, 1.1)
    VFX.EmitAt(a1, templates("Explosion"))
    VFX.EmitAt(a1, templates("Death", "Burst"))
    v2 = (a2 or a1 - Vector3.new(0, 3, 0)) + Vector3.new(0, 0.3499999940395355, 0)
    ring(v2, 6, 120, 1.1, CFrame.identity)
    task.delay(0.12, ring, v2, 4, 72, 0.95, CFrame.identity)
    VFX.EmitAt(v2 + Vector3.new(0, 0.20000000298023224, 0), templates("Death", "Ground"))
    light(v2 + Vector3.new(0, 5, 0), 9, 80, 2.4, u62)
    local v3 = sound("Sounds", "CinematicBoom")
    if v3 then
        Audio.Play(v3, a1, {Volume = 1, PlaybackSpeed = 1, MaxDistance = 320})
    end
    v3 = sound("Sounds", "ImpactBoom")
    if v3 then
        Audio.Play(v3, a1, {Volume = 0.7, PlaybackSpeed = 0.85, MaxDistance = 320})
    end
    v3 = sound("Sounds", "ScrambleBoss", "Pop")
    if v3 then
        Audio.Play(v3, a1, {Volume = 0.6, PlaybackSpeed = 1.2, MaxDistance = 320})
    end
    v2 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local Sounds = v2 and v2:FindFirstChild("Sounds")
    v2 = Sounds and Sounds:FindFirstChild("Swing")
    v3 = if not v2 then nil else if not v2:IsA("Sound") then nil else v2
    if v3 then
        Audio.Play(v3, a1, {Volume = 0.7, PlaybackSpeed = 1.3, MaxDistance = 320})
    end
    local CurrentCamera = Workspace.CurrentCamera
    v3 = if CurrentCamera ~= nil then math.clamp(1 - (CurrentCamera.CFrame.Position - a1).Magnitude / 220, 0, 1) else 0
    if v3 > 0 then
        Flash.Play({Attack = 0.03, Decay = 0.8, Tint = u57, Opacity = v3 * 0.55})
    end
    if not GuiService.ReducedMotionEnabled then
        Shake.Play({Seconds = 1.1, Magnitude = 1.8, Shape = "Fade", Range = {Near = 35, Far = 200, Center = a1}})
    end
end

function v1.SpawnPuff(a1) -- Line: 400
    -- upvalues: ring (val), light (val), VFX (val), templates (val), sound (val), Audio (val), GuiService (val)
    -- upvalues: Shake (val)
    ring(a1 + Vector3.new(0, 0.5, 0), 4, 48, 0.9, CFrame.identity)
    light(a1 + Vector3.new(0, 6, 0), 8, 40, 1.4)
    VFX.EmitAt(a1 + Vector3.new(0, 1, 0), templates("Spawn"))
    local v1 = sound("Sounds", "BossEventSounds", "Boss Spawn")
    if v1 then
        Audio.Play(v1, a1, {Volume = 0.8, PlaybackSpeed = 1.1, MaxDistance = 320})
    end
    if not GuiService.ReducedMotionEnabled then
        Shake.Play({Seconds = 0.6, Magnitude = 0.6, Shape = "Pulse", Range = {Near = 40, Far = 200, Center = a1}})
    end
end

return table.freeze(v1)