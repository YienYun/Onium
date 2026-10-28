-- Script path: ReplicatedStorage.Packages.Spring
-- Decompile time: 4.93 ms

local u0 = {}

local function getIsValueValid(a1) -- Line: 47
    local v1 = false
    if a1 == a1 then
        v1 = a1 ~= nil
    end
    return v1
end

function u0.new(a1, a2) -- Line: 54 -- upvalues: u0 (val)
    local v1 = false
    if a1 == a1 then
        v1 = a1 ~= nil
    end
    v1 = if v1 then a1 else if typeof(a1) ~= "Vector3" then 0 else Vector3.new(0, 0, 0)
    local v2 = a2 or tick
    return (setmetatable({
        _damper = 1,
        _speed = 1,
        _clock = v2,
        _time0 = v2(),
        _position0 = v1,
        _velocity0 = 0 * v1,
        _target = v1,
    }, u0))
end

function u0.Impulse(a1, a2) -- Line: 78
    local v1 = false
    if a2 == a2 then
        v1 = a2 ~= nil
    end
    if not v1 then
        return
    end
    a1.Velocity = a1.Velocity + a2
end

function u0.TimeSkip(a1, a2) -- Line: 88
    local v1 = a1._clock()
    local v2, v3 = a1:_positionVelocity(v1 + a2)
    a1._position0 = v2
    a1._velocity0 = v3
    a1._time0 = v1
end

function u0.getPosition(a1) -- Line: 96
    return a1:_positionVelocity((a1._clock()))
end

function u0.__index(a1, a2) -- Line: 100 -- upvalues: u0 (val)
    if u0[a2] then
        return u0[a2]
    end
    if a2 ~= "Value" and a2 ~= "Position" and a2 ~= "p" then
        local v1
        if a2 ~= "Velocity" and a2 ~= "v" then
            if a2 ~= "Target" and a2 ~= "t" then
                if a2 ~= "Damper" and a2 ~= "d" then
                    if a2 ~= "Speed" and a2 ~= "s" then
                        if a2 == "Clock" then
                            return a1._clock
                        end
                        error(("%q is not a valid member of Spring"):format((tostring(a2))), 2)
                        return
                    end
                    return a1._speed
                end
                return a1._damper
            end
            return a1._target
        end
        _, v1 = a1:_positionVelocity((a1._clock()))
        return v1
    end
    return (a1:_positionVelocity((a1._clock())))
end

function u0.__newindex(a1, a2, a3) -- Line: 122
    local v1
    local v2 = a1._clock()
    local v3 = false
    if a3 == a3 then
        v3 = a3 ~= nil
    end
    if not v3 then
        return
    end
    if a2 ~= "Value" and a2 ~= "Position" and a2 ~= "p" then
        if a2 ~= "Velocity" and a2 ~= "v" then
            if a2 ~= "Target" and a2 ~= "t" then
                if a2 ~= "Damper" and a2 ~= "d" then
                    if a2 ~= "Speed" and a2 ~= "s" then
                        if a2 ~= "Clock" then
                            error(("%q is not a valid member of Spring"):format((tostring(a2))), 2)
                            return
                        end
                        v3, v1 = a1:_positionVelocity(v2)
                        a1._position0 = v3
                        a1._velocity0 = v1
                        a1._clock = a3
                        a1._time0 = a3()
                        return
                    end
                    v3, v1 = a1:_positionVelocity(v2)
                    a1._position0 = v3
                    a1._velocity0 = v1
                    a1._speed = if not (a3 < 0) then a3 else 0
                    a1._time0 = v2
                    return
                end
                v3, v1 = a1:_positionVelocity(v2)
                a1._position0 = v3
                a1._velocity0 = v1
                a1._damper = math.clamp(a3, 0, 1)
                a1._time0 = v2
                return
            end
            v3, v1 = a1:_positionVelocity(v2)
            a1._position0 = v3
            a1._velocity0 = v1
            a1._target = a3
            a1._time0 = v2
            return
        end
        a1._position0 = (a1:_positionVelocity(v2))
        a1._velocity0 = a3
        a1._time0 = v2
        return
    end
    _, v1 = a1:_positionVelocity(v2)
    a1._position0 = a3
    a1._velocity0 = v1
    a1._time0 = v2
end

function u0:_positionVelocity(a2) -- Line: 168
    local v1, v2, v3, v4, v5
    local _position0 = self._position0
    local _velocity0 = self._velocity0
    local _target = self._target
    local _damper = self._damper
    local _speed = self._speed
    local v6 = _speed * (a2 - self._time0)
    local v7 = _damper * _damper
    if v7 < 1 then
        v5 = math.sqrt(1 - v7)
        v3 = math.exp(-_damper * v6) / v5
        v2 = v3 * math.cos(v5 * v6)
        v1 = v3 * math.sin(v5 * v6)
    elseif v7 ~= 1 then
        v5 = math.sqrt(v7 - 1)
        v3 = (math.exp((-_damper + v5) * v6)) / (2 * v5)
        v4 = (math.exp((-_damper - v5) * v6)) / (2 * v5)
        v2 = v3 + v4
        v1 = v3 - v4
    else
        v3 = math.exp(-_damper * v6) / 1
        v2 = v3
        v1 = v3 * v6
    end
    v7 = v5 * v2 + _damper * v1
    v6 = 1 - (v5 * v2 + _damper * v1)
    v3 = v1 / _speed
    v4 = -_speed * v1
    local v8 = _speed * v1
    local v9 = v5 * v2 - _damper * v1
    return v7 * _position0 + v6 * _target + v3 * _velocity0, v4 * _position0 + v8 * _target + v9 * _velocity0
end

return u0