-- Script path: ReplicatedStorage.Client.ShrineFusionSequences.EnchantedPond
-- Decompile time: 117.20 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local ShrineFusionFlags = require(ReplicatedStorage.Shared.Flags.ShrineFusionFlags)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Kit = require(script.Parent.Kit)
local ShrinePadPets = require(ReplicatedStorage.Client.ShrinePadPets)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u59 = table.freeze({
    Bed = 113629321829237,
    Appear = 115818434760382,
    SealCrack = 83193566956039,
    Roar = 122225901664901,
    SealShatter = 88421070361458,
    WaterReveal = 87535168837444,
    WhaleCall = 105930615352693,
    Splash = 83099379619955,
    Charge = 119987445263999,
    Collapse = 70767570204111,
    EggBurst = 131661095169691,
    EggLand = 140086252907114,
})
local u62 = table.freeze({LionRoar = "rbxassetid://76209207390777"})
local u65 = table.freeze({
    Sparkle = "rbxasset://textures/particles/sparkles_main.dds",
    Shockwave = "rbxassetid://109600784699514",
    Ripple = "rbxassetid://16511598488",
    Water = "rbxassetid://71203942292797",
    Flare = "rbxassetid://105427977618886",
    Shard = "rbxassetid://140284431017219",
    Petal = "rbxassetid://101360855375102",
    Sunburst = "rbxassetid://85665154415342",
    Energy = "rbxassetid://85003420967228",
    Vortex = "rbxassetid://87418254231660",
    Smoke = "rbxassetid://11917388916",
})
local u68 = table.freeze({
    Appear = 0,
    Crack = 1.4,
    Halt = 2.4,
    Roar = 3.25,
    Shatter = 4.2,
    Reveal = 4.5,
    WhaleCall = 5.6,
    Dive = 6.2,
    Splash = 7.6,
    Fuse = 8.2,
    Collapse = 12.6,
})
local u71 = table.freeze({
    Burst = 0.12,
    Apex = 1.05,
    Split = 1.55,
    Land = 2.4,
    Present = 2.8,
    Handoff = 3.6,
    Caught = 4.5,
    Done = 5.4,
})
local u76 = Color3.fromRGB(255, 204, 72)
local u81 = Color3.fromRGB(255, 150, 40)
local u86 = Color3.fromRGB(92, 226, 255)
local u91 = Color3.fromRGB(164, 110, 255)
local u96 = Color3.new(1, 1, 1)
local v1 = {}
local u98 = nil
local u102 = setmetatable({}, {__mode = "k"})
local u106 = setmetatable({}, {__mode = "k"})
local u108 = Random.new()

local function ritualSeconds(a1) -- Line: 102 -- upvalues: ShrineFusionFlags (val) -- types: a1: string
    return ShrineFusionFlags.ShrineRitualSeconds:Get()[a1] or ShrineFusionFlags.RitualSeconds:Get()
end

local function container(a1) -- Line: 106 -- upvalues: Workspace (val) -- types: a1: userdata?
    local Folder = Instance.new("Folder")
    Folder.Name = "EnchantedFusion"
    Folder.Parent = a1 or Workspace:FindFirstChild("Transient") or Workspace
    return Folder
end

local function objectValue(a1, a2) -- Line: 113 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    if v1 and v1:IsA("ObjectValue") then
        return v1.Value
    end
    return nil
end

local function partsOf(a1) -- Line: 118 -- types: a1: userdata?
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

local function sound(a1, a2, a3, a4, a5) -- Line: 133
    -- upvalues: Kit (val), u59 (val)
    local v1 = Kit.Sound(u59[a2], a3 or a1.Center, a4, a5)
    if v1 then
        a1.Sounds[v1] = true
    end
    return v1
end

local function fadeOut(a1, a2) -- Line: 147 -- upvalues: TweenService (val) -- types: a1: userdata?, a2: number
    if a1 and a1.Parent then
        local v1 = TweenService:Create(a1, TweenInfo.new(a2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Volume = 0})
        v1.Completed:Once(function() -- Line: 156 -- upvalues: a1 (val)
            a1:Stop()
        end)
        v1:Play()
        return
    end
end

local function startBed(a1) -- Line: 162 -- upvalues: Workspace (val), u59 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if a1.Participant and CurrentCamera then
        local Sound = Instance.new("Sound")
        Sound.Name = "EnchantedFusionBed"
        Sound.SoundId = ("rbxassetid://%*"):format(u59.Bed)
        Sound.Volume = 0.85
        Sound.TimePosition = math.max((Workspace:GetServerTimeNow()) - a1.StartAt, 0)
        Sound.Parent = CurrentCamera
        Sound.Ended:Once(function() -- Line: 173 -- upvalues: Sound (val)
            Sound:Destroy()
        end)
        Sound:Play()
        a1.Bed = Sound
        return
    end
end

local function kick(a1, a2) -- Line: 180 -- upvalues: Kit (val), Shake (val) -- types: a2: number
    a1.ShakePower = math.max(a1.ShakePower, a2)
    if not a1.Participant and not Kit.ReducedMotion() then
        Shake.Play({
            Seconds = a2 * 0.4 + 0.5,
            Magnitude = a2,
            Range = {Near = 30, Far = 140, Center = a1.Center},
        })
    end
end

local function emitterHost(a1, a2, a3) -- Line: 191 -- upvalues: Kit (val) -- types: a2: userdata, a3: vector?
    local v1 = Kit.Part({
        Name = "EmitterHost",
        Transparency = 1,
        Size = a3 or Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = a2,
    })
    v1.Parent = a1.Container
    return v1
end

local function burst(a1, a2, a3, a4, a5) -- Line: 202
    -- upvalues: Kit (val)
    local v1 = CFrame.new(a2)
    local u13 = Kit.Part({
        Name = "EmitterHost",
        Transparency = 1,
        Size = a5 or Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v1,
    })
    u13.Parent = a1.Container
    Kit.Emitter(u13, a3):Emit(a4)
    task.delay(4, function() -- Line: 212 -- upvalues: u13 (val)
        u13:Destroy()
    end)
end

local function flatWave(a1, a2, a3, a4, a5) -- Line: 217
    -- upvalues: burst (val), u65 (val)
    burst(a1, a2, {
        ZOffset = 2,
        Texture = u65.Shockwave,
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
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.6, 0.35),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    }, 1)
end

local function sparkleBurst(a1, a2, a3, a4, a5) -- Line: 238
    -- upvalues: burst (val), u65 (val), u96 (val)
    burst(a1, a2, {
        Drag = 3,
        Acceleration = Vector3.new(0, 4, 0),
        ZOffset = 1,
        Texture = u65.Sparkle,
        Color = ColorSequence.new(u96, a3),
        SpreadAngle = Vector2.new(180, 180),
        Speed = NumberRange.new(a5 * 0.4, a5),
        Lifetime = NumberRange.new(0.8, 1.6),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), (NumberSequenceKeypoint.new(1, 0))}),
    }, a4)
end

local function glowFlare(a1, a2, a3, a4) -- Line: 255
    -- upvalues: burst (val), u65 (val)
    burst(a1, a2, {
        ZOffset = 3,
        Texture = u65.Flare,
        Color = ColorSequence.new(a3),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.45),
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, a4 * 0.3),
            NumberSequenceKeypoint.new(0.25, a4),
            (NumberSequenceKeypoint.new(1, a4 * 1.2)),
        }),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))}),
    }, 1)
end

local function rigTemplate(a1) -- Line: 274 -- upvalues: ReplicatedStorage (val) -- types: a1: string?
    local FusionShrineRigs = ReplicatedStorage.Assets.Models:FindFirstChild("FusionShrineRigs")
    if FusionShrineRigs and a1 then
        return (FusionShrineRigs:FindFirstChild(a1))
    end
    return nil
end

local function boneNamed(a1, a2) -- Line: 279 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2, true)
    if v1 and v1:IsA("Bone") then
        return v1
    end
    return nil
end

local function mouthRig(a1) -- Line: 284 -- types: a1: userdata
    local Head1 = a1:FindFirstChild("Head1", true)
    local v1 = if not Head1 then nil else if not Head1:IsA("Bone") then nil else Head1
    local MouthBottom1 = a1:FindFirstChild("MouthBottom1", true)
    local v2 = if not MouthBottom1 then nil else if not MouthBottom1:IsA("Bone") then nil else MouthBottom1
    local Nose1 = a1:FindFirstChild("Nose1", true)
    local v3 = if not Nose1 then nil else if not Nose1:IsA("Bone") then nil else Nose1
    if v1 and v2 and v3 then
        local Scale = a1:GetScale()
        local LookVector = a1:GetPivot().LookVector
        return {
            Head = v1,
            Jaw = v2,
            Nose = v3,
            Tip = v2.TransformedWorldCFrame:PointToObjectSpace(v2.WorldPosition + LookVector * (math.max((v3.WorldPosition - v2.WorldPosition):Dot(LookVector), 0)) * 0.95) / Scale,
            Forward = v1.TransformedWorldCFrame:VectorToObjectSpace(LookVector),
        }
    end
    return nil
end

local function loadRoar(a1) -- Line: 304 -- upvalues: u62 (val) -- types: a1: userdata
    local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = if not AnimationController then nil else AnimationController:FindFirstChildOfClass("Animator")
    if not Animator then
        return nil
    end
    local u16 = Instance.new("Animation")
    u16.AnimationId = u62.LionRoar
    local success, err = pcall(function() -- Line: 312 -- upvalues: Animator (val), u16 (val)
        return Animator:LoadAnimation(u16)
    end)
    if success and err then
        err.Looped = false
        err.Priority = Enum.AnimationPriority.Action4
        return err
    end
    return nil
end

local function homeFrame(a1, a2) -- Line: 323 -- upvalues: Kit (val) -- types: a1: vector, a2: vector
    return CFrame.lookAt(a1, a1 + Kit.Flat(a2))
end

local function footOf(a1) -- Line: 327 -- types: a1: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return a1:GetPivot().Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y / 2)
end

local function groundDrop(a1, a2) -- Line: 332 -- upvalues: Workspace (val), Players (val) -- types: a2: userdata
    local v1 = {a1.Container, a1.Shrine}
    local Transient = Workspace:FindFirstChild("Transient")
    if Transient then
        table.insert(v1, Transient)
    end
    for i, j in Players:GetPlayers() do
        if j.Character then
            table.insert(v1, j.Character)
        end
    end
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.FilterDescendantsInstances = v1
    v2.RespectCanCollide = true
    local v3 = Workspace:Raycast(a2.Position + a2.LookVector * 7 + Vector3.new(0, 4, 0), Vector3.new(-0, -30, -0), v2)
    if not v3 then
        return 0
    end
    return (math.clamp(v3.Position.Y - a2.Position.Y, -12, 2))
end

local function buildSeatPets(a1) -- Line: 355
    -- upvalues: Kit (val), ReplicatedStorage (val), Assets (val), ShrinePadPets (val), groundDrop (val), loadRoar (val)
    -- upvalues: mouthRig (val)
    local Animations, BoundingBox, BoundingBox_2, FusionShrineRigs, PetModel, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local Recipe = a1.Recipe or {}
    local v10 = nil
    local v11 = nil
    local v12 = a1
    for i, j in a1.Seats, v10, v11 do
        v8 = nil
        v9 = nil
        for k, n in v12.Kind.Sides, v8, v9 do
            v1 = j[n]
            v2 = Recipe[n]
            if v1 and v2 then
                PetModel = Kit.PetModel
                v6 = v2
                if not v3 then
                    v7 = nil
                else
                    FusionShrineRigs = ReplicatedStorage.Assets.Models:FindFirstChild("FusionShrineRigs")
                    v7 = if not FusionShrineRigs then nil else if not v2 then nil else FusionShrineRigs:FindFirstChild(v2)
                end
                v5 = PetModel(v6, if not (n == "Lion") then 21 else 12, v7)
                if v5 then
                    v6 = Assets.Directory[v2] or {}
                    Animations = v6.Animations or {}
                    v5.Parent = v12.Container
                    v6 = {
                        Grow = 0,
                        Kind = n,
                        Model = v5,
                        Home = ShrinePadPets.Home(v12.Kind, n, v1, v12.Center),
                        Placed = ShrinePadPets.Size(v12.Kind, n) / v4,
                    }
                    BoundingBox, BoundingBox_2 = v5:GetBoundingBox()
                    v6.Foot = v5:GetPivot().Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y / 2)
                    v6.Real = v3 == (i == 2)
                    v6.Index = i
                    if not v3 then
                        v6.Track = Kit.PlayAnimation(v5, Animations.Walk or Animations.Idle, 1)
                    else
                        v6.Height = 10.2
                        v6.Drop = groundDrop(v12, v6.Home)
                        v6.Track = Kit.PlayAnimation(v5, Animations.Idle, 1)
                        v6.Walk = Kit.PlayAnimation(v5, Animations.Walk, 1.15)
                        v6.Roar = loadRoar(v5)
                        v6.Mouth = mouthRig(v5)
                    end
                    table.insert(v12.Pets, v6)
                end
            end
        end
    end
end

local function buildPets(a1) -- Line: 398
    -- upvalues: buildSeatPets (val), Kit (val), ReplicatedStorage (val), Assets (val), loadRoar (val), mouthRig (val)
    -- upvalues: u86 (val), u91 (val)
    local Animations, Animations_2, Attachment, FusionShrineRigs, Lion, Lion_2, PetModel, Trail, v1, v2, v3, v4, v5, v6, v7, v8
    local Center = a1.Center
    a1.Pets = {}
    local Recipe = a1.Recipe or {}
    if a1.Seats then
        buildSeatPets(a1)
    end
    local Sides = if not a1.Seats then a1.Kind.Sides else {}
    local v9 = nil
    local v10 = nil
    local v11 = a1
    for i, j in Sides, v9, v10 do
        v7 = v11.Pads[j]
        v8 = v7.Position + Vector3.new(0, 1, 0) * (v7.Size.Y / 2)
        v7 = Kit.Flat(Center - v8)
        PetModel = Kit.PetModel
        Lion = Recipe.Lion
        Lion_2 = Recipe.Lion
        FusionShrineRigs = ReplicatedStorage.Assets.Models:FindFirstChild("FusionShrineRigs")
        v2 = PetModel(Lion, 12, if not FusionShrineRigs then nil else if not Lion_2 then nil else FusionShrineRigs:FindFirstChild(Lion_2))
        v3 = Assets.Directory[Recipe.Lion] or {}
        Animations = v3.Animations or {}
        if v2 then
            v3 = v8 + v11.Side * 12 - v7 * 2
            v2.Parent = v11.Container
            table.insert(v11.Pets, {
                Kind = "Lion",
                Height = 10.2,
                Grow = 0,
                Model = v2,
                Home = CFrame.lookAt(v3, v3 + Kit.Flat(Center - v3)),
                Real = j == "Lion",
                Index = i,
                Track = Kit.PlayAnimation(v2, Animations.Idle, 1),
                Walk = Kit.PlayAnimation(v2, Animations.Walk, 1.15),
                Roar = loadRoar(v2),
                Mouth = mouthRig(v2),
            })
        end
        v4 = Kit.PetModel(Recipe.Whale, 21)
        if v4 then
            for k, n in v4:GetDescendants() do
                if n:IsA("Beam") then
                    n.Enabled = false
                end
            end
            v2 = v8 - v11.Side * 9 + v7 * 3 + Vector3.new(0, 17, 0)
            v4.Parent = v11.Container
            v5 = Assets.Directory[Recipe.Whale] or {}
            Animations_2 = v5.Animations or {}
            table.insert(v11.Pets, {
                Kind = "Whale",
                Grow = 0,
                Model = v4,
                Home = CFrame.lookAt(v2, v2 + Kit.Flat((v11.Side:Cross((Vector3.new(0, 1, 0)))) * (if i ~= 1 then -1 else 1))),
                Real = j == "Whale",
                Index = i,
                Track = Kit.PlayAnimation(v4, Animations_2.Walk or Animations_2.Idle, 1),
            })
        end
    end
    v9 = nil
    v10 = nil
    for m, i5 in v11.Pets, v9, v10 do
        if i5.Walk then
            i5.Walk:Stop(0)
        end
        i5.Model:ScaleTo((i5.Model:GetScale()) * 0.02)
        i5.Scale = i5.Model:GetScale() / 0.02
        i5.Model:PivotTo(i5.Home)
        if i5.Kind == "Whale" then
            v6 = Kit.Part({
                Name = "WhaleWake",
                Transparency = 1,
                Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
            })
            v1 = Instance.new("Attachment")
            v1.Position = Vector3.new(-1.399999976158142, 0, 0)
            v1.Parent = v6
            Attachment = Instance.new("Attachment")
            Attachment.Position = Vector3.new(1.399999976158142, 0, 0)
            Attachment.Parent = v6
            Trail = Instance.new("Trail")
            Trail.Attachment0 = v1
            Trail.Attachment1 = Attachment
            Trail.Color = ColorSequence.new(u86, u91)
            Trail.Transparency = NumberSequence.new(0.45, 1)
            Trail.WidthScale = NumberSequence.new(1, 0.2)
            Trail.Lifetime = 0.45
            Trail.MinLength = 0.2
            Trail.LightEmission = 0.8
            Trail.LightInfluence = 0
            Trail.FaceCamera = false
            Trail.Enabled = false
            Trail.Parent = v6
            v6.Parent = v11.Container
            i5.Wake = v6
            i5.Trail = Trail
        end
    end
end

local function mouthOf(a1) -- Line: 487
    local Pivot = a1.Model:GetPivot()
    return Pivot.Position + Pivot.LookVector * 5.04 + Vector3.new(0, 1, 0) * ((a1.Height or 6) * 0.42)
end

local function liveMouth(a1) -- Line: 492 -- upvalues: Kit (val)
    local v1
    local Mouth = a1.Mouth
    local LookVector = a1.Model:GetPivot().LookVector
    if Mouth and Mouth.Head.Parent then
        local v2 = (Mouth.Nose.TransformedWorldCFrame.Position + (Mouth.Jaw.TransformedWorldCFrame:PointToWorldSpace(Mouth.Tip * (a1.Model:GetScale())))) / 2
        v1 = (Mouth.Head.TransformedWorldCFrame:VectorToWorldSpace(Mouth.Forward)) + Kit.Flat(LookVector) * 0.6
        if v1.Magnitude < 0.001 then
            v1 = LookVector
        end
        return CFrame.lookAt(v2, v2 + v1.Unit)
    end
    local Pivot = a1.Model:GetPivot()
    v1 = Pivot.Position + Pivot.LookVector * 5.04 + Vector3.new(0, 1, 0) * ((a1.Height or 6) * 0.42)
    return CFrame.lookAt(v1, v1 + LookVector)
end

local function overWater(a1, a2) -- Line: 510 -- upvalues: Kit (val) -- types: a1: userdata, a2: table
    local Water = a1:FindFirstChild("Water")
    local Value = if not Water then nil else if not Water:IsA("ObjectValue") then nil else Water.Value
    if Value and Value:IsA("BasePart") then
        local v1 = math.max(Value.Size.X, Value.Size.Z) / 2 + 12
        local v2 = {}
        for i, j in a2 do
            if Kit.Flat(j.Position - Value.Position).Magnitude <= v1 then
                table.insert(v2, j)
            end
        end
        return v2
    end
    return a2
end

local function sealPartsOf(a1) -- Line: 525 -- upvalues: overWater (val), partsOf (val) -- types: a1: userdata
    local SealCore = a1:FindFirstChild("SealCore")
    local v1 = overWater(a1, (partsOf(if not SealCore then nil else if not SealCore:IsA("ObjectValue") then nil else SealCore.Value)))
    local v2 = {}
    local Seal = a1:FindFirstChild("Seal")
    for i, j in overWater(a1, (partsOf(if not Seal then nil else if not Seal:IsA("ObjectValue") then nil else Seal.Value))) do
        if not table.find(v1, j) then
            table.insert(v2, j)
        end
    end
    return v2, v1
end

local function setCleared(a1, a2) -- Line: 536
    -- upvalues: u102 (val), sealPartsOf (val), u106 (val), Kit (val)
    local v1, v2
    if not a2 and not u102[a1] then
        return
    end
    u102[a1] = if not a2 then nil else true
    local v3, v4 = sealPartsOf(a1)
    local v5 = {v3, v4}
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        for k, n in j do
            if not v8 then
                Kit.Show(n)
                v1 = u106[n]
                if v1 then
                    u106[n] = nil
                    n.CanCollide = v1[1]
                    n.CanQuery = v1[2]
                    n.CanTouch = v1[3]
                end
            elseif not u106[n] then
                v1 = u106
                v2 = {n.CanCollide, n.CanQuery, n.CanTouch}
                v1[n] = v2
                Kit.Hide(n)
                n.CanCollide = false
                n.CanQuery = false
                n.CanTouch = false
            end
        end
    end
end

local function buildSeal(a1) -- Line: 566 -- upvalues: u102 (val), sealPartsOf (val), u76 (val)
    local Highlight, Value_2, v1
    local Shrine = a1.Shrine
    if u102[Shrine] then
        return
    end
    local v2, v3 = sealPartsOf(Shrine)
    a1.SealParts = v2
    a1.CoreParts = v3
    local Water = Shrine:FindFirstChild("Water")
    local Value = if not Water then nil else if not Water:IsA("ObjectValue") then nil else Water.Value
    if Value and Value:IsA("BasePart") then
        a1.Water = Value
        a1.WaterSaved = {
            Color = Value.Color,
            Transparency = Value.Transparency,
            Material = Value.Material,
            Reflectance = Value.Reflectance,
        }
    end
    v2 = {}
    v3 = {"Seal", "SealCore"}
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v1 = Shrine:FindFirstChild(j)
        Value_2 = if not v1 then nil else if not v1:IsA("ObjectValue") then nil else v1.Value
        if Value_2 then
            Highlight = Instance.new("Highlight")
            Highlight.Adornee = Value_2
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
            Highlight.FillColor = u76
            Highlight.OutlineColor = Color3.fromRGB(255, 240, 190)
            Highlight.FillTransparency = 1
            Highlight.OutlineTransparency = 1
            Highlight.Parent = a1.Container
            table.insert(v2, Highlight)
        end
    end
    a1.Highlights = v2
end

local function restoreWater(a1) -- Line: 600
    local Water = a1.Water
    local WaterSaved = a1.WaterSaved
    if Water and WaterSaved then
        Water.Color = WaterSaved.Color
        Water.Transparency = WaterSaved.Transparency
        Water.Material = WaterSaved.Material
        Water.Reflectance = WaterSaved.Reflectance
    end
end

local function restoreSeal(a1) -- Line: 610 -- upvalues: u102 (val), Kit (val)
    if u102[a1.Shrine] then
        return
    end
    for i, j in a1.SealParts do
        Kit.Show(j)
    end
    for k, n in a1.CoreParts do
        Kit.Show(n)
    end
end

local function shatter(a1) -- Line: 622
    -- upvalues: Kit (val), u108 (val), u65 (val), flatWave (val), u76 (val), u96 (val), glowFlare (val)
    -- upvalues: sparkleBurst (val), Flash (val), kick (val)
    local v1, v2, v3, v4, v5, v6
    local Center = a1.Center
    a1.Fragments = {}
    local v7 = {a1.SealParts, a1.CoreParts}
    local v8 = nil
    local v9 = nil
    local v10 = a1
    for i, j in v7, v8, v9 do
        v5 = nil
        v6 = nil
        for k, n in j, v5, v6 do
            v1 = n:Clone()
            for m, i5 in v1:GetChildren() do
                if not i5:IsA("SurfaceAppearance") and not i5:IsA("Decal") and not i5:IsA("Texture") then
                    i5:Destroy()
                end
            end
            v1.Anchored = true
            v1.CanCollide = false
            v1.CanQuery = false
            v1.CanTouch = false
            v1.Locked = true
            v1.Parent = v10.Container
            v2 = Kit.Flat(n.Position - Center + Vector3.new(u108:NextNumber(-1, 1), 0, (u108:NextNumber(-1, 1))))
            table.insert(v10.Fragments, {
                Part = v1,
                Origin = n.CFrame,
                Transparency = n.Transparency,
                Out = v2,
                Axis = v2:Cross((Vector3.new(0, 1, 0))).Unit,
                Spin = (u108:NextNumber(0.35, 0.75)) * (if not ((u108:NextNumber()) < 0.5) then 1 else -1),
                Reach = if j ~= v10.CoreParts then u108:NextNumber(34, 46) else 0,
                Lift = if j ~= v10.CoreParts then u108:NextNumber(5, 11) else 9,
                Core = j == v10.CoreParts,
            })
            Kit.Hide(n)
        end
    end
    for i6, i7 in v10.Highlights do
        i7.FillTransparency = 1
        i7.OutlineTransparency = 1
    end
    v10.Debris = {}
    v7 = {
        Color3.fromRGB(122, 78, 44),
        Color3.fromRGB(96, 64, 40),
        Color3.fromRGB(150, 104, 60),
        (Color3.fromRGB(84, 120, 44)),
    }
    for i8 = 1, 26 do
        v3 = u108:NextNumber(0, 6.283185307179586)
        v4 = u108:NextNumber(2, 30)
        v5 = Center + Vector3.new(math.cos(v3) * v4, 1, (math.sin(v3)) * v4)
        v4 = Kit.Part({
            Name = "SealChunk",
            Size = Vector3.new(u108:NextNumber(0.8, 2.2), u108:NextNumber(0.6, 1.4), (u108:NextNumber(2, 5))),
            Material = Enum.Material.Wood,
            Color = v7[u108:NextInteger(1, #v7)],
            CFrame = (CFrame.new(v5)) * CFrame.Angles(u108:NextNumber(0, 6), u108:NextNumber(0, 6), 0),
        })
        v4.Parent = v10.Container
        table.insert(v10.Debris, {
            Age = 0,
            Part = v4,
            Velocity = (Kit.Flat(v5 - Center)) * u108:NextNumber(14, 34) + Vector3.new(0, 1, 0) * u108:NextNumber(26, 48),
            Spin = Vector3.new(u108:NextNumber(-9, 9), u108:NextNumber(-9, 9), (u108:NextNumber(-9, 9))),
            Life = u108:NextNumber(1.4, 2.2),
        })
    end
    v8 = CFrame.new(Center + Vector3.new(0, 1.5, 0))
    local u200 = Kit.Part({
        Name = "EmitterHost",
        Transparency = 1,
        Size = Vector3.new(50, 0.4000000059604645, 50),
        CFrame = v8,
    })
    u200.Parent = v10.Container
    ;(Kit.Emitter(u200, {
        LightEmission = 0.3,
        Acceleration = Vector3.new(0, -60, 0),
        Texture = u65.Shard,
        Color = ColorSequence.new(Color3.fromRGB(150, 100, 56), Color3.fromRGB(255, 214, 120)),
        Shape = Enum.ParticleEmitterShape.Box,
        EmissionDirection = Enum.NormalId.Top,
        SpreadAngle = Vector2.new(40, 40),
        Speed = NumberRange.new(24, 48),
        Lifetime = NumberRange.new(0.9, 1.6),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-360, 360),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.4), (NumberSequenceKeypoint.new(1, 0.4))}),
    })):Emit(70)
    ;(Kit.Emitter(u200, {
        Drag = 1.5,
        Acceleration = Vector3.new(0, -6, 0),
        Texture = u65.Petal,
        Color = ColorSequence.new(Color3.fromRGB(120, 210, 90), Color3.fromRGB(255, 220, 110)),
        Shape = Enum.ParticleEmitterShape.Box,
        EmissionDirection = Enum.NormalId.Top,
        SpreadAngle = Vector2.new(70, 70),
        Speed = NumberRange.new(12, 30),
        Lifetime = NumberRange.new(2, 3.4),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-120, 120),
        Size = NumberSequence.new(0.9),
    })):Emit(60)
    task.delay(4, function() -- Line: 730 -- upvalues: u200 (val)
        u200:Destroy()
    end)
    flatWave(v10, Center + Vector3.new(0, 0.6000000238418579, 0), u76, 120, 0.8)
    flatWave(v10, Center + Vector3.new(0, 0.800000011920929, 0), u96, 70, 0.5)
    glowFlare(v10, Center + Vector3.new(0, 4, 0), Color3.fromRGB(255, 236, 170), 46)
    sparkleBurst(v10, Center + Vector3.new(0, 3, 0), u76, 90, 60)
    if v10.Participant then
        pcall(Flash.Play, {Attack = 0.04, Decay = 0.45, Opacity = 0.55, Tint = Color3.fromRGB(255, 236, 190)})
    end
    kick(v10, 1.6)
end

local function buildFusionField(a1) -- Line: 746
    -- upvalues: Kit (val), u65 (val), u86 (val), u96 (val), u76 (val), u108 (val), liveMouth (val)
    local Attachment, Attachment_2, Beam, Energy, Orbs, Trail, v1, v2, v3, v4, v5, v6, v7
    local Center = a1.Center
    local v8 = CFrame.new(Center + Vector3.new(0, 0.25, 0))
    local v9 = Kit.Part({
        Name = "EmitterHost",
        Transparency = 1,
        Size = Vector3.new(80, 0.20000000298023224, 80),
        CFrame = v8,
    })
    v9.Parent = a1.Container
    a1.Ripples = Kit.Emitter(v9, {
        Texture = u65.Ripple,
        Color = ColorSequence.new(u86, u96),
        Shape = Enum.ParticleEmitterShape.Box,
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(0.01),
        Lifetime = NumberRange.new(1.2, 2),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), (NumberSequenceKeypoint.new(1, 7))}),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), (NumberSequenceKeypoint.new(1, 1))}),
    })
    local Emitter_2 = Kit.Emitter
    local v10 = {
        Acceleration = Vector3.new(0, 5, 0),
        Texture = u65.Sparkle,
        Color = ColorSequence.new(u86, u76),
        Shape = Enum.ParticleEmitterShape.Box,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(2, 6),
        Lifetime = NumberRange.new(2, 3.5),
    }
    local new_3 = NumberSequence.new
    local v11 = {NumberSequenceKeypoint.new(0, 0.5), (NumberSequenceKeypoint.new(1, 0))}
    v10.Size = new_3(v11)
    a1.Motes = Emitter_2(v9, v10)
    v9 = Kit.Part({
        Name = "PondLight",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = CFrame.new(Center + Vector3.new(0, 3, 0)),
    })
    v9.Parent = a1.Container
    local PointLight = Instance.new("PointLight")
    PointLight.Range = 60
    PointLight.Brightness = 0
    PointLight.Color = u86
    PointLight.Shadows = false
    PointLight.Parent = v9
    a1.Light = PointLight
    v8 = Kit.Part({
        Name = "FusionCore",
        Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612),
        Transparency = 1,
        Shape = Enum.PartType.Ball,
        Material = Enum.Material.Neon,
        Color = u76,
        CFrame = CFrame.new(Center + Vector3.new(0, 3, 0)),
    })
    v8.Parent = a1.Container
    a1.Core = v8
    v9 = Instance.new("Attachment")
    v9.Position = Vector3.new(0, -2.5, 0)
    v9.Parent = v8
    a1.CoreAttachment = v9
    a1.Orbs = {}
    for i = 1, 44 do
        v6 = Kit.Part({
            Name = "EssenceMote",
            Transparency = 1,
            Shape = Enum.PartType.Ball,
            Material = Enum.Material.Neon,
            Color = if not (i % 2 == 0) then u86 else u76,
            Size = Vector3.new(1, 1, 1) * u108:NextNumber(0.35, 0.8),
            CFrame = CFrame.new(Center),
        })
        v6.Parent = a1.Container
        Orbs = a1.Orbs
        v2 = {
            Part = v6,
            Phase = u108:NextNumber(0, 6.283185307179586),
            Radius = u108:NextNumber(5, 27),
            Height = u108:NextNumber(-6, 4),
        }
        v3 = if not v11 then -1 else 1
        v2.Speed = (u108:NextNumber(0.8, 1.4)) * v3
        table.insert(Orbs, v2)
    end
    a1.Rings = {}
    local v12 = {9, 16, 24}
    v10 = nil
    local v13 = nil
    for j, k in v12, v10, v13 do
        v7 = if j ~= 2 then u76 else u86
        v1 = ColorSequence.new({
            ColorSequenceKeypoint.new(0, v7),
            ColorSequenceKeypoint.new(0.5, v7:Lerp(u96, 0.55)),
            (ColorSequenceKeypoint.new(1, v7)),
        })
        v2 = Kit.Ring(a1.Container, v7, 1.1, 20)
        v2:Style({
            TextureLength = 9,
            Texture = u65.Energy,
            TextureMode = Enum.TextureMode.Wrap,
            TextureSpeed = if j % 2 ~= 0 then 1.1 + j * 0.2 else -1.4,
            Color = v1,
        })
        v2:Set(CFrame.new(Center + Vector3.new(0, 0.30000001192092896, 0)), k, 1)
        v1 = Kit.Ring(a1.Container, v7, 2.4, 20)
        v1:Style({Color = ColorSequence.new(v7)})
        v1:Set(CFrame.new(Center + Vector3.new(0, 0.25, 0)), k, 1)
        table.insert(a1.Rings, {Ring = v2, Halo = v1, Radius = k, Phase = j * 1.3})
    end
    v10, v13 = CFrame.new(Center + Vector3.new(0, 0.3499999940395355, 0))
    v12 = Kit.Part({
        Name = "EmitterHost",
        Transparency = 1,
        Size = v13 or Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = v10,
    })
    v12.Parent = a1.Container
    a1.RingPulse = Kit.Emitter(v12, {
        ZOffset = 1,
        Texture = u65.Shockwave,
        Color = ColorSequence.new(u76:Lerp(u96, 0.3), u86),
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(0.01),
        Lifetime = NumberRange.new(2.4),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 58))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.15, 0.45),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    })
    a1.RingImplode = Kit.Emitter(v12, {
        ZOffset = 1,
        Texture = u65.Shockwave,
        Color = ColorSequence.new(u96, u76),
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(0.01),
        Lifetime = NumberRange.new(0.9),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 50), (NumberSequenceKeypoint.new(1, 2))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.35),
            (NumberSequenceKeypoint.new(1, 0.9)),
        }),
    })
    a1.CoreVortex = Kit.Emitter(v8, {
        LockedToPart = true,
        ZOffset = 1,
        Texture = u65.Vortex,
        Color = ColorSequence.new(u76, u86),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.9, 1.2),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(160, 260),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), (NumberSequenceKeypoint.new(1, 5))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.35),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    })
    a1.CoreGlow = Kit.Emitter(v8, {
        LockedToPart = true,
        ZOffset = 2,
        Texture = u65.Flare,
        Color = ColorSequence.new(Color3.fromRGB(255, 236, 170), u86),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(0.5),
        Size = NumberSequence.new(5),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), (NumberSequenceKeypoint.new(1, 1))}),
    })
    a1.CoreSparks = Kit.Emitter(v8, {
        Texture = u65.Sparkle,
        Color = ColorSequence.new(u96, u76),
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward,
        Speed = NumberRange.new(8, 14),
        Lifetime = NumberRange.new(0.4, 0.6),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), (NumberSequenceKeypoint.new(1, 0))}),
    })
    a1.Streams = {}
    v13 = nil
    v11 = nil
    for n, m in a1.Pets, v13, v11 do
        if m.Kind == "Lion" and m.Model.PrimaryPart then
            v12 = Instance.new("Attachment")
            v12.Parent = m.Model.PrimaryPart
            v12.WorldPosition = liveMouth(m).Position
            v8 = {}
            for i5 = 1, 2 do
                Beam = Instance.new("Beam")
                Beam.Attachment0 = v12
                Beam.Attachment1 = v9
                Energy = if i5 ~= 1 then u65.Water else u65.Energy
                Beam.Texture = Energy
                Beam.TextureMode = Enum.TextureMode.Wrap
                Beam.TextureLength = if i5 ~= 1 then 11 else 7
                Beam.TextureSpeed = if i5 ~= 1 then 1.3 else 2.4
                Beam.Color = ColorSequence.new(u76, if i5 ~= 1 then u96 else u86)
                Beam.LightEmission = 1
                Beam.LightInfluence = 0
                Beam.FaceCamera = true
                Beam.Segments = 24
                Beam.Transparency = NumberSequence.new(1)
                Beam.Parent = m.Model.PrimaryPart
                v8[i5] = Beam
            end
            v1 = {}
            for i6 = 1, 10 do
                v3 = if i6 % 2 ~= 0 then u86 else u76
                v4 = Kit.Part({
                    Name = "EssenceComet",
                    Size = Vector3.new(0.44999998807907104, 0.44999998807907104, 0.44999998807907104),
                    Transparency = 1,
                    Shape = Enum.PartType.Ball,
                    Material = Enum.Material.Neon,
                    Color = v3,
                    CFrame = CFrame.new(Center),
                })
                Attachment = Instance.new("Attachment")
                Attachment.Position = Vector3.new(0, 0.30000001192092896, 0)
                Attachment.Parent = v4
                Attachment_2 = Instance.new("Attachment")
                Attachment_2.Position = Vector3.new(0, -0.30000001192092896, 0)
                Attachment_2.Parent = v4
                Trail = Instance.new("Trail")
                Trail.Attachment0 = Attachment
                Trail.Attachment1 = Attachment_2
                Trail.Color = ColorSequence.new(v3, u96)
                Trail.Transparency = NumberSequence.new(0.15, 1)
                Trail.WidthScale = NumberSequence.new(1, 0)
                Trail.Lifetime = 0.3
                Trail.LightEmission = 1
                Trail.LightInfluence = 0
                Trail.FaceCamera = true
                Trail.Enabled = false
                Trail.Parent = v4
                v4.Parent = a1.Container
                v5 = {
                    Part = v4,
                    Trail = Trail,
                    Offset = (i6 - 1) / 10,
                    Side = u108:NextNumber(-1, 1),
                    Lift = u108:NextNumber(2, 7),
                }
                v1[i6] = v5
            end
            table.insert(a1.Streams, {Ribbons = v8, Comets = v1, Mouth = v12, Pet = m})
        end
    end
end

local function roarWaves(a1) -- Line: 1007
    -- upvalues: liveMouth (val), Kit (val), u65 (val), u76 (val), u81 (val), glowFlare (val)
    local v1
    for i, j in a1.Pets do
        if j.Kind == "Lion" then
            v1 = liveMouth(j)
            local u18 = Kit.Part({
                Name = "EmitterHost",
                Transparency = 1,
                Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
                CFrame = v1,
            })
            u18.Parent = a1.Container
            j.RoarHost = u18
            local u69 = Kit.Emitter(u18, {
                Rate = 9,
                Enabled = true,
                ZOffset = 2,
                Texture = u65.Shockwave,
                Color = ColorSequence.new(Color3.fromRGB(255, 232, 150), u76),
                Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
                EmissionDirection = Enum.NormalId.Front,
                Speed = NumberRange.new(52),
                Lifetime = NumberRange.new(0.95),
                Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 17))}),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.05),
                    NumberSequenceKeypoint.new(0.7, 0.4),
                    (NumberSequenceKeypoint.new(1, 1)),
                }),
            })
            local u104 = Kit.Emitter(u18, {
                Drag = 1,
                Rate = 70,
                Enabled = true,
                Texture = u65.Sparkle,
                Color = ColorSequence.new(u76, u81),
                EmissionDirection = Enum.NormalId.Front,
                SpreadAngle = Vector2.new(22, 22),
                Speed = NumberRange.new(30, 60),
                Lifetime = NumberRange.new(0.6, 1.1),
                Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), (NumberSequenceKeypoint.new(1, 0))}),
            })
            glowFlare(a1, v1.Position, u76, 12)
            task.delay(1.15 * a1.Scale, function() -- Line: 1049 -- upvalues: u69 (val), u104 (val), j (val), u18 (val)
                u69.Enabled = false
                u104.Enabled = false
                j.RoarHost = nil
                task.delay(1.5, function() -- Line: 1053 -- upvalues: u18 (upval)
                    u18:Destroy()
                end)
            end)
        end
    end
end

local function splash(a1, a2) -- Line: 1061
    -- upvalues: burst (val), u65 (val), u96 (val), u86 (val), flatWave (val), sparkleBurst (val)
    burst(a1, a2, {
        LightEmission = 0.6,
        Acceleration = Vector3.new(0, -70, 0),
        Texture = u65.Water,
        Color = ColorSequence.new(u96, u86),
        EmissionDirection = Enum.NormalId.Top,
        SpreadAngle = Vector2.new(28, 28),
        Speed = NumberRange.new(34, 62),
        Lifetime = NumberRange.new(0.9, 1.5),
        Rotation = NumberRange.new(0, 360),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.2), (NumberSequenceKeypoint.new(1, 4.5))}),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 1))}),
    }, 46)
    flatWave(a1, a2 + Vector3.new(0, 0.30000001192092896, 0), u86, 44, 0.9)
    sparkleBurst(a1, a2 + Vector3.new(0, 2, 0), u86, 40, 36)
end

local function lionRise(a1, a2) -- Line: 1085 -- upvalues: Kit (val) -- types: a2: number
    return Kit.Window(a2, 0.05 + a1.Index * 0.15, 1.1 + a1.Index * 0.15)
end

local function lionWalk(a1) -- Line: 1089 -- upvalues: Kit (val) -- types: a1: number
    return Kit.Ease(Kit.Window(a1, 1.35, 2.45), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
end

local function whaleArrive(a1) -- Line: 1093
    local v1 = 0.2 + a1.Index * 0.35
    return v1, v1 + 3.2
end

local function petFrame(a1, a2, a3) -- Line: 1098 -- upvalues: Kit (val), u68 (val) -- types: a3: number
    local v1, v2, v3, v4, v5, v6, v7
    local Home = a2.Home
    if a2.Kind == "Lion" then
        v2 = Kit.Ease(Kit.Window(a3, 1.35, 2.45), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        local v8 = Home + Home.LookVector * (v2 * 7)
        if a2.Drop then
            v8 = v8 + Vector3.new(0, 1, 0) * (a2.Drop * Kit.Smooth(Kit.Window(v2, 0.35, 0.8)))
        end
        v2 = Kit.Window(a3, u68.Fuse, u68.Fuse + 0.6)
        v3 = math.sin(a3 * 6) * 0.15 * v2
        v4 = Kit.Ease(Kit.Window(a3, 0.05 + a2.Index * 0.15, 1.1 + a2.Index * 0.15), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        v5 = if not a2.Placed then -(1 - v4) * (a2.Height or 12) * 0.9 else 0
        if a2.Roar then
            return (v8 + Vector3.new(0, 1, 0) * (v5 + v3)) * CFrame.Angles(-0.08 * v2, 0, 0)
        end
        v4 = Kit.Smooth(Kit.Window(a3, u68.Crack, u68.Roar))
        v6 = Kit.Window(a3, u68.Roar, u68.Roar + 0.45)
        v7 = Kit.Smooth((Kit.Window(a3, u68.Roar + 1.3, u68.Shatter + 0.5)))
        v1 = (Kit.BackOut(v6)) * (1 - v7)
        v7 = -0.12 * v4 * (1 - v6) + 0.44 * v1
        local v9 = 1.9 * v1 - 0.5 * v4 * (1 - v6)
        return (v8 + v8.LookVector * (1.4 * v1) + Vector3.new(0, 1, 0) * (v5 + v9 + v3)) * CFrame.Angles(v7 - 0.08 * v2, 0, 0)
    end
    v2 = math.sin(a3 * 1.7 + a2.Index) * 0.9
    if a2.Placed and a3 < u68.Dive then
        return Home + Vector3.new(0, 1, 0) * (v2 * Kit.Smooth(Kit.Window(a3, 0, 1.2)))
    end
    if a3 < u68.Dive then
        v5 = 0.2 + a2.Index * 0.35
        v3 = v5
        v4 = v5 + 3.2
        v5 = Home + Vector3.new(0, 1, 0) * v2
        if v4 + 0.8 <= a3 then
            return v5
        end
        v6 = Home.Position + Kit.Flat(Home.Position - a1.Center) * 60 + Vector3.new(0, 38, 0)
        v7 = (v6 + Home.Position) / 2 + Vector3.new(0, 14, 0) + Home.LookVector * -18
        v1 = Kit.Ease(Kit.Window(a3, v3, v4), Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        v3 = Kit.Bezier(v6, v7, Home.Position, v1)
        v1 = Kit.Bezier(v6, v7, Home.Position, (math.min(v1 + 0.03, 1))) - v3
        return (if not (0.001 < v1.Magnitude) then (CFrame.new(v3)) * Home.Rotation else CFrame.lookAt(v3, v3 + v1.Unit)):Lerp(
            v5,
            (Kit.Smooth((Kit.Window(a3, v4 - 0.5, v4 + 0.8))))
        )
    end
    v3 = a1.Center + Kit.Flat(Home.Position - a1.Center) * 9 - Vector3.new(0, 3, 0)
    if a3 < u68.Splash then
        v4 = Kit.Window(a3, u68.Dive, u68.Splash)
        v5 = Kit.Ease(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        v4 = (Home.Position + v3) / 2 + Vector3.new(0, 16, 0)
        v6 = Home.Position + Vector3.new(0, 1, 0) * v2
        v7 = Kit.Bezier(v6, v4, v3, v5)
        v1 = (v4 - v6) * (1 - v5) + (v3 - v4) * v5
        if v1.Magnitude < 0.001 then
            v1 = v3 - Home.Position
        end
        v6 = CFrame.lookAt(v7, v7 + v1.Unit)
        a2.DiveRotation = v6.Rotation
        return v6
    end
    v2 = a3 - u68.Splash
    local u362 = math.atan2(v3.Z - a1.Center.Z, v3.X - a1.Center.X)
    local u372 = Kit.Smooth(Kit.Window(a3, u68.Collapse, 15))

    local function swimAt(a1_2) -- Line: 1163
        -- upvalues: Kit (upval), u362 (val), u372 (val), a1 (val)
        local v1 = Kit.Smooth((math.min(a1_2 / 1.6, 1)))
        local v2 = u362 + (a1_2 * 1.1 + (1 - math.exp(a1_2 * -1.5)) * 0.6 + a1_2 * 0.18 * a1_2)
        local v3 = Kit.Lerp(Kit.Lerp(9, 15, v1), 6, u372)
        local v4 = Kit.Lerp(Kit.Lerp(3, 7.5, v1), 4, u372)
        return a1.Center + Vector3.new(math.cos(v2) * v3, -v4 + math.sin(a1_2 * 3) * 0.6 * v1, (math.sin(v2)) * v3)
    end

    v5 = swimAt(v2)
    v6 = CFrame.lookAt(v5, (swimAt(v2 + 0.06)))
    v4 = Kit.Smooth((math.min(v2 / 0.55, 1)))
    if not (v4 >= 1) and a2.DiveRotation then
        return ((CFrame.new(v5)) * a2.DiveRotation):Lerp(v6, v4)
    end
    return v6
end

local function petScale(a1, a2, a3) -- Line: 1185 -- upvalues: Kit (val), lionRise (val), u68 (val) -- types: a3: number
    local v1, v2, v3
    if a2.Placed then
        v1 = Kit.Lerp(a2.Placed, 1, Kit.Smooth(Kit.Window(a3, 0.25, 1.5)))
    elseif a2.Kind ~= "Lion" then
        v3 = 0.2 + a2.Index * 0.35
        v2 = v3
        local v4 = v3 + 3.2
        v1 = Kit.Lerp(0.15, 1, Kit.Smooth(Kit.Window(a3, v2, v2 + 1.4)))
    else
        v1 = Kit.Lerp(0.35, 1, Kit.Smooth(lionRise(a2, a3)))
    end
    v2 = if a2.Kind ~= "Lion" then 1 else math.max(0, 1 - (math.abs(a3 - u68.Roar - 0.15)) / 0.35) * 0.08 + 1
    v3 = 1 - Kit.Smooth(Kit.Window(a3, u68.Collapse + 0.6, u68.Collapse + 1.6))
    if a1.PayoffAt then
        v3 = 0
    end
    return (math.max(v1 * v2 * v3, 0.02))
end

local function stepPets(a1, a2) -- Line: 1205
    -- upvalues: petScale (val), petFrame (val), liveMouth (val), u68 (val), sparkleBurst (val), u76 (val), u86 (val)
    local Trail, v1, v2, v3, v4, v5
    local Pets = a1.Pets
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a2
    for i, j in Pets, v6, v7 do
        if j.Model.Parent then
            v4 = petScale(v8, j, v9)
            if 0.001 < (math.abs(v4 - j.Grow)) then
                j.Grow = v4
                j.Model:ScaleTo((math.max(j.Scale * v4, 0.01)))
            end
            v5 = petFrame(v8, j, v9)
            if j.Foot then
                v5 = v5 + Vector3.new(0, 1, 0) * (j.Foot * v4)
            end
            j.Model:PivotTo(v5)
            if j.RoarHost then
                j.RoarHost.CFrame = liveMouth(j)
            end
            if j.Wake then
                j.Wake.CFrame = v5
                v2 = 0.2 + j.Index * 0.35
                v1 = v2 + 3.2
                Trail = j.Trail
                if not (v9 < v1 + 0.4) then
                    v3 = false
                    if u68.Dive + 0.15 <= v9 then
                        v3 = v9 < u68.Collapse + 0.6
                    end
                else
                    v3 = not j.Placed
                    if not v3 then
                        v3 = false
                        if u68.Dive + 0.15 <= v9 then
                            v3 = v9 < u68.Collapse + 0.6
                        end
                    end
                end
                Trail.Enabled = v3
            end
            if v4 <= 0.03 and u68.Collapse < v9 and not j.Dissolved then
                j.Dissolved = true
                sparkleBurst(v8, j.Model:GetPivot().Position, if j.Kind ~= "Lion" then u86 else u76, 30, 18)
                j.Model.Parent = nil
            end
        end
    end
end

local function stepSeal(a1, a2, a3) -- Line: 1243
    -- upvalues: Kit (val), u68 (val), sparkleBurst (val), u76 (val), glowFlare (val), u96 (val)
    local Age_2, Part_3, v1, v2, v3, v4
    local v5 = Kit.Window(a2, u68.Crack, u68.Shatter)
    if not a1.Fragments then
        for m, i5 in a1.Highlights do
            v3 = a2 * (10 + 26 * v5)
            i5.FillTransparency = 1 - v5 * ((math.sin(v3) * 0.5 + 0.5) * 0.25 + 0.35)
            i5.OutlineTransparency = 1 - v5 * 0.9
        end
        return
    end
    v5 = a2 - u68.Shatter
    for i, j in a1.Fragments do
        Part_3 = j.Part
        if not j.Core then
            v1 = Kit.Ease(math.min(v5 / 1.6, 1), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
            v2 = (math.sin(3.141592653589793 * (math.min(v5 / 0.9, 1)))) * j.Lift
            v3 = math.max(v5 - 0.9, 0) ^ 2 * 9
            v4 = CFrame.fromAxisAngle(j.Axis, j.Spin * v1)
            Part_3.CFrame = CFrame.new(j.Origin.Position + j.Out * j.Reach * v1 + Vector3.new(0, 1, 0) * (v2 - v3)) * v4 * j.Origin.Rotation
            Part_3.Transparency = Kit.Lerp(j.Transparency, 1, Kit.Window(v5, 0.7, 1.8))
        else
            v1 = Kit.Smooth((math.min(v5 / 0.5, 1)))
            Part_3.CFrame = j.Origin + Vector3.new(0, 1, 0) * j.Lift * v1
            Part_3.Transparency = Kit.Lerp(j.Transparency, 1, Kit.Window(v5, 0.25, 0.6))
            if v5 > 0.35 and not j.Popped then
                j.Popped = true
                sparkleBurst(a1, Part_3.Position, u76, 50, 40)
                glowFlare(a1, Part_3.Position, u96, 18)
            end
        end
    end
    for k, n in a1.Debris do
        if n.Part.Parent then
            n.Age = n.Age + a3
            n.Velocity = n.Velocity - Vector3.new(0, 80, 0) * a3
            n.Part.CFrame = (n.Part.CFrame + n.Velocity * a3) * CFrame.Angles(n.Spin.X * a3, n.Spin.Y * a3, n.Spin.Z * a3)
            n.Part.Transparency = Kit.Window(n.Age, n.Life - 0.5, n.Life)
            Age_2 = n.Age
            if n.Life < Age_2 then
                n.Part:Destroy()
            end
        end
    end
end

local function stepWater(a1, a2) -- Line: 1291
    -- upvalues: Kit (val), u68 (val), u86 (val), u91 (val), u76 (val), u71 (val)
    local v1
    local Water = a1.Water
    local WaterSaved = a1.WaterSaved
    local v2 = Kit.Smooth(Kit.Window(a2, u68.Shatter, u68.Reveal + 1.2))
    local v3 = Kit.Window(a2, u68.Fuse, u68.Collapse + 1.4)
    if Water and WaterSaved and v2 > 0 then
        local v4 = math.sin(a2 * (2 + 9 * v3)) * 0.5 + 0.5
        v1 = (u86:Lerp(u91, 0.35 * v3 * v4)):Lerp(Color3.fromRGB(255, 236, 170), 0.4 * v3 * v3)
        Water.Material = Enum.Material.Glass
        Water.Color = WaterSaved.Color:Lerp(v1, v2)
        Water.Transparency = Kit.Lerp(WaterSaved.Transparency, 0.3, v2)
        Water.Reflectance = Kit.Lerp(WaterSaved.Reflectance, 0.15, v2)
    end
    if a1.Light then
        a1.Light.Brightness = v2 * 1 + v3 * 2.2
        a1.Light.Color = u86:Lerp(u76, v3 * 0.6)
        a1.Light.Range = 50 + 20 * v3
    end
    if a1.Ripples then
        local v5 = if not a1.P then 1 else 1 - Kit.Window(a1.P, u71.Present, u71.Done - 0.5)
        a1.Ripples.Rate = v2 * (6 + 30 * v3) * v5
        local Ripples = a1.Ripples
        v1 = false
        if v2 > 0 then
            v1 = v5 > 0
        end
        Ripples.Enabled = v1
        a1.Motes.Rate = v2 * (4 + 50 * v3) * v5
        local Motes = a1.Motes
        v1 = false
        if v2 > 0 then
            v1 = v5 > 0
        end
        Motes.Enabled = v1
    end
end

local function stepFusion(a1, a2) -- Line: 1320
    -- upvalues: Kit (val), u68 (val), liveMouth (val), u76 (val), u86 (val), u96 (val)
    local Halo, Position_2, Ring, Unit, new_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16
    local Center = a1.Center
    local v17 = Kit.Window(a2, u68.Fuse, u68.Fuse + 1.2)
    local v18 = Kit.Smooth(Kit.Window(a2, u68.Collapse, 15))
    local v19 = a1.PayoffAt ~= nil
    for i, j in a1.Orbs do
        if not v19 then
            v1 = j.Phase + a2 * j.Speed * (1 + 3 * v18)
            v2 = j.Radius * (1 - 0.88 * v18) * (0.6 + 0.4 * v17)
            v3 = j.Height * (1 - v18) + 3 * v18 + math.sin(a2 * 2 + j.Phase) * 0.5
            j.Part.CFrame = CFrame.new(Center + Vector3.new(math.cos(v1) * v2, v3, (math.sin(v1)) * v2))
            j.Part.Transparency = 1 - v17 * 0.9
        else
            j.Part.Transparency = 1
        end
    end
    local Rings = a1.Rings
    local v20 = nil
    local v21 = nil
    local v22, v23 = a1, a2
    for k, n in Rings, v20, v21 do
        v1 = (math.sin(v23 * 2.4 + n.Phase)) * 0.05 + 1
        v2 = math.max(n.Radius * v1 * (1 - 0.9 * v18), 0.2)
        v1 = math.sin(v23 * 5 + n.Phase * 2) * 0.15 + 0.85
        v3 = Vector3.new(0, 1, 0) * (0.3 + v18 * 2)
        Ring = n.Ring
        v5 = CFrame.new(Center + v3)
        v7 = 1.1 + 0.5 * v18
        Ring:Set(v5, v2, if not v19 then 1 - v17 * 0.7 * v1 else 1, v7)
        Halo = n.Halo
        v5 = CFrame.new(Center + v3 - Vector3.new(0, 0.05000000074505806, 0))
        v7 = 2.4 + 1.6 * v18
        Halo:Set(v5, v2, if not v19 then 1 - v17 * 0.14 * v1 else 1, v7)
    end
    v22.RingPulse.Rate = if not v19 then v17 * (1 - v18) * 1.4 else 0
    v22.RingPulse.Enabled = 0.05 < v22.RingPulse.Rate
    v22.RingImplode.Rate = if not v19 then v18 * 3.5 else 0
    v22.RingImplode.Enabled = 0.05 < v22.RingImplode.Rate
    local v24 = math.max(v23 - u68.Fuse, 0)
    v20 = Kit.Ease(v24 / 3.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    v21 = if not (v24 < 3.4) then (v24 - 3.4) * 1.3 + 1.972 else v24 * 0.22 + v24 ^ 3 * 1.08 / 34.67999999999999
    v24 = 0.2 + 0.8 * v20
    local Position = v22.Core.Position
    v1 = nil
    v2 = nil
    for m, i5 in v22.Streams, v1, v2 do
        v4 = false
        if i5.Pet.Model.Parent ~= nil then
            v4 = not v19
        end
        v5 = if not v4 then 0 else v17 * (1 - Kit.Window(v23, u68.Collapse + 0.6, u68.Collapse + 1.4))
        Position_2 = if not v4 then Center else liveMouth(i5.Pet).Position
        if v4 then
            i5.Mouth.WorldCFrame = CFrame.lookAt(Position_2, Position)
        end
        v7 = nil
        v8 = nil
        for i6, i7 in i5.Ribbons, v7, v8 do
            v4 = v5 * (0.2 + 0.8 * v20)
            v11 = v4 * (if i6 ~= 1 then 0.75 else 0.55)
            v12 = math.sin(v23 * 9 + i6) * 0.15 + 0.85
            new_2 = NumberSequence.new
            v14 = {
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.15, 1 - v11),
                NumberSequenceKeypoint.new(0.85, 1 - v11),
                (NumberSequenceKeypoint.new(1, 1)),
            }
            i7.Transparency = new_2(v14)
            v15 = if i6 ~= 1 then 0.7 else 1.6
            i7.Width0 = v15 * v4 * v12
            v15 = if i6 ~= 1 then 1.4 else 3.2
            i7.Width1 = v15 * v4 * v12
            v14 = if i6 ~= 1 then 1.3 else 2.4
            i7.TextureSpeed = v14 * (0.15 + 0.85 * v20)
            v16 = v23 * 2.2 + i5.Pet.Index + i6
            i7.CurveSize0 = math.sin(v16) * 7 * v5
            v16 = v23 * 1.7 + i6
            i7.CurveSize1 = math.cos(v16) * 5 * v5
        end
        v6 = Position - Position_2
        v7 = v6:Cross((Vector3.new(0, 1, 0)))
        Unit = if not (0.001 < v7.Magnitude) then Vector3.new(1, 0, 0) else v7.Unit
        v9 = nil
        v10 = nil
        for i8, i9 in i5.Comets, v9, v10 do
            v13 = (v21 + i9.Offset) % 1
            v14 = false
            if i9.Last ~= nil then
                v14 = v13 < i9.Last
            end
            i9.Last = v13
            if v5 < 0.05 then
                i9.Part.Transparency = 1
                i9.Trail.Enabled = false
            elseif not (v24 < i9.Offset) then
                v15 = Position_2 + v6 * 0.5 + Unit * i9.Side * 6 + Vector3.new(0, 1, 0) * i9.Lift
                v16 = math.sin(3.141592653589793 * v13)
                i9.Part.CFrame = CFrame.new(Kit.Bezier(Position_2, v15, Position, v13))
                i9.Part.Transparency = 1 - v5 * v16
                i9.Part.Size = Vector3.new(1, 1, 1) * (v16 * 0.45 + 0.3)
                i9.Trail.Enabled = not v14
            else
                i9.Part.Transparency = 1
                i9.Trail.Enabled = false
            end
        end
    end
    local Core = v22.Core
    if v19 then
        v22.CoreVortex.Enabled = false
        v22.CoreGlow.Enabled = false
        v22.CoreSparks.Enabled = false
    end
    if not v19 then
        v21 = Kit.Window(v23, u68.Fuse + 0.6, 15)
        v20 = math.sin(v23 * (12 + 30 * v18)) * 0.12 + 1
        v24 = (0.6 + 2.2 * v21 * v21 + 2.4 * v18) * v20
        Core.Size = Vector3.new(1, 1, 1) * v24
        Core.Transparency = 1 - math.min(v21 * 1.6, 1) * 0.55
        v22.CoreVortex.Rate = 4 + 16 * v21
        v22.CoreVortex.Enabled = v21 > 0.02
        v22.CoreVortex.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, v24 * 1.6),
            (NumberSequenceKeypoint.new(1, v24 * 3.6)),
        })
        v22.CoreGlow.Rate = 6 + 10 * v21
        v22.CoreGlow.Enabled = v21 > 0.02
        v22.CoreGlow.Size = NumberSequence.new(v24 * 3)
        v22.CoreSparks.Rate = 20 + 90 * v18
        v22.CoreSparks.Enabled = v21 > 0.1
        Core.Color = (u76:Lerp(u86, (math.sin(v23 * 5)) * 0.5 + 0.5)):Lerp(u96, v18 * 0.85)
        Core.CFrame = CFrame.new(Center + Vector3.new(0, 1, 0) * (2 + v18))
    end
end

local function beats(a1, a2) -- Line: 1444
    -- upvalues: Kit (val), u59 (val), flatWave (val), u76 (val), sparkleBurst (val), burst (val), u65 (val), u86 (val)
    -- upvalues: u68 (val), kick (val), roarWaves (val), shatter (val), buildFusionField (val), splash (val)
    local v1, v2, v3, v4
    local Fired = a1.Fired

    local function once(a1, a2_2) -- Line: 1446 -- upvalues: Fired (val), a2 (val) -- types: a1: string, a2_2: number
        if not Fired[a1] and not (a2 < a2_2) then
            Fired[a1] = true
            return true
        end
        return false
    end

    if Fired.Appear then
        v2 = false
    elseif not (a2 < 0.1) then
        Fired.Appear = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = Kit.Sound(u59.Appear, a1.Center or a1.Center, 1.2, nil)
        if v3 then
            a1.Sounds[v3] = true
        end
        for i, j in a1.Pets do
            if j.Kind == "Lion" then
                task.delay((0.05 + j.Index * 0.15) * a1.Scale, function() -- Line: 1460
                    -- upvalues: a1 (val), j (val), flatWave (upval), u76 (upval), sparkleBurst (upval), burst (upval)
                    -- upvalues: u65 (upval), u86 (upval)
                    if not a1.Dead and j.Model.Parent then
                        local v1 = j.Home.Position - Vector3.new(0, 1, 0) * (j.Height or 12) * 0.35
                        flatWave(a1, v1, u76, 26, 1.2)
                        sparkleBurst(a1, v1, u76, 36, 16)
                        burst(a1, v1, {
                            Drag = 2,
                            Texture = u65.Petal,
                            Color = ColorSequence.new(if j.Kind ~= "Lion" then u86 else u76),
                            SpreadAngle = Vector2.new(180, 180),
                            Speed = NumberRange.new(8, 18),
                            Lifetime = NumberRange.new(1, 1.8),
                            Rotation = NumberRange.new(0, 360),
                            RotSpeed = NumberRange.new(-180, 180),
                            Size = NumberSequence.new(0.8),
                        }, 24)
                        return
                    end
                end)
            end
        end
    end
    if Fired.Walk then
        v2 = false
    elseif not (a2 < 1.35) then
        Fired.Walk = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        for k, n in a1.Pets do
            if n.Walk and n.Track then
                n.Walk:Play(0.25, 1, 1.15)
                n.Track:Stop(0.25)
            end
        end
    end
    local Halt = u68.Halt
    if Fired.Halt then
        v2 = false
    elseif not (a2 < Halt) then
        Fired.Halt = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = nil
        v4 = nil
        for m, i5 in a1.Pets, v3, v4 do
            if i5.Walk and i5.Track then
                i5.Walk:Stop(0.25)
                i5.Track:Play(0.25)
            end
            if i5.Roar then
                i5.Roar:Play(0.2, 1, 1 / a1.Scale)
                i5.Roar.TimePosition = math.max(a2 - u68.Halt, 0)
            end
        end
    end
    local Crack = u68.Crack
    if Fired.Crack then
        v2 = false
    elseif not (a2 < Crack) then
        Fired.Crack = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = Kit.Sound(u59.SealCrack, a1.Center or a1.Center, 1.3, nil)
        if v3 then
            a1.Sounds[v3] = true
        end
        kick(a1, 0.35)
    end
    local Roar_3 = u68.Roar
    if Fired.Roar then
        v2 = false
    elseif not (a2 < Roar_3) then
        Fired.Roar = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        local Position, v5
        v3 = nil
        v4 = nil
        for i6, i7 in a1.Pets, v3, v4 do
            if i7.Kind == "Lion" then
                Position = i7.Home.Position
                v1 = if not i7.Real then 0.92 else 1
                v5 = Kit.Sound(u59.Roar, Position or a1.Center, 1.5, v1)
                if v5 then
                    a1.Sounds[v5] = true
                end
            end
        end
        roarWaves(a1)
        kick(a1, 1.1)
        a1.FovKick = 1
    end
    local Shatter = u68.Shatter
    if Fired.Shatter then
        v2 = false
    elseif not (a2 < Shatter) then
        Fired.Shatter = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = Kit.Sound(u59.SealShatter, a1.Center or a1.Center, 1.6, nil)
        if v3 then
            a1.Sounds[v3] = true
        end
        shatter(a1)
    end
    local Reveal = u68.Reveal
    if Fired.Reveal then
        v2 = false
    elseif not (a2 < Reveal) then
        Fired.Reveal = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = Kit.Sound(u59.WaterReveal, a1.Center or a1.Center, 1.2, nil)
        if v3 then
            a1.Sounds[v3] = true
        end
        buildFusionField(a1)
    end
    local WhaleCall = u68.WhaleCall
    if Fired.WhaleCall then
        v2 = false
    elseif not (a2 < WhaleCall) then
        Fired.WhaleCall = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = nil
        v4 = nil
        for i8, i9 in a1.Pets, v3, v4 do
            if i9.Kind == "Whale" and i9.Real then
                v1 = Kit.Sound(u59.WhaleCall, i9.Home.Position or a1.Center, 1.3, nil)
                if v1 then
                    a1.Sounds[v1] = true
                end
            end
        end
    end
    local Splash = u68.Splash
    if Fired.Splash then
        v2 = false
    elseif not (a2 < Splash) then
        Fired.Splash = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = Kit.Sound(u59.Splash, a1.Center or a1.Center, 1.5, nil)
        if v3 then
            a1.Sounds[v3] = true
        end
        for i10, i11 in a1.Pets do
            if i11.Kind == "Whale" then
                splash(a1, a1.Center + Kit.Flat(i11.Home.Position - a1.Center) * 9)
            end
        end
        kick(a1, 2.2)
        a1.FovKick = math.max(a1.FovKick, 0.7)
    end
    local Fuse = u68.Fuse
    if Fired.Fuse then
        v2 = false
    elseif not (a2 < Fuse) then
        Fired.Fuse = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v2 = Kit.Sound(u59.Charge, a1.Center or a1.Center, 1.1, nil)
        if v2 then
            a1.Sounds[v2] = true
        end
        a1.ChargeSound = v2
    end
    v3 = u68.Collapse + 1.3
    if Fired.Collapse then
        v2 = false
    elseif not (a2 < v3) then
        Fired.Collapse = true
        v2 = true
    else
        v2 = false
    end
    if v2 then
        v3 = Kit.Sound(u59.Collapse, a1.Center or a1.Center, 1.4, nil)
        if v3 then
            a1.Sounds[v3] = true
        end
    end
    if u68.Collapse <= a2 then
        a1.ShakePower = math.max(a1.ShakePower, 0.25 + 0.5 * (Kit.Window(a2, u68.Collapse, 15)))
    end
end

local function regrow(a1, a2) -- Line: 1553 -- upvalues: Kit (val) -- types: a2: number
    local v1
    if not a1.Fragments then
        return
    end
    for i, j in a1.Fragments do
        if not j.Core then
            v1 = 1 - Kit.Ease(a2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
            j.Part.CFrame = j.Origin + j.Out * j.Reach * v1 - Vector3.new(0, 3, 0) * v1
            j.Part.Transparency = Kit.Lerp(1, j.Transparency, Kit.Window(a2, 0, 0.6))
        else
            j.Part.CFrame = j.Origin
            j.Part.Transparency = Kit.Lerp(1, j.Transparency, Kit.Window(a2, 0.7, 1))
        end
    end
    local Water = a1.Water
    local WaterSaved = a1.WaterSaved
    if Water and WaterSaved then
        Water.Color = Water.Color:Lerp(WaterSaved.Color, a2)
        Water.Transparency = Kit.Lerp(Water.Transparency, WaterSaved.Transparency, a2)
        Water.Reflectance = Kit.Lerp(Water.Reflectance, WaterSaved.Reflectance, a2)
    end
    if a1.Light then
        local Light = a1.Light
        Light.Brightness = Light.Brightness * (1 - a2)
    end
end

local function makeEggs(a1) -- Line: 1582 -- upvalues: Kit (val), u86 (val), u76 (val), u96 (val)
    local Attachment, Attachment_2, BoundingBox_2, Character, Eggs, Lion, Trail, v1, v2, v3, v4, v5, v6, v7, v8
    a1.Eggs = {}
    local Seats = a1.Seats
    local v9 = if not Seats then #a1.Kind.Sides else #Seats
    local v10 = a1
    for i = 1, v9 do
        v4 = v10.Kind.Sides[i] or v10.Kind.Sides[1]
        v5 = if not Seats then nil else Seats[i]
        Lion = if not v5 then v10.Pads[v4] else v5.Lion or v5.Whale
        v7 = Lion.Position + Vector3.new(0, 1, 0) * (Lion.Size.Y / 2)
        v6 = v7 + Kit.Flat(v10.Center - v7) * 7
        v7 = Kit.EggModel(v10.Fused, 5.4, if i ~= 1 then u76 else u86)
        _, BoundingBox_2 = v7:GetBoundingBox()
        v7:ScaleTo((v7:GetScale()) * 0.25)
        v7.Parent = v10.Container
        v8 = Kit.Part({
            Name = "EggGlow",
            Transparency = 1,
            Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        })
        v8.Parent = v10.Container
        Attachment = Instance.new("Attachment")
        Attachment.Position = Vector3.new(0, 1.2000000476837158, 0)
        Attachment.Parent = v8
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Position = Vector3.new(0, -1.2000000476837158, 0)
        Attachment_2.Parent = v8
        Trail = Instance.new("Trail")
        Trail.Attachment0 = Attachment
        Trail.Attachment1 = Attachment_2
        Trail.Color = ColorSequence.new(if i ~= 1 then u76 else u86, u96)
        Trail.Transparency = NumberSequence.new(0.1, 1)
        Trail.Lifetime = 0.5
        Trail.LightEmission = 1
        Trail.LightInfluence = 0
        Trail.FaceCamera = true
        Trail.Parent = v8
        v1 = Instance.new("PointLight")
        v1.Color = if i ~= 1 then u76 else u86
        v1.Range = 14
        v1.Brightness = 3
        v1.Parent = v8
        Eggs = v10.Eggs
        v2 = {
            Model = v7,
            Full = v7:GetScale() * 4,
            Host = v8,
            Trail = Trail,
            Side = v4,
            Index = i,
            Land = v6 + Vector3.new(0, 1, 0) * (BoundingBox_2.Y / 2),
        }
        Character = if not v5 then v10.Characters[v4] else v5.Character
        v2.Character = Character
        v3 = if not v5 then v10.Guards[v4] else v10.Guards[i]
        v2.Guard = v3
        table.insert(Eggs, v2)
    end
end

local function stepEggs(a1, a2) -- Line: 1632
    -- upvalues: Kit (val), u71 (val), u59 (val), flatWave (val), u86 (val), u76 (val), sparkleBurst (val), kick (val)
    -- upvalues: glowFlare (val), u96 (val)
    local Land, Model, v1, v2, v3, v4, v5, v6, v7
    local Center = a1.Center
    local v8 = Center + Vector3.new(0, 24, 0)
    local Eggs = a1.Eggs
    local v9 = nil
    local v10 = nil
    local v11, v12 = a2, a1
    for i, j in Eggs, v9, v10 do
        Model = j.Model
        if Model.Parent then
            v1 = if j.Index ~= 1 then 3.141592653589793 else 0
            v3 = v11 * 9
            v4 = Kit.BackOut((Kit.Window(v11, u71.Burst, u71.Apex)))
            v5 = j.Full * math.max(0.25 + 0.75 * v4, 0.05)
            if v11 < u71.Apex then
                v4 = Kit.Ease(Kit.Window(v11, u71.Burst, u71.Apex), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                v6 = 2.2 * v4
                v7 = v1 + v11 * 10
                if 0.0001 < (math.abs((Model:GetScale()) - v5)) then
                    Model:ScaleTo((math.max(v5, 0.01)))
                end
                v5 = if not (u71.Land <= v11) or not (v11 < u71.Handoff) then 0 else math.sin(v11 * 16) * 0.12 * math.exp(-(v11 - u71.Land) * 1.5)
                Model:PivotTo((CFrame.new((Center:Lerp(v8, v4)) + Vector3.new(math.cos(v7) * v6, 0, (math.sin(v7)) * v6))) * (CFrame.Angles(v5, v3, v5 * 0.5)))
                j.Host.CFrame = CFrame.new(v2)
                j.Position = v2
            elseif v11 < u71.Split then
                v6 = v1 + u71.Apex * 10 + (v11 - u71.Apex) * 4
                v3 = u71.Apex * 9 + (v11 - u71.Apex) * 3
                if 0.0001 < (math.abs((Model:GetScale()) - v5)) then
                    Model:ScaleTo((math.max(v5, 0.01)))
                end
                v5 = if not (u71.Land <= v11) or not (v11 < u71.Handoff) then 0 else math.sin(v11 * 16) * 0.12 * math.exp(-(v11 - u71.Land) * 1.5)
                Model:PivotTo((CFrame.new(v8 + Vector3.new(math.cos(v6) * 2.2, math.sin(v11 * 4) * 0.4, (math.sin(v6)) * 2.2))) * (CFrame.Angles(v5, v3, v5 * 0.5)))
                j.Host.CFrame = CFrame.new(v2)
                j.Position = v2
            elseif v11 < u71.Land then
                v6 = Kit.Window(v11, u71.Split, u71.Land)
                v7 = v8 + Vector3.new(math.cos(v1) * 2.2, 0, (math.sin(v1)) * 2.2)
                v2 = Kit.Bezier(
                    v7,
                    (v7 + j.Land) / 2 + Vector3.new(0, 14, 0),
                    j.Land,
                    Kit.Ease(v6, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                )
                v3 = u71.Apex * 9 + v6 * 3.141592653589793 * 3
                if 0.0001 < (math.abs((Model:GetScale()) - v5)) then
                    Model:ScaleTo((math.max(v5, 0.01)))
                end
                v5 = if not (u71.Land <= v11) or not (v11 < u71.Handoff) then 0 else math.sin(v11 * 16) * 0.12 * math.exp(-(v11 - u71.Land) * 1.5)
                Model:PivotTo((CFrame.new(v2)) * (CFrame.Angles(v5, v3, v5 * 0.5)))
                j.Host.CFrame = CFrame.new(v2)
                j.Position = v2
            elseif v11 < u71.Handoff then
                v6 = v11 - u71.Land
                v7 = math.abs((math.sin((math.min(v6 / 0.45, 1)) * 3.141592653589793))) * 1.4 * math.exp(-v6 * 2)
                v2 = j.Land + Vector3.new(0, 1, 0) * v7
                if not j.Landed then
                    j.Landed = true
                    j.Trail.Enabled = false
                    v7 = Kit.Sound(u59.EggLand, j.Land or v12.Center, 1.2, nil)
                    if v7 then
                        v12.Sounds[v7] = true
                    end
                    flatWave(v12, j.Land - Vector3.new(0, 2, 0), if j.Index ~= 1 then u76 else u86, 22, 0.6)
                    sparkleBurst(v12, j.Land, if j.Index ~= 1 then u76 else u86, 40, 20)
                    kick(v12, 0.4)
                end
                if j.Character or not (u71.Caught < v11) then
                    if 0.0001 < (math.abs((Model:GetScale()) - v5)) then
                        Model:ScaleTo((math.max(v5, 0.01)))
                    end
                    v5 = if not (u71.Land <= v11) or not (v11 < u71.Handoff) then 0 else math.sin(v11 * 16) * 0.12 * math.exp(-(v11 - u71.Land) * 1.5)
                    Model:PivotTo((CFrame.new(v2)) * (CFrame.Angles(v5, 0, v5 * 0.5)))
                    j.Host.CFrame = CFrame.new(v2)
                    j.Position = v2
                else
                    sparkleBurst(v12, j.Land, u76, 30, 14)
                    Model.Parent = nil
                    j.Host.Parent = nil
                end
            elseif j.Character then
                v6 = Kit.Window(v11, u71.Handoff, u71.Caught)
                v7 = Kit.RootOf(j.Character)
                Land = if not v7 then j.Land else v7.Position + Vector3.new(0, 1.5, 0)
                v7 = (j.Land + Land) / 2 + Vector3.new(0, 7, 0)
                v2 = Kit.Bezier(j.Land, v7, Land, v6 * v6)
                v3 = v6 * 3.141592653589793 * 4
                v5 = v5 * (1 - Kit.Window(v6, 0.6, 1) * 0.95)
                j.Trail.Enabled = true
                if not (v6 >= 1) then
                    if 0.0001 < (math.abs((Model:GetScale()) - v5)) then
                        Model:ScaleTo((math.max(v5, 0.01)))
                    end
                    v5 = if not (u71.Land <= v11) or not (v11 < u71.Handoff) then 0 else math.sin(v11 * 16) * 0.12 * math.exp(-(v11 - u71.Land) * 1.5)
                    Model:PivotTo((CFrame.new(v2)) * (CFrame.Angles(v5, v3, v5 * 0.5)))
                    j.Host.CFrame = CFrame.new(v2)
                    j.Position = v2
                else
                    if j.Guard then
                        j.Guard:Reveal()
                    end
                    sparkleBurst(v12, Land, u76, 50, 22)
                    glowFlare(v12, Land, u96, 10)
                    Model.Parent = nil
                    j.Host.Parent = nil
                end
            else
                v6 = v11 - u71.Land
                v7 = math.abs((math.sin((math.min(v6 / 0.45, 1)) * 3.141592653589793))) * 1.4 * math.exp(-v6 * 2)
                v2 = j.Land + Vector3.new(0, 1, 0) * v7
                if not j.Landed then
                    j.Landed = true
                    j.Trail.Enabled = false
                    v7 = Kit.Sound(u59.EggLand, j.Land or v12.Center, 1.2, nil)
                    if v7 then
                        v12.Sounds[v7] = true
                    end
                    flatWave(v12, j.Land - Vector3.new(0, 2, 0), if j.Index ~= 1 then u76 else u86, 22, 0.6)
                    sparkleBurst(v12, j.Land, if j.Index ~= 1 then u76 else u86, 40, 20)
                    kick(v12, 0.4)
                end
                if j.Character or not (u71.Caught < v11) then
                    if 0.0001 < (math.abs((Model:GetScale()) - v5)) then
                        Model:ScaleTo((math.max(v5, 0.01)))
                    end
                    v5 = if not (u71.Land <= v11) or not (v11 < u71.Handoff) then 0 else math.sin(v11 * 16) * 0.12 * math.exp(-(v11 - u71.Land) * 1.5)
                    Model:PivotTo((CFrame.new(v2)) * (CFrame.Angles(v5, 0, v5 * 0.5)))
                    j.Host.CFrame = CFrame.new(v2)
                    j.Position = v2
                else
                    sparkleBurst(v12, j.Land, u76, 30, 14)
                    Model.Parent = nil
                    j.Host.Parent = nil
                end
            end
        end
    end
end

local function payoffBurst(a1) -- Line: 1724
    -- upvalues: Kit (val), u59 (val), fadeOut (val), Flash (val), u96 (val), kick (val), u65 (val), u86 (val)
    -- upvalues: burst (val), flatWave (val), u76 (val), glowFlare (val), sparkleBurst (val)
    local Beam, v1
    local Center = a1.Center
    local v2 = Kit.Sound(u59.EggBurst, Center or a1.Center, 1.7, nil)
    if v2 then
        a1.Sounds[v2] = true
    end
    fadeOut(a1.ChargeSound, 0.45)
    if a1.Participant then
        pcall(Flash.Play, {Attack = 0.03, Decay = 0.6, Opacity = 0.9, Tint = u96})
    end
    kick(a1, 2)
    a1.FovKick = 1.3
    v2 = Kit.Part({
        Name = "GeyserBase",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        CFrame = CFrame.new(Center),
    })
    v2.Parent = a1.Container
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = v2
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = Vector3.new(0, 0.20000000298023224, 0)
    Attachment_2.Parent = v2
    local v3 = {}
    local v4 = {
        {
            Width = 13,
            Speed = -4,
            Length = 10,
            Texture = u65.Energy,
            Color = ColorSequence.new(u86, u96),
        },
        {
            Width = 7,
            Speed = -6,
            Length = 14,
            Texture = u65.Water,
            Color = ColorSequence.new(u96, u86),
        },
    }
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in v4, v5, v6 do
        Beam = Instance.new("Beam")
        Beam.Attachment0 = Attachment
        Beam.Attachment1 = Attachment_2
        Beam.Texture = j.Texture
        Beam.TextureMode = Enum.TextureMode.Wrap
        Beam.TextureLength = j.Length
        Beam.TextureSpeed = j.Speed
        Beam.Color = j.Color
        Beam.LightEmission = 1
        Beam.LightInfluence = 0
        Beam.FaceCamera = true
        Beam.Segments = 10
        Beam.Width0 = j.Width
        Beam.Width1 = j.Width * 0.55
        Beam.Transparency = NumberSequence.new(1)
        Beam.Parent = v2
        v1 = {Beam = Beam, Width = j.Width, Floor = if i ~= 1 then 0.1 else 0.25}
        v3[i] = v1
    end
    v7.Geyser = {
        Top = Attachment_2,
        Pillars = v3,
        Column = Kit.Emitter(v2, {
            LightEmission = 0.6,
            Acceleration = Vector3.new(0, -60, 0),
            Rate = 180,
            Enabled = true,
            Texture = u65.Water,
            Color = ColorSequence.new(u96, u86),
            EmissionDirection = Enum.NormalId.Top,
            SpreadAngle = Vector2.new(6, 6),
            Speed = NumberRange.new(70, 110),
            Lifetime = NumberRange.new(1, 1.5),
            Rotation = NumberRange.new(0, 360),
            RotSpeed = NumberRange.new(-90, 90),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 9))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 1))}),
        }),
        Mist = Kit.Emitter(v2, {
            LightEmission = 0.4,
            Drag = 2,
            Acceleration = Vector3.new(0, -6, 0),
            Rate = 70,
            Enabled = true,
            Texture = u65.Smoke,
            Color = ColorSequence.new(u96, u86),
            EmissionDirection = Enum.NormalId.Top,
            SpreadAngle = Vector2.new(85, 85),
            Speed = NumberRange.new(18, 34),
            Lifetime = NumberRange.new(1.4, 2.2),
            Rotation = NumberRange.new(0, 360),
            RotSpeed = NumberRange.new(-40, 40),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 6), (NumberSequenceKeypoint.new(1, 15))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), (NumberSequenceKeypoint.new(1, 1))}),
        }),
    }
    burst(v7, Center, {
        LightEmission = 0.7,
        Acceleration = Vector3.new(0, -75, 0),
        Texture = u65.Water,
        Color = ColorSequence.new(u96, u86),
        EmissionDirection = Enum.NormalId.Top,
        SpreadAngle = Vector2.new(22, 22),
        Speed = NumberRange.new(55, 95),
        Lifetime = NumberRange.new(1.2, 2),
        Rotation = NumberRange.new(0, 360),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 6))}),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), (NumberSequenceKeypoint.new(1, 1))}),
    }, 90)
    burst(v7, Center + Vector3.new(0, 4, 0), {
        ZOffset = 4,
        Texture = u65.Sunburst,
        Color = ColorSequence.new(Color3.fromRGB(255, 240, 200)),
        Speed = NumberRange.new(0),
        Lifetime = NumberRange.new(1.2),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-40, 40),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 10), (NumberSequenceKeypoint.new(1, 42))}),
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 1))}),
    }, 2)
    flatWave(v7, Center + Vector3.new(0, 0.4000000059604645, 0), u86, 130, 1)
    flatWave(v7, Center + Vector3.new(0, 0.6000000238418579, 0), u76, 90, 0.7)
    glowFlare(v7, Center + Vector3.new(0, 5, 0), u96, 60)
    sparkleBurst(v7, Center + Vector3.new(0, 6, 0), u76, 120, 70)
    sparkleBurst(v7, Center + Vector3.new(0, 6, 0), u86, 80, 55)
    for k, n in v7.Pets do
        if n.Model.Parent then
            sparkleBurst(v7, n.Model:GetPivot().Position, u76, 20, 14)
            n.Model.Parent = nil
        end
    end
    if v7.Core then
        v7.Core.Transparency = 1
    end
end

local function stepGeyser(a1, a2) -- Line: 1881 -- upvalues: Kit (val), u71 (val) -- types: a2: number
    local Geyser = a1.Geyser
    if not Geyser then
        return
    end
    local v1 = Kit.Ease(Kit.Window(a2, u71.Burst, u71.Burst + 0.35), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local v2 = Kit.Smooth(Kit.Window(a2, u71.Burst + 0.7, u71.Split + 0.6))
    local v3 = 46 * v1 * (1 - 0.35 * v2)
    Geyser.Top.Position = Vector3.new(0, math.max(v3, 0.2), 0)
    for i, j in Geyser.Pillars do
        v3 = Kit.Lerp(j.Floor, 1, v2)
        j.Beam.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, v3),
            NumberSequenceKeypoint.new(0.7, v3 + (1 - v3) * 0.35),
            (NumberSequenceKeypoint.new(1, 1)),
        })
        v3 = math.sin(a2 * 30) * 0.06 + 1
        j.Beam.Width0 = j.Width * v3 * (1 - 0.4 * v2)
        j.Beam.Width1 = j.Width * 0.55 * v3 * (1 - 0.4 * v2)
    end
    Geyser.Column.Rate = 180 * (1 - v2)
    Geyser.Column.Enabled = v2 < 1
    Geyser.Mist.Rate = 70 * (1 - v2)
    Geyser.Mist.Enabled = v2 < 1
end

local function finish(a1) -- Line: 1911 -- upvalues: u98 (ref), fadeOut (val), setCleared (val), restoreSeal (val)
    if a1.Dead then
        return
    end
    a1.Dead = true
    if u98 == a1 then
        u98 = nil
    end
    for i in a1.Sounds do
        if i.Parent and i.Looped then
            fadeOut(i, 0.6)
        end
    end
    fadeOut(a1.ChargeSound, 0.6)
    local Bed = a1.Bed
    if Bed and Bed.Parent then
        fadeOut(Bed, if not a1.PayoffAt then 0.8 else 2.2)
        task.delay(3, function() -- Line: 1928 -- upvalues: Bed (val)
            Bed:Destroy()
        end)
    end
    for j, k in a1.Guards do
        k:Reveal()
    end
    if not a1.PayoffAt or not a1.Participant then
        restoreSeal(a1)
    else
        setCleared(a1.Shrine, true)
    end
    local Water = a1.Water
    local WaterSaved = a1.WaterSaved
    if Water and WaterSaved then
        Water.Color = WaterSaved.Color
        Water.Transparency = WaterSaved.Transparency
        Water.Material = WaterSaved.Material
        Water.Reflectance = WaterSaved.Reflectance
    end
    a1.Trove:Destroy()
end

local function step(a1, a2) -- Line: 1944
    -- upvalues: Workspace (val), beats (val), stepPets (val), stepSeal (val), stepWater (val), stepFusion (val)
    -- upvalues: u71 (val), payoffBurst (val), stepGeyser (val), stepEggs (val), regrow (val), Kit (val), finish (val)
    if a1.Dead then
        return
    end
    local v1 = (Workspace:GetServerTimeNow() - a1.StartAt) / a1.Scale
    if a1.PayoffAt then
        v1 = math.max(v1, 15)
    end
    a1.T = v1
    a1.ShakePower = a1.ShakePower * math.exp(-a2 * 3.2)
    a1.FovKick = a1.FovKick * math.exp(-a2 * 4)
    beats(a1, v1)
    stepPets(a1, v1)
    stepSeal(a1, v1, a2)
    stepWater(a1, v1)
    if a1.Core then
        stepFusion(a1, v1)
    end
    local PayoffAt = a1.PayoffAt
    if PayoffAt then
        local v2 = os.clock() - PayoffAt
        a1.P = v2
        if not a1.Burst and u71.Burst <= v2 then
            a1.Burst = true
            payoffBurst(a1)
        end
        if a1.Core and not a1.Burst then
            local Core = a1.Core
            local v3 = a1.Core.Size.X * (1 - a2 * 18)
            Core.Size = Vector3.new(1, 1, 1) * math.max(v3, 0.3)
        end
        stepGeyser(a1, v2)
        stepEggs(a1, v2)
        if u71.Present <= v2 then
            regrow(a1, Kit.Window(v2, u71.Present, u71.Done - 0.3))
        end
        if u71.Handoff <= v2 and a1.OnDone then
            local OnDone = a1.OnDone
            a1.OnDone = nil
            task.spawn(OnDone)
        end
        if u71.Done <= v2 then
            finish(a1)
        end
    end
end

local function catmull(a1, a2, a3, a4, a5) -- Line: 1990
    -- upvalues: 
    local v1 = a5 * a5
    local v2 = a5 * a5 * a5
    return (a2 * 2 + (a3 - a1) * a5 + (a1 * 2 - a2 * 5 + a3 * 4 - a4) * v1 + (a2 * 3 - a1 - a3 * 3 + a4) * v2) * 0.5
end

local function around(a1, a2) -- Line: 2001 -- types: a2: number
    return (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), a2)):VectorToWorldSpace(a1.Side)
end

local function whaleFocus(a1) -- Line: 2005
    local v1 = Vector3.new(0, 0, 0)
    local v2 = 0
    for i, j in a1.Pets do
        if j.Kind == "Whale" and j.Model.Parent then
            v1 = v1 + j.Model:GetPivot().Position
            v2 = v2 + 1
        end
    end
    if v2 > 0 then
        return v1 / v2
    end
    return a1.Center
end

local function pathKeys(a1) -- Line: 2016 -- upvalues: Kit (val), whaleFocus (val)
    local v1, v2
    local Center = a1.Center
    local HeroLion = a1.HeroLion
    local v3 = Kit.Flat(Center - (if not HeroLion then Center + a1.Side * 40 else HeroLion.Home.Position + HeroLion.Home.LookVector * 7 + Vector3.new(0, 1, 0) * (HeroLion.Drop or 0)))
    local v4 = v3:Cross((Vector3.new(0, 1, 0)))
    if (v4:Dot(a1.Side)) < 0 then
        v4 = -v4
    end
    if not HeroLion then
        v2 = v1 + Vector3.new(0, 6, 0)
    else
        local Pivot = HeroLion.Model:GetPivot()
        v2 = Pivot.Position + Pivot.LookVector * 5.04 + Vector3.new(0, 1, 0) * ((HeroLion.Height or 6) * 0.42)
    end
    local v5 = whaleFocus(a1)
    return {
        {
            T = -1,
            Fov = 62,
            At = Center + a1.Side * 70 + Vector3.new(0, 36, 0),
            Look = Center + Vector3.new(0, 2, 0),
        },
        {
            T = 0,
            Fov = 62,
            At = Center + a1.Side * 64 + Vector3.new(0, 32, 0),
            Look = Center + Vector3.new(0, 2, 0),
        },
        {
            T = 1.7,
            Fov = 60,
            At = v1 + v4 * 32 - v3 * 4 + Vector3.new(0, 13, 0),
            Look = v1 + Vector3.new(0, 5, 0),
        },
        {
            T = 3.3,
            Fov = 56,
            At = v1 + v4 * 23 + v3 * 11 + Vector3.new(0, 5, 0),
            Look = v2 - Vector3.new(0, 2, 0),
        },
        {
            T = 4.4,
            Fov = 58,
            At = v1 + v4 * 26 + v3 * 24 + Vector3.new(0, 12, 0),
            Look = v2:Lerp(Center, 0.65),
        },
        {
            T = 5.4,
            Fov = 64,
            At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -0.25)):VectorToWorldSpace(a1.Side) * 34 + Vector3.new(0, 46, 0),
            Look = Center,
        },
        {
            T = 6.8,
            Fov = 66,
            At = Center + a1.Side * 50 + Vector3.new(0, 22, 0),
            Look = v5:Lerp(Center, 0.3),
        },
        {
            T = 8.2,
            Fov = 60,
            At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.1)):VectorToWorldSpace(a1.Side) * 47 + Vector3.new(0, 16, 0),
            Look = Center,
        },
        {
            T = 10.4,
            Fov = 56,
            At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.5)):VectorToWorldSpace(a1.Side) * 43 + Vector3.new(0, 15, 0),
            Look = Center,
        },
        {
            T = 12.6,
            Fov = 52,
            At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0.85)):VectorToWorldSpace(a1.Side) * 37 + Vector3.new(0, 12, 0),
            Look = Center + Vector3.new(0, 1, 0),
        },
        {
            T = 15,
            Fov = 45,
            At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 1.05)):VectorToWorldSpace(a1.Side) * 25 + Vector3.new(0, 7, 0),
            Look = Center + Vector3.new(0, 2.5, 0),
        },
        {
            T = 17,
            Fov = 44,
            At = Center + (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 1.15)):VectorToWorldSpace(a1.Side) * 22 + Vector3.new(0, 6, 0),
            Look = Center + Vector3.new(0, 3, 0),
        },
    }
end

local function samplePath(a1, a2) -- Line: 2065 -- upvalues: pathKeys (val), Kit (val) -- types: a2: number
    local v1 = pathKeys(a1)
    local v2 = 2
    while v2 < #v1 - 2 do
        if not (v1[v2 + 1].T < a2) then
            break
        end
        v2 = v2 + 1
    end
    local v3 = v1[v2 - 1]
    local v4 = v1[v2]
    local v5 = v1[v2 + 1]
    local v6 = v1[v2 + 2]
    v2 = Kit.Clamp01((a2 - v4.T) / (v5.T - v4.T))
    v1 = Kit.Smooth(v2) * 0.35 + v2 * 0.65
    local At = v3.At
    local At_2 = v4.At
    local At_3 = v5.At
    local At_4 = v6.At
    local v7 = v1 * v1
    local v8 = v1 * v1 * v1
    local v9 = (At_2 * 2 + (At_3 - At) * v1 + (At * 2 - At_2 * 5 + At_3 * 4 - At_4) * v7 + (At_2 * 3 - At - At_3 * 3 + At_4) * v8) * 0.5
    local Look = v3.Look
    local Look_2 = v4.Look
    local Look_3 = v5.Look
    local Look_4 = v6.Look
    v8 = v1 * v1
    local v10 = v1 * v1 * v1
    return v9, (Look_2 * 2 + (Look_3 - Look) * v1 + (Look * 2 - Look_2 * 5 + Look_3 * 4 - Look_4) * v8 + (Look_2 * 3 - Look - Look_3 * 3 + Look_4) * v10) * 0.5, Kit.Lerp(v4.Fov, v5.Fov, Kit.Smooth(v2))
end

local function payoffPath(a1, a2) -- Line: 2079 -- upvalues: Kit (val), u71 (val) -- types: a2: number
    local Center = a1.Center
    local PayoffFrom = a1.PayoffFrom
    local v1 = Kit.Smooth(Kit.Window(a2, 0, u71.Apex))
    local v2 = PayoffFrom + Kit.Flat(PayoffFrom - Center) * 10 * v1 + Vector3.new(0, 3, 0) * v1
    local v3 = (Center + Vector3.new(0, 3, 0)):Lerp(Center + Vector3.new(0, 20, 0), (Kit.Smooth((Kit.Window(a2, u71.Burst, u71.Apex)))))
    local v4 = Kit.Lerp(46, 60, v1)
    local MyEgg = a1.MyEgg
    if MyEgg then
        local Land = MyEgg.Land
        local v5 = Kit.Smooth(Kit.Window(a2, u71.Apex - 0.2, u71.Land + 0.2))
        local v6 = Land + Kit.Flat(Center - Land) * 7 + a1.Side * 24 + Vector3.new(0, 11, 0)
        local v7 = if not MyEgg.Position then Land else MyEgg.Position:Lerp(Land, 0.35)
        v2 = v2:Lerp(v6, v5)
        v3 = v3:Lerp(v7, v5)
        v4 = Kit.Lerp(v4, 58, v5)
    end
    return v2, v3, v4
end

function v1.Camera(a1, a2) -- Line: 2102
    -- upvalues: u98 (ref), payoffPath (val), samplePath (val), Kit (val)
    local v1 = u98
    if v1 and not v1.Dead and v1.Participant and v1.T then
        local v2, v3, v4, v5, v6, v7
        if not v1.PayoffAt then
            v5, v6, v7 = samplePath(v1, v1.T)
        else
            if not v1.PayoffFrom then
                local At = if not v1.Cam then v1.Center + v1.Side * 30 else v1.Cam.At
                v1.PayoffFrom = At
            end
            v5, v6, v7 = payoffPath(v1, v1.P or 0)
        end
        local Cam = v1.Cam
        if not Cam then
            v1.Cam = {At = v5, Look = v6, Fov = v7}
        end
        v6 = 1 - math.exp(-a2 * 4.5)
        Cam.At = Cam.At:Lerp(v2, v6)
        Cam.Look = Cam.Look:Lerp(v3, v6)
        Cam.Fov = Kit.Lerp(Cam.Fov, v4, v6)
        v6 = Kit.ReducedMotion()
        local ShakePower = if not v6 then v1.ShakePower else 0
        v3 = os.clock()
        v2 = Vector3.new(math.noise(v3 * 20, 1.3), math.noise(v3 * 20, 7.9), (math.noise(v3 * 20, 4.1))) * ShakePower
        v7 = math.noise(v3 * 13, 9.4) * 0.05585053606381855 * ShakePower
        v4 = (CFrame.lookAt(Cam.At + v2, Cam.Look)) * CFrame.Angles(0, 0, v7)
        return v4, (math.clamp(Cam.Fov + (if not v6 then v1.FovKick * 12 else 0), 30, 90))
    end
    return nil, nil
end

function v1.IsPlaying() -- Line: 2141 -- upvalues: u98 (ref)
    return u98 ~= nil
end

function v1.ActiveShrine() -- Line: 2145 -- upvalues: u98 (ref)
    if u98 then
        return u98.Shrine
    end
    return nil
end

function v1.IsResolving() -- Line: 2149 -- upvalues: u98 (ref)
    local v1 = false
    if u98 ~= nil then
        v1 = u98.PayoffAt ~= nil
    end
    return v1
end

function v1.FlightFocus() -- Line: 2153
    return nil
end

function v1.Begin(a1) -- Line: 2157
    -- upvalues: u98 (ref), finish (val), ShrineFusionFlags (val), Trove (val), Kit (val), Workspace (val)
    -- upvalues: startBed (val), buildSeal (val), buildPets (val), RunService (val), step (val)
    if u98 and u98.Shrine == a1.Shrine and not u98.Dead then
        if a1.Participant and not u98.Participant then
            u98.Participant = true
            u98.Gui = a1.Gui
        end
        return true
    end
    if u98 then
        finish(u98)
    end
    local Shrine = a1.Shrine
    local Pond = Shrine:FindFirstChild("Pond")
    if Pond and Pond:IsA("BasePart") then
        local Id = a1.Kind.Id
        local v1 = ShrineFusionFlags.ShrineRitualSeconds:Get()[Id] or ShrineFusionFlags.RitualSeconds:Get()
        local u44 = {ShakePower = 0, FovKick = 0}
        u44.Trove = Trove.new()
        u44.Shrine = Shrine
        u44.Kind = a1.Kind
        u44.Pads = a1.Pads
        u44.Seats = if type(a1.Seats) ~= "table" then nil else if not (#a1.Seats > 0) then nil else a1.Seats
        local Characters = a1.Characters or {}
        u44.Characters = Characters
        u44.Tier = a1.Tier
        local Recipe = a1.Recipe or (ShrineFusionFlags.Recipes:Get())[a1.Tier]
        u44.Recipe = Recipe
        u44.Fused = a1.FusedCategory
        u44.Participant = a1.Participant == true
        u44.Gui = a1.Gui
        u44.Center = Pond.Position + Vector3.new(0, 1, 0) * (Pond.Size.Y / 2)
        u44.Side = Kit.Flat(Pond.CFrame.LookVector)
        u44.StartAt = a1.EndsAt - v1
        u44.EndsAt = a1.EndsAt
        u44.Scale = v1 / 15
        u44.Fired = {}
        u44.Sounds = {}
        u44.Guards = {}
        u44.Highlights = {}
        u44.SealParts = {}
        u44.CoreParts = {}
        local Fused = u44.Fused or u44.Recipe and u44.Recipe.Fused
        u44.Fused = Fused
        local Parent = a1.Parent
        local v2 = Instance.new("Folder")
        v2.Name = "EnchantedFusion"
        v2.Parent = Parent or Workspace:FindFirstChild("Transient") or Workspace
        u44.Container = v2
        u44.Trove:Add(u44.Container)
        if not u44.Seats then
            for i, j in u44.Characters do
                u44.Guards[i] = (Kit.ToolGuard(j))
            end
        else
            for k, n in u44.Seats do
                u44.Guards[k] = (Kit.ToolGuard(n.Character))
            end
        end
        u98 = u44
        startBed(u44)
        buildSeal(u44)
        buildPets(u44)
        for m, i5 in u44.Pets do
            if i5.Kind == "Lion" and i5.Real then
                u44.HeroLion = i5
            end
        end
        local HeroLion = u44.HeroLion or u44.Pets[1]
        u44.HeroLion = HeroLion
        u44.Trove:Connect(RunService.RenderStepped, function(a1) -- Line: 2225 -- upvalues: step (upval), u44 (val), finish (upval)
            local success, err = pcall(step, u44, a1)
            if not success then
                warn("[EnchantedPond] step failed:", err)
                finish(u44)
            end
        end)
        return true
    end
    warn("[EnchantedPond] shrine needs a Pond part:", Shrine:GetFullName())
    return false
end

function v1.Payoff(a1) -- Line: 2235 -- upvalues: u98 (ref), Kit (val), makeEggs (val) -- types: a1: function?
    local v1 = u98
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

function v1.Settle(a1, a2) -- Line: 2256 -- upvalues: u98 (ref), setCleared (val) -- types: a1: userdata, a2: boolean
    if u98 and u98.Shrine == a1 then
        return
    end
    setCleared(a1, a2)
end

function v1.Cancel() -- Line: 2263 -- upvalues: u98 (ref), finish (val)
    if u98 then
        finish(u98)
    end
end

return (table.freeze(v1))