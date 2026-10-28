-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.PowerUpVisuals
-- Decompile time: 59.60 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local EmitOnce = require(ReplicatedStorage.UserGenerated.VFX.EmitOnce)
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local RacePowerUps = require(ReplicatedStorage.Data.RacePowerUps)
require(ReplicatedStorage.Shared.Modules.RaceTrackPath)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Assets = RacePowerUps.Assets
local Attributes = RacePowerUps.Attributes
local Tuning = RacePowerUps.Tuning
local u64 = Color3.fromRGB(60, 215, 255)
local u69 = Color3.fromRGB(255, 255, 255)
local u70 = {0.05, 0.11, 0.17}
local u74 = {0.1, 0.35, 0.6}
local u82 = Color3.fromRGB(255, 190, 90)
local u87 = CFrame.new(0, -10000, 0)
local u88 = {}
local u90 = Random.new()
local u91 = {}

local function now() -- Line: 53 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function characterOf(a1) -- Line: 57 -- types: a1: userdata?
    if a1 == nil then
        return nil
    end
    if a1:IsA("Player") then
        return a1.Character
    end
    if a1:IsA("Model") and a1.Parent ~= nil then
        return a1
    end
    return nil
end

local function rootOf(a1) -- Line: 67 -- types: a1: userdata?
    local Character = if a1 ~= nil then if not a1:IsA("Player") then if not a1:IsA("Model") then nil else if a1.Parent == nil then nil else a1 else a1.Character else nil
    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

function u91.Folder(a1) -- Line: 73 -- upvalues: Workspace (val)
    local Folder = Instance.new("Folder")
    Folder.Name = "RacePowerUpFX"
    Folder.Parent = Workspace
    a1:Add(Folder)
    return Folder
end

function u91.Emit(a1, a2, a3, a4) -- Line: 81
    -- upvalues: Assets (val), EmitOnce (val)
    local new, v1
    local v2 = Assets.Effects:FindFirstChild(a2)
    if v2 == nil then
        return
    end
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = a3
    local v3 = v2:Clone()
    v3.Parent = Part
    Part.Parent = a1
    local v4 = a4
    for i, j in v3:GetChildren() do
        if j:IsA("ParticleEmitter") then
            if v4 ~= nil and v4 ~= 1 then
                v2 = {}
                for k, n in j.Size.Keypoints do
                    table.insert(v2, (NumberSequenceKeypoint.new(n.Time, n.Value * v4, n.Envelope * v4)))
                end
                j.Size = NumberSequence.new(v2)
                new = NumberRange.new
                v1 = j.Speed.Min * v4
                j.Speed = new(v1, j.Speed.Max * v4)
            end
            EmitOnce(j)
        end
    end
    task.delay(3, Part.Destroy, Part)
end

function u91.Sound(a1, a2, a3) -- Line: 116 -- upvalues: Assets (val), Workspace (val) -- types: a1: string, a3: number?
    local v1 = Assets.Sounds:FindFirstChild(a1)
    if v1 == nil then
        return nil
    end
    local u12 = v1:Clone()
    if a3 ~= nil then
        u12.PlaybackSpeed = u12.PlaybackSpeed * a3
    end
    if typeof(a2) == "Instance" then
        u12.Parent = a2
    elseif typeof(a2) ~= "Vector3" then
        u12.Parent = Workspace.CurrentCamera
    else
        local u26 = Instance.new("Attachment")
        u26.WorldPosition = a2
        u26.Parent = Workspace.Terrain
        u12.Parent = u26
        u12.Ended:Once(function() -- Line: 132 -- upvalues: u26 (val)
            u26:Destroy()
        end)
        task.delay(8, u26.Destroy, u26)
    end
    if not u12.Looped then
        u12.Ended:Once(function() -- Line: 140 -- upvalues: u12 (val)
            u12:Destroy()
        end)
        task.delay(10, u12.Destroy, u12)
    end
    u12:Play()
    return u12
end

local function trailOn(a1, a2, a3, a4, a5) -- Line: 149
    -- upvalues: Assets (val)
    local v1 = a1:Add((Instance.new("Attachment")))
    local v2 = a1:Add((Instance.new("Attachment")))
    local v3 = a5 or Vector3.new(0, 0, 0)
    v1.Position = v3 + Vector3.new(0, a4 / 2, 0)
    v2.Position = v3 - Vector3.new(0, a4 / 2, 0)
    v1.Parent = a2
    v2.Parent = a2
    v3 = a1:Add((Assets.Effects[a3]:Clone()))
    v3.Attachment0 = v1
    v3.Attachment1 = v2
    v3.Parent = a2
    return v3
end

local function spinFrame(a1, a2, a3) -- Line: 164 -- types: a1: vector, a2: vector, a3: number
    local v1 = Vector3.new(a2.X, 0, a2.Z)
    return (CFrame.lookAt(a1, a1 + (if not (0.001 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit))) * CFrame.Angles(a3, 0, 0)
end

local function cuePart(a1, a2, a3, a4) -- Line: 170
    -- upvalues: u82 (val), u87 (val)
    local v1 = a1:Add((Instance.new("Part")))
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    v1.Material = Enum.Material.Neon
    v1.Color = u82
    v1.Transparency = a3
    v1.Size = a2
    v1.CFrame = u87
    v1.Parent = a4
    return v1
end

local function pathFrame(a1, a2) -- Line: 186 -- upvalues: RacePowerUps (val) -- types: a1: table, a2: number
    local v1, v2 = RacePowerUps.PathAt(a1, a2)
    local v3 = RacePowerUps.PathAt(a1, a2 + 0.02)
    local v4 = v3 - v1
    if not v2 and not (v4.Magnitude < 0.001) then
        return (CFrame.lookAt(v1, v3)), false
    end
    return nil, v2
end

local function popIn(a1, a2, a3) -- Line: 196
    -- upvalues: TweenService (val), RunService (val)
    local u4 = os.clock()
    local Scale = a1:GetScale()
    a1:ScaleTo(Scale * (a3 or 0.2))
    task.spawn(function() -- Line: 200
        -- upvalues: a1 (val), u4 (val), a2 (val), TweenService (upval), Scale (val), a3 (val), RunService (upval)
        local Value, v1
        while a1.Parent ~= nil do
            v1 = math.min((os.clock() - u4) / a2, 1)
            Value = TweenService:GetValue(v1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            a1:ScaleTo((math.max(Scale * ((a3 or 0.2) + (1 - (a3 or 0.2)) * Value), 0.01)))
            if v1 >= 1 then
                break
            end
            RunService.RenderStepped:Wait()
        end
    end)
end

local function afterimage(a1, a2, a3) -- Line: 213
    -- upvalues: TweenService (val)
    local v1, v2, v3
    local Model = Instance.new("Model")
    Model.Name = "Ghost"
    local v4 = {}
    for i, j in a2:GetDescendants() do
        if j:IsA("MeshPart") and j.Transparency < 1 then
            v1 = j:Clone()
            v1:ClearAllChildren()
            v1.Anchored = true
            v1.CanCollide = false
            v1.CanQuery = false
            v1.CanTouch = false
            v1.CastShadow = false
            v1.Material = Enum.Material.Neon
            v1.Color = a3
            v1.Transparency = 0.55
            v1.Parent = Model
            table.insert(v4, v1)
        end
    end
    Model.Parent = a1
    local v5 = TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for k, n in v4 do
        v2 = TweenService
        v3 = {Transparency = 1, Size = n.Size * 1.12}
        v2:Create(n, v5, v3):Play()
    end
    task.delay(0.37, Model.Destroy, Model)
end

local function watchRacer(a1, a2, a3) -- Line: 241
    -- upvalues: MountRace (val), Assets (val), TweenService (val), u91 (val), u69 (val), u88 (val), RunService (val)
    -- upvalues: Workspace (val), u64 (val), u90 (val), trailOn (val), afterimage (val), popIn (val), Attributes (val)
    local u5 = a1:Extend()
    local u6 = nil
    local u7 = nil

    local function mountOf() -- Line: 246 -- upvalues: a3 (val), MountRace (upval)
        local Character
        local v1 = a3
        if (if v1 ~= nil then if not v1:IsA("Player") then if not v1:IsA("Model") then nil else if v1.Parent == nil then nil else v1 else v1.Character else nil) == nil then
            return nil
        end
        local RaceSkywhale = Character:FindFirstChild("RaceSkywhale")
        if RaceSkywhale ~= nil and RaceSkywhale:IsA("Model") then
            return RaceSkywhale
        end
        v1 = Character:FindFirstChild(MountRace.MountName)
        if v1 ~= nil and v1:IsA("Model") then
            return v1
        end
        return nil
    end

    local function startShield(a1, a2_2) -- Line: 259
        -- upvalues: a3 (val), Assets (upval), a2 (val), TweenService (upval), u91 (upval), u69 (upval), u88 (upval)
        -- upvalues: RunService (upval), Workspace (upval), u64 (upval), u90 (upval)
        local Unit, v1
        local v2 = a3
        local Character = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
            return
        end
        local u35 = Assets.Models.Shield:Clone()
        local PrimaryPart = u35.PrimaryPart
        local Fill = u35:FindFirstChild("Fill")
        local Panels = u35:FindFirstChild("Panels")
        local PointLight = PrimaryPart:FindFirstChildOfClass("PointLight")
        local CFrame_2 = PrimaryPart.CFrame
        local Size = PrimaryPart.Size
        local Size_2 = if Fill == nil then Vector3.new(0, 0, 0) else Fill.Size
        local u53 = {}
        local u54 = {}
        local u55 = {}
        local u56 = {}
        for i, j in u35:GetDescendants() do
            if j:IsA("BasePart") then
                table.insert(u53, j)
                table.insert(u54, (CFrame_2:ToObjectSpace(j.CFrame)))
                table.insert(u55, j.CFrame)
                if Panels ~= nil and j.Parent == Panels then
                    Unit = CFrame_2:PointToObjectSpace(j.Position).Unit
                    j.Transparency = 1
                    table.insert(u56, {
                        Flash = 0,
                        Alpha = 1,
                        Color = 0,
                        Part = j,
                        Normal = Unit,
                        Delay = 0.08 + (Unit.Y + 1) / 2 * 0.45,
                    })
                end
            end
        end
        u35.Parent = a2
        local u74 = os.clock()
        local u75 = 0
        local u76 = 0
        local CFrame = v1.CFrame
        local u79 = false
        local v3 = Instance.new("Part")
        v3.Shape = Enum.PartType.Ball
        v3.Material = Enum.Material.Neon
        v3.Color = Color3.fromRGB(110, 225, 255)
        v3.Anchored = true
        v3.CanCollide = false
        v3.CanQuery = false
        v3.CanTouch = false
        v3.CastShadow = false
        v3.Transparency = 0.45
        v3.Size = Size * 0.5
        v3.CFrame = v1.CFrame
        v3.Parent = a2
        local v4 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(v3, v4, {Transparency = 1, Size = Size * 1.45}):Play()
        task.delay(0.45, v3.Destroy, v3)
        u91.Sound("ShieldUp", v1)
        u91.Sound("ShieldRing", v1)

        local function hit(a1) -- Line: 332
            -- upvalues: CFrame (ref), u56 (val), u76 (ref), u79 (ref), Size (val), u91 (upval), a2 (upval), u69 (upval)
            -- upvalues: TweenService (upval)
            local Flash, v1, v2
            local v3 = if a1 == nil then Vector3.new(-0, -0, -1) else CFrame:PointToObjectSpace(a1)
            local Unit = if not (0.001 < v3.Magnitude) then Vector3.new(-0, -0, -1) else v3.Unit
            for i, j in u56 do
                v2 = j.Normal:Dot(Unit)
                Flash = j.Flash
                v1 = math.clamp((v2 - 0.72) / 0.22, 0, 1)
                j.Flash = math.max(Flash, v1)
            end
            u76 = 1
            u79 = false
            local v4 = Size.X / 2
            local v5 = CFrame * CFrame.new(Unit * v4)
            u91.Emit(a2, "Shatter", v5, 0.45)
            v4 = Instance.new("Part")
            v4.Shape = Enum.PartType.Ball
            v4.Material = Enum.Material.Neon
            v4.Color = u69
            v4.Anchored = true
            v4.CanCollide = false
            v4.CanQuery = false
            v4.CanTouch = false
            v4.CastShadow = false
            v4.Transparency = 0.05
            v4.Size = Vector3.new(0.6000000238418579, 0.6000000238418579, 0.6000000238418579)
            v4.CFrame = v5
            v4.Parent = a2
            v5 = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local v6 = {
                Size = Vector3.new(4.199999809265137, 4.199999809265137, 4.199999809265137),
                Transparency = 1,
            }
            TweenService:Create(v4, v5, v6):Play()
            task.delay(0.4, v4.Destroy, v4)
        end

        u88[a3] = hit
        a1:Add(function() -- Line: 362 -- upvalues: u88 (upval), a3 (upval), hit (val)
            if u88[a3] == hit then
                u88[a3] = nil
            end
        end)
        a1:Connect(RunService.RenderStepped, function(a1) -- Line: 368
            -- upvalues: a3 (upval), u75 (ref), u74 (val), a2_2 (val), Workspace (upval), TweenService (upval)
            -- upvalues: CFrame (ref), u54 (val), u55 (val), u53 (val), PrimaryPart (val), Size (val), Fill (val)
            -- upvalues: Size_2 (val), u79 (ref), u76 (ref), u56 (val), u64 (upval), u69 (upval), PointLight (val)
            local v1, v2, v3, v4
            local v5 = a3
            local Character = if v5 ~= nil then if not v5:IsA("Player") then if not v5:IsA("Model") then nil else if v5.Parent == nil then nil else v5 else v5.Character else nil
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
                return
            end
            u75 = u75 + a1 * 0.6
            v5 = os.clock() - u74
            local v6 = a2_2 - Workspace:GetServerTimeNow()
            local v7 = 0.15 + 0.85 * (TweenService:GetValue(math.min(v5 / 0.38, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out))
            local v8 = v1.CFrame * CFrame.new(0, -0.6, 0) * CFrame.Angles(0, u75, 0)
            CFrame = v8
            for i, j in u54 do
                u55[i] = v8 * (j.Rotation + j.Position * v7)
            end
            Workspace:BulkMoveTo(u53, u55, Enum.BulkMoveMode.FireCFrameChanged)
            if v5 < 0.43 then
                PrimaryPart.Size = Size * v7
                if Fill ~= nil then
                    Fill.Size = Size_2 * v7
                end
            end
            v7 = v6 < 1.6
            if u79 and not v7 then
                return
            end
            v8 = math.floor((os.clock()) * (if not (v6 < 0.7) then 9 else 18))
            v6 = true
            if not (v5 < 0.75) then
                v6 = v7
            end
            u76 = math.max(u76 - a1 * 3, 0)
            local v9 = nil
            local v10 = nil
            for k, n in u56, v9, v10 do
                v3 = n.Flash - a1 * 1.5
                n.Flash = math.max(v3, 0)
                v6 = v6 or 0 < n.Flash
                v2 = 1 - math.clamp((v5 - n.Delay) / 0.12, 0, 1) * 0.85
                if v7 and (k * 7 + v8) % 3 == 0 then
                    v2 = 0.85
                end
                v2 = v2 * (1 - n.Flash)
                v1 = math.floor(n.Flash * 20 + 0.5) / 20
                if 0.01 < (math.abs(v2 - n.Alpha)) then
                    n.Alpha = v2
                    n.Part.Transparency = v2
                end
                if v1 ~= n.Color then
                    n.Color = v1
                    v4 = u69
                    n.Part.Color = u64:Lerp(v4, v1)
                end
            end
            v5 = v7 and v8 % 2 == 0
            if Fill ~= nil then
                Fill.Transparency = if not v5 then 0.89 - u76 * 0.25 else 0.97
            end
            PrimaryPart.Transparency = if not v5 then 0 else 0.6
            if PointLight ~= nil then
                PointLight.Brightness = u76 * 3 + 1.4
            end
            u79 = not v6 and u76 <= 0
        end)
        a1:Add(function() -- Line: 432
            -- upvalues: a3 (upval), u91 (upval), a2 (upval), u35 (val), PrimaryPart (val), u56 (val), u90 (upval)
            -- upvalues: u69 (upval), TweenService (upval), Fill (val), PointLight (val)
            local Part, Unit, v1
            local v2 = a3
            local Character = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            local v3 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            if v3 ~= nil then
                u91.Emit(a2, "Shatter", v3.CFrame, 0.8)
                u91.Sound("ShieldBreak", v3)
            end
            if u35.Parent == nil then
                return
            end
            local Position = PrimaryPart.Position
            v2 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            for i, j in u56 do
                Part = j.Part
                Unit = (Part.Position - Position).Unit
                v1 = Part.CFrame * CFrame.Angles(u90:NextNumber(-1, 1), u90:NextNumber(-1, 1), u90:NextNumber(-1, 1)) + Unit * u90:NextNumber(2.5, 4.5)
                Part.Color = u69
                Part.Transparency = 0
                TweenService:Create(Part, v2, {Transparency = 1, CFrame = v1}):Play()
            end
            TweenService:Create(PrimaryPart, v2, {Transparency = 1, Size = PrimaryPart.Size * 1.2}):Play()
            if Fill ~= nil then
                TweenService:Create(Fill, v2, {Transparency = 1, Size = Fill.Size * 1.2}):Play()
            end
            if PointLight ~= nil then
                TweenService:Create(PointLight, v2, {Brightness = 0}):Play()
            end
            task.delay(0.5, u35.Destroy, u35)
        end)
    end

    local function startSerum(a1) -- Line: 464
        -- upvalues: a3 (val), u91 (upval), a2 (val), mountOf (val), trailOn (upval), Assets (upval), RunService (upval)
        -- upvalues: afterimage (upval)
        local v1
        local v2 = a3
        local Character_2 = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
        local HumanoidRootPart = if Character_2 == nil then nil else Character_2:FindFirstChild("HumanoidRootPart")
        if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
            return
        end
        u91.Sound("Gulp", v1)
        u91.Sound("SerumBurst", v1)
        u91.Emit(a2, "Poof", v1.CFrame, 0.7)
        v2 = a3
        local Character = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
        v2 = mountOf()
        local Hitbox = if v2 == nil then nil else v2:FindFirstChild("Hitbox")
        if Hitbox ~= nil and Hitbox:IsA("BasePart") then
            trailOn(a1, Hitbox, "SerumTrail", 2.4, (Vector3.new(2.5999999046325684, 0, 2.5)))
            trailOn(a1, Hitbox, "SerumTrail", 2.4, (Vector3.new(-2.5999999046325684, 0, 2.5)))
            v2 = a1:Add((Assets.Effects.Speed:Clone()))
            v2.Position = Vector3.new(0, 0, 3)
            local ParticleEmitter = v2:FindFirstChildOfClass("ParticleEmitter")
            ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(170, 255, 90))
            v2.Parent = Hitbox
        end
        local u116 = 0
        a1:Connect(RunService.Heartbeat, function() -- Line: 485 -- upvalues: u116 (ref), mountOf (upval), Character (val), afterimage (upval), a2 (upval)
            if os.clock() - u116 < 0.09 then
                return
            end
            os.clock()
            local v1 = mountOf()
            if v1 ~= nil and Character.Parent ~= nil then
                afterimage(a2, v1, Color3.fromRGB(120, 255, 110))
            end
        end)
    end

    local function startWhale(a1) -- Line: 497
        -- upvalues: a3 (val), u91 (upval), a2 (val), trailOn (upval), popIn (upval), u5 (val), RunService (upval)
        -- upvalues: TweenService (upval)
        local v1
        local v2 = a3
        local Character = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
            return
        end
        u91.Emit(a2, "Poof", v1.CFrame, 1.6)
        u91.Sound("Pop", v1)
        u91.Sound("WhaleSwoosh", v1)
        v2 = u91.Sound("WhaleLoop", v1)
        if v2 ~= nil then
            a1:Add(v2)
        end
        local u60 = nil
        local identity = CFrame.identity
        task.spawn(function() -- Line: 511 -- upvalues: a3 (upval), a1 (val), identity (ref), u60 (ref), trailOn (upval), popIn (upval)
            local v1 = a3
            local Character = if v1 ~= nil then if not v1:IsA("Player") then if not v1:IsA("Model") then nil else if v1.Parent == nil then nil else v1 else v1.Character else nil
            local RaceSkywhale = if Character == nil then nil else Character:WaitForChild("RaceSkywhale", 2)
            if RaceSkywhale ~= nil and a1.Destroy ~= nil then
                local v2 = a3
                local Character_2 = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
                local HumanoidRootPart = if Character_2 == nil then nil else Character_2:FindFirstChild("HumanoidRootPart")
                local v3 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
                if v3 ~= nil then
                    v3.CFrame:ToObjectSpace((RaceSkywhale:GetPivot()))
                end
                v3 = RaceSkywhale:Clone()
                if v3 == nil then
                    return
                end
                for i, j in v3:GetDescendants() do
                    if j:IsA("BasePart") then
                        j.Anchored = true
                        j.CanCollide = false
                        j.CanQuery = false
                        j.CanTouch = false
                        j.CastShadow = false
                    elseif j:IsA("JointInstance")
                        or j:IsA("Constraint")
                        or j:IsA("Trail")
                        or j:IsA("Sound")
                        or j:IsA("ParticleEmitter") then
                        j:Destroy()
                    end
                end
                if a1.Destroy == nil then
                    v3:Destroy()
                    return
                end
                u60 = v3
                v3 = RaceSkywhale:FindFirstChild("HumanoidRootPart")
                if v3 ~= nil and v3:IsA("BasePart") then
                    trailOn(a1, v3, "WhaleTrail", 2.6, (Vector3.new(0, 4.199999809265137, 14.5)))
                    trailOn(a1, v3, "WhaleTrail", 1, (Vector3.new(6.199999809265137, 2.4000000953674316, 3)))
                    trailOn(a1, v3, "WhaleTrail", 1, (Vector3.new(-6.199999809265137, 2.4000000953674316, 3)))
                    popIn(RaceSkywhale, 0.35, 0.3)
                end
                return
            end
        end)
        a1:Add(function() -- Line: 555
            -- upvalues: a3 (upval), u91 (upval), a2 (upval), u60 (ref), u5 (upval), identity (ref), RunService (upval)
            -- upvalues: TweenService (upval)
            local v1
            local v2 = a3
            local Character = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
                return
            end
            u91.Emit(a2, "Poof", v1.CFrame, 1.1)
            u91.Sound("Pop", v1, 0.85)
            local u41 = u60
            u60 = nil
            if u41 == nil then
                return
            end
            local Scale = u41:GetScale()
            local u46 = {}
            for i, j in u41:GetDescendants() do
                if j:IsA("BasePart") and j.Transparency < 1 then
                    table.insert(u46, j)
                end
            end
            local v3 = u5
            local success, err = pcall(u5.Extend, v3)
            if success and a2.Parent ~= nil then
                u41:PivotTo(v1.CFrame * identity)
                u41.Parent = a2
                err:Add(u41)
                local u82 = (os.clock())
                err:Connect(RunService.RenderStepped, function() -- Line: 583
                    -- upvalues: u82 (val), TweenService (upval), a3 (upval), u41 (val), Scale (val), identity (upval)
                    -- upvalues: u46 (val)
                    local v1 = math.min((os.clock() - u82) / 0.34, 1)
                    local Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    local v2 = a3
                    local Character = if v2 ~= nil then if not v2:IsA("Player") then if not v2:IsA("Model") then nil else if v2.Parent == nil then nil else v2 else v2.Character else nil
                    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
                    v1 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
                    u41:ScaleTo((math.max(Scale * (1 - 0.8 * Value), 0.01)))
                    if v1 ~= nil then
                        u41:PivotTo(v1.CFrame * identity * (CFrame.new(0, 3 * Value, 0)))
                    end
                    for i, j in u46 do
                        j.Transparency = Value
                    end
                end)
                task.delay(0.34, err.Destroy, err)
                return
            end
            u41:Destroy()
        end)
    end

    local function refreshEffect() -- Line: 599
        -- upvalues: u6 (ref), a3 (val), Attributes (upval), Workspace (upval), u5 (val), startShield (val)
        -- upvalues: startSerum (val), startWhale (val)
        if u6 ~= nil then
            u6:Destroy()
            u6 = nil
        end
        local Attribute = a3:GetAttribute(Attributes.Effect)
        local Attribute_2 = a3:GetAttribute(Attributes.EffectEndsAt)
        if type(Attribute) == "string"
            and type(Attribute_2) == "number"
            and not (Attribute_2 <= Workspace:GetServerTimeNow()) then
            local v1 = u5:Extend()
            u6 = v1
            if Attribute == "Shield" then
                startShield(v1, Attribute_2)
                return
            end
            if Attribute == "Serum" then
                startSerum(v1)
                return
            end
            if Attribute == "Skywhale" then
                startWhale(v1)
            end
            return
        end
    end

    local function refreshStun() -- Line: 620
        -- upvalues: u7 (ref), a3 (val), Attributes (upval), Workspace (upval), u5 (val), Assets (upval), u91 (upval)
        if u7 ~= nil then
            u7:Destroy()
            u7 = nil
        end
        local Attribute = a3:GetAttribute(Attributes.StunEndsAt)
        if type(Attribute) == "number" and not (Attribute <= Workspace:GetServerTimeNow()) then
            local v1 = a3
            local Character = if v1 ~= nil then if not v1:IsA("Player") then if not v1:IsA("Model") then nil else if v1.Parent == nil then nil else v1 else v1.Character else nil
            local Head = if Character == nil then nil else Character:FindFirstChild("Head")
            if Head ~= nil and Head:IsA("BasePart") then
                local u48 = u5:Extend()
                u7 = u48
                local v2 = u48:Add((Assets.Effects.Dizzy:Clone()))
                v2.Position = Vector3.new(0, 1.600000023841858, 0)
                v2.Parent = Head
                v2 = u91.Sound("Dizzy", Head)
                if v2 ~= nil then
                    u48:Add(v2)
                end
                task.delay(Attribute - Workspace:GetServerTimeNow(), function() -- Line: 643 -- upvalues: u7 (upval), u48 (val)
                    if u7 == u48 then
                        u48:Destroy()
                        u7 = nil
                    end
                end)
                return
            end
            return
        end
    end

    u5:Connect(a3:GetAttributeChangedSignal(Attributes.Effect), refreshEffect)
    u5:Connect(a3:GetAttributeChangedSignal(Attributes.StunEndsAt), refreshStun)
    refreshEffect()
    refreshStun()
    return u5
end

function u91.Run(a1, a2, a3) -- Line: 658
    -- upvalues: u91 (val), RacePowerUps (val), MountRace (val), Players (val), Workspace (val), watchRacer (val)
    -- upvalues: RunService (val), MountRaceFlags (val), Tuning (val), Assets (val), u82 (val), u87 (val), trailOn (val)
    -- upvalues: u74 (val), popIn (val), u70 (val), TweenService (val), LocalPlayer (val), u88 (val), Remotes (val)
    local u6 = u91.Folder(a1)
    local u10 = RacePowerUps.Params(a2)
    local u11 = {}
    local u12 = {}
    local u17 = MountRace.HeatOf(Players.LocalPlayer)

    local function syncRacers() -- Line: 665
        -- upvalues: Players (upval), MountRace (upval), a2 (val), u17 (val), Workspace (upval), u12 (val)
        -- upvalues: watchRacer (upval), a1 (val), u6 (val)
        local RaceId_2
        local v1 = {}
        for i, j in Players:GetPlayers() do
            RaceId_2 = MountRace.PlayerAttributes.RaceId
            if (j:GetAttribute(RaceId_2)) == a2.Name and (MountRace.HeatOf(j)) == u17 then
                v1[j] = true
            end
        end
        local RaceBots = Workspace:FindFirstChild("RaceBots")
        if RaceBots ~= nil then
            local RaceId
            for k, n in RaceBots:GetChildren() do
                RaceId = MountRace.PlayerAttributes.RaceId
                if (n:GetAttribute(RaceId)) == a2.Name and (MountRace.HeatOf(n)) == u17 then
                    v1[n] = true
                end
            end
        end
        for m in v1 do
            if u12[m] == nil then
                u12[m] = (watchRacer(a1, u6, m))
            end
        end
        for i5, i6 in u12 do
            if not v1[i5] then
                i6:Destroy()
                u12[i5] = nil
            end
        end
    end

    local u19 = 0
    a1:Connect(RunService.Heartbeat, function() -- Line: 699 -- upvalues: u19 (ref), syncRacers (val)
        if 0.5 < os.clock() - u19 then
            os.clock()
            syncRacers()
        end
    end)
    syncRacers()

    local function shot(a1_2, a2, a3, a4) -- Line: 707
        -- upvalues: a1 (val), u6 (val), u11 (val)
        local v1 = a1:Extend()
        if a3 ~= nil then
            v1:Add(a3)
            if a4 ~= nil then
                a3:PivotTo(a4)
            end
            a3.Parent = u6
        end
        local v2 = {Kind = a2, Model = a3, Trove = v1, Data = {}}
        u11[a1_2] = v2
        return v2
    end

    local function drop(a1) -- Line: 721 -- upvalues: u11 (val) -- types: a1: string
        local v1 = u11[a1]
        if v1 ~= nil then
            u11[a1] = nil
            v1.Trove:Destroy()
        end
        return v1
    end

    local function onSpike(a1, a2, a3, a4, a5) -- Line: 730
        -- upvalues: RacePowerUps (upval), MountRaceFlags (upval), Tuning (upval), u10 (val), Assets (upval), shot (val)
        -- upvalues: u6 (val), u82 (upval), u87 (upval), trailOn (upval), u74 (upval), popIn (upval), u91 (upval)
        -- upvalues: RunService (upval), Workspace (upval), u70 (upval)
        local Trove_3, v1, v2, v3
        local u179 = RacePowerUps.SpikePath(a3, a4, (MountRaceFlags.TopSpeed:Get()) * Tuning.SpikeSpeed, u10)
        local u180 = Assets.Models.Spike:Clone()
        u180:ScaleTo((u180:GetScale()) * Tuning.SpikeScale)
        local v4 = shot(a1, "Spike", u180, CFrame.new(a3))
        local SpikeScale_2 = Tuning.SpikeScale
        local v5 = u6
        local v6 = v4.Trove:Add((Instance.new("Part")))
        v6.Anchored = true
        v6.CanCollide = false
        v6.CanQuery = false
        v6.CanTouch = false
        v6.CastShadow = false
        v6.Material = Enum.Material.Neon
        v6.Color = u82
        v6.Transparency = 1
        v6.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
        v6.CFrame = u87
        v6.Parent = v5
        v6.CFrame = CFrame.new(a3)
        trailOn(v4.Trove, v6, "SpikeTrail", 3.4)
        local u150 = {}
        local u168 = {}
        local v7 = nil
        local v8 = nil
        for i, j in u74, v7, v8 do
            for k = -1, 1, 2 do
                Trove_3 = v4.Trove
                v2 = Vector3.new(0.550000011920929, 0.11999999731779099, 3.200000047683716) * SpikeScale_2
                v3 = u6
                v1 = Trove_3:Add((Instance.new("Part")))
                v1.Anchored = true
                v1.CanCollide = false
                v1.CanQuery = false
                v1.CanTouch = false
                v1.CastShadow = false
                v1.Material = Enum.Material.Neon
                v1.Color = u82
                v1.Transparency = j
                v1.Size = v2
                v1.CFrame = u87
                v1.Parent = v3
                table.insert(u150, v1)
                table.insert(
                    u168,
                    (CFrame.new(k * 0.92 * SpikeScale_2, -1.55, -0.29 * SpikeScale_2)) * (CFrame.Angles(0, k * 0.6108652381980153, 0))
                )
            end
        end
        popIn(u180, 0.18, 0.35)
        u91.Sound("Throw", a3)
        local u96 = 0
        local u101 = table.clone(u150)
        table.insert(u101, v6)
        local u111 = table.create(#u101, u87)
        v4.Trove:Connect(RunService.RenderStepped, function(a1) -- Line: 757
            -- upvalues: Workspace (upval), a5 (val), RacePowerUps (upval), u179 (val), u96 (ref), u180 (val)
            -- upvalues: u70 (upval), u111 (val), u168 (val), u87 (upval), u150 (val), u74 (upval), u101 (val)
            local v1, v2, v3, v4, v5
            local v6 = (Workspace:GetServerTimeNow()) - a5
            local v7 = RacePowerUps.PathAt(u179, v6)
            local v8 = RacePowerUps.PathAt(u179, v6 + 0.05)
            u96 = u96 - a1 * 18
            local v9 = math.abs((math.sin(v6 * 14))) * 0.8
            local v10 = v7 + Vector3.new(0, 1, 0) * v9
            local v11 = v8 - v7
            local v12 = Vector3.new(v11.X, 0, v11.Z)
            u180:PivotTo((CFrame.lookAt(v10, v10 + (if not (0.001 < v12.Magnitude) then Vector3.new(0, 0, 1) else v12.Unit))) * (CFrame.Angles(u96, 0, 0)))
            v9 = math.sin(v6 * 24) * 0.5 + 0.5
            local v13 = nil
            local v14 = nil
            for i, j in u70, v13, v14 do
                v1 = u179
                v12 = v6 + j
                v2, v3 = RacePowerUps.PathAt(v1, v12)
                v4 = RacePowerUps.PathAt(v1, v12 + 0.02)
                v5 = v4 - v2
                v8 = if v3 then nil else if not (v5.Magnitude < 0.001) then CFrame.lookAt(v2, v4) else nil
                for k = 1, 2 do
                    v3 = (i - 1) * 2 + k
                    u111[v3] = if v8 == nil then u87 else v8 * u168[v3]
                    v4 = u150[v3]
                    v4.Transparency = u74[i] + v9 * 0.12
                end
            end
            local v15 = u179
            v13, v14 = RacePowerUps.PathAt(v15, v6)
            v10 = RacePowerUps.PathAt(v15, v6 + 0.02)
            v11 = v10 - v13
            v9 = if v14 then nil else if not (v11.Magnitude < 0.001) then CFrame.lookAt(v13, v10) else nil
            v13 = #u111
            u111[v13] = if v9 == nil then CFrame.new(v7) else v9
            Workspace:BulkMoveTo(u101, u111, Enum.BulkMoveMode.FireCFrameChanged)
        end)
    end

    local function onSpikeEnd(a1, a2, a3) -- Line: 779
        -- upvalues: u11 (val), u91 (upval), u6 (val)
        local v1 = u11[a1]
        if v1 ~= nil then
            u11[a1] = nil
            v1.Trove:Destroy()
        end
        local Position = a3 or (if not v1 then nil else if not v1.Model then nil else v1.Model:GetPivot().Position)
        if Position == nil then
            return
        end
        if a2 == nil then
            u91.Emit(u6, "Poof", CFrame.new(Position), 0.6)
            u91.Sound("Pop", Position, 1.5)
            return
        end
        u91.Emit(u6, "Stars", CFrame.new(Position), 1.2)
        u91.Emit(u6, "Poof", CFrame.new(Position), 0.7)
        u91.Sound("PuffHit", Position)
        u91.Sound("Pop", Position, 1.3)
    end

    local function onPod(a1, a2, a3_2, a4, a5) -- Line: 796
        -- upvalues: Assets (upval), shot (val), trailOn (upval), popIn (upval), u91 (upval), MountRaceFlags (upval)
        -- upvalues: Tuning (upval), RunService (upval), a3 (val), Workspace (upval)
        local u10 = Assets.Models.Pod:Clone()
        local v1 = shot(a1, "Pod", u10, CFrame.new(a3_2))
        local PrimaryPart = u10.PrimaryPart
        trailOn(v1.Trove, PrimaryPart, "PodTrail", 2.2, (Vector3.new(0, 1.600000023841858, -2.799999952316284)))
        popIn(u10, 0.25, 0.3)
        u91.Sound("PodLaunch", a3_2)
        local v2 = u91.Sound("PodLoop", PrimaryPart)
        if v2 ~= nil then
            v1.Trove:Add(v2)
        end
        local Data = v1.Data
        Data.Position = a3_2
        Data.Progress = a4
        local u58 = (MountRaceFlags.TopSpeed:Get()) * Tuning.PodSpeed
        local u59 = 0
        v1.Trove:Connect(RunService.RenderStepped, function(a1) -- Line: 812
            -- upvalues: Data (val), u58 (val), a3 (upval), Workspace (upval), a5 (val), Tuning (upval), u59 (ref)
            -- upvalues: u10 (val)
            local v1, v2, v3, v4
            local Position = Data.Position
            local Target = Data.Target
            if Target == nil then
                v3 = Data
                v3.Progress = v3.Progress + u58 * a1
                v3 = a3:FrameAt(Data.Progress)
                v4 = math.clamp(((Workspace:GetServerTimeNow()) - a5) / 0.5, 0, 1)
                v2 = Position:Lerp(v3.Position + v3.UpVector * Tuning.PodHeight, (math.max(v4, 0.25)))
                u59 = u59 + a1
                v1 = v2 - Position
                Data.Position = v2
                if 0.001 < v1.Magnitude then
                    u10:PivotTo((CFrame.lookAt(v2, v2 + v1)) * CFrame.new(0, math.sin(u59 * 9) * 0.35, 0) * (CFrame.Angles(0, 3.141592653589793, (math.sin(u59 * 5)) * 0.2)))
                end
                return
            end
            local Character = if Target ~= nil then if not Target:IsA("Player") then if not Target:IsA("Model") then nil else if Target.Parent == nil then nil else Target else Target.Character else nil
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
                return
            end
            v4 = v3.Position + Vector3.new(0, 1.5, 0)
            v3 = v4 - Position
            local v5 = u58 * 1.15 * a1
            v2 = if not (v3.Magnitude <= v5) then Position + v3.Unit * v5 else v4
            u59 = u59 + a1
            v1 = v2 - Position
            Data.Position = v2
            if 0.001 < v1.Magnitude then
                u10:PivotTo((CFrame.lookAt(v2, v2 + v1)) * CFrame.new(0, math.sin(u59 * 9) * 0.35, 0) * (CFrame.Angles(0, 3.141592653589793, (math.sin(u59 * 5)) * 0.2)))
            end
        end)
    end

    local function onPodLock(a1, a2, a3) -- Line: 845
        -- upvalues: u11 (val), Assets (upval), u6 (val), TweenService (upval), RunService (upval), u91 (upval)
        local v1 = u11[a1]
        if v1 ~= nil and a2 ~= nil then
            v1.Data.Target = a2
            v1.Data.Position = a3:Lerp(v1.Data.Position, 0.5)
            local Character = if a2 ~= nil then if not a2:IsA("Player") then if not a2:IsA("Model") then nil else if a2.Parent == nil then nil else a2 else a2.Character else nil
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            local v2 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            if v2 ~= nil then
                local v3 = v1.Trove:Add((Assets.Effects.Reticle:Clone()))
                v3.Adornee = v2
                v3.Parent = u6
                local Ring = v3:FindFirstChild("Ring")
                Ring.Size = UDim2.fromScale(2.4, 2.4)
                TweenService:Create(
                    Ring,
                    TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Size = UDim2.fromScale(1, 1)}
                ):Play()
                v1.Trove:Connect(RunService.RenderStepped, function() -- Line: 864 -- upvalues: Ring (val)
                    Ring.Rotation = os.clock() * 220 % 360
                end)
                u91.Sound("PodLock", v2)
            end
            return
        end
    end

    local function onPodEnd(a1, a2, a3) -- Line: 871
        -- upvalues: u11 (val), u91 (upval), u6 (val)
        local v1 = u11[a1]
        if v1 ~= nil then
            u11[a1] = nil
            v1.Trove:Destroy()
        end
        local Position = a3 or (if not v1 then nil else v1.Data.Position)
        if Position == nil then
            return
        end
        u91.Emit(u6, "Boom", CFrame.new(Position), 1)
        u91.Sound("Explode", Position)
        if a2 ~= nil then
            u91.Emit(u6, "Stars", CFrame.new(Position), 1.3)
            u91.Sound("Laugh", Position)
        end
    end

    local function onDrilla(a1, a2, a3_2, a4, a5) -- Line: 885
        -- upvalues: Assets (upval), shot (val), a3 (val), u6 (val), u91 (upval), MountRaceFlags (upval), Tuning (upval)
        -- upvalues: RunService (upval), Workspace (upval)
        local u10 = Assets.Models.Drilla:Clone()
        local v1 = shot(a1, "Drilla", u10, (a3:FrameAt(a3_2)) * CFrame.new(0, -12, 0))
        local u33 = v1.Trove:Add((Instance.new("Part")))
        u33.Anchored = true
        u33.CanCollide = false
        u33.CanQuery = false
        u33.CanTouch = false
        u33.Transparency = 1
        u33.Size = Vector3.new(1, 1, 1)
        local v2 = Assets.Effects.Rumble:Clone()
        v2.Parent = u33
        for i, j in v2:GetChildren() do
            if j:IsA("ParticleEmitter") then
                j.Enabled = true
            end
        end
        u33.Parent = u6
        v2 = u91.Sound("DrillaLoop", u33)
        if v2 ~= nil then
            v1.Trove:Add(v2)
        end
        local Sound = u91.Sound
        local Character = if a2 ~= nil then if not a2:IsA("Player") then if not a2:IsA("Model") then nil else if a2.Parent == nil then nil else a2 else a2.Character else nil
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        Sound("Roar", if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart, 1.2)
        local Data = v1.Data
        Data.Progress = a3_2
        local u136 = (MountRaceFlags.TopSpeed:Get()) * Tuning.DrillaSpeed
        local u137 = 0
        v1.Trove:Connect(RunService.RenderStepped, function(a1) -- Line: 912
            -- upvalues: u137 (ref), Data (val), a3 (upval), u136 (val), u33 (val), u10 (val), Workspace (upval)
            local v1
            u137 = u137 + a1 * 20
            if Data.Spot == nil then
                local v2 = Data
                v2.Progress = v2.Progress + u136 * a1
                v1 = a3:FrameAt(Data.Progress)
            else
                v1 = (CFrame.new(Data.Spot)) * a3:FrameAt(Data.Progress).Rotation
            end
            u33.CFrame = v1
            u10:PivotTo(v1 * CFrame.new(0, -3.6, 0) * CFrame.Angles(-1.2217304763960306, 0, 0) * (CFrame.Angles(0, u137, 0)))
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera ~= nil and (CurrentCamera.CFrame.Position - v1.Position).Magnitude < 50 then
                Data.Near = true
            end
        end)
    end

    local function onDrillaWarn(a1, a2, a3, a4) -- Line: 932
        -- upvalues: u11 (val), Assets (upval), Workspace (upval), u10 (val), u6 (val), RunService (upval)
        -- upvalues: TweenService (upval), u91 (upval)
        local u5 = u11[a1]
        if u5 == nil then
            return
        end
        u5.Data.Spot = a3
        local v1 = u5.Trove:Add((Assets.Models.Warning:Clone()))
        local v2 = Workspace:Raycast(a3 + Vector3.new(0, 3, 0), Vector3.new(-0, -10, -0), u10)
        local Normal = if v2 == nil then Vector3.new(0, 1, 0) else v2.Normal
        local fromMatrix = CFrame.fromMatrix
        local Unit = 0.1 < Normal:Cross((Vector3.new(1, 0, 0))).Magnitude and Normal:Cross((Vector3.new(1, 0, 0))).Unit or Vector3.new(0, 0, 1)
        v1:PivotTo((fromMatrix(a3 + Normal * 0.15, Normal, Unit)))
        v1.Parent = u6
        local Disc = v1:FindFirstChild("Disc")
        local u70 = v1:FindFirstChild("Edge")
        local u73 = os.clock()
        local u84 = math.max(a4 - Workspace:GetServerTimeNow(), 0.2)
        u5.Trove:Connect(RunService.RenderStepped, function() -- Line: 952 -- upvalues: u73 (val), u84 (val), TweenService (upval), Disc (val), u70 (val)
            local v1 = math.clamp((os.clock() - u73) / u84, 0, 1)
            local v2 = 0.35 + 0.65 * TweenService:GetValue(math.min(v1 * 2.2, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            Disc.Size = Vector3.new(0.2, 18 * v2, 18 * v2)
            u70.Size = Vector3.new(0.25, 18.6 * v2, 18.6 * v2)
            Disc.Transparency = if not (math.floor((os.clock()) * (v1 * 14 + 6)) % 2 == 0) then 0.7 else 0.35
            u70.Transparency = if not v2 then 0.5 else 0
        end)
        u91.Sound("DrillaWarn", a3)
        task.delay(u84 * 0.5, function() -- Line: 964 -- upvalues: u11 (upval), a1 (val), u5 (val), u91 (upval), a3 (val)
            if u11[a1] == u5 then
                u91.Sound("DrillaWarn", a3, 1.2)
            end
        end)
    end

    local function onDrillaEnd(a1_2, a2, a3) -- Line: 971
        -- upvalues: u11 (val), u91 (upval), u6 (val), Assets (upval), RunService (upval), a1 (val)
        local v1 = u11[a1_2]
        if v1 ~= nil then
            u11[a1_2] = nil
            v1.Trove:Destroy()
        end
        if a3 == nil then
            return
        end
        u91.Emit(u6, "Dirt", CFrame.new(a3), 1.1)
        u91.Sound("DrillaBurst", a3)
        u91.Sound("Roar", a3)
        if a2 ~= nil then
            u91.Emit(u6, "Stars", CFrame.new(a3 + Vector3.new(0, 4, 0)), 1.3)
        end
        local u47 = Assets.Models.Drilla:Clone()
        u47.Parent = u6
        local u50 = os.clock()
        local u51 = 0
        local u52 = nil
        u52 = RunService.RenderStepped:Connect(function(a1) -- Line: 987
            -- upvalues: u50 (val), u51 (ref), u47 (val), a3 (val), u52 (ref), u91 (upval), u6 (upval)
            local v1 = os.clock() - u50
            u51 = u51 + a1 * 26
            local v2 = 26 * v1 - 48 * v1 * v1
            u47:PivotTo((CFrame.new(a3 + Vector3.new(0, 1, 0) * (v2 - 2))) * CFrame.Angles(-1.3962634015954636 + v1 * 2, 0, 0) * (CFrame.Angles(0, u51, 0)))
            if v1 > 0.62 then
                u52:Disconnect()
                u91.Emit(u6, "Dirt", CFrame.new(a3), 0.6)
                u47:Destroy()
            end
        end)
        a1:Add(u52)
        a1:Add(u47)
    end

    local function onEgg(a1_2, a2, a3, a4) -- Line: 1006
        -- upvalues: Assets (upval), a1 (val), u11 (val), u6 (val), u91 (upval), RunService (upval), popIn (upval)
        local u9 = Assets.Models.Splat:Clone()
        local u14 = {Kind = "Egg"}
        u14.Trove = a1:Extend()
        u14.Data = {}
        u11[a1_2] = u14
        u14.Data.Frame = a3
        local Character = if a2 ~= nil then if not a2:IsA("Player") then if not a2:IsA("Model") then nil else if a2.Parent == nil then nil else a2 else a2.Character else nil
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        local v1 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
        local u55 = if v1 == nil then a3.Position + Vector3.new(0, 6, 0) else v1.Position + Vector3.new(0, 2, 0)
        local u72 = u14.Trove:Add((Assets.Models.Egg:Clone()))
        u72:PivotTo((CFrame.new(u55)))
        u72.Parent = u6
        u91.Sound("EggDrop", u55)
        local u87 = os.clock()
        local u88 = false
        u14.Trove:Connect(RunService.RenderStepped, function() -- Line: 1018
            -- upvalues: u87 (val), u88 (ref), u55 (val), a3 (val), u72 (val), u9 (val), u6 (upval), u14 (val)
            -- upvalues: popIn (upval), u91 (upval)
            local v1
            local v2 = math.min((os.clock() - u87) / 0.32, 1)
            if u88 then
                local Yolk = u9:FindFirstChild("Yolk")
                if Yolk ~= nil then
                    v1 = math.sin(os.clock() * 5 + a3.Position.X) * 0.08
                    Yolk.Size = (Vector3.new((v1 + 1) * 3.6, (1 - v1) * 1.1, (v1 + 1) * 3.6)) * u9:GetScale()
                end
                return
            end
            v1 = u55:Lerp(a3.Position, v2)
            local v3 = v2 * 3.141592653589793
            u72:PivotTo((CFrame.new(v1 + Vector3.new(0, 1, 0) * math.sin(v3) * 5)) * (CFrame.Angles(v2 * 7, v2 * 3, 0)))
            if not (v2 >= 1) then
                return
            end
            u88 = true
            u72:Destroy()
            u9:PivotTo(a3)
            u9.Parent = u6
            u14.Trove:Add(u9)
            u14.Model = u9
            popIn(u9, 0.4, 0.2)
            u91.Emit(u6, "Splash", a3, 0.9)
            u91.Sound("Crack", a3.Position)
            u91.Sound("Splat", a3.Position)
        end)
    end

    local function onEggEnd(a1, a2, a3) -- Line: 1046
        -- upvalues: u11 (val), u91 (upval), u6 (val)
        local v1 = u11[a1]
        if v1 ~= nil then
            u11[a1] = nil
            v1.Trove:Destroy()
        end
        local Position = a3 or (if not v1 then nil else v1.Data.Frame.Position)
        if Position == nil then
            return
        end
        if a2 == nil then
            u91.Emit(u6, "Poof", CFrame.new(Position), 0.5)
            return
        end
        u91.Emit(u6, "Splash", CFrame.new(Position), 1.3)
        u91.Sound("Splat", Position, 0.9)
        u91.Sound("Slip", Position)
    end

    local function onBox(a1, a2) -- Line: 1061
        -- upvalues: LocalPlayer (upval), u91 (upval), u6 (val)
        if a1 == LocalPlayer then
            return
        end
        local Pad = a2:FindFirstChild("Pad")
        if Pad ~= nil and Pad:IsA("BasePart") then
            u91.Emit(u6, "Shatter", Pad.CFrame, 0.7)
            u91.Sound("Pickup", Pad.Position)
        end
    end

    local function onBlocked(a1, a2, a3, a4) -- Line: 1072
        -- upvalues: u88 (upval), u91 (upval), u6 (val)
        local v1
        local Character = if a1 ~= nil then if not a1:IsA("Player") then if not a1:IsA("Model") then nil else if a1.Parent == nil then nil else a1 else a1.Character else nil
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
            return
        end
        local v2 = u88[a1]
        if a3 ~= "Shield" or v2 == nil then
            u91.Emit(u6, "Shatter", v1.CFrame, 0.6)
        else
            v2(if typeof(a4) ~= "Vector3" then nil else a4)
        end
        u91.Sound("ShieldBlock", v1)
    end

    local function onHit(a1, a2, a3, a4) -- Line: 1086
        -- upvalues: u91 (upval), u6 (val)
        local v1
        local Character = if a1 ~= nil then if not a1:IsA("Player") then if not a1:IsA("Model") then nil else if a1.Parent == nil then nil else a1 else a1.Character else nil
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
            return
        end
        u91.Emit(u6, "Stars", v1.CFrame * CFrame.new(0, 2.5, 0), 1)
        if a2 == "Spike" then
            u91.Sound("PuffHit", v1)
        end
    end

    local function onUse(a1, a2) -- Line: 1097 -- upvalues: u91 (upval), u6 (val) -- types: a1: userdata, a2: string
        local Character = if a1 ~= nil then if not a1:IsA("Player") then if not a1:IsA("Model") then nil else if a1.Parent == nil then nil else a1 else a1.Character else nil
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
            return
        end
        if a2 == "Pod" then
            local v1
            u91.Emit(u6, "Poof", v1.CFrame * CFrame.new(0, 3, 0), 0.6)
        end
    end

    a1:Connect(Remotes.MountRace.PowerUpMoment.OnClientEvent, function(a1, ...) -- Line: 1107
        -- upvalues: onSpike (val), onSpikeEnd (val), onPod (val), onPodLock (val), onPodEnd (val), onDrilla (val)
        -- upvalues: onDrillaWarn (val), onDrillaEnd (val), onEgg (val), onEggEnd (val), onBox (val), onBlocked (val)
        -- upvalues: onHit (val), u91 (upval), u6 (val), u11 (val)
        local v1, v2
        if a1 == "Spike" then
            onSpike(...)
            return
        end
        if a1 == "SpikeEnd" then
            onSpikeEnd(...)
            return
        end
        if a1 == "Pod" then
            onPod(...)
            return
        end
        if a1 == "PodLock" then
            onPodLock(...)
            return
        end
        if a1 == "PodEnd" then
            onPodEnd(...)
            return
        end
        if a1 == "Drilla" then
            onDrilla(...)
            return
        end
        if a1 == "DrillaWarn" then
            onDrillaWarn(...)
            return
        end
        if a1 == "DrillaEnd" then
            onDrillaEnd(...)
            return
        end
        if a1 == "Egg" then
            onEgg(...)
            return
        end
        if a1 == "EggEnd" then
            onEggEnd(...)
            return
        end
        if a1 == "Box" then
            onBox(...)
            return
        end
        if a1 == "Blocked" then
            onBlocked(...)
            return
        end
        if a1 == "Hit" then
            onHit(...)
            return
        end
        if a1 == "Use" then
            local v3
            v1, v2 = ...
            local Character = if v1 ~= nil then if not v1:IsA("Player") then if not v1:IsA("Model") then nil else if v1.Parent == nil then nil else v1 else v1.Character else nil
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil
                or v2 ~= "Pod" then
                return
            end
            u91.Emit(u6, "Poof", v3.CFrame * CFrame.new(0, 3, 0), 0.6)
            return
        end
        if a1 ~= "Clear" then
            if a1 == "BotSwap" then
                v1 = ...
                if typeof(v1) == "Vector3" then
                    u91.Emit(u6, "Poof", CFrame.new(v1), 1.6)
                end
            end
            return
        end
        v1 = ...
        v2 = u11[v1]
        if v2 == nil then
            return
        end
        u11[v1] = nil
        v2.Trove:Destroy()
    end)
    return u6
end

return u91