-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Stages.Watering
-- Decompile time: 43.83 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local BeanstalkEventFlags = require(ReplicatedStorage.Shared.Flags.BeanstalkEventFlags)
local BeanstalkGrowth = require(script.Parent.Parent.BeanstalkGrowth)
local EmitOnce = require(ReplicatedStorage.UserGenerated.VFX.EmitOnce)
local Juice = require(script.Parent.Parent.Parent.ScrambleBoss.Juice)
local RailRide = require(script.Parent.Parent.RailRide)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trampoline = require(script.Parent.Parent.Trampoline)
require(ReplicatedStorage.Packages.Trove)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local UISystem = require(script.Parent.Parent.UISystem)
local LocalPlayer = Players.LocalPlayer
local Stage2 = ReplicatedStorage.Assets.BeanstalkEventAssets.Stage2
local LeafBowl = Stage2.LeafBowl
local Cloud = Stage2.Cloud
local BeanstalkEvent_2 = ReplicatedStorage.Assets.Sounds.BeanstalkEvent
local Stage = BeanstalkEvent.Stage
local u108 = CFrame.new(0, 0.5, -2.5)
local u113 = Color3.fromRGB(105, 108, 118)
local u114 = {
    {
        Clouds = 1,
        Scale = 1,
        Radius = 4,
        Period = 8,
        Storm = false,
    },
    {
        Clouds = 3,
        Scale = 0.55,
        Radius = 4,
        Period = 10,
        Storm = false,
    },
    {
        Clouds = 1,
        Scale = 1,
        Radius = 4,
        Period = 6.5,
        Storm = true,
    },
}
local u122 = Color3.fromRGB(255, 240, 60)
local u126 = ReplicatedStorage.Assets.Sounds.LightVsDarknessSounds["Lightning Explosion"]
local RainCircle = Stage2.RainCircle
local u131 = TweenInfo.new(0.6)

local function emitAll(a1) -- Line: 97 -- upvalues: EmitOnce (val) -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            EmitOnce(j)
        end
    end
end

local function flat(a1) -- Line: 105 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

local function groundDisc(a1, a2, a3) -- Line: 110 -- types: a1: string, a2: number, a3: userdata
    local Part = Instance.new("Part")
    Part.Name = a1
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(0.2, a2 * 2, a2 * 2)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = a3
    Part.Transparency = 1
    return Part
end

local function serverCount() -- Line: 126 -- upvalues: LocalPlayer (val), BeanstalkEvent (val)
    local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return 0
end

return {
    Run = function(a1, a2, a3, a4) -- Line: 135
        -- upvalues: BeanstalkEventFlags (val), Workspace (val), BeanstalkEvent (val), Cloud (val), u114 (val)
        -- upvalues: emitAll (val), LocalPlayer (val), BeanstalkGrowth (val), UISystem (val), RailRide (val)
        -- upvalues: Stage (val), Trampoline (val), LeafBowl (val), Remotes (val), SoundService (val)
        -- upvalues: BeanstalkEvent_2 (val), RainCircle (val), u113 (val), TweenService (val), u122 (val), Juice (val)
        -- upvalues: u126 (val), Debris (val), TutorialBeam (val), RunService (val), u108 (val), u131 (val)
        local Trampoline_2, v1, v2, v3
        local PourZone = a2.Sections.Stage2.PourZone
        local u672 = BeanstalkEventFlags.PoursRequired:Get()
        local u674 = a1:Add((Instance.new("Folder")))
        u674.Name = "BeanstalkWatering"
        u674.Parent = Workspace
        local u675 = a1:Add((Instance.new("Highlight")))
        u675.FillColor = Color3.fromRGB(70, 160, 255)
        u675.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        u675.Parent = u674
        local v4 = BeanstalkEvent.MapShift(a2.Beanstalk)
        local Stage2 = a2.Sections.Stage2
        local u679 = Stage2.Floor.Position.Y + Stage2.Floor.Size.Y * 0.5
        local v5 = v4 * Cloud:GetPivot()
        local u509 = Vector3.new(v5.X, u679 + 60, v5.Z)
        local Rotation = v5.Rotation
        local u459 = {}
        local Clouds = u114[2].Clouds
        for i = 1, Clouds do
            v1 = a1:Clone(Cloud)
            v1:PivotTo(Rotation + u509)
            table.insert(u459, v1)
        end
        local u688 = a2.Sections.Stage2.structures["water collection bucket"]
        local u92 = u688["collected water"]
        local v6 = u688["bucket bottom"]
        local CFrame_2 = u92.CFrame
        local Transparency = u92.Transparency
        local u108_2 = CFrame_2.Position.Y - (v6.Position.Y + v6.Size.Y * 0.5) - u92.Size.Y * 0.5

        local function showBucketWater(a1) -- Line: 168
            -- upvalues: u92 (val), CFrame_2 (val), u108_2 (val), Transparency (val)
            u92.CFrame = CFrame_2 - Vector3.new(0, u108_2 * (1 - a1), 0)
            u92.Transparency = if not (a1 > 0) then 1 else Transparency
        end

        local VFX = u688.VFX
        local CFrame_3 = VFX.CFrame
        a1:Add(function() -- Line: 174 -- upvalues: u92 (val), CFrame_2 (val), Transparency (val), VFX (val), CFrame_3 (val)
            u92.CFrame = CFrame_2
            u92.Transparency = Transparency
            VFX.CFrame = CFrame_3
        end)

        local function splashBucket() -- Line: 180 -- upvalues: VFX (val), u92 (val), emitAll (upval)
            VFX.CFrame = u92.CFrame
            emitAll(VFX)
        end

        local u689 = false

        local function onProgress() -- Line: 186
            -- upvalues: LocalPlayer (upval), BeanstalkEvent (upval), u672 (val), BeanstalkGrowth (upval), u92 (val)
            -- upvalues: CFrame_2 (val), u108_2 (val), Transparency (val), UISystem (upval), u689 (ref), u675 (val)
            -- upvalues: RailRide (upval), Stage (upval), BeanstalkEventFlags (upval), Trampoline (upval), a1 (val)
            -- upvalues: a2 (val), a3 (val)
            local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
            local v1 = math.min(if typeof(Attribute) ~= "number" then 0 else Attribute, u672)
            BeanstalkGrowth.SetWilted(1 - v1 / u672)
            local v2 = v1 / u672
            u92.CFrame = CFrame_2 - Vector3.new(0, u108_2 * (1 - v2), 0)
            u92.Transparency = if not (v2 > 0) then 1 else Transparency
            if v1 < u672 then
                UISystem.SetProgress("WaterBeanstalk", v1, u672)
                return
            end
            if u689 then
                return
            end
            u689 = true
            u675.Adornee = nil
            UISystem.SetTask("Bounce on the trampoline!")
            UISystem.SetPrompt(nil)
            RailRide.Shake(3)
            BeanstalkGrowth.GrowTo(BeanstalkGrowth.HeightFor(Stage.WhaleFlight), BeanstalkEventFlags.GrowSeconds:Get())
            Trampoline.Show(a1, a2.Sections.Stage2.Trampoline, a2.Sections.Stage3.SpawnLocation, a3)
        end

        a1:Connect(LocalPlayer:GetAttributeChangedSignal(BeanstalkEvent.ProgressAttribute), onProgress)
        a1:Add(function() -- Line: 207 -- upvalues: UISystem (upval)
            UISystem.SetPrompt(nil)
        end)
        onProgress()
        if a4 then
            task.wait(BeanstalkEventFlags.LeafRespawnSeconds:Get())
        end
        local u691 = v4 * LeafBowl:GetPivot()
        local u677 = a1:Clone(LeafBowl)
        u677:PivotTo(u691)
        local PrimaryPart = u677.PrimaryPart
        local Water = u677:FindFirstChild("Water")
        local Droplet = Water:FindFirstChild("Droplet")
        local Size = Water.Size
        local u700 = PrimaryPart.CFrame:ToObjectSpace(Water.CFrame)
        local Transparency_2 = Water.Transparency
        u677.Parent = u674
        local u704 = false
        local u705 = 0
        local u706 = 0
        local u707 = false

        local function showWater() -- Line: 233
            -- upvalues: Size (val), u705 (ref), Water (val), PrimaryPart (val), u700 (val), Transparency_2 (val)
            local v1 = math.max(Size.Y * u705, 0.05)
            Water.Size = Vector3.new(Size.X, v1, Size.Z)
            Water.CFrame = PrimaryPart.CFrame * u700 * CFrame.new(0, (v1 - Size.Y) * 0.5, 0)
            Water.Transparency = if not (u705 > 0) then 1 else Transparency_2
        end

        local v7 = math.max(Size.Y * u705, 0.05)
        Water.Size = Vector3.new(Size.X, v7, Size.Z)
        Water.CFrame = PrimaryPart.CFrame * u700 * CFrame.new(0, (v7 - Size.Y) * 0.5, 0)
        Water.Transparency = if not (u705 > 0) then 1 else Transparency_2

        local function pour() -- Line: 241
            -- upvalues: u707 (ref), Remotes (upval), SoundService (upval), BeanstalkEvent_2 (upval), u675 (val)
            -- upvalues: a1 (val), splashBucket (val), u706 (ref), u705 (ref), u689 (ref), UISystem (upval)
            local v1
            u707 = true
            Remotes.BeanstalkEvent.AskPour:FireServer()
            SoundService:PlayLocalSound(BeanstalkEvent_2.DepositRainwater)
            u675.Adornee = nil
            a1:Add((task.delay(0.4, splashBucket)))
            local v2 = os.clock()
            while true do
                if not (os.clock() - v2 < 0.8) then
                    break
                end
                v1 = (os.clock() - v2) / 0.8
                math.sin(v1 * 3.141592653589793)
                u705 = 1 - v1
                task.wait()
            end
            u706 = 0
            u705 = 0
            u707 = false
            if not u689 then
                UISystem.SetPrompt("Fill the leaf under the rain cloud")
            end
        end

        local u709 = RaycastParams.new()
        u709.FilterType = Enum.RaycastFilterType.Include
        u709.FilterDescendantsInstances = {Stage2}
        u709.RespectCanCollide = true

        local function groundUnder(a1) -- Line: 267
            -- upvalues: u509 (val), Workspace (upval), u709 (val)
            local v1 = Vector3.new(a1.X, u509.Y, a1.Z)
            local v2 = Workspace:Raycast(v1, Vector3.new(0, -300, 0), u709)
            if v2 then
                return v2.Position
            end
            return nil
        end

        local function rainSpot(a1) -- Line: 273
            -- upvalues: u509 (val), Workspace (upval), u709 (val), u679 (val)
            local Position = a1:GetPivot().Position
            local v1 = Vector3.new(Position.X, u509.Y, Position.Z)
            local v2 = Workspace:Raycast(v1, Vector3.new(0, -300, 0), u709)
            return (if not v2 then nil else v2.Position) or Vector3.new(Position.X, u679, Position.Z)
        end

        local u463 = u114[1]
        local u711 = 0
        local u712 = (-1 / 0)
        local u713 = {}
        local u714 = {}
        local u715 = {}
        local u716 = {}
        local u659 = {}
        local u717 = {}
        local Color = Cloud:FindFirstChildWhichIsA("BasePart", true).Color
        local v8 = nil
        local v9 = nil
        for j, k in u459, v8, v9 do
            u715[j] = u509
            u716[j] = 1
            v2 = {}
            for n, m in k:GetDescendants() do
                if m:IsA("ParticleEmitter") then
                    table.insert(v2, m)
                    u717[m] = m.Speed
                end
            end
            u659[j] = v2
        end

        local function orbit(a1, a2) -- Line: 302 -- upvalues: u463 (ref), u509 (val) -- types: a1: number, a2: number
            local v1 = a2 * 2 * 3.141592653589793 / u463.Period
            if u463.Clouds == 1 then
                return u509 + Vector3.new(math.cos(v1) * 25, 0, (math.sin(v1)) * 18)
            end
            local v2 = (a1 - 1) * 2 * 3.141592653589793 / u463.Clouds
            local v3 = u509 + Vector3.new(math.cos(v2), 0, (math.sin(v2))) * 15
            local v4 = v2 + v1 * (if a1 % 2 ~= 0 then 1 else -1)
            return v3 + Vector3.new(math.cos(v4), 0, (math.sin(v4))) * 18
        end

        local function rainingIndex(a1) -- Line: 314 -- upvalues: u463 (ref) -- types: a1: number
            if u463.Clouds == 1 then
                return 1
            end
            return (math.floor(a1 / 5)) % u463.Clouds + 1
        end

        local u282 = {}
        for i5 in u459 do
            v3 = a1:Clone(RainCircle)
            v3.Parent = u674
            table.insert(u282, v3)
        end
        local Transparency_3 = RainCircle.Transparency

        local function placeRainCircles(a1, a2, a3) -- Line: 327
            -- upvalues: u282 (val), u463 (ref), Transparency_3 (val), u459 (val), u509 (val), Workspace (upval)
            -- upvalues: u709 (val), u679 (val)
            local Position, new, v1, v2, v3, v4, v5
            local v6 = (math.sin(a1 * 2 * 3.141592653589793 / 1.2) * 0.5 + 0.5) * 0.2
            local v7 = nil
            local v8 = nil
            for i, j in u282, v7, v8 do
                v5 = a2 and i <= u463.Clouds
                v1 = if v5 then if i ~= v9 then Transparency_3 else Transparency_3 - v6 else 1
                j.Transparency = v1
                if v5 then
                    new = CFrame.new
                    Position = u459[i]:GetPivot().Position
                    v3 = Vector3.new(Position.X, u509.Y, Position.Z)
                    v4 = Workspace:Raycast(v3, Vector3.new(0, -300, 0), u709)
                    v2 = new(((if not v4 then nil else v4.Position) or Vector3.new(Position.X, u679, Position.Z)) + Vector3.new(0, 0.15000000596046448, 0))
                    j.CFrame = v2 * CFrame.Angles(0, 0, 1.5707963267948966)
                end
            end
        end

        local function updateWeather(a1, a2) -- Line: 343
            -- upvalues: LocalPlayer (upval), BeanstalkEvent (upval), u672 (val), u114 (upval), u711 (ref), u463 (ref)
            -- upvalues: u459 (val), u713 (val), u715 (val), u714 (val), u716 (val), u712 (ref), u282 (val)
            -- upvalues: u113 (upval), Color (val), TweenService (upval)
            local X, v1, v2, v3
            local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
            local v4 = math.clamp(math.min(if typeof(Attribute) ~= "number" then 0 else Attribute, u672 - 1) + 1, 1, #u114)
            if v4 == u711 then
                return
            end
            local Clouds = if u711 ~= 0 then u463.Clouds else 1
            u711 = v4
            u463 = u114[v4]
            local v5 = nil
            local v6 = nil
            local v7, v8 = a2, a1
            for i in u459, v5, v6 do
                v1 = if not (Clouds < i) then u715[i] else u715[1]
                u713[i] = v1
                v1 = if not v4 then u716[i] else u716[1]
                u714[i] = v1
            end
            u712 = if not v7 then v8 else (-1 / 0)
            for j, k in u282 do
                X = k.Size.X
                v2 = u463.Radius * 2
                v3 = u463.Radius * 2
                k.Size = Vector3.new(X, v2, v3)
            end
            local v9 = TweenInfo.new(if not v7 then 1.5 else 0)
            local v10 = if not u463.Storm then Color else u113
            v6 = nil
            local v11 = nil
            for n, m in u459, v6, v11 do
                for i5, i6 in m:GetDescendants() do
                    if i6:IsA("BasePart") then
                        TweenService:Create(i6, v9, {Color = v10}):Play()
                    end
                end
            end
        end

        local function moveClouds(a1) -- Line: 373
            -- upvalues: u712 (ref), u459 (val), u463 (ref), orbit (val), u713 (val), u715 (val), u714 (val), u716 (val)
            -- upvalues: u659 (val), u717 (val), Rotation (val), u674 (val)
            local v1, v2, v3, v4, v5
            local v6 = math.clamp((a1 - u712) / 1.5, 0, 1)
            local v7 = v6 * v6 * (3 - v6 * 2)
            local v8 = nil
            local v9 = nil
            for i, j in u459, v8, v9 do
                v5 = orbit(if not (i <= u463.Clouds) then 1 else i, v1)
                v2 = if not (v6 < 1) then v5 else u713[i]:Lerp(v5, v7)
                u715[i] = v2
                v5 = v4 or v6 < 1
                if v5 then
                    v4 = u714[i] + (u463.Scale - u714[i]) * v7
                    if 0.001 < (math.abs(v4 - u716[i])) then
                        j:ScaleTo(v4)
                        u716[i] = v4
                        for k, n in u659[i] do
                            n.Speed = u717[n]
                        end
                    end
                    v3 = Rotation + v2
                    j:PivotTo(v3)
                end
                v2 = if not v5 then nil else u674
                if j.Parent ~= v2 then
                    j.Parent = v2
                end
            end
            return v6
        end

        local function setRain(a1) -- Line: 403 -- upvalues: u659 (val) -- types: a1: number?
            local Enabled, v1, v2, v3
            local v4 = nil
            local v5 = nil
            local v6 = a1
            for i, j in u659, v4, v5 do
                v2 = nil
                v3 = nil
                for k, n in j, v2, v3 do
                    Enabled = n.Enabled
                    if Enabled ~= (i == v6) then
                        v1 = i == v6
                        n.Enabled = v1
                    end
                end
            end
        end

        updateWeather(os.clock(), true)
        moveClouds(os.clock())
        local v10 = u122
        local v11 = Instance.new("Part")
        v11.Name = "LightningStrike"
        v11.Shape = Enum.PartType.Cylinder
        v11.Size = Vector3.new(0.20000000298023224, 20, 20)
        v11.Anchored = true
        v11.CanCollide = false
        v11.CanQuery = false
        v11.CanTouch = false
        v11.CastShadow = false
        v11.Material = Enum.Material.Neon
        v11.Color = v10
        v11.Transparency = 1
        local u345 = a1:Add(v11)
        local u346 = false
        local u347 = 0
        local u348 = 0

        local function fling(a1) -- Line: 422
            -- upvalues: a3 (val), u509 (val), Workspace (upval), u709 (val), Stage2 (val), u348 (ref), Juice (upval)
            local v1 = a3.Root.Position - a1
            local v2 = Vector3.new(v1.X, 0, v1.Z)
            local v3 = a3.Root.Position + (if not (0.1 < v2.Magnitude) then Vector3.new(1, 0, 0) else v2.Unit) * 30
            local v4 = Vector3.new(v3.X, u509.Y, v3.Z)
            local v5 = Workspace:Raycast(v4, Vector3.new(0, -300, 0), u709)
            local Position = (if not v5 then nil else v5.Position) or Stage2.SpawnLocation.Position
            u348 = os.clock() + 1.6
            Juice.Throw(a3.Root, a3.Humanoid, Position + Vector3.new(0, 3, 0), 1.6)
        end

        local function strike(a1, a2) -- Line: 430
            -- upvalues: SoundService (upval), u126 (upval), RailRide (upval), u459 (val), u122 (upval), u674 (val)
            -- upvalues: Debris (upval), a3 (val), u348 (ref), fling (val)
            SoundService:PlayLocalSound(u126)
            RailRide.Shake(3)
            local Position = u459[1]:GetPivot().Position
            local Part = Instance.new("Part")
            Part.Name = "LightningBolt"
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CastShadow = false
            Part.Material = Enum.Material.Neon
            Part.Color = u122
            Part.Size = Vector3.new(1.2, 1.2, (Position - a1).Magnitude)
            Part.CFrame = CFrame.lookAt((Position + a1) * 0.5, a1)
            Part.Parent = u674
            Debris:AddItem(Part, 0.15)
            local v1 = a3.Root.Position - a1
            if u348 <= a2 and Vector3.new(v1.X, 0, v1.Z).Magnitude <= 10 and v1.Y <= 12 then
                fling(a1)
            end
        end

        local function stepLightning(a1, a2) -- Line: 455
            -- upvalues: u346 (ref), u345 (val), u347 (ref), u674 (val), u459 (val), u509 (val), Workspace (upval)
            -- upvalues: u709 (val), u679 (val), strike (val)
            if not a2 then
                u346 = false
                if u345.Parent ~= nil then
                    u345.Parent = nil
                end
                return
            end
            if not u346 then
                u346 = true
                u347 = a1
                u345.Parent = u674
            end
            local Position = u459[1]:GetPivot().Position
            local v1 = Vector3.new(Position.X, u509.Y, Position.Z)
            local v2 = Workspace:Raycast(v1, Vector3.new(0, -300, 0), u709)
            u345.CFrame = (CFrame.new(((if not v2 then nil else v2.Position) or Vector3.new(Position.X, u679, Position.Z)) + Vector3.new(0, 0.30000001192092896, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
            local v3 = (a1 - u347) / 3
            u345.Transparency = 1 - math.min(v3, 1)
            if v3 >= 1 then
                local Position_2
                strike(Position_2, a1)
                u346 = false
            end
        end

        local function guideTarget() -- Line: 480
            -- upvalues: u689 (ref), Stage2 (val), u704 (ref), PrimaryPart (val), u705 (ref), u707 (ref), u459 (val)
            -- upvalues: u463 (ref), u509 (val), Workspace (upval), u709 (val), u679 (val)
            if u689 then
                return Stage2.Trampoline
            end
            if not u704 then
                return PrimaryPart
            end
            if u705 < 1 and not u707 then
                local v1 = os.clock()
                local Position = u459[if u463.Clouds ~= 1 then (math.floor(v1 / 5)) % u463.Clouds + 1 else 1]:GetPivot().Position
                local v2 = Vector3.new(Position.X, u509.Y, Position.Z)
                v1 = Workspace:Raycast(v2, Vector3.new(0, -300, 0), u709)
                return (if not v1 then nil else v1.Position) or Vector3.new(Position.X, u679, Position.Z)
            end
            return Stage2.structures["drop-off pad"]
        end

        local Attach = TutorialBeam.Attach
        if u689 then
            Trampoline_2 = Stage2.Trampoline
        elseif not u704 then
            Trampoline_2 = PrimaryPart
        elseif not (u705 < 1) or u707 then
            Trampoline_2 = Stage2.structures["drop-off pad"]
        else
            local v12 = os.clock()
            local Position = u459[if u463.Clouds ~= 1 then (math.floor(v12 / 5)) % u463.Clouds + 1 else 1]:GetPivot().Position
            v12 = Vector3.new(Position.X, u509.Y, Position.Z)
            local v13 = Workspace:Raycast(v12, Vector3.new(0, -300, 0), u709)
            Trampoline_2 = (if not v13 then nil else v13.Position) or Vector3.new(Position.X, u679, Position.Z)
        end
        local u416 = Attach(Trampoline_2)
        a1:Add(function() -- Line: 491 -- upvalues: TutorialBeam (upval), u416 (val)
            TutorialBeam.Destroy(u416)
        end)
        if not u689 then
            UISystem.SetPrompt("Grab the leaf")
        end
        local u433 = (-1 / 0)
        local u434 = (-1 / 0)
        local u435 = false
        local u441 = a1:Clone(BeanstalkEvent_2.CollectingRainwater)
        u441.Parent = SoundService
        a1:Connect(RunService.Heartbeat, function(a1_2) -- Line: 504
            -- upvalues: updateWeather (val), moveClouds (val), u459 (val), u463 (ref), setRain (val)
            -- upvalues: placeRainCircles (val), stepLightning (val), u689 (ref), TutorialBeam (upval), u416 (val)
            -- upvalues: Stage2 (val), u704 (ref), PrimaryPart (val), u705 (ref), u707 (ref), u509 (val)
            -- upvalues: Workspace (upval), u709 (val), u679 (val), a3 (val), u348 (ref), u441 (val), u434 (ref)
            -- upvalues: emitAll (upval), Droplet (val), u677 (val), u108 (upval), u706 (ref), Size (val), Water (val)
            -- upvalues: u700 (val), Transparency_2 (val), u435 (ref), TweenService (upval), u131 (upval), u691 (val)
            -- upvalues: UISystem (upval), BeanstalkEventFlags (upval), u675 (val), u688 (val), BeanstalkEvent (upval)
            -- upvalues: PourZone (val), u433 (ref), a1 (val), pour (val)
            local Trampoline
            local v1 = os.clock()
            updateWeather(v1, false)
            local v2 = 1 <= (moveClouds(v1))
            local v3 = u459[if u463.Clouds ~= 1 then (math.floor(v1 / 5)) % u463.Clouds + 1 else 1]
            setRain(if not v2 then nil else if u463.Clouds ~= 1 then (math.floor(v1 / 5)) % u463.Clouds + 1 else 1)
            placeRainCircles(v1, v2, if u463.Clouds ~= 1 then (math.floor(v1 / 5)) % u463.Clouds + 1 else 1)
            stepLightning(v1, u463.Storm and v2 and not u689)
            local Retarget = TutorialBeam.Retarget
            if u689 then
                Trampoline = Stage2.Trampoline
            elseif not u704 then
                Trampoline = PrimaryPart
            elseif not (u705 < 1) or u707 then
                Trampoline = Stage2.structures["drop-off pad"]
            else
                local v4 = os.clock()
                local Position = u459[if u463.Clouds ~= 1 then (math.floor(v4 / 5)) % u463.Clouds + 1 else 1]:GetPivot().Position
                local v5 = Vector3.new(Position.X, u509.Y, Position.Z)
                v4 = Workspace:Raycast(v5, Vector3.new(0, -300, 0), u709)
                Trampoline = (if not v4 then nil else v4.Position) or Vector3.new(Position.X, u679, Position.Z)
            end
            Retarget(u416, Trampoline)
            local v6 = not u689
            if v6 then
                v6 = u704
                if v6 then
                    v6 = false
                    if u705 < 1 then
                        v6 = not u707
                    end
                end
            end
            local v7 = v6 and 1 < u463.Clouds
            local v8 = not v7
            if u416.beam.Enabled ~= v8 then
                u416.beam.Enabled = v8
            end
            local Position_2 = a3.Root.Position
            local Position_3 = v3:GetPivot().Position
            v3 = v2
            if v3 then
                v3 = false
                local v9 = Position_2 - Position_3
                if Vector3.new(v9.X, 0, v9.Z).Magnitude <= u463.Radius then
                    v3 = Position_2.Y < Position_3.Y
                end
            end
            v6 = not u689
            if v6 then
                v6 = u704
                if v6 then
                    v6 = not u707
                    if v6 then
                        v6 = false
                        if u705 < 1 then
                            v6 = v3 and u348 <= v1
                        end
                    end
                end
            end
            if u441.IsPlaying ~= v6 then
                if not v6 then
                    u441:Stop()
                else
                    u441:Play()
                end
            end
            if v6 and 0.3 <= v1 - u434 then
                u434 = v1
                emitAll(Droplet)
            end
            if u689 then
                if u704 then
                    u677:PivotTo(a3.Root.CFrame * u108 * (CFrame.Angles(u706 * 1.3962634015954636, 0, 0)))
                    v6 = math.max(Size.Y * u705, 0.05)
                    Water.Size = Vector3.new(Size.X, v6, Size.Z)
                    Water.CFrame = PrimaryPart.CFrame * u700 * CFrame.new(0, (v6 - Size.Y) * 0.5, 0)
                    Water.Transparency = if not (u705 > 0) then 1 else Transparency_2
                end
                if not u707 and not u435 then
                    u435 = true
                    for i, j in u677:GetDescendants() do
                        if j:IsA("BasePart") then
                            TweenService:Create(j, u131, {Transparency = 1}):Play()
                        end
                    end
                end
                return
            end
            if not u704 then
                if (Position_2 - u691.Position).Magnitude <= 7 then
                    u704 = true
                    UISystem.SetPrompt("Fill the leaf under the rain cloud")
                end
                return
            end
            u677:PivotTo(a3.Root.CFrame * u108 * (CFrame.Angles(u706 * 1.3962634015954636, 0, 0)))
            if u707 then
                v2 = math.max(Size.Y * u705, 0.05)
                Water.Size = Vector3.new(Size.X, v2, Size.Z)
                Water.CFrame = PrimaryPart.CFrame * u700 * CFrame.new(0, (v2 - Size.Y) * 0.5, 0)
                Water.Transparency = if not (u705 > 0) then 1 else Transparency_2
                return
            end
            if not (u705 < 1) then
                if BeanstalkEvent.IsInsideBox(PourZone, Position_2) then
                    v7 = v1 - u433
                    if BeanstalkEventFlags.MinPourIntervalSeconds:Get() < v7 then
                        u433 = v1
                        a1:Add((task.spawn(pour)))
                    end
                end
            elseif v3 then
                u705 = math.min(u705 + a1_2 / BeanstalkEventFlags.FillSeconds:Get(), 1)
                if u705 >= 1 then
                    UISystem.SetPrompt("Return to the Beanstalk")
                    u675.Adornee = u688
                end
            end
            v8 = math.max(Size.Y * u705, 0.05)
            Water.Size = Vector3.new(Size.X, v8, Size.Z)
            Water.CFrame = PrimaryPart.CFrame * u700 * CFrame.new(0, (v8 - Size.Y) * 0.5, 0)
            Water.Transparency = if not (u705 > 0) then 1 else Transparency_2
        end)
    end,
}