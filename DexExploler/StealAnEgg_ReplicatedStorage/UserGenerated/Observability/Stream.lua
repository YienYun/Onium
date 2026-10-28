-- Script path: ReplicatedStorage.UserGenerated.Observability.Stream
-- Decompile time: 2.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Op = Observability.Op
local u15 = {}
u15.__index = u15

function u15.new(a1, a2) -- Line: 28 -- upvalues: Codec (val), u15 (val) -- types: a1: number, a2: function
    local v1 = {
        Init = false,
        LastTime = 0,
        Records = 0,
        StageTime = 0,
        StageStart = 0,
        BatchBytes = a1,
        OnBatch = a2,
        W = Codec.newWriter(a1 + 1024),
        Scratch = Codec.newWriter(16384),
        Staged = {},
    }
    local v2 = setmetatable(v1, u15)
    v2:_writeTime()
    return v2
end

function u15:_writeTime() -- Line: 46 -- upvalues: Op (val)
    local W = self.W
    W:u8(Op.Time)
    W:u32(self.LastTime)
end

function u15:Time(a2) -- Line: 52 -- upvalues: Op (val), Codec (val) -- types: self: table, a2: number
    local v1 = math.clamp(math.floor(a2), 0, 4294967295)
    if self.Main then
        self.StageTime = v1
        return
    end
    if self.LastTime < v1 then
        local W = self.W
        W:u8(Op.TimeDelta)
        Codec.varuint(W, v1 - self.LastTime)
        self.LastTime = v1
    end
end

function u15.BeginStage(a1) -- Line: 65
    assert(not a1.Main, "stage already open")
    a1.Main = a1.W
    a1.W = a1.Scratch
    a1.W.len = 0
    a1.StageStart = 0
    a1.StageTime = a1.LastTime
    table.clear(a1.Staged)
end

function u15.CommitStage(a1) -- Line: 75
    local W_2, v1
    local W = a1.W
    a1.W = a1.Main
    a1.Main = nil
    local Staged = a1.Staged
    table.sort(Staged, function(a1, a2) -- Line: 80
        if a1.T ~= a2.T then
            return a1.T < a2.T
        end
        return a1.Index < a2.Index
    end)
    for i, j in Staged do
        a1:Time(j.T)
        W_2 = a1.W
        v1 = j.Finish - j.Start
        W_2:_ensure(v1)
        buffer.copy(W_2.buf, W_2.len, W.buf, j.Start, v1)
        W_2.len = W_2.len + v1
        a1:EndRecord()
    end
    table.clear(Staged)
end

function u15:EndRecord() -- Line: 99
    if not self.Main then
        self.Records = self.Records + 1
        if self.BatchBytes <= self.W.len then
            self:Cut()
        end
        return
    end
    local Staged = self.Staged
    local len = self.W.len
    table.insert(Staged, {
        T = self.StageTime,
        Start = self.StageStart,
        Finish = len,
        Index = #Staged + 1,
    })
    self.StageStart = len
end

function u15:Cut() -- Line: 114 -- upvalues: Codec (val)
    if self.Records == 0 then
        return
    end
    local v1 = self.W:finish()
    self.W = Codec.newWriter(self.BatchBytes + 1024)
    self.Records = 0
    self:_writeTime()
    self.OnBatch(v1, self.Init)
end

function u15.ClockSync(a1, a2) -- Line: 126 -- upvalues: Op (val) -- types: a1: table, a2: number
    local W = a1.W
    W:u8(Op.ClockSync)
    W:f64(a2)
    a1:EndRecord()
end

return u15