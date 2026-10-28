-- Script path: ReplicatedStorage.Client.ShrineFusionSequences.VoidRitual
-- Decompile time: 245.06 ms

local ContentProvider = game:GetService("ContentProvider")
game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local Audio = require(ReplicatedStorage.Shared.Audio)
local ShrineFusionFlags = require(ReplicatedStorage.Shared.Flags.ShrineFusionFlags)
local Kit = require(script.Parent.Kit)
local ShrinePadPets = require(ReplicatedStorage.Client.ShrinePadPets)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u62 = table.freeze({
    Sparkle = "rbxasset://textures/particles/sparkles_main.dds",
    Shockwave = "rbxassetid://109600784699514",
    Flare = "rbxassetid://105427977618886",
    Shard = "rbxassetid://140284431017219",
    Energy = "rbxassetid://85003420967228",
    Smoke = "rbxassetid://11917388916",
    Glow = "rbxassetid://119472448303122",
    Spark = "rbxassetid://102994739118592",
    Fire = "rbxassetid://86657672959540",
    Flame = "rbxassetid://16860419961",
    Swirl = "rbxassetid://127031165095122",
    TetherCore = "rbxassetid://118222722924836",
    TetherGlow = "rbxassetid://13530570401",
    TetherFlow = "rbxassetid://13526801263",
    EggVeins = "rbxassetid://96731066947230",
    Lantern = "rbxassetid://116399120112092",
})
local u65 = table.freeze({
    Pulse = 0.3,
    Crack = 0.9,
    Tear = 1.45,
    EyeOpen = 2.6,
    Gaze = 3.4,
    Link = 4.2,
    Lock = 4.25,
    PetLift = 4.6,
    Build = 4.9,
    PairOrbit = 5.3,
    Rattle = 5.6,
    Lift = 6.5,
    GroupOrbit = 7.3,
    Squint = 7.7,
    Dissolve = 9,
    Blink = 10.4,
    Merge = 11.8,
    Narrow = 12.4,
    Return = 12.9,
    Close = 13.7,
    Implode = 14.15,
    Flash = 14.45,
    Condense = 14.55,
    Egg = 15.3,
})
local u68 = table.freeze({
    Split = 0.45,
    Land = 1.35,
    Handoff = 2.1,
    Caught = 2.9,
    Done = 3.7,
})
local u77 = table.freeze({3.62, 5.45, 6.05, 8.35, 10.4, 11.3})
local u108 = table.freeze({
    Vector2.new(-1, 0.15),
    Vector2.new(0.85, -0.35),
    Vector2.new(-0.25, 0.7),
    Vector2.new(1, 0.25),
    Vector2.new(-0.8, -0.5),
    Vector2.new(0.3, -0.75),
    (Vector2.new(-0.55, 0.45)),
})
local u123 = table.freeze({Open = {0, 0}, Narrow = {-22, 15}, Closed = {-64, 42}, Flare = {12, -9}})
local u126 = table.freeze({Fish = "Ghost Fish", Pumpkin = "Voidseer Pumpkin", Fused = "Cursed Fish"})
local u131 = Color3.fromRGB(150, 232, 255)
local u136 = Color3.fromRGB(222, 250, 255)
local u141 = Color3.fromRGB(156, 76, 255)
local u146 = Color3.fromRGB(214, 162, 255)
local u151 = Color3.fromRGB(70, 20, 150)
local u156 = Color3.fromRGB(236, 224, 255)
local u161 = Color3.fromRGB(176, 112, 255)
local u166 = Color3.new(1, 1, 1)
local u171 = Color3.fromRGB(255, 70, 225)
local u176 = Color3.fromRGB(255, 184, 56)
local u181 = Color3.fromRGB(58, 20, 104)
local u186 = Color3.fromRGB(232, 230, 246)
local u191 = Color3.fromRGB(196, 140, 255)
local u196 = Color3.fromRGB(214, 190, 255)
local u201 = Color3.fromRGB(240, 228, 255)
local u207 = table.freeze({
    ["Zombified Halloween Sabertooth"] = table.freeze({Shell = "Cube.179", Bone = "Cube.182", Gold = "Icosphere.004"}),
})
local u211 = table.freeze({["rbxassetid://129580486379843"] = true})
local u214 = table.freeze({SwirlCore = 0.5, SwirlMain = 0.4, Halo = 0.6, EyeGlow = 0.7})
local u217 = table.freeze({
    VoidDisc = true,
    SwirlBack = true,
    SwirlMain = true,
    SwirlCore = true,
    Halo = true,
})
local u220 = table.freeze({candles = 12, potions = 4, books = 22})
local u227 = table.freeze({"PropRattle", "PropRattle2", "PropRattle3", "PropRattle4"})
local v1 = {}
local u229 = nil
local u231 = Random.new()
local u232 = nil
task.spawn(function() -- Line: 148 -- upvalues: ReplicatedStorage (val), u232 (ref)
    local v1
    local Shared = ReplicatedStorage:FindFirstChild("Shared")
    if not (if not Shared then nil else Shared:FindFirstChild("Util")) then
        return
    end
    local VoidFusionSounds = v1:WaitForChild("VoidFusionSounds", 30)
    if VoidFusionSounds and VoidFusionSounds:IsA("ModuleScript") then
        local success, err = pcall(require, VoidFusionSounds)
        if success and type(err) == "table" then
            u232 = err
        end
    end
end)
task.spawn(function() -- Line: 163 -- upvalues: ContentProvider (val), u62 (val)
    pcall(function() -- Line: 164 -- upvalues: ContentProvider (upval), u62 (upval)
        ContentProvider:PreloadAsync({u62.Glow, u62.EggVeins, u62.Lantern, u62.Flame, u62.Swirl})
    end)
end)

local function sounds() -- Line: 177 -- upvalues: u232 (ref), ReplicatedStorage (val)
    if u232 then
        return u232
    end
    local Util = ReplicatedStorage.Shared:FindFirstChild("Util")
    local VoidFusionSounds = if not Util then nil else Util:FindFirstChild("VoidFusionSounds")
    if VoidFusionSounds and VoidFusionSounds:IsA("ModuleScript") then
        local success, err = pcall(require, VoidFusionSounds)
        if success and type(err) == "table" then
            u232 = err
            return err
        end
    end
    return {}
end

local function assetNumber(a1) -- Line: 193
    if type(a1) == "number" then
        return a1
    end
    if type(a1) == "string" then
        return (tonumber((string.match(a1, "%d+"))))
    end
    return nil
end

local function ritualSeconds(a1) -- Line: 202 -- upvalues: ShrineFusionFlags (val) -- types: a1: string
    return ShrineFusionFlags.ShrineRitualSeconds:Get()[a1] or ShrineFusionFlags.RitualSeconds:Get()
end

local function voidAssets() -- Line: 206 -- upvalues: ReplicatedStorage (val)
    local FusionShrine = ReplicatedStorage.Assets:FindFirstChild("FusionShrine")
    if FusionShrine then
        return (FusionShrine:FindFirstChild("Void"))
    end
    return nil
end

local function container(a1) -- Line: 211 -- upvalues: Workspace (val) -- types: a1: userdata?
    local Folder = Instance.new("Folder")
    Folder.Name = "VoidFusion"
    Folder.Parent = a1 or Workspace:FindFirstChild("Transient") or Workspace
    return Folder
end

local function partsOf(a1) -- Line: 218 -- types: a1: userdata?
    local v1 = {}
    if a1 then
        if a1:IsA("BasePart") then
            table.insert(v1, a1)
        end
        for i, j in a1:GetDescendants() do
            if j:IsA("BasePart") then
                table.insert(v1, j)
            end
        end
    end
    return v1
end

local function boundsOf(a1) -- Line: 233 -- types: a1: userdata
    if a1:IsA("Model") then
        return a1:GetBoundingBox()
    end
    if a1:IsA("BasePart") then
        return a1.CFrame, a1.Size
    end
    return CFrame.identity, (Vector3.new(0, 0, 0))
end

local function corners(a1) -- Line: 242 -- types: a1: table
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = Vector3.new(1, 1, 1) * (1 / 0)
    local v10 = Vector3.new(-1, -1, -1) * (1 / 0)
    local v11 = nil
    local v12 = nil
    for i, j in a1, v11, v12 do
        v7 = j.Size / 2
        v8 = {-1, 1}
        v1 = nil
        v2 = nil
        for k, n in v8, v1, v2 do
            v3 = {-1, 1}
            v4 = nil
            v5 = nil
            for m, i5 in v3, v4, v5 do
                for i6, i7 in {-1, 1} do
                    v6 = j.CFrame:PointToWorldSpace((Vector3.new(v7.X * n, v7.Y * i5, v7.Z * i7)))
                    v9 = v9:Min(v6)
                    v10 = v10:Max(v6)
                end
            end
        end
    end
    return v9, v10
end

local function cubic(a1, a2, a3, a4, a5) -- Line: 261
    -- upvalues: 
    local v1 = 1 - a5
    return a1 * (v1 * v1 * v1) + a2 * (v1 * 3 * v1 * a5) + a3 * (v1 * 3 * a5 * a5) + a4 * (a5 * a5 * a5)
end

local function axisFrame(a1, a2) -- Line: 266 -- types: a1: vector, a2: vector
    local Unit
    local Unit_2 = Unit:Cross(if not (0.98 < (math.abs(((if not (0.001 < a2.Magnitude) then Vector3.new(0, 1, 0) else a2.Unit):Dot((Vector3.new(0, 1, 0))))))) then Vector3.new(0, 1, 0) else Vector3.new(0, 0, 1)).Unit
    return CFrame.fromMatrix(a1, Unit, (Unit_2:Cross(Unit)).Unit, Unit_2)
end

local function rotateFlat(a1, a2) -- Line: 274 -- types: a1: vector, a2: number
    return (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), a2)):VectorToWorldSpace(a1)
end

local function scaleSequence(a1, a2) -- Line: 278 -- types: a1: userdata, a2: number
    local v1 = {}
    for i, j in a1.Keypoints do
        table.insert(v1, (NumberSequenceKeypoint.new(j.Time, j.Value * a2, j.Envelope * a2)))
    end
    return NumberSequence.new(v1)
end

local function scaleTree(a1, a2) -- Line: 286 -- upvalues: scaleSequence (val) -- types: a1: userdata, a2: number
    local new, v1
    for i, j in a1:GetDescendants() do
        if j:IsA("Attachment") then
            j.Position = j.Position * a2
        elseif j:IsA("ParticleEmitter") then
            j.Size = scaleSequence(j.Size, a2)
            new = NumberRange.new
            v1 = j.Speed.Min * a2
            j.Speed = new(v1, j.Speed.Max * a2)
            j.Acceleration = j.Acceleration * a2
            j.ZOffset = j.ZOffset * a2
        elseif j:IsA("Beam") then
            j.Width0 = j.Width0 * a2
            j.Width1 = j.Width1 * a2
        end
    end
end

local function holders(a1, a2) -- Line: 302 -- types: a1: userdata, a2: string
    local v1 = {}
    local v2 = a2
    for i, j in a1:GetDescendants() do
        if j:IsA("Attachment") then
            if j:GetAttribute("Phase") == v2 then
                table.insert(v1, j)
            end
        elseif j:IsA("BasePart") and j:GetAttribute("Phase") == v2 then
            table.insert(v1, j)
        end
    end
    return v1
end

local function burstPhase(a1, a2) -- Line: 315 -- upvalues: holders (val) -- types: a1: userdata, a2: string
    local Attribute
    for i, j in holders(a1, a2) do
        for k, n in j:GetChildren() do
            if n:IsA("ParticleEmitter") then
                Attribute = n:GetAttribute("EmitCount")
                n:Emit(Attribute or 1)
            end
        end
    end
end

local function hitOf(a1) -- Line: 325 -- upvalues: sounds (val) -- types: a1: string
    local v1 = sounds()[a1]
    if type(v1) == "table" then
        return tonumber(v1.Hit) or 0
    end
    return 0
end

local function sound(a1, a2, a3, a4, a5) -- Line: 330
    -- upvalues: sounds (val), Audio (val)
    local v1
    local v2 = sounds()[a2]
    if type(v2) ~= "table" then
        return nil
    end
    local Id = v2.Id
    if not (if type(Id) == "number" then Id else if type(Id) ~= "string" then nil else tonumber((string.match(Id, "%d+")))) then
        return nil
    end
    local success, err = pcall(Audio.Play, v1, a3 or a1.Center, {
        MaxDistance = 260,
        Volume = (tonumber(v2.Volume) or 1) * (a4 or 1),
        PlaybackSpeed = a5 or 1,
        Looped = v2.Looped == true,
    })
    if success and typeof(err) == "Instance" then
        a1.Sounds[err] = true
        return err
    end
    return nil
end

local function fadeOut(a1, a2) -- Line: 352 -- upvalues: TweenService (val) -- types: a1: userdata?, a2: number
    if a1 and a1.Parent then
        local v1 = TweenService:Create(a1, TweenInfo.new(a2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Volume = 0})
        v1.Completed:Once(function() -- Line: 361 -- upvalues: a1 (val)
            a1:Stop()
        end)
        v1:Play()
        return
    end
end

local function loop(a1, a2, a3, a4) -- Line: 367 -- upvalues: sound (val) -- types: a2: string, a4: number?
    if a1.Loops[a2] then
        return
    end
    a1.Loops[a2] = sound(a1, a2, a3, a4) or false
end

local function stopLoop(a1, a2, a3) -- Line: 374 -- upvalues: fadeOut (val) -- types: a2: string, a3: number
    local v1 = a1.Loops[a2]
    if v1 then
        fadeOut(v1, a3)
    end
end

local function startBed(a1) -- Line: 381 -- upvalues: Workspace (val), sounds (val)
    local v1
    local CurrentCamera = Workspace.CurrentCamera
    local Bed = sounds().Bed
    if type(Bed) ~= "table" then
        v1 = nil
    else
        local Id = Bed.Id
        v1 = if type(Id) == "number" then Id else if type(Id) ~= "string" then nil else tonumber((string.match(Id, "%d+")))
    end
    if a1.Participant and CurrentCamera and v1 and not a1.Bed then
        local Sound = Instance.new("Sound")
        Sound.Name = "VoidFusionBed"
        Sound.SoundId = ("rbxassetid://%*"):format(v1)
        Sound.Volume = tonumber(Bed.Volume) or 0.8
        Sound.TimePosition = math.max((Workspace:GetServerTimeNow()) - a1.StartAt, 0)
        Sound.Parent = CurrentCamera
        Sound.Ended:Once(function() -- Line: 394 -- upvalues: Sound (val)
            Sound:Destroy()
        end)
        Sound:Play()
        a1.Bed = Sound
        return
    end
end

local function kick(a1, a2) -- Line: 401 -- upvalues: Kit (val), Shake (val) -- types: a2: number
    a1.ShakePower = math.max(a1.ShakePower, a2)
    if not a1.Participant and not Kit.ReducedMotion() then
        Shake.Play({
            Seconds = a2 * 0.4 + 0.5,
            Magnitude = a2,
            Range = {Near = 30, Far = 140, Center = a1.Center},
        })
    end
end

local function host(a1, a2, a3, a4) -- Line: 412 -- upvalues: Kit (val) -- types: a2: userdata, a3: vector?, a4: string?
    local v1 = Kit.Part({
        Transparency = 1,
        Name = a4 or "VoidHost",
        Size = a3 or Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = a2,
    })
    v1.Parent = a1.Container
    return v1
end

local function burst(a1, a2, a3, a4, a5) -- Line: 423
    -- upvalues: Kit (val)
    local v1 = CFrame.new(a2)
    local u13 = Kit.Part({
        Name = "VoidBurst",
        Transparency = 1,
        Size = a5 or Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v1,
    })
    u13.Parent = a1.Container
    Kit.Emitter(u13, a3):Emit(a4)
    task.delay(4, function() -- Line: 433 -- upvalues: u13 (val)
        u13:Destroy()
    end)
end

local function flatWave(a1, a2, a3, a4, a5) -- Line: 438
    -- upvalues: burst (val), u62 (val)
    burst(a1, a2, {
        ZOffset = 1,
        Texture = u62.Shockwave,
        Color = ColorSequence.new(a3),
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(0.01),
        Lifetime = NumberRange.new(a5),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, a4 * 0.08),
            (NumberSequenceKeypoint.new(1, a4)),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(0.6, 0.45),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }, 1)
end

local function faceWave(a1, a2, a3, a4, a5) -- Line: 459
    -- upvalues: burst (val), u62 (val)
    burst(a1, a2, {
        ZOffset = 4,
        Texture = u62.Shockwave,
        Color = ColorSequence.new(a3),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(a5),
        Rotation = NumberRange.new(0, 360),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, a4 * 0.1),
            (NumberSequenceKeypoint.new(1, a4)),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.15),
            NumberSequenceKeypoint.new(0.5, 0.5),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }, 1)
end

local function sparkleBurst(a1, a2, a3, a4, a5) -- Line: 479
    -- upvalues: burst (val), u62 (val), u166 (val)
    burst(a1, a2, {
        Drag = 3,
        ZOffset = 1,
        Texture = u62.Spark,
        Color = ColorSequence.new(u166, a3),
        Orientation = Enum.ParticleOrientation.VelocityParallel,
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(a5 * 0.4, a5),
        Lifetime = NumberRange.new(0.5, 1.1),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.15, 1.1),
            (NumberSequenceKeypoint.new(1, 0)),
        }),
    }, a4)
end

local function glowFlare(a1, a2, a3, a4, a5) -- Line: 497
    -- upvalues: burst (val), u62 (val)
    burst(a1, a2, {
        ZOffset = 3,
        Texture = u62.Flare,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Color = ColorSequence.new(a3),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(a5 or 0.45),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, a4 * 0.3),
            NumberSequenceKeypoint.new(0.25, a4),
            (NumberSequenceKeypoint.new(1, a4 * 1.15)),
        }),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), (NumberSequenceKeypoint.new(1, 1))}),
    }, 1)
end

local function shardBurst(a1, a2, a3, a4, a5) -- Line: 518
    -- upvalues: burst (val), u62 (val)
    burst(a1, a2, {
        LightEmission = 0.6,
        Drag = 2.6,
        Acceleration = Vector3.new(0, -14, 0),
        ZOffset = 1,
        Texture = u62.Shard,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Color = ColorSequence.new(a3),
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(a5 * 0.5, a5),
        Lifetime = NumberRange.new(0.9, 1.6),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-260, 260),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.9),
            NumberSequenceKeypoint.new(0.8, 0.7),
            (NumberSequenceKeypoint.new(1, 0)),
        }),
    }, a4)
end

local function sideColor(a1, a2) -- Line: 541
    -- upvalues: u131 (val), u136 (val), u141 (val), u146 (val)
    if a2 == a1.Kind.Sides[1] then
        return u131, u136
    end
    return u141, u146
end

local function geometry(a1) -- Line: 548 -- upvalues: Workspace (val), partsOf (val), corners (val)
    local Center = a1.Center
    local building = if not a1.Interior then nil else a1.Interior:FindFirstChild("building")
    local v1 = RaycastParams.new()
    if not building then
        v1.FilterType = Enum.RaycastFilterType.Exclude
        v1.FilterDescendantsInstances = {a1.Container, a1.Shrine}
    else
        v1.FilterType = Enum.RaycastFilterType.Include
        v1.FilterDescendantsInstances = {building}
    end
    local v2 = Workspace:Raycast(Center, Vector3.new(-0, -80, -0), v1)
    local v3 = Workspace:Raycast(Center, Vector3.new(0, 80, 0), v1)
    local Y = if not v2 then Center.Y - 14 else v2.Position.Y
    a1.Floor = Y
    local Y_2 = if not v3 then Center.Y + 16 else v3.Position.Y
    a1.Ceiling = Y_2
    v3 = if not building then nil else building:FindFirstChild("fusion room")
    v3 = partsOf(if not v3 then nil else v3:FindFirstChild("floors"))
    if not (#v3 > 0) then
        a1.Low = Vector3.new(Center.X - 40, a1.Floor, Center.Z - 40)
        a1.High = Vector3.new(Center.X + 40, a1.Ceiling, Center.Z + 40)
    else
        local v4, v5 = corners(v3)
        a1.Low = Vector3.new(v4.X + 2.5, a1.Floor, v4.Z + 2.5)
        a1.High = Vector3.new(v5.X - 2.5, a1.Ceiling, v5.Z - 2.5)
    end
    a1.WallReach = math.max(math.min(Center.X - a1.Low.X, a1.High.X - Center.X, Center.Z - a1.Low.Z, a1.High.Z - Center.Z), 10)
    a1.RiftSize = math.clamp((math.min(a1.Ceiling - Center.Y, Center.Y - a1.Floor)) * 1.25, 10, 19)
end

local function inside(a1, a2, a3) -- Line: 585 -- types: a2: vector, a3: number
    local v1 = false
    local X = a2.X
    if a1.Low.X + a3 < X then
        v1 = false
        if a2.X < a1.High.X - a3 then
            v1 = false
            local Z = a2.Z
            if a1.Low.Z + a3 < Z then
                v1 = a2.Z < a1.High.Z - a3
            end
        end
    end
    return v1
end

local function clampRoom(a1, a2) -- Line: 592 -- types: a2: vector
    return (Vector3.new(
        math.clamp(a2.X, a1.Low.X + 1, a1.High.X - 1),
        math.clamp(a2.Y, a1.Floor + 1.6, a1.Ceiling - 1.6),
        (math.clamp(a2.Z, a1.Low.Z + 1, a1.High.Z - 1))
    ))
end

local function flatAngle(a1, a2) -- Line: 600 -- types: a2: vector
    return (math.atan2(a2:Dot(a1.Side), (a2:Dot(a1.Across))))
end

local function planOrbits(a1) -- Line: 604
    local Across_2, Magnitude, Side_2, v1, v2, v3, v4, v5
    local v6 = #a1.Pets
    if v6 == 0 then
        return
    end
    local v7 = Vector3.new(0, 0, 0)
    local v8 = {}
    local v9 = nil
    local v10 = nil
    local v11 = a1
    for i, j in a1.Pets, v9, v10 do
        v7 = v7 + j.Home.Position
        Side_2 = j.Side
        v1 = v8[j.Side] or {}
        v8[Side_2] = v1
        table.insert(v8[j.Side], j)
    end
    v11.PetHub = v7 / v6
    v11.PetOrbit = math.clamp(v11.RowSpan * 0.32, 8, 16)
    v9 = nil
    v10 = nil
    for k, n in v8, v9, v10 do
        v7 = Vector3.new(0, 0, 0)
        for m, i5 in n do
            v7 = v7 + i5.Home.Position
        end
        v7 = v7 / #n
        v1 = nil
        v2 = nil
        for i6, i7 in n, v1, v2 do
            Across_2 = i7.Home.Position - v7
            Magnitude = Vector3.new(Across_2.X, 0, Across_2.Z).Magnitude
            if Magnitude < 0.5 then
                Across_2 = v11.Across
                v7 = i7.Home.Position - v11.Across * 1.6
            end
            i7.PairMid = v7
            i7.PairRadius = Magnitude
            v4 = Across_2:Dot(v11.Side)
            v5 = Across_2:Dot(v11.Across)
            i7.PairAngle = math.atan2(v4, v5)
            v3 = if k ~= v11.Kind.Sides[1] then -1 else 1
            i7.Spin = v3
        end
    end
    for i8, i9 in v11.Pets do
        v2 = i9.Order - 1
        i9.GroupAngle = 3.141592653589793 - v2 * (6.283185307179586 / v6)
    end
end

local function petOrbit(a1, a2, a3) -- Line: 643 -- upvalues: Kit (val), u65 (val) -- types: a3: number
    local Position = a2.Home.Position
    if not a2.PairMid then
        return Position, 0
    end
    local v1 = Kit.Smooth(Kit.Window(a3, u65.PetLift, u65.PetLift + 1.3))
    local v2 = Kit.Smooth(Kit.Window(a3, u65.PairOrbit, u65.PairOrbit + 1.2))
    local v3 = Kit.Smooth(Kit.Window(a3, u65.GroupOrbit, u65.GroupOrbit + 1.4))
    local v4 = Kit.Smooth(Kit.Window(a3, u65.GroupOrbit, u65.Dissolve + 1.2))
    local v5 = a2.Spin * 1.1 * math.max(a3 - u65.PairOrbit, 0) ^ 1.45
    local v6 = a2.PairAngle + v5
    local v7 = a2.PairMid + (a1.Across * math.cos(v6) + a1.Side * math.sin(v6)) * (a2.PairRadius * (1 - 0.2 * v2))
    v6 = math.max(a3 - u65.GroupOrbit, 0) ^ 1.5 * 1.2
    local v8 = a2.GroupAngle + v6
    local v9 = (a1.PetHub:Lerp(a1.Center, 0.25 * v4)) + (a1.Across * math.cos(v8) + a1.Side * math.sin(v8) * 0.6) * (a1.PetOrbit * (0.8 + 0.3 * v4))
    local v10 = (Position:Lerp(v7, v2)):Lerp(v9, v3)
    v9 = Position.Y + 3.2 * v1 + 1.6 * v2 + v3 * (2 + 5 * v4)
    v8 = v5 * v2 * (1 - v3) + v6 * v3
    local v11 = Vector3.new(v10.X, v9, v10.Z)
    return Vector3.new(
        math.clamp(v11.X, a1.Low.X + 1, a1.High.X - 1),
        math.clamp(v11.Y, a1.Floor + 1.6, a1.Ceiling - 1.6),
        (math.clamp(v11.Z, a1.Low.Z + 1, a1.High.Z - 1))
    ), v8
end

local function buildPets(a1) -- Line: 669
    -- upvalues: ShrinePadPets (val), Kit (val), Assets (val), u131 (val), u136 (val), u141 (val), u146 (val)
    -- upvalues: partsOf (val), u65 (val), u231 (val), u166 (val), u62 (val), planOrbits (val)
    local Animations, BoundingBox_2, PointLight, v1, v2, v3, v4, v5, v6, v7, v8, v9
    a1.Pets = {}
    local Recipe = a1.Recipe
    local v10 = {}
    if not a1.Seats then
        for i, j in a1.Kind.Sides do
            v8 = a1.Pads[j]
            if v8 then
                table.insert(v10, {Side = j, Pad = v8, Seat = i})
            end
        end
    else
        v6 = nil
        v7 = nil
        for k, n in a1.Seats, v6, v7 do
            for m, i5 in a1.Kind.Sides do
                if n[i5] then
                    table.insert(v10, {Side = i5, Pad = n[i5], Seat = k})
                end
            end
        end
    end
    table.sort(v10, function(a1_2, a2) -- Line: 689 -- upvalues: a1 (val)
        return ((a1_2.Pad.Position - a1.Row):Dot(a1.Across)) < (a2.Pad.Position - a1.Row):Dot(a1.Across)
    end)
    v6 = nil
    v7 = nil
    for i6, i7 in v10, v6, v7 do
        v8 = Recipe[i7.Side]
        v9 = ShrinePadPets.Size(a1.Kind, i7.Side)
        v1 = if not v8 then nil else Kit.PetModel(v8, v9, ShrinePadPets.Template(v8))
        if v1 then
            v9 = Assets.Directory[v8] or {}
            Animations = v9.Animations or {}
            v9 = ShrinePadPets.Home(a1.Kind, i7.Side, i7.Pad, a1.Row)
            v1:PivotTo(v9)
            v1.Parent = a1.Container
            if i7.Side ~= a1.Kind.Sides[1] then
                v2 = u141
                v3 = u146
            else
                v2 = u131
                v3 = u136
            end
            _, BoundingBox_2 = v1:GetBoundingBox()
            v4 = {
                Side = i7.Side,
                Model = v1,
                Home = v9,
                Pad = i7.Pad,
                Top = i7.Pad.Position + Vector3.new(0, 1, 0) * (i7.Pad.Size.Y / 2),
                Seat = i7.Seat,
                Order = i6,
                Color = v2,
                Hot = v3,
                Base = v1:GetScale(),
                Height = BoundingBox_2.Y,
            }
            v4.Track = Kit.PlayAnimation(v1, Animations.Idle or Animations.Walk, 1)
            v4.Parts = partsOf(v1)
            v4.Fx = {}
            v4.DissolveAt = u65.Dissolve + (i6 - 1) * 0.42
            v4.Bob = u231:NextNumber(0, 6.283185307179586)
            for i8, i9 in v1:GetDescendants() do
                if i9:IsA("ParticleEmitter") or i9:IsA("Beam") or i9:IsA("Trail") or i9:IsA("Light") then
                    table.insert(v4.Fx, i9)
                end
            end
            v8 = Instance.new("Highlight")
            v8.Adornee = v1
            v8.FillColor = v3
            v8.OutlineColor = u166
            v8.FillTransparency = 1
            v8.OutlineTransparency = 1
            v8.DepthMode = Enum.HighlightDepthMode.Occluded
            v8.Parent = a1.Container
            v4.Highlight = v8
            v5 = CFrame.new(v9.Position + Vector3.new(0, 1, 0) * BoundingBox_2.Y * 0.45)
            v1 = Kit.Part({
                Name = "PetCore",
                Transparency = 1,
                Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
                CFrame = v5,
            })
            v1.Parent = a1.Container
            v4.Core = v1
            v4.Energy = Kit.Emitter(v1, {
                ZOffset = 1,
                Texture = u62.Energy,
                FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
                FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
                Color = ColorSequence.new(v3, v2),
                SpreadAngle = Vector2.new(180, 180),
                Speed = NumberRange.new(2, 6),
                Lifetime = NumberRange.new(0.6, 1),
                Rotation = NumberRange.new(0, 360),
                RotSpeed = NumberRange.new(-120, 120),
                Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1.6),
                    (NumberSequenceKeypoint.new(1, 0.2)),
                }),
                Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))}),
            })
            v4.Motes = Kit.Emitter(v1, {
                Texture = u62.Spark,
                Orientation = Enum.ParticleOrientation.VelocityParallel,
                Color = ColorSequence.new(u166, v3),
                SpreadAngle = Vector2.new(180, 180),
                Speed = NumberRange.new(4, 9),
                Lifetime = NumberRange.new(0.4, 0.8),
                Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.2, 0.6),
                    (NumberSequenceKeypoint.new(1, 0)),
                }),
            })
            PointLight = Instance.new("PointLight")
            PointLight.Color = v2
            PointLight.Range = 12
            PointLight.Brightness = 0
            PointLight.Shadows = false
            PointLight.Parent = v1
            v4.Glow = PointLight
            table.insert(a1.Pets, v4)
            a1.RowSpan = math.max(a1.RowSpan, (math.abs(((v4.Top - a1.Row):Dot(a1.Across)))) * 2)
        end
    end
    planOrbits(a1)
end

local function buildPads(a1) -- Line: 795 -- upvalues: Kit (val), u62 (val)
    local v1, v2, v3, v4
    a1.PadFx = {}
    for i, j in a1.Pets do
        v3 = CFrame.new(j.Top + Vector3.new(0, 0.30000001192092896, 0))
        v2 = Kit.Part({
            Name = "PadFlare",
            Transparency = 1,
            Size = Vector3.new(5, 0.20000000298023224, 5),
            CFrame = v3,
        })
        v2.Parent = a1.Container
        v1 = Instance.new("PointLight")
        v1.Color = j.Color
        v1.Range = 14
        v1.Brightness = 0
        v1.Shadows = false
        v1.Parent = v2
        v3 = Kit.Emitter(v2, {
            Texture = u62.Glow,
            Color = ColorSequence.new(j.Hot, j.Color),
            EmissionDirection = Enum.NormalId.Top,
            Speed = NumberRange.new(3, 7),
            Lifetime = NumberRange.new(0.8, 1.4),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), (NumberSequenceKeypoint.new(1, 0))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), (NumberSequenceKeypoint.new(1, 1))}),
            Shape = Enum.ParticleEmitterShape.Disc,
            ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        })
        v4 = Kit.Emitter(v2, {
            ZOffset = 0.5,
            Texture = u62.Shockwave,
            Color = ColorSequence.new(j.Color),
            Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
            EmissionDirection = Enum.NormalId.Top,
            Speed = NumberRange.new(0.01),
            Lifetime = NumberRange.new(1.2),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4), (NumberSequenceKeypoint.new(1, 9))}),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.3, 0.55),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
        })
        table.insert(a1.PadFx, {
            Pet = j,
            Part = v2,
            Light = v1,
            Column = v3,
            Runes = v4,
        })
    end
end

local function eyePlug(a1, a2) -- Line: 851 -- upvalues: Kit (val)
    local EyeNow = a1.EyeNow or CFrame.lookAt(a1.Center, a1.Center + a1.Side)
    local EyeK = a1.EyeK
    local EyeWidth = a1.EyeWidth or a1.RiftSize * 0.6
    local v1 = EyeWidth * (EyeK or 1)
    local v2 = math.max(#a1.Pets, 1)
    v2 = math.rad((Kit.Lerp(-152, -28, if not (v2 > 1) then 0.5 else (a2.Order - 1) / (v2 - 1))))
    local v3 = Vector3.new(math.cos(v2), math.sin(v2), 0)
    return (EyeNow:PointToWorldSpace(v3 * v1 * 0.2 + (Vector3.new(0, 0, v1 * 0.06)))), EyeNow:VectorToWorldSpace(-v3 * 0.45 + Vector3.new(0, 0, 0.8999999761581421)).Unit
end

local function tetherFrames(a1, a2, a3) -- Line: 864 -- upvalues: eyePlug (val), axisFrame (val) -- types: a3: vector
    local v1, v2 = eyePlug(a1, a2)
    local Magnitude = (v1 - a3).Magnitude
    return (axisFrame(a3, Vector3.new(0, 1, 0) + a1.Side * 0.15)), (axisFrame(v1, v2)), Magnitude * 0.5, Magnitude * 0.42
end

local function makeBeam(a1, a2, a3, a4) -- Line: 873 -- types: a1: userdata, a2: userdata, a3: userdata
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = a2
    Beam.Attachment1 = a3
    Beam.Texture = a4.Texture
    Beam.TextureMode = Enum.TextureMode.Wrap
    Beam.TextureLength = a4.Length
    Beam.TextureSpeed = a4.Speed
    Beam.Color = a4.Color
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.Brightness = a4.Brightness or 1
    Beam.FaceCamera = true
    Beam.Segments = 32
    Beam.Width0 = 0
    Beam.Width1 = 0
    Beam.Transparency = a4.Transparency
    Beam.ZOffset = a4.ZOffset or 0
    Beam.Enabled = false
    Beam.Parent = a1
    return Beam
end

local function buildTethers(a1) -- Line: 896
    -- upvalues: Kit (val), makeBeam (val), u62 (val), u141 (val), u146 (val), u65 (val), u166 (val)
    local Attachment, Attachment_2, Position, v1, v2, v3, v4, v5
    a1.Tethers = {}
    local v6 = CFrame.new(a1.Center)
    local v7 = Kit.Part({
        Name = "TetherHeart",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v6,
    })
    v7.Parent = a1.Container
    local v8 = nil
    local v9 = nil
    local v10 = a1
    for i, j in a1.Pets, v8, v9 do
        Position = j.Core.Position
        Attachment = Instance.new("Attachment")
        Attachment.Parent = j.Core
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Parent = v7
        v1 = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.55),
            NumberSequenceKeypoint.new(0.12, 0.05),
            (NumberSequenceKeypoint.new(1, 0.1)),
        })
        v2 = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.85),
            NumberSequenceKeypoint.new(0.15, 0.45),
            NumberSequenceKeypoint.new(0.85, 0.45),
            (NumberSequenceKeypoint.new(1, 0.85)),
        })
        v3 = {Pet = j, A0 = Attachment, A1 = Attachment_2}
        v3.Beams = {
            {
                Width = 4.8,
                Beam = makeBeam(v7, Attachment, Attachment_2, {
                    Length = 9,
                    Speed = 0.9,
                    Brightness = 1.6,
                    ZOffset = -0.2,
                    Texture = u62.TetherGlow,
                    Color = ColorSequence.new(j.Color, u141),
                    Transparency = v2,
                }),
            },
            {
                Width = 1.9,
                Beam = makeBeam(v7, Attachment, Attachment_2, {
                    Length = 6,
                    Speed = 1.8,
                    Brightness = 1.6,
                    Texture = u62.TetherCore,
                    Color = ColorSequence.new(j.Hot, u146),
                    Transparency = v1,
                }),
            },
            {
                Width = 2.8,
                Beam = makeBeam(v7, Attachment, Attachment_2, {
                    Length = 11,
                    Speed = 2.6,
                    Brightness = 1.2,
                    ZOffset = 0.2,
                    Texture = u62.TetherFlow,
                    Color = ColorSequence.new(j.Color, j.Hot),
                    Transparency = v1,
                }),
            },
        }
        v3.Pulses = {}
        v3.LinkAt = u65.Link + (j.Order - 1) * 0.08
        v4 = CFrame.new(v10.Center)
        v2 = Kit.Part({
            Name = "TetherPlug",
            Transparency = 1,
            Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
            CFrame = v4,
        })
        v2.Parent = v10.Container
        v3.Plug = v2
        v3.PlugGlow = Kit.Emitter(v2, {
            LockedToPart = true,
            Rate = 26,
            ZOffset = 1.2,
            Texture = u62.Flare,
            FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
            FlipbookMode = Enum.ParticleFlipbookMode.Loop,
            Color = ColorSequence.new(j.Hot, j.Color),
            Speed = NumberRange.new(0),
            Lifetime = NumberRange.new(0.2),
            Rotation = NumberRange.new(0, 360),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.6), (NumberSequenceKeypoint.new(1, 1.6))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))}),
        })
        v3.PlugSparks = Kit.Emitter(v2, {
            Drag = 4,
            Rate = 18,
            ZOffset = 1,
            Texture = u62.Spark,
            Orientation = Enum.ParticleOrientation.VelocityParallel,
            Color = ColorSequence.new(u166, j.Hot),
            SpreadAngle = Vector2.new(70, 70),
            EmissionDirection = Enum.NormalId.Back,
            Speed = NumberRange.new(5, 10),
            Lifetime = NumberRange.new(0.25, 0.45),
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.2, 0.55),
                (NumberSequenceKeypoint.new(1, 0)),
            }),
        })
        for k = 1, 3 do
            v5 = CFrame.new(Position)
            v2 = Kit.Part({
                Name = "TetherPulse",
                Transparency = 1,
                Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
                CFrame = v5,
            })
            v2.Parent = v10.Container
            Kit.Emitter(v2, {
                LockedToPart = true,
                Rate = 30,
                ZOffset = 1,
                Texture = u62.Flare,
                FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
                FlipbookMode = Enum.ParticleFlipbookMode.Loop,
                Color = ColorSequence.new(j.Hot),
                Speed = NumberRange.new(0),
                Lifetime = NumberRange.new(0.18),
                Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1.8),
                    (NumberSequenceKeypoint.new(1, 1.2)),
                }),
                Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 1))}),
            })
            table.insert(v3.Pulses, {Part = v2, Offset = (k - 1) / 3})
        end
        table.insert(v10.Tethers, v3)
    end
    v10.TetherHeart = v7
end

local function gatherProps(a1) -- Line: 1027 -- upvalues: u220 (val), partsOf (val), u231 (val), u65 (val)
    local BoundingBox, BoundingBox_2, CFrame_3, Frame, Position, Size_4, X_2, Y_2, Z_2, decoration, v1, v2, v3, v4, v5, v6, v7, v8, v9
    a1.Props = {}
    if not (if not a1.Interior then nil else a1.Interior:FindFirstChild("decoration")) then
        return
    end
    local Center = a1.Center
    local v10 = {}
    local v11 = nil
    local v12 = nil
    for i, j in u220, v11, v12 do
        v9 = decoration:FindFirstChild(i)
        if v9 then
            v1 = {}
            for k, n in v9:GetChildren() do
                v4 = partsOf(n)
                if #v4 ~= 0 and not (#v4 > 12) then
                    if n:IsA("Model") then
                        BoundingBox, BoundingBox_2 = n:GetBoundingBox()
                        CFrame_3 = BoundingBox
                        Size_4 = BoundingBox_2
                    elseif not n:IsA("BasePart") then
                        CFrame_3 = CFrame.identity
                        Size_4 = Vector3.new(0, 0, 0)
                    else
                        CFrame_3 = n.CFrame
                        Size_4 = n.Size
                    end
                    Position = CFrame_3.Position
                    if not (9 < Size_4.Magnitude) then
                        v8 = false
                        X_2 = Position.X
                        if a1.Low.X + 1 < X_2 then
                            v8 = false
                            if Position.X < a1.High.X - 1 then
                                v8 = false
                                Z_2 = Position.Z
                                if a1.Low.Z + 1 < Z_2 then
                                    v8 = Position.Z < a1.High.Z - 1
                                end
                            end
                        end
                        if v8 then
                            Y_2 = Position.Y
                            if not (a1.Ceiling - 4 < Y_2) and not (Position.Y < a1.Floor - 3) then
                                table.insert(v1, {
                                    Item = n,
                                    Parts = v4,
                                    Frame = CFrame_3,
                                    Size = Size_4,
                                    Slam = i == "books",
                                })
                            end
                        end
                    end
                end
            end
            table.sort(v1, function(a1, a2) -- Line: 1064 -- upvalues: Center (val)
                return (a1.Frame.Position - Center).Magnitude < (a2.Frame.Position - Center).Magnitude
            end)
            v4 = #v1
            for m = 1, (math.min(j, v4)) do
                table.insert(v10, v1[m])
            end
        end
    end
    local u282 = Center - a1.Side * 4
    a1.OrbitHub = u282
    local v13 = 0
    v11 = 0
    for i5, i6 in a1.Pets do
        v2 = i6.Top - u282
        v13 = math.max(v13, (math.abs((v2:Dot(a1.Across)))))
        v11 = math.max(v11, (math.abs((v2:Dot(a1.Side)))))
    end

    local function reach(a1_2) -- Line: 1079 -- upvalues: a1 (val), u282 (val) -- types: a1_2: vector
        local v1
        local v2 = (1 / 0)
        local v3 = {"X", "Z"}
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v1 = a1_2[j]
            if 0.001 < (math.abs(v1)) then
                v2 = math.min(v2, ((if not (v1 > 0) then a1.Low[j] else a1.High[j]) - u282[j]) / v1)
            end
        end
        return v2
    end

    v12 = math.max(math.min(reach(a1.Across), (reach(-a1.Across))) - 4, v13 + 10)
    local v14 = math.clamp(math.min(reach(a1.Side) - 4, (reach(-a1.Side)) - 6), 12, 18)
    v11 = math.min(v13 + 8, v12 - 2)
    v13 = math.max(a1.PadTop + 6, a1.Floor + 5)
    local v15 = math.max(a1.Ceiling - 4, v13 + 2)
    table.sort(v10, function(a1, a2) -- Line: 1097 -- upvalues: Center (val)
        return (a1.Frame.Position - Center).Magnitude < (a2.Frame.Position - Center).Magnitude
    end)
    v1 = nil
    v2 = nil
    for i7, i8 in v10, v1, v2 do
        Frame = i8.Frame
        v3 = {}
        for i9, i10 in i8.Parts do
            table.insert(v3, {
                Part = i10,
                CFrame = i10.CFrame,
                Rel = Frame:ToObjectSpace(i10.CFrame),
                Anchored = i10.Anchored,
                CanCollide = i10.CanCollide,
                Transparency = i10.Transparency,
            })
        end
        v4 = Frame.Position - u282
        v5 = math.max(i8.Size.X, i8.Size.Y, i8.Size.Z)
        v6 = u231:NextNumber(v11, v12 - v5 * 0.5)
        v7 = u231:NextNumber(math.min(10, v14 - 2), v14 - v5 * 0.5)
        table.insert(a1.Props, {
            Item = i8.Item,
            Parts = v3,
            Home = Frame,
            HomeRot = Frame.Rotation,
            Extent = v5,
            Slam = i8.Slam,
            Angle = math.atan2(v4:Dot(a1.Side) / v7, (v4:Dot(a1.Across)) / v6),
            RadiusX = v6,
            RadiusZ = v7,
            Height = u231:NextNumber(v13, v15 - v5 * 0.5),
            Tilt = u231:NextNumber(1.2, 3.2),
            Phase = u231:NextNumber(0, 6.283185307179586),
            Axis = u231:NextUnitVector(),
            SpinRate = (u231:NextNumber(1.4, 3.4)) * (if not i8.Slam then 0.55 else 1),
            Seed = u231:NextNumber(0, 1000),
            RattleAt = u65.Rattle + u231:NextNumber(0, 0.8),
            LiftAt = u65.Lift + i7 * 0.035 + u231:NextNumber(0, 0.3),
            LiftSeconds = u231:NextNumber(1.3, 1.8),
            ReturnAt = u65.Return + u231:NextNumber(0, 0.9),
            ReturnSeconds = u231:NextNumber(1.6, 2.1),
            Rot = CFrame.identity,
            Pose = Frame,
        })
    end
end

local function freeProps(a1) -- Line: 1147
    local Part
    local v1 = nil
    local v2 = nil
    for i, j in a1.Props, v1, v2 do
        for k, n in j.Parts do
            Part = n.Part
            if Part.Parent then
                Part.Anchored = true
                Part.CanCollide = false
            end
        end
    end
    a1.PropsFree = true
end

local function restoreProps(a1) -- Line: 1160 -- upvalues: Workspace (val)
    if a1.Props and not a1.PropsRestored then
        local Part
        a1.PropsRestored = true
        local v1 = {}
        local v2 = {}
        local v3 = nil
        local v4 = nil
        for i, j in a1.Props, v3, v4 do
            for k, n in j.Parts do
                if n.Part.Parent then
                    table.insert(v1, n.Part)
                    table.insert(v2, n.CFrame)
                end
            end
        end
        if #v1 > 0 then
            Workspace:BulkMoveTo(v1, v2, Enum.BulkMoveMode.FireCFrameChanged)
        end
        v3 = nil
        v4 = nil
        for m, i5 in v5.Props, v3, v4 do
            for i6, i7 in i5.Parts do
                Part = i7.Part
                if Part.Parent then
                    Part.CFrame = i7.CFrame
                    Part.Anchored = i7.Anchored
                    Part.CanCollide = i7.CanCollide
                    Part.Transparency = i7.Transparency
                    if not i7.Anchored then
                        Part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        Part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
        return
    end
end

local function gatherLights(a1) -- Line: 1194 -- upvalues: u211 (val), u62 (val), u231 (val)
    local Parent, Position, Shrine, X, Z, v1
    a1.Lights = {}
    a1.SquareDust = {}
    if not a1.Interior then
        return
    end
    local v2 = a1
    for i, j in a1.Interior:GetDescendants() do
        if not j:IsA("ParticleEmitter") then
            if j:IsA("Light") then
                Shrine = v2.Shrine
                if not j:IsDescendantOf(Shrine) then
                    Parent = j.Parent
                    Position = if not Parent then if not Parent then nil else if not Parent:IsA("Attachment") then nil else Parent.WorldPosition else if not Parent:IsA("BasePart") then if not Parent then nil else if not Parent:IsA("Attachment") then nil else Parent.WorldPosition else Parent.Position
                    if Position then
                        v1 = false
                        X = Position.X
                        if v2.Low.X + -4 < X then
                            v1 = false
                            if Position.X < v2.High.X - -4 then
                                v1 = false
                                Z = Position.Z
                                if v2.Low.Z + -4 < Z then
                                    v1 = Position.Z < v2.High.Z - -4
                                end
                            end
                        end
                        if v1 and Position.Y < v2.Ceiling + 6 then
                            table.insert(v2.Lights, {
                                Light = j,
                                Brightness = j.Brightness,
                                Color = j.Color,
                                Seed = u231:NextNumber(0, 1000),
                            })
                        end
                    end
                end
            end
        elseif u211[j.Texture] then
            table.insert(v2.SquareDust, {Emitter = j, Texture = j.Texture})
            j.Texture = u62.Glow
            j:Clear()
        elseif j:IsA("Light") then
            Shrine = v2.Shrine
            if not j:IsDescendantOf(Shrine) then
                Parent = j.Parent
                Position = if not Parent then if not Parent then nil else if not Parent:IsA("Attachment") then nil else Parent.WorldPosition else if not Parent:IsA("BasePart") then if not Parent then nil else if not Parent:IsA("Attachment") then nil else Parent.WorldPosition else Parent.Position
                if Position then
                    v1 = false
                    X = Position.X
                    if v2.Low.X + -4 < X then
                        v1 = false
                        if Position.X < v2.High.X - -4 then
                            v1 = false
                            Z = Position.Z
                            if v2.Low.Z + -4 < Z then
                                v1 = Position.Z < v2.High.Z - -4
                            end
                        end
                    end
                    if v1 and Position.Y < v2.Ceiling + 6 then
                        table.insert(v2.Lights, {
                            Light = j,
                            Brightness = j.Brightness,
                            Color = j.Color,
                            Seed = u231:NextNumber(0, 1000),
                        })
                    end
                end
            end
        end
    end
end

local function restoreLights(a1) -- Line: 1226
    for i, j in a1.Lights or {} do
        if j.Light.Parent then
            j.Light.Brightness = j.Brightness
            j.Light.Color = j.Color
        end
    end
    for k, n in a1.SquareDust or {} do
        if n.Emitter.Parent then
            n.Emitter.Texture = n.Texture
        end
    end
    a1.SquareDust = {}
end

local function buildRoom(a1) -- Line: 1241 -- upvalues: Workspace (val), Kit (val), u62 (val), u146 (val), u131 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
        ColorCorrectionEffect.Name = "VoidFusionGrade"
        ColorCorrectionEffect.Parent = CurrentCamera
        a1.Trove:Add(ColorCorrectionEffect)
        a1.Grade = ColorCorrectionEffect
    end
    local Low = a1.Low
    local High = a1.High
    local v1 = Vector3.new(High.X - Low.X, 0.4, High.Z - Low.Z)
    local v2 = CFrame.new((Low.X + High.X) / 2, a1.Floor + 0.6, (Low.Z + High.Z) / 2)
    v1 = Kit.Part({
        Name = "RoomMotes",
        Transparency = 1,
        Size = v1 or Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v2,
    })
    v1.Parent = a1.Container
    a1.Motes = Kit.Emitter(v1, {
        Acceleration = Vector3.new(0, 0.6000000238418579, 0),
        Texture = u62.Glow,
        Color = ColorSequence.new(u146, u131),
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(1.5, 4),
        Lifetime = NumberRange.new(3, 5),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.2, 0.45),
            (NumberSequenceKeypoint.new(1, 0)),
        }),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), (NumberSequenceKeypoint.new(1, 1))}),
    })
end

local function buildRift(a1) -- Line: 1277
    -- upvalues: ReplicatedStorage (val), scaleTree (val), u217 (val), u146 (val), u141 (val), scaleSequence (val)
    -- upvalues: u214 (val), u123 (val), Kit (val), u62 (val), u166 (val), u136 (val)
    local Beam, v1, v2, v3, v4
    local FusionShrine = ReplicatedStorage.Assets:FindFirstChild("FusionShrine")
    local v5 = if not FusionShrine then nil else FusionShrine:FindFirstChild("Void")
    local RiftSize = a1.RiftSize
    local v6 = CFrame.lookAt(a1.Center, a1.Center + a1.Side)
    a1.Steady = {}
    a1.RiftDiscs = {}
    a1.MergeDim = {}
    a1.VortexGlow = {}
    local Rift = if not v5 then nil else v5:FindFirstChild("Rift")
    if Rift and Rift:IsA("Model") then
        local v7
        v2 = Rift:Clone()
        scaleTree(v2, RiftSize / 170)
        v2:PivotTo(v6)
        v1 = a1
        for i, j in v2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
            elseif j:IsA("ParticleEmitter") then
                j.Enabled = false
                if u217[j.Name] then
                    table.insert(v1.RiftDiscs, {Emitter = j, Size = j.Size})
                end
                if j.Name == "Pinch" then
                    j.Color = ColorSequence.new(u146, u141)
                    j.Size = scaleSequence(j.Size, 0.55)
                elseif j.Name == "EyeGlow" then
                    j.Color = ColorSequence.new(u141)
                end
                v7 = u214[j.Name] or (if j.Name ~= "Bolt" then nil else 0.5)
                if v7 then
                    table.insert(v1.MergeDim, {
                        Emitter = j,
                        Dim = v7,
                        Transparency = j.Transparency,
                        LightEmission = j.LightEmission,
                        Brightness = j.Brightness,
                    })
                end
            end
        end
        v2.Parent = v1.Container
        v1.Rift = v2
        v1.RiftFacing = v6
        local PrimaryPart = v2.PrimaryPart or v2:FindFirstChildWhichIsA("BasePart")
        if PrimaryPart then
            v2 = Instance.new("PointLight")
            v2.Color = u141
            v2.Range = RiftSize * 2.4
            v2.Brightness = 0
            v2.Shadows = false
            v2.Parent = PrimaryPart
            v1.RiftLight = v2
        end
    end
    local Vortex = if not v5 then nil else v5:FindFirstChild("Vortex")
    if Vortex and Vortex:IsA("BasePart") then
        v2 = Vortex:Clone()
        scaleTree(v2, RiftSize / 24)
        v2.CFrame = v6 * CFrame.new(0, 0, 0.2)
        v2.Parent = v1.Container
        v1.Vortex = v2
        for k, n in v2:GetDescendants() do
            if n:IsA("ParticleEmitter") then
                n.Enabled = false
                n.Brightness = math.min(n.Brightness, 3)
                table.insert(v1.RiftDiscs, {Emitter = n, Size = n.Size})
                table.insert(v1.VortexGlow, {Emitter = n, Brightness = n.Brightness})
            end
        end
    end
    local Eye = if not v5 then nil else v5:FindFirstChild("Eye")
    if Eye and Eye:IsA("Model") then
        local BoundingBox_2
        v6 = Eye:Clone()
        _, BoundingBox_2 = v6:GetBoundingBox()
        v2 = RiftSize * 0.6
        v1.EyeScale = v2 / math.max(BoundingBox_2.X, 0.1)
        v1.EyeWidth = v2
        v6:ScaleTo(v1.EyeScale)
        v3 = v1.Center + v1.Side * (RiftSize * 0.04)
        v1.EyeFrame = CFrame.lookAt(v3, v3 + v1.Side)
        v6:PivotTo(v1.EyeFrame)
        local Sclera = v6:FindFirstChild("Sclera")
        v6:ScaleTo(v1.EyeScale * 0.05)
        v6:PivotTo(v1.EyeFrame)
        for m, i5 in v6:GetDescendants() do
            if i5:IsA("BasePart") then
                i5.LocalTransparencyModifier = 1
            end
        end
        v6.Parent = v1.Container
        v2 = Instance.new("PointLight")
        v2.Color = u146
        v2.Range = RiftSize * 0.9
        v2.Brightness = 0
        v2.Shadows = false
        v2.Parent = if not Sclera then v6:FindFirstChildWhichIsA("BasePart") else Sclera
        v4 = {
            Shown = false,
            Scale = 0.05,
            Model = v6,
            Upper = v6:FindFirstChild("UpperLid"),
            Lower = v6:FindFirstChild("LowerLid"),
            Pupil = v6:FindFirstChild("Pupil"),
            Sclera = Sclera,
        }
        v4.ScleraColor = if not Sclera then u141 else if not Sclera:IsA("BasePart") then u141 else Sclera.Color
        v4.Light = v2
        v4.Angles = {u123.Closed[1], u123.Closed[2]}
        v4.Look = Vector2.zero
        v1.Eye = v4
        v1.EyeNow = v1.EyeFrame
    end
    v2 = CFrame.new(v1.Center)
    local v8 = Kit.Part({
        Name = "RiftTear",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v2,
    })
    v8.Parent = v1.Container
    local v9 = Instance.new("Attachment")
    v9.Parent = v8
    v5 = Instance.new("Attachment")
    v5.Parent = v8
    v2 = {}
    v3 = {
        {
            Width = 2.4,
            Texture = u62.TetherGlow,
            Color = ColorSequence.new(u141, u146),
        },
        {
            Width = 0.9,
            Texture = u62.TetherCore,
            Color = ColorSequence.new(u166, u136),
        },
    }
    v4 = nil
    local v10 = nil
    for i6, i7 in v3, v4, v10 do
        Beam = Instance.new("Beam")
        Beam.Attachment0 = v9
        Beam.Attachment1 = v5
        Beam.Texture = i7.Texture
        Beam.TextureMode = Enum.TextureMode.Stretch
        Beam.TextureSpeed = 1.5
        Beam.Color = i7.Color
        Beam.LightEmission = 1
        Beam.LightInfluence = 0
        Beam.Brightness = if i6 ~= 2 then 2 else 4
        Beam.FaceCamera = true
        Beam.Segments = 12
        Beam.Width0 = 0
        Beam.Width1 = 0
        Beam.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.1),
            NumberSequenceKeypoint.new(0.7, 0.1),
            (NumberSequenceKeypoint.new(1, 1)),
        })
        Beam.Enabled = false
        Beam.Parent = v8
        table.insert(v2, {Beam = Beam, Width = i7.Width})
    end
    v1.Tear = {Part = v8, Bottom = v9, Top = v5, Beams = v2}
end

local function setLoop(a1, a2, a3, a4, a5) -- Line: 1437
    -- upvalues: holders (val)
    local Steady, v1
    if not a2 then
        return
    end
    local v2, v3, v4 = a1, a4, a5
    for i, j in holders(a2, a3) do
        for k, n in j:GetDescendants() do
            if n:IsA("ParticleEmitter") then
                if not (0 < n.Rate) or not (n.Rate < 4) then
                    n.Enabled = v3
                else
                    n.Enabled = false
                    if not v3 then
                        if not v3 then
                            v2.Steady[n] = nil
                        end
                    elseif not v2.Steady[n] then
                        n:Emit(1)
                        Steady = v2.Steady
                        v1 = {
                            Interval = 1 / n.Rate,
                            Next = os.clock() + 1 / n.Rate,
                        }
                        Steady[n] = v1
                    elseif not v3 then
                        v2.Steady[n] = nil
                    end
                end
                if v4 then
                    n:Clear()
                end
            end
        end
    end
end

local function setVortex(a1, a2, a3) -- Line: 1464 -- types: a2: boolean, a3: boolean?
    local v1
    local Vortex = a1.Vortex
    if not Vortex then
        return
    end
    local v2, v3 = a2, a3
    for i, j in Vortex:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v1 = v2 and not string.find(j.Name, "tech_vortex", 1, true)
            j.Enabled = v1
            if v3 then
                j:Clear()
            end
        end
    end
end

local function stepSteady(a1, a2) -- Line: 1479 -- types: a2: number
    local v1, v2
    local v3 = os.clock()
    local Steady = a1.Steady
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a2
    for i, j in Steady, v4, v5 do
        if not i.Parent then
            v6.Steady[i] = nil
        elseif j.Next <= v3 then
            i:Emit(1)
            v1 = j.Interval / math.max(v7, 0.2)
            v2 = if not (v1 < v3 - j.Next) then j.Next + v1 else v3 + v1
            j.Next = v2
        end
    end
end

local function buildOrb(a1) -- Line: 1494
    -- upvalues: Kit (val), u62 (val), u146 (val), u141 (val), u131 (val), u136 (val), u151 (val)
    local RiftSize = a1.RiftSize
    local v1 = a1.Center + a1.Side * (RiftSize * 0.2)
    local v2 = CFrame.lookAt(v1, v1 + a1.Side)
    local u16 = Kit.Part({Name = "VoidOrb", Transparency = 1, Size = Vector3.new(1, 1, 1), CFrame = v2})
    u16.Parent = a1.Container

    local function emit(a1) -- Line: 1498 -- upvalues: Kit (upval), u16 (val) -- types: a1: table
        local v1 = Kit.Emitter(u16, a1)
        v1.Enabled = false
        return v1
    end

    v2 = {Size = 0, Part = u16}
    local v3 = {
        LightEmission = 0.75,
        LockedToPart = true,
        Rate = 26,
        ZOffset = 3,
        Texture = u62.Flare,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        Color = ColorSequence.new(u146, u141),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.3),
        Rotation = NumberRange.new(0, 360),
        Size = NumberSequence.new(1),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), (NumberSequenceKeypoint.new(1, 1))}),
    }
    local v4 = Kit.Emitter(u16, v3)
    v4.Enabled = false
    v2.Core = v4
    v3 = {
        LightEmission = 0.6,
        LockedToPart = true,
        Rate = 22,
        ZOffset = 3.4,
        Texture = u62.Flare,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        Color = ColorSequence.new(u131, u136),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.25),
        Rotation = NumberRange.new(0, 360),
        Size = NumberSequence.new(1),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.45), (NumberSequenceKeypoint.new(1, 1))}),
    }
    v4 = Kit.Emitter(u16, v3)
    v4.Enabled = false
    v2.Bone = v4
    v3 = {
        LightEmission = 0.8,
        LockedToPart = true,
        Rate = 6,
        ZOffset = 2.6,
        Texture = u62.Swirl,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        Color = ColorSequence.new(u146, u131),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.9),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-260, -200),
        Size = NumberSequence.new(1),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.25, 0.25),
            NumberSequenceKeypoint.new(0.75, 0.25),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }
    v4 = Kit.Emitter(u16, v3)
    v4.Enabled = false
    v2.Swirl = v4
    v3 = {
        Rate = 45,
        ZOffset = 2,
        Texture = u62.Spark,
        Orientation = Enum.ParticleOrientation.VelocityParallel,
        Color = ColorSequence.new(u136, u146),
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward,
        Speed = NumberRange.new(16, 26),
        Lifetime = NumberRange.new(0.25, 0.4),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.3, 0.9),
            (NumberSequenceKeypoint.new(1, 0)),
        }),
    }
    v4 = Kit.Emitter(u16, v3)
    v4.Enabled = false
    v2.Inward = v4
    v3 = {
        Rate = 14,
        ZOffset = 2.2,
        Texture = u62.Fire,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Color = ColorSequence.new(u146, u151),
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(1, 3),
        Lifetime = NumberRange.new(0.5, 0.7),
        Rotation = NumberRange.new(0, 360),
        Size = NumberSequence.new(1),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))}),
    }
    v4 = Kit.Emitter(u16, v3)
    v4.Enabled = false
    v2.Flames = v4
    v1 = Instance.new("PointLight")
    v1.Color = u146
    v1.Range = RiftSize * 1.6
    v1.Brightness = 0
    v1.Shadows = false
    v1.Parent = u16
    v2.Light = v1
    a1.Orb = v2
end

local function setOrbSize(a1, a2) -- Line: 1605 -- types: a2: number
    local Orb = a1.Orb
    if not Orb then
        return
    end
    local v1 = a2 > 0.05
    for i, j in {"Core", "Bone", "Swirl", "Inward", "Flames"} do
        Orb[j].Enabled = v1
    end
    if not v1 then
        Orb.Light.Brightness = 0
        return
    end
    v1 = math.sin((os.clock()) * 22) * 0.08 + 1
    Orb.Core.Size = NumberSequence.new(a2 * 2.3 * v1)
    Orb.Bone.Size = NumberSequence.new(a2 * 1.1 * v1)
    Orb.Swirl.Size = NumberSequence.new(a2 * 2.8)
    Orb.Flames.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, a2 * 0.6),
        (NumberSequenceKeypoint.new(1, a2 * 1.1)),
    })
    local Part = Orb.Part
    local v2 = a2 * 2.6
    Part.Size = Vector3.new(1, 1, 1) * math.max(v2, 0.5)
    Orb.Light.Brightness = a2 * 0.45 + 1.5
end

local function makeWisp(a1, a2, a3) -- Line: 1630 -- upvalues: Kit (val), u62 (val), u231 (val) -- types: a3: vector
    local v1 = CFrame.new(a3)
    local v2 = Kit.Part({
        Name = "VoidWisp",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v1,
    })
    v2.Parent = a1.Container
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(0, 0.3499999940395355, 0)
    Attachment.Parent = v2
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = Vector3.new(0, -0.3499999940395355, 0)
    Attachment_2.Parent = v2
    local Trail = Instance.new("Trail")
    Trail.Attachment0 = Attachment
    Trail.Attachment1 = Attachment_2
    Trail.Color = ColorSequence.new(a2.Hot, a2.Color)
    Trail.Texture = u62.Glow
    Trail.TextureMode = Enum.TextureMode.Stretch
    Trail.Transparency = NumberSequence.new(0.1, 1)
    Trail.WidthScale = NumberSequence.new(1, 0.1)
    Trail.Lifetime = 0.32
    Trail.MinLength = 0.05
    Trail.LightEmission = 1
    Trail.LightInfluence = 0
    Trail.FaceCamera = true
    Trail.Parent = v2
    Kit.Emitter(v2, {
        LockedToPart = true,
        Rate = 30,
        Enabled = true,
        ZOffset = 1.5,
        Texture = u62.Flare,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        Color = ColorSequence.new(a2.Hot),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.16),
        Size = NumberSequence.new(1.3),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), (NumberSequenceKeypoint.new(1, 1))}),
    })
    local Center = a1.Center
    v1 = a1.Across * u231:NextNumber(-7, 7)
    local v3 = u231:NextNumber(0, 6.283185307179586)
    table.insert(a1.Wisps, {
        Part = v2,
        Trail = Trail,
        From = a3,
        Control = (a3:Lerp(Center, 0.5)) + Vector3.new(0, 1, 0) * u231:NextNumber(4, 8) + v1,
        Born = a1.T,
        Travel = u231:NextNumber(0.75, 1.15),
        Angle = v3,
        Radius = a1.RiftSize * u231:NextNumber(0.26, 0.4),
        Spin = if a2.Side ~= a1.Kind.Sides[1] then -1 else 1,
        Tilt = u231:NextNumber(-0.5, 0.5),
        Rate = u231:NextNumber(0.85, 1.2),
    })
end

local function wispOrbit(a1, a2, a3) -- Line: 1687 -- types: a3: number
    local v1 = a2.Radius * (1 - a3 * 0.82)
    local v2 = CFrame.fromAxisAngle(a1.Across, a2.Tilt)
    local v3 = v2:VectorToWorldSpace(a1.Across)
    local v4 = v2:VectorToWorldSpace((Vector3.new(0, 1, 0)))
    return a1.Center + (v3 * math.cos(a2.Angle) + v4 * math.sin(a2.Angle)) * v1 + a1.Side * (a1.RiftSize * 0.2 + math.sin(a2.Angle * 2) * 0.5)
end

local function stepWisps(a1, a2, a3) -- Line: 1697
    -- upvalues: Kit (val), u65 (val), wispOrbit (val)
    local v1, v2, v3, v4
    local v5 = Kit.Smooth(Kit.Window(a2, u65.Merge, u65.Implode))
    local v6 = 2.4 + 8 * v5
    local v7, v8, v9 = a1, a3, a2
    for i = #a1.Wisps, 1, -1 do
        v3 = v7.Wisps[i]
        if v3.Part.Parent then
            v3.Angle = v3.Angle + v3.Spin * v6 * v3.Rate * v8
            v4 = wispOrbit(v7, v3, v5)
            v1 = Kit.Window(v9, v3.Born, v3.Born + v3.Travel)
            v2 = if not (v1 < 1) then v4 else Kit.Bezier(v3.From, v3.Control, v4, (Kit.Ease(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)))
            if not (u65.Implode <= v9) then
                v3.Part.CFrame = CFrame.new(v2)
            else
                v1 = Kit.Window(v9, u65.Implode, u65.Implode + 0.28)
                v2 = v2:Lerp(v7.Center, (Kit.Ease(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)))
                if not (v1 >= 1) then
                    v3.Part.CFrame = CFrame.new(v2)
                else
                    v3.Part:Destroy()
                    table.remove(v7.Wisps, i)
                end
            end
        else
            table.remove(v7.Wisps, i)
        end
    end
end

local function lidAngles(a1, a2) -- Line: 1732
    -- upvalues: u123 (val), u65 (val), Kit (val), u77 (val)
    local Window_5, v1
    local Open = u123.Open
    local Flare = u123.Flare
    local Narrow = u123.Narrow
    local Closed = u123.Closed
    if a2 < u65.EyeOpen then
        return Closed[1], Closed[2]
    end
    local v2 = Kit.Ease(Kit.Window(a2, u65.EyeOpen, u65.EyeOpen + 0.24), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local v3 = Kit.Smooth(Kit.Window(a2, u65.EyeOpen + 0.3, u65.EyeOpen + 0.9))
    local v4 = Kit.Lerp(Kit.Lerp(Closed[1], Flare[1], v2), Open[1], v3)
    local v5 = Kit.Lerp(Kit.Lerp(Closed[2], Flare[2], v2), Open[2], v3)
    local v6 = math.max(
        math.sin(3.141592653589793 * (Kit.Window(a2, u65.Lock, u65.Lock + 0.5))) * 0.35,
        (math.sin(3.141592653589793 * (Kit.Window(a2, u65.Squint, u65.Dissolve)))) * 0.55,
        (Kit.Smooth((Kit.Window(a2, u65.Narrow, u65.Narrow + 0.5))))
    )
    v4 = Kit.Lerp(v4, Narrow[1], v6)
    v5 = Kit.Lerp(v5, Narrow[2], v6)
    v3 = 0
    for i, j in u77 do
        Window_5 = Kit.Window
        v1 = j + 0.2
        v3 = math.max(v3, (math.sin(3.141592653589793 * (Window_5(a2, j, v1)))))
    end
    v4 = Kit.Lerp(v4, Closed[1], v3)
    v5 = Kit.Lerp(v5, Closed[2], v3)
    v3 = Kit.Ease(Kit.Window(a2, u65.Close, u65.Implode), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    return (Kit.Lerp(v4, Closed[1], v3)), Kit.Lerp(v5, Closed[2], v3)
end

local function glance(a1, a2, a3, a4) -- Line: 1765 -- upvalues: u108 (val) -- types: a2: number, a3: number, a4: number
    local v1 = u108[(math.floor((a2 - a3) / a4)) % #u108 + 1]
    return a1.Center + a1.Side * 20 + a1.Across * (16 * v1.X) + Vector3.new(0, 1, 0) * (6 * v1.Y - 3)
end

local function rowGaze(a1, a2) -- Line: 1774 -- upvalues: u65 (val) -- types: a2: number
    return a1.Row + a1.Across * ((math.sin((a2 - u65.Lock) * 0.8)) * a1.RowSpan * 0.45) + Vector3.new(0, 2, 0)
end

local function gazeTarget(a1, a2) -- Line: 1779
    -- upvalues: u65 (val), u108 (val), Kit (val), Workspace (val)
    local v1, v2
    if a2 < u65.Lock then
        v1 = u108[(math.floor((a2 - u65.EyeOpen) / 0.36)) % #u108 + 1]
        return a1.Center + a1.Side * 20 + a1.Across * (16 * v1.X) + Vector3.new(0, 1, 0) * (6 * v1.Y - 3)
    end
    if a2 < u65.Lift then
        return a1.Row + a1.Across * ((math.sin((a2 - u65.Lock) * 0.8)) * a1.RowSpan * 0.45) + Vector3.new(0, 2, 0)
    end
    if a2 < u65.Dissolve - 0.3 then
        v1 = u108[(math.floor((a2 - u65.Lift) / 0.5)) % #u108 + 1]
        return a1.Center + a1.Side * 20 + a1.Across * (16 * v1.X) + Vector3.new(0, 1, 0) * (6 * v1.Y - 3)
    end
    if a2 < u65.Merge then
        return a1.Row + a1.Across * ((math.sin((a2 - u65.Lock) * 0.8)) * a1.RowSpan * 0.45) + Vector3.new(0, 2, 0)
    end
    local v3 = Vector3.new(0, 0, 0)
    local v4 = 0
    for i, j in a1.Seats or {} do
        v2 = Kit.RootOf(j.Character)
        if v2 then
            v3 = v3 + (v2.Position + Vector3.new(0, 2, 0))
            v4 = v4 + 1
        end
    end
    if v4 ~= 0 then
        return v3 / v4
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.CFrame.Position
    end
    return a1.Center + a1.Side * 20
end

local function gazeRate(a1) -- Line: 1807 -- upvalues: u65 (val) -- types: a1: number
    if a1 < u65.Lock then
        return 18
    end
    if a1 < u65.Lock + 0.35 then
        return 22
    end
    if u65.Lift <= a1 and a1 < u65.Dissolve - 0.3 then
        return 14
    end
    return 7
end

local function stepEye(a1, a2, a3) -- Line: 1820
    -- upvalues: Kit (val), u65 (val), lidAngles (val), gazeTarget (val), u146 (val)
    local Eye = a1.Eye
    if Eye and Eye.Model.Parent then
        local v1, v2, v3
        local v4 = math.max(
            (Kit.Ease(Kit.Window(a2, u65.Tear + 0.2, u65.Tear + 0.8), Enum.EasingStyle.Back, Enum.EasingDirection.Out)) * (1 - Kit.Ease(Kit.Window(a2, u65.Close + 0.15, u65.Implode + 0.05), Enum.EasingStyle.Quad, Enum.EasingDirection.In)),
            0
        )
        local v5 = v4 > 0.02
        if v5 == Eye.Shown then
            v2 = a2
        else
            Eye.Shown = v5
            v2, v1, v3 = a2, a1, a3
            for i, j in Eye.Model:GetDescendants() do
                if j:IsA("BasePart") then
                    j.LocalTransparencyModifier = if not v5 then 1 else 0
                end
            end
        end
        Eye.Light.Brightness = if not v5 then 0 else (0.6 + 1.4 * Kit.Window(v2, u65.EyeOpen, u65.EyeOpen + 0.3)) * v4
        if not v5 then
            return
        end
        v5 = v1.EyeScale * math.max(v4, 0.05)
        if 0.0001 < (math.abs((Eye.Model:GetScale()) - v5)) then
            Eye.Model:ScaleTo(v5)
        end
        v4 = (Eye.Model:GetScale()) / v1.EyeScale
        v5 = math.sin(v2 * 9) * 0.03 + 1
        local v6 = v1.EyeFrame * CFrame.new(0, math.sin(v2 * 1.6) * 0.12, 0)
        v1.EyeNow = v6
        v1.EyeK = v4
        Eye.Model:PivotTo(v6)
        local v7, v8 = lidAngles(v1, v2)
        local Angles = Eye.Angles
        local Angles_2 = Eye.Angles
        Angles[1] = v7
        Angles_2[2] = v8
        if Eye.Upper then
            Eye.Upper:PivotTo(v6 * (CFrame.Angles(math.rad(v7), 0, 0)))
        end
        if Eye.Lower then
            Eye.Lower:PivotTo(v6 * (CFrame.Angles(math.rad(v8), 0, 0)))
        end
        v8 = v6:PointToObjectSpace((gazeTarget(v1, v2)))
        v7 = math.clamp(math.atan2(-v8.X, -v8.Z), -0.4537856055185257, 0.4537856055185257)
        v4 = math.clamp(math.atan2(v8.Y, (math.sqrt(v8.X ^ 2 + v8.Z ^ 2))), -0.2792526803190927, 0.2792526803190927)
        local v9 = -v3
        v8 = 1 - math.exp(v9 * (if not (v2 < u65.Lock) then if not (v2 < u65.Lock + 0.35) then if not (u65.Lift <= v2) then 7 else if not (v2 < u65.Dissolve - 0.3) then 7 else 14 else 22 else 18))
        Eye.Look = Eye.Look:Lerp(Vector2.new(v4, v7), v8)
        if Eye.Pupil then
            Eye.Pupil:PivotTo(v6 * (CFrame.Angles(Eye.Look.X, Eye.Look.Y, 0)))
        end
        if Eye.Sclera then
            v8 = (Kit.Window(v2, u65.EyeOpen, u65.EyeOpen + 0.25)) * (1 - Kit.Window(v2, u65.EyeOpen + 0.3, u65.EyeOpen + 1.2))
            v7 = math.sin(3.141592653589793 * (Kit.Window(v2, u65.Lock, u65.Lock + 0.6)))
            Eye.Sclera.Color = Eye.ScleraColor:Lerp(u146, (math.clamp(math.max(v8, v7) * 0.6 + (v5 - 1) * 2, 0, 1)))
        end
        return
    end
end

local function stepRift(a1, a2) -- Line: 1892
    -- upvalues: Kit (val), u65 (val), scaleSequence (val)
    local v1 = Kit.Ease(Kit.Window(a2, u65.Tear, u65.Tear + 0.9), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local v2 = Kit.Smooth(Kit.Window(a2, u65.Merge, u65.Implode))
    local v3 = Kit.Window(a2, u65.Implode, u65.Implode + 0.3)
    local v4 = v1 * (1 + 0.12 * v2) * (1 - Kit.Ease(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
    if u65.Tear <= a2 and v3 < 1 then
        if not a1.RiftGrow then
            a1.RiftGrow = v4
            for i, j in a1.RiftDiscs do
                j.Emitter.Size = scaleSequence(j.Size, (math.max(v4, 0.02)))
            end
        elseif 0.004 < (math.abs(a1.RiftGrow - v4)) then
            a1.RiftGrow = v4
            for k, n in a1.RiftDiscs do
                n.Emitter.Size = scaleSequence(n.Size, (math.max(v4, 0.02)))
            end
        end
    end
    v4 = Kit.Smooth(Kit.Window(a2, u65.Merge - 0.4, u65.Merge + 0.6))
    if not a1.Hush then
        a1.Hush = v4
        for m, i5 in a1.MergeDim do
            i5.Emitter.Brightness = i5.Brightness * Kit.Lerp(1, i5.Dim, v4)
            i5.Emitter.LightEmission = i5.LightEmission * Kit.Lerp(1, i5.Dim, v4)
        end
        for i6, i7 in a1.VortexGlow do
            i7.Emitter.Brightness = i7.Brightness * Kit.Lerp(1, 0.55, v4)
        end
    elseif 0.02 < (math.abs(a1.Hush - v4)) then
        a1.Hush = v4
        for i8, i9 in a1.MergeDim do
            i9.Emitter.Brightness = i9.Brightness * Kit.Lerp(1, i9.Dim, v4)
            i9.Emitter.LightEmission = i9.LightEmission * Kit.Lerp(1, i9.Dim, v4)
        end
        for i10, i11 in a1.VortexGlow do
            i11.Emitter.Brightness = i11.Brightness * Kit.Lerp(1, 0.55, v4)
        end
    end
    if a1.RiftLight then
        v4 = 1 + 0.18 * math.noise(a2 * 7, 3.1)
        a1.RiftLight.Brightness = (v1 * 2.4 + v2 * 1.8) * (1 - v3) * v4
    end
    local Tear = a1.Tear
    if Tear then
        local v5
        v2 = Kit.Ease(Kit.Window(a2, u65.Crack, u65.Tear), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        v1 = Kit.Window(a2, u65.Tear, u65.Tear + 0.45)
        local v6 = false
        if v2 > 0 then
            v6 = v1 < 1
        end
        local v7 = a1.RiftSize * (0.12 + 0.38 * v2 + 0.2 * v1)
        Tear.Bottom.WorldPosition = a1.Center - Vector3.new(0, 1, 0) * v7
        Tear.Top.WorldPosition = a1.Center + Vector3.new(0, 1, 0) * v7
        for i12, i13 in Tear.Beams do
            i13.Beam.Enabled = v6
            v7 = i13.Width * (v2 * (1 - v1) + v1 * 3.5 * (1 - v1))
            v5 = 1 + 0.25 * math.noise(a2 * 30, i13.Width)
            i13.Beam.Width0 = v7 * v5
            i13.Beam.Width1 = v7 * v5
        end
    end
end

local function energy(a1) -- Line: 1948 -- upvalues: Kit (val), u65 (val) -- types: a1: number
    return Kit.Smooth(Kit.Window(a1, u65.Link, u65.Lift)) * 0.6 + Kit.Smooth(Kit.Window(a1, u65.Lift, u65.Dissolve)) * 0.4
end

local function stepTethers(a1, a2) -- Line: 1953
    -- upvalues: Kit (val), u65 (val), eyePlug (val), axisFrame (val), glowFlare (val), sparkleBurst (val)
    local Beam, Gone, Magnitude, Part, Pet, Position, Position_2, Position_3, new_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18
    local v19 = Kit.Smooth(Kit.Window(a2, u65.Link, u65.Lift)) * 0.6 + Kit.Smooth(Kit.Window(a2, u65.Lift, u65.Dissolve)) * 0.4
    local v20 = nil
    local v21 = nil
    local v22 = a2
    for i, j in a1.Tethers, v20, v21 do
        Pet = j.Pet
        v18 = Kit.Ease(Kit.Window(v22, j.LinkAt, j.LinkAt + 0.38), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        Gone = Pet.Gone or not Pet.Model.Parent
        v2 = if not Pet.RetractAt then 0 else Kit.Window(v22, Pet.RetractAt, Pet.RetractAt + 0.35)
        v3 = false
        if v18 > 0 then
            v3 = v2 < 1
        end
        Position = Pet.Core.Position
        v9, v10 = eyePlug(v1, Pet)
        Magnitude = (v9 - Position).Magnitude
        v5 = axisFrame(Position, Vector3.new(0, 1, 0) + v1.Side * 0.15)
        v6 = axisFrame(v9, v10)
        v7 = Magnitude * 0.5
        v8 = Magnitude * 0.42
        Position_2 = v5.Position
        Position_3 = v6.Position
        v4 = Position_2 + v5.XVector * v7
        v11 = Position_3 - v6.XVector * v8
        v13 = 1 - v18
        v12 = Position_2 * (v13 * v13 * v13) + v4 * (v13 * 3 * v13 * v18) + v11 * (v13 * 3 * v18 * v18) + Position_3 * (v18 * v18 * v18)
        v14 = Kit.Ease(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        v15 = 1 - v14
        v13 = Position_2 * (v15 * v15 * v15) + v4 * (v15 * 3 * v15 * v14) + v11 * (v15 * 3 * v14 * v14) + Position_3 * (v14 * v14 * v14)
        j.A0.WorldCFrame = axisFrame(v13, v5.XVector)
        j.A1.WorldCFrame = axisFrame(v12, v6.XVector)
        v13 = math.max(v18 - v2, 0)
        v12 = math.max(math.sin((v22 - j.LinkAt) * 5.2), 0) * 0.35 * v19 + 1
        v5 = if not Pet.DissolveAt then 0 else Kit.Window(v22, Pet.DissolveAt, Pet.DissolveAt + 0.4)
        v15 = nil
        v16 = nil
        for k, n in j.Beams, v15, v16 do
            Beam = n.Beam
            Beam.Enabled = v3 and not Gone
            v17 = n.Width * (v19 * 0.75 + 0.55 + 0.6 * v5) * v12
            Beam.Width0 = v17 * (1 - v2)
            Beam.Width1 = v17 * 0.6 * v13
            Beam.CurveSize0 = v7 * v13
            Beam.CurveSize1 = v8 * v13
            Beam.TextureSpeed = (if not (4 < n.Width) then 2.2 else 0.9) * (1 + 2.5 * v5)
        end
        v13 = v3 and not Gone and v18 > 0.92
        j.Plug.CFrame = CFrame.lookAt(Position_3, Position_3 + v6.XVector)
        j.PlugGlow.Enabled = v13
        j.PlugSparks.Enabled = v13
        if v13 then
            v8 = (v19 * 0.5 + 0.8 + 0.4 * v5) * v12
            j.PlugGlow.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 2.6 * v8),
                (NumberSequenceKeypoint.new(1, 1.6 * v8)),
            })
            j.PlugSparks.Rate = v19 * 30 + 14 + 30 * v5
        end
        if v18 >= 1 and not j.Plugged then
            j.Plugged = true
            glowFlare(v1, Position_3, Pet.Hot, 6, 0.4)
            sparkleBurst(v1, Position_3, Pet.Hot, 16, 14)
        end
        v15 = nil
        v16 = nil
        for m, i5 in j.Pulses, v15, v16 do
            v13 = ((v22 - j.LinkAt) * (v19 * 0.9 + 0.55 + v5) + i5.Offset) % 1
            v12 = v3
            if v12 then
                v12 = not Gone
                if v12 then
                    v12 = false
                    if v18 >= 1 then
                        v12 = v2 < v13
                    end
                end
            end
            Part = i5.Part
            new_2 = CFrame.new
            v7 = 1 - v13
            Part.CFrame = new_2(Position_2 * (v7 * v7 * v7) + v4 * (v7 * 3 * v7 * v13) + v11 * (v7 * 3 * v13 * v13) + Position_3 * (v13 * v13 * v13))
            v13 = i5.Part:FindFirstChildOfClass("ParticleEmitter")
            if v13 then
                v13.Enabled = v12
            end
        end
    end
end

local function fadePet(a1, a2) -- Line: 2021 -- types: a2: number
    if a1.Faded and (math.abs(a1.Faded - a2)) < 0.01 then
        return
    end
    a1.Faded = a2
    for i, j in a1.Parts do
        j.LocalTransparencyModifier = a2
    end
end

local function stepPets(a1, a2) -- Line: 2031
    -- upvalues: u65 (val), Kit (val), petOrbit (val), sound (val), sparkleBurst (val), glowFlare (val), makeWisp (val)
    -- upvalues: u231 (val)
    local BoundingBox_2, Energy, Model, Motes, Position, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
    local v16 = os.clock()
    local Pets = a1.Pets
    local v17 = nil
    local v18 = nil
    local v19, v20 = a2, a1
    for i, j in Pets, v17, v18 do
        if not j.Gone then
            Model = j.Model
            v15 = u65.Pulse + (j.Order - 1) * 0.18
            v1 = Kit.Window(v19, v15, v15 + 0.45)
            v15 = 1 + math.sin(3.141592653589793 * v1) * 0.16 * (1 - v1 * 0.3)
            v2 = math.sin(v16 * 1.7 + j.Bob) * 0.45
            v3 = Kit.Window(v19, j.DissolveAt, j.DissolveAt + 1.9)
            v4 = Kit.Ease(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            v5, v6 = petOrbit(v20, j, v19)
            Position = if not v20.EyeNow then v20.Center else v20.EyeNow.Position
            v7 = Vector3.new(math.noise(v19 * 18, j.Order), math.noise(v19 * 18, j.Order + 9.1), (math.noise(v19 * 18, j.Order + 3.7))) * 0.35 * Kit.Window(v3, 0, 0.3)
            v8 = v6 + v4 * v4 * 3.141592653589793 * 1.4
            v6 = (v5 + Vector3.new(0, 1, 0) * v2):Lerp(Position, 0.92 * v4 ^ 1.6) + v7
            Model:PivotTo((CFrame.new(v6)) * j.Home.Rotation * (CFrame.Angles(0, v8, 0)))
            v8 = j.Base * v15 * (1 - 0.78 * v4)
            if 0.001 < (math.abs((Model:GetScale()) - v8)) then
                Model:ScaleTo((math.max(v8, 0.01)))
            end
            j.Core.CFrame = CFrame.new(v6 + Vector3.new(0, 1, 0) * j.Height * 0.45 * (1 - 0.6 * v4))
            v8 = Kit.Window(v3, 0, 0.3)
            j.Highlight.FillTransparency = 1 - 0.8 * v8 * (1 - Kit.Window(v3, 0.75, 1))
            j.Highlight.OutlineTransparency = 1 - 0.9 * v8 * (1 - Kit.Window(v3, 0.6, 0.95))
            v9 = Kit.Window(v3, 0.35, 0.95)
            if not j.Faded then
                j.Faded = v9
                for k, n in j.Parts do
                    n.LocalTransparencyModifier = v9
                end
            elseif not ((math.abs(j.Faded - v9)) < 0.01) then
                j.Faded = v9
                for m, i5 in j.Parts do
                    i5.LocalTransparencyModifier = v9
                end
            end
            v8 = math.sin(3.141592653589793 * (math.clamp(v3 * 1.15, 0, 1)))
            Energy = j.Energy
            v10 = false
            if v3 > 0 then
                v10 = v3 < 1
            end
            Energy.Enabled = v10
            j.Energy.Rate = v8 * 70
            j.Energy.Acceleration = (v20.Center - v6).Unit * 75
            Motes = j.Motes
            v10 = false
            if v3 > 0 then
                v10 = v3 < 0.95
            end
            Motes.Enabled = v10
            j.Motes.Rate = v8 * 60
            j.Glow.Brightness = math.sin(3.141592653589793 * v1) * 1.5 + v8 * 3.2
            if v3 > 0 and not j.FxOff then
                j.FxOff = true
                for i6, i7 in j.Fx do
                    i7.Enabled = false
                end
                sound(v20, "Dissolve", v6, 0.8, 0.94 + j.Order * 0.03)
                sparkleBurst(v20, v6, j.Hot, 30, 16)
                glowFlare(v20, v6 + Vector3.new(0, 1, 0) * j.Height * 0.3, j.Hot, j.Height * 1.4, 0.5)
                j.NextWisp = 0
            end
            if v3 > 0 and v3 < 0.85 and j.NextWisp and j.NextWisp < 7 and j.NextWisp / 7 * 0.85 <= v3 then
                j.NextWisp = j.NextWisp + 1
                _, BoundingBox_2 = Model:GetBoundingBox()
                v11 = makeWisp
                v12 = (u231:NextNumber(-0.5, 0.5)) * BoundingBox_2.X
                v13 = (u231:NextNumber(0, 0.8)) * BoundingBox_2.Y
                v14 = (u231:NextNumber(-0.5, 0.5)) * BoundingBox_2.Z
                v11(v20, j, v6 + Vector3.new(v12, v13, v14))
            end
            if v3 >= 0.82 and not j.RetractAt then
                j.RetractAt = v19
            end
            if v3 >= 1 then
                j.Gone = true
                Model.Parent = nil
                j.Energy.Enabled = false
                j.Motes.Enabled = false
                j.Highlight.Enabled = false
                j.Glow.Brightness = 0
            end
        end
    end
end

local function stepPads(a1, a2) -- Line: 2111 -- upvalues: Kit (val), u65 (val) -- types: a2: number
    local Column, Pet, Runes, v1, v2, v3, v4, v5
    local v6 = Kit.Smooth(Kit.Window(a2, u65.Link, u65.Lift)) * 0.6 + Kit.Smooth(Kit.Window(a2, u65.Lift, u65.Dissolve)) * 0.4
    local v7 = nil
    local v8 = nil
    local v9 = a2
    for i, j in a1.PadFx, v7, v8 do
        Pet = j.Pet
        v5 = u65.Pulse + (Pet.Order - 1) * 0.18
        v1 = math.sin(3.141592653589793 * (Kit.Window(v9, v5, v5 + 0.5)))
        v2 = 1 - Kit.Window(v9, Pet.DissolveAt + 1.2, Pet.DissolveAt + 2.2)
        v3 = 1 + 0.15 * math.noise(v9 * 6, Pet.Order * 2.3)
        j.Light.Brightness = (v1 * 2.6 + 0.6 + v6 * 1.6) * v2 * v3
        Column = j.Column
        v4 = false
        if v5 <= v9 then
            v4 = v2 > 0.05
        end
        Column.Enabled = v4
        j.Column.Rate = (v6 * 24 + 6) * v2
        Runes = j.Runes
        v4 = false
        if u65.Link <= v9 then
            v4 = v2 > 0.05
        end
        Runes.Enabled = v4
        j.Runes.Rate = v6 * 1.4 + 0.9
    end
end

local function orbitPoint(a1, a2, a3) -- Line: 2127 -- upvalues: Kit (val), u65 (val) -- types: a3: number
    local v1 = 1 - 0.12 * Kit.Smooth(Kit.Window(a3, u65.Merge, u65.Return))
    local v2 = a1.OrbitHub + a1.Across * ((math.cos(a2.Angle)) * a2.RadiusX * v1) + a1.Side * ((math.sin(a2.Angle)) * a2.RadiusZ * v1)
    local v3 = Vector3.new(v2.X, a2.Height + (math.sin(a2.Angle * 2 + a2.Phase)) * a2.Tilt + (math.sin(a3 * 1.7 + a2.Phase)) * 0.5, v2.Z)
    return (Vector3.new(
        math.clamp(v3.X, a1.Low.X + 1, a1.High.X - 1),
        math.clamp(v3.Y, a1.Floor + 1.6, a1.Ceiling - 1.6),
        (math.clamp(v3.Z, a1.Low.Z + 1, a1.High.Z - 1))
    ))
end

local function stepProps(a1, a2, a3) -- Line: 2139
    -- upvalues: u65 (val), freeProps (val), Kit (val), sound (val), u227 (val), u231 (val), orbitPoint (val)
    -- upvalues: burst (val), u62 (val), Workspace (val)
    local Axis, Home, Position_2, Rot, Rotation_2, Seed, fromAxisAngle, v1, v2, v3, v4, v5, v6
    if #a1.Props == 0 then
        return
    end
    if not a1.PropsFree and u65.Rattle <= a2 then
        freeProps(a1)
    end
    if not a1.PropsFree then
        return
    end
    local v7 = Kit.Smooth(Kit.Window(a2, u65.Merge, u65.Return))
    local v8 = (Kit.Smooth(Kit.Window(a2, u65.Link, u65.Lift)) * 0.6 + Kit.Smooth(Kit.Window(a2, u65.Lift, u65.Dissolve)) * 0.4) * 0.45 + 0.35 + 0.55 * v7
    local v9 = {}
    local v10 = {}
    local Props = a1.Props
    local v11 = nil
    local v12 = nil
    local v13, v14, v15 = a2, a1, a3
    for i, j in Props, v11, v12 do
        if not j.Landed then
            Home = j.Home
            if v13 < j.RattleAt then
                j.Pose = Home
                for i10, i11 in j.Parts do
                    if i11.Part.Parent then
                        table.insert(v9, i11.Part)
                        table.insert(v10, v1 * i11.Rel)
                    end
                end
            elseif not (v13 < j.LiftAt) then
                v2 = j.LiftAt + j.LiftSeconds
                v3 = Kit.Window(v13, j.LiftAt, v2)
                v2 = Kit.Smooth(v3)
                j.Angle = j.Angle + v8 * v15 * v2
                Rot = j.Rot
                fromAxisAngle = CFrame.fromAxisAngle
                Axis = j.Axis
                v6 = j.SpinRate * v15 * v2
                j.Rot = Rot * fromAxisAngle(Axis, v6 * (1 + v7))
                v2 = orbitPoint(v14, j, v13)
                Rotation_2 = Home.Rotation * j.Rot
                if not (v3 < 1) then
                    v4 = v2
                else
                    v5 = Kit.Ease(v3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    v4 = Kit.Bezier(Home.Position, Home.Position + Vector3.new(0, 1, 0) * (5 + j.Extent), v2, v5)
                end
                if not (j.ReturnAt <= v13) then
                    v1 = CFrame.new(v4) * Rotation_2
                    j.Pose = v1
                    for k, n in j.Parts do
                        if n.Part.Parent then
                            table.insert(v9, n.Part)
                            table.insert(v10, v1 * n.Rel)
                        end
                    end
                else
                    if not j.From then
                        j.From = v4
                        j.FromRot = Rotation_2
                    end
                    v3 = Kit.Window(v13, j.ReturnAt, j.ReturnAt + j.ReturnSeconds)
                    Position_2 = Home.Position
                    v6 = if not j.Slam then 1 else 3.2
                    v2 = Position_2 + Vector3.new(0, 1, 0) * v6
                    if not (v3 < 0.78) then
                        v5 = (v3 - 0.78) / 0.22
                        v4 = v2:Lerp(
                            Home.Position,
                            if not j.Slam then Kit.Ease(v5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) else v5 * v5
                        )
                        Rotation_2 = Home.Rotation
                    else
                        v5 = Kit.Ease(v3 / 0.78, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                        v4 = Kit.Bezier(v4, (j.From + v2) / 2 + Vector3.new(0, 3, 0), v2, v5)
                        Rotation_2 = j.FromRot:Lerp(Home.Rotation, (Kit.Smooth(v3 / 0.78)))
                    end
                    if not (v3 >= 1) then
                        v1 = CFrame.new(v4) * Rotation_2
                        j.Pose = v1
                        for m, i5 in j.Parts do
                            if i5.Part.Parent then
                                table.insert(v9, i5.Part)
                                table.insert(v10, v1 * i5.Rel)
                            end
                        end
                    else
                        j.Landed = true
                        for i6, i7 in j.Parts do
                            if i7.Part.Parent then
                                table.insert(v9, i7.Part)
                                table.insert(v10, i7.CFrame)
                            end
                        end
                        v14.LandCount = v14.LandCount + 1
                        if j.Slam or v14.LandCount % 3 == 0 then
                            burst(v14, Home.Position - Vector3.new(0, 0.20000000298023224, 0), {
                                LightEmission = 0,
                                Drag = 3,
                                Texture = u62.Smoke,
                                FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
                                FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
                                Color = ColorSequence.new(Color3.fromRGB(150, 128, 170)),
                                EmissionDirection = Enum.NormalId.Top,
                                SpreadAngle = Vector2.new(80, 80),
                                Speed = NumberRange.new(2, 5),
                                Lifetime = NumberRange.new(0.5, 0.9),
                                Rotation = NumberRange.new(0, 360),
                                Size = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 0.6),
                                    (NumberSequenceKeypoint.new(1, 2.2)),
                                }),
                                Transparency = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 0.55),
                                    (NumberSequenceKeypoint.new(1, 1)),
                                }),
                            }, 6)
                        end
                        if v14.LandCount == 1 or v14.LandCount == 7 or v14.LandCount == 15 then
                            sound(v14, "PropsLand", Home.Position, 0.9, u231:NextNumber(0.92, 1.08))
                        end
                    end
                end
            else
                v2 = Kit.Window(v13, j.RattleAt, j.LiftAt)
                Seed = j.Seed
                v1 = Home * CFrame.new(0, (math.max(math.noise(v13 * 14, Seed), 0)) * 0.35 * v2, 0) * CFrame.Angles(
                    math.noise(v13 * 12, Seed + 1) * 0.15707963267948966 * v2,
                    math.noise(v13 * 12, Seed + 2) * 0.10471975511965978 * v2,
                    math.noise(v13 * 12, Seed + 3) * 0.15707963267948966 * v2
                )
                if not j.Rattled and v2 > 0.3 then
                    j.Rattled = true
                    v14.RattleCount = v14.RattleCount + 1
                    if v14.RattleCount <= 4 then
                        sound(v14, u227[v14.RattleCount], Home.Position, 0.8, u231:NextNumber(0.9, 1.12))
                    end
                end
                j.Pose = v1
                for i8, i9 in j.Parts do
                    if i9.Part.Parent then
                        table.insert(v9, i9.Part)
                        table.insert(v10, v1 * i9.Rel)
                    end
                end
            end
        end
    end
    if #v9 > 0 then
        Workspace:BulkMoveTo(v9, v10, Enum.BulkMoveMode.FireCFrameChanged)
    end
end

local function dimAmount(a1) -- Line: 2277 -- upvalues: Kit (val), u65 (val) -- types: a1: number
    return (Kit.Smooth(Kit.Window(a1, u65.Crack - 0.3, u65.EyeOpen + 0.4))) * (1 - 0.75 * Kit.Smooth(Kit.Window(a1, u65.Flash + 0.2, u65.Egg + 2.4)))
end

local function stepLights(a1, a2) -- Line: 2283
    -- upvalues: dimAmount (val), u65 (val), Kit (val), u161 (val), u166 (val), u156 (val), u196 (val), u191 (val)
    -- upvalues: u201 (val)
    local Light, v1
    local v2 = dimAmount(a2)
    local v3 = if a2 < u65.Flash then 0 else if not (a2 < u65.Flash + 0.06) then math.exp(-(a2 - u65.Flash - 0.06) / 0.12) else (a2 - u65.Flash) / 0.06
    local v4 = (Kit.Smooth(Kit.Window(a2, u65.Merge - 0.3, u65.Narrow))) * (1 - Kit.Smooth(Kit.Window(a2, u65.Egg - 0.3, u65.Egg + 0.8)))
    local v5 = (math.max(math.sin(3.141592653589793 * (Kit.Window(a2, u65.Crack, u65.EyeOpen + 0.4))), (Kit.Window(a2, u65.Build, u65.Rattle)))) * (1 - Kit.Window(a2, u65.Egg, u65.Egg + 1))
    for i, j in a1.Lights do
        Light = j.Light
        if Light.Parent then
            v1 = 1 - v5 * 0.55 * (math.max(math.noise(a2 * 9, j.Seed), 0)) * 1.6
            Light.Brightness = j.Brightness * Kit.Lerp(1, 0.32, v2) * math.max(v1, 0.15) * (1 + 0.9 * v3)
            Light.Color = j.Color:Lerp(u161, (math.max(v2 * 0.75, v3)))
        end
    end
    v5 = if not a1.ImpactAt then -1 else a2 - a1.ImpactAt
    local v6 = if v5 < 0 then 0 else if not (v5 < 0.05) then math.exp(-(v5 - 0.05) / 0.1) else 1
    local Grade = a1.Grade
    if Grade then
        Grade.TintColor = (((u166:Lerp(u156, v2)):Lerp(u196, v4)):Lerp(u191, v3)):Lerp(u201, v6)
        Grade.Brightness = v2 * -0.06 - 0.06 * v4 + 0.08 * v3 + v6 * 0.12
        Grade.Contrast = v2 * 0.1 + 0.14 * v4 + 0.2 * v3 + v6 * 0.5
        Grade.Saturation = v2 * 0.1 + 0.15 * v4 + 0.25 * v3 - v6 * 0.45
    end
    if a1.Motes then
        a1.Motes.Enabled = v2 > 0.02
        a1.Motes.Rate = v2 * 40
    end
end

local function tintPart(a1, a2, a3, a4) -- Line: 2328
    -- upvalues: u131 (val)
    local Highlight = Instance.new("Highlight")
    Highlight.Adornee = a2
    Highlight.FillColor = a3
    Highlight.FillTransparency = a4
    Highlight.OutlineColor = u131
    Highlight.OutlineTransparency = 0.35
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Parent = a1
end

local function voidSkin(a1, a2) -- Line: 2339
    -- upvalues: partsOf (val), u181 (val), u62 (val), u171 (val), u131 (val), u176 (val), u186 (val)
    local Highlight, Highlight_2, Highlight_3, v1
    local v2, v3 = a1, a2
    for i, j in a1:GetDescendants() do
        if j:IsA("SurfaceAppearance") or j:IsA("Decal") or j:IsA("Texture") then
            j:Destroy()
        end
    end
    for k, n in partsOf(v2) do
        if not (0.99 <= n.Transparency) then
            n.Reflectance = 0
            if n.Name == v3.Shell then
                n.Color = u181
                n.Material = Enum.Material.SmoothPlastic
                if n:IsA("MeshPart") then
                    n.TextureID = u62.EggVeins
                end
                v1 = u171
                Highlight = Instance.new("Highlight")
                Highlight.Adornee = n
                Highlight.FillColor = v1
                Highlight.FillTransparency = 0.8
                Highlight.OutlineColor = u131
                Highlight.OutlineTransparency = 0.35
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                Highlight.Parent = v2
            elseif n.Name ~= v3.Gold then
                n.Color = u186
                n.Material = Enum.Material.SmoothPlastic
                v1 = u186
                Highlight_3 = Instance.new("Highlight")
                Highlight_3.Adornee = n
                Highlight_3.FillColor = v1
                Highlight_3.FillTransparency = 0.3
                Highlight_3.OutlineColor = u131
                Highlight_3.OutlineTransparency = 0.35
                Highlight_3.DepthMode = Enum.HighlightDepthMode.Occluded
                Highlight_3.Parent = v2
            else
                n.Color = u176
                n.Material = Enum.Material.Foil
                v1 = u176
                Highlight_2 = Instance.new("Highlight")
                Highlight_2.Adornee = n
                Highlight_2.FillColor = v1
                Highlight_2.FillTransparency = 0.35
                Highlight_2.OutlineColor = u131
                Highlight_2.OutlineTransparency = 0.35
                Highlight_2.DepthMode = Enum.HighlightDepthMode.Occluded
                Highlight_2.Parent = v2
            end
        end
    end
end

local function makeEgg(a1, a2) -- Line: 2369
    -- upvalues: Kit (val), u141 (val), u207 (val), voidSkin (val)
    local v1 = Kit.EggModel(a1.Fused, a2 or 6, u141)
    local v2 = u207[a1.Fused]
    if v2 then
        voidSkin(v1, v2)
    end
    v1.Parent = a1.Container
    return v1
end

local function buildEgg(a1) -- Line: 2379
    -- upvalues: Kit (val), u141 (val), u207 (val), voidSkin (val), u62 (val), u136 (val), u146 (val), u166 (val)
    -- upvalues: u151 (val), u131 (val), u176 (val), u231 (val)
    local Attachment, Attachment_2, Side, Trail, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = Kit.EggModel(a1.Fused, 8, u141)
    local v12 = u207[a1.Fused]
    if v12 then
        voidSkin(v11, v12)
    end
    v11.Parent = a1.Container
    local Scale = v11:GetScale()
    v11:ScaleTo(Scale * 0.02)
    local v13 = CFrame.new(a1.Center)
    local u238 = Kit.Part({
        Name = "EggDressing",
        Transparency = 1,
        Size = Vector3.new(12, 0.4000000059604645, 12),
        CFrame = v13,
    })
    u238.Parent = a1.Container

    local function emit(a1, a2) -- Line: 2386 -- upvalues: Kit (upval), u238 (val) -- types: a1: table, a2: userdata?
        local v1 = a2 or u238
        local v2 = Kit.Emitter(v1, a1)
        v2.Enabled = false
        return v2
    end

    local v14 = CFrame.new(a1.Center)
    local v15 = Kit.Part({
        Name = "EggBackdrop",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v14,
    })
    v15.Parent = a1.Container
    v14 = {}
    for i = 1, 4 do
        v2 = math.rad((i - 1) * 100 + -150 + (if i <= 2 then 0 else 20))
        Side = v1.Side
        v4 = (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v2)):VectorToWorldSpace(Side) * 8 * 0.95
        v6 = if i % 2 ~= 0 then -0.4 else 1.6
        v3 = v4 + Vector3.new(0, 1, 0) * v6
        v4 = CFrame.new(v1.Center + v3)
        v2 = Kit.Part({
            Name = "EggLantern",
            Transparency = 1,
            Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
            CFrame = v4,
        })
        v2.Parent = v1.Container
        v5 = {Part = v2, Offset = v3}
        v7 = {
            LightEmission = 0.8,
            Brightness = 2,
            Rate = 26,
            ZOffset = 0.3,
            Texture = u62.Flame,
            FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
            FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
            Color = ColorSequence.new(if i % 2 ~= 0 then u146 else u136, u141),
            EmissionDirection = Enum.NormalId.Top,
            SpreadAngle = Vector2.new(12, 12),
            Speed = NumberRange.new(4, 6),
            Lifetime = NumberRange.new(0.5, 0.75),
            Rotation = NumberRange.new(-8, 8),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.6), (NumberSequenceKeypoint.new(1, 2.6))}),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.1),
                NumberSequenceKeypoint.new(0.7, 0.35),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
        }
        v6 = Kit.Emitter(v2 or u238, v7)
        v6.Enabled = false
        v5.Fire = v6
        v7 = {
            LightEmission = 0.7,
            Rate = 0.9,
            ZOffset = 0.5,
            Texture = u62.Lantern,
            Color = ColorSequence.new(if i % 2 ~= 0 then u166 else u136),
            EmissionDirection = Enum.NormalId.Top,
            SpreadAngle = Vector2.new(20, 20),
            Speed = NumberRange.new(0.8, 1.6),
            Lifetime = NumberRange.new(1.6, 2.2),
            Rotation = NumberRange.new(-12, 12),
            RotSpeed = NumberRange.new(-14, 14),
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.2, 2.4),
                (NumberSequenceKeypoint.new(1, 2.9)),
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.2, 0.1),
                NumberSequenceKeypoint.new(0.75, 0.25),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
        }
        v6 = Kit.Emitter(v2 or u238, v7)
        v6.Enabled = false
        v5.Emitter = v6
        table.insert(v14, v5)
    end
    local v16 = {Part = u238, Back = v15, Lanterns = v14}
    local v17 = {
        LightEmission = 0.55,
        LockedToPart = true,
        Rate = 2.5,
        ZOffset = -3,
        Texture = u62.Swirl,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        Color = ColorSequence.new(u141, u151),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(1.6),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-70, -40),
        Size = NumberSequence.new(24),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.2),
            NumberSequenceKeypoint.new(0.7, 0.2),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }
    local v18 = Kit.Emitter(v15 or u238, v17)
    v18.Enabled = false
    v16.Backdrop = v18
    v17 = {
        LightEmission = 0.6,
        LockedToPart = true,
        Rate = 2,
        ZOffset = -4,
        Texture = u62.Glow,
        Color = ColorSequence.new(u141),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(1.2),
        Size = NumberSequence.new(27.2),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.4, 0.4),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }
    v18 = Kit.Emitter(v15 or u238, v17)
    v18.Enabled = false
    v16.BackGlow = v18
    v17 = {
        Drag = 1,
        Rate = 80,
        LightEmission = 0.8,
        Brightness = 2,
        ZOffset = -0.5,
        Texture = u62.Flame,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, u146),
            ColorSequenceKeypoint.new(0.5, u141),
            (ColorSequenceKeypoint.new(1, u151)),
        }),
        Shape = Enum.ParticleEmitterShape.Disc,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(7, 11),
        Lifetime = NumberRange.new(0.6, 0.9),
        Rotation = NumberRange.new(-10, 10),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 5))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.05),
            NumberSequenceKeypoint.new(0.7, 0.3),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }
    v18 = Kit.Emitter(u238, v17)
    v18.Enabled = false
    v16.Flames = v18
    v17 = {
        Drag = 1,
        Rate = 40,
        LightEmission = 0.8,
        Brightness = 2,
        ZOffset = -0.4,
        Texture = u62.Flame,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Color = ColorSequence.new(u136, u131),
        Shape = Enum.ParticleEmitterShape.Disc,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(6, 9),
        Lifetime = NumberRange.new(0.5, 0.75),
        Rotation = NumberRange.new(-10, 10),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.8), (NumberSequenceKeypoint.new(1, 3.2))}),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 1))}),
    }
    v18 = Kit.Emitter(u238, v17)
    v18.Enabled = false
    v16.BoneFlames = v18
    v17 = {
        LightEmission = 0.5,
        Rate = 10,
        Texture = u62.Shard,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Color = ColorSequence.new(u146, u131),
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        Speed = NumberRange.new(0.6, 1.6),
        Lifetime = NumberRange.new(1.4, 2.2),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-90, 90),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.2, 1.1),
            NumberSequenceKeypoint.new(0.8, 0.8),
            (NumberSequenceKeypoint.new(1, 0)),
        }),
    }
    v18 = Kit.Emitter(u238, v17)
    v18.Enabled = false
    v16.Shards = v18
    v17 = {
        Rate = 16,
        ZOffset = 1,
        Texture = u62.Sparkle,
        Color = ColorSequence.new(u166, u146),
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(1, 3),
        Lifetime = NumberRange.new(0.6, 1.2),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), (NumberSequenceKeypoint.new(1, 0))}),
    }
    v18 = Kit.Emitter(u238, v17)
    v18.Enabled = false
    v16.Shimmer = v18
    v17 = {
        Rate = 120,
        ZOffset = 1,
        Texture = u62.Spark,
        Orientation = Enum.ParticleOrientation.VelocityParallel,
        Color = ColorSequence.new(u136, u146),
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward,
        Speed = NumberRange.new(18, 30),
        Lifetime = NumberRange.new(0.3, 0.45),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.3, 1.2),
            (NumberSequenceKeypoint.new(1, 0)),
        }),
    }
    v18 = Kit.Emitter(u238, v17)
    v18.Enabled = false
    v16.Condense = v18
    v18 = CFrame.new(v1.Center)
    v14 = Kit.Part({
        Name = "EggCore",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v18,
    })
    v14.Parent = v1.Container
    v16.Core = v14
    v17 = CFrame.new(v1.Center)
    v18 = Kit.Part({
        Name = "EggEmbers",
        Transparency = 1,
        Size = Vector3.new(7.199999809265137, 7.199999809265137, 7.199999809265137),
        CFrame = v17,
    })
    v18.Parent = v1.Container
    v16.EmberHost = v18
    v17 = {
        LockedToPart = true,
        Rate = 50,
        ZOffset = 2,
        Texture = u62.Glow,
        Color = ColorSequence.new(u166, u146),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.12),
        Size = NumberSequence.new(1),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 0.6))}),
    }
    v18 = Kit.Emitter(v14 or u238, v17)
    v18.Enabled = false
    v16.CoreGlow = v18
    v17 = {
        LightEmission = 0.7,
        LockedToPart = true,
        Rate = 9,
        ZOffset = 1.5,
        Texture = u62.Swirl,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.Loop,
        FlipbookFramerate = NumberRange.new(24),
        Color = ColorSequence.new(u146, u141),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.45),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(300, 420),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 15.2), (NumberSequenceKeypoint.new(1, 0.4))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.35, 0.3),
            (NumberSequenceKeypoint.new(1, 0.9)),
        }),
    }
    v18 = Kit.Emitter(v14 or u238, v17)
    v18.Enabled = false
    v16.SwirlIn = v18
    v17 = {
        Acceleration = Vector3.new(0, 3.5, 0),
        Drag = 0.6,
        Rate = 26,
        ZOffset = 1,
        Texture = u62.Glow,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, u176),
            ColorSequenceKeypoint.new(0.4, u146),
            (ColorSequenceKeypoint.new(1, u141)),
        }),
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(0.6, 2.4),
        Lifetime = NumberRange.new(1.4, 2.4),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.15, 0.4),
            (NumberSequenceKeypoint.new(1, 0)),
        }),
    }
    local new_22 = NumberSequence.new
    v3 = {
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.7, 0.2),
        (NumberSequenceKeypoint.new(1, 1)),
    }
    v17.Transparency = new_22(v3)
    local EmberHost = v16.EmberHost
    v18 = Kit.Emitter(EmberHost or u238, v17)
    v18.Enabled = false
    v16.Embers = v18
    v14 = {}
    for j = 1, 10 do
        v4 = CFrame.new(v1.Center)
        v3 = Kit.Part({
            Name = "EggSpiral",
            Transparency = 1,
            Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
            CFrame = v4,
        })
        v3.Parent = v1.Container
        Attachment = Instance.new("Attachment")
        Attachment.Position = Vector3.new(0, 0.30000001192092896, 0)
        Attachment.Parent = v3
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Position = Vector3.new(0, -0.30000001192092896, 0)
        Attachment_2.Parent = v3
        v5 = if j % 2 ~= 0 then u146 else u136
        Trail = Instance.new("Trail")
        Trail.Attachment0 = Attachment
        Trail.Attachment1 = Attachment_2
        Trail.Texture = u62.Glow
        Trail.TextureMode = Enum.TextureMode.Stretch
        Trail.Color = ColorSequence.new(v5, u141)
        Trail.Transparency = NumberSequence.new(0.1, 1)
        Trail.WidthScale = NumberSequence.new(1, 0.2)
        Trail.Lifetime = 0.22
        Trail.MinLength = 0.05
        Trail.LightEmission = 1
        Trail.LightInfluence = 0
        Trail.FaceCamera = true
        Trail.Enabled = false
        Trail.Parent = v3
        v8 = {
            Part = v3,
            Trail = Trail,
            Angle = (j - 1) / 10 * 3.141592653589793 * 2,
            Reach = u231:NextNumber(0.85, 1.15),
            Lag = u231:NextNumber(0, 0.12),
        }
        v10 = {
            LockedToPart = true,
            Rate = 30,
            ZOffset = 1.5,
            Texture = u62.Flare,
            FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
            FlipbookMode = Enum.ParticleFlipbookMode.Loop,
            Color = ColorSequence.new(v5),
            Speed = NumberRange.new(0),
            Lifetime = NumberRange.new(0.14),
            Size = NumberSequence.new(1.4),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), (NumberSequenceKeypoint.new(1, 1))}),
        }
        v9 = Kit.Emitter(v3 or u238, v10)
        v9.Enabled = false
        v8.Glint = v9
        table.insert(v14, v8)
    end
    v16.Spiral = v14
    v14 = Instance.new("PointLight")
    v14.Color = u146
    v14.Range = 20
    v14.Brightness = 0
    v14.Shadows = false
    v14.Parent = u238
    v16.Light = v14
    v14 = Instance.new("PointLight")
    v14.Color = u131
    v14.Range = 14
    v14.Brightness = 0
    v14.Shadows = false
    v14.Parent = v15
    v16.Rim = v14
    v1.Egg = {Model = v11, Full = Scale, Dressing = v16}
end

local function stepEgg(a1, a2) -- Line: 2738 -- upvalues: u68 (val), Kit (val), u65 (val) -- types: a2: number
    local v1, v2, v3
    local Egg = a1.Egg
    if not Egg then
        return
    end
    if a1.PayoffAt and a1.P and u68.Split <= a1.P then
        return
    end
    local Dressing = Egg.Dressing
    local v4 = Kit.Window(a2, u65.Condense, u65.Egg)
    local v5 = false
    if v4 > 0 then
        v5 = v4 < 1
    end
    Dressing.Condense.Enabled = v5
    Dressing.Part.Size = Vector3.new(12, 0.4000000059604645, 12) * (1 + 1.6 * (1 - v4))
    local v6 = Kit.Window(a2, u65.Egg - 0.12, u65.Egg)
    local v7 = (0.8 + 4.6 * v4 * v4) * (1 - 0.8 * v6) + math.sin(a2 * 40) * 0.6 * v4
    Dressing.CoreGlow.Enabled = v5
    if v5 then
        Dressing.CoreGlow.Size = NumberSequence.new((math.max(v7, 0.3)))
    end
    Dressing.SwirlIn.Enabled = v5 and v4 < 0.9
    local v8 = nil
    local v9 = nil
    local v10 = a2
    for i, j in Dressing.Spiral, v8, v9 do
        v7 = math.clamp((v4 - j.Lag) / (1 - j.Lag), 0, 1)
        v6 = v5
        if v6 then
            v6 = false
            if v7 > 0 then
                v6 = v7 < 1
            end
        end
        j.Trail.Enabled = v6
        j.Glint.Enabled = v6
        if v6 then
            v2 = 13.6 * j.Reach * (1 - v7) ^ 1.3
            v3 = j.Angle + v7 * 3.141592653589793 * 3.2
            j.Part.CFrame = CFrame.new(v1.Center + v1.Across * (math.cos(v3) * v2) + Vector3.new(0, 1, 0) * (math.sin(v3) * v2 * 0.8) + v1.Side * (math.sin(v3 * 2) * v2 * 0.25))
        end
    end
    v5 = v10 - u65.Egg
    v4 = if v5 <= 0 then 0 else if not (v5 > 1.4) then 1 - (math.exp(-7 * v5)) * math.cos(14 * v5) else 1
    local v11 = if not v1.PayoffAt then 1 else math.sin(3.141592653589793 * (Kit.Window(os.clock() - v1.PayoffAt, 0, u68.Split))) * 0.18 + 1
    v8 = Egg.Full * math.max(v4, 0.02) * v11
    local Model = Egg.Model
    if v4 <= 0 then
        Model.Parent = nil
        return
    end
    if Model.Parent ~= v1.Container then
        Model.Parent = v1.Container
    end
    if 0.0001 < (math.abs((Model:GetScale()) - v8)) then
        Model:ScaleTo(v8)
    end
    v8 = math.sin(v10 * 2.1) * 0.35
    v9 = v1.Center + Vector3.new(0, 1, 0) * v8
    local v12 = (v10 - u65.Egg) * 0.9
    Model:PivotTo((CFrame.new(v9)) * (CFrame.Angles(0, v12, (math.sin(v10 * 1.3)) * 0.06)))
    Egg.Position = v9
    v12 = v9 - Vector3.new(0, 4, 0)
    Dressing.Part.CFrame = CFrame.new(v12)
    Dressing.EmberHost.CFrame = CFrame.new(v9)
    Dressing.Back.CFrame = CFrame.lookAt(v1.Center - v1.Side * 5 + Vector3.new(0, 0.5, 0), v1.Center + v1.Side * 10)
    v2 = nil
    v3 = nil
    for k, n in Dressing.Lanterns, v2, v3 do
        n.Part.CFrame = CFrame.new(v1.Center + n.Offset + Vector3.new(0, 1, 0) * v8 * 0.5)
        n.Emitter.Enabled = v4 > 0.5
        n.Fire.Enabled = v4 > 0.3
    end
    Dressing.Flames.Enabled = v4 > 0.2
    Dressing.BoneFlames.Enabled = v4 > 0.2
    Dressing.Shards.Enabled = v4 > 0.4
    Dressing.Shimmer.Enabled = v4 > 0.4
    Dressing.Embers.Enabled = v5 > 0.05
    Dressing.Backdrop.Enabled = v4 > 0.1
    Dressing.BackGlow.Enabled = v4 > 0.1
    v12 = math.exp(-(math.max(v5, 0)) / 0.35)
    Dressing.Light.Brightness = v4 * 2.2 + math.sin(v10 * 5) * 0.5 + v12 * 5
    Dressing.Rim.Brightness = v4 * 2.4 + v12 * 2
end

local function flameBurst(a1, a2, a3, a4, a5) -- Line: 2824
    -- upvalues: burst (val), u62 (val), u141 (val), u151 (val)
    burst(a1, a2, {
        LightEmission = 0.85,
        Brightness = 2,
        Drag = 3.5,
        Acceleration = Vector3.new(0, 6, 0),
        ZOffset = 2,
        Texture = u62.Flame,
        FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
        FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, a3),
            ColorSequenceKeypoint.new(0.5, u141),
            (ColorSequenceKeypoint.new(1, u151)),
        }),
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(a5 * 0.5, a5),
        Lifetime = NumberRange.new(0.55, 0.85),
        Rotation = NumberRange.new(-20, 20),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.8), (NumberSequenceKeypoint.new(1, 4.4))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.05),
            NumberSequenceKeypoint.new(0.6, 0.35),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }, a4)
end

local function floorDust(a1, a2, a3) -- Line: 2855
    -- upvalues: Kit (val), u62 (val), u146 (val), u151 (val)
    local v1, v2, v3
    for i = 1, a3 do
        v1 = (i - 1) / a3 * 3.141592653589793 * 2
        v2 = a1.Across * math.cos(v1) + a1.Side * math.sin(v1)
        v3 = CFrame.lookAt(a2 + v2 * 2, a2 + v2 * 3)
        local u37 = Kit.Part({
            Name = "VoidDust",
            Transparency = 1,
            Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
            CFrame = v3,
        })
        u37.Parent = a1.Container
        Kit.Emitter(u37, {
            LightEmission = 0.4,
            Drag = 3,
            Texture = u62.Smoke,
            FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
            FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
            Color = ColorSequence.new(u146, u151),
            EmissionDirection = Enum.NormalId.Front,
            SpreadAngle = Vector2.new(12, 6),
            Speed = NumberRange.new(16, 24),
            Lifetime = NumberRange.new(0.7, 1),
            Rotation = NumberRange.new(0, 360),
            RotSpeed = NumberRange.new(-60, 60),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), (NumberSequenceKeypoint.new(1, 5))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), (NumberSequenceKeypoint.new(1, 1))}),
        }):Emit(2)
        task.delay(3, function() -- Line: 2883 -- upvalues: u37 (val)
            u37:Destroy()
        end)
    end
end

local function eggBorn(a1) -- Line: 2889
    -- upvalues: sound (val), kick (val), flatWave (val), u146 (val), u131 (val), floorDust (val), u141 (val)
    -- upvalues: faceWave (val), u201 (val), glowFlare (val), u166 (val), sparkleBurst (val), shardBurst (val)
    -- upvalues: flameBurst (val), u136 (val), burst (val), u62 (val), u176 (val)
    local Center = a1.Center
    a1.ImpactAt = a1.T
    sound(a1, "Boom", Center, 1)
    kick(a1, 1.8)
    a1.FovKick = math.max(a1.FovKick, 1.3)
    local v1 = Vector3.new(Center.X, a1.Floor + 0.3, Center.Z)
    local v2 = Vector3.new(Center.X, a1.PadTop + 0.3, Center.Z)
    flatWave(a1, v1, u146, 60, 0.9)
    flatWave(a1, v1, u131, 38, 0.6)
    floorDust(a1, v1, 14)
    flatWave(a1, v2, u141, 44, 0.75)
    flatWave(a1, Center - Vector3.new(0, 4, 0), u141, 34, 0.8)
    faceWave(a1, Center, u201, 30, 0.35)
    faceWave(a1, Center, u146, 22, 0.55)
    glowFlare(a1, Center, u166, 14, 0.3)
    glowFlare(a1, Center, u146, 20, 1.1)
    sparkleBurst(a1, Center, u131, 50, 34)
    sparkleBurst(a1, Center, u146, 60, 38)
    shardBurst(a1, Center, u146, 26, 32)
    shardBurst(a1, Center, u131, 16, 28)
    flameBurst(a1, Center, u146, 18, 22)
    flameBurst(a1, Center, u136, 10, 18)
    burst(a1, Center, {
        LightEmission = 0.7,
        Drag = 2.8,
        Acceleration = Vector3.new(0, 4, 0),
        ZOffset = 2.5,
        Texture = u62.Lantern,
        Color = ColorSequence.new(u166),
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(10, 15),
        Lifetime = NumberRange.new(1, 1.4),
        Rotation = NumberRange.new(-15, 15),
        RotSpeed = NumberRange.new(-40, 40),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.15, 3),
            (NumberSequenceKeypoint.new(1, 2.2)),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.7, 0.2),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }, 6)
    burst(a1, Center, {
        Drag = 2,
        Acceleration = Vector3.new(0, 3, 0),
        ZOffset = 1,
        Texture = u62.Glow,
        Color = ColorSequence.new(u176, u146),
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(8, 20),
        Lifetime = NumberRange.new(1.2, 2.2),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), (NumberSequenceKeypoint.new(1, 0))}),
    }, 60)
    if a1.Loops.Shimmer then
        return
    end
    a1.Loops.Shimmer = sound(a1, "Shimmer", Center, 0.9) or false
end

local function implode(a1) -- Line: 2952
    -- upvalues: fadeOut (val), setLoop (val), burstPhase (val), kick (val), sparkleBurst (val), u146 (val)
    local Center = a1.Center
    local Swirl = a1.Loops.Swirl
    if Swirl then
        fadeOut(Swirl, 0.35)
    end
    local Hum = a1.Loops.Hum
    if Hum then
        fadeOut(Hum, 0.6)
    end
    if a1.Rift then
        setLoop(a1, a1.Rift, "Loop", false, true)
        burstPhase(a1.Rift, "Close")
    end
    local Vortex = a1.Vortex
    if Vortex then
        for i, j in Vortex:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                j.Enabled = false
                j:Clear()
            end
        end
    end
    kick(a1, 0.9)
    sparkleBurst(a1, Center, u146, 40, 20)
end

local function flashBeat(a1) -- Line: 2965
    -- upvalues: kick (val), faceWave (val), u146 (val), u141 (val), flatWave (val), glowFlare (val), sparkleBurst (val)
    -- upvalues: u131 (val)
    local Center = a1.Center
    kick(a1, 1.6)
    a1.FovKick = math.max(a1.FovKick, 1)
    faceWave(a1, Center, u146, a1.RiftSize * 3.2, 0.55)
    faceWave(a1, Center, u141, a1.RiftSize * 2, 0.4)
    flatWave(a1, Center, u141, a1.RiftSize * 5, 0.8)
    glowFlare(a1, Center, u146, a1.RiftSize * 0.9, 0.25)
    sparkleBurst(a1, Center, u131, 26, 34)
    sparkleBurst(a1, Center, u146, 34, 38)
end

local function tearOpen(a1) -- Line: 2977
    -- upvalues: burstPhase (val), setLoop (val), kick (val), faceWave (val), u146 (val), sparkleBurst (val), u131 (val)
    -- upvalues: sound (val)
    local Center = a1.Center
    if a1.Rift then
        burstPhase(a1.Rift, "Burst")
        setLoop(a1, a1.Rift, "Loop", true)
    end
    local Vortex = a1.Vortex
    if Vortex then
        for i, j in Vortex:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                j.Enabled = not string.find(j.Name, "tech_vortex", 1, true)
            end
        end
    end
    kick(a1, 1)
    a1.FovKick = math.max(a1.FovKick, 0.9)
    faceWave(a1, Center, u146, a1.RiftSize * 2.4, 0.6)
    sparkleBurst(a1, Center, u146, 50, 34)
    sparkleBurst(a1, Center, u131, 30, 28)
    if a1.Loops.Swirl then
        return
    end
    a1.Loops.Swirl = sound(a1, "Swirl", Center, 0.8) or false
end

local function beats(a1, a2) -- Line: 2992
    -- upvalues: u65 (val), sound (val), flatWave (val), sparkleBurst (val), kick (val), glowFlare (val), u171 (val)
    -- upvalues: faceWave (val), u146 (val), Kit (val), sounds (val), tearOpen (val), fadeOut (val), implode (val)
    -- upvalues: flashBeat (val), eggBorn (val)
    local v1, v2, v3, v4
    local Fired = a1.Fired

    local function once(a1, a2_2) -- Line: 2994 -- upvalues: Fired (val), a2 (val) -- types: a1: string, a2_2: number
        if not Fired[a1] and not (a2 < a2_2) then
            Fired[a1] = true
            return true
        end
        return false
    end

    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in a1.Pets, v5, v6 do
        v4 = u65.Pulse + (j.Order - 1) * 0.18
        v2 = "Pulse" .. j.Order
        if Fired[v2] then
            v1 = false
        elseif not (a2 < v4) then
            Fired[v2] = true
            v1 = true
        else
            v1 = false
        end
        if v1 then
            sound(v7, "Place", j.Top, 0.75, 0.95 + j.Order * 0.04)
            flatWave(v7, j.Top + Vector3.new(0, 0.20000000298023224, 0), j.Color, 14, 0.7)
            sparkleBurst(v7, j.Top + Vector3.new(0, 1, 0) * j.Height * 0.5, j.Hot, 18, 12)
        end
    end
    local Lock = u65.Lock
    if Fired.Gaze then
        v3 = false
    elseif not (a2 < Lock) then
        Fired.Gaze = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        kick(v7, 0.3)
        v7.FovKick = math.max(v7.FovKick, 0.35)
        local EyeNow = v7.EyeNow or CFrame.new(v7.Center)
        v3 = EyeNow.Position + v7.Side * (v7.RiftSize * 0.05)
        glowFlare(v7, v3, u171, v7.RiftSize * 0.45, 0.35)
        faceWave(v7, v3, u146, v7.RiftSize * 1.4, 0.45)
    end
    local Link = u65.Link
    if Fired.Link then
        v3 = false
    elseif not (a2 < Link) then
        Fired.Link = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        sound(v7, "Link", v7.Center, 1)
        kick(v7, 0.35)
        for k, n in v7.Pets do
            glowFlare(v7, n.Core.Position, n.Hot, 6, 0.35)
        end
    end
    local Build = u65.Build
    if Fired.Build then
        v3 = false
    elseif not (a2 < Build) then
        Fired.Build = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        local Center = v7.Center
        if not v7.Loops.Hum then
            v7.Loops.Hum = sound(v7, "Hum", Center, 0.9) or false
        end
    end
    local Rattle = u65.Rattle
    if Fired.Rattle then
        v3 = false
    elseif not (a2 < Rattle) then
        Fired.Rattle = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        local Center_2 = v7.Center
        if not v7.Loops.Rumble then
            v7.Loops.Rumble = sound(v7, "Rumble", Center_2, 0.9) or false
        end
    end
    if u65.Rattle <= a2 and a2 < u65.Return + 2.6 then
        v7.ShakePower = math.max(
            v7.ShakePower,
            0.16 * ((Kit.Window(a2, u65.Rattle, u65.Lift + 1)) * (1 - Kit.Window(a2, u65.Return + 1.6, u65.Return + 2.6)))
        )
    end
    local Crack = u65.Crack
    if Fired.Crack then
        v3 = false
    elseif not (a2 < Crack) then
        Fired.Crack = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        glowFlare(v7, v7.Center, u146, 5, 0.6)
    end
    local Tear = u65.Tear
    local RiftOpen = sounds().RiftOpen
    v5 = Tear - (type(RiftOpen) == "table" and tonumber(RiftOpen.Hit) or 0)
    if Fired.RiftOpenSfx then
        v3 = false
    elseif not (a2 < v5) then
        Fired.RiftOpenSfx = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        sound(v7, "RiftOpen", v7.Center, 1)
    end
    local Tear_2 = u65.Tear
    if Fired.Tear then
        v3 = false
    elseif not (a2 < Tear_2) then
        Fired.Tear = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        tearOpen(v7)
    end
    local EyeOpen = u65.EyeOpen
    local EyeOpen_2 = sounds().EyeOpen
    v5 = EyeOpen - (type(EyeOpen_2) == "table" and tonumber(EyeOpen_2.Hit) or 0)
    if Fired.EyeOpenSfx then
        v3 = false
    elseif not (a2 < v5) then
        Fired.EyeOpenSfx = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        sound(v7, "EyeOpen", v7.Center, 1)
    end
    local EyeOpen_3 = u65.EyeOpen
    if Fired.EyeOpen then
        v3 = false
    elseif not (a2 < EyeOpen_3) then
        Fired.EyeOpen = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        kick(v7, 0.45)
        if v7.Eye then
            glowFlare(v7, v7.Center + v7.Side * 0.6, u146, v7.RiftSize * 0.7, 0.5)
        end
    end
    if u65.Dissolve <= a2 and a2 < u65.Merge then
        v7.ShakePower = math.max(v7.ShakePower, 0.2)
    end
    local Merge = u65.Merge
    if Fired.Merge then
        v3 = false
    elseif not (a2 < Merge) then
        Fired.Merge = true
        v3 = true
    else
        v3 = false
    end
    if v3 and v7.Vortex then
        for m, i5 in v7.Vortex:GetDescendants() do
            if i5:IsA("ParticleEmitter") and string.find(i5.Name, "tech_vortex", 1, true) then
                i5.Enabled = true
            end
        end
    end
    if u65.Merge <= a2 and a2 < u65.Implode then
        v7.ShakePower = math.max(v7.ShakePower, 0.2 + 0.5 * (Kit.Window(a2, u65.Merge, u65.Implode)))
    end
    local Egg = u65.Egg
    local Riser = sounds().Riser
    v5 = Egg - (type(Riser) == "table" and tonumber(Riser.Hit) or 0)
    if Fired.Riser then
        v3 = false
    elseif not (a2 < v5) then
        Fired.Riser = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        sound(v7, "Riser", v7.Center, 1)
    end
    local Implode_2 = u65.Implode
    local Implode_3 = sounds().Implode
    v5 = Implode_2 - (type(Implode_3) == "table" and tonumber(Implode_3.Hit) or 0)
    if Fired.ImplodeSfx then
        v3 = false
    elseif not (a2 < v5) then
        Fired.ImplodeSfx = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        sound(v7, "Implode", v7.Center, 1)
    end
    v5 = u65.Return + 2.4
    if Fired.Return then
        v3 = false
    elseif not (a2 < v5) then
        Fired.Return = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        local Rumble = v7.Loops.Rumble
        if Rumble then
            fadeOut(Rumble, 1.2)
        end
    end
    local Implode_4 = u65.Implode
    if Fired.Implode then
        v3 = false
    elseif not (a2 < Implode_4) then
        Fired.Implode = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        implode(v7)
    end
    local Flash = u65.Flash
    if Fired.Flash then
        v3 = false
    elseif not (a2 < Flash) then
        Fired.Flash = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        flashBeat(v7)
    end
    local Egg_2 = u65.Egg
    if Fired.Egg then
        v3 = false
    elseif not (a2 < Egg_2) then
        Fired.Egg = true
        v3 = true
    else
        v3 = false
    end
    if v3 then
        eggBorn(v7)
    end
end

local function finish(a1) -- Line: 3097 -- upvalues: u229 (ref), restoreProps (val), restoreLights (val), fadeOut (val)
    if a1.Dead then
        return
    end
    a1.Dead = true
    if u229 == a1 then
        u229 = nil
    end
    restoreProps(a1)
    restoreLights(a1)
    for i in a1.Sounds do
        if i.Parent and i.Looped then
            fadeOut(i, 0.6)
        end
    end
    local Bed = a1.Bed
    if Bed and Bed.Parent then
        fadeOut(Bed, if not a1.PayoffAt then 0.8 else 2.2)
        task.delay(3, function() -- Line: 3115 -- upvalues: Bed (val)
            Bed:Destroy()
        end)
    end
    for j, k in a1.Guards do
        k:Reveal()
    end
    a1.Trove:Destroy()
end

local function landing(a1, a2) -- Line: 3125 -- upvalues: Workspace (val) -- types: a2: vector
    local v1 = (Vector3.new(a2.X, a1.PadTop, a2.Z)) + a1.Side * 7
    local v2 = Workspace
    local v3 = v1 + Vector3.new(0, 6, 0)
    local FloorParams = a1.FloorParams
    v2 = v2:Raycast(v3, Vector3.new(-0, -40, -0), FloorParams)
    if v2 then
        return v2.Position
    end
    return v1
end

local function makeEggs(a1) -- Line: 3131
    -- upvalues: Workspace (val), Kit (val), u141 (val), u207 (val), voidSkin (val), u62 (val), u136 (val), u146 (val)
    local Attachment, Attachment_2, BoundingBox_2, Character, FloorParams, Land, Position, Row, Trail, v1, v2, v3, v4, v5, v6, v7, v8, v9
    a1.Eggs = {}
    local Seats = a1.Seats
    local v10 = {}
    local v11 = (math.max(if not Seats then #a1.Kind.Sides else #Seats, 2))
    for i = 1, v11 do
        v7 = if not Seats then nil else Seats[i]
        v8 = {}
        v2 = nil
        v3 = nil
        for j, k in v1.Kind.Sides, v2, v3 do
            v6 = if not v7 then v1.Pads[k] else v7[k]
            if v6 then
                table.insert(v8, v6)
            end
        end
        v9 = Vector3.new(0, 0, 0)
        for n, m in v8 do
            v9 = v9 + (m.Position + Vector3.new(0, 1, 0) * (m.Size.Y / 2))
        end
        Row = if not (#v8 > 0) then v1.Row else v9 / #v8
        v3 = (Vector3.new(Row.X, v1.PadTop, Row.Z)) + v1.Side * 7
        v4 = Workspace
        v6 = v3 + Vector3.new(0, 6, 0)
        FloorParams = v1.FloorParams
        v4 = v4:Raycast(v6, Vector3.new(-0, -40, -0), FloorParams)
        Position = if not v4 then v3 else v4.Position
        Character = if not v7 then v1.Characters[v1.Kind.Sides[i]] else v7.Character
        if Character and v10[Character] then
            Character = nil
        end
        if Character then
            v10[Character] = true
        end
        v7 = Kit.EggModel(v1.Fused, 6, u141)
        v2 = u207[v1.Fused]
        if v2 then
            voidSkin(v7, v2)
        end
        v7.Parent = v1.Container
        _, BoundingBox_2 = v7:GetBoundingBox()
        v7.Parent = nil
        v4 = CFrame.new(v1.Center)
        v2 = Kit.Part({
            Name = "EggTrail",
            Transparency = 1,
            Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
            CFrame = v4,
        })
        v2.Parent = v1.Container
        Attachment = Instance.new("Attachment")
        Attachment.Position = Vector3.new(0, 0.699999988079071, 0)
        Attachment.Parent = v2
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Position = Vector3.new(0, -0.699999988079071, 0)
        Attachment_2.Parent = v2
        Trail = Instance.new("Trail")
        Trail.Attachment0 = Attachment
        Trail.Attachment1 = Attachment_2
        Trail.Texture = u62.Glow
        Trail.TextureMode = Enum.TextureMode.Stretch
        Trail.Color = ColorSequence.new(if i ~= 1 then u146 else u136, u141)
        Trail.Transparency = NumberSequence.new(0.25, 1)
        Trail.WidthScale = NumberSequence.new(1, 0.3)
        Trail.Lifetime = 0.35
        Trail.LightEmission = 1
        Trail.LightInfluence = 0
        Trail.FaceCamera = true
        Trail.Enabled = false
        Trail.Parent = v2
        v5 = Instance.new("PointLight")
        v5.Color = u146
        v5.Range = 12
        v5.Brightness = 2.5
        v5.Shadows = false
        v5.Parent = v2
        table.insert(v1.Eggs, {
            Model = v7,
            Full = v7:GetScale(),
            Glow = v2,
            Trail = Trail,
            Index = i,
            Land = Position + Vector3.new(0, 1, 0) * (BoundingBox_2.Y / 2 + 0.2),
            Lift = BoundingBox_2.Y / 2 + 0.2,
            Character = Character,
            Guard = v1.Guards[i],
        })
    end
    v10 = false
    local v12 = nil
    local v13 = nil
    for i5, i6 in v1.Eggs, v12, v13 do
        v3 = i5 + 1
        v9 = #v1.Eggs
        for i7 = v3, v9 do
            Land = v1.Eggs[i7].Land
            if Vector3.new(i6.Land.X - Land.X, 0, i6.Land.Z - Land.Z).Magnitude < 6 then
                v10 = true
            end
        end
    end
    if v10 then
        local FloorParams_2, Position_2, v14
        local v15 = #v1.Eggs
        v11 = math.max(v1.RowSpan * 0.34, 10)
        v13 = nil
        v7 = nil
        for i8, i9 in v1.Eggs, v13, v7 do
            v2 = v1.Row + v1.Across * ((i8 - (v15 + 1) / 2) * v11)
            v5 = (Vector3.new(v2.X, v1.PadTop, v2.Z)) + v1.Side * 7
            v6 = Workspace
            v14 = v5 + Vector3.new(0, 6, 0)
            FloorParams_2 = v1.FloorParams
            v6 = v6:Raycast(v14, Vector3.new(-0, -40, -0), FloorParams_2)
            Position_2 = if not v6 then v5 else v6.Position
            i9.Land = Position_2 + Vector3.new(0, 1, 0) * i9.Lift
        end
    end
end

local function stepPayoff(a1) -- Line: 3221
    -- upvalues: u68 (val), sound (val), fadeOut (val), faceWave (val), u146 (val), sparkleBurst (val), u131 (val)
    -- upvalues: kick (val), Kit (val), flatWave (val), u141 (val), glowFlare (val), u166 (val), finish (val)
    local Full, Land, Model, v1, v2, v3, v4
    local v5 = os.clock() - a1.PayoffAt
    a1.P = v5
    local Center = a1.Center
    local Egg = a1.Egg
    if not a1.Split and u68.Split <= v5 then
        a1.Split = true
        sound(a1, "Reward", Center, 1)
        local Shimmer = a1.Loops.Shimmer
        if Shimmer then
            fadeOut(Shimmer, 1.5)
        end
        if Egg then
            Egg.Model.Parent = nil
            for i, j in {
                "Flames",
                "BoneFlames",
                "Shards",
                "Shimmer",
                "Condense",
                "Backdrop",
                "BackGlow",
                "Embers",
                "CoreGlow",
                "SwirlIn",
            } do
                v4 = Egg.Dressing[j]
                v4.Enabled = false
            end
            for k, n in Egg.Dressing.Lanterns do
                n.Emitter.Enabled = false
                n.Fire.Enabled = false
            end
            Egg.Dressing.Light.Brightness = 0
            Egg.Dressing.Rim.Brightness = 0
        end
        faceWave(a1, Center, u146, 22, 0.5)
        sparkleBurst(a1, Center, u146, 50, 28)
        sparkleBurst(a1, Center, u131, 30, 22)
        kick(a1, 0.7)
        a1.FovKick = math.max(a1.FovKick, 0.6)
    end
    local v6 = nil
    local v7 = nil
    for m, i5 in a1.Eggs, v6, v7 do
        Model = i5.Model
        if not i5.Done and not (v5 < u68.Split) then
            Full = i5.Full
            if v5 < u68.Land then
                v2 = Kit.Window(v5, u68.Split, u68.Land)
                v4 = Kit.Bezier(
                    Center,
                    (Center + i5.Land) / 2 + Vector3.new(0, 9, 0),
                    i5.Land,
                    Kit.Ease(v2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                )
                v1 = v2 * 3.141592653589793 * 3
                Full = Full * (0.6 + 0.4 * Kit.Smooth(v2))
                i5.Trail.Enabled = true
                Model.Parent = a1.Container
                if 0.0001 < (math.abs((Model:GetScale()) - Full)) then
                    Model:ScaleTo((math.max(Full, 0.01)))
                end
                Model:PivotTo((CFrame.new(v4)) * (CFrame.Angles(0, v1, 0)))
                i5.Glow.CFrame = CFrame.new(v4)
                i5.Position = v4
            elseif v5 < u68.Handoff then
                v2 = v5 - u68.Land
                v3 = math.abs((math.sin((math.min(v2 / 0.42, 1)) * 3.141592653589793))) * 1.3 * math.exp(-v2 * 2)
                v4 = i5.Land + Vector3.new(0, 1, 0) * v3
                if not i5.Landed then
                    i5.Landed = true
                    i5.Trail.Enabled = false
                    sound(a1, "PropsLand", i5.Land, 0.6, 1.25)
                    flatWave(a1, i5.Land - Vector3.new(0, 2.700000047683716, 0), if i5.Index ~= 1 then u141 else u131, 18, 0.6)
                    sparkleBurst(a1, i5.Land, u146, 30, 16)
                    kick(a1, 0.35)
                end
                if i5.Character or not (u68.Done - 0.2 < v5) then
                    Model.Parent = a1.Container
                    if 0.0001 < (math.abs((Model:GetScale()) - Full)) then
                        Model:ScaleTo((math.max(Full, 0.01)))
                    end
                    Model:PivotTo((CFrame.new(v4)) * (CFrame.Angles(0, 0, 0)))
                    i5.Glow.CFrame = CFrame.new(v4)
                    i5.Position = v4
                else
                    sparkleBurst(a1, i5.Land, u146, 24, 12)
                    Model.Parent = nil
                    i5.Glow.Parent = nil
                    i5.Done = true
                end
            elseif i5.Character then
                v2 = Kit.Window(v5, u68.Handoff, u68.Caught)
                v3 = Kit.RootOf(i5.Character)
                Land = if not v3 then i5.Land else v3.Position + Vector3.new(0, 1.5, 0)
                v3 = (i5.Land + Land) / 2 + Vector3.new(0, 7, 0)
                v4 = Kit.Bezier(i5.Land, v3, Land, v2 * v2)
                v1 = v2 * 3.141592653589793 * 4
                Full = Full * (1 - Kit.Window(v2, 0.6, 1) * 0.95)
                i5.Trail.Enabled = true
                if not (v2 >= 1) then
                    Model.Parent = a1.Container
                    if 0.0001 < (math.abs((Model:GetScale()) - Full)) then
                        Model:ScaleTo((math.max(Full, 0.01)))
                    end
                    Model:PivotTo((CFrame.new(v4)) * (CFrame.Angles(0, v1, 0)))
                    i5.Glow.CFrame = CFrame.new(v4)
                    i5.Position = v4
                else
                    if i5.Guard then
                        i5.Guard:Reveal()
                    end
                    sparkleBurst(a1, Land, u146, 40, 20)
                    glowFlare(a1, Land, u166, 8, 0.4)
                    Model.Parent = nil
                    i5.Glow.Parent = nil
                    i5.Done = true
                end
            else
                v2 = v5 - u68.Land
                v3 = math.abs((math.sin((math.min(v2 / 0.42, 1)) * 3.141592653589793))) * 1.3 * math.exp(-v2 * 2)
                v4 = i5.Land + Vector3.new(0, 1, 0) * v3
                if not i5.Landed then
                    i5.Landed = true
                    i5.Trail.Enabled = false
                    sound(a1, "PropsLand", i5.Land, 0.6, 1.25)
                    flatWave(a1, i5.Land - Vector3.new(0, 2.700000047683716, 0), if i5.Index ~= 1 then u141 else u131, 18, 0.6)
                    sparkleBurst(a1, i5.Land, u146, 30, 16)
                    kick(a1, 0.35)
                end
                if i5.Character or not (u68.Done - 0.2 < v5) then
                    Model.Parent = a1.Container
                    if 0.0001 < (math.abs((Model:GetScale()) - Full)) then
                        Model:ScaleTo((math.max(Full, 0.01)))
                    end
                    Model:PivotTo((CFrame.new(v4)) * (CFrame.Angles(0, 0, 0)))
                    i5.Glow.CFrame = CFrame.new(v4)
                    i5.Position = v4
                else
                    sparkleBurst(a1, i5.Land, u146, 24, 12)
                    Model.Parent = nil
                    i5.Glow.Parent = nil
                    i5.Done = true
                end
            end
        end
    end
    if u68.Handoff <= v5 and a1.OnDone then
        local OnDone = a1.OnDone
        a1.OnDone = nil
        task.spawn(OnDone)
    end
    if u68.Done <= v5 then
        finish(a1)
    end
end

local function step(a1, a2) -- Line: 3348
    -- upvalues: Workspace (val), finish (val), beats (val), stepPads (val), stepRift (val), stepEye (val)
    -- upvalues: stepPets (val), stepTethers (val), stepProps (val), stepLights (val), stepWisps (val), stepSteady (val)
    -- upvalues: Kit (val), u65 (val), setOrbSize (val), stepEgg (val), stepPayoff (val)
    if a1.Dead then
        return
    end
    if not a1.Shrine:IsDescendantOf(Workspace) then
        finish(a1)
        return
    end
    local v1 = (Workspace:GetServerTimeNow() - a1.StartAt) / a1.Scale
    if a1.PayoffAt then
        v1 = math.max(v1, 18)
    end
    local v2 = a2 / a1.Scale
    a1.T = v1
    a1.ShakePower = a1.ShakePower * math.exp(-a2 * 3.2)
    a1.FovKick = a1.FovKick * math.exp(-a2 * 4)
    beats(a1, v1)
    stepPads(a1, v1)
    stepRift(a1, v1)
    stepEye(a1, v1, a2)
    stepPets(a1, v1)
    stepTethers(a1, v1)
    stepProps(a1, v1, v2)
    stepLights(a1, v1)
    stepWisps(a1, v1, v2)
    stepSteady(a1, 1 + 0.8 * Kit.Window(v1, u65.Merge, u65.Implode))
    v2 = Kit.Ease(Kit.Window(v1, u65.Merge - 0.2, u65.Implode - 0.25), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local v3 = Kit.Ease(Kit.Window(v1, u65.Implode - 0.1, u65.Implode + 0.3), Enum.EasingStyle.Back, Enum.EasingDirection.In)
    setOrbSize(a1, a1.RiftSize * 0.16 * v2 * (1 - v3))
    stepEgg(a1, v1)
    if a1.PayoffAt then
        stepPayoff(a1)
    end
end

local function cameraKeys(a1) -- Line: 3392 -- upvalues: u65 (val)
    local Center = a1.Center
    local Row = a1.Row
    local Side = a1.Side
    local Across = a1.Across
    local RiftSize = a1.RiftSize

    local function orbit(a1, a2, a3) -- Line: 3395
        -- upvalues: Center (val), Side (val)
        return Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), a1)):VectorToWorldSpace(Side) * a2 + Vector3.new(0, 1, 0) * a3
    end

    local v1 = math.max(a1.Floor + 2.2 - Row.Y, -6)
    local v2 = math.max(a1.PadTop + 2.5 - Center.Y, -RiftSize * 0.45)
    local v3 = RiftSize * 1.35
    local v4 = math.min(5, (math.max(Center.Y - a1.PadTop - 1.5, 2)))
    local v5 = {}
    local v6 = {
        T = -1,
        Fov = 58,
        At = Row + Side * 48 + Vector3.new(0, 16, 0),
        Look = Row:Lerp(Center, 0.3),
    }
    local v7 = {
        T = 0,
        Fov = 58,
        At = Row + Side * 46 + Vector3.new(0, 15, 0),
        Look = Row:Lerp(Center, 0.3),
    }
    local v8 = {
        Fov = 58,
        T = u65.Crack,
        At = Row + Side * 42 + Vector3.new(0, 12, 0),
        Look = Row:Lerp(Center, 0.55),
    }
    local v9 = {
        Fov = 56,
        T = u65.Tear + 0.6,
        At = Center + ((CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -0.3)):VectorToWorldSpace(Side)) * (RiftSize * 1.9) + Vector3.new(0, 1, 0) * (v2 * 0.35),
        Look = Center,
    }
    local v10 = {
        Fov = 44,
        T = u65.EyeOpen + 0.3,
        At = Center + Side * v3 - Vector3.new(0, 1.2000000476837158, 0),
        Look = Center,
    }
    local v11 = {
        Fov = 42,
        T = u65.Gaze + 0.6,
        At = Center + Side * (v3 * 0.9) + Across * 0.8 - Vector3.new(0, 1, 0),
        Look = Center - Vector3.new(0, 0.4000000059604645, 0),
    }
    local v12 = {
        Fov = 58,
        T = u65.Link + 0.7,
        At = Row + Side * 32 + Across * 5 + Vector3.new(0, 9, 0),
        Look = Row:Lerp(Center, 0.62),
    }
    local v13 = {
        Fov = 56,
        T = u65.Build + 1,
        At = Row + Side * 25 - Across * 7 + Vector3.new(0, 6, 0),
        Look = Row:Lerp(Center, 0.7),
    }
    local v14 = {
        Fov = 62,
        T = u65.Lift + 0.4,
        At = Row + Side * 21 - Across * 11 + Vector3.new(0, 1, 0) * v1,
        Look = Center + Vector3.new(0, 1, 0),
    }
    local v15 = {Fov = 56, T = u65.Squint + 0.3}
    local v16 = RiftSize * 1.25
    local v17 = v2 * 0.5
    v15.At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -0.55)):VectorToWorldSpace(Side) * v16 + Vector3.new(0, 1, 0) * v17
    v15.Look = Center
    local v18 = {
        Fov = 60,
        T = u65.Dissolve + 0.9,
        At = Row + Side * 36 + Vector3.new(0, 9, 0),
        Look = Row:Lerp(Center, 0.55),
    }
    v16 = {
        Fov = 58,
        T = u65.Dissolve + 2.6,
        At = Row + Side * 31 + Across * 15 + Vector3.new(0, 7, 0),
        Look = Row:Lerp(Center, 0.6),
    }
    v17 = {Fov = 56, T = u65.Merge + 0.6}
    local v19 = RiftSize * 1.55
    v17.At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.45)):VectorToWorldSpace(Side) * v19 + Vector3.new(0, 2, 0)
    v17.Look = Center
    local v20 = {Fov = 54, T = u65.Close}
    local v21 = RiftSize * 1.45
    v20.At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.6)):VectorToWorldSpace(Side) * v21 + Vector3.new(0, 2, 0)
    v20.Look = Center
    v19 = {Fov = 55, T = u65.Implode}
    local v22 = RiftSize * 1.45
    v19.At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.5)):VectorToWorldSpace(Side) * v22 + Vector3.new(0, 1.5, 0)
    v19.Look = Center
    v21 = {
        Fov = 60,
        T = u65.Condense + 0.35,
        At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.38)):VectorToWorldSpace(Side) * 31.42857142857143 - Vector3.new(0, 1, 0) * (v4 * 0.4),
        Look = Center - Vector3.new(0, 3, 0),
    }
    v5[1] = v6
    v5[2] = v7
    v5[3] = v8
    v5[4] = v9
    v5[5] = v10
    v5[6] = v11
    v5[7] = v12
    v5[8] = v13
    v5[9] = v14
    v5[10] = v15
    v5[11] = v18
    v5[12] = v16
    v5[13] = v17
    v5[14] = v20
    v5[15] = v19
    v5[16] = v21
    v6 = {
        Fov = 52,
        T = u65.Egg + 1,
        At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.3)):VectorToWorldSpace(Side) * 15.428571428571429 - Vector3.new(0, 1, 0) * v4,
        Look = Center + Vector3.new(0, 0.6000000238418579, 0),
    }
    v7 = {
        Fov = 50,
        T = u65.Egg + 2.5,
        At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.12)):VectorToWorldSpace(Side) * 14.285714285714285 - Vector3.new(0, 1, 0) * v4,
        Look = Center + Vector3.new(0, 0.800000011920929, 0),
    }
    v8 = {
        Fov = 49,
        T = u65.Egg + 5.5,
        At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.02)):VectorToWorldSpace(Side) * 13.857142857142856 - Vector3.new(0, 1, 0) * v4,
        Look = Center + Vector3.new(0, 1, 0),
    }
    v5[17] = v6
    v5[18] = v7
    v5[19] = v8
    return v5
end

local function hermite(a1, a2) -- Line: 3466 -- upvalues: Kit (val) -- types: a1: table, a2: number
    local v1 = #a1
    if a2 <= a1[2].T then
        return a1[2].At, a1[2].Look, a1[2].Fov
    end
    if a1[v1].T <= a2 then
        return a1[v1].At, a1[v1].Look, a1[v1].Fov
    end
    local v2 = 2
    while v2 < v1 - 1 do
        if not (a1[v2 + 1].T < a2) then
            break
        end
        v2 = v2 + 1
    end
    local u32 = a1[v2 - 1]
    local u33 = a1[v2]
    local u35 = a1[v2 + 1]
    local u41 = a1[math.min(v2 + 2, v1)]
    local u44 = u35.T - u33.T
    v1 = Kit.Clamp01((a2 - u33.T) / u44)
    local v3 = v1 * v1
    local v4 = v1 * v1 * v1
    local u61 = 2 * v4 - 3 * v3 + 1
    local u65 = v4 - 2 * v3 + v1
    local u70 = -2 * v4 + 3 * v3
    local u71 = v4 - v3

    local function tangent(a1, a2) -- Line: 3489
        return (math.max(a2.T - a1.T, 0.001))
    end

    local function blend(a1) -- Line: 3492
        -- upvalues: u35 (val), u32 (val), u44 (val), u41 (val), u33 (val), u61 (val), u65 (val), u70 (val), u71 (val)
        local v1 = (u35[a1] - u32[a1]) / math.max(u35.T - u32.T, 0.001) * u44 * 0.85
        local v2 = (u41[a1] - u33[a1]) / math.max(u41.T - u33.T, 0.001) * u44 * 0.85
        return u33[a1] * u61 + v1 * u65 + u35[a1] * u70 + v2 * u71
    end

    return (blend("At")), (blend("Look")), Kit.Lerp(u33.Fov, u35.Fov, Kit.Smooth(v1))
end

local function payoffPath(a1, a2) -- Line: 3500 -- upvalues: Kit (val), u68 (val) -- types: a2: number
    local Center = a1.Center
    local PayoffFrom = a1.PayoffFrom
    local v1 = Kit.Smooth(Kit.Window(a2, 0, u68.Land))
    local v2 = PayoffFrom:Lerp(Center + a1.Side * (a1.RiftSize * 1.9) + Vector3.new(0, 5, 0), v1)
    local v3 = Center:Lerp(a1.Row + Vector3.new(0, 2, 0), v1 * 0.6)
    local v4 = Kit.Lerp(50, 60, v1)
    local Eggs = a1.Eggs or {}
    local MyEgg = a1.MyEgg or Eggs[1]
    if MyEgg then
        local v5
        local Land_2 = MyEgg.Land
        local v6 = 0
        if #Eggs >= 2 then
            v5 = Vector3.new(0, 0, 0)
            for i, j in Eggs do
                v5 = v5 + j.Land
            end
            Land_2 = v5 / #Eggs
            for k, n in Eggs do
                v6 = math.max(v6, (n.Land - Land_2).Magnitude)
            end
        end
        v5 = Kit.Smooth(Kit.Window(a2, u68.Split + 0.3, u68.Land + 0.3))
        local v7 = Land_2 + a1.Side * (v6 * 0.6 + 17) + Vector3.new(0, 1, 0) * (v6 * 0.2 + 7) + Kit.Flat(Center - Land_2) * 3
        local v8 = if not MyEgg.Position then Land_2 else MyEgg.Position:Lerp(Land_2, if not (v6 > 0) then 0.4 else 0.7)
        v2 = v2:Lerp(v7, v5)
        v3 = v3:Lerp(v8, v5)
        v4 = Kit.Lerp(v4, 56, v5)
    end
    return v2, v3, v4
end

function v1.Camera(a1, a2) -- Line: 3538
    -- upvalues: u229 (ref), Workspace (val), payoffPath (val), hermite (val), Kit (val)
    local v1 = u229
    if v1 and not v1.Dead and v1.Participant and v1.T then
        local v2, v3, v4, v5, v6
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera and CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
            v1.CameraTakebacks = v1.CameraTakebacks + 1
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
        end
        if not v1.PayoffAt then
            v4, v5, v6 = hermite(v1.CamKeys, v1.T)
        else
            if not v1.PayoffFrom then
                local At = if not v1.Cam then v1.Center + v1.Side * 20 else v1.Cam.At
                v1.PayoffFrom = At
            end
            v4, v5, v6 = payoffPath(v1, v1.P or 0)
        end
        v4 = v4
        local v7 = Vector3.new(
            math.clamp(v4.X, v1.Low.X + 1, v1.High.X - 1),
            math.clamp(v4.Y, v1.Floor + 1.6, v1.Ceiling - 1.6),
            (math.clamp(v4.Z, v1.Low.Z + 1, v1.High.Z - 1))
        )
        local Cam = v1.Cam
        if not Cam then
            v1.Cam = if not CurrentCamera then {At = v7, Look = v5, Fov = v6} else {
                At = CurrentCamera.CFrame.Position,
                Look = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * 24,
                Fov = CurrentCamera.FieldOfView,
            }
        end
        local v8 = 1 - math.exp(-a2 * 6)
        Cam.At = Cam.At:Lerp(v7, v8)
        Cam.Look = Cam.Look:Lerp(v2, v8)
        Cam.Fov = Kit.Lerp(Cam.Fov, v3, v8)
        v3 = Kit.ReducedMotion()
        local ShakePower = if not v3 then v1.ShakePower else 0
        v7 = os.clock()
        v8 = CFrame.lookAt(Cam.At, Cam.Look)
        v5 = (v8.RightVector * math.noise(v7 * 17, 1.3) + v8.UpVector * math.noise(v7 * 17, 7.9)) * ShakePower * 0.5
        v6 = (v8.RightVector * math.noise(v7 * 11, 4.1) + v8.UpVector * math.noise(v7 * 11, 2.6)) * ShakePower * 0.35
        return (CFrame.lookAt(Cam.At + v5, Cam.Look + v6)), (math.clamp(Cam.Fov + (if not v3 then v1.FovKick * 9 else 0), 30, 90))
    end
    return nil, nil
end

function v1.IsPlaying() -- Line: 3598 -- upvalues: u229 (ref)
    return u229 ~= nil
end

function v1.ActiveShrine() -- Line: 3602 -- upvalues: u229 (ref)
    if u229 then
        return u229.Shrine
    end
    return nil
end

function v1.IsResolving() -- Line: 3606 -- upvalues: u229 (ref)
    local v1 = false
    if u229 ~= nil then
        v1 = u229.PayoffAt ~= nil
    end
    return v1
end

function v1.FlightFocus() -- Line: 3610
    return nil
end

local function localNear(a1) -- Line: 3614 -- upvalues: Kit (val) -- types: a1: vector
    local v1 = Kit.RootOf(Kit.LocalPlayerCharacter())
    local v2 = false
    if v1 ~= nil then
        v2 = (v1.Position - a1).Magnitude <= 170
    end
    return v2
end

function v1.Begin(a1) -- Line: 3619
    -- upvalues: u229 (ref), startBed (val), finish (val), Kit (val), ShrineFusionFlags (val), u126 (val), Trove (val)
    -- upvalues: Workspace (val), geometry (val), buildPets (val), buildPads (val), buildTethers (val)
    -- upvalues: gatherProps (val), gatherLights (val), buildRoom (val), buildRift (val), buildOrb (val), buildEgg (val)
    -- upvalues: cameraKeys (val), RunService (val), step (val)
    if u229 and u229.Shrine == a1.Shrine and not u229.Dead then
        if a1.Participant and not u229.Participant then
            u229.Participant = true
            u229.Gui = a1.Gui
            startBed(u229)
        end
        return true
    end
    if u229 then
        finish(u229)
    end
    local Shrine = a1.Shrine
    local RitualCenter = Shrine:FindFirstChild("RitualCenter")
    if RitualCenter and RitualCenter:IsA("BasePart") then
        local v1, v2, v3
        if a1.Participant ~= true then
            local Position = RitualCenter.Position
            local v4 = Kit.RootOf(Kit.LocalPlayerCharacter())
            v3 = false
            if v4 ~= nil then
                v3 = (v4.Position - Position).Magnitude <= 170
            end
            if not v3 then
                return false
            end
        end
        local Id = a1.Kind.Id
        v3 = ShrineFusionFlags.ShrineRitualSeconds:Get()[Id] or ShrineFusionFlags.RitualSeconds:Get()
        local Recipe = a1.Recipe or (ShrineFusionFlags.Recipes:Get())[a1.Tier] or u126
        local u339 = {
            ShakePower = 0,
            FovKick = 0,
            RattleCount = 0,
            LandCount = 0,
            CameraTakebacks = 0,
        }
        u339.Trove = Trove.new()
        u339.Shrine = Shrine
        u339.Interior = Shrine.Parent
        u339.Kind = a1.Kind
        u339.Pads = a1.Pads
        u339.Seats = if type(a1.Seats) ~= "table" then nil else if not (#a1.Seats > 0) then nil else a1.Seats
        local Characters = a1.Characters or {}
        u339.Characters = Characters
        u339.Tier = a1.Tier
        u339.Recipe = Recipe
        local FusedCategory = a1.FusedCategory or Recipe.Fused or u126.Fused
        u339.Fused = FusedCategory
        u339.Participant = a1.Participant == true
        u339.Gui = a1.Gui
        u339.Center = RitualCenter.Position
        u339.Side = Kit.Flat(RitualCenter.CFrame.LookVector)
        u339.StartAt = a1.EndsAt - v3
        u339.EndsAt = a1.EndsAt
        u339.Scale = v3 / 18
        u339.Fired = {}
        u339.Sounds = {}
        u339.Loops = {}
        u339.Guards = {}
        u339.Wisps = {}
        u339.Steady = {}
        u339.RiftDiscs = {}
        u339.Across = u339.Side:Cross((Vector3.new(0, 1, 0)))
        local u402 = Vector3.new(0, 0, 0)
        local u403 = 0
        local u408 = (-1 / 0)

        local function addPad(a1) -- Line: 3677 -- upvalues: u402 (ref), u403 (ref), u408 (ref)
            if typeof(a1) == "Instance" and a1:IsA("BasePart") then
                local v1 = a1.Position + Vector3.new(0, 1, 0) * (a1.Size.Y / 2)
                u402 = u402 + v1
                u403 = u403 + 1
                math.max(u408, v1.Y)
            end
        end

        if not u339.Seats then
            local v5
            for i, j in u339.Pads do
                if typeof(j) == "Instance" and j:IsA("BasePart") then
                    v5 = j.Position + Vector3.new(0, 1, 0) * (j.Size.Y / 2)
                    u402 = u402 + v5
                    u403 = u403 + 1
                    u408 = math.max(u408, v5.Y)
                end
            end
        else
            local v6
            v2 = nil
            local v7 = nil
            v1 = a1
            for k, n in u339.Seats, v2, v7 do
                for m, i5 in u339.Kind.Sides do
                    v6 = n[i5]
                    if typeof(v6) == "Instance" and v6:IsA("BasePart") then
                        v3 = v6.Position + Vector3.new(0, 1, 0) * (v6.Size.Y / 2)
                        u402 = u402 + v3
                        u403 = u403 + 1
                        u408 = math.max(u408, v3.Y)
                    end
                end
            end
        end
        local v8 = if not (u403 > 0) then u339.Center - Vector3.new(0, 10, 0) else u402 / u403
        u339.Row = v8
        u339.RowSpan = 12
        v8 = if not (u403 > 0) then u339.Center.Y - 10 else u408
        u339.PadTop = v8
        local Parent = v1.Parent
        v8 = Instance.new("Folder")
        v8.Name = "VoidFusion"
        v8.Parent = Parent or Workspace:FindFirstChild("Transient") or Workspace
        u339.Container = v8
        u339.Trove:Add(u339.Container)
        geometry(u339)
        u339.FloorParams = RaycastParams.new()
        local v9 = if not u339.Interior then nil else u339.Interior:FindFirstChild("building")
        if v9 then
            u339.FloorParams.FilterType = Enum.RaycastFilterType.Include
            u339.FloorParams.FilterDescendantsInstances = {v9}
        end
        if not u339.Seats then
            for i6, i7 in u339.Kind.Sides do
                u339.Guards[i6] = (Kit.ToolGuard(u339.Characters[i7]))
            end
        else
            for i8, i9 in u339.Seats do
                u339.Guards[i8] = (Kit.ToolGuard(i9.Character))
            end
        end
        u339.T = ((Workspace:GetServerTimeNow()) - u339.StartAt) / u339.Scale
        u229 = u339
        local success, err = pcall(function() -- Line: 3719
            -- upvalues: startBed (upval), u339 (val), buildPets (upval), buildPads (upval), buildTethers (upval)
            -- upvalues: gatherProps (upval), gatherLights (upval), buildRoom (upval), buildRift (upval)
            -- upvalues: buildOrb (upval), buildEgg (upval), cameraKeys (upval)
            startBed(u339)
            buildPets(u339)
            buildPads(u339)
            buildTethers(u339)
            gatherProps(u339)
            gatherLights(u339)
            buildRoom(u339)
            buildRift(u339)
            buildOrb(u339)
            buildEgg(u339)
            u339.CamKeys = cameraKeys(u339)
        end)
        if not success then
            warn("[VoidRitual] build failed:", err)
            finish(u339)
            return false
        end
        v2 = Kit.LocalPlayerCharacter()
        v8 = if not v2 then nil else v2:FindFirstChildOfClass("Humanoid")
        if v8 then
            u339.Trove:Connect(v8.Died, function() -- Line: 3740 -- upvalues: u229 (upval), u339 (val), finish (upval)
                if u229 == u339 then
                    finish(u339)
                end
            end)
        end
        u339.Trove:Connect(RunService.RenderStepped, function(a1) -- Line: 3746 -- upvalues: step (upval), u339 (val), finish (upval)
            local success, err = pcall(step, u339, a1)
            if not success then
                warn("[VoidRitual] step failed:", err)
                finish(u339)
            end
        end)
        return true
    end
    warn("[VoidRitual] shrine needs a RitualCenter part:", Shrine:GetFullName())
    return false
end

function v1.Payoff(a1) -- Line: 3756 -- upvalues: u229 (ref), Kit (val), makeEggs (val) -- types: a1: function?
    local v1 = u229
    if v1 and not v1.Dead then
        if v1.PayoffAt then
            v1.OnDone = v1.OnDone or a1
            return true
        end
        v1.PayoffAt = os.clock()
        v1.OnDone = a1
        local v2 = Kit.LocalPlayerCharacter()
        makeEggs(v1)
        for i, j in v1.Eggs do
            if v2 and j.Character == v2 then
                v1.MyEgg = j
            end
        end
        return true
    end
    return false
end

function v1.Cancel() -- Line: 3777 -- upvalues: u229 (ref), finish (val)
    if u229 then
        finish(u229)
    end
end

return (table.freeze(v1))