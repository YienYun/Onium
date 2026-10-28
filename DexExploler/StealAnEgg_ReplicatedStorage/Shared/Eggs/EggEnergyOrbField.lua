-- Script path: ReplicatedStorage.Shared.Eggs.EggEnergyOrbField
-- Decompile time: 7.31 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local u24 = {}
u24.__index = u24
u24.__class = "EggEnergyOrbField"

local function getOrbTransparency(a1) -- Line: 70 -- types: a1: number
    if a1 < 0.14 then
        return 1 - a1 / 0.14
    end
    if a1 > 0.72 then
        return (a1 - 0.72) / 0.28
    end
    return 0
end

local function randomUnitVector(a1) -- Line: 80 -- types: a1: userdata
    local v1 = a1:NextNumber(-1, 1)
    local v2 = a1:NextNumber(0, 6.283185307179586)
    local v3 = math.sqrt((math.max(1 - v1 * v1, 0)))
    return (Vector3.new(v3 * math.cos(v2), v3 * math.sin(v2), v1))
end

local function randomOrbitPlane(a1) -- Line: 88 -- types: a1: userdata
    local v1 = a1:NextNumber(-1, 1)
    local v2 = a1:NextNumber(0, 6.283185307179586)
    local v3 = math.sqrt((math.max(1 - v1 * v1, 0)))
    local v4 = Vector3.new(v3 * math.cos(v2), v3 * math.sin(v2), v1)
    local Unit = v4:Cross(if not ((math.abs(v4.Y)) < 0.9) then Vector3.new(1, 0, 0) else Vector3.new(0, 1, 0)).Unit
    return Unit, v4:Cross(Unit).Unit
end

function u24.new(a1, a2) -- Line: 99 -- upvalues: t (val), u24 (val) -- types: a1: userdata, a2: userdata
    t.strict(t.Instance)(a1)
    t.strict(t.Color3)(a2)
    local v1 = setmetatable({}, u24)
    v1._color = a2
    v1._parent = a1
    v1._rng = Random.new()
    v1._orbs = {}
    v1._spawnAccumulator = 0
    v1._destroyed = false
    return v1
end

function u24:_resetOrb(a2, a3) -- Line: 118 -- types: a2: table, a3: vector
    local _rng = self._rng
    local v1 = _rng:NextNumber(-1, 1)
    local v2 = _rng:NextNumber(0, 6.283185307179586)
    local v3 = math.sqrt((math.max(1 - v1 * v1, 0)))
    local v4 = Vector3.new(v3 * math.cos(v2), v3 * math.sin(v2), v1)
    local Unit = v4:Cross(if not ((math.abs(v4.Y)) < 0.9) then Vector3.new(1, 0, 0) else Vector3.new(0, 1, 0)).Unit
    local Unit_2 = (v4:Cross(Unit)).Unit
    a2.PlaneU = Unit
    a2.PlaneV = Unit_2
    a2.Radius = _rng:NextNumber(4.5, 6.5)
    a2.Angle = _rng:NextNumber(0, 6.283185307179586)
    a2.AngularSpeed = (_rng:NextNumber(3, 7)) * (if _rng:NextInteger(0, 1) ~= 0 then 1 else -1)
    a2.Age = 0
    a2.CurrentRadius = a2.Radius
    a2.Part.Position = a3 + (a2.PlaneU * math.cos(a2.Angle) + a2.PlaneV * math.sin(a2.Angle)) * a2.Radius
    a2.Part.Transparency = 1
    a2.Trail.Enabled = true
    a2.Trail:Clear()
end

function u24:_createOrb(a2) -- Line: 137 -- types: a2: vector
    local Part = Instance.new("Part")
    Part.Name = "EnergyOrb"
    Part.Shape = Enum.PartType.Ball
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = self._color
    Part.Size = Vector3.new(0.25999999046325684, 0.25999999046325684, 0.25999999046325684)
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(0, 0.12999999523162842, 0)
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = Vector3.new(0, -0.12999999523162842, 0)
    Attachment_2.Parent = Part
    local Trail = Instance.new("Trail")
    Trail.Attachment0 = Attachment
    Trail.Attachment1 = Attachment_2
    Trail.Lifetime = 0.32
    Trail.LightEmission = 1
    Trail.LightInfluence = 0
    Trail.FaceCamera = true
    Trail.MinLength = 0
    Trail.Color = ColorSequence.new(self._color)
    Trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.85), (NumberSequenceKeypoint.new(1, 0))})
    Trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))})
    Trail.Parent = Part
    local v1 = {
        CurrentRadius = 6.5,
        PlaneU = Vector3.new(1, 0, 0),
        PlaneV = Vector3.new(0, 0, 1),
        Radius = 6.5,
        Angle = 0,
        AngularSpeed = 3,
        Age = 0,
        Part = Part,
        Trail = Trail,
        AbsorbSeconds = self._rng:NextNumber(0.9, 1.8),
    }
    self:_resetOrb(v1, a2)
    Part.Parent = self._parent
    return v1
end

function u24.Step(a1, a2, a3, a4) -- Line: 197 -- types: a2: vector, a3: number, a4: number
    local Angle_2, v1, v2
    if a1._destroyed then
        return
    end
    local _orbs = a1._orbs
    if #_orbs < 26 then
        a1._spawnAccumulator = a1._spawnAccumulator + a4
        local v3 = math.clamp(a3, 0, 1) * -0.19999999999999998 + 0.24
        while v3 <= a1._spawnAccumulator do
            if not (#_orbs < 26) then
                break
            end
            a1._spawnAccumulator = a1._spawnAccumulator - v3
            table.insert(_orbs, (a1:_createOrb(a2)))
        end
    end
    local v4 = nil
    local v5 = nil
    for i, j in _orbs, v4, v5 do
        j.Age = j.Age + a4
        v1 = j.Age / j.AbsorbSeconds
        if not (v1 >= 1) then
            Angle_2 = j.Angle
            v2 = j.AngularSpeed * a4
            j.Angle = Angle_2 + v2 * (1 + v1 * 2.5)
            j.CurrentRadius = j.Radius * (1 - v1) ^ 1.5
            j.Part.Position = a2 + (j.PlaneU * math.cos(j.Angle) + j.PlaneV * math.sin(j.Angle)) * j.CurrentRadius
            j.Part.Transparency = if not (v1 < 0.14) then if not (v1 > 0.72) then 0 else (v1 - 0.72) / 0.28 else 1 - v1 / 0.14
            j.Trail.Enabled = v1 <= 0.72
        else
            a1:_resetOrb(j, a2)
        end
    end
end

function u24.Absorb(a1, a2, a3, a4) -- Line: 238
    -- upvalues: RunService (val), TweenService (val), Debris (val)
    local Part, v1, v2, v3, v4, v5
    if a1._destroyed then
        return
    end
    a1._destroyed = true
    local v6 = table.clone(a1._orbs)
    table.clear(a1._orbs)
    if #v6 == 0 then
        return
    end
    local v7 = 0
    local v8 = a3
    while v7 < v8 do
        v2 = RunService.Heartbeat:Wait()
        v7 = v7 + v2
        v3 = math.min(v7 / v8, 1)
        v4 = 1 - TweenService:GetValue(v3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        v5 = math.max((v3 - 0.72) / 0.28, 0)
        for i, j in v6 do
            j.Angle = j.Angle + j.AngularSpeed * v2 * 3.5
            Part = j.Part
            v1 = j.PlaneU * math.cos(j.Angle) + j.PlaneV * math.sin(j.Angle)
            Part.Position = v9 + v1 * (j.CurrentRadius * v4)
            j.Part.Transparency = math.max(j.Part.Transparency, v5)
            if v3 >= 0.82 then
                j.Trail.Enabled = false
            end
        end
        if v10 ~= nil then
            v10(v2)
        end
    end
    for k, n in v6 do
        n.Part.Transparency = 1
        n.Trail.Enabled = false
        Debris:AddItem(n.Part, 0.32)
    end
end

function u24:Destroy() -- Line: 289
    if self._destroyed then
        return
    end
    self._destroyed = true
    for i, j in self._orbs do
        j.Part:Destroy()
    end
    table.clear(self._orbs)
end

return u24