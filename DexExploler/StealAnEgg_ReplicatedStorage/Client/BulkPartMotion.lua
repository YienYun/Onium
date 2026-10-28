-- Script path: ReplicatedStorage.Client.BulkPartMotion
-- Decompile time: 13.90 ms

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u29 = (require(ReplicatedStorage.Packages.Log)).new()
local u38 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))

local function isFiniteCFrame(a1) -- Line: 33 -- upvalues: u38 (val)
    local v1 = false
    if typeof(a1) == "CFrame" then
        local Position = a1.Position
        v1 = false
        if typeof(Position) == "Vector3" then
            v1 = u38(Position.X) and u38(Position.Y) and u38(Position.Z)
        end
        if v1 then
            local XVector = a1.XVector
            v1 = false
            if typeof(XVector) == "Vector3" then
                v1 = u38(XVector.X) and u38(XVector.Y) and u38(XVector.Z)
            end
            if v1 then
                local YVector = a1.YVector
                v1 = false
                if typeof(YVector) == "Vector3" then
                    v1 = u38(YVector.X) and u38(YVector.Y) and u38(YVector.Z)
                end
                if v1 then
                    local ZVector = a1.ZVector
                    v1 = false
                    if typeof(ZVector) == "Vector3" then
                        v1 = u38(ZVector.X) and u38(ZVector.Y) and u38(ZVector.Z)
                    end
                end
            end
        end
    end
    return v1
end

local u45 = t.strict(t.instanceIsA("BasePart"))
local u48 = t.strict(isFiniteCFrame)
local u53 = t.strict(t.optional(isFiniteCFrame))
local u57 = t.strict(function(a1) -- Line: 24 -- upvalues: u38 (val)
    local v1 = false
    if typeof(a1) == "Vector3" then
        v1 = u38(a1.X) and u38(a1.Y) and u38(a1.Z)
    end
    return v1
end)
local u60 = t.strict(t.TweenInfo)
local u61 = {}
u61.__index = u61
local v1 = {}
local u63 = {}
local u64 = {}
local u65 = {}
local u66 = {}
local u67 = {}

local function isAlive(a1) -- Line: 75 -- types: a1: userdata?
    local v1 = false
    if a1 ~= nil then
        v1 = a1.Parent ~= nil
    end
    return v1
end

local function dropGlide(a1) -- Line: 77 -- upvalues: u65 (val)
    u65[a1] = nil
    a1.origin = nil
    a1.destination = nil
    a1.curve = nil
    a1.spent = 0
end

local function retire(a1) -- Line: 85 -- upvalues: u63 (val), u64 (val), u65 (val)
    local body = a1.body
    if body then
        u63[body] = nil
    end
    u64[a1] = nil
    u65[a1] = nil
    a1.origin = nil
    a1.destination = nil
    a1.curve = nil
    a1.spent = 0
    a1.body = nil
    a1.root = nil
    a1.queued = nil
    a1.extent = nil
    a1.retired = true
end

local function writable(a1) -- Line: 103 -- upvalues: u63 (val), u64 (val), u65 (val)
    local body = a1.body
    local v1 = false
    if body ~= nil then
        v1 = body.Parent ~= nil
    end
    if v1 then
        return body
    end
    local body_2 = a1.body
    if body_2 then
        u63[body_2] = nil
    end
    u64[a1] = nil
    u65[a1] = nil
    a1.origin = nil
    a1.destination = nil
    a1.curve = nil
    a1.spent = 0
    a1.body = nil
    a1.root = nil
    a1.queued = nil
    a1.extent = nil
    a1.retired = true
    return nil
end

local function enqueue(a1, a2) -- Line: 114 -- upvalues: u64 (val) -- types: a2: userdata
    a1.root = a2
    a1.queued = a2 * a1.lean
    u64[a1] = true
end

local function reshape(a1, a2, a3) -- Line: 122
    -- upvalues: u57 (val), u63 (val), u64 (val), u65 (val)
    local v1
    u57(a2 or a3)
    if a1.retired then
        return
    end
    a1.extent = a2 or a1.extent
    a1.stretch = a3 or a1.stretch
    local body = a1.body
    local v2 = false
    if body ~= nil then
        v2 = body.Parent ~= nil
    end
    if not v2 then
        local body_2 = a1.body
        if body_2 then
            u63[body_2] = nil
        end
        u64[a1] = nil
        u65[a1] = nil
        a1.origin = nil
        a1.destination = nil
        a1.curve = nil
        a1.spent = 0
        a1.body = nil
        a1.root = nil
        a1.queued = nil
        a1.extent = nil
        a1.retired = true
        v1 = nil
    else
        v1 = body
    end
    if v1 then
        local extent_2 = a1.extent or v1.Size
        local stretch_2 = a1.stretch
        v1.Size = Vector3.new(extent_2.X * stretch_2.X, extent_2.Y * stretch_2.Y, extent_2.Z * stretch_2.Z)
    end
end

local function reposition(a1, a2, a3) -- Line: 141
    -- upvalues: u48 (val), u63 (val), u64 (val), u65 (val)
    local v1
    u48(a2)
    local body = a1.body
    local v2 = false
    if body ~= nil then
        v2 = body.Parent ~= nil
    end
    if not v2 then
        local body_2 = a1.body
        if body_2 then
            u63[body_2] = nil
        end
        u64[a1] = nil
        u65[a1] = nil
        a1.origin = nil
        a1.destination = nil
        a1.curve = nil
        a1.spent = 0
        a1.body = nil
        a1.root = nil
        a1.queued = nil
        a1.extent = nil
        a1.retired = true
        v1 = nil
    else
        v1 = body
    end
    if not v1 then
        return
    end
    u65[a1] = nil
    a1.origin = nil
    a1.destination = nil
    a1.curve = nil
    a1.spent = 0
    a1.root = a2
    a1.queued = a2 * a1.lean
    u64[a1] = true
    if a3 then
        u64[a1] = nil
        v1.CFrame = a1.queued
    end
end

local function sweepDead() -- Line: 158 -- upvalues: u63 (val), u64 (val), u65 (val)
    local body, v1
    local v2 = nil
    local v3 = nil
    for i, j in u63, v2, v3 do
        v1 = false
        if i ~= nil then
            v1 = i.Parent ~= nil
        end
        if not v1 then
            body = j.body
            if body then
                u63[body] = nil
            end
            u64[j] = nil
            u65[j] = nil
            j.origin = nil
            j.destination = nil
            j.curve = nil
            j.spent = 0
            j.body = nil
            j.root = nil
            j.queued = nil
            j.extent = nil
            j.retired = true
        end
    end
end

local function advanceGlides(a1) -- Line: 168
    -- upvalues: u65 (val), u63 (val), u64 (val), TweenService (val)
    local Time, body, body_2, curve, destination, origin, v1, v2, v3, v4, v5
    local v6 = nil
    local v7 = nil
    for i in u65, v6, v7 do
        origin = i.origin
        destination = i.destination
        curve = i.curve
        v5 = false
        if origin ~= nil then
            v5 = false
            if destination ~= nil then
                v5 = curve ~= nil
            end
        end
        body = i.body
        v4 = false
        if body ~= nil then
            v4 = body.Parent ~= nil
        end
        if not v4 then
            body_2 = i.body
            if body_2 then
                u63[body_2] = nil
            end
            u64[i] = nil
            u65[i] = nil
            i.origin = nil
            i.destination = nil
            i.curve = nil
            i.spent = 0
            i.body = nil
            i.root = nil
            i.queued = nil
            i.extent = nil
            i.retired = true
            v2 = nil
        else
            v2 = body
        end
        if v2 ~= nil then
            if v5 then
                Time = curve.Time
                i.spent = i.spent + v1
                v3 = origin:Lerp(destination, (TweenService:GetValue(
                    if not (Time > 0) then 1 else math.clamp(i.spent / Time, 0, 1),
                    curve.EasingStyle,
                    curve.EasingDirection
                )))
                i.root = v3
                i.queued = v3 * i.lean
                u64[i] = true
                if v2 >= 1 then
                    u65[i] = nil
                    i.origin = nil
                    i.destination = nil
                    i.curve = nil
                    i.spent = 0
                end
            else
                u65[i] = nil
                i.origin = nil
                i.destination = nil
                i.curve = nil
                i.spent = 0
            end
        end
    end
end

function v1.Register(a1, a2) -- Line: 199
    -- upvalues: u45 (val), u53 (val), u63 (val), u61 (val)
    local v1
    u45(a1)
    u53(a2)
    local v2 = u63[a1]
    if v2 == nil or v2.retired then
        local v3 = {
            spent = 0,
            stretch = Vector3.new(1, 1, 1),
            retired = false,
            body = a1,
            lean = CFrame.identity,
        }
        v1 = setmetatable(v3, u61)
    else
        v1 = v2
    end
    if a2 then
        v1:SetCFrame(a2)
    end
    u63[a1] = v1
    return v1
end

function v1.Forget(a1) -- Line: 232 -- upvalues: u45 (val), u63 (val), u64 (val), u65 (val) -- types: a1: userdata
    u45(a1)
    local v1 = u63[a1]
    if v1 then
        local body = v1.body
        if body then
            u63[body] = nil
        end
        u64[v1] = nil
        u65[v1] = nil
        v1.origin = nil
        v1.destination = nil
        v1.curve = nil
        v1.spent = 0
        v1.body = nil
        v1.root = nil
        v1.queued = nil
        v1.extent = nil
        v1.retired = true
    end
end

function v1.Commit(a1) -- Line: 243
    -- upvalues: advanceGlides (val), u66 (val), u67 (val), u64 (val), u63 (val), u65 (val), TryCall (val)
    -- upvalues: sweepDead (val), u29 (val)
    local body, body_2, queued, v1
    advanceGlides(a1 or 0)
    table.clear(u66)
    table.clear(u67)
    local v2 = 0
    local v3 = nil
    local v4 = nil
    for i in u64, v3, v4 do
        u64[i] = nil
        body = i.body
        queued = i.queued
        i.queued = nil
        v1 = false
        if body ~= nil then
            v1 = body.Parent ~= nil
        end
        if not v1 then
            body_2 = i.body
            if body_2 then
                u63[body_2] = nil
            end
            u64[i] = nil
            u65[i] = nil
            i.origin = nil
            i.destination = nil
            i.curve = nil
            i.spent = 0
            i.body = nil
            i.root = nil
            i.queued = nil
            i.extent = nil
            i.retired = true
        elseif queued then
            v2 = v2 + 1
            u66[v2] = body
            u67[v2] = queued
        end
    end
    if v2 <= 0 then
        return
    end
    if not TryCall(function() -- Line: 272 -- upvalues: u66 (upval), u67 (upval)
        local FireCFrameChanged, v0, v1, v2, v3
        v0 = workspace
        v2 = u66
        v3 = u67
        FireCFrameChanged = Enum.BulkMoveMode.FireCFrameChanged
        v0:BulkMoveTo(v2, v3, FireCFrameChanged)
        return
    end) then
        sweepDead()
        u29:AtWarning():Log("A batched part move was rejected; the roster was swept")
    end
end

function u61.Subject(a1) -- Line: 281
    if a1.retired then
        return nil
    end
    return a1.body
end

function u61.Destroy(a1) -- Line: 283 -- upvalues: u63 (val), u64 (val), u65 (val)
    if not a1.retired then
        local body = a1.body
        if body then
            u63[body] = nil
        end
        u64[a1] = nil
        u65[a1] = nil
        a1.origin = nil
        a1.destination = nil
        a1.curve = nil
        a1.spent = 0
        a1.body = nil
        a1.root = nil
        a1.queued = nil
        a1.extent = nil
        a1.retired = true
    end
end

function u61.Halt(a1) -- Line: 289 -- upvalues: u65 (val)
    u65[a1] = nil
    a1.origin = nil
    a1.destination = nil
    a1.curve = nil
    a1.spent = 0
end

function u61.Stretch(a1, a2) -- Line: 291 -- upvalues: reshape (val) -- types: a2: vector
    reshape(a1, nil, a2)
end

function u61.Span(a1, a2) -- Line: 293 -- upvalues: reshape (val) -- types: a2: vector
    reshape(a1, a2, nil)
end

function u61.Lean(a1, a2) -- Line: 297 -- upvalues: u48 (val), u63 (val), u64 (val), u65 (val) -- types: a2: userdata
    local v1
    u48(a2)
    local body = a1.body
    local v2 = false
    if body ~= nil then
        v2 = body.Parent ~= nil
    end
    if not v2 then
        local body_2 = a1.body
        if body_2 then
            u63[body_2] = nil
        end
        u64[a1] = nil
        u65[a1] = nil
        a1.origin = nil
        a1.destination = nil
        a1.curve = nil
        a1.spent = 0
        a1.body = nil
        a1.root = nil
        a1.queued = nil
        a1.extent = nil
        a1.retired = true
        v1 = nil
    else
        v1 = body
    end
    if v1 then
        a1.lean = a2
        local root = a1.root or v1.CFrame
        a1.root = root
        a1.queued = root * a1.lean
        u64[a1] = true
    end
end

function u61.Glide(a1, a2, a3) -- Line: 307
    -- upvalues: u60 (val), u48 (val), u63 (val), u64 (val), u65 (val)
    local v1
    u60(a2)
    u48(a3)
    local body = a1.body
    local v2 = false
    if body ~= nil then
        v2 = body.Parent ~= nil
    end
    if not v2 then
        local body_2 = a1.body
        if body_2 then
            u63[body_2] = nil
        end
        u64[a1] = nil
        u65[a1] = nil
        a1.origin = nil
        a1.destination = nil
        a1.curve = nil
        a1.spent = 0
        a1.body = nil
        a1.root = nil
        a1.queued = nil
        a1.extent = nil
        a1.retired = true
        v1 = nil
    else
        v1 = body
    end
    if v1 then
        local root = a1.root or v1.CFrame
        a1.origin = root
        a1.destination = a3
        a1.curve = a2
        a1.spent = 0
        u65[a1] = true
        u64[a1] = true
    end
end

function u61.Snap(a1, a2) -- Line: 322 -- upvalues: u48 (val), u63 (val), u64 (val), u65 (val) -- types: a2: userdata
    local v1
    u48(a2)
    local body = a1.body
    local v2 = false
    if body ~= nil then
        v2 = body.Parent ~= nil
    end
    if not v2 then
        local body_2 = a1.body
        if body_2 then
            u63[body_2] = nil
        end
        u64[a1] = nil
        u65[a1] = nil
        a1.origin = nil
        a1.destination = nil
        a1.curve = nil
        a1.spent = 0
        a1.body = nil
        a1.root = nil
        a1.queued = nil
        a1.extent = nil
        a1.retired = true
        v1 = nil
    else
        v1 = body
    end
    if not v1 then
        return
    end
    u65[a1] = nil
    a1.origin = nil
    a1.destination = nil
    a1.curve = nil
    a1.spent = 0
    a1.root = a2
    a1.queued = a2 * a1.lean
    u64[a1] = true
    u64[a1] = nil
    v1.CFrame = a1.queued
end

function u61:SetCFrame(a2) -- Line: 324 -- upvalues: u48 (val), u63 (val), u64 (val), u65 (val) -- types: a2: userdata
    local v1
    u48(a2)
    local body = self.body
    local v2 = false
    if body ~= nil then
        v2 = body.Parent ~= nil
    end
    if not v2 then
        local body_2 = self.body
        if body_2 then
            u63[body_2] = nil
        end
        u64[self] = nil
        u65[self] = nil
        self.origin = nil
        self.destination = nil
        self.curve = nil
        self.spent = 0
        self.body = nil
        self.root = nil
        self.queued = nil
        self.extent = nil
        self.retired = true
        v1 = nil
    else
        v1 = body
    end
    if not v1 then
        return
    end
    u65[self] = nil
    self.origin = nil
    self.destination = nil
    self.curve = nil
    self.spent = 0
    self.root = a2
    self.queued = a2 * self.lean
    u64[self] = true
end

RunService.PreSimulation:Connect(v1.Commit)
return v1