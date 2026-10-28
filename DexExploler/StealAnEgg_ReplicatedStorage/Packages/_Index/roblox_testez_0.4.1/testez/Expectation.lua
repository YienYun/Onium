-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.Expectation
-- Decompile time: 7.14 ms

local u0 = {}
local u1 = {
    to = true,
    be = true,
    been = true,
    have = true,
    was = true,
    at = true,
}
local u2 = {never = true}

local function assertLevel(a1, a2, a3) -- Line: 42
    if not a1 then
        error(a2 or "Assertion failed!", (a3 or 1) + 1)
    end
end

local function bindSelf(a1, a2) -- Line: 54
    return function(a1_2, ...) -- Line: 55 -- upvalues: a1 (val), a2 (val)
        if a1_2 == a1 then
            return a2(a1, ...)
        end
        return a2(a1, a1_2, ...)
    end
end

local function formatMessage(a1, a2, a3) -- Line: 64
    if a1 then
        return a2
    end
    return a3
end

function u0.new(a1) -- Line: 75 -- upvalues: u0 (val)
    local u1 = {successCondition = true, condition = false, value = a1}
    u1.matchers = {}
    u1._boundMatchers = {}
    setmetatable(u1, u0)
    local a = u1.a

    function u1.a(a1, ...) -- Line: 55 -- upvalues: u1 (val), a (val)
        if a1 == u1 then
            return a(u1, ...)
        end
        return a(u1, a1, ...)
    end

    u1.an = u1.a
    local ok = u1.ok

    function u1.ok(a1, ...) -- Line: 55 -- upvalues: u1 (val), ok (val)
        if a1 == u1 then
            return ok(u1, ...)
        end
        return ok(u1, a1, ...)
    end

    local equal = u1.equal

    function u1.equal(a1, ...) -- Line: 55 -- upvalues: u1 (val), equal (val)
        if a1 == u1 then
            return equal(u1, ...)
        end
        return equal(u1, a1, ...)
    end

    local throw = u1.throw

    function u1.throw(a1, ...) -- Line: 55 -- upvalues: u1 (val), throw (val)
        if a1 == u1 then
            return throw(u1, ...)
        end
        return throw(u1, a1, ...)
    end

    local near = u1.near

    function u1.near(a1, ...) -- Line: 55 -- upvalues: u1 (val), near (val)
        if a1 == u1 then
            return near(u1, ...)
        end
        return near(u1, a1, ...)
    end

    return u1
end

function u0.checkMatcherNameCollisions(a1) -- Line: 96 -- upvalues: u1 (val), u2 (val), u0 (val)
    if not u1[a1] and not u2[a1] and not u0[a1] then
        return true
    end
    return false
end

function u0:extend(a2) -- Line: 104
    local _boundMatchers
    self.matchers = a2 or {}
    for k, v in pairs(self.matchers) do
        _boundMatchers = self._boundMatchers

        local function u20(a1, ...) -- Line: 108 -- upvalues: v (val), self (val)
            local v1 = v(self.value, ...)
            local v2 = v1.pass == self.successCondition
            local message = v1.message
            if not v2 then
                error(message or "Assertion failed!", 4)
            end
            self:_resetModifiers()
            return self
        end

        _boundMatchers[k] = function(a1, ...) -- Line: 55 -- upvalues: self (val), u20 (val)
            if a1 == self then
                return u20(self, ...)
            end
            return u20(self, a1, ...)
        end
    end
    return self
end

function u0.__index(a1, a2) -- Line: 121 -- upvalues: u1 (val), u2 (val), u0 (val)
    if u1[a2] then
        return a1
    end
    if u2[a2] then
        local v1 = (u0.new(a1.value)):extend(a1.matchers)
        v1.successCondition = not a1.successCondition
        return v1
    end
    if a1._boundMatchers[a2] then
        return a1._boundMatchers[a2]
    end
    return u0[a2]
end

function u0:_resetModifiers() -- Line: 154
    self.successCondition = true
end

function u0.a(a1, a2) -- Line: 163
    local v1 = type(a1.value) == a2 == a1.successCondition
    local successCondition = a1.successCondition
    local v2 = ("Expected value of type %q, got value %q of type %s"):format(a2, tostring(a1.value), (type(a1.value)))
    local v3 = ("Expected value not of type %q, got value %q of type %s"):format(a2, tostring(a1.value), (type(a1.value)))
    local v4 = if not successCondition then v3 else v2
    if not v1 then
        error(v4 or "Assertion failed!", 4)
    end
    a1:_resetModifiers()
    return a1
end

u0.an = u0.a

function u0.ok(a1) -- Line: 188
    local v1 = a1.value ~= nil == a1.successCondition
    local successCondition = a1.successCondition
    local v2 = ("Expected value %q to be non-nil"):format((tostring(a1.value)))
    local v3 = ("Expected value %q to be nil"):format((tostring(a1.value)))
    local v4 = if not successCondition then v3 else v2
    if not v1 then
        error(v4 or "Assertion failed!", 4)
    end
    a1:_resetModifiers()
    return a1
end

function u0.equal(a1, a2) -- Line: 206
    local v1 = a1.value == a2 == a1.successCondition
    local successCondition = a1.successCondition
    local v2 = ("Expected value %q (%s), got %q (%s) instead"):format(tostring(a2), type(a2), tostring(a1.value), (type(a1.value)))
    local v3 = ("Expected anything but value %q (%s)"):format(tostring(a2), (type(a2)))
    local v4 = if not successCondition then v3 else v2
    if not v1 then
        error(v4 or "Assertion failed!", 4)
    end
    a1:_resetModifiers()
    return a1
end

function u0.near(a1, a2, a3) -- Line: 230
    assert(type(a1.value) == "number", "Expectation value must be a number to use 'near'")
    assert(type(a2) == "number", "otherValue must be a number")
    local v1 = true
    if type(a3) ~= "number" then
        v1 = a3 == nil
    end
    assert(v1, "limit must be a number or nil")
    local v2 = a3 or 1e-07
    local v3 = math.abs(a1.value - a2) <= v2 == a1.successCondition
    local successCondition = a1.successCondition
    local v4 = ("Expected value to be near %f (within %f) but got %f instead"):format(a2, v2, a1.value)
    local v5 = ("Expected value to not be near %f (within %f) but got %f instead"):format(a2, v2, a1.value)
    v1 = if not successCondition then v5 else v4
    if not v3 then
        error(v1 or "Assertion failed!", 4)
    end
    a1:_resetModifiers()
    return a1
end

function u0.throw(a1, a2) -- Line: 256
    local v1, v2
    local success, err = pcall(a1.value)
    local v3 = success ~= a1.successCondition
    if a2 and not success then
        v3 = if not a1.successCondition then err:find(a2, 1, true) == nil else err:find(a2, 1, true) ~= nil
    end
    if not a2 then
        local successCondition_2 = a1.successCondition
        v2 = ("Expected function to succeed, but it threw an error: %s"):format((tostring(err)))
        v1 = if not successCondition_2 then v2 else "Expected function to throw an error, but it did not throw."
    else
        local successCondition = a1.successCondition
        v2 = ("Expected function to throw an error containing %q, but it %s"):format(a2, err and ("threw: %s"):format(err) or "did not throw.")
        local v4 = ("Expected function to never throw an error containing %q, but it threw: %s"):format(a2, (tostring(err)))
        v1 = if not successCondition then v4 else v2
    end
    if not v3 then
        error(v1 or "Assertion failed!", 4)
    end
    a1:_resetModifiers()
    return a1
end

return u0