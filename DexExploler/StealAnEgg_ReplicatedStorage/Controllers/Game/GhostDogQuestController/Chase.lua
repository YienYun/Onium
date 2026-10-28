-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Chase
-- Decompile time: 68.22 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local GhostDogQuestFlags = require(ReplicatedStorage.Shared.Flags.GhostDogQuestFlags)
local Cine = require(script.Parent.Cine)
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local Hud = require(script.Parent.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Swim = require(script.Parent.Swim)
require(ReplicatedStorage.Packages.Trove)
local WhaleHearts = require(ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.WhaleHearts)
local LocalPlayer = Players.LocalPlayer
local GhostDogQuest_2 = ReplicatedStorage.Assets.GhostDogQuest
local Sounds = ReplicatedStorage.Assets.Sounds
local Chase = GhostDogQuest.Chase
local u81 = {-1, 0, 1}
local Stage3 = Sounds.BeanstalkEvent.Music.Stage3
local Explosion = Sounds.Explosion
local WhaleHeartBreak = Sounds.BeanstalkEvent.WhaleHeartBreak
local WhaleNearMiss = Sounds.BeanstalkEvent.WhaleNearMiss
local Swoosh = Sounds.ScrambleBoss.Swoosh
local Shatter = Sounds.ScrambleBoss.Shatter
local u102 = Color3.fromRGB(110, 240, 255)
local u107 = Color3.fromRGB(255, 60, 70)
local u112 = Color3.fromRGB(190, 230, 255)
local u117 = Color3.fromRGB(255, 60, 80)
local v1 = {}

local function seabedPart(a1, a2, a3, a4, a5, a6) -- Line: 100
    -- upvalues: 
    local Part = Instance.new("Part")
    Part.Name = a2
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Size = a3
    Part.CFrame = a4
    Part.Color = a5
    Part.Material = a6
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Parent = a1
    return Part
end

local function buildScene(a1, a2, a3, a4) -- Line: 125
    -- upvalues: GhostDogQuest (val), u102 (val), GhostDogQuest_2 (val), Fx (val), Workspace (val)
    local Cobblestone, Grass, Neon, Neon_2, Neon_3, Neon_4, Neon_5, Sand, Slate, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17
    local v18 = a1:Add((Instance.new("Folder")))
    v18.Name = "GhostDogChaseScene"
    local v19 = Random.new(a2 * 977 + 13)
    local v20 = a3 + 22 + 300
    local v21 = 0
    for i = -40, v20, 30 do
        v2 = (GhostDogQuest.ChaseFrame(a2, i + 15)) * CFrame.new(0, -11, 0)
        v3 = v2 * CFrame.new(0, -1.5, 0)
        v4 = Color3.fromRGB(46, 66, 84)
        Sand = Enum.Material.Sand
        v1 = Instance.new("Part")
        v1.Name = "Seabed"
        v1.Anchored = true
        v1.CanCollide = false
        v1.CanQuery = false
        v1.CanTouch = false
        v1.CastShadow = false
        v1.Size = Vector3.new(84, 3, 32)
        v1.CFrame = v3
        v1.Color = v4
        v1.Material = Sand
        v1.TopSurface = Enum.SurfaceType.Smooth
        v1.BottomSurface = Enum.SurfaceType.Smooth
        v1.Parent = v18
        for j, k in {-1, 1} do
            v9 = v2 * CFrame.new(k * 15, 0.12, 0)
            v10 = u102
            Neon_5 = Enum.Material.Neon
            v8 = Instance.new("Part")
            v8.Name = "Edge"
            v8.Anchored = true
            v8.CanCollide = false
            v8.CanQuery = false
            v8.CanTouch = false
            v8.CastShadow = false
            v8.Size = Vector3.new(0.8999999761581421, 0.25, 30.5)
            v8.CFrame = v9
            v8.Color = v10
            v8.Material = Neon_5
            v8.TopSurface = Enum.SurfaceType.Smooth
            v8.BottomSurface = Enum.SurfaceType.Smooth
            v8.Parent = v18
            v8.Transparency = 0.15
        end
        v4 = v2 * CFrame.new(0, 0.12, 0)
        v5 = u102
        Neon = Enum.Material.Neon
        v3 = Instance.new("Part")
        v3.Name = "Spine"
        v3.Anchored = true
        v3.CanCollide = false
        v3.CanQuery = false
        v3.CanTouch = false
        v3.CastShadow = false
        v3.Size = Vector3.new(0.5, 0.20000000298023224, 13.5)
        v3.CFrame = v4
        v3.Color = v5
        v3.Material = Neon
        v3.TopSurface = Enum.SurfaceType.Smooth
        v3.BottomSurface = Enum.SurfaceType.Smooth
        v3.Parent = v18
        v3.Transparency = 0.55
        v4 = v2 * CFrame.new(0, 0.06, 0)
        v5 = Color3.fromRGB(40, 120, 150)
        Neon_2 = Enum.Material.Neon
        v3 = Instance.new("Part")
        v3.Name = "Track"
        v3.Anchored = true
        v3.CanCollide = false
        v3.CanQuery = false
        v3.CanTouch = false
        v3.CastShadow = false
        v3.Size = Vector3.new(30, 0.10000000149011612, 30.5)
        v3.CFrame = v4
        v3.Color = v5
        v3.Material = Neon_2
        v3.TopSurface = Enum.SurfaceType.Smooth
        v3.BottomSurface = Enum.SurfaceType.Smooth
        v3.Parent = v18
        v3.Transparency = 0.82
        v4 = {-1, 1}
        v5 = nil
        v6 = nil
        for n, m in v4, v5, v6 do
            for i5 = 1, 2 do
                v3 = v19:NextNumber(7, 18)
                v13 = Vector3.new(v3, v3 * v19:NextNumber(0.8, 1.8), v3)
                v14 = v2 * CFrame.new(m * (34 + v19:NextNumber(0, 12)), v3 * 0.35, v19:NextNumber(-15, 15)) * CFrame.Angles(v19:NextNumber(-0.5, 0.5), v19:NextNumber(0, 6), v19:NextNumber(-0.5, 0.5))
                v15 = Color3.fromRGB(38 + v19:NextInteger(0, 18), 50 + v19:NextInteger(0, 18), 72 + v19:NextInteger(0, 18))
                Slate = Enum.Material.Slate
                v12 = Instance.new("Part")
                v12.Name = "Rock"
                v12.Anchored = true
                v12.CanCollide = false
                v12.CanQuery = false
                v12.CanTouch = false
                v12.CastShadow = false
                v12.Size = v13
                v12.CFrame = v14
                v12.Color = v15
                v12.Material = Slate
                v12.TopSurface = Enum.SurfaceType.Smooth
                v12.BottomSurface = Enum.SurfaceType.Smooth
                v12.Parent = v18
                v12.Transparency = 0
            end
            v9 = v19:NextNumber()
            if v9 < 0.75 then
                v9 = v2 * CFrame.new(m * v19:NextNumber(18, 28), 0, v19:NextNumber(-12, 12))
                v10 = v19:NextInteger(4, 7)
                v11 = v19:NextNumber(-0.25, 0.25)
                v12 = v9
                for i6 = 1, v10 do
                    v16 = v12 * CFrame.new(0, 1.6, 0)
                    v17 = Color3.fromRGB(40, i6 * 8 + 120, 90)
                    Grass = Enum.Material.Grass
                    v9 = Instance.new("Part")
                    v9.Name = "Kelp"
                    v9.Anchored = true
                    v9.CanCollide = false
                    v9.CanQuery = false
                    v9.CanTouch = false
                    v9.CastShadow = false
                    v9.Size = Vector3.new(0.6000000238418579, 3.200000047683716, 1.2999999523162842)
                    v9.CFrame = v16
                    v9.Color = v17
                    v9.Material = Grass
                    v9.TopSurface = Enum.SurfaceType.Smooth
                    v9.BottomSurface = Enum.SurfaceType.Smooth
                    v9.Parent = v18
                    v9.Transparency = 0.1
                    v12 = v12 * CFrame.new(0, 3, 0) * CFrame.Angles(0, 0, v11)
                end
                v14 = Color3.fromRGB(150, 255, 200)
                Neon_3 = Enum.Material.Neon
                v11 = Instance.new("Part")
                v11.Name = "KelpGlow"
                v11.Anchored = true
                v11.CanCollide = false
                v11.CanQuery = false
                v11.CanTouch = false
                v11.CastShadow = false
                v11.Size = Vector3.new(1.2000000476837158, 1.2000000476837158, 1.2000000476837158)
                v11.CFrame = v12
                v11.Color = v14
                v11.Material = Neon_3
                v11.TopSurface = Enum.SurfaceType.Smooth
                v11.BottomSurface = Enum.SurfaceType.Smooth
                v11.Parent = v18
                v11.Shape = Enum.PartType.Ball
            end
            v9 = v19:NextNumber()
            if v9 < 0.35 then
                v10 = v2 * CFrame.new(m * v19:NextNumber(10, 16), 0.6, v19:NextNumber(-12, 12))
                v11 = if not ((v19:NextNumber()) < 0.5) then Color3.fromRGB(180, 140, 255) else Color3.fromRGB(255, 120, 220)
                Neon_4 = Enum.Material.Neon
                v9 = Instance.new("Part")
                v9.Name = "Anemone"
                v9.Anchored = true
                v9.CanCollide = false
                v9.CanQuery = false
                v9.CanTouch = false
                v9.CastShadow = false
                v9.Size = Vector3.new(2.4000000953674316, 1.600000023841858, 2.4000000953674316)
                v9.CFrame = v10
                v9.Color = v11
                v9.Material = Neon_4
                v9.TopSurface = Enum.SurfaceType.Smooth
                v9.BottomSurface = Enum.SurfaceType.Smooth
                v9.Parent = v18
                v9.Shape = Enum.PartType.Ball
                v9.Transparency = 0.2
            end
        end
        v4 = v19:NextNumber()
        if v4 < 0.18 then
            v4 = if not ((v19:NextNumber()) < 0.5) then 1 else -1
            v5 = v19:NextNumber(12, 22)
            v7 = Vector3.new(3.4, v5, 3.4)
            v8 = v2 * CFrame.new(v4 * 22, v5 * 0.5 - 1, 0) * CFrame.Angles(0, 0, v4 * v19:NextNumber(0.05, 0.25))
            v9 = Color3.fromRGB(86, 96, 110)
            Cobblestone = Enum.Material.Cobblestone
            v6 = Instance.new("Part")
            v6.Name = "Ruin"
            v6.Anchored = true
            v6.CanCollide = false
            v6.CanQuery = false
            v6.CanTouch = false
            v6.CastShadow = false
            v6.Size = v7
            v6.CFrame = v8
            v6.Color = v9
            v6.Material = Cobblestone
            v6.TopSurface = Enum.SurfaceType.Smooth
            v6.BottomSurface = Enum.SurfaceType.Smooth
            v6.Parent = v18
            v6.Transparency = 0
        end
        v21 = v21 + 1
        if v21 % 8 == 0 then
            task.wait()
        end
    end
    v21 = nil
    if a4 then
        v20 = GhostDogQuest.ChaseFrame(a2, a3 + 22)
        v19 = a1:Clone(GhostDogQuest_2.SunkenChest)
        v19:PivotTo(v20 * CFrame.new(0, -11, 0) * (CFrame.Angles(0, 3.141592653589793, 0)))
        v19.Parent = v18
        v21 = v19
    end
    local Part = Instance.new("Part")
    Part.Name = "Snow"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(60, 1, 60)
    Part.Parent = v18
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "MarineSnow"
    ParticleEmitter.Texture = Fx.Sparkle
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(190, 240, 255))
    ParticleEmitter.LightEmission = 0.6
    ParticleEmitter.Rate = 60
    ParticleEmitter.Lifetime = NumberRange.new(2, 4)
    ParticleEmitter.Speed = NumberRange.new(0.5, 2)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Size = NumberSequence.new(0.18, 0)
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.3, 0.3),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter.Parent = Part
    v18.Parent = Workspace
    return v18, v21
end

local function underwater(a1) -- Line: 307 -- upvalues: Lighting (val)
    local v1 = a1:Add((Instance.new("ColorCorrectionEffect")))
    v1.Name = "GhostDogUnderwater"
    v1.TintColor = Color3.fromRGB(150, 225, 255)
    v1.Saturation = 0.1
    v1.Contrast = 0.12
    v1.Brightness = 0.02
    v1.Parent = Lighting
    v1 = a1:Add((Instance.new("BlurEffect")))
    v1.Name = "GhostDogUnderwaterBlur"
    v1.Size = 2
    v1.Parent = Lighting
    local Atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if Atmosphere then
        local Density = Atmosphere.Density
        local Color = Atmosphere.Color
        local Decay = Atmosphere.Decay
        local Haze = Atmosphere.Haze
        Atmosphere.Density = 0.55
        Atmosphere.Color = Color3.fromRGB(40, 110, 140)
        Atmosphere.Decay = Color3.fromRGB(10, 40, 70)
        Atmosphere.Haze = 2
        a1:Add(function() -- Line: 327 -- upvalues: Atmosphere (val), Density (val), Color (val), Decay (val), Haze (val)
            Atmosphere.Density = Density
            Atmosphere.Color = Color
            Atmosphere.Decay = Decay
            Atmosphere.Haze = Haze
        end)
    end
end

local function playFish(a1, a2, a3, a4) -- Line: 336 -- types: a1: userdata, a2: string, a3: boolean, a4: number?
    local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
    local v1 = a1:FindFirstChild("Animations")
    local v2 = v1 and v1:FindFirstChild(a2)
    if Animator ~= nil and v2 ~= nil and v2:IsA("Animation") then
        v1 = Animator:LoadAnimation(v2)
        v1.Looped = a3
        v1:Play(0.15, 1, a4 or 1)
        return v1
    end
    return nil
end

local function spawnMine(a1, a2, a3, a4) -- Line: 350
    -- upvalues: GhostDogQuest_2 (val), GhostDogQuest (val), u112 (val), u107 (val)
    local v1 = GhostDogQuest_2.SeaMine:Clone()
    v1:PivotTo((GhostDogQuest.ChaseFrame(a2, a4)) * (CFrame.new(a3, 0, 0)))
    local Part = Instance.new("Part")
    Part.Name = "Tether"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Material = Enum.Material.Metal
    Part.Color = Color3.fromRGB(50, 60, 78)
    Part.Size = Vector3.new(0.3499999940395355, 9, 0.3499999940395355)
    Part.CFrame = (v1:GetPivot()) * CFrame.new(0, -6, 0)
    Part.Parent = v1
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = u112
    Highlight.FillTransparency = 0.88
    Highlight.OutlineColor = u112
    Highlight.OutlineTransparency = 0.5
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Parent = v1
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u107
    PointLight.Range = 10
    PointLight.Brightness = 0
    local Body = v1:FindFirstChild("Body") or v1.PrimaryPart
    PointLight.Parent = Body
    v1.Parent = a1
    return {
        Hit = false,
        Passed = false,
        Model = v1,
        Offset = a3,
        Distance = a4,
        Phase = math.random() * 6,
        Glow = Highlight,
        Light = PointLight,
    }
end

local function planRows(a1, a2, a3) -- Line: 390
    -- upvalues: GhostDogQuestFlags (val), u81 (val), GhostDogQuest (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = {}
    local v8 = Random.new()
    local v9 = a2 * GhostDogQuestFlags.ChaseGraceSeconds:Get()
    local v10 = a2 * GhostDogQuestFlags.ChaseMineGapSeconds:Get() * a3
    local v11 = a1 - a2 * 2.6
    local v12 = v9
    local v13 = 0
    local v14 = 0
    while v12 < v11 do
        v14 = v14 + 1
        v1 = (v12 - v9) / math.max(v11 - v9, 1)
        v2 = {}
        v3 = v8:NextNumber()
        if v1 < 0.22 then
            v2 = {u81[v8:NextInteger(1, 3)]}
        elseif not (v3 < 0.25) then
            v4 = u81[v8:NextInteger(1, 3)]
            if v4 == v13 and (v8:NextNumber()) < 0.7 then
                v4 = if v4 ~= 0 then 0 else if not ((v8:NextNumber()) < 0.5) then 1 else -1
            end
            for i, j in u81 do
                if j ~= v4 then
                    table.insert(v2, j)
                end
            end
        else
            v2 = {u81[v8:NextInteger(1, 3)]}
        end
        for k, n in v2 do
            v6 = v8:NextNumber(-2.5, 2.5)
            table.insert(v7, {
                Offset = math.clamp(GhostDogQuest.LaneOffset(n) + v6, -13, 13),
                Distance = v12,
            })
        end
        v5 = v10 * (1 - v1 * 0.25)
        v12 = v12 + v5 * (if #v2 ~= 2 then 0.9 else 1.15)
    end
    return v7
end

local function banner(a1, a2, a3, a4) -- Line: 439 -- upvalues: Fx (val) -- types: a2: string, a3: string?, a4: number?
    local Banner = a1.Chase.Banner
    Banner.Text = a2
    Banner.TextTransparency = 0
    local UIStroke = Banner:FindFirstChildOfClass("UIStroke")
    if UIStroke then
        UIStroke.Transparency = 0
    end
    local UIScale = Banner:FindFirstChildOfClass("UIScale")
    if UIScale then
        Fx.Punch(UIScale, 1.6, 0.35)
    end
    a1.Chase.Sub.Text = a3 or ""
    if a4 then
        task.delay(a4, function() -- Line: 453 -- upvalues: Banner (val), a2 (val), Fx (upval), UIStroke (val), a1 (val)
            if Banner.Text == a2 then
                Fx.Tween(Banner, 0.3, {TextTransparency = 1})
                if UIStroke then
                    Fx.Tween(UIStroke, 0.3, {Transparency = 1})
                end
                a1.Chase.Sub.Text = ""
            end
        end)
    end
end

local function popText(a1, a2, a3) -- Line: 465 -- upvalues: Fx (val) -- types: a2: string, a3: userdata
    local Pop = a1.Chase.Pop
    Pop.Text = a2
    Pop.TextColor3 = a3
    Pop.Visible = true
    Pop.TextTransparency = 0
    Pop.Rotation = math.random(-8, 8)
    local UIScale = Pop:FindFirstChildOfClass("UIScale")
    if UIScale then
        Fx.Punch(UIScale, 1.8, 0.25)
    end
    local UIStroke = Pop:FindFirstChildOfClass("UIStroke")
    if UIStroke then
        UIStroke.Transparency = 0
    end
    task.delay(0.5, function() -- Line: 480 -- upvalues: Fx (upval), Pop (val), UIStroke (val)
        Fx.Tween(Pop, 0.25, {TextTransparency = 1})
        if UIStroke then
            Fx.Tween(UIStroke, 0.25, {Transparency = 1})
        end
    end)
end

local function keysText() -- Line: 488 -- upvalues: UserInputService (val)
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        return "Hold the joystick left or right to steer"
    end
    if UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then
        return "Hold the left stick left or right to steer"
    end
    return "Hold <b>A</b> or <b>D</b> to steer"
end

local function waitForArrival(a1, a2, a3) -- Line: 498
    -- upvalues: GhostDogQuest (val), LocalPlayer (val)
    local Position = GhostDogQuest.ChaseFrame(a2, 0).Position
    local v1 = os.clock()
    local v2, v3, v4 = a3, a1, a2
    while os.clock() - v1 < v2 do
        if v3.Parent ~= nil
            and LocalPlayer:GetAttribute(GhostDogQuest.ChaseAttribute) == v4
            and (v3.Position - Position).Magnitude < 40 then
            return true
        end
        task.wait()
    end
    return false
end

function v1.Run(a1, a2, a3, a4, a5) -- Line: 511
    -- upvalues: LocalPlayer (val), Hud (val), GhostDogQuestFlags (val), buildScene (val), underwater (val)
    -- upvalues: Workspace (val), GhostDogQuest (val), Swim (val), waitForArrival (val), GhostDogQuest_2 (val)
    -- upvalues: playFish (val), Fx (val), Stage3 (val), UserInputService (val), WhaleHearts (val), planRows (val)
    -- upvalues: Cine (val), banner (val), Explosion (val), WhaleHeartBreak (val), u117 (val), popText (val)
    -- upvalues: Swoosh (val), spawnMine (val), u107 (val), u112 (val), Chase (val), WhaleNearMiss (val), Shatter (val)
    -- upvalues: Remotes (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character
    if HumanoidRootPart then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    local u2275 = Hud.Get()
    if Character ~= nil
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart")
        and Humanoid ~= nil
        and u2275 ~= nil then
        local Banner, Banner_2, Banner_3, Banner_4, Position_2, RodTip, UIScale, UIScale_2, UIScale_3, UIStroke, err, success, u1089, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24
        local v25 = false
        if a5 ~= nil then
            v25 = a5.Ending == "Catch"
        end
        local v26 = if not v25 then GhostDogQuestFlags.ChaseSeconds:Get() else GhostDogQuestFlags.FishChaseSeconds:Get()
        local u1957 = GhostDogQuestFlags.ChaseSpeed:Get()
        local u1960 = v26 * u1957
        local v27 = GhostDogQuestFlags.ChaseHearts:Get()
        local u2565, v28 = buildScene(a1, a2, u1960, not v25)
        underwater(a1)
        local Snow = u2565:FindFirstChild("Snow")
        local CurrentCamera = Workspace.CurrentCamera
        Humanoid.PlatformStand = true
        a1:Add(function() -- Line: 541 -- upvalues: Humanoid (val), HumanoidRootPart (val), CurrentCamera (val), LocalPlayer (upval)
            Humanoid.PlatformStand = false
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            CurrentCamera.CameraType = Enum.CameraType.Custom
            local Character = LocalPlayer.Character
            CurrentCamera.CameraSubject = Character and Character:FindFirstChildOfClass("Humanoid") or Humanoid
        end)
        local u96 = GhostDogQuest.ChaseFrame(a2, 0)
        local u97 = true
        a1:BindToRenderStep("GhostDogChaseHold", Enum.RenderPriority.Character.Value, function() -- Line: 552 -- upvalues: u97 (ref), HumanoidRootPart (val), u96 (ref)
            if u97 and (HumanoidRootPart.Position - u96.Position).Magnitude < 60 then
                HumanoidRootPart.CFrame = u96 * CFrame.Angles(-1.2566370614359172, 0, 0)
                HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
        end)
        if a4 then
            a4:Clean()
            Humanoid.PlatformStand = true
        end
        Swim.Start(a1, Character, "Swim")
        if not waitForArrival(HumanoidRootPart, a2, 20) then
            warn(
                "[GhostDogQuest] Chase arrival timed out",
                a2,
                HumanoidRootPart.Position,
                LocalPlayer:GetAttribute(GhostDogQuest.ChaseAttribute)
            )
            return "Aborted", nil, nil, nil
        end
        local u2300 = a1:Clone(GhostDogQuest_2.GhostFish)
        u2300:PivotTo((GhostDogQuest.ChaseFrame(a2, 30)) * (CFrame.new(0, -8.5, 0)))
        u2300.Parent = u2565
        playFish(u2300, "GhostFish_Swim", true, 1.4)
        local MouthGlow = u2300:FindFirstChild("MouthGlow", true)
        local Attachment = Instance.new("Attachment")
        Attachment.Name = "Hook"
        if MouthGlow then
            Attachment.Parent = MouthGlow
        end
        local v29 = nil
        for i, j in Character:GetChildren() do
            if j:IsA("Tool") then
                RodTip = j:FindFirstChild("RodTip", true)
                if RodTip and RodTip:IsA("Attachment") then
                    v29 = RodTip
                end
            end
        end
        local Attachment_2 = Instance.new("Attachment")
        Attachment_2.Name = "GhostDogLineHand"
        local RightHand = Character:FindFirstChild("RightHand") or Character:FindFirstChild("Right Arm") or HumanoidRootPart
        Attachment_2.Parent = RightHand
        a1:Add(Attachment_2)
        local u2245 = a1:Add((Instance.new("Beam")))
        u2245.Attachment0 = v29 or Attachment_2
        u2245.Attachment1 = Attachment
        u2245.Width0 = 0.12
        u2245.Width1 = 0.22
        u2245.LightEmission = 1
        u2245.FaceCamera = true
        u2245.Segments = 12
        u2245.Color = ColorSequence.new(Fx.Ghost, Color3.fromRGB(150, 235, 255))
        u2245.Parent = u2565
        local u1993 = Instance.new("ParticleEmitter")
        u1993.Name = "GhostDogBubbles"
        u1993.Texture = Fx.Sparkle
        u1993.Color = ColorSequence.new(Color3.fromRGB(210, 250, 255))
        u1993.Rate = 18
        u1993.Lifetime = NumberRange.new(0.6, 1.2)
        u1993.Speed = NumberRange.new(2, 5)
        u1993.Acceleration = Vector3.new(0, 6, 0)
        u1993.Size = NumberSequence.new(0.35, 0)
        u1993.SpreadAngle = Vector2.new(60, 60)
        u1993.Parent = Attachment_2
        local u1996 = a1:Add((Instance.new("Highlight")))
        u1996.FillColor = Color3.new(1, 1, 1)
        u1996.FillTransparency = 1
        u1996.OutlineTransparency = 1
        u1996.Adornee = Character
        u1996.Parent = Character
        local v30 = Fx.Play(Stage3, {Volume = 0.45, Looped = true, PlaybackSpeed = 0.92, SoundGroup = "Music"})
        if v30 then
            v30.Name = "GhostDogChaseMusic"
            a1:Add(v30)
            local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect")
            EqualizerSoundEffect.HighGain = -18
            EqualizerSoundEffect.MidGain = -4
            EqualizerSoundEffect.LowGain = 4
            EqualizerSoundEffect.Parent = v30
        end
        u2275.Chase.Visible = true
        a1:Add(function() -- Line: 633 -- upvalues: u2275 (val)
            u2275.Chase.Visible = false
        end)
        u2275.Chase.Keys.Text = if not UserInputService.TouchEnabled then if not UserInputService.GamepadEnabled then "Hold <b>A</b> or <b>D</b> to steer" else if UserInputService.KeyboardEnabled then "Hold <b>A</b> or <b>D</b> to steer" else "Hold the left stick left or right to steer" else if UserInputService.KeyboardEnabled then if not UserInputService.GamepadEnabled then "Hold <b>A</b> or <b>D</b> to steer" else if UserInputService.KeyboardEnabled then "Hold <b>A</b> or <b>D</b> to steer" else "Hold the left stick left or right to steer" else "Hold the joystick left or right to steer"
        u2275.Chase.Keys.TextTransparency = 0
        u2275.Chase.Keys.Position = UDim2.fromScale(0.5, 0.8)
        v30 = u2275.Chase.Keys:FindFirstChildOfClass("UIStroke")
        if v30 then
            v30.Transparency = 0
        end
        u2275.Chase.Lanes.Visible = false
        u2275.Chase.Progress.Position = UDim2.fromScale(0.5, 0.03)
        local Progress = u2275.Chase.Progress
        local Bar = Progress.BarHolder.BarBG.Bar
        if v25 then
            local Goal = Progress.Goal
            local Visible = Goal.Visible
            Goal.Visible = false
            a1:Add(function() -- Line: 651 -- upvalues: Goal (val), Visible (val)
                Goal.Visible = Visible
            end)
        end
        WhaleHearts.Show(a1, v27, Progress)
        local v31 = nil
        local v32 = 0
        local v33 = a1
        while v31 == nil do
            v32 = v32 + 1
            v1 = v33:Extend()
            local u1319 = {}
            local u1401 = planRows(u1960, u1957, if not (v32 >= 3) then 1 else 1.25)
            local u1385 = 1
            local u1033 = 0
            local u1244 = 0
            local u1228 = 0
            local u1302 = 0
            local u1335 = 0
            local u1194 = false
            local u1058 = (-1 / 0)
            local u1074 = 0
            local u1260 = 0
            local u1123 = false
            local u1144 = false
            Bar.Size = UDim2.fromScale(0, 1)
            Progress.Fish.Position = UDim2.fromScale(0.06, 0.48)
            u1089 = v27 + (if not (v32 >= 3) then 0 else 1)
            if v32 == 3 then
                WhaleHearts.Show(v33, u1089, Progress)
            end
            v8 = GhostDogQuest.ChaseFrame(a2, 0)
            v9 = CFrame.lookAt(v8.Position - v8.LookVector * 20 + v8.UpVector * 7, v8.Position + v8.LookVector * 18)
            if v32 ~= 1 then
                Hud.Fade(0, 0.45)
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.CameraSubject = Humanoid
                CurrentCamera.CFrame = v9
                v10 = ("Attempt %*"):format(v32)
                Banner_2 = u2275.Chase.Banner
                Banner_2.Text = "HOLD ON TIGHT!"
                Banner_2.TextTransparency = 0
                UIStroke = Banner_2:FindFirstChildOfClass("UIStroke")
                if UIStroke then
                    UIStroke.Transparency = 0
                end
                UIScale = Banner_2:FindFirstChildOfClass("UIScale")
                if UIScale then
                    Fx.Punch(UIScale, 1.6, 0.35)
                end
                u2275.Chase.Sub.Text = v10 or ""
                task.wait(0.8)
            else
                task.spawn(function() -- Line: 693 -- upvalues: Hud (upval)
                    Hud.Fade(0, 0.6)
                    local v1 = Hud.FadeFrame()
                    if v1 then
                        v1.BackgroundColor3 = Color3.new(0, 0, 0)
                    end
                end)
                Hud.Bubbles(1.2, 50)
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                v10 = v8.Position - v8.LookVector * 4 + v8.RightVector * 5 + v8.UpVector * 1.5
                v11 = v8.Position + v8.RightVector * 11 + v8.UpVector * 5 - v8.LookVector * 3
                v12 = v8.Position - v8.LookVector * 22 + v8.UpVector * 11 + v8.RightVector * 6
                Position_2 = GhostDogQuest.ChaseFrame(a2, 30).Position
                v14 = v8.Position + v8.LookVector * 18
                v15 = Cine.SpeedLens(0.25, 18)
                v16 = Cine.RestingFov()
                Fx.Play(GhostDogQuest.Sounds.Surfaced, {Volume = 0.8})
                local u570 = Fx.Play(GhostDogQuest.Sounds.UnderwaterDrone, {Volume = 0, Looped = true})
                if u570 then
                    u570.Name = "GhostDogUnderwaterDrone"
                    Fx.Tween(u570, 1.2, {Volume = 0.8})
                    v33:Add(function() -- Line: 724 -- upvalues: u570 (val), Fx (upval)
                        if u570.Parent == nil then
                            return
                        end
                        Fx.Tween(u570, 0.6, {Volume = 0})
                        task.delay(0.6, function() -- Line: 729 -- upvalues: u570 (upval)
                            u570:Destroy()
                        end)
                    end)
                end
                v17 = os.clock()
                v18 = false
                while true do
                    v19 = os.clock()
                    v20 = math.min((v19 - v17) / 2.1, 1)
                    v21 = Fx.Ease(v20, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    v22 = 1 - v21
                    v23 = v10 * (v22 * v22 * v22) + v11 * (3 * v22 * v22 * v21) + v12 * (3 * v22 * v21 * v21) + v9.Position * (v21 * v21 * v21)
                    v22 = Fx.Ease(math.clamp((v20 - 0.2) / 0.35, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    v21 = Fx.Ease(math.clamp((v20 - 0.55) / 0.45, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    CurrentCamera.CFrame = CFrame.lookAt(v23, ((HumanoidRootPart.Position:Lerp(Position_2, v22)):Lerp(v14, v21)))
                    CurrentCamera.FieldOfView = v15(v23, v19 - v17, v16)
                    if not v18 and v20 >= 0.35 then
                        Fx.Play(GhostDogQuest.Sounds.GrowlShort, {Volume = 0.9})
                        playFish(u2300, "GhostFish_Roar", false)
                        Fx.Shake(2, 0.6)
                        v24 = if not v25 then "Dodge the sea mines" else "Dodge the sea mines and wear it out"
                        Banner = u2275.Chase.Banner
                        Banner.Text = "IT'S DRAGGING YOU DOWN!"
                        Banner.TextTransparency = 0
                        v23 = Banner:FindFirstChildOfClass("UIStroke")
                        if v23 then
                            v23.Transparency = 0
                        end
                        v22 = Banner:FindFirstChildOfClass("UIScale")
                        if v22 then
                            Fx.Punch(v22, 1.6, 0.35)
                        end
                        u2275.Chase.Sub.Text = v24 or ""
                    end
                    if v20 >= 1 then
                        break
                    end
                    task.wait()
                end
                CurrentCamera.FieldOfView = v16
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.CameraSubject = Humanoid
                CurrentCamera.CFrame = v9
                task.wait(0.3)
            end
            for k = 3, 1, -1 do
                v13 = tostring(k)
                Banner_3 = u2275.Chase.Banner
                Banner_3.Text = v13
                Banner_3.TextTransparency = 0
                v8 = Banner_3:FindFirstChildOfClass("UIStroke")
                if v8 then
                    v8.Transparency = 0
                end
                UIScale_2 = Banner_3:FindFirstChildOfClass("UIScale")
                if UIScale_2 then
                    Fx.Punch(UIScale_2, 1.6, 0.35)
                end
                u2275.Chase.Sub.Text = ""
                Fx.Play(GhostDogQuest.Sounds.CountdownTick, {Volume = 0.6})
                task.wait(if not (v32 > 1) then 0.55 else 0.35)
            end
            banner(u2275, "GO!", nil, 0.6)
            Fx.Play(GhostDogQuest.Sounds.CountdownGo, {Volume = 0.7})
            v1:Add((task.delay(5, function() -- Line: 800 -- upvalues: Fx (upval), u2275 (val)
                Fx.Tween(u2275.Chase.Keys, 0.5, {TextTransparency = 1})
                local UIStroke = u2275.Chase.Keys:FindFirstChildOfClass("UIStroke")
                if UIStroke then
                    Fx.Tween(UIStroke, 0.5, {Transparency = 1})
                end
            end)))

            local function steer() -- Line: 809
                -- upvalues: GhostDogQuest (upval), a2 (val), u1033 (ref), Humanoid (val), UserInputService (upval)
                local v1 = GhostDogQuest.ChaseFrame(a2, u1033)
                local MoveDirection = Humanoid.MoveDirection
                local v2 = if not (0.05 < MoveDirection.Magnitude) then 0 else math.clamp(MoveDirection:Dot(v1.RightVector) * 1.4, -1, 1)
                local v3 = UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left)
                v1 = UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right)
                if v3 and not v1 then
                    return -1
                end
                if v1 and not v3 then
                    v2 = 1
                end
                return v2
            end

            local function onHit(a1) -- Line: 827
                -- upvalues: u1058 (ref), u1074 (ref), u1089 (ref), Fx (upval), GhostDogQuest (upval), a2 (val)
                -- upvalues: u1033 (ref), Explosion (upval), WhaleHeartBreak (upval), u117 (upval), u1996 (val)
                -- upvalues: popText (upval), u2275 (val), WhaleHearts (upval), u1123 (ref)
                a1.Hit = true
                os.clock()
                u1074 = os.clock() + 0.08
                u1089 = u1089 - 1
                local Position = a1.Model:GetPivot().Position
                a1.Model:Destroy()
                Fx.Burst(Position, Color3.fromRGB(255, 170, 90), 40, 30, 2.2)
                Fx.Burst(Position, Color3.fromRGB(255, 255, 255), 20, 18, 1.2)
                Fx.Ring(
                    (CFrame.lookAt(Position, Position + GhostDogQuest.ChaseFrame(a2, u1033).LookVector)) * CFrame.Angles(0, 1.5707963267948966, 0),
                    Color3.fromRGB(255, 160, 80),
                    3,
                    26,
                    0.5
                )
                Fx.Play(Explosion, {Volume = 0.8})
                Fx.Play(WhaleHeartBreak, {Volume = 0.6})
                Fx.Shake(3.2, 0.5)
                local Flash = Fx.Flash
                local v1 = if not (u1089 <= 0) then 0.42 else 0.6
                Flash(u117, v1, 0.02, 0.4)
                u1996.FillTransparency = 0
                popText(u2275, "OUCH!", u117)
                v1 = u1089
                WhaleHearts.Lose((math.max(v1, 0)))
                if u1089 == 1 then
                    task.delay(0.35, function() -- Line: 852 -- upvalues: popText (upval), u2275 (upval), u117 (upval), Fx (upval)
                        popText(u2275, "LAST HEART!", u117)
                        Fx.Flash(u117, 0.25, 0.05, 0.6)
                    end)
                end
                if u1089 <= 0 then
                    u1123 = true
                end
            end

            v1:BindToRenderStep("GhostDogChase", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 865
                -- upvalues: u1074 (ref), u1144 (ref), u1123 (ref), u1033 (ref), GhostDogQuest (upval), a2 (val)
                -- upvalues: u1957 (val), u1960 (val), steer (val), u1194 (ref), Fx (upval), Swoosh (upval), u1993 (val)
                -- upvalues: u1228 (ref), u1244 (ref), u1260 (ref), u1058 (ref), HumanoidRootPart (val), Snow (val)
                -- upvalues: u1302 (ref), u1319 (val), u1335 (ref), u2300 (val), u2245 (val), CurrentCamera (val)
                -- upvalues: u1996 (val), u1385 (ref), u1401 (val), spawnMine (upval), u2565 (val), u107 (upval)
                -- upvalues: u112 (upval), onHit (val), Chase (upval), WhaleNearMiss (upval), popText (upval)
                -- upvalues: u2275 (val), Bar (val), Progress (val), a3 (val)
                local success, err = pcall(function() -- Line: 866
                    -- upvalues: a1 (val), u1074 (upval), u1144 (upval), u1123 (upval), u1033 (upval)
                    -- upvalues: GhostDogQuest (upval), a2 (upval), u1957 (upval), u1960 (upval), steer (upval)
                    -- upvalues: u1194 (upval), Fx (upval), Swoosh (upval), u1993 (upval), u1228 (upval), u1244 (upval)
                    -- upvalues: u1260 (upval), u1058 (upval), HumanoidRootPart (upval), Snow (upval), u1302 (upval)
                    -- upvalues: u1319 (upval), u1335 (upval), u2300 (upval), u2245 (upval), CurrentCamera (upval)
                    -- upvalues: u1996 (upval), u1385 (upval), u1401 (upval), spawnMine (upval), u2565 (upval)
                    -- upvalues: u107 (upval), u112 (upval), onHit (upval), Chase (upval), WhaleNearMiss (upval)
                    -- upvalues: popText (upval), u2275 (upval), Bar (upval), Progress (upval), a3 (upval)
                    local v1 = a1
                    local v2 = os.clock()
                    if v2 < u1074 then
                        return
                    end
                    if not u1144 and not u1123 then
                        local v3, v4, v5, v6, v7, v8
                        v1 = math.min(v1, 0.1)
                        local v9 = u1033
                        local LookVector = GhostDogQuest.ChaseFrame(a2, u1033).LookVector
                        u1033 = math.min(u1033 + u1957 * v1, u1960)
                        local v10 = GhostDogQuest.ChaseFrame(a2, u1033)
                        local v11 = steer()
                        if 0.2 < (math.abs(v11)) and not u1194 then
                            Fx.Play(Swoosh, {Volume = 0.25, PlaybackSpeed = 1.3 + math.random() * 0.2})
                            u1993:Emit(8)
                        end
                        u1194 = v8
                        v8 = v11 * 75
                        u1228 = u1228 + (v8 - u1228) * math.min(v1 * 16, 1)
                        u1244 = u1244 + u1228 * v1
                        if 13 <= (math.abs(u1244)) then
                            u1244 = math.clamp(u1244, -13, 13)
                            u1228 = 0
                        end
                        u1260 = u1228 / 75
                        v8 = v2 - u1058
                        v11 = if not (v8 < 0.5) then 0 else (math.sin(v8 * 40)) * (0.5 - v8) * 0.8
                        local v12 = math.sin(v2 * 9) * 0.05
                        local v13 = v10 * CFrame.new(u1244, math.sin(v2 * 2.4) * 0.3, 0)
                        HumanoidRootPart.CFrame = v13 * CFrame.Angles(v12 + -1.2566370614359172, 0, -u1260 * 0.45 + v11)
                        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        Snow.CFrame = v13 * CFrame.new(0, 10, -20)
                        v13 = u1033 + 30
                        v12 = math.sin(v2 * 1.3) * 3 + u1244 * 0.25
                        v11 = u1302
                        local v14 = (1 / 0)
                        for i = -15, 15, 1.5 do
                            v3 = math.abs(i - v12) * 0.35 + math.abs(i - u1302) * 0.25
                            for j, k in u1319 do
                                v4 = k.Distance - v13
                                if v4 > -8 and v4 < 55 and not k.Hit then
                                    v5 = math.abs(k.Offset - i)
                                    if v5 < 9 then
                                        v6 = 1 - (math.clamp(v4 / 55, 0, 1))
                                        v3 = v3 + (9 - v5) * (v6 * 10 + 4)
                                    end
                                end
                            end
                            if v3 < v14 then
                                v14 = v3
                                v11 = i
                            end
                        end
                        v14 = (v11 - u1302) * 28 - u1335 * 9
                        u1335 = u1335 + v14 * v1
                        u1302 = u1302 + u1335 * v1
                        v14 = math.clamp(-u1335 * 0.035, -0.6, 0.6)
                        v12 = math.clamp(-u1335 * 0.012, -0.3, 0.3)
                        u2300:PivotTo((GhostDogQuest.ChaseFrame(a2, v13)) * CFrame.new(u1302, math.sin(v2 * 3) * 0.6 + -8.5, 0) * (CFrame.Angles(0, v12 + math.sin(v2 * 2.2) * 0.05, v14)))
                        u2245.CurveSize0 = math.sin(v2 * 5) * 1.2
                        u2245.CurveSize1 = -math.sin(v2 * 5) * 1.2
                        v14 = ((math.atan2(-v10.LookVector.X, -v10.LookVector.Z)) - math.atan2(-LookVector.X, -LookVector.Z) + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                        local Position = HumanoidRootPart.Position
                        CurrentCamera.CFrame = (CFrame.new(Position)) * CFrame.Angles(0, v14, 0) * CFrame.new(-Position) * CurrentCamera.CFrame
                        if v8 < 1.2 then
                            v14 = math.floor(v8 * 12) % 2 == 0
                            u1996.FillTransparency = if not (v8 < 0.12) then if not v14 then 1 else 0.55 else v8 / 0.12 * 0.4
                        elseif u1996.FillTransparency < 1 then
                            u1996.FillTransparency = 1
                        end
                        while u1385 <= #u1401 do
                            if not (u1401[u1385].Distance <= u1033 + 260) then
                                break
                            end
                            v13 = u1401[u1385]
                            table.insert(u1319, (spawnMine(u2565, a2, v13.Offset, v13.Distance)))
                            u1385 = u1385 + 1
                        end
                        for n = #u1319, 1, -1 do
                            v12 = u1319[n]
                            if not v12.Hit then
                                v11 = v12.Distance - u1033
                                v12.Model:PivotTo((GhostDogQuest.ChaseFrame(a2, v12.Distance)) * CFrame.new(v12.Offset, math.sin(v2 * 2 + v12.Phase) * 0.6, 0) * (CFrame.Angles(0, v2 * 0.6 + v12.Phase, 0)))
                                v10 = (math.max(v11, 0)) / u1957
                                v7 = math.clamp(u1244 + u1228 * math.min(v10, 0.25), -13, 13)
                                v10 = false
                                if v11 < 70 then
                                    v10 = false
                                    if v11 > -2.6 then
                                        v10 = (math.abs(v12.Offset - v7)) < 4.6
                                    end
                                end
                                if v10 then
                                    v7 = (math.sin(v2 * 16) + 1) * 0.5
                                    v1 = 1 - math.clamp(v11 / 70, 0, 1)
                                    v12.Glow.FillColor = u107
                                    v12.Glow.OutlineColor = u107
                                    v12.Glow.OutlineTransparency = 0
                                    v12.Glow.FillTransparency = 0.75 - (v1 * 0.25 + 0.3) * v7
                                    v12.Light.Brightness = v1 * 3 * v7 + 1
                                elseif v12.Glow.FillColor ~= u112 then
                                    v12.Glow.FillColor = u112
                                    v12.Glow.OutlineColor = u112
                                    v12.Glow.OutlineTransparency = 0.5
                                    v12.Glow.FillTransparency = 0.88
                                    v12.Light.Brightness = 0
                                end
                                if v11 < -30 then
                                    v12.Model:Destroy()
                                    table.remove(u1319, n)
                                elseif not v12.Passed and v11 <= 2.6 and -2.6 <= v12.Distance - v9 then
                                    v10 = math.abs(v12.Offset - u1244)
                                    if not (v10 < 4.6) then
                                        if v10 < Chase.LaneSpacing + 1 and v11 < 0 then
                                            v12.Passed = true
                                            Fx.Play(WhaleNearMiss, {Volume = 0.35})
                                            Fx.Shake(0.8, 0.15)
                                            if math.random() < 0.35 then
                                                popText(u2275, "CLOSE!", Color3.fromRGB(255, 225, 90))
                                            end
                                        end
                                    elseif not (v8 >= 1.2) then
                                        v12.Passed = true
                                    else
                                        onHit(v12)
                                    end
                                end
                            else
                                table.remove(u1319, n)
                            end
                        end
                        v8 = u1033 / u1960
                        Bar.Size = UDim2.fromScale(v8, 1)
                        Progress.Fish.Position = UDim2.fromScale(0.06 + v8 * 0.88, 0.48)
                        if u1960 <= u1033 then
                            u1144 = true
                        end
                        if not a3() then
                            u1123 = true
                        end
                        return
                    end
                end)
                if not success then
                    warn((("[GhostDogQuest] chase step failed: %*"):format(err)))
                    u1123 = true
                end
            end)
            v12 = os.clock() + v26 + 20
            while not u1144 do
                if u1123 or not a3() or not (os.clock() < v12) then
                    break
                end
                task.wait()
            end
            if not u1144 then end
            v1:Clean()
            for n, m in u1319 do
                m.Model:Destroy()
            end
            if not a3() then
                v31 = "Aborted"
                break
            end
            if u1144 then
                v31 = "Won"
                break
            end
            v13 = ("You got %*%% of the way!"):format((math.floor(u1033 / u1960 * 100)))
            Banner_4 = u2275.Chase.Banner
            Banner_4.Text = "OOF! Try again!"
            Banner_4.TextTransparency = 0
            v1 = Banner_4:FindFirstChildOfClass("UIStroke")
            if v1 then
                v1.Transparency = 0
            end
            UIScale_3 = Banner_4:FindFirstChildOfClass("UIScale")
            if UIScale_3 then
                Fx.Punch(UIScale_3, 1.6, 0.35)
            end
            u2275.Chase.Sub.Text = v13 or ""
            Fx.Play(Shatter, {Volume = 0.7, PlaybackSpeed = 0.8})
            Fx.Flash(Color3.new(1, 1, 1), 0.4, 0.02, 0.35)
            Fx.Shake(2.6, 0.5)
            task.wait(0.9)
            Hud.Fade(1, 0.35)
            v13 = false
            for i5 = 1, 3 do
                success, err = pcall(function() -- Line: 1086 -- upvalues: Remotes (upval)
                    return Remotes.GhostDogQuest.Restart:InvokeServer()
                end)
                if success and err == true then
                    v13 = true
                    break
                end
                task.wait(0.6)
            end
            if not v13 then
                v31 = "Aborted"
                break
            end
            GhostDogQuest.ChaseFrame(a2, 0)
            waitForArrival(HumanoidRootPart, a2, 5)
            WhaleHearts.Refill(v27 + (if not (3 <= v32 + 1) then 0 else 1))
        end
        if v31 ~= "Won" then
            return v31, nil, u2565, nil
        end
        u2275.Chase.Keys.TextTransparency = 1
        if v25 then
            return "Won", nil, u2565, u2300, u2245
        end
        v32 = v33:Extend()
        local CFrame_2 = HumanoidRootPart.CFrame
        v32:BindToRenderStep("GhostDogChaseEnd", Enum.RenderPriority.Character.Value, function() -- Line: 1116 -- upvalues: HumanoidRootPart (val), CFrame_2 (ref)
            HumanoidRootPart.CFrame = CFrame_2
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end)
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local CFrame_3 = CurrentCamera.CFrame
        v27 = u2300:GetPivot().Position + Vector3.new(0, 8.5, 0)
        playFish(u2300, "GhostFish_Thrash", false, 1.4)
        Fx.Play(GhostDogQuest.Sounds.GrowlShort, {Volume = 1, PlaybackSpeed = 0.95})
        u2245.Color = ColorSequence.new(Color3.new(1, 1, 1), Fx.Ghost)
        v26 = os.clock()
        while true do
            if not (os.clock() - v26 < 0.7) then
                break
            end
            v25 = (os.clock() - v26) / 0.7
            u2245.Width0 = 0.12 + math.abs((math.sin(v25 * 40))) * 0.3 * v25
            u2245.Width1 = u2245.Width0 + 0.1
            u2245.CurveSize0 = 0
            u2245.CurveSize1 = 0
            CurrentCamera.CFrame = (CFrame_3:Lerp(CFrame.lookAt(CFrame_3.Position:Lerp(v27, 0.12), v27), (Fx.Ease(v25)))) * CFrame.Angles(0, 0, math.noise(os.clock() * 20, 3) * v25 * 0.04)
            if math.random() < 0.3 then
                Fx.Shake(0.6 * v25, 0.1)
            end
            task.wait()
        end
        task.wait(0.12)
        local WorldPosition = u2245.Attachment0.WorldPosition
        local WorldPosition_2 = Attachment.WorldPosition
        for i6 = 1, 5 do
            Fx.Burst(WorldPosition:Lerp(WorldPosition_2, i6 / 6), Color3.fromRGB(220, 255, 240), 10, 18, 0.5)
        end
        u2245:Destroy()
        Fx.Play(GhostDogQuest.Sounds.LineSnap, {Volume = 0.9})
        Fx.Flash(Color3.new(1, 1, 1), 0.65, 0.02, 0.4)
        Fx.Shake(4.5, 0.8)
        banner(u2275, "SNAP!", nil, 0.9)
        v31 = GhostDogQuest.ChaseFrame(a2, u1960)
        local v34 = u2300:GetPivot()
        local CFrame_4 = HumanoidRootPart.CFrame
        local v35 = (GhostDogQuest.ChaseFrame(a2, u1960 + 8)) * CFrame.new(0, -6, 0)
        local Position_3 = v28:GetPivot().Position
        local v36 = v35.Position - v31.LookVector * 16 + v31.UpVector * 9 + v31.RightVector * 6
        local CFrame_5 = CurrentCamera.CFrame
        local v37 = GhostDogQuest.ChaseFrame(a2, u1960 + 30).LookVector * Vector3.new(1, 0, 1)
        local Unit = if not (0.05 < v37.Magnitude) then v31.LookVector else v37.Unit
        local Position_4 = (v34 * CFrame.new(0, 8.5, 0)).Position
        local Rotation = CFrame.lookAt(Position_4, Position_4 + Unit).Rotation
        local Rotation_2 = v34.Rotation
        v26 = os.clock()
        while true do
            v2 = os.clock()
            v3 = math.min((v2 - v26) / 1.6, 1)
            v4 = v2 - v26
            v5 = Fx.Ease(v3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v6 = Fx.Ease(math.min(v3 / 0.4, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            Position_4 = Position_4 + Unit * (22 + -6 * Fx.Ease(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)) * v4
            u2300:PivotTo((CFrame.new(Position_4)) * Rotation_2:Lerp(Rotation, v6) * CFrame.new(0, -8.5, 0) * (CFrame.Angles(0, 0, (math.sin(v2 * 2.2)) * 0.06)))
            v7 = math.sin(v3 * 3.141592653589793) * 0.5
            CFrame_2 = (CFrame_4:Lerp(CFrame.lookAt(v35.Position, Position_3 * Vector3.new(1, 0, 1) + Vector3.new(0, v35.Y, 0)), v5)) * CFrame.Angles(-1.2566370614359172 * (1 - v5) * 0.8 + v7 * 0.3, 0, v7 * 0.4)
            CurrentCamera.CFrame = CFrame_5:Lerp(CFrame.lookAt(v36, Position_3 + Vector3.new(0, 2, 0)), v5)
            if v3 >= 1 then
                break
            end
            task.wait()
        end
        u2275.Chase.Visible = false
        v32:Clean()
        return "Won", v28, u2565, u2300
    end
    return "Aborted", nil, nil, nil
end

return table.freeze(v1)