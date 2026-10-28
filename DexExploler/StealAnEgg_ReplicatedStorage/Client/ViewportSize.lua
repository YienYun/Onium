-- Script path: ReplicatedStorage.Client.ViewportSize
-- Decompile time: 3.88 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Signal = require(ReplicatedStorage.Packages.Signal)
local u17 = table.freeze({Floor = 0.3, Ceiling = 2.4})
local u18 = {}
u18.Changed = Signal.new()

local function scaleFor(a1) -- Line: 20 -- upvalues: u17 (val) -- types: a1: userdata
    return (math.clamp((math.min(a1.X, a1.Y)) / 1100, u17.Floor, u17.Ceiling))
end

local function snapshotOf(a1) -- Line: 25 -- upvalues: u17 (val) -- types: a1: userdata
    return {
        Size = a1,
        Scale = math.clamp((math.min(a1.X, a1.Y)) / 1100, u17.Floor, u17.Ceiling),
    }
end

local CurrentCamera = Workspace.CurrentCamera
local ViewportSize = if not CurrentCamera then Vector2.one * 1100 else CurrentCamera.ViewportSize
local u27 = {Size = ViewportSize}
local v1 = (math.min(ViewportSize.X, ViewportSize.Y)) / 1100
u27.Scale = math.clamp(v1, u17.Floor, u17.Ceiling)
local u40 = false
local u41 = nil

local function flush() -- Line: 34 -- upvalues: u40 (ref), Workspace (val), u27 (ref), u17 (val), u18 (val)
    u40 = false
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    local ViewportSize = CurrentCamera.ViewportSize
    if ViewportSize == u27.Size then
        return
    end
    u27 = {
        Size = ViewportSize,
        Scale = math.clamp((math.min(ViewportSize.X, ViewportSize.Y)) / 1100, u17.Floor, u17.Ceiling),
    }
    u18.Changed:Fire(u27.Size, u27.Scale)
end

local function queueFlush() -- Line: 51 -- upvalues: u40 (ref), flush (val)
    if u40 then
        return
    end
    u40 = true
    task.defer(flush)
end

local function follow(a1) -- Line: 59
    -- upvalues: u41 (ref), queueFlush (val), u40 (ref), flush (val)
    if u41 ~= nil then
        u41:Disconnect()
        u41 = nil
    end
    if a1 == nil then
        return
    end
    ;(a1:GetPropertyChangedSignal("ViewportSize")):Connect(queueFlush)
    if u40 then
        return
    end
    u40 = true
    task.defer(flush)
end

function u18.Get() -- Line: 71 -- upvalues: u27 (ref)
    return u27.Size
end

function u18.ReadScale() -- Line: 75 -- upvalues: u27 (ref)
    return u27.Scale
end

function u18.Observe(a1) -- Line: 81 -- upvalues: u18 (val), u27 (ref) -- types: a1: function
    local u6 = u18.Changed:Connect(a1)
    a1(u27.Size, u27.Scale)
    return function() -- Line: 84 -- upvalues: u6 (val)
        u6:Disconnect()
    end
end

;(Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 89 -- upvalues: Workspace (val), u41 (ref), queueFlush (val), u40 (ref), flush (val)
    local CurrentCamera = Workspace.CurrentCamera
    if u41 ~= nil then
        u41:Disconnect()
        u41 = nil
    end
    if CurrentCamera == nil then
        return
    end
    ;(CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(queueFlush)
    if u40 then
        return
    end
    u40 = true
    task.defer(flush)
end)
if u41 ~= nil then
    u41:Disconnect()
end
if CurrentCamera ~= nil then
    (CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(queueFlush)
    if not u40 then
        task.defer(flush)
    end
end
return (table.freeze(u18))