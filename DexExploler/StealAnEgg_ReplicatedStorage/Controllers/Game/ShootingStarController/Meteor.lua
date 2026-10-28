-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.Meteor
-- Decompile time: 11.99 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u29 = {[0] = 1, 0.9, 0.8, 0.7}
local u35 = {}
u35.__index = u35

local function easeOutBack(a1) -- Line: 60 -- types: a1: number
    return (a1 - 1) ^ 3 * 2.70158 + 1 + (a1 - 1) ^ 2 * 1.70158
end

local function stageOffset(a1, a2) -- Line: 66 -- types: a1: userdata, a2: number
    if a2 <= 0 then
        return CFrame.identity
    end
    local v1 = math.clamp(math.floor(a2), 1, 2)
    local Attribute = a1:GetAttribute((("Stage%*Offset"):format(v1)))
    local Attribute_2 = a1:GetAttribute((("Stage%*Rot"):format(v1)))
    local v2 = if typeof(Attribute_2) ~= "Vector3" then Vector3.new(0, 0, 0) else Attribute_2
    return (CFrame.new(if typeof(Attribute) ~= "Vector3" then Vector3.new(0, 0, 0) else Attribute)) * CFrame.Angles(math.rad(v2.X), math.rad(v2.Y), (math.rad(v2.Z)))
end

local function lerpOffset(a1, a2, a3) -- Line: 78 -- types: a1: userdata, a2: userdata, a3: number
    local v1 = a1.Position:Lerp(a2.Position, a3)
    local v2 = a1.Rotation:Lerp(a2.Rotation, (math.clamp(a3, 0, 1)))
    return CFrame.new(v1) * v2
end

local function setTransparency(a1, a2) -- Line: 84 -- types: a1: userdata, a2: number
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j:GetAttribute("KeepHidden") ~= true then
            j.LocalTransparencyModifier = a2
        end
    end
end

function u35.new(a1, a2, a3, a4) -- Line: 96
    -- upvalues: Fx (val), Trove (val), u35 (val), RunService (val)
    local v1
    local v2 = Fx.Kit():FindFirstChild("Meteor"):Clone()
    v2:PivotTo(a1)
    local PrimaryPart = v2.PrimaryPart
    local Rock = v2:WaitForChild("Rock")
    local Star = v2:WaitForChild("Star")
    local v3 = Trove.new()
    v3:Add(v2)
    local v4 = {}
    local v5, v6, v7, v8 = a1, a2, a3, a4
    for i, j in Rock:GetChildren() do
        if j:IsA("BasePart") then
            v1 = PrimaryPart.CFrame:ToObjectSpace(j.CFrame)
            table.insert(v4, {
                Velocity = Vector3.new(0, 0, 0),
                Spin = Vector3.new(0, 0, 0),
                Part = j,
                Rest = v1,
                Dir = if not (0.01 < v1.Position.Magnitude) then Vector3.new(0, 1, 0) else v1.Position.Unit,
            })
        end
    end
    local v9 = {
        Broken = false,
        _poseFrom = 0,
        _poseTo = 0,
        _poseAt = (-1 / 0),
        _joltAt = (-1 / 0),
        _joltPower = 0,
        _dim = 1,
        Model = v2,
        Core = PrimaryPart,
        Star = Star,
        Landing = v5,
        Stage = math.clamp(v7, 0, v6 - 1),
        Total = v6,
        _trove = v3,
        _chunks = v4,
        _starRest = PrimaryPart.CFrame:ToObjectSpace(Star.CFrame),
        _starScale = Star.Size,
        _glow = PrimaryPart:FindFirstChild("Glow"),
        _highlight = v2:FindFirstChild("Aura"),
        _beacon = PrimaryPart:FindFirstChild("Beacon"),
        _startedAt = os.clock(),
    }
    local u84 = setmetatable(v9, u35)
    Star.Size = u84._starScale * 0.5
    u84._poseFrom = u84.Stage
    u84._poseTo = u84.Stage
    v2.Parent = v8
    if u84._beacon then
        u84._beacon.Width0 = 0
        u84._beacon.Width1 = 0
    end
    v3:Connect(RunService.RenderStepped, function() -- Line: 156 -- upvalues: u84 (val)
        u84:_step()
    end)
    u84:_step()
    return u84
end

function u35:_step() -- Line: 163 -- upvalues: stageOffset (val), Workspace (val), u29 (val)
    local v1
    local v2 = os.clock()
    local v3 = math.clamp((v2 - self._poseAt) / 0.42, 0, 1)
    local v4 = (v3 - 1) ^ 3 * 2.70158 + 1 + (v3 - 1) ^ 2 * 1.70158
    local v5 = (1 - math.clamp((v2 - self._joltAt) / 0.32, 0, 1)) ^ 2 * self._joltPower
    v3 = math.sin((v2 - self._startedAt) * 2.4)
    local CFrame_2 = self.Core.CFrame
    if not self.Broken then
        local v6, v7, v8, v9, v10
        local v11 = {}
        v1 = {}
        local v12 = nil
        local v13 = nil
        for i, j in self._chunks, v12, v13 do
            v6 = stageOffset(j.Part, self._poseFrom)
            v7 = stageOffset(j.Part, self._poseTo)
            v9 = v6.Position:Lerp(v7.Position, v4)
            v10 = v6.Rotation:Lerp(v7.Rotation, (math.clamp(v4, 0, 1)))
            v8 = CFrame.new(v9) * v10
            v7 = Vector3.new(0, 0, 0)
            if v5 > 0 then
                v6 = i * 12.9898 + v2 * 61
                v7 = Vector3.new(math.noise(v6, 1), math.noise(v6, 2), (math.noise(v6, 3))) * v5
            end
            v9 = j.Dir * (0.04 + 0.03 * self.Stage) * v3
            table.insert(v11, j.Part)
            table.insert(v1, CFrame_2 * CFrame.new(v8.Position + v7 + v9) * j.Rest * v8.Rotation)
        end
        Workspace:BulkMoveTo(v11, v1, Enum.BulkMoveMode.FireCFrameChanged)
    end
    v4 = v3 * 0.08 + 1
    local _dim = self._dim
    if self._lightOffAt then
        _dim = _dim * math.clamp(1 - (v2 - self._lightOffAt) / 0.3, 0, 1)
    end
    if self._glow then
        self._glow.Brightness = v4 * 0.3 * _dim
        self._glow.Range = 9
        self._glow.Enabled = _dim > 0
    end
    if self._highlight and not self.Broken then
        v1 = u29[math.clamp(self.Stage, 0, 3)] or 0.5
        self._highlight.FillTransparency = math.clamp(v1 - v3 * 0.06 - v5 * 0.4, 0, 1)
    end
    if self._starOverride then
        self.Star.CFrame = self._starOverride
        return
    end
    v5 = CFrame.Angles(0, (v2 - self._startedAt) * 1.3, 0)
    self.Star.CFrame = CFrame_2 * self._starRest * v5
end

function u35.SetStage(a1, a2, a3) -- Line: 221 -- types: a2: number, a3: boolean
    local v1 = math.clamp(a2, 0, a1.Total - 1)
    a1._poseFrom = if not a3 then v1 else a1._poseTo
    a1._poseTo = v1
    a1._poseAt = if not a3 then (-1 / 0) else os.clock()
    a1.Stage = v1
end

function u35.Rise(a1, a2) -- Line: 229 -- upvalues: TweenService (val), Fx (val) -- types: a2: number
    local _beacon = a1._beacon
    if _beacon then
        TweenService:Create(
            _beacon,
            TweenInfo.new(a2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Width0 = 7, Width1 = 2.4499999999999997}
        ):Play()
    end
    if a1._hum == nil then
        a1._hum = Fx.Sound("StarHum", a1.Core)
        if a1._hum then
            a1._hum.Looped = true
            a1._trove:Add(a1._hum)
        end
    end
end

function u35.Open(a1) -- Line: 247 -- upvalues: Fx (val), TweenService (val), RunService (val), Workspace (val)
    if a1.Broken then
        return
    end
    local Position = a1.Core.Position
    local _trove = a1._trove
    a1._joltAt = os.clock()
    a1._joltPower = 0.9
    Fx.Sound("StarCharge", Position, 0.6)
    Fx.Emit("Charge", Position, 1)
    task.delay(if not Fx.ReducedMotion() then 0.42 else 0.2, function() -- Line: 260
        -- upvalues: a1 (val), Fx (upval), Position (val), TweenService (upval), _trove (val), RunService (upval)
        -- upvalues: Workspace (upval)
        local v1, v2, v3, v4
        if a1.Model.Parent == nil then
            return
        end
        a1.Broken = true
        a1.Star.Transparency = 1
        Fx.Sound("StarBurst", Position, 0.75)
        Fx.Emit("Burst", Position, 0.8)
        Fx.Emit("Reveal", Position + Vector3.new(0, 3, 0), 1)
        Fx.Shake(0.4, 0.7, Position)
        if a1._beacon then
            TweenService:Create(a1._beacon, TweenInfo.new(0.6), {Width0 = 0, Width1 = 0}):Play()
        end
        local _highlight = a1._highlight
        if _highlight then
            TweenService:Create(_highlight, TweenInfo.new(0.5), {FillTransparency = 1, OutlineTransparency = 1}):Play()
        end
        local v5 = Random.new()
        for i, j in a1._chunks do
            v2 = j.Dir * Vector3.new(1, 0.3499999940395355, 1)
            j.Velocity = (v2 + Vector3.new(0, 0.8999999761581421, 0)).Unit * v5:NextNumber(26, 44)
            v3 = v5:NextNumber(-9, 9)
            v4 = v5:NextNumber(-9, 9)
            v1 = v5:NextNumber(-9, 9)
            j.Spin = Vector3.new(v3, v4, v1)
            j.Free = j.Part.CFrame
        end
        local u80 = a1.Landing.Position.Y + 0.4
        local u82 = os.clock()
        local u83 = nil
        _trove:Connect(RunService.RenderStepped, function(a1_2) -- Line: 294
            -- upvalues: u82 (val), a1 (upval), u80 (val), Workspace (upval), u83 (ref)
            local Free, v1, v2, v3, v4, v5
            local v6 = os.clock() - u82
            local v7 = {}
            local v8 = {}
            local v9 = nil
            local v10 = nil
            local v11 = a1_2
            for i, j in a1._chunks, v9, v10 do
                Free = j.Free
                j.Velocity = j.Velocity + Vector3.new(0, -120, 0) * v11
                v1 = Free.Position + j.Velocity * v11
                if v1.Y < u80 and j.Velocity.Y < 0 then
                    v1 = Vector3.new(v1.X, u80, v1.Z)
                    v3 = j.Velocity.X * 0.45
                    v4 = -j.Velocity.Y * 0.32
                    v5 = j.Velocity.Z * 0.45
                    j.Velocity = Vector3.new(v3, v4, v5)
                    j.Spin = j.Spin * 0.5
                end
                v2 = j.Spin * v11
                v4 = (CFrame.new(v1)) * Free.Rotation
                j.Free = v4 * CFrame.Angles(v2.X, v2.Y, v2.Z)
                table.insert(v7, j.Part)
                table.insert(v8, j.Free)
                v2 = math.clamp((v6 - 1.14) / 0.76, 0, 1)
                j.Part.LocalTransparencyModifier = v2
            end
            Workspace:BulkMoveTo(v7, v8, Enum.BulkMoveMode.FireCFrameChanged)
            if v6 > 1.9 then
                u83:Disconnect()
                for k, n in a1._chunks do
                    n.Part.Transparency = 1
                end
            end
        end)
    end)
end

function u35.LightOff(a1) -- Line: 331
    if a1._lightOffAt == nil then
        a1._lightOffAt = os.clock()
    end
end

function u35.Fade(a1) -- Line: 337 -- upvalues: TweenService (val), RunService (val), setTransparency (val)
    local Model = a1.Model
    if a1._beacon then
        TweenService:Create(a1._beacon, TweenInfo.new(1.5), {Width0 = 0, Width1 = 0}):Play()
    end
    if a1._hum then
        TweenService:Create(a1._hum, TweenInfo.new(1.5), {Volume = 0}):Play()
    end
    local u30 = os.clock()
    local u31 = nil
    a1._trove:Connect(RunService.RenderStepped, function() -- Line: 347 -- upvalues: u30 (val), setTransparency (upval), Model (val), a1 (val), u31 (ref)
        local v1 = math.clamp((os.clock() - u30) / 1.1, 0, 1)
        setTransparency(Model, v1)
        a1._dim = 1 - v1
        if v1 >= 1 then
            u31:Disconnect()
            a1:Destroy()
        end
    end)
end

function u35:Destroy() -- Line: 358
    self._trove:Destroy()
end

return u35