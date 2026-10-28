-- Script path: ReplicatedStorage.Packages._Index.sleitnick_shake@1.1.0.shake
-- Decompile time: 5.40 ms

local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u11 = Random.new()
local u12 = 0
local u13 = {}
u13.__index = u13

function u13.new() -- Line: 207 -- upvalues: u13 (val), RunService (val), u11 (val)
    local v1 = setmetatable({}, u13)
    v1.Amplitude = 1
    v1.Frequency = 1
    v1.FadeInTime = 1
    v1.FadeOutTime = 1
    v1.SustainTime = 0
    v1.Sustain = false
    v1.PositionInfluence = Vector3.new(1, 1, 1)
    v1.RotationInfluence = Vector3.new(1, 1, 1)
    v1.TimeFunction = if not RunService:IsRunning() then os.clock else time
    v1._timeOffset = u11:NextNumber(-1000000, 1000000)
    v1._startTime = 0
    v1._running = false
    v1._signalConnections = {}
    v1._renderBindings = {}
    return v1
end

function u13.InverseSquare(a1, a2) -- Line: 258 -- types: a1: vector, a2: number
    if a2 < 1 then
        a2 = 1
    end
    return a1 * (1 / (a2 * a2))
end

function u13.NextRenderName() -- Line: 274 -- upvalues: u12 (ref)
    u12 = u12 + 1
    return ("__shake_%.4i__"):format(u12)
end

function u13.Start(a1) -- Line: 287
    a1._startTime = a1.TimeFunction()
    a1._running = true
end

function u13:Stop() -- Line: 299 -- upvalues: RunService (val)
    self._running = false
    for i, j in self._renderBindings do
        RunService:UnbindFromRenderStep(j)
    end
    table.clear(self._renderBindings)
    for k, n in self._signalConnections do
        n:Disconnect()
    end
    table.clear(self._signalConnections)
end

function u13.IsShaking(a1) -- Line: 317
    return a1._running
end

function u13.StopSustain(a1) -- Line: 326
    local v1 = a1.TimeFunction()
    a1.Sustain = false
    a1.SustainTime = v1 - a1._startTime - a1.FadeInTime
end

function u13:Update() -- Line: 354
    local v1 = false
    local v2 = self.TimeFunction()
    local v3 = v2 - self._startTime
    local v4 = (v2 + self._timeOffset) / self.Frequency % 10000
    v2 = 1
    local v5 = 1
    if v3 < self.FadeInTime then
        v2 = v3 / self.FadeInTime
    end
    if not self.Sustain and self.FadeInTime + self.SustainTime < v3 then
        if self.FadeOutTime ~= 0 then
            v5 = 1 - (v3 - self.FadeInTime - self.SustainTime) / self.FadeOutTime
            if not self.Sustain and self.FadeInTime + self.SustainTime + self.FadeOutTime <= v3 then
                v1 = true
            end
        else
            v1 = true
        end
    end
    v3 = (Vector3.new(math.noise(v4, 0) / 2, math.noise(0, v4) / 2, (math.noise(v4, v4)) / 2)) * self.Amplitude * math.min(v2, v5)
    if v1 then
        self:Stop()
    end
    return self.PositionInfluence * v3, self.RotationInfluence * v3, v1
end

function u13.OnSignal(a1, a2, a3) -- Line: 415 -- types: a1: table, a3: function
    local v1 = a2:Connect(function() -- Line: 416 -- upvalues: a3 (val), a1 (val)
        a3(a1:Update())
    end)
    table.insert(a1._signalConnections, v1)
    return v1
end

function u13:BindToRenderStep(a2, a3, a4) -- Line: 445
    -- upvalues: RunService (val)
    RunService:BindToRenderStep(a2, a3, function() -- Line: 446 -- upvalues: a4 (val), self (val)
        a4(self:Update())
    end)
    table.insert(self._renderBindings, a2)
end

function u13.Clone(a1) -- Line: 482 -- upvalues: u13 (val)
    local v1 = u13.new()
    for i, j in {
        "Amplitude",
        "Frequency",
        "FadeInTime",
        "FadeOutTime",
        "SustainTime",
        "Sustain",
        "PositionInfluence",
        "RotationInfluence",
        "TimeFunction",
    } do
        v1[j] = a1[j]
    end
    return v1
end

function u13.Destroy(a1) -- Line: 504
    a1:Stop()
end

return {
    new = u13.new,
    InverseSquare = u13.InverseSquare,
    NextRenderName = u13.NextRenderName,
}