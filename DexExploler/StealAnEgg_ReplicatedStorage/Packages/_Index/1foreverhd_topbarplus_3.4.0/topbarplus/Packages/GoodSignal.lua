-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Packages.GoodSignal
-- Decompile time: 3.12 ms

local u0 = nil

local function acquireRunnerThreadAndCallEventHandler(a1, ...) -- Line: 34 -- upvalues: u0 (ref)
    local v1 = u0
    u0 = nil
    a1(...)
    u0 = v1
end

local function runEventHandlerInFreeThread() -- Line: 45 -- upvalues: acquireRunnerThreadAndCallEventHandler (val)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local u3 = {}
u3.__index = u3

function u3.new(a1, a2) -- Line: 60 -- upvalues: u3 (val)
    return (setmetatable({_connected = true, _next = false, _signal = a1, _fn = a2}, u3))
end

function u3:Disconnect() -- Line: 69
    self._connected = false
    if self._signal._handlerListHead == self then
        self._signal._handlerListHead = self._next
        return
    end
    local _handlerListHead = self._signal._handlerListHead
    while _handlerListHead do
        if _handlerListHead._next == self then
            break
        end
        _handlerListHead = _handlerListHead._next
    end
    if _handlerListHead then
        _handlerListHead._next = self._next
    end
end

u3.Destroy = u3.Disconnect
local v1 = {
    __index = function(a1, a2) -- Line: 92
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
    __newindex = function(a1, a2, a3) -- Line: 95
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
}
setmetatable(u3, v1)
local u13 = {}
u13.__index = u13

function u13.new() -- Line: 104 -- upvalues: u13 (val)
    return (setmetatable({_handlerListHead = false}, u13))
end

function u13:Connect(a2) -- Line: 110 -- upvalues: u3 (val)
    local v1 = u3.new(self, a2)
    if not self._handlerListHead then
        self._handlerListHead = v1
        return v1
    end
    v1._next = self._handlerListHead
    self._handlerListHead = v1
    return v1
end

function u13.DisconnectAll(a1) -- Line: 123
    a1._handlerListHead = false
end

u13.Destroy = u13.DisconnectAll

function u13.Fire(a1, ...) -- Line: 132 -- upvalues: u0 (ref), runEventHandlerInFreeThread (val)
    local _handlerListHead = a1._handlerListHead
    while _handlerListHead do
        if _handlerListHead._connected then
            if not u0 then
                u0 = coroutine.create(runEventHandlerInFreeThread)
                coroutine.resume(u0)
            end
            task.spawn(u0, _handlerListHead._fn, ...)
        end
        _handlerListHead = _handlerListHead._next
    end
end

function u13.Wait(a1) -- Line: 149
    local u2 = coroutine.running()
    local u3 = nil
    a1:Connect(function(...) -- Line: 152 -- upvalues: u3 (ref), u2 (val)
        u3:Disconnect()
        task.spawn(u2, ...)
    end)
    return (coroutine.yield())
end

function u13.Once(a1, a2) -- Line: 161
    local u2 = nil
    u2 = (a1:Connect(function(...) -- Line: 163 -- upvalues: u2 (ref), a2 (val)
        if u2._connected then
            u2:Disconnect()
        end
        a2(...)
    end))
    return u2
end

local v2 = {
    __index = function(a1, a2) -- Line: 174
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
    __newindex = function(a1, a2, a3) -- Line: 177
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
}
setmetatable(u13, v2)
return u13