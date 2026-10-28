-- Script path: ReplicatedStorage.Packages._Index.sleitnick_signal@2.0.3.signal
-- Decompile time: 5.49 ms

local u0 = nil
local t = require(((game:GetService("ReplicatedStorage")):WaitForChild("Packages")):WaitForChild("t"))

local function acquireRunnerThreadAndCallEventHandler(a1, ...) -- Line: 47 -- upvalues: u0 (ref)
    local v1 = u0
    u0 = nil
    a1(...)
    u0 = v1
end

local function runEventHandlerInFreeThread(...) -- Line: 58 -- upvalues: acquireRunnerThreadAndCallEventHandler (val)
    acquireRunnerThreadAndCallEventHandler(...)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local function getOrCreateReusableRunnerThread(...) -- Line: 65 -- upvalues: u0 (ref), runEventHandlerInFreeThread (val)
    if not u0 then
        u0 = coroutine.create(runEventHandlerInFreeThread)
    end
    task.spawn(u0, ...)
end

local u19 = {}
u19.__index = u19

function u19:Disconnect() -- Line: 91
    if not self.Connected then
        return
    end
    self.Connected = false
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

u19.Destroy = u19.Disconnect
local v1 = {
    __index = function(a1, a2) -- Line: 118
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
    __newindex = function(a1, a2, a3) -- Line: 121
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
}
setmetatable(u19, v1)
local u28 = {}
u28.__index = u28

function u28._deployStickyBehavior(a1, a2) -- Line: 158
    -- upvalues: getOrCreateReusableRunnerThread (val)
    local v1 = rawget(a1, "_stickyBehavior")
    if not v1 then
        return
    end
    getOrCreateReusableRunnerThread(v1, a2)
end

function u28.new(a1) -- Line: 172 -- upvalues: t (val), u28 (val) -- types: a1: function?
    t.strict(t.optional(t.callback))(a1)
    return (setmetatable({_handlerListHead = false, _stickyBehavior = a1}, u28))
end

function u28.Wrap(a1) -- Line: 198 -- upvalues: u28 (val) -- types: a1: userdata
    local v1 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. (typeof(a1))
    assert(typeof(a1) == "RBXScriptSignal", v1)
    local u17 = u28.new()
    u17._proxyHandler = a1:Connect(function(...) -- Line: 205 -- upvalues: u17 (val)
        u17:Fire(...)
    end)
    return u17
end

function u28.Is(a1) -- Line: 218 -- upvalues: u28 (val)
    local v1 = false
    if type(a1) == "table" then
        v1 = (getmetatable(a1)) == u28
    end
    return v1
end

function u28:Connect(a2) -- Line: 235 -- upvalues: u19 (val)
    local v1 = {Connected = true, _next = false, _signal = self, _fn = a2}
    local v2 = setmetatable(v1, u19)
    if self._handlerListHead then
        v2._next = self._handlerListHead
    end
    self._handlerListHead = v2
    self:_deployStickyBehavior(a2)
    return v2
end

function u28.ConnectOnce(a1, a2) -- Line: 259
    return a1:Once(a2)
end

function u28:Once(a2) -- Line: 278
    local u2 = nil
    local u3 = false
    u2 = (self:Connect(function(...) -- Line: 282 -- upvalues: u3 (ref), u2 (ref), a2 (val)
        if u3 then
            return
        end
        u3 = true
        u2:Disconnect()
        a2(...)
    end))
    return u2
end

function u28.GetConnections(a1) -- Line: 295
    local v1 = {}
    local _handlerListHead = a1._handlerListHead
    while _handlerListHead do
        table.insert(v1, _handlerListHead)
        _handlerListHead = _handlerListHead._next
    end
    return v1
end

function u28:DisconnectAll() -- Line: 315
    local _handlerListHead = self._handlerListHead
    while _handlerListHead do
        _handlerListHead.Connected = false
        _handlerListHead = _handlerListHead._next
    end
    self._handlerListHead = false
    local v1 = rawget(self, "_yieldedThreads")
    if v1 then
        for i in v1 do
            if coroutine.status(i) == "suspended" then
                warn(debug.traceback(i, "signal disconnected; yielded thread cancelled", 2))
                task.cancel(i)
            end
        end
        table.clear(self._yieldedThreads)
    end
end

function u28:Fire(...) -- Line: 350 -- upvalues: getOrCreateReusableRunnerThread (val)
    local _handlerListHead = self._handlerListHead
    while _handlerListHead do
        if _handlerListHead.Connected then
            getOrCreateReusableRunnerThread(_handlerListHead._fn, ...)
        end
        _handlerListHead = _handlerListHead._next
    end
end

function u28.FireDeferred(a1, ...) -- Line: 368
    local _handlerListHead = a1._handlerListHead
    while _handlerListHead do
        local u3 = _handlerListHead
        task.defer(function(...) -- Line: 372 -- upvalues: u3 (val)
            if u3.Connected then
                u3._fn(...)
            end
        end, ...)
        _handlerListHead = _handlerListHead._next
    end
end

function u28.Wait(a1) -- Line: 396
    local u5 = rawget(a1, "_yieldedThreads")
    if not u5 then
        u5 = {}
        local v1 = u5
        rawset(a1, "_yieldedThreads", v1)
    end
    local u12 = coroutine.running()
    u5[u12] = true
    a1:Once(function(...) -- Line: 406 -- upvalues: u5 (ref), u12 (val)
        u5[u12] = nil
        if coroutine.status(u12) == "suspended" then
            task.spawn(u12, ...)
        end
    end)
    return (coroutine.yield())
end

function u28.Destroy(a1, a2) -- Line: 429 -- types: a1: table, a2: boolean?
    a1:DisconnectAll()
    local v1 = rawget(a1, "_proxyHandler")
    if v1 then
        v1:Disconnect()
    end
    if not a2 then
        return
    end
    setmetatable(a1, nil)
    table.clear(a1)
end

local v2 = {
    __index = function(a1, a2) -- Line: 446
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
    __newindex = function(a1, a2, a3) -- Line: 449
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(a2))), 2)
    end,
}
setmetatable(u28, v2)
return (table.freeze({new = u28.new, Wrap = u28.Wrap, Is = u28.Is}))