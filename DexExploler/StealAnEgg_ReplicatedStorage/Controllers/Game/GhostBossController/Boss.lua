-- Script path: ReplicatedStorage.Controllers.Game.GhostBossController.Boss
-- Decompile time: 35.03 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Burst = require(script.Parent.Burst)
local GhostBossFlags = require(ReplicatedStorage.Shared.Flags.GhostBossFlags)
local GhostBoss = require(ReplicatedStorage.Shared.Util.GhostBoss)
local Shake = require(ReplicatedStorage.Client.Shake)
local SuckFX = require(ReplicatedStorage.Controllers.Game.TrainGhostVisuals.SuckFX)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Attributes = GhostBoss.Attributes
local Phases = GhostBoss.Phases
local AttackPhases = GhostBoss.AttackPhases
local u61 = Color3.fromRGB(80, 255, 210)
local u66 = Color3.new(1, 1, 1)
local DisplayName = GhostBoss.DisplayName
local u72 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u80 = TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.2)
local u81 = {}
u81.__index = u81

local function now() -- Line: 131 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function ease(a1, a2, a3, a4) -- Line: 135 -- types: a1: number, a2: number, a3: number, a4: number
    return a1 + (a2 - a1) * (1 - math.exp(-a3 * a4))
end

local function easeAngle(a1, a2, a3, a4) -- Line: 139 -- types: a1: number, a2: number, a3: number, a4: number
    return a1 + ((a2 - a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * (1 - math.exp(-a3 * a4))
end

local function sound(...) -- Line: 144 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    for i, j in {...} do
        Assets = if not Assets then nil else Assets:FindFirstChild(j)
    end
    if Assets and Assets:IsA("Sound") then
        return Assets
    end
    return nil
end

local function play(a1, a2, a3, a4) -- Line: 152
    -- upvalues: Audio (val)
    if a1 then
        Audio.Play(a1, a2, {MaxDistance = 260, Volume = a3, PlaybackSpeed = a4 or 1})
    end
end

local function numberAttribute(a1, a2, a3) -- Line: 162 -- types: a1: userdata, a2: string, a3: number
    local Attribute = a1:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return a3
end

local function vectorAttribute(a1, a2) -- Line: 167 -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    if typeof(Attribute) == "Vector3" then
        return Attribute
    end
    return nil
end

local function predictedGround(a1, a2) -- Line: 172
    -- upvalues: Attributes (val), Workspace (val)
    local v1
    local Attribute = a1:GetAttribute(Attributes.Ground)
    local v2 = (if typeof(Attribute) ~= "Vector3" then nil else Attribute) or a2
    local Attribute_2 = a1:GetAttribute(Attributes.Velocity)
    if (if typeof(Attribute_2) ~= "Vector3" then nil else Attribute_2) == nil then
        return v2
    end
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local Attribute_3 = a1:GetAttribute(Attributes.MovedAt)
    return v2 + v1 * math.clamp(ServerTimeNow - (if type(Attribute_3) ~= "number" then ServerTimeNow else Attribute_3), 0, 0.3)
end

local function nozzleOf(a1) -- Line: 184 -- upvalues: Players (val), GhostBoss (val) -- types: a1: number
    local v1
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    local Character = PlayerByUserId and PlayerByUserId.Character
    if Character == nil then
        return nil
    end
    for i, j in Character:GetChildren() do
        if GhostBoss.IsVacuum(j) then
            v1 = j:FindFirstChild("Nozzle", true)
            if v1 and v1:IsA("Attachment") then
                return v1
            end
        end
    end
    return nil
end

local function captorPoint(a1) -- Line: 201 -- upvalues: nozzleOf (val), Players (val) -- types: a1: number
    local v1 = nozzleOf(a1)
    if v1 then
        return v1.WorldPosition
    end
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    local Character = PlayerByUserId and PlayerByUserId.Character
    v1 = Character and Character:FindFirstChild("HumanoidRootPart")
    if v1 and v1:IsA("BasePart") then
        return (v1.CFrame * CFrame.new(0, 1, -2.5)).Position
    end
    return nil
end

local function bindHealthBar(a1) -- Line: 215 -- upvalues: DisplayName (val) -- types: a1: userdata
    local BillboardGui = a1:FindFirstChildWhichIsA("BillboardGui", true)
    if BillboardGui == nil then
        return nil
    end
    local BarBG = BillboardGui:FindFirstChild("BarBG")
    local Bar = BarBG and BarBG:FindFirstChild("Bar")
    local PhantomBar = BarBG and BarBG:FindFirstChild("PhantomBar")
    local v1 = BillboardGui:FindFirstChild("HPLabel")
    local Title = BillboardGui:FindFirstChild("Title")
    if Bar ~= nil
        and PhantomBar ~= nil
        and v1 ~= nil
        and Bar:IsA("GuiObject")
        and PhantomBar:IsA("GuiObject")
        and v1:IsA("TextLabel") then
        if Title and Title:IsA("TextLabel") then
            Title.Text = DisplayName
        end
        return {
            Gui = BillboardGui,
            Bar = Bar,
            Phantom = PhantomBar,
            Label = v1,
            BaseSize = BillboardGui.Size,
            BaseOffset = BillboardGui.StudsOffset,
        }
    end
    return nil
end

local function attachEmitters(a1, a2) -- Line: 248
    -- upvalues: ReplicatedStorage (val), GhostBoss (val)
    local v1
    local v2 = {}
    local v3 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local VFX = v3 and v3:FindFirstChild("VFX")
    v3 = VFX and VFX:FindFirstChild(a2)
    if v3 == nil then
        return v2
    end
    for i, j in v3:GetChildren() do
        if j:IsA("ParticleEmitter") then
            v1 = j:Clone()
            v1.Enabled = true
            v1.Parent = a1
            table.insert(v2, v1)
        end
    end
    return v2
end

local function loadTrack(a1, a2, a3) -- Line: 267 -- types: a1: userdata?, a2: userdata, a3: string
    local u6 = a2:FindFirstChild(a3)
    if a1 ~= nil and u6 ~= nil and u6:IsA("Animation") then
        local success, err = pcall(function() -- Line: 272 -- upvalues: a1 (val), u6 (val)
            return a1:LoadAnimation(u6)
        end)
        if success then
            return err
        end
        return nil
    end
    return nil
end

function u81.new(a1, a2, a3) -- Line: 282
    -- upvalues: Trove (val), attachEmitters (val), u61 (val), bindHealthBar (val), GhostBoss (val), Attributes (val)
    -- upvalues: AttackPhases (val), GhostBossFlags (val), Phases (val), Workspace (val), u81 (val), loadTrack (val)
    local v1
    local v2 = Trove.new()
    local v3 = v2:Add((a2:Clone()))
    local PrimaryPart = v3.PrimaryPart or v3:FindFirstChild("RootPart")
    assert(PrimaryPart and PrimaryPart:IsA("BasePart"), "Ghost Boss template needs a RootPart")
    PrimaryPart.PivotOffset = CFrame.new(PrimaryPart.CFrame:PointToObjectSpace((v3:GetBoundingBox()).Position))
    v3.PrimaryPart = PrimaryPart
    local v4 = {}
    local v5, v6, v7 = a1, a2, a3
    for i, j in v3:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = j == PrimaryPart
            j.Anchored = v1
            j.Massless = true
            j.CanCollide = false
            j.CanTouch = false
            j.CanQuery = false
            j.CastShadow = false
            v4[j] = j.Transparency
        end
    end
    local v8 = PrimaryPart
    for k in v4 do
        if k.Transparency < 1 and v8.Size.Magnitude < k.Size.Magnitude then
            v8 = k
        end
    end
    local v9 = attachEmitters(v8, "Aura")
    v8 = Instance.new("PointLight")
    v8.Name = "GhostBossLight"
    v8.Color = u61
    v8.Brightness = 1.6
    v8.Range = 22
    v8.Shadows = false
    v8.Parent = PrimaryPart
    v8 = Instance.new("Highlight")
    v8.Name = "GhostBossGlow"
    v8.DepthMode = Enum.HighlightDepthMode.Occluded
    v8.FillColor = u61
    v8.OutlineColor = u61
    v8.FillTransparency = 0.85
    v8.OutlineTransparency = 0.35
    v8.Parent = v3
    local AnimationController = v3:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
    if AnimationController and Animator == nil then
        Animator = Instance.new("Animator")
        Animator.Parent = AnimationController
    end
    local v10 = {
        State = v5,
        Trove = v2,
        Model = v3,
        Root = PrimaryPart,
        Parts = v4,
        Animator = Animator,
        Idle = nil,
        Attack = nil,
        Bar = bindHealthBar(PrimaryPart),
        Glow = v8,
        Aura = v9,
        HalfHeight = GhostBoss.TemplateHalfHeight(v6),
    }
    local Attribute = v5:GetAttribute(Attributes.Ground)
    v10.Ground = (if typeof(Attribute) ~= "Vector3" then nil else Attribute) or v3:GetPivot().Position
    v10.Struggle = 0
    v10.Lean = 0
    v10.AttackPhase = AttackPhases.None
    local ScaleFor = GhostBoss.ScaleFor
    local Attribute_2 = v5:GetAttribute(Attributes.Health)
    local Attribute_3 = v5:GetAttribute(Attributes.MaxHealth)
    v10.Scale = ScaleFor(
        (if type(Attribute_2) ~= "number" then 1 else Attribute_2) / math.max(if type(Attribute_3) ~= "number" then 1 else Attribute_3, 1),
        GhostBossFlags.CaptureHealthFraction:Get(),
        GhostBossFlags.StartScale:Get()
    )
    v10.AppliedScale = 1
    local Attribute_4 = v5:GetAttribute(Attributes.Yaw)
    v10.Yaw = if type(Attribute_4) ~= "number" then 0 else Attribute_4
    v10.Clock = 0
    local Attribute_5 = v5:GetAttribute(Attributes.Health)
    v10.ShownHealth = if type(Attribute_5) ~= "number" then 1 else Attribute_5
    v10.PunchAt = (-1 / 0)
    local Attribute_6 = v5:GetAttribute(Attributes.AttackSerial)
    v10.AttackSerial = if type(Attribute_6) ~= "number" then 0 else Attribute_6
    v10.Beams = {}
    v10.Phase = Phases.None
    v10.PhaseAt = Workspace:GetServerTimeNow()
    v10.CaptureFrom = nil
    v10.CaptureScale = 1
    v10.RuptureFrom = nil
    v10.RuptureScale = 1
    v10.RuptureAt = 0
    v10.RupturePoint = Vector3.new(0, 0, 0)
    v10.Exploded = false
    v10.Finished = false
    v10.SpawnPuffed = false
    v10.SpawnRoared = false
    v10.LocalSucking = false
    local u279 = setmetatable(v10, u81)
    v8 = v5:GetAttribute(Attributes.SpawnedAt)
    v10 = if type(v8) ~= "number" then 0 else v8
    local v11 = v5:GetAttribute(Attributes.SpawnSeconds)
    if (if type(v11) ~= "number" then 0 else v11) < Workspace:GetServerTimeNow() - v10 then
        u279.SpawnPuffed = true
        u279.SpawnRoared = true
    end
    v3.Parent = v7
    u279.Idle = loadTrack(Animator, v3, "Idle")
    u279.Attack = loadTrack(Animator, v3, "Attack")
    local Idle = u279.Idle
    if Idle then
        Idle.Looped = true
        Idle.Priority = Enum.AnimationPriority.Idle
        Idle:Play(0.2)
    end
    local Attack = u279.Attack
    if Attack then
        Attack.Looped = false
        Attack.Priority = Enum.AnimationPriority.Action
    end
    u279:SetHealth(true)
    u279:ApplyScale(u279.Scale, 0)
    u279.Model:PivotTo((u279:RestingFrame()))
    if not u279.SpawnRoared then
        u279:SetFade(1)
    end
    v2:Add(function() -- Line: 407 -- upvalues: u279 (val)
        for i, j in u279.Beams do
            j.FX:Destroy()
        end
        table.clear(u279.Beams)
    end)
    return u279
end

function u81:RestingFrame() -- Line: 416 -- upvalues: GhostBoss (val), GhostBossFlags (val)
    return (CFrame.new((GhostBoss.Center(self.Ground, self.Scale, self.HalfHeight, GhostBossFlags.HoverStuds:Get())))) * CFrame.Angles(0, self.Yaw + 0, 0)
end

function u81.SetLocalSucking(a1, a2) -- Line: 422 -- types: a2: boolean
    a1.LocalSucking = a2
end

function u81:InReach(a2) -- Line: 426 -- upvalues: LocalPlayer (val), GhostBossFlags (val) -- types: a2: number?
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local Position = (self.Model:GetPivot()).Position
        local v1 = self.HalfHeight * self.AppliedScale
        return (Position - HumanoidRootPart.Position).Magnitude - v1 <= (GhostBossFlags.VacuumReachStuds:Get()) * (a2 or 1)
    end
    return false
end

function u81.InCone(a1, a2) -- Line: 438 -- upvalues: LocalPlayer (val), GhostBossFlags (val) -- types: a2: vector?
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local v1
        local v2 = (a1.Model:GetPivot().Position - HumanoidRootPart.Position) * Vector3.new(1, 0, 1)
        if v2.Magnitude < a1.HalfHeight * a1.AppliedScale then
            return true
        end
        local v3 = math.cos((math.rad((GhostBossFlags.VacuumConeDegrees:Get()) / 2)))
        for i, j in {HumanoidRootPart.CFrame.LookVector, a2 or Vector3.new(0, 0, 0)} do
            v1 = j * Vector3.new(1, 0, 1)
            if 0.001 <= v1.Magnitude and v3 <= v1.Unit:Dot(v2.Unit) then
                return true
            end
        end
        return false
    end
    return false
end

function u81.IsFinished(a1) -- Line: 458
    return a1.Finished
end

function u81.GetPhase(a1) -- Line: 462
    return a1.Phase
end

function u81.SetPhase(a1, a2) -- Line: 466
    -- upvalues: Workspace (val), Phases (val), sound (val), Audio (val), Shake (val)
    local v1
    if a2 == a1.Phase then
        return
    end
    local Phase = a1.Phase
    a1.Phase = a2
    a1.PhaseAt = Workspace:GetServerTimeNow()
    if a2 == Phases.Capturing then
        a1.CaptureFrom = a1.Model:GetPivot()
        a1.CaptureScale = a1.AppliedScale
        a1:PlayAttack(1.25)
        v1 = sound("Sounds", "ScrambleBoss", "Roar")
        local Position = (a1.Model:GetPivot()).Position
        if v1 then
            Audio.Play(v1, Position, {Volume = 0.8, PlaybackSpeed = 1.35, MaxDistance = 260})
        end
        Shake.Play({
            Seconds = 0.5,
            Magnitude = 0.5,
            Shape = "Pulse",
            Range = {Near = 40, Far = 160, Center = a1.Model:GetPivot().Position},
        })
        return
    end
    if a2 == Phases.Defeated then
        if Phase ~= Phases.Capturing then
            a1.CaptureFrom = a1.Model:GetPivot()
            a1.CaptureScale = a1.AppliedScale
        end
        a1:Explode()
        return
    end
    if a2 == Phases.Escaped then
        a1:StopAura()
        a1:PlayAttack(0.8)
        v1 = sound("Sounds", "ScrambleBoss", "Swoosh")
        local Position_2 = (a1.Model:GetPivot()).Position
        if v1 then
            Audio.Play(v1, Position_2, {Volume = 0.9, PlaybackSpeed = 0.7, MaxDistance = 260})
        end
    end
end

function u81:StopAura() -- Line: 497
    for i, j in self.Aura do
        j.Enabled = false
    end
end

function u81:PlayAttack(a2) -- Line: 503 -- types: a2: number
    local Attack = self.Attack
    if Attack then
        Attack:Play(0.1, 1, a2)
    end
end

function u81:SetHealth(a2) -- Line: 510
    -- upvalues: Attributes (val), TweenService (val), u72 (val), u80 (val)
    local Bar = self.Bar
    local Attribute = self.State:GetAttribute(Attributes.Health)
    local v1 = if type(Attribute) ~= "number" then 0 else Attribute
    local Attribute_2 = self.State:GetAttribute(Attributes.MaxHealth)
    local v2 = math.max(if type(Attribute_2) ~= "number" then 1 else Attribute_2, 1)
    if v1 < self.ShownHealth - 0.01 then
        self.PunchAt = os.clock()
    end
    self.ShownHealth = v1
    if Bar == nil then
        return
    end
    local v3 = math.clamp(v1 / v2, 0, 1)
    local v4 = UDim2.fromScale(v3, Bar.Bar.Size.Y.Scale)
    Bar.Label.Text = ("%*/%*"):format(math.max(math.ceil(v1), 0), (math.ceil(v2)))
    if a2 then
        Bar.Bar.Size = v4
        Bar.Phantom.Size = UDim2.fromScale(v3, Bar.Phantom.Size.Y.Scale)
        return
    end
    TweenService:Create(Bar.Bar, u72, {Size = v4}):Play()
    TweenService:Create(Bar.Phantom, u80, {Size = UDim2.fromScale(v3, Bar.Phantom.Size.Y.Scale)}):Play()
end

function u81:ApplyScale(a2, a3) -- Line: 535 -- types: a2: number, a3: number
    if 0.004 < (math.abs(a2 - self.AppliedScale)) then
        self.Model:ScaleTo((math.max(a2, 0.01)))
        self.AppliedScale = a2
    end
    local Bar = self.Bar
    if Bar then
        local v1 = a2 * (a3 + 1)
        Bar.Gui.Size = UDim2.new(Bar.BaseSize.X.Scale * v1, 0, Bar.BaseSize.Y.Scale * v1, 0)
        Bar.Gui.StudsOffset = Bar.BaseOffset * a2
    end
end

function u81:SetFade(a2) -- Line: 548 -- types: a2: number
    for i, j in self.Parts do
        i.Transparency = j + (1 - j) * a2
    end
    local Bar = self.Bar
    if Bar then
        Bar.Gui.Enabled = a2 < 0.95
    end
end

function u81:StepBeams(a2, a3, a4) -- Line: 558
    -- upvalues: GhostBoss (val), Attributes (val), LocalPlayer (val), nozzleOf (val), SuckFX (val)
    local v1, v2
    local v3 = os.clock()
    local v4 = {}
    if not a4 then
        v4 = GhostBoss.DecodeSuckers(self.State:GetAttribute(Attributes.Suckers))
        if self.LocalSucking and not table.find(v4, LocalPlayer.UserId) and self:InReach() then
            table.insert(v4, LocalPlayer.UserId)
        end
    else
        table.insert(v4, a4)
    end
    local v5 = nil
    local v6 = nil
    local v7, v8, v9 = self, a3, a2
    for i, j in v4, v5, v6 do
        if i > 6 then
            break
        end
        v1 = nozzleOf(j)
        if v1 ~= nil then
            v2 = v7.Beams[j]
            if v2 == nil then
                v2 = {FX = SuckFX.new(v7.Model), SeenAt = v3}
                v7.Beams[j] = v2
            end
            v2.SeenAt = v3
            v2.FX:Update(v1, v8, v9)
        end
    end
    for k, n in v7.Beams do
        if n.SeenAt ~= v3 then
            n.FX:Update(nil, 0, v9)
            if 1.2 < v3 - n.SeenAt then
                n.FX:Destroy()
                v7.Beams[k] = nil
            end
        end
    end
end

function u81:Explode() -- Line: 596
    -- upvalues: Attributes (val), nozzleOf (val), SuckFX (val), Workspace (val), Burst (val)
    if self.Exploded then
        return
    end
    self.Exploded = true
    local Attribute = self.State:GetAttribute(Attributes.CaptureUserId)
    local v1 = if type(Attribute) ~= "number" then 0 else Attribute
    local v2 = if not (v1 > 0) then nil else nozzleOf(v1)
    if v2 then
        SuckFX.Burst(v2)
    end
    self:StopAura()
    for i, j in self.Beams do
        j.FX:Destroy()
    end
    table.clear(self.Beams)
    if self.Bar then
        self.Bar.Gui.Enabled = false
    end
    local State_2 = self.State
    local DefeatAt = Attributes.DefeatAt
    local ServerTimeNow = Workspace:GetServerTimeNow()
    v1 = State_2:GetAttribute(DefeatAt)
    v2 = if type(v1) ~= "number" then ServerTimeNow else v1
    if 1.5 < Workspace:GetServerTimeNow() - v2 then
        self:SetFade(1)
        self.Finished = true
        return
    end
    v2 = self.State:GetAttribute(Attributes.ExplodePosition)
    self.RupturePoint = (if typeof(v2) ~= "Vector3" then nil else v2) or self.Model:GetPivot().Position
    self.RuptureFrom = self.Model:GetPivot()
    self.RuptureScale = self.AppliedScale
    self.RuptureAt = os.clock()
    Burst.Rupture(self.RupturePoint)
end

function u81:StepRupture() -- Line: 628
    -- upvalues: Burst (val), TweenService (val), u61 (val), u66 (val), Attributes (val)
    local RuptureFrom = self.RuptureFrom
    if RuptureFrom == nil then
        return
    end
    local v1 = math.clamp((os.clock() - self.RuptureAt) / Burst.RuptureSeconds, 0, 1)
    local Value = TweenService:GetValue(v1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local Value_2 = TweenService:GetValue(v1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v2 = math.max(self.RuptureScale + (0.6 - self.RuptureScale) * Value, 0.01)
    local v3 = self.Clock * 40
    local v4 = Vector3.new(math.noise(v3, 1.3), math.noise(v3, 2.9), (math.noise(v3, 4.7))) * 0.9 * v1 * v2
    v3 = RuptureFrom.Position:Lerp(self.RupturePoint + Vector3.new(0, 1.5, 0), Value_2)
    self:ApplyScale(v2, 0)
    self.Glow.FillColor = u61:Lerp(u66, v1)
    self.Glow.FillTransparency = (1 - v1) * 0.6
    self.Glow.OutlineTransparency = (1 - v1) * 0.35
    self.Model:PivotTo((CFrame.new(v3 + v4)) * RuptureFrom.Rotation * (CFrame.Angles(0, Value * 0.6, (math.sin(self.Clock * 35)) * 0.12 * v1)))
    if v1 < 1 then
        return
    end
    self.RuptureFrom = nil
    Burst.Shatter(self.Model, self.Model:GetPivot().Position, v2)
    local Explode = Burst.Explode
    local RupturePoint = self.RupturePoint
    v4 = self.State:GetAttribute(Attributes.DropPosition)
    Explode(RupturePoint, if typeof(v4) ~= "Vector3" then nil else v4)
    self:SetFade(1)
    self.Glow.Enabled = false
    self.Finished = true
end

function u81.Step(a1, a2) -- Line: 663
    -- upvalues: Phases (val), Attributes (val), AttackPhases (val), GhostBoss (val), LocalPlayer (val), Shake (val)
    -- upvalues: Workspace (val), GhostBossFlags (val), Burst (val), sound (val), Audio (val), captorPoint (val)
    -- upvalues: u61 (val), u66 (val), SuckFX (val)
    local v1, v2, v3, v4, v5, v6
    if a1.Finished and a1.Phase ~= Phases.Escaped then
        return
    end
    a1.Clock = a1.Clock + a2
    local State = a1.State
    local Attribute = State:GetAttribute(Attributes.Health)
    if 0.01 < (math.abs((if type(Attribute) ~= "number" then 0 else Attribute) - a1.ShownHealth)) then
        a1:SetHealth()
    end
    local Attribute_2 = State:GetAttribute(Attributes.AttackPhase)
    if type(Attribute_2) ~= "string" then
        Attribute_2 = AttackPhases.None
    end
    if Attribute_2 ~= a1.AttackPhase then
        a1.AttackPhase = Attribute_2
        if Attribute_2 == AttackPhases.Windup then
            a1:PlayAttack(0.35)
        end
    end
    local Attribute_3 = State:GetAttribute(Attributes.AttackSerial)
    local v7 = if type(Attribute_3) ~= "number" then 0 else Attribute_3
    if a1.AttackSerial < v7 then
        a1.AttackSerial = v7
        if a1.Attack then
            a1.Attack:Stop(0)
        end
        a1:PlayAttack(1)
        if table.find(GhostBoss.DecodeSuckers(State:GetAttribute(Attributes.AttackHits)), LocalPlayer.UserId) then
            Shake.Play({Seconds = 0.4, Magnitude = 0.8, Shape = "Fade"})
        end
    end
    v7 = Attribute_2 ~= AttackPhases.None
    local Lean = a1.Lean
    a1.Lean = Lean + ((if Attribute_2 ~= AttackPhases.Windup then if Attribute_2 ~= AttackPhases.Charge then 0 else -0.22 else 0.35) - Lean) * (1 - math.exp(a2 * -10))
    local Ground = a1.Ground
    local Attribute_4 = State:GetAttribute(Attributes.Ground)
    local v8 = (if typeof(Attribute_4) ~= "Vector3" then nil else Attribute_4) or Ground
    local Attribute_5 = State:GetAttribute(Attributes.Velocity)
    local v9 = if typeof(Attribute_5) ~= "Vector3" then nil else Attribute_5
    if v9 ~= nil then
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local Attribute_6 = State:GetAttribute(Attributes.MovedAt)
        v6 = v8 + v9 * math.clamp(ServerTimeNow - (if type(Attribute_6) ~= "number" then ServerTimeNow else Attribute_6), 0, 0.3)
    else
        v6 = v8
    end
    a1.Ground = if not (40 < (v6 - a1.Ground).Magnitude) then a1.Ground:Lerp(v6, 1 - (math.exp(a2 * -8))) else v6
    local Ground_4 = a1.Ground
    local Attribute_7 = State:GetAttribute(Attributes.Suckers)
    v8 = false
    if type(Attribute_7) == "string" then
        v8 = Attribute_7 ~= ""
    end
    local Struggle = a1.Struggle
    a1.Struggle = Struggle + ((if not v8 then 0 else 1) - Struggle) * (1 - math.exp(a2 * -6))
    local v10 = State:GetAttribute(Attributes.MaxHealth)
    v8 = math.max(if type(v10) ~= "number" then 1 else v10, 1)
    v9 = GhostBossFlags.CaptureHealthFraction:Get()
    local v11 = GhostBossFlags.StartScale:Get()
    local v12 = GhostBossFlags.HoverStuds:Get()
    local v13 = math.clamp(v5 / v8, 0, 1)
    v8 = GhostBoss.ScaleFor(v13, v9, v11)
    v11 = GhostBoss.CaptureProgress(v13, v9)
    local Yaw = a1.Yaw
    local Yaw_2 = Attributes.Yaw
    local Yaw_3 = a1.Yaw
    v13 = State:GetAttribute(Yaw_2)
    a1.Yaw = Yaw + (((if type(v13) ~= "number" then Yaw_3 else v13) - Yaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * (1 - math.exp(-(if not v7 then 3 else 12) * a2))
    v7 = os.clock() - a1.PunchAt
    v5 = if not (v7 < 0.18) then 0 else 0.12 * (1 - v7 / 0.18)
    v7 = math.sin(a1.Clock * 1.7) * 0.7
    local v14 = math.sin(a1.Clock * 0.9) * 0.08
    local Phase = a1.Phase
    if Phase ~= Phases.Spawning and Phase ~= Phases.Alive then
        if Phase ~= Phases.Capturing then
            if Phase == Phases.Escaped then
                v1 = math.clamp(((Workspace:GetServerTimeNow()) - a1.PhaseAt) / 1.6, 0, 1)
                v2 = GhostBoss.Center(Ground_4, a1.Scale, a1.HalfHeight, v12)
                a1:SetFade(v1)
                a1:ApplyScale(a1.Scale * (v1 * 0.3 + 1), 0)
                a1.Model:PivotTo((CFrame.new(v2 + Vector3.new(0, v1 * v1 * 36, 0))) * (CFrame.Angles(0, a1.Yaw + 0 + v1 * 6.283185307179586, 0)))
                a1:StepBeams(a2, 0, nil)
                if not (v1 >= 1) then
                    return
                end
                a1.Finished = true
                return
            end
            if Phase == Phases.Defeated then
                a1:StepRupture()
            end
            return
        end
        local Attribute_8 = State:GetAttribute(Attributes.CaptureUserId)
        v1 = if type(Attribute_8) ~= "number" then 0 else Attribute_8
        local Attribute_9 = State:GetAttribute(Attributes.CaptureSeconds)
        v2 = math.max(if type(Attribute_9) ~= "number" then 1 else Attribute_9, 0.1)
        local ServerTimeNow_2 = Workspace:GetServerTimeNow()
        local CaptureAt = Attributes.CaptureAt
        local ServerTimeNow_3 = Workspace:GetServerTimeNow()
        local Attribute_10 = State:GetAttribute(CaptureAt)
        v3 = math.clamp((ServerTimeNow_2 - (if type(Attribute_10) ~= "number" then ServerTimeNow_3 else Attribute_10)) / v2, 0, 1)
        local CaptureFrom = a1.CaptureFrom or a1.Model:GetPivot()
        v4 = if not (v1 > 0) then nil else captorPoint(v1)
        local v15 = math.clamp((v3 - 0.22) / 0.78, 0, 1)
        v3 = v15 * v15 * v15
        local v16 = a1.CaptureScale + (0.04 - a1.CaptureScale) * v3
        local Position = if not v4 then CaptureFrom.Position else CaptureFrom.Position:Lerp(v4, v3)
        v4 = (1 - v15) * 0.6 * a1.CaptureScale
        local v17 = a1.Clock * 18
        local v18 = Position + Vector3.new(math.noise(v17, 1.1), math.noise(v17, 2.3), (math.noise(v17, 3.7))) * v4
        a1:ApplyScale(v16, 0)
        a1.Glow.FillColor = u61:Lerp(u66, v3)
        a1.Glow.FillTransparency = 0.6 - v3 * 0.5
        a1.Model:PivotTo((CFrame.new(v18)) * CaptureFrom.Rotation * (CFrame.Angles(0, SuckFX.CaptureSpin(v3), math.sin(a1.Clock * 30) * 0.15 * (1 - v15))))
        if a1.Bar then
            a1.Bar.Gui.Enabled = v15 < 0.15
        end
        a1:StepBeams(a2, 1, if not (v1 > 0) then nil else v1)
        return
    end
    local Attribute_11 = State:GetAttribute(Attributes.SpawnedAt)
    v1 = if type(Attribute_11) ~= "number" then 0 else Attribute_11
    local Attribute_12 = State:GetAttribute(Attributes.SpawnSeconds)
    v2 = math.max(if type(Attribute_12) ~= "number" then 1 else Attribute_12, 0.1)
    v3 = math.clamp((Workspace:GetServerTimeNow() - v1) / v2, 0, 1)
    if not a1.SpawnPuffed and v3 < 0.5 then
        a1.SpawnPuffed = true
        Burst.SpawnPuff(Ground_4)
    end
    if not a1.SpawnRoared and v3 >= 0.55 then
        a1.SpawnRoared = true
        a1:PlayAttack(1)
        v4 = sound("Sounds", "MonsterParasite", "Roar")
        if v4 then
            Audio.Play(v4, Ground_4, {Volume = 0.75, PlaybackSpeed = 1.15, MaxDistance = 260})
        end
    end
    v2 = (1 - v3) ^ 2 * 14
    v1 = 1 - (1 - v3) ^ 3
    if not (v3 < 1) then
        local Scale = a1.Scale
        v4 = Scale + (v8 - Scale) * (1 - math.exp(a2 * -6))
    else
        v4 = v8 * (v1 * 0.85 + 0.15)
    end
    a1.Scale = v4
    a1:ApplyScale(a1.Scale, v5)
    a1:SetFade(1 - (math.clamp(v3 * 1.6, 0, 1)))
    a1.Glow.FillTransparency = 0.85 - (1 - v3) * 0.6 - 0.25 * v11 - math.max(a1.Lean, 0) * 0.3 / 0.35
    v3 = GhostBoss.Center(Ground_4, a1.Scale, a1.HalfHeight, v12)
    v1 = a1.Clock * 9
    a1.Model:PivotTo((CFrame.new(v3 + Vector3.new(math.noise(v1, 4.1), 0, (math.noise(v1, 5.3))) * 0.6 * a1.Struggle * a1.Scale + Vector3.new(0, v7 * a1.Scale - v2, 0))) * CFrame.Angles(0, a1.Yaw + 0, 0) * (CFrame.Angles(a1.Lean, 0, v14 * (1 + a1.Struggle))))
    a1:StepBeams(a2, 0.25 + 0.75 * v11, nil)
end

function u81:Destroy() -- Line: 824
    self.Trove:Destroy()
end

return u81