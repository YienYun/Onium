-- Script path: ReplicatedStorage.Client.Input.TouchTapTracker
-- Decompile time: 3.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local u13 = {}
u13.__index = u13
u13.__class = "TouchTapTracker"
local u19 = t.strict(t.optional(t.table))
local u24 = t.strict(t.optional(t.number))
local u27 = Log.new()

local function requireTouch(a1) -- Line: 36 -- types: a1: userdata
    assert(a1.UserInputType == Enum.UserInputType.Touch)
end

local function travelled(a1, a2) -- Line: 40 -- types: a2: userdata
    local origin = a1.origin
    if origin then
        return (a2.Position - origin).Magnitude
    end
    return nil
end

function u13.new(a1) -- Line: 45 -- upvalues: u19 (val), u24 (val), u13 (val), u27 (val) -- types: a1: table?
    u19(a1)
    if a1 then
        u24(a1.MaxMovement)
        u24(a1.MaxDuration)
    end
    local v1 = a1 or {}
    local v2 = setmetatable({}, u13)
    v2.slop = v1.MaxMovement or 16
    v2.holdLimit = v1.MaxDuration or 0.35
    v2.claimed = nil
    v2.pressedAt = 0
    v2.origin = nil
    v2.aborted = false
    u27:AtDebug():Log("tap tracker ready")
    return v2
end

function u13:Reset() -- Line: 66
    self.claimed = nil
    self.pressedAt = 0
    self.origin = nil
    self.aborted = false
end

function u13.IsTrackingInput(a1, a2) -- Line: 73 -- types: a2: userdata
    return a1.claimed == a2
end

function u13.IsCancelled(a1) -- Line: 77
    return a1.aborted
end

function u13.Begin(a1, a2) -- Line: 79 -- types: a2: userdata
    assert(a2.UserInputType == Enum.UserInputType.Touch)
    a1.claimed = a2
    a1.pressedAt = os.clock()
    a1.origin = a2.Position
    a1.aborted = false
end

function u13.Update(a1, a2) -- Line: 88 -- types: a2: userdata
    assert(a2.UserInputType == Enum.UserInputType.Touch)
    if a1.claimed == a2 and not a1.aborted then
        local origin = a1.origin
        local Magnitude = if not origin then nil else (a2.Position - origin).Magnitude
        local v1 = true
        if Magnitude ~= nil then
            v1 = a1.slop < Magnitude
        end
        a1.aborted = v1
        return not v1
    end
    return false
end

function u13.Evaluate(a1, a2, a3) -- Line: 104 -- types: a2: userdata, a3: boolean
    assert(a2.UserInputType == Enum.UserInputType.Touch)
    local origin = a1.origin
    local Magnitude = if not origin then nil else (a2.Position - origin).Magnitude
    local pressedAt = a1.pressedAt
    local v1 = not a3
    if v1 then
        v1 = false
        if a1.claimed == a2 then
            v1 = not a1.aborted
            if v1 then
                v1 = false
                if Magnitude ~= nil then
                    v1 = false
                    if pressedAt > 0 then
                        v1 = false
                        if os.clock() - pressedAt <= a1.holdLimit then
                            v1 = Magnitude <= a1.slop
                        end
                    end
                end
            end
        end
    end
    a1:Reset()
    return v1
end

return u13