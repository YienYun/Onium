-- Script path: ReplicatedStorage.Client.WorldFX.ArrowPointer3D
-- Decompile time: 12.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local Model = ReplicatedStorage.Assets.Models.Pointers.Model
local v1 = Model:FindFirstChild("Shell")
local v2 = false
if v1 ~= nil then
    v2 = v1:IsA("BasePart")
end
assert(v2, "the pointer template needs a Shell BasePart")
local X = v1.Size.X
local u48 = X * 0.6666666666666666
local Transient = Workspace:WaitForChild("Transient")
local u58 = Color3.fromRGB(255, 72, 48)
local u68 = table.freeze({
    Amplitude = 4,
    Blink = false,
    BlinkFrequency = 1.2,
    CleanupOnPartDestroyed = false,
    Highlight = false,
    OriginOffset = Vector3.new(0, 0, 0),
    OscillationSpeed = 3.2,
    Radius = 4,
    RotationSpeed = 0,
    TargetOffset = Vector3.new(0, 0, 0),
    Color = Color3.new(1, 1, 1),
    ProximityThreshold = X + X / 2,
})
local v3 = t.interface({
    Amplitude = t.optional(t.number),
    Blink = t.optional(t.boolean),
    BlinkFrequency = t.optional(t.number),
    CleanupOnPartDestroyed = t.optional(t.boolean),
    Color = t.optional(t.Color3),
    Highlight = t.optional(t.boolean),
    OriginOffset = t.optional(t.Vector3),
    OscillationSpeed = t.optional(t.number),
    ProximityThreshold = t.optional(t.number),
    Radius = t.optional(t.number),
    RotationSpeed = t.optional(t.number),
    TargetOffset = t.optional(t.Vector3),
})
local u110 = {}
u110.__index = u110
u110.__class = "ArrowPointer3D"
u110.__types = {Config = v3, OptionalConfig = t.optional(v3)}
local u119 = Log.new()
local u120 = {}
local u128 = t.optional(t.union(t.instanceIsA("BasePart"), t.Vector3))

local function withDefaults(a1) -- Line: 120 -- upvalues: u68 (val) -- types: a1: table?
    local v1 = table.clone(u68)
    if a1 ~= nil then
        for i, j in a1 do
            v1[i] = j
        end
    end
    return v1
end

local function pointOf(a1, a2) -- Line: 130 -- types: a2: vector
    return (if typeof(a1) ~= "Vector3" then a1.Position else a1) + a2
end

local function inWorld(a1) -- Line: 135 -- upvalues: Workspace (val)
    if a1 == nil then
        return false
    end
    if typeof(a1) == "Vector3" then
        return true
    end
    return a1:IsDescendantOf(Workspace)
end

local function bothInWorld(a1) -- Line: 145 -- upvalues: Workspace (val)
    local origin = a1.origin
    local v1 = if origin == nil then false else if typeof(origin) ~= "Vector3" then origin:IsDescendantOf(Workspace) else true
    if v1 then
        local target = a1.target
        if target == nil then
            return false
        end
        if typeof(target) == "Vector3" then
            return true
        end
        v1 = target:IsDescendantOf(Workspace)
    end
    return v1
end

local function halt(a1) -- Line: 149 -- upvalues: u120 (val)
    if not a1.isRunning then
        return false
    end
    a1.isRunning = false
    u120[a1] = nil
    a1.model.Parent = nil
    return true
end

local function track(a1, a2, a3) -- Line: 161
    -- upvalues: Workspace (val), u120 (val)
    local v1 = a1.endScopes[a2]
    v1:Clean()
    if a1.Config.CleanupOnPartDestroyed then
        v1:Connect(a3.Destroying, function() -- Line: 166 -- upvalues: a1 (val)
            a1:Destroy()
        end)
    end
    v1:Connect(a3.AncestryChanged, function() -- Line: 170 -- upvalues: a1 (val), Workspace (upval), u120 (upval)
        local v1 = a1
        local origin = v1.origin
        local v2 = if origin == nil then false else if typeof(origin) ~= "Vector3" then origin:IsDescendantOf(Workspace) else true
        if v2 then
            local target = v1.target
            v2 = if target == nil then false else if typeof(target) ~= "Vector3" then target:IsDescendantOf(Workspace) else true
        end
        if v2 then
            a1:Start()
            return
        end
        v1 = a1
        if v1.isRunning then
            v1.isRunning = false
            u120[v1] = nil
            v1.model.Parent = nil
            v2 = true
        else
            v2 = false
        end
        if v2 then
            a1.haltedByWorld = true
        end
    end)
end

local function bind(a1, a2, a3) -- Line: 179 -- upvalues: track (val), Workspace (val) -- types: a2: string
    if typeof(a3) ~= "Instance" then
        a1.boundParts[a2] = nil
        a1.endScopes[a2]:Clean()
    elseif a1.boundParts[a2] ~= a3 then
        a1.boundParts[a2] = a3
        track(a1, a2, a3)
    end
    a1[if a2 ~= "Origin" then "target" else "origin"] = a3
    if a1.haltedByWorld then
        local origin = a1.origin
        local v1 = if origin == nil then false else if typeof(origin) ~= "Vector3" then origin:IsDescendantOf(Workspace) else true
        if v1 then
            local target = a1.target
            v1 = if target == nil then false else if typeof(target) ~= "Vector3" then target:IsDescendantOf(Workspace) else true
        end
        if v1 then
            a1:Start()
        end
    end
end

local function tintAt(a1, a2) -- Line: 198 -- upvalues: u58 (val) -- types: a1: table, a2: number
    if not a1.Blink then
        return a1.Color
    end
    return a1.Color:Lerp(u58, math.sin(a2 * a1.BlinkFrequency * 6.283185307179586) * 0.5 + 0.5)
end

local function settleReach(a1, a2) -- Line: 208 -- types: a2: number
    local Config = a1.Config
    local Amplitude = if not (0 <= (math.sin(a1.clock * Config.OscillationSpeed))) then -Config.Amplitude else Config.Amplitude
    local v1 = Config.Radius + Amplitude
    local v2 = Config.OscillationSpeed * 1.6
    a1.reachVelocity = a1.reachVelocity + (-(v2 * v2) * (a1.reach - v1) - 1 * v2 * a1.reachVelocity) * a2
    a1.reach = a1.reach + a1.reachVelocity * a2
    if a1.reach < 0 then
        a1.reach = 0
        a1.reachVelocity = math.max(a1.reachVelocity, 0)
    end
    return a1.reach
end

local function poseAlong(a1, a2, a3, a4) -- Line: 227 -- types: a1: vector, a2: vector, a3: number, a4: number
    local Unit = (a2 - a1).Unit
    local Unit_2 = Unit:Cross(if not (0.98 < (math.abs((Unit:Dot((Vector3.new(0, 1, 0))))))) then Vector3.new(0, 1, 0) else Vector3.new(0, 0, 1)).Unit
    local v1 = Unit_2:Cross(Unit)
    if a4 ~= 0 then
        local v2 = CFrame.fromAxisAngle(Unit, -a4)
        Unit_2 = v2:VectorToWorldSpace(Unit_2)
        v1 = v2:VectorToWorldSpace(v1)
    end
    return CFrame.fromMatrix(a1 + Unit * a3, -Unit, -Unit_2, -v1)
end

local function advance(a1, a2) -- Line: 240
    -- upvalues: Workspace (val), u58 (val), settleReach (val), u48 (val), poseAlong (val)
    local v1 = math.min(a2, 0.05)
    a1.clock = a1.clock + v1
    local origin = a1.origin
    local v2 = if origin == nil then false else if typeof(origin) ~= "Vector3" then origin:IsDescendantOf(Workspace) else true
    if v2 then
        local target = a1.target
        v2 = if target == nil then false else if typeof(target) ~= "Vector3" then target:IsDescendantOf(Workspace) else true
    end
    if not v2 then
        return
    end
    local Config = a1.Config
    local origin_2 = a1.origin
    local OriginOffset = Config.OriginOffset
    local v3 = (if typeof(origin_2) ~= "Vector3" then origin_2.Position else origin_2) + OriginOffset
    local target_2 = a1.target
    local TargetOffset = Config.TargetOffset
    local v4 = (if typeof(target_2) ~= "Vector3" then target_2.Position else target_2) + TargetOffset
    local Core = a1.model.Core
    local clock = a1.clock
    Core.Color = if Config.Blink then Config.Color:Lerp(u58, math.sin(clock * Config.BlinkFrequency * 6.283185307179586) * 0.5 + 0.5) else Config.Color
    if (v4 - v3).Magnitude < Config.ProximityThreshold then
        a1.model.Parent = nil
        return
    end
    if a1.model.Parent == nil then
        a1.model.Parent = a1.stage
    end
    a1.model:PivotTo((poseAlong(v3, v4, (settleReach(a1, v1)) + u48, a1.clock * Config.RotationSpeed)))
end

function u110.new(a1, a2, a3) -- Line: 265
    -- upvalues: u110 (val), u128 (val), Trove (val), u68 (val), Model (val), Transient (val), bind (val)
    assert((u110.__types.OptionalConfig(a3)))
    assert((u128(a1)))
    assert((u128(a2)))
    local v1 = Trove.new()
    local v2 = setmetatable({}, u110)
    local v3 = table.clone(u68)
    if a3 ~= nil then
        for i, j in a3 do
            v3[i] = j
        end
    end
    v2.Config = v3
    v2.model = v1:Clone(Model)
    v2.stage = Transient
    v2.scope = v1
    v2.endScopes = {Origin = v1:Extend(), Target = v1:Extend()}
    v2.boundParts = {}
    v2.clock = 0
    v2.reach = v2.Config.Radius
    v2.reachVelocity = 0
    v2.isRunning = false
    v2.haltedByWorld = false
    v2.retired = false
    v2.model.Core.Color = v2.Config.Color
    if a2 ~= nil then
        bind(v2, "Origin", a2)
    end
    if a1 ~= nil then
        bind(v2, "Target", a1)
    end
    return v2
end

function u110:Start() -- Line: 297 -- upvalues: Workspace (val), u120 (val)
    if not self.isRunning and not self.retired then
        local origin = self.origin
        local v1 = if origin == nil then false else if typeof(origin) ~= "Vector3" then origin:IsDescendantOf(Workspace) else true
        if v1 then
            local target = self.target
            v1 = if target == nil then false else if typeof(target) ~= "Vector3" then target:IsDescendantOf(Workspace) else true
        end
        assert(v1, "an arrow needs both of its anchors in the world before it starts")
        self.isRunning = true
        self.haltedByWorld = false
        self.model.Parent = self.stage
        u120[self] = true
        return true
    end
    return false
end

function u110.Stop(a1) -- Line: 310 -- upvalues: u120 (val)
    a1.haltedByWorld = false
    if not a1.isRunning then
        return false
    end
    a1.isRunning = false
    u120[a1] = nil
    a1.model.Parent = nil
    return true
end

function u110.PointFrom(a1, a2) -- Line: 315 -- upvalues: u128 (val), bind (val)
    assert((u128(a2)))
    bind(a1, "Origin", a2)
end

function u110.PointAt(a1, a2) -- Line: 320 -- upvalues: u128 (val), bind (val)
    assert((u128(a2)))
    bind(a1, "Target", a2)
end

function u110:Destroy() -- Line: 325 -- upvalues: u120 (val)
    if self.retired then
        return
    end
    self.retired = true
    if self.isRunning then
        self.isRunning = false
        u120[self] = nil
        self.model.Parent = nil
    end
    self.scope:Destroy()
end

RunService.RenderStepped:Connect(function(a1) -- Line: 334 -- upvalues: u120 (val), advance (val), u119 (val) -- types: a1: number
    local err, success
    for i in u120 do
        success, err = pcall(advance, i, a1)
        if not success then
            (u119:AtError()):Log((("arrow pointer step failed: %*"):format(err)))
            if i.isRunning then
                i.isRunning = false
                u120[i] = nil
                i.model.Parent = nil
            end
        end
    end
end)
return u110