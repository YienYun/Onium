-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardMovementRecovery
-- Decompile time: 3.04 ms

local GuardRecovery = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardRecovery
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local u26 = Log.new()
local u27 = {}
u27.__index = u27
u27.__class = "GuardMovementRecovery"

function u27.new(a1, a2) -- Line: 40 -- upvalues: t (val), u27 (val) -- types: a1: userdata, a2: userdata
    t.strict(t.instanceIsA("BasePart"))(a1)
    t.strict(t.instanceIsA("BasePart"))(a2)
    local v1 = setmetatable({}, u27)
    v1._ground = a2
    v1._lastProgressPosition = nil
    v1._lastProgressTime = 0
    v1._returnHomeStartedAt = nil
    v1._root = a1
    return v1
end

function u27:_getHorizontalDistance(a2) -- Line: 59 -- types: a2: vector
    local v1 = self._root.Position - a2
    return Vector3.new(v1.X, 0, v1.Z).Magnitude
end

function u27:Reset() -- Line: 72
    self._lastProgressPosition = nil
    self._lastProgressTime = 0
    self._returnHomeStartedAt = nil
end

function u27.ShouldRecoverFromFall(a1) -- Line: 78 -- upvalues: GuardRecovery (val), u26 (val)
    local Y = a1._root.Position.Y
    if a1._ground.Position.Y - GuardRecovery.FALL_RECOVERY_DEPTH <= Y then
        return false
    end
    ;(u26:AtWarning()):Log((("Guard fell below the world and requires recovery: %*"):format((a1._root:GetFullName()))))
    return true
end

function u27.Step(a1, a2, a3, a4) -- Line: 88
    -- upvalues: t (val), GuardRecovery (val), u26 (val)
    local _lastProgressPosition
    t.strict(t.number)(a2)
    t.strict(t.boolean)(a3)
    t.strict(t.boolean)(a4)
    if not a4 then
        a1._returnHomeStartedAt = nil
        if not a3 then
            a1._lastProgressPosition = nil
            a1._lastProgressTime = 0
            return false
        end
        _lastProgressPosition = a1._lastProgressPosition
        if _lastProgressPosition == nil
            or GuardRecovery.MINIMUM_HORIZONTAL_PROGRESS <= (a1:_getHorizontalDistance(_lastProgressPosition)) then
            a1._lastProgressPosition = a1._root.Position
            a1._lastProgressTime = a2
            return false
        end
        if a2 - a1._lastProgressTime < GuardRecovery.STUCK_TIMEOUT then
            return false
        end
        ;(u26:AtWarning()):Log((("Guard stuck recovery triggered for %*"):format((a1._root:GetFullName()))))
        a1:Reset()
        return true
    end
    local _returnHomeStartedAt = a1._returnHomeStartedAt
    if _returnHomeStartedAt == nil then
        a1._returnHomeStartedAt = a2
        if not a3 then
            a1._lastProgressPosition = nil
            a1._lastProgressTime = 0
            return false
        end
        _lastProgressPosition = a1._lastProgressPosition
        if _lastProgressPosition == nil
            or GuardRecovery.MINIMUM_HORIZONTAL_PROGRESS <= (a1:_getHorizontalDistance(_lastProgressPosition)) then
            a1._lastProgressPosition = a1._root.Position
            a1._lastProgressTime = a2
            return false
        end
        if a2 - a1._lastProgressTime < GuardRecovery.STUCK_TIMEOUT then
            return false
        end
        ;(u26:AtWarning()):Log((("Guard stuck recovery triggered for %*"):format((a1._root:GetFullName()))))
        a1:Reset()
        return true
    end
    if GuardRecovery.RETURN_HOME_TIMEOUT <= a2 - _returnHomeStartedAt then
        (u26:AtWarning()):Log((("Guard return-home timeout triggered for %*"):format((a1._root:GetFullName()))))
        a1:Reset()
        return true
    end
    if not a3 then
        a1._lastProgressPosition = nil
        a1._lastProgressTime = 0
        return false
    end
    _lastProgressPosition = a1._lastProgressPosition
    if _lastProgressPosition == nil
        or GuardRecovery.MINIMUM_HORIZONTAL_PROGRESS <= (a1:_getHorizontalDistance(_lastProgressPosition)) then
        a1._lastProgressPosition = a1._root.Position
        a1._lastProgressTime = a2
        return false
    end
    if a2 - a1._lastProgressTime < GuardRecovery.STUCK_TIMEOUT then
        return false
    end
    ;(u26:AtWarning()):Log((("Guard stuck recovery triggered for %*"):format((a1._root:GetFullName()))))
    a1:Reset()
    return true
end

return u27