-- Script path: ReplicatedStorage.Shared.Modules.QueueLock
-- Decompile time: 2.17 ms

local u0 = {}
u0.__index = u0
local u1 = {}
u1.__index = u1

local function newLease(a1) -- Line: 28 -- upvalues: u1 (val)
    return (setmetatable({lock = a1, takenAt = os.clock()}, u1))
end

local function nextInLine(a1) -- Line: 34
    local v1
    local line = a1.line
    while a1.head < a1.tail do
        v1 = line[a1.head]
        line[a1.head] = nil
        a1.head = a1.head + 1
        if coroutine.status(v1) == "suspended" then
            return v1
        end
    end
    a1.head = 1
    a1.tail = 1
    return nil
end

local function failureReport(a1) -- Line: 48
    return debug.traceback(("QueueLock body raised: %*"):format((tostring(a1))), 2)
end

local function settle(a1, a2, ...) -- Line: 52 -- types: a2: boolean
    a1:GiveBack()
    if not a2 then
        error(..., 0)
    end
    return ...
end

function u0.new() -- Line: 60 -- upvalues: u0 (val)
    return (setmetatable({head = 1, tail = 1, line = {}}, u0))
end

function u0:TryTake() -- Line: 66 -- upvalues: u1 (val)
    if self.occupant then
        return nil
    end
    local v1 = {lock = self, takenAt = os.clock()}
    local v2 = setmetatable(v1, u1)
    self.occupant = v2
    return v2
end

function u0:Take() -- Line: 76
    local v1 = self:TryTake()
    if v1 then
        return v1
    end
    self.line[self.tail] = (coroutine.running())
    self.tail = self.tail + 1
    return coroutine.yield()
end

function u0.WithLock(a1, a2, ...) -- Line: 88 -- upvalues: settle (val), failureReport (val) -- types: a2: function
    local v1 = a1:Take()
    local v2 = settle
    local success = xpcall(a2, failureReport, ...)
    return v2(v1, success)
end

function u0.Destroy(a1) -- Line: 94
    if a1.occupant then
        return
    end
    table.clear(a1)
    setmetatable(a1, nil)
end

function u1:GiveBack() -- Line: 104 -- upvalues: nextInLine (val), u1 (val)
    local lock = self.lock
    if lock.occupant ~= self then
        error("GiveBack: this lease does not hold its lock", 2)
    end
    local v1 = nextInLine(lock)
    if v1 == nil then
        lock.occupant = nil
        return
    end
    local v2 = {lock = lock, takenAt = os.clock()}
    local v3 = setmetatable(v2, u1)
    lock.occupant = v3
    task.defer(v1, v3)
end

return u0