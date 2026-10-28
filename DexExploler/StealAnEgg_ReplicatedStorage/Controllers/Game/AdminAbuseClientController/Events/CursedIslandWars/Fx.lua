-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.Fx
-- Decompile time: 71.77 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local CursedIslandWars = require(ReplicatedStorage.Data.CursedIslandWars)
local CursedIslandWarsFlags = require(ReplicatedStorage.Shared.Flags.CursedIslandWarsFlags)
local State = require(script.Parent.State)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Assets = CursedIslandWars.Assets
local VFX = Assets.VFX
local UI = Assets.UI
local Sounds = ReplicatedStorage.Assets.Sounds
local u56 = Color3.fromRGB(190, 70, 255)
local u57 = {}
u57.Landmine = Color3.fromRGB(255, 140, 30)
u57.JumpPad = Color3.fromRGB(120, 255, 80)
local u72 = Color3.fromRGB(255, 214, 70)
local u73 = {Prep = true, Match = true, SuddenDeath = true}
local u75 = Trove.new()
local u76 = nil
local u77 = {}
local u78 = {}
local u79 = {}
local u80 = {}
local u81 = {}
local u82 = {}
local u83 = {}
local u84 = {}
local u85 = {}
local u86 = {}
local u87 = {}
local u91 = setmetatable({}, {__mode = "k"})
local u92 = {}
local u96 = setmetatable({}, {__mode = "k"})
local u97 = nil
local u98 = false
local u99 = 0
local u100 = nil
local u101 = nil
local u102 = false
local u103 = 0
local u104 = 0
local u106 = Random.new()
local u107 = {}

local function stage() -- Line: 84 -- upvalues: u76 (ref), Workspace (val)
    local v1 = u76
    if v1 and v1.Parent then
        return v1
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "CursedIslandWarsFx"
    Folder.Parent = Workspace
    u76 = Folder
    return Folder
end

local function holders(a1, a2) -- Line: 96 -- types: a1: userdata, a2: string
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

function u107.Burst(a1, a2) -- Line: 106 -- upvalues: holders (val) -- types: a1: userdata, a2: string
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

function u107.Loop(a1, a2, a3, a4) -- Line: 116
    -- upvalues: holders (val), u86 (val)
    local v1, v2 = a3, a4
    for i, j in holders(a1, a2) do
        for k, n in j:GetDescendants() do
            if not n:IsA("ParticleEmitter") or not (0 < n.Rate) then
                if n:IsA("ParticleEmitter") or n:IsA("Beam") or n:IsA("Trail") then
                    n.Enabled = v1
                    if v2 and n:IsA("ParticleEmitter") then
                        n:Clear()
                    end
                end
            elseif n.Rate < 4 then
                n.Enabled = false
                if not v1 then
                    if not v1 then
                        u86[n] = nil
                    end
                elseif u86[n] == nil then
                    n:Emit(1)
                    u86[n] = os.clock() + 1 / n.Rate
                elseif not v1 then
                    u86[n] = nil
                end
                if v2 then
                    n:Clear()
                end
            elseif n:IsA("ParticleEmitter") or n:IsA("Beam") or n:IsA("Trail") then
                n.Enabled = v1
                if v2 and n:IsA("ParticleEmitter") then
                    n:Clear()
                end
            end
        end
    end
end

local function stepSteady() -- Line: 140 -- upvalues: u86 (val)
    local v1 = os.clock()
    for i, j in u86 do
        if i.Parent == nil then
            u86[i] = nil
        elseif j <= v1 then
            i:Emit(1)
            u86[i] = v1 + 1 / math.max(i.Rate, 0.05)
        end
    end
end

function u107.Tint(a1, a2) -- Line: 152 -- types: a1: userdata, a2: CFrame
    for i, j in a1:GetDescendants() do
        if j:GetAttribute("TeamTint") then
            if j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Trail") then
                j.Color = ColorSequence.new(a2)
            end
        end
    end
end

function u107.Anchored(a1, a2, a3) -- Line: 160
    -- upvalues: u107 (val), u76 (ref), Workspace (val)
    local v1
    local v2 = a1:Clone()
    v2:PivotTo(a2)
    if a3 then
        u107.Tint(v2, a3)
    end
    local v3 = u76
    if not v3 or not v3.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v3
    end
    v2.Parent = v1
    return v2
end

function u107.Welded(a1, a2, a3, a4) -- Line: 170
    -- upvalues: u107 (val)
    local v1 = a1:Clone()
    v1:PivotTo(a3 or a2.CFrame)
    if a4 then
        u107.Tint(v1, a4)
    end
    local Root = v1.Root
    Root.Anchored = false
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = Root
    WeldConstraint.Part1 = a2
    WeldConstraint.Parent = Root
    v1.Parent = a2
    return v1
end

function u107.Once(a1, a2, a3, a4, a5) -- Line: 186
    -- upvalues: u107 (val), Debris (val)
    local v1 = u107.Anchored(a1, a3, a5)
    for i, j in a2 do
        u107.Burst(v1, j)
    end
    Debris:AddItem(v1, a4 + 0.3)
    return v1
end

function u107.Sound(a1, a2, a3, a4) -- Line: 195
    -- upvalues: Audio (val)
    Audio.Play(a1, a2, {PlaybackSpeed = a3, Volume = a4})
end

function u107.Ui(a1, a2, a3) -- Line: 199
    -- upvalues: Audio (val), Workspace (val)
    Audio.Play(a1, Workspace.CurrentCamera, {PlaybackSpeed = a2, Volume = a3})
end

local function teamColor(a1) -- Line: 203 -- upvalues: CursedIslandWars (val)
    return CursedIslandWars.Teams[a1].FxColor
end

local function fling(a1, a2, a3) -- Line: 207
    -- upvalues: u76 (ref), Workspace (val), u106 (val), TweenService (val), Debris (val)
    local v1
    a1.Anchored = false
    a1.CanCollide = false
    a1.CanQuery = false
    a1.CanTouch = false
    local v2 = u76
    if not v2 or not v2.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v2
    end
    a1.Parent = v1
    a1.AssemblyLinearVelocity = a2
    a1.AssemblyAngularVelocity = u106:NextUnitVector() * 10
    TweenService:Create(a1, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, a3 - 0.4), {Transparency = 1}):Play()
    Debris:AddItem(a1, a3)
end

local function neon(a1, a2, a3, a4) -- Line: 221
    -- upvalues: u76 (ref), Workspace (val)
    local v1
    local Part = Instance.new("Part")
    Part.Material = Enum.Material.Neon
    Part.Color = a4
    Part.Size = a1
    Part.CFrame = a2
    Part.Transparency = a3
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    local v2 = u76
    if not v2 or not v2.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v2
    end
    Part.Parent = v1
    return Part
end

local function ripple(a1, a2, a3, a4, a5) -- Line: 238
    -- upvalues: u76 (ref), Workspace (val), TweenService (val), Debris (val)
    local v1
    local v2 = Vector3.new(0.2, a3, a3)
    local v3 = a1 * CFrame.Angles(0, 0, 1.5707963267948966)
    local v4 = Instance.new("Part")
    v4.Material = Enum.Material.Neon
    v4.Color = a2
    v4.Size = v2
    v4.CFrame = v3
    v4.Transparency = 0.3
    v4.Anchored = true
    v4.CanCollide = false
    v4.CanQuery = false
    v4.CanTouch = false
    v4.CastShadow = false
    local v5 = u76
    if not v5 or not v5.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v5
    end
    v4.Parent = v1
    v4.Shape = Enum.PartType.Cylinder
    TweenService:Create(
        v4,
        TweenInfo.new(a5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 1, Size = Vector3.new(0.2, a4, a4)}
    ):Play()
    Debris:AddItem(v4, a5)
end

function u107.Launch(a1, a2, a3, a4, a5) -- Line: 250
    -- upvalues: Assets (val), u76 (ref), Workspace (val), u107 (val), VFX (val), CursedIslandWars (val), u77 (val)
    -- upvalues: Sounds (val)
    local v1
    local v2 = Assets.Projectiles.Pumpkin:Clone()
    v2:PivotTo((CFrame.lookAt(a2, a2 + a3)))
    local v3 = u76
    if not v3 or not v3.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v3
    end
    v2.Parent = v1
    local Body = v2.Body
    u107.Loop(u107.Welded(VFX.V4_PumpkinTrail, Body, Body.Trail.WorldCFrame, CursedIslandWars.Teams[a5].FxColor), "Trail", true)
    u77[a1] = {
        Model = v2,
        Position = a2,
        Velocity = a3,
        Stepped = a4,
        Launched = a4,
    }
    u107.Sound(Sounds.ScrambleBoss.Swoosh, a2, 0.7, 1)
end

function u107.Lock(a1, a2, a3) -- Line: 262 -- upvalues: u77 (val) -- types: a1: string, a2: vector, a3: userdata?
    local v1 = u77[a1]
    if v1 then
        v1.Velocity = a2
        v1.Target = a3
    end
end

function u107.Land(a1) -- Line: 270 -- upvalues: u77 (val) -- types: a1: string
    local v1 = u77[a1]
    u77[a1] = nil
    if v1 then
        v1.Model:Destroy()
    end
end

local function stepFlights() -- Line: 278
    -- upvalues: State (val), CursedIslandWarsFlags (val), u77 (val), u107 (val), CursedIslandWars (val)
    local Target, v1, v2
    local v3 = State.Now()
    local v4 = (CursedIslandWarsFlags.LauncherRange:Get()) / CursedIslandWarsFlags.LauncherSpeed:Get()
    local v5 = math.rad((CursedIslandWarsFlags.LauncherTurnRate:Get()))
    local v6 = nil
    local v7 = nil
    for i, j in u77, v6, v7 do
        v1 = v3 - j.Launched
        if not (v4 + 0.5 < v1) then
            v2 = v3 - j.Stepped
            if v2 > 0 then
                j.Stepped = v3
                j.Position = j.Position + j.Velocity * v2
                Target = j.Target
                if Target and Target.Parent then
                    j.Velocity = CursedIslandWars.Steer(j.Velocity, j.Position, Target.Position, v5 * v2)
                end
            end
            j.Model:PivotTo((CFrame.lookAt(j.Position, j.Position + j.Velocity)) * (CFrame.Angles(0, 0, v1 * 9)))
        else
            u107.Land(i)
        end
    end
end

local function scaleFx(a1, a2) -- Line: 302 -- types: a1: userdata, a2: number
    local new, v1, v2
    local v3 = a2
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v1 = {}
            for k, n in j.Size.Keypoints do
                table.insert(v1, (NumberSequenceKeypoint.new(n.Time, n.Value * v3, n.Envelope * v3)))
            end
            j.Size = NumberSequence.new(v1)
            new = NumberRange.new
            v2 = j.Speed.Min * v3
            j.Speed = new(v2, j.Speed.Max * v3)
        elseif j:IsA("BasePart") then
            j.Size = j.Size * v3
        end
    end
end

function u107.Explode(a1, a2) -- Line: 317
    -- upvalues: u107 (val), VFX (val), scaleFx (val), CursedIslandWarsFlags (val), Debris (val), Sounds (val)
    -- upvalues: u106 (val)
    if a1 ~= "Pumpkin" then
        u107.Once(VFX.V5_Landmine, {"Burst", "Linger"}, CFrame.new(a2), 2.2)
        u107.Sound(Sounds.Explosion, a2, u106:NextNumber(0.95, 1.05), 1)
        return
    end
    local v1 = u107.Anchored(VFX.V4_PumpkinImpact, CFrame.new(a2))
    scaleFx(v1, CursedIslandWarsFlags.LauncherRadius:Get() / 8)
    u107.Burst(v1, "Impact")
    Debris:AddItem(v1, 1.1)
    u107.Sound(Sounds.ImpactBoom, a2, u106:NextNumber(1.25, 1.45), 0.6)
end

function u107.Mine(a1, a2) -- Line: 332
    -- upvalues: CursedIslandWars (val), u107 (val), VFX (val), Sounds (val), u84 (val), CursedIslandWarsFlags (val)
    if a1 == nil then
        return
    end
    local Body = a1.Body
    local WorldCFrame = Body.Base.WorldCFrame
    local FxColor = CursedIslandWars.Teams[a2].FxColor
    u107.Once(VFX.V5_Landmine, {"Arm"}, WorldCFrame, 0.7, FxColor)
    u107.Sound(Sounds.ScrambleBoss.Tick, Body, 1.3, 0.8)
    local u35 = u107.Welded(VFX.V5_Landmine, Body, WorldCFrame, FxColor)
    u84[a1] = {Tripped = false, Fx = u35, Glow = a1.Glow}
    task.delay(CursedIslandWarsFlags.MineArmSeconds:Get(), function() -- Line: 343 -- upvalues: u84 (upval), a1 (val), u35 (val), u107 (upval)
        local v1 = u84[a1]
        if v1 and v1.Fx == u35 and not v1.Tripped then
            u107.Loop(u35, "Armed", true)
        end
    end)
end

function u107.MineTrigger(a1) -- Line: 351 -- upvalues: u84 (val), u107 (val), Sounds (val) -- types: a1: userdata?
    local v1
    if (if not a1 then nil else u84[a1]) == nil then
        return
    end
    v1.Tripped = true
    u107.Loop(v1.Fx, "Armed", false, true)
    u107.Burst(v1.Fx, "Trigger")
    u107.Sound(Sounds.ScrambleBoss.TargetLock, v1.Glow, 1.2, 1)
end

local function stepMines() -- Line: 363 -- upvalues: u84 (val)
    local v1 = os.clock()
    local v2 = nil
    local v3 = nil
    for i, j in u84, v2, v3 do
        if i.Parent ~= nil then
            j.Glow.Transparency = if not (0 < (math.sin(v1 * (if not j.Tripped then 5 else 40)))) then 0.7 else 0
        else
            u84[i] = nil
        end
    end
end

function u107.Built(a1, a2) -- Line: 376
    -- upvalues: u107 (val), VFX (val), CursedIslandWars (val), Sounds (val), u106 (val)
    local Pop, Sound, v1
    for i, j in a1 do
        u107.Once(VFX.V6_Brick, {"Build"}, j, 0.9, CursedIslandWars.Teams[a2].FxColor)
        if i == 1 then
            Sound = u107.Sound
            Pop = Sounds.ScrambleBoss.Pop
            v1 = u106:NextNumber(1.3, 1.6)
            Sound(Pop, j, v1, 0.7)
        end
    end
end

function u107.Bricks(a1) -- Line: 385
    -- upvalues: u107 (val), VFX (val), Sounds (val), u106 (val), Assets (val), u99 (ref), fling (val)
    local v1, v2
    local v3 = false
    local v4 = nil
    local v5 = nil
    for i, j in a1, v4, v5 do
        v1 = j[1]
        v2 = j[2]
        if v1 ~= "Crack" then
            u107.Once(VFX.V6_Brick, {"Break"}, v2, 0.9)
            if not v3 then
                u107.Sound(Sounds.BeanstalkEvent.WhaleRockHit, v2, u106:NextNumber(1.1, 1.3), 0.8)
            end
            for k, n in Assets.BrickDebris:GetChildren() do
                if u99 >= 80 then
                    break
                end
                u99 = u99 + 1
                v1 = n:Clone()
                v1.CFrame = v2 * CFrame.new(u106:NextNumber(-1, 1), u106:NextNumber(-1, 1), u106:NextNumber(-1, 1))
                fling(v1, ((u106:NextUnitVector()) + Vector3.new(0, 1, 0)) * u106:NextNumber(18, 32), 2.2)
                task.delay(2.2, function() -- Line: 406 -- upvalues: u99 (upval)
                    u99 = u99 - 1
                end)
            end
        else
            u107.Once(VFX.V6_Brick, {"Crack"}, v2, 0.9)
        end
    end
end

function u107.Pad(a1, a2) -- Line: 415
    -- upvalues: u107 (val), VFX (val), CursedIslandWars (val), u83 (val), u75 (ref)
    if a1 == nil then
        return
    end
    local Base = a1.Base
    local v1 = u107.Welded(VFX.V7_JumpPad, Base, Base.Launch.WorldCFrame, CursedIslandWars.Teams[a2].FxColor)
    u107.Loop(v1, "Loop", true)
    u83[a1] = v1
    u75:Add((a1.Destroying:Connect(function() -- Line: 423 -- upvalues: u83 (upval), a1 (val)
        u83[a1] = nil
    end)))
end

function u107.PadLaunch(a1, a2, a3) -- Line: 428
    -- upvalues: u83 (val), u107 (val), TweenService (val), Sounds (val), u106 (val), VFX (val), CursedIslandWars (val)
    -- upvalues: Debris (val)
    local CFrame, v1, v2
    if a1 == nil then
        return
    end
    local v3 = u83[a1]
    if v3 then
        u107.Burst(v3, "Launch")
    end
    local Plate = a1.Plate
    local v4 = a1:GetPivot().UpVector * -0.25
    for i, j in {Plate, a1.Chevrons} do
        CFrame = j.CFrame
        j.CFrame = CFrame + v4
        v1 = TweenService
        v2 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        v1:Create(j, v2, {CFrame = CFrame}):Play()
    end
    u107.Sound(Sounds.BeanstalkEvent.TrampolineJump, Plate, u106:NextNumber(0.95, 1.1), 1)
    local HumanoidRootPart = if not a2 then nil else a2:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        local u64 = u107.Welded(VFX.V7_Airborne, HumanoidRootPart, nil, CursedIslandWars.Teams[a3].FxColor)
        u107.Loop(u64, "Airborne", true)
        task.delay(2.4, function() -- Line: 448 -- upvalues: u107 (upval), u64 (val), Debris (upval)
            u107.Loop(u64, "Airborne", false)
            Debris:AddItem(u64, 0.5)
        end)
    end
end

function u107.PadLand(a1) -- Line: 455 -- upvalues: u107 (val), VFX (val), Sounds (val) -- types: a1: vector
    u107.Once(VFX.V7_JumpPad, {"Land"}, CFrame.new(a1), 1)
    u107.Sound(Sounds.ScrambleBoss.HeavyLand, a1, 1.3, 0.4)
end

function u107.Hit(a1) -- Line: 462 -- upvalues: u107 (val), VFX (val), Sounds (val), u106 (val) -- types: a1: userdata?
    local HumanoidRootPart = if not a1 then nil else a1:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        u107.Once(VFX.V9_PlayerFX, {"HitSpark"}, HumanoidRootPart.CFrame, 0.95)
        u107.Sound(Sounds.ScrambleBoss.BatHit, HumanoidRootPart, u106:NextNumber(1.1, 1.3), 0.6)
    end
end

function u107.Knockout(a1) -- Line: 470 -- upvalues: u107 (val), VFX (val), Sounds (val) -- types: a1: vector?
    if a1 then
        u107.Once(VFX.V9_PlayerFX, {"Knockout"}, CFrame.new(a1), 0.95)
        u107.Sound(Sounds.ScrambleBoss.Swoosh, a1, 0.55, 1.2)
    end
end

function u107.EndShield(a1) -- Line: 477 -- upvalues: u81 (val), u107 (val), Debris (val) -- types: a1: string
    local v1 = u81[a1]
    u81[a1] = nil
    if v1 then
        u107.Loop(v1, "Shell", false, true)
        Debris:AddItem(v1, 0.5)
    end
end

function u107.Respawn(a1, a2, a3, a4) -- Line: 486
    -- upvalues: u107 (val), VFX (val), CursedIslandWars (val), Sounds (val), u81 (val), CursedIslandWarsFlags (val)
    local HumanoidRootPart
    u107.Once(VFX.V10_RespawnBurst, {"Burst"}, a2 * CFrame.new(0, -4, 0), 0.9, CursedIslandWars.Teams[a4].FxColor)
    u107.Sound(Sounds.MountRace.Respawn, a2.Position, 1, 0.8)
    if (if not a3 then nil else a3:FindFirstChild("HumanoidRootPart")) == nil then
        return
    end
    u107.EndShield(a1)
    local u53 = u107.Welded(VFX.V10_SpawnShell, HumanoidRootPart, nil, CursedIslandWars.Teams[a4].FxColor)
    u107.Loop(u53, "Shell", true)
    u81[a1] = u53
    task.delay(CursedIslandWarsFlags.SpawnShieldSeconds:Get(), function() -- Line: 497 -- upvalues: u81 (upval), a1 (val), u53 (val), u107 (upval)
        if u81[a1] == u53 then
            u107.EndShield(a1)
        end
    end)
end

local function refreshSkulls() -- Line: 504 -- upvalues: State (val), u82 (val), u107 (val), VFX (val)
    local HumanoidRootPart, v1, v2
    local Snapshot = State.Snapshot
    local v3 = {}
    if Snapshot then
        local v4
        for i, j in Snapshot.Entries do
            v4 = Snapshot.Crystals[j.Team]
            if j.State == "Alive" and v4 and v4.Health <= 0 and j.Model then
                v3[j.Id] = j.Model
            end
        end
    end
    local v5 = nil
    local v6 = nil
    for k, n in u82, v5, v6 do
        v1 = v3[k]
        if v1 == nil or n.Parent == nil or not n:IsDescendantOf(v1) then
            n:Destroy()
            u82[k] = nil
        end
    end
    for m, i5 in v3 do
        HumanoidRootPart = i5:FindFirstChild("HumanoidRootPart")
        if u82[m] == nil and HumanoidRootPart then
            v2 = u107.Welded(VFX.V9_PlayerFX, HumanoidRootPart)
            u107.Loop(v2, "LastLife", true)
            u82[m] = v2
        end
    end
end

local function mountCrystal(a1, a2) -- Line: 534
    -- upvalues: u78 (val), u107 (val), VFX (val), CursedIslandWars (val), u98 (ref)
    local v1 = u78[a1]
    if v1 and v1.Model == a2 then
        return
    end
    local Pivot = a2.Crystal.Pivot
    local v2 = u107.Welded(VFX.V8_CursedCrystal, Pivot, Pivot.CFrame, CursedIslandWars.Teams[a1].FxColor)
    u107.Loop(v2, "Loop", true)
    u107.Loop(v2, "Pillar", u98)
    u78[a1] = {Model = a2, Pivot = Pivot, Base = Pivot.CFrame, Fx = v2}
end

function u107.Pillars(a1) -- Line: 546 -- upvalues: u98 (ref), u78 (val), u107 (val) -- types: a1: boolean
    if u98 == a1 then
        return
    end
    u98 = a1
    for i, j in u78 do
        u107.Loop(j.Fx, "Pillar", a1)
    end
end

local function stepCrystals() -- Line: 556 -- upvalues: u78 (val)
    local v1 = os.clock()
    for i, j in u78 do
        if j.Pivot.Parent then
            j.Pivot.CFrame = j.Base * CFrame.new(0, math.sin(v1 * 1.4) * 0.6, 0) * CFrame.Angles(0, v1 * 0.5, 0)
        end
    end
end

function u107.CrystalHit(a1, a2) -- Line: 565 -- upvalues: u78 (val), u107 (val), Sounds (val) -- types: a2: number
    local v1 = u78[a1]
    if v1 == nil then
        return
    end
    u107.Burst(v1.Fx, "Hit")
    u107.Sound(Sounds.ScrambleBoss.GlassCrack, v1.Pivot, a2 * 0.7 + 0.8, 0.35)
end

function u107.CrystalStage(a1, a2) -- Line: 574
    -- upvalues: u78 (val), u107 (val), CursedIslandWars (val), fling (val), u106 (val), Sounds (val)
    local v1 = u78[a1]
    if v1 == nil then
        return
    end
    u107.Burst(v1.Fx, "Stage")
    local v2 = v1.Model.Crystal.Shell:FindFirstChild((("Chunk%*"):format((math.floor(CursedIslandWars.Tuning.Crystal.Stages[a2] * 100)))))
    if v2 then
        local v3 = v2:Clone()
        v3:ClearAllChildren()
        v3.Transparency = 0.3
        fling(v3, ((u106:NextUnitVector()) + Vector3.new(0, 1.5, 0)) * 25, 2.5)
    end
    u107.Sound(Sounds.BossEventSounds["Crystal Break SFX"], v1.Pivot, 1.3, 0.5)
end

function u107.CrystalShattered(a1) -- Line: 591
    -- upvalues: u78 (val), u107 (val), Sounds (val), u106 (val), fling (val)
    local u2 = u78[a1]
    if u2 == nil then
        return
    end
    u78[a1] = nil
    u107.Loop(u2.Fx, "Loop", false, true)
    u107.Loop(u2.Fx, "Pillar", false)
    u107.Burst(u2.Fx, "Implode")
    task.delay(0.32, function() -- Line: 600 -- upvalues: u107 (upval), u2 (val), Sounds (upval), u106 (upval), fling (upval)
        local Unit, v1, v2
        u107.Burst(u2.Fx, "Shatter")
        u107.Loop(u2.Fx, "Dead", true)
        u107.Sound(Sounds.BossEventSounds["Crystal Break SFX"], u2.Pivot, 0.9, 1)
        u107.Sound(Sounds.CinematicBoom, u2.Pivot, 1, 4)
        for i, j in u2.Model.Crystal:GetDescendants() do
            if j:IsA("BasePart") then
                if j.Name == "Core" or j.Parent and j.Parent.Name == "Shell" then
                    v1 = j:Clone()
                    v1:ClearAllChildren()
                    v1.Transparency = if j.Name ~= "Core" then 0.3 else 0
                    v2 = j.Position - u2.Pivot.Position
                    Unit = if not (0.1 < v2.Magnitude) then u106:NextUnitVector() else v2.Unit
                    fling(v1, (Unit + Vector3.new(0, 0.6000000238418579, 0)) * u106:NextNumber(40, 70), 2.5)
                end
            end
        end
    end)
end

local function upright(a1) -- Line: 621 -- types: a1: vector
    return (CFrame.new(a1)) * CFrame.Angles(0, 0, 1.5707963267948966)
end

function u107.PickupDrop(a1, a2) -- Line: 625
    -- upvalues: u57 (val), u76 (ref), Workspace (val), TweenService (val), ripple (val), u107 (val), VFX (val)
    -- upvalues: Sounds (val), Debris (val)
    local v1
    if a2 == nil then
        return
    end
    local u3 = u57[a1]
    local Position = a2:GetPivot().Position
    local v2 = (CFrame.new(Position + Vector3.new(0, 120, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    local u22 = Instance.new("Part")
    u22.Material = Enum.Material.Neon
    u22.Color = u3
    u22.Size = Vector3.new(80, 6, 6)
    u22.CFrame = v2
    u22.Transparency = 0.1
    u22.Anchored = true
    u22.CanCollide = false
    u22.CanQuery = false
    u22.CanTouch = false
    u22.CastShadow = false
    local v3 = u76
    if not v3 or not v3.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v3
    end
    u22.Parent = v1
    u22.Shape = Enum.PartType.Cylinder
    TweenService:Create(u22, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        CFrame = (CFrame.new(Position + Vector3.new(0, 40, 0))) * CFrame.Angles(0, 0, 1.5707963267948966),
    }):Play()
    task.delay(0.22, function() -- Line: 636
        -- upvalues: TweenService (upval), u22 (val), ripple (upval), Position (val), u3 (val), u107 (upval)
        -- upvalues: VFX (upval), Sounds (upval)
        TweenService:Create(
            u22,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = Vector3.new(80, 0.20000000298023224, 0.20000000298023224),
                Transparency = 1,
            }
        ):Play()
        ripple(CFrame.new(Position - Vector3.new(0, 2.5, 0)), u3, 4, 30, 0.6)
        u107.Once(VFX.V10_RespawnBurst, {"Burst"}, CFrame.new(Position), 1.5, u3)
        u107.Sound(Sounds.ScrambleBoss.Pop, Position, 0.8, 1)
    end)
    Debris:AddItem(u22, 0.7)
end

function u107.PickupTaken(a1, a2) -- Line: 648
    -- upvalues: u57 (val), ripple (val), u76 (ref), Workspace (val), TweenService (val), Debris (val), u107 (val)
    -- upvalues: VFX (val), Sounds (val)
    local v1
    local v2 = u57[a1]
    ripple(CFrame.new(a2 - Vector3.new(0, 2.5, 0)), v2, 4, 22, 0.45)
    local v3 = (CFrame.new(a2 + Vector3.new(0, 12, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    local v4 = Instance.new("Part")
    v4.Material = Enum.Material.Neon
    v4.Color = v2
    v4.Size = Vector3.new(30, 5, 5)
    v4.CFrame = v3
    v4.Transparency = 0.2
    v4.Anchored = true
    v4.CanCollide = false
    v4.CanQuery = false
    v4.CanTouch = false
    v4.CastShadow = false
    local v5 = u76
    if not v5 or not v5.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v5
    end
    v4.Parent = v1
    v4.Shape = Enum.PartType.Cylinder
    TweenService:Create(
        v4,
        TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = Vector3.new(30, 0.20000000298023224, 0.20000000298023224), Transparency = 1}
    ):Play()
    Debris:AddItem(v4, 0.4)
    u107.Once(VFX.V7_JumpPad, {"Land"}, CFrame.new(a2), 1)
    u107.Sound(Sounds.ScrambleBoss.Pop, a2, 1.4, 0.8)
end

local function mountPickup(a1, a2) -- Line: 662
    -- upvalues: u57 (val), State (val), Workspace (val), u76 (ref), TweenService (val), UI (val)
    -- upvalues: CursedIslandWars (val)
    local Folder_4, Part, v1, v2, v3, v4
    local v5 = u57[a1.Name]
    local v6 = RaycastParams.new()
    v6.FilterType = Enum.RaycastFilterType.Include
    v6.FilterDescendantsInstances = {(State.Island())}
    local v7 = Workspace:Raycast(a2.Position, Vector3.new(-0, -12, -0), v6)
    v6 = CFrame.new(if not v7 then a2.Position - Vector3.new(0, 3, 0) else v7.Position)
    local Model = Instance.new("Model")
    Model.Name = ("%*Look"):format(a1.Name)
    local v8 = u76
    if not v8 or not v8.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v3 = Folder
    else
        v3 = v8
    end
    Model.Parent = v3
    v8 = (CFrame.new(v6.Position + Vector3.new(0, 18, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    v3 = Instance.new("Part")
    v3.Material = Enum.Material.Neon
    v3.Color = v5
    v3.Size = Vector3.new(36, 0.800000011920929, 0.800000011920929)
    v3.CFrame = v8
    v3.Transparency = 0.6
    v3.Anchored = true
    v3.CanCollide = false
    v3.CanQuery = false
    v3.CanTouch = false
    v3.CastShadow = false
    local v9 = u76
    if not v9 or not v9.Parent then
        local Folder_2 = Instance.new("Folder")
        Folder_2.Name = "CursedIslandWarsFx"
        Folder_2.Parent = Workspace
        u76 = Folder_2
        v4 = Folder_2
    else
        v4 = v9
    end
    v3.Parent = v4
    v3.Shape = Enum.PartType.Cylinder
    v3.Parent = Model
    TweenService:Create(v3, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.85}):Play()
    v8 = (CFrame.new(v6.Position + Vector3.new(0, 0.15000000596046448, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    v3 = Instance.new("Part")
    v3.Material = Enum.Material.Neon
    v3.Color = v5
    v3.Size = Vector3.new(0.20000000298023224, 9, 9)
    v3.CFrame = v8
    v3.Transparency = 0.55
    v3.Anchored = true
    v3.CanCollide = false
    v3.CanQuery = false
    v3.CanTouch = false
    v3.CastShadow = false
    v9 = u76
    if not v9 or not v9.Parent then
        local Folder_3 = Instance.new("Folder")
        Folder_3.Name = "CursedIslandWarsFx"
        Folder_3.Parent = Workspace
        u76 = Folder_3
        v4 = Folder_3
    else
        v4 = v9
    end
    v3.Parent = v4
    v3.Shape = Enum.PartType.Cylinder
    v3.Parent = Model
    v8 = {}
    local v10, v11 = a2, a1
    for i = 1, 6 do
        Part = Instance.new("Part")
        Part.Material = Enum.Material.Neon
        Part.Color = v5
        Part.Size = Vector3.new(1.399999976158142, 0.30000001192092896, 0.5)
        Part.CFrame = v6
        Part.Transparency = 0.1
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CastShadow = false
        v2 = u76
        if not v2 or not v2.Parent then
            Folder_4 = Instance.new("Folder")
            Folder_4.Name = "CursedIslandWarsFx"
            Folder_4.Parent = Workspace
            u76 = Folder_4
            v1 = Folder_4
        else
            v1 = v2
        end
        Part.Parent = v1
        Part.Parent = Model
        v8[i] = Part
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = v3
    Attachment.WorldPosition = v10.Position + Vector3.new(0, 1, 0) * (v11:GetExtentsSize().Y / 2 + 5)
    v3 = UI.PickupMarker:Clone()
    v3.Title.Text = string.upper(CursedIslandWars.ToolNames[v11.Name])
    v3.Title.TextColor3 = v5
    v3.Adornee = Attachment
    v3.Parent = Attachment
    local Highlight = Instance.new("Highlight")
    Highlight.Adornee = v11
    Highlight.FillColor = v5
    Highlight.FillTransparency = 0.55
    Highlight.OutlineColor = v5
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Parent = Model
    return {
        NextRipple = 0,
        Look = Model,
        Ground = v6,
        Marks = v8,
        Color = v5,
    }
end

local function stepPickups() -- Line: 705
    -- upvalues: u92 (val), u96 (val), State (val), u91 (val), mountPickup (val), ripple (val)
    local Pickups, v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    for i, j in u92, v5, v6 do
        if i.Parent == nil or u96[i] then
            u92[i] = nil
            j.Look:Destroy()
        end
    end
    local v7 = State.Island()
    if (if not v7 then nil else if not v7.Parent then nil else v7.Parent:FindFirstChild("Pickups")) == nil then
        return
    end
    v7 = os.clock()
    for k, n in Pickups:GetChildren() do
        if n:IsA("Model") and not u96[n] then
            v3 = u91[n]
            if v3 == nil then
                v3 = n:GetPivot()
                u91[n] = v3
            end
            v1 = v3 * CFrame.new(0, math.sin(v7 * 2 + v3.X) * 0.6, 0) * (CFrame.Angles(0, v7 * 1.5, 0))
            n:PivotTo(v1)
            v4 = u92[n]
            if v4 == nil then
                v4 = mountPickup(n, v3)
                u92[n] = v4
            end
            for m, i5 in v4.Marks do
                v2 = v4.Ground * CFrame.Angles(0, v7 * 2 + m * 3.141592653589793 * 2 / #v4.Marks, 0)
                i5.CFrame = v2 * CFrame.new(5.3, 0.3, 0)
            end
            if v4.NextRipple <= v7 then
                v4.NextRipple = v7 + 1.2
                ripple(v4.Ground * CFrame.new(0, 0.2, 0), v4.Color, 9, 21.599999999999998, 1.2)
            end
        end
    end
end

local function mountBarrier(a1, a2, a3) -- Line: 746
    -- upvalues: u79 (val), u107 (val), VFX (val), CursedIslandWars (val)
    local v1
    local v2 = u79[a1]
    if v2 and v2.Model == a2 then
        return
    end
    v2 = u107.Anchored(VFX.V13_CrystalBarrier, a2:GetPivot(), CursedIslandWars.Teams[a1].FxColor)
    u107.Loop(v2, "Loop", true)
    u107.Loop(v2, "Unstable", a3 <= 0.25)
    u79[a1] = {Model = a2, Fx = v2, Unstable = v1}
end

function u107.BarrierHit(a1, a2, a3) -- Line: 758
    -- upvalues: u79 (val), holders (val), u107 (val), Sounds (val)
    local v1 = u79[a1]
    if v1 == nil then
        return
    end
    holders(v1.Fx, "Hit")[1].WorldPosition = a3
    u107.Burst(v1.Fx, "Hit")
    if a2 <= 0.25 and not v1.Unstable then
        v1.Unstable = true
        u107.Loop(v1.Fx, "Unstable", true)
    end
    u107.Sound(Sounds.ScrambleBoss.GlassCrack, a3, a2 * 0.4 + 1, 0.4)
end

function u107.BarrierStage(a1, a2) -- Line: 772 -- upvalues: u79 (val), u107 (val), Sounds (val) -- types: a2: number
    local v1 = u79[a1]
    if v1 == nil then
        return
    end
    u107.Burst(v1.Fx, (("Break%*"):format(a2)))
    u107.Sound(Sounds.BossEventSounds["Crystal Break SFX"], v1.Model.Hitbox, 1.1, 0.6)
end

function u107.BarrierBroken(a1) -- Line: 781 -- upvalues: u79 (val), u107 (val), Debris (val), Sounds (val)
    local v1 = u79[a1]
    if v1 == nil then
        return
    end
    u79[a1] = nil
    u107.Loop(v1.Fx, "Loop", false, true)
    u107.Loop(v1.Fx, "Unstable", false, true)
    u107.Burst(v1.Fx, "Shatter")
    Debris:AddItem(v1.Fx, 4)
    local Hitbox = v1.Model.Hitbox
    u107.Sound(Sounds.CinematicBoom, Hitbox, 1.1, 3)
    u107.Sound(Sounds.ScrambleBoss.GlassCrack, Hitbox, 0.7, 2)
end

local function eyes() -- Line: 798 -- upvalues: State (val)
    local v1 = State.Island()
    local Parent = if not v1 then nil else v1.Parent
    v1 = if not Parent then nil else Parent:FindFirstChild("Pieces")
    if v1 then
        return (v1:FindFirstChild("SkyEyes"))
    end
    return nil
end

local function portalCrack(a1) -- Line: 805 -- types: a1: userdata
    return a1.Cloud.Crack
end

local function showFace(a1, a2) -- Line: 809 -- types: a1: userdata, a2: string
    local v1 = 0
    for i, j in a1.Cloud.Crack[a2]:GetChildren() do
        if j:IsA("ParticleEmitter") then
            j:Emit(1)
            v1 = math.max(v1, j.Lifetime.Max)
        end
    end
    return v1
end

local function clearFace(a1) -- Line: 820 -- types: a1: userdata
    local Crack = a1.Cloud.Crack
    local v1 = {Crack.EYES, Crack.EYES2}
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        for k, n in j:GetChildren() do
            if n:IsA("ParticleEmitter") then
                n:Clear()
            end
        end
    end
end

local function burstCrack(a1) -- Line: 831 -- types: a1: userdata
    local Attribute
    for i, j in a1.Cloud.Crack:GetChildren() do
        if j:IsA("ParticleEmitter") then
            Attribute = j:GetAttribute("EmitCount")
            j:Emit(Attribute or 1)
        end
    end
end

local function setPortal(a1, a2) -- Line: 839 -- upvalues: clearFace (val) -- types: a1: userdata, a2: boolean
    local Crack = a1.Cloud.Crack
    local v1 = {Crack, Crack.Portal}
    local v2 = nil
    local v3 = nil
    local v4, v5 = a2, a1
    for i, j in v1, v2, v3 do
        for k, n in j:GetChildren() do
            if n:IsA("ParticleEmitter") then
                n.Enabled = v4
            end
        end
    end
    if not v4 then
        clearFace(v5)
    end
end

local function getSkyPortalTemplate() -- Line: 854 -- upvalues: ReplicatedStorage (val)
    return ReplicatedStorage.CutsceneAssets.CursedIslandWarsCutsceneAssets.IntroCutscene.CursedIntroVFX.Crack.Cloud
end

local function mountPortal(a1) -- Line: 858
    -- upvalues: ReplicatedStorage (val), setPortal (val), u76 (ref), Workspace (val)
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Transparency = 1
        end
    end
    local Pivot = a1:GetPivot()
    local Model = Instance.new("Model")
    Model.Name = "SkyPortal"
    local v1 = ReplicatedStorage.CutsceneAssets.CursedIslandWarsCutsceneAssets.IntroCutscene.CursedIntroVFX.Crack.Cloud:Clone()
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    for k, n in v1:GetChildren() do
        if n:IsA("ParticleEmitter") then
            n:Destroy()
        end
    end
    local Crack = v1.Crack
    local v2 = {Crack.EYES, Crack.EYES2}
    local v3 = nil
    local v4 = nil
    for m, i5 in v2, v3, v4 do
        for i6, i7 in i5:GetChildren() do
            if i7:IsA("ParticleEmitter") then
                i7.Orientation = Enum.ParticleOrientation.FacingCamera
            end
        end
    end
    v1.CFrame = Pivot * v1.CFrame:ToObjectSpace(Crack.Portal.WorldCFrame):Inverse()
    v1.Parent = Model
    Model.WorldPivot = Pivot
    Model:ScaleTo(1.8)
    setPortal(Model, false)
    local v5 = u76
    if not v5 or not v5.Parent then
        v5 = Instance.new("Folder")
        v5.Name = "CursedIslandWarsFx"
        v5.Parent = Workspace
        u76 = v5
    end
    Model.Parent = v5
    return Model
end

function u107.Eyes(a1) -- Line: 894
    -- upvalues: u102 (ref), u101 (ref), setPortal (val), burstCrack (val), u103 (ref), u104 (ref), clearFace (val)
    -- upvalues: showFace (val)
    local v1 = u102
    u102 = a1 ~= "Closed"
    local v2 = u101
    if v2 == nil then
        return
    end
    if not u102 then
        setPortal(v2, false)
        return
    end
    if not v1 then
        setPortal(v2, true)
        burstCrack(v2)
        u103 = 0
    end
    v1 = os.clock()
    if a1 == "Flare" or a1 == "Narrow" and u104 <= v1 then
        clearFace(v2)
        u103 = v1 + showFace(v2, "EYES")
        u104 = u103 + 6
        if a1 == "Flare" then
            burstCrack(v2)
        end
    end
end

local function stepEyes() -- Line: 921 -- upvalues: u101 (ref), u102 (ref), u103 (ref), showFace (val)
    local v1 = u101
    if v1 ~= nil and u102 then
        local v2 = os.clock()
        if u103 <= v2 then
            u103 = v2 + showFace(v1, "EYES2")
        end
        return
    end
end

function u107.WallsOpen(a1) -- Line: 935
    -- upvalues: u56 (val), u76 (ref), Workspace (val), TweenService (val), u107 (val), Sounds (val), RunService (val)
    -- upvalues: u106 (val), u75 (ref), Debris (val), fling (val), VFX (val)
    local v1
    local Collision = a1.Collision
    local u2 = {}
    for i, j in a1:GetChildren() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            u2[j] = j.Transparency
        end
    end
    local CFrame = Collision.CFrame
    local Size = Collision.Size
    local v2 = Vector3.new(0.4, Size.Y, Size.Z)
    local v3 = u56
    local u27 = Instance.new("Part")
    u27.Material = Enum.Material.Neon
    u27.Color = v3
    u27.Size = v2
    u27.CFrame = CFrame
    u27.Transparency = 1
    u27.Anchored = true
    u27.CanCollide = false
    u27.CanQuery = false
    u27.CanTouch = false
    u27.CastShadow = false
    local v4 = u76
    if not v4 or not v4.Parent then
        local Folder = Instance.new("Folder")
        Folder.Name = "CursedIslandWarsFx"
        Folder.Parent = Workspace
        u76 = Folder
        v1 = Folder
    else
        v1 = v4
    end
    u27.Parent = v1
    TweenService:Create(u27, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 0.25}):Play()
    u107.Sound(Sounds.ScrambleBoss.Rumble, Collision, 1.6, 1.5)
    local u73 = os.clock()
    local u74 = nil
    u74 = RunService.RenderStepped:Connect(function() -- Line: 949 -- upvalues: u73 (val), u2 (val), u106 (upval), u74 (ref)
        local v1
        local v2 = 0.4 <= os.clock() - u73
        local v3 = nil
        local v4 = nil
        for i, j in u2, v3, v4 do
            v1 = if not v2 then if not ((u106:NextNumber()) < 0.5) then 0.85 else j else 1
            i.Transparency = v1
        end
        if v2 then
            u74:Disconnect()
        end
    end)
    u75:Add(u74)
    task.delay(0.4, function() -- Line: 959
        -- upvalues: TweenService (upval), u27 (val), Size (val), Debris (upval), u106 (upval), CFrame (val)
        -- upvalues: u56 (upval), u76 (upval), Workspace (upval), fling (upval), u107 (upval), VFX (upval)
        -- upvalues: Sounds (upval), Collision (val)
        local Folder, RightVector, v1, v2, v3, v4, v5, v6, v7
        TweenService:Create(
            u27,
            TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Transparency = 1, Size = Vector3.new(14, Size.Y * 1.05, Size.Z)}
        ):Play()
        Debris:AddItem(u27, 0.4)
        local v8 = Size.Y / 4
        local v9 = Size.Z / 24
        for i = 1, 4 do
            for j = 1, 24 do
                v6 = Vector3.new(0, (i - 0.5) * v8 - Size.Y / 2, (j - 0.5) * v9 - Size.Z / 2)
                v1 = Vector3.new(0.3, v8 * u106:NextNumber(0.4, 0.8), v9 * (u106:NextNumber(0.4, 0.8)))
                v2 = CFrame * CFrame.new(v6) * CFrame.Angles(u106:NextNumber(-0.6, 0.6), 0, u106:NextNumber(-0.6, 0.6))
                v3 = u56
                v7 = Instance.new("Part")
                v7.Material = Enum.Material.Neon
                v7.Color = v3
                v7.Size = v1
                v7.CFrame = v2
                v7.Transparency = 0.2
                v7.Anchored = true
                v7.CanCollide = false
                v7.CanQuery = false
                v7.CanTouch = false
                v7.CastShadow = false
                v5 = u76
                if not v5 or not v5.Parent then
                    Folder = Instance.new("Folder")
                    Folder.Name = "CursedIslandWarsFx"
                    Folder.Parent = Workspace
                    u76 = Folder
                    v4 = Folder
                else
                    v4 = v5
                end
                v7.Parent = v4
                RightVector = CFrame.RightVector
                v6 = RightVector * (if not ((u106:NextNumber()) < 0.5) then -1 else 1) * u106:NextNumber(30, 70)
                fling(v7, v6 + Vector3.new(0, 1, 0) * u106:NextNumber(5, 30), u106:NextNumber(1, 1.6))
            end
        end
        for k = 1, 5 do
            v9 = (k / 6 - 0.5) * Size.Z
            u107.Once(VFX.V3_RulesWall, {"Burst"}, CFrame * CFrame.new(0, 0, v9) * CFrame.Angles(0, 1.5707963267948966, 0), 0.9)
        end
        local Position = CFrame.Position
        local v10 = Size.Y / 2 - 0.4
        local v11 = (CFrame.new(Position - Vector3.new(0, 1, 0) * v10)) * CFrame.Angles(0, 0, 1.5707963267948966)
        local v12 = u56
        local v13 = Instance.new("Part")
        v13.Material = Enum.Material.Neon
        v13.Color = v12
        v13.Size = Vector3.new(0.4000000059604645, 4, 4)
        v13.CFrame = v11
        v13.Transparency = 0.15
        v13.Anchored = true
        v13.CanCollide = false
        v13.CanQuery = false
        v13.CanTouch = false
        v13.CastShadow = false
        local v14 = u76
        if not v14 or not v14.Parent then
            local Folder_2 = Instance.new("Folder")
            Folder_2.Name = "CursedIslandWarsFx"
            Folder_2.Parent = Workspace
            u76 = Folder_2
            v10 = Folder_2
        else
            v10 = v14
        end
        v13.Parent = v10
        v13.Shape = Enum.PartType.Cylinder
        TweenService:Create(
            v13,
            TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = Vector3.new(0.4000000059604645, 600, 600), Transparency = 1}
        ):Play()
        Debris:AddItem(v13, 1.2)
        u107.Sound(Sounds.ScrambleBoss.GlassCrack, Collision, 0.7, 2)
        u107.Sound(Sounds.CinematicBoom, Collision, 1.1, 3)
        u107.Sound(Sounds.Explosion, Collision, 0.8, 1.5)
    end)
end

local function sizeCollapse(a1, a2) -- Line: 997 -- upvalues: holders (val) -- types: a1: userdata, a2: userdata
    local BoundingBox, BoundingBox_2 = a2:GetBoundingBox()
    local v1 = {"Warn", "Fall", "Break"}
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        for k, n in holders(a1, j) do
            if n:IsA("BasePart") then
                n.CFrame = BoundingBox
                n.Size = BoundingBox_2
            end
        end
    end
end

local function glow(a1, a2, a3, a4) -- Line: 1009
    -- upvalues: TweenService (val)
    a1.Transparency = a2
    TweenService:Create(a1, TweenInfo.new(a4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = a3}):Play()
end

function u107.SafeZone(a1) -- Line: 1016
    -- upvalues: u97 (ref), State (val), u72 (val), glow (val), u76 (ref), Workspace (val)
    local v1 = u97
    if not a1 then
        u97 = nil
        if v1 then
            v1:Destroy()
        end
        return
    end
    local v2 = State.Island()
    if not v1 and v2 ~= nil then
        local Part
        local Top = v2.Centre.Top
        local Model = Instance.new("Model")
        Model.Name = "SafeZone"
        for i, j in {
            {Vector3.new(420, 10, 10), Vector3.new(0, 210, 0), 0.5, 0.75},
            {
                Vector3.new(0.30000001192092896, 54, 54),
                Vector3.new(0, 0.4000000059604645, 0),
                0.55,
                0.85,
            },
        } do
            Part = Instance.new("Part")
            Part.Shape = Enum.PartType.Cylinder
            Part.Material = Enum.Material.Neon
            Part.Color = u72
            Part.Size = j[1]
            Part.CFrame = (CFrame.new(Top.Position + j[2])) * CFrame.Angles(0, 0, 1.5707963267948966)
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CastShadow = false
            Part.Parent = Model
            glow(Part, j[3], j[4], 0.9)
        end
        v1 = u76
        if not v1 or not v1.Parent then
            v1 = Instance.new("Folder")
            v1.Name = "CursedIslandWarsFx"
            v1.Parent = Workspace
            u76 = v1
        end
        Model.Parent = v1
        u97 = Model
        return
    end
end

function u107.CollapseWarn(a1, a2) -- Line: 1054
    -- upvalues: u76 (ref), Workspace (val), TweenService (val), u87 (val), u107 (val), VFX (val), sizeCollapse (val)
    -- upvalues: u85 (val), Sounds (val)
    local Folder, Highlight, v1, v2, v3, v4, v5, v6
    local v7 = nil
    local v8 = nil
    for i, j in a1, v7, v8 do
        Highlight = Instance.new("Highlight")
        Highlight.Adornee = j
        Highlight.FillColor = Color3.fromRGB(255, 30, 20)
        Highlight.OutlineColor = Color3.fromRGB(255, 70, 40)
        Highlight.FillTransparency = 0.8
        Highlight.OutlineTransparency = 0.2
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        v6 = u76
        if not v6 or not v6.Parent then
            Folder = Instance.new("Folder")
            Folder.Name = "CursedIslandWarsFx"
            Folder.Parent = Workspace
            u76 = Folder
            v5 = Folder
        else
            v5 = v6
        end
        Highlight.Parent = v5
        TweenService:Create(
            Highlight,
            TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {FillTransparency = 0.35}
        ):Play()
        u87[j] = Highlight
        v4 = u107.Anchored(VFX.V11_Collapse, j:GetPivot())
        sizeCollapse(v4, j)
        u107.Loop(v4, "Warn", true)
        u85[j] = v4
        for k, n in j:GetDescendants() do
            if n:IsA("BasePart") and n.Name == "Cracks" then
                v1 = TweenService
                v2 = TweenInfo.new(a2)
                v3 = {Color = Color3.fromRGB(255, 30, 10)}
                v1:Create(n, v2, v3):Play()
            end
        end
        u107.Sound(Sounds.ScrambleBoss.Rumble, j:GetPivot().Position, 1, 2)
    end
end

function u107.CollapseDrop(a1, a2, a3) -- Line: 1081
    -- upvalues: u96 (val), u87 (val), u85 (val), u107 (val), Debris (val), u80 (val), u106 (val), Sounds (val)
    local v1, v2
    local v3 = {}
    for i, j in a1 do
        v3[j] = {j}
    end
    for k, n in a2 do
        if n:IsA("Model") then
            u96[n] = true
            table.insert(v3[a3[k]], n)
        end
    end
    local v4 = os.clock()
    local v5 = nil
    local v6 = nil
    for m, i5 in a1, v5, v6 do
        v1 = u87[i5]
        u87[i5] = nil
        if v1 then
            v1:Destroy()
        end
        v1 = v3[i5]
        v2 = u85[i5]
        u85[i5] = nil
        if v2 then
            u107.Loop(v2, "Warn", false)
            u107.Burst(v2, "Break")
            u107.Loop(v2, "Fall", true)
            table.insert(v1, v2)
            Debris:AddItem(v2, 3.4)
        end
        v2 = {}
        for i6, i7 in v1 do
            v2[i6] = (i7:GetPivot())
        end
        table.insert(u80, {
            Models = v1,
            Bases = v2,
            Origin = i5:GetPivot(),
            Spin = Vector3.new(u106:NextNumber(-0.35, 0.35), 0, (u106:NextNumber(-0.35, 0.35))),
            Start = v4,
        })
        u107.Sound(Sounds.ImpactBoom, i5:GetPivot().Position, 0.6, 2)
    end
end

local function stepFallings() -- Line: 1124 -- upvalues: u80 (val), u106 (val)
    local v1, v2, v3, v4
    local v5 = os.clock()
    for i = #u80, 1, -1 do
        v2 = u80[i]
        v3 = v5 - v2.Start
        if not (v3 > 2.4) then
            v4 = if not (v3 < 0) then (CFrame.new(0, -(12 * v3 + 100 * v3 * v3), 0)) * CFrame.Angles(v2.Spin.X * v3, 0, v2.Spin.Z * v3) else CFrame.new(u106:NextNumber(-0.4, 0.4), 0, u106:NextNumber(-0.4, 0.4))
            v3 = v2.Origin * v4 * v2.Origin:Inverse()
            for j, k in v2.Models do
                if k.Parent then
                    v1 = v3 * v2.Bases[j]
                    k:PivotTo(v1)
                end
            end
        else
            for n, m in v2.Models do
                if m.Parent then
                    m.Parent = nil
                end
            end
            table.remove(u80, i)
        end
    end
end

function u107.Victory(a1) -- Line: 1151 -- upvalues: u107 (val), VFX (val), Sounds (val) -- types: a1: userdata
    for i = -1, 1 do
        u107.Once(VFX.V12_Victory, {"Burst"}, a1 * CFrame.new(i * 8, -3, -6), 4)
    end
    u107.Ui(Sounds.ScrambleBoss.Pop, 1, 1.5)
end

function u107.SuddenDeath() -- Line: 1158 -- upvalues: u100 (ref), u107 (val)
    local v1 = u100
    if v1 then
        u107.Loop(v1, "SuddenDeath", true)
    end
end

function u107.Start(a1) -- Line: 1165
    -- upvalues: u75 (ref), u102 (ref), u103 (ref), u104 (ref), u77 (val), u107 (val), u78 (val), u79 (val), u80 (val)
    -- upvalues: u81 (val), u82 (val), u83 (val), u84 (val), u92 (val), u85 (val), u86 (val), u87 (val), u97 (ref)
    -- upvalues: u98 (ref), u100 (ref), u101 (ref), u76 (ref), VFX (val), State (val), mountPortal (val), u73 (val)
    -- upvalues: mountCrystal (val), mountBarrier (val), refreshSkulls (val), RunService (val), stepSteady (val)
    -- upvalues: stepFlights (val), stepMines (val), stepCrystals (val), showFace (val), stepFallings (val)
    -- upvalues: stepPickups (val)
    u75 = a1:Extend()
    u102 = false
    u103 = 0
    u104 = 0
    u75:Add(function() -- Line: 1170
        -- upvalues: u77 (upval), u107 (upval), u78 (upval), u79 (upval), u80 (upval), u81 (upval), u82 (upval)
        -- upvalues: u83 (upval), u84 (upval), u92 (upval), u85 (upval), u86 (upval), u87 (upval), u97 (upval)
        -- upvalues: u98 (upval), u100 (upval), u101 (upval), u76 (upval)
        for i in u77 do
            u107.Land(i)
        end
        table.clear(u78)
        table.clear(u79)
        table.clear(u80)
        local v1 = {u81, u82}
        local v2 = nil
        local v3 = nil
        for j, k in v1, v2, v3 do
            for n, m in k do
                m:Destroy()
            end
            table.clear(k)
        end
        table.clear(u83)
        table.clear(u84)
        table.clear(u92)
        table.clear(u85)
        table.clear(u86)
        table.clear(u87)
        u97 = nil
        u98 = false
        u100 = nil
        u101 = nil
        v1 = u76
        u76 = nil
        if v1 then
            v1:Destroy()
        end
    end)
    local u12 = {}

    local function mount(a1) -- Line: 1201
        -- upvalues: u100 (upval), u107 (upval), VFX (upval), u12 (val), State (upval), u101 (upval)
        -- upvalues: mountPortal (upval), u102 (upval), u73 (upval), mountCrystal (upval), mountBarrier (upval)
        -- upvalues: refreshSkulls (upval)
        if a1 ~= nil and a1.Island ~= nil then
            local v1
            local Island = a1.Island
            if u100 == nil then
                v1 = u107.Anchored(VFX.V1_CursedSky.WorldFX, Island:GetPivot())
                u107.Loop(v1, "Ambient", true)
                u100 = v1
                for i, j in Island.FloatingDebris:GetChildren() do
                    u12[j] = (j:GetPivot())
                end
            end
            v1 = State.Island()
            local Parent = if not v1 then nil else v1.Parent
            v1 = if not Parent then nil else Parent:FindFirstChild("Pieces")
            local v2 = if not v1 then nil else v1:FindFirstChild("SkyEyes")
            if u101 == nil and v2 then
                mountPortal(v2)
                if u102 or u73[a1.Phase] then
                    u102 = false
                    u107.Eyes("Open")
                end
            end
            for k, n in a1.Crystals do
                if 0 < n.Health then
                    mountCrystal(k, n.Model)
                end
            end
            for m, i5 in a1.Barriers do
                if 0 < i5.Health then
                    mountBarrier(m, i5.Model, i5.Health / i5.MaxHealth)
                end
            end
            refreshSkulls()
            return
        end
    end

    u75:Add((State.Changed:Connect(mount)))
    mount(State.Snapshot)
    u75:Add((RunService.RenderStepped:Connect(function(a1) -- Line: 1238
        -- upvalues: stepSteady (upval), stepFlights (upval), stepMines (upval), stepCrystals (upval), u101 (upval)
        -- upvalues: u102 (upval), u103 (upval), showFace (upval), stepFallings (upval), stepPickups (upval), u12 (val)
        local v1, v2
        stepSteady()
        stepFlights()
        stepMines()
        stepCrystals()
        local v3 = u101
        if v3 ~= nil and u102 then
            local v4 = os.clock()
            if u103 <= v4 then
                u103 = v4 + showFace(v3, "EYES2")
            end
        end
        stepFallings()
        stepPickups()
        v3 = os.clock()
        for i, j in u12 do
            if i.Parent then
                v1 = CFrame.new(0, math.sin(v3 * 0.8 + j.X) * 1.5, 0)
                v2 = j * v1
                i:PivotTo(v2)
            end
        end
    end)))
end

return u107