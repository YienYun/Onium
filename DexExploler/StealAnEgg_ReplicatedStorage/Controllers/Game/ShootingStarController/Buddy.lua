-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.Buddy
-- Decompile time: 27.16 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CalmLoop = require(script.Parent.CalmLoop)
local Fx = require(script.Parent.Fx)
local ShootingStarFlags = require(ReplicatedStorage.Shared.Flags.ShootingStarFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u44 = {0.8, 1.62}
local LocalPlayer = Players.LocalPlayer
local u48 = {}
u48.__index = u48

local function now() -- Line: 79 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function legPace(a1) -- Line: 83 -- upvalues: ShootingStarFlags (val) -- types: a1: table
    local v1 = a1.ArriveAt - a1.StartAt
    if v1 <= 0 then
        return 0
    end
    return Vector3.new(a1.To.X - a1.From.X, 0, a1.To.Z - a1.From.Z).Magnitude / v1 / math.max(ShootingStarFlags.WalkSpeedStuds:Get(), 1)
end

local function legPosition(a1, a2) -- Line: 92 -- types: a1: table, a2: number
    local v1 = a1.ArriveAt - a1.StartAt
    if v1 <= 0 then
        return a1.To
    end
    return a1.From:Lerp(a1.To, (math.clamp((a2 - a1.StartAt) / v1, 0, 1)))
end

local function angleTowards(a1, a2, a3) -- Line: 100 -- types: a1: number, a2: number, a3: number
    return a1 + ((a2 - a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * a3
end

local function yawOf(a1) -- Line: 105 -- types: a1: vector
    local v1 = Vector3.new(a1.X, 0, a1.Z)
    if v1.Magnitude < 0.001 then
        return nil
    end
    return (math.atan2(-v1.X, -v1.Z))
end

local function hopCurve(a1, a2, a3) -- Line: 113 -- types: a1: number, a2: number, a3: number
    local v1 = math.clamp(a1 / a2, 0, 1)
    return v1 * 4 * (1 - v1) * a3
end

local function playerRoot() -- Line: 118 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function kitChild(a1) -- Line: 124 -- upvalues: Fx (val) -- types: a1: string
    return (Fx.Kit():FindFirstChild(a1))
end

function u48.Spawn(a1, a2) -- Line: 133 -- upvalues: Fx (val) -- types: a1: userdata, a2: userdata
    local v1 = Fx.Kit():FindFirstChild("Buddy"):Clone()
    v1:PivotTo(a2)
    v1.Parent = a1
    return v1
end

function u48.Tracks(a1) -- Line: 140 -- types: a1: userdata
    local v1 = {}
    local AnimationController = a1:FindFirstChildOfClass("AnimationController")
    local Animator = AnimationController
    if Animator then
        Animator = AnimationController:FindFirstChildOfClass("Animator")
    end
    local v2 = a1:FindFirstChild("Animations")
    if Animator ~= nil and v2 ~= nil then
        local err, success
        for i, j in v2:GetChildren() do
            if j:IsA("Animation") then
                success, err = pcall(function() -- Line: 150 -- upvalues: Animator (val), j (val)
                    return Animator:LoadAnimation(j)
                end)
                if success and err then
                    err.Looped = true
                    v1[j.Name] = err
                end
            end
        end
        return v1
    end
    return v1
end

function u48.CalmIdle(a1) -- Line: 162 -- upvalues: CalmLoop (val) -- types: a1: userdata
    local AnimationController = a1:FindFirstChildOfClass("AnimationController")
    local Animator = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
    local v1 = a1:FindFirstChild("Animations")
    local Idle = v1 and v1:FindFirstChild("Idle")
    if Animator ~= nil and Idle ~= nil and Idle:IsA("Animation") then
        local success, err = pcall(CalmLoop.new, Animator, Idle, 3)
        if success then
            return err
        end
        return nil
    end
    return nil
end

function u48.new(a1, a2, a3, a4, a5) -- Line: 174
    -- upvalues: Trove (val), u48 (val), RunService (val)
    local v1
    local v2 = Trove.new()
    local v3 = u48.Spawn(a1, CFrame.new(a2.To))
    local PrimaryPart = v3.PrimaryPart
    local Core = PrimaryPart:FindFirstChild("Core")
    local v4 = u48.Tracks(v3)
    local v5 = {}
    for i, j in {"Eyebalck", "eye"} do
        v1 = v3:FindFirstChild(j)
        if v1 and v1:IsA("BasePart") then
            v5[v1] = v1.Size
        end
    end
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.Name = "CatchPrompt"
    ProximityPrompt.ActionText = "Catch"
    ProximityPrompt.ObjectText = "Little Star"
    ProximityPrompt.HoldDuration = a4
    ProximityPrompt.MaxActivationDistance = 11
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    ProximityPrompt.Enabled = false
    ProximityPrompt.Parent = PrimaryPart
    v2:Connect(ProximityPrompt.PromptButtonHoldBegan, function() -- Line: 206 -- upvalues: a5 (val)
        a5.HoldBegan()
    end)
    v2:Connect(ProximityPrompt.PromptButtonHoldEnded, function() -- Line: 209 -- upvalues: a5 (val)
        a5.HoldEnded()
    end)
    v2:Connect(ProximityPrompt.Triggered, function() -- Line: 212 -- upvalues: a5 (val)
        a5.Triggered()
    end)
    local v6 = RaycastParams.new()
    v6.FilterType = Enum.RaycastFilterType.Exclude
    v6.RespectCanCollide = true
    v6.IgnoreWater = false
    local v7 = {
        Model = v3,
        Root = PrimaryPart,
        Leg = a2,
        Noticed = a3,
        Prompt = ProximityPrompt,
        _trove = v2,
        _core = Core,
        _tracks = v4,
        _eyes = v5,
        _params = v6,
        _parent = a1,
        _scale = v3:GetScale(),
        _groundOffset = v3:GetAttribute("GroundOffset") or -1.7,
        _groundY = a2.To.Y,
        _probeAt = 0,
        _probeX = (1 / 0),
        _probeZ = (1 / 0),
        _yaw = 0,
        _lookYaw = nil,
        _lookAt = 0,
        _hopAt = (-1 / 0),
        _hopHeight = 0,
        _hopSeconds = 0.35,
        _wobbleAt = (-1 / 0),
        _charge = 0,
        _lift = 0,
        _blinkAt = os.clock() + 2,
        _chatterAt = os.clock() + 4,
        _lastWalkTime = 0,
        _stepSide = 1,
        _override = nil,
        _moving = false,
        _running = false,
        _popping = false,
        _tug = nil,
        _gone = false,
        _detached = false,
        _idle = u48.CalmIdle(v3),
    }
    local u122 = setmetatable(v7, u48)
    if u122._idle then
        u122._idle:Play(0)
    end
    v2:Connect(RunService.RenderStepped, function(a1) -- Line: 265 -- upvalues: u122 (val) -- types: a1: number
        u122:_step(a1)
    end)
    u122:_refreshPrompt()
    return u122
end

function u48:_refreshFilter() -- Line: 272 -- upvalues: Players (val)
    local v1 = {self._parent}
    for i, j in Players:GetPlayers() do
        if j.Character then
            table.insert(v1, j.Character)
        end
    end
    self._params.FilterDescendantsInstances = v1
end

function u48:_ground(a2) -- Line: 282 -- upvalues: Workspace (val) -- types: a2: vector
    local v1 = os.clock()
    local v2 = (math.abs(a2.X - self._probeX)) + math.abs(a2.Z - self._probeZ)
    if v1 - self._probeAt < 0.08 and v2 < 0.6 then
        return self._groundY
    end
    self._probeAt = v1
    self._probeX = a2.X
    self._probeZ = a2.Z
    self:_refreshFilter()
    v2 = Vector3.new(a2.X, a2.Y + 20, a2.Z)
    local v3 = Workspace
    local _params = self._params
    v1 = v3:Raycast(v2, Vector3.new(0, -60, 0), _params)
    if v1 then
        return v1.Position.Y
    end
    return a2.Y
end

function u48:_blink() -- Line: 297
    local X, v1
    for i, j in self._eyes do
        if i.Parent then
            X = j.X
            v1 = j.Y * 0.12
            i.Size = Vector3.new(X, v1, j.Z)
        end
    end
    task.delay(0.11, function() -- Line: 303 -- upvalues: self (val)
        for i, j in self._eyes do
            if i.Parent then
                i.Size = j
            end
        end
    end)
end

function u48:_footprint(a2, a3) -- Line: 312 -- upvalues: Fx (val), TweenService (val) -- types: a2: vector, a3: number
    local u13 = Fx.Kit():FindFirstChild("Footprint"):Clone()
    local v1 = CFrame.Angles(0, a3, 0).RightVector * 0.3 * self._stepSide * self._scale
    u13.Size = Vector3.new(1.399999976158142, 0.05000000074505806, 1.399999976158142) * self._scale
    u13.CFrame = (CFrame.new(a2 + v1 + Vector3.new(0, 0.05999999865889549, 0))) * CFrame.Angles(0, a3 + math.rad((math.random(-25, 25))), 0)
    u13.Parent = self._parent
    v1 = u13:FindFirstChildOfClass("Decal")
    if v1 then
        TweenService:Create(v1, TweenInfo.new(2.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
    end
    task.delay(2.7, function() -- Line: 328 -- upvalues: u13 (val)
        u13:Destroy()
    end)
end

function u48:_hop(a2, a3) -- Line: 333 -- types: a2: number, a3: number
    self._hopAt = os.clock()
    self._hopHeight = a2 * self._scale
    self._hopSeconds = a3
end

function u48:_refreshPrompt() -- Line: 339
    local Prompt = self.Prompt
    local Noticed = self.Noticed and not self._popping and not self._gone
    Prompt.Enabled = Noticed
end

function u48:_step(a2) -- Line: 343
    -- upvalues: Workspace (val), LocalPlayer (val), ShootingStarFlags (val), u44 (val), Fx (val)
    local _lookYaw, v1, v2, v3, v4, v5, v6
    local v7 = os.clock()
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local Leg = self.Leg
    local v8 = Leg.ArriveAt - Leg.StartAt
    local To = if not (v8 <= 0) then Leg.From:Lerp(Leg.To, (math.clamp((ServerTimeNow - Leg.StartAt) / v8, 0, 1))) else Leg.To
    v8 = false
    if ServerTimeNow < Leg.ArriveAt then
        v8 = 0.1 < (Leg.To - Leg.From).Magnitude
    end
    local _scale = self._scale
    if self._override then
        self.Root.CFrame = self._override
        return
    end
    local v9 = self:_ground(To)
    if not (12 < (math.abs(v9 - self._groundY))) then
        self._groundY = self._groundY + (v9 - self._groundY) * (1 - math.exp(a2 * -14))
    else
        self._groundY = v9
    end
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    v9 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    if v8 then
        v6 = Leg.To - Leg.From
        v3 = Vector3.new(v6.X, 0, v6.Z)
        _lookYaw = if not (v3.Magnitude < 0.001) then math.atan2(-v3.X, -v3.Z) else nil
        self._lookYaw = nil
    elseif not self.Noticed or not v9 then
        if self._lookAt < v7 then
            self._lookAt = v7 + math.random() * 2 + 1.6
            self._lookYaw = self._yaw + (math.random() * 2 - 1) * 0.9599310885968813
        end
        _lookYaw = self._lookYaw
    else
        v6 = v9.Position - To
        v3 = Vector3.new(v6.X, 0, v6.Z)
        _lookYaw = if not (v3.Magnitude < 0.001) then math.atan2(-v3.X, -v3.Z) else nil
    end
    if _lookYaw then
        local _yaw = self._yaw
        v5 = 1 - math.exp(a2 * -9)
        self._yaw = _yaw + ((_lookYaw - _yaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v5
    end
    local Walk = self._tracks.Walk
    local _idle = self._idle
    if v8 ~= self._moving then
        self._moving = v8
        if Walk and _idle then
            if not v8 then
                _idle:Play(0.25)
                Walk:Stop(0.25)
            else
                Walk:Play(0.2)
                _idle:Stop(0.2)
            end
        end
    end
    if not v8 or not Walk then
        v1, v2 = self, a2
    else
        local v10 = Leg.ArriveAt - Leg.StartAt
        Walk:AdjustSpeed((math.clamp(
            if not (v10 <= 0) then Vector3.new(Leg.To.X - Leg.From.X, 0, Leg.To.Z - Leg.From.Z).Magnitude / v10 / math.max(ShootingStarFlags.WalkSpeedStuds:Get(), 1) else 0,
            1,
            2.4
        )))
        local TimePosition = Walk.TimePosition
        v5 = nil
        local v11 = nil
        v1, v2 = self, a2
        for i, j in u44, v5, v11 do
            if v1._lastWalkTime < j and j <= TimePosition then
                v1._stepSide = -v1._stepSide
                Fx.Sound(if not (0 < v1._stepSide) then "BuddyStep2" else "BuddyStep1", v1.Root, nil, 0.9 + math.random() * 0.35)
                v1:_footprint(Vector3.new(To.X, v1._groundY, To.Z), v1._yaw)
            end
        end
        v1._lastWalkTime = TimePosition
    end
    if _idle then
        _idle:SetSpeed(1 + v1._charge * 1.6)
        _idle:Step(v1.Noticed or 0 < v1._charge)
    end
    if v1._blinkAt < v7 then
        v1._blinkAt = v7 + 2.2 + math.random() * 3
        v1:_blink()
    end
    if not v8 and v9 and v1._chatterAt < v7 and v1._charge <= 0 then
        v1._chatterAt = v7 + 5 + math.random() * 5
        if (v9.Position - To).Magnitude < 45 then
            Fx.Sound(if not (math.random() < 0.5) then "BuddyChatter2" else "BuddyChatter1", v1.Root, nil, 1.45 + math.random() * 0.25)
            v1:_hop(0.9, 0.3)
        end
    end
    v3 = v7 - v1._hopAt
    local _hopSeconds = v1._hopSeconds
    local _hopHeight = v1._hopHeight
    local v12 = math.clamp(v3 / _hopSeconds, 0, 1)
    v6 = v12 * 4 * (1 - v12) * _hopHeight
    v9 = v7 - v1._wobbleAt
    v8 = if not (v9 < 0.6) then 0 else (math.sin(v9 * 30)) * (1 - v9 / 0.6) * 0.24434609527920614
    local _charge_2 = v1._charge
    local v13 = Vector3.new(0, 0, 0)
    local identity = CFrame.identity
    if _charge_2 > 0 then
        v4 = v7 * 47
        v5 = (_charge_2 * 0.28 + 0.05) * _scale
        v13 = Vector3.new(math.noise(v4, 1.3), math.noise(v4, 2.7) * 0.5, (math.noise(v4, 3.1))) * v5
        identity = CFrame.Angles(0, 0, (math.noise(v4, 4.2)) * math.rad(_charge_2 * 10 + 4))
    end
    v4 = _charge_2 ^ 1.4 * 4.5 * _scale / 0.72
    v9 = if not (v1._lift < v4) then 4 else 10
    v1._lift = v1._lift + (v4 - v1._lift) * (1 - math.exp(-v9 * v2))
    v4 = math.sin(v7 * 3.2) * 0.18 * math.min(v1._lift, 1)
    v9 = Vector3.new(To.X, v1._groundY + v1._groundOffset * _scale + v6 + v1._lift + v4, To.Z)
    v1.Root.CFrame = (CFrame.new(v9 + v13)) * CFrame.Angles(0, v1._yaw, 0) * CFrame.Angles(0, 0, v8) * identity
end

function u48.Position(a1) -- Line: 470
    return a1.Root.Position
end

function u48.SetLeg(a1, a2, a3) -- Line: 474
    -- upvalues: ShootingStarFlags (val), Fx (val)
    local Noticed = a1.Noticed
    a1.Leg = a2
    a1.Noticed = a3
    local v1 = not a3
    if v1 then
        local v2 = a2.ArriveAt - a2.StartAt
        v1 = (if not (v2 <= 0) then Vector3.new(a2.To.X - a2.From.X, 0, a2.To.Z - a2.From.Z).Magnitude / v2 / math.max(ShootingStarFlags.WalkSpeedStuds:Get(), 1) else 0) >= 1.3
    end
    local v3 = v1 and not a1._running
    a1._running = v1
    if not v3 or a1._popping then
        if not a3 or Noticed then
            if Noticed and not a3 and not a1._gone then
                Fx.Sound("BuddyHuh", a1.Root, nil, 1.4)
                a1._wobbleAt = os.clock()
            end
        elseif not a1._popping then
            Fx.Sound("BuddyNotice", a1.Root, nil, 1.15 + math.random() * 0.15)
            a1:_hop(1.6, 0.36)
            a1:_mark()
        elseif Noticed and not a3 and not a1._gone then
            Fx.Sound("BuddyHuh", a1.Root, nil, 1.4)
            a1._wobbleAt = os.clock()
        end
    elseif not a1._gone then
        Fx.Sound("BuddyHuh", a1.Root, nil, 1.7 + math.random() * 0.15)
        a1:_hop(1.1, 0.28)
    elseif not a3 or Noticed then
        if Noticed and not a3 and not a1._gone then
            Fx.Sound("BuddyHuh", a1.Root, nil, 1.4)
            a1._wobbleAt = os.clock()
        end
    elseif not a1._popping then
        Fx.Sound("BuddyNotice", a1.Root, nil, 1.15 + math.random() * 0.15)
        a1:_hop(1.6, 0.36)
        a1:_mark()
    elseif Noticed and not a3 and not a1._gone then
        Fx.Sound("BuddyHuh", a1.Root, nil, 1.4)
        a1._wobbleAt = os.clock()
    end
    a1:_refreshPrompt()
end

function u48:_mark() -- Line: 495 -- upvalues: Fx (val), TweenService (val)
    local u15 = (Fx.Kit():FindFirstChild("Ui")):FindFirstChild("Notice"):Clone()
    u15.Adornee = self.Root
    u15.StudsOffsetWorldSpace = Vector3.new(0, 6 * self._scale / 0.72, 0)
    u15.Enabled = true
    u15.Parent = self.Model
    local u31 = u15:FindFirstChild("Mark")
    local UIScale = u31:FindFirstChildOfClass("UIScale")
    UIScale.Scale = 0
    TweenService:Create(UIScale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    task.delay(1.1, function() -- Line: 510 -- upvalues: u15 (val), TweenService (upval), u31 (val), UIScale (val)
        if u15.Parent == nil then
            return
        end
        local v1 = TweenService:Create(u31, TweenInfo.new(0.3), {TextTransparency = 1})
        v1:Play()
        TweenService:Create(UIScale, TweenInfo.new(0.3), {Scale = 0.6}):Play()
        v1.Completed:Wait()
        u15:Destroy()
    end)
end

function u48.PopOut(a1) -- Line: 522 -- upvalues: Fx (val), RunService (val)
    a1._popping = true
    a1:_refreshPrompt()
    local u6 = os.clock()
    local To = a1.Leg.To
    local _scale = a1._scale
    local u14 = if not (math.random() < 0.5) then 1 else -1
    local u15 = {}
    local _trove = a1._trove
    Fx.Sound("BuddyPop", To, 0.9)
    a1.Model:ScaleTo(_scale * 0.25)

    local function makeDizzy() -- Line: 534 -- upvalues: a1 (val), _trove (val), u15 (val)
        local BillboardGui, ImageLabel, Part, v1
        for i = 1, 3 do
            Part = Instance.new("Part")
            Part.Name = "Dizzy"
            Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
            Part.Transparency = 1
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            BillboardGui = Instance.new("BillboardGui")
            BillboardGui.Size = UDim2.fromScale(0.9, 0.9)
            BillboardGui.LightInfluence = 0
            BillboardGui.Parent = Part
            ImageLabel = Instance.new("ImageLabel")
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Size = UDim2.fromScale(1, 1)
            ImageLabel.Image = "rbxassetid://97372292402278"
            v1 = if i ~= 2 then Color3.fromRGB(255, 226, 110) else Color3.fromRGB(255, 190, 220)
            ImageLabel.ImageColor3 = v1
            ImageLabel.Parent = BillboardGui
            Part.Parent = a1._parent
            _trove:Add(Part)
            table.insert(u15, Part)
        end
    end

    local u32 = nil
    local u33 = false
    local u34 = false
    _trove:Connect(RunService.RenderStepped, function() -- Line: 565
        -- upvalues: u6 (val), a1 (val), _scale (val), To (val), u14 (val), u33 (ref), Fx (upval), makeDizzy (val)
        -- upvalues: u15 (val), u34 (ref), u32 (ref)
        local new_2, v1, v2
        local v3 = os.clock() - u6
        local _groundY = a1._groundY
        if v3 < 0.75 then
            local v4 = v3 / 0.75
            local v5 = math.min(v4 * 1.6, 1) * 0.75 + 0.25
            a1.Model:ScaleTo(_scale * v5)
            local v6 = _scale * 6.5
            local v7 = math.clamp(v3 / 0.75, 0, 1)
            local v8 = v7 * 4 * (1 - v7) * v6
            a1._override = (CFrame.new(To.X, _groundY + a1._groundOffset * _scale * v5 + v8, To.Z)) * CFrame.Angles(0, a1._yaw + u14 * v4 * 3.141592653589793 * 4, 0)
            return
        end
        if not u33 then
            u33 = true
            a1._override = nil
            a1.Model:ScaleTo(_scale)
            Fx.Sound("BuddyBoing", a1.Root, 0.5, 1.15)
            Fx.Emit("Collect", Vector3.new(To.X, _groundY + 0.5, To.Z), 0.8)
            a1:_footprint(Vector3.new(To.X, _groundY, To.Z), a1._yaw)
            a1._wobbleAt = os.clock() + 0.05
            makeDizzy()
        end
        local v9 = v3 - 0.75
        v3 = a1.Root.Position + Vector3.new(0, _scale * 5.6 / 0.72, 0)
        for i, j in u15 do
            v2 = v9 * 6 + i * 3.141592653589793 * 2 / 3
            new_2 = CFrame.new
            v1 = Vector3.new(math.cos(v2) * 1.3, math.sin(v2 * 2) * 0.15, (math.sin(v2)) * 1.3)
            j.CFrame = new_2(v3 + v1 * _scale / 0.72)
        end
        if v9 < 1.5 then
            a1._wobbleAt = math.max(a1._wobbleAt, (os.clock()) - 0.3)
            return
        end
        if not u34 then
            u34 = true
            for k, n in u15 do
                Fx.Emit("Collect", n.Position, 0.35)
                n:Destroy()
            end
            table.clear(u15)
            Fx.Sound("BuddyGiggle", a1.Root, nil, 1.2)
            a1:_hop(1.2, 0.32)
            a1._wobbleAt = os.clock()
        end
        if v9 > 1.9 then
            u32:Disconnect()
            a1._popping = false
            a1:_refreshPrompt()
        end
    end)
end

function u48:Charge(a2) -- Line: 628 -- upvalues: Fx (val) -- types: a2: number
    local v1 = math.clamp(a2, 0, 1)
    self._charge = v1
    local Charge = self.Model:FindFirstChild("Charge")
    if Charge then
        Charge.Enabled = v1 > 0
        Charge.FillTransparency = 1 - v1 * 0.3
        Charge.OutlineTransparency = 1 - v1 * 0.6
    end
    local _core = self._core
    if _core then
        local Glow = _core:FindFirstChild("Glow")
        if Glow then
            Glow.Brightness = v1 * 0.6 + 1.2
            Glow.Range = v1 * 2 + 9
        end
        local Twinkles = _core:FindFirstChild("Twinkles")
        if Twinkles then
            Twinkles.Rate = v1 * 30 + 10
        end
    end
    if v1 > 0 and self._tug == nil then
        self._tug = Fx.Sound("BuddyTug", self.Root, nil, 0.9)
        if self._tug then
            self._tug.Looped = true
            self._trove:Add(self._tug)
        end
    end
    if self._tug then
        self._tug.PlaybackSpeed = v1 * 0.55 + 0.9
    end
end

function u48:Release(a2) -- Line: 661 -- upvalues: TweenService (val), Fx (val) -- types: a2: boolean
    local v1
    local _tug = self._tug
    self._tug = nil
    if _tug then
        v1 = TweenService:Create(_tug, TweenInfo.new(0.15), {Volume = 0})
        v1:Play()
        v1.Completed:Once(function() -- Line: 667 -- upvalues: _tug (val)
            _tug:Destroy()
        end)
    end
    v1 = 0.05 < self._charge
    self:Charge(0)
    if not a2 and v1 then
        Fx.Sound("BuddyHuh", self.Root, nil, 1.55)
        self._wobbleAt = os.clock()
    end
end

function u48.Leave(a1) -- Line: 679 -- upvalues: Fx (val), RunService (val)
    if a1._gone then
        return
    end
    a1._gone = true
    a1:_refreshPrompt()
    a1:Release(true)
    local u11 = os.clock()
    local CFrame = a1.Root.CFrame
    local _core = a1._core
    if _core then
        local Twinkles = _core:FindFirstChild("Twinkles")
        if Twinkles then
            Twinkles.Rate = 50
        end
    end
    Fx.Sound("BuddyGiggle", a1.Root, nil, 1.05)
    a1:_hop(1.4, 0.34)
    task.delay(0.55, function() -- Line: 697 -- upvalues: Fx (upval), a1 (val)
        Fx.Sound("BuddyOrbit", a1.Root, nil, 0.85)
    end)
    local _scale = a1._scale
    local u38 = nil
    a1._trove:Connect(RunService.RenderStepped, function() -- Line: 702 -- upvalues: u11 (val), a1 (val), CFrame (val), _scale (val), u38 (ref), Fx (upval)
        local v1 = os.clock() - u11 - 0.55
        if v1 < 0 then
            return
        end
        local v2 = math.clamp(v1 / 2.4, 0, 1)
        v1 = v2 * v2
        local v3 = v2 * 3.141592653589793 * 5
        a1._override = (CFrame.new(CFrame.Position + (Vector3.new(math.cos(v3) * 3 * (1 - v2), v1 * 140, math.sin(v3) * 3 * (1 - v2))))) * CFrame.Angles(0, v3 * 2, 0)
        a1.Model:ScaleTo((math.max(_scale * (1 - v2 * 0.85), 0.05)))
        if v2 >= 1 then
            u38:Disconnect()
            Fx.Emit("Collect", a1.Root.Position, 0.6)
            a1:Destroy()
        end
    end)
end

function u48.Detach(a1) -- Line: 722
    local Model = a1.Model
    a1._detached = true
    a1._gone = true
    a1.Prompt:Destroy()
    a1:Release(true)
    a1._trove:Destroy()
    for i, j in a1._tracks do
        j:Stop(0.1)
    end
    if a1._idle then
        a1._idle:Stop(0.1)
    end
    return Model
end

function u48:Destroy() -- Line: 738
    self._gone = true
    self._trove:Destroy()
    if not self._detached then
        self.Model:Destroy()
    end
end

return u48