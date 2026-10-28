-- Script path: ReplicatedStorage.UserGenerated.Observability.Uplink
-- Decompile time: 4.00 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)

local function newQueue() -- Line: 29
    return {
        Head = 1,
        Tail = 0,
        Bytes = 0,
        Items = {},
        Times = {},
    }
end

local function push(a1, a2, a3) -- Line: 33 -- types: a1: table, a2: buffer, a3: number
    a1.Tail = a1.Tail + 1
    a1.Items[a1.Tail] = a2
    a1.Times[a1.Tail] = a3
    a1.Bytes = a1.Bytes + buffer.len(a2)
end

local function peek(a1) -- Line: 40 -- types: a1: table
    return a1.Items[a1.Head]
end

local function pop(a1) -- Line: 44 -- types: a1: table
    local v1 = a1.Items[a1.Head]
    a1.Items[a1.Head] = nil
    a1.Times[a1.Head] = nil
    a1.Head = a1.Head + 1
    a1.Bytes = a1.Bytes - buffer.len(v1)
    if a1.Tail < a1.Head then
        a1.Head = 1
        a1.Tail = 0
    end
end

local u13 = {}
u13.__index = u13

function u13.new(a1, a2, a3) -- Line: 59 -- upvalues: newQueue (val), u13 (val) -- types: a2: function, a3: function
    return (setmetatable({
        SentBytes = 0,
        Elapsed = 0,
        BurstLeft = 0,
        Stopped = false,
        Config = a1,
        Send = a2,
        OnStop = a3,
        Stream = newQueue(),
        Init = newQueue(),
        StreamTokens = a1.StreamBytesPerSecond,
        InitTokens = a1.InitBytesPerSecond,
    }, u13))
end

function u13.Push(a1, a2, a3) -- Line: 80 -- upvalues: Observability (val) -- types: a1: table, a2: buffer, a3: boolean
    if a1.Stopped then
        return
    end
    if a3 then
        local Init = a1.Init
        local Elapsed = a1.Elapsed
        Init.Tail = Init.Tail + 1
        Init.Items[Init.Tail] = a2
        Init.Times[Init.Tail] = Elapsed
        Init.Bytes = Init.Bytes + buffer.len(a2)
        return
    end
    local Stream = a1.Stream
    local Elapsed_2 = a1.Elapsed
    Stream.Tail = Stream.Tail + 1
    Stream.Items[Stream.Tail] = a2
    Stream.Times[Stream.Tail] = Elapsed_2
    Stream.Bytes = Stream.Bytes + buffer.len(a2)
    if a1.Config.QueueDropBytes < a1.Stream.Bytes then
        a1:Stop(Observability.StopReason.Dropped)
    end
end

function u13.Burst(a1, a2) -- Line: 96 -- types: a1: table, a2: number
    a1.BurstLeft = a2
end

function u13:_drain(a2, a3, a4, a5) -- Line: 101
    -- upvalues: Observability (val)
    local v1, v2, v3
    local v4 = math.min(a3 + a4 * a5, a4)
    local v5, v6, v7 = a2, a4, self
    while true do
        v1 = v5.Items[v5.Head]
        if not v1 then
            break
        end
        v2 = buffer.len(v1)
        if v4 < math.min(v2, v6) then
            break
        end
        if v7.Config.SessionCapBytes < v7.SentBytes + v2 then
            v7:Stop(Observability.StopReason.Capped)
            return v4
        end
        v3 = v5.Items[v5.Head]
        v5.Items[v5.Head] = nil
        v5.Times[v5.Head] = nil
        v5.Head = v5.Head + 1
        v5.Bytes = v5.Bytes - buffer.len(v3)
        if v5.Tail < v5.Head then
            v5.Head = 1
            v5.Tail = 0
        end
        v4 = v4 - v2
        v7.SentBytes = v7.SentBytes + v2
        v7.Send(v1)
    end
    return v4
end

function u13.Step(a1, a2) -- Line: 125 -- upvalues: Observability (val) -- types: a1: table, a2: number
    if a1.Stopped then
        return
    end
    a1.Elapsed = a1.Elapsed + a2
    a1.InitTokens = a1:_drain(a1.Init, a1.InitTokens, a1.Config.InitBytesPerSecond, a2)
    if a1.Stopped then
        return
    end
    local Stream = a1.Stream
    local Init_2 = a1.Init
    if Init_2.Items[Init_2.Head] then
        local Head = Stream.Head
        local Tail = Stream.Tail
        for i = Head, Tail do
            Stream.Times[i] = a1.Elapsed
        end
        return
    end
    local StreamBytesPerSecond = a1.Config.StreamBytesPerSecond
    if 0 < a1.BurstLeft then
        a1.BurstLeft = a1.BurstLeft - a2
        StreamBytesPerSecond = a1.Config.BurstBytesPerSecond
    end
    a1.StreamTokens = a1:_drain(Stream, a1.StreamTokens, StreamBytesPerSecond, a2)
    if a1.Stopped then
        return
    end
    local v1 = Stream.Times[Stream.Head]
    if v1 and a1.Config.QueueMaxLagSeconds < a1.Elapsed - v1 then
        a1:Stop(Observability.StopReason.Dropped)
    end
end

function u13:Stop(a2) -- Line: 158 -- upvalues: newQueue (val) -- types: self: table, a2: string
    if self.Stopped then
        return
    end
    self.Stopped = true
    self.Stream = newQueue()
    self.Init = newQueue()
    self.OnStop(a2)
end

return u13