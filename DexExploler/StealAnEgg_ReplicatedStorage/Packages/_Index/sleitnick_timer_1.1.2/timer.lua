-- Script path: ReplicatedStorage.Packages._Index.sleitnick_timer@1.1.2.timer
-- Decompile time: 2.76 ms

local Signal = require(script.Parent.Signal)
local RunService = game:GetService("RunService")
local u10 = {}
u10.__index = u10

function u10.new(a1) -- Line: 73 -- upvalues: u10 (val), RunService (val), Signal (val) -- types: a1: number
    local v1 = "Argument #1 to Timer.new must be a number; got " .. (type(a1))
    assert(type(a1) == "number", v1)
    v1 = "Argument #1 to Timer.new must be greater or equal to 0; got " .. (tostring(a1))
    assert(a1 >= 0, v1)
    local v2 = setmetatable({}, u10)
    v2._runHandle = nil
    v2.Interval = a1
    v2.UpdateSignal = RunService.Heartbeat
    v2.TimeFunction = time
    v2.AllowDrift = true
    v2.Tick = Signal.new()
    return v2
end

function u10.Simple(a1, a2, a3, a4, a5) -- Line: 103
    -- upvalues: RunService (val)
    local Heartbeat = a4 or RunService.Heartbeat
    local u10 = a5
    if not u10 then
        u10 = time
    end
    local u16 = u10() + a1
    if a3 then
        task.defer(a2)
    end
    return (Heartbeat:Connect(function() -- Line: 116 -- upvalues: u10 (val), u16 (ref), a1 (val), a2 (val)
        local v1 = u10()
        if u16 <= v1 then
            u16 = v1 + a1
            task.defer(a2)
        end
    end))
end

function u10.Is(a1) -- Line: 128 -- upvalues: u10 (val)
    local v1 = false
    if type(a1) == "table" then
        v1 = (getmetatable(a1)) == u10
    end
    return v1
end

function u10:_startTimer() -- Line: 132
    local TimeFunction = self.TimeFunction
    local u5 = TimeFunction() + self.Interval
    self._runHandle = self.UpdateSignal:Connect(function() -- Line: 135 -- upvalues: TimeFunction (val), u5 (ref), self (val)
        local v1 = TimeFunction()
        if u5 <= v1 then
            u5 = v1 + self.Interval
            self.Tick:Fire()
        end
    end)
end

function u10:_startTimerNoDrift() -- Line: 144
    assert(0 < self.Interval, "Interval must be greater than 0 when AllowDrift is set to false")
    local TimeFunction = self.TimeFunction
    local u11 = 1
    local u13 = TimeFunction()
    local u15 = u13 + self.Interval
    self._runHandle = self.UpdateSignal:Connect(function() -- Line: 150 -- upvalues: TimeFunction (val), u15 (ref), u11 (ref), u13 (val), self (val)
        local v1 = TimeFunction()
        while u15 <= v1 do
            u11 = u11 + 1
            u15 = u13 + self.Interval * u11
            self.Tick:Fire()
        end
    end)
end

function u10:Start() -- Line: 167
    if self._runHandle then
        return
    end
    if self.AllowDrift then
        self:_startTimer()
        return
    end
    self:_startTimerNoDrift()
end

function u10.StartNow(a1) -- Line: 186
    if a1._runHandle then
        return
    end
    a1.Tick:Fire()
    a1:Start()
end

function u10:Stop() -- Line: 201
    if not self._runHandle then
        return
    end
    self._runHandle:Disconnect()
    self._runHandle = nil
end

function u10.IsRunning(a1) -- Line: 218
    return a1._runHandle ~= nil
end

function u10:Destroy() -- Line: 225
    self.Tick:Destroy()
    self:Stop()
end

return u10